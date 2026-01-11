<#   
.SYNOPSIS   
    Interactive program that allows a user to discover paths longer the 260 characters long. This will case issues with windows.
.DESCRIPTION 
    Presents an interactive menu for user to first specify a base path to examine.  The script then creates temp files in c:\temp.  
    The scripts examines the base direcotry for items exceding the target of 260. The script finally create a report and opens it in notepad.    
.NOTES   
    Name: win_path_length
    Author: Straytripod
    Modifier: Straytripod
    DateCreated: 9SEPT2021
    DateModifed: 9/9/2021
#> 

Write-Host ""
write-host "This program will examine path and find ones greater then 260 characters long."
write-host ""  
$exampath = Read-Host "Enter the base path to examine (\\fileserver\Data\...)"\
$raw = "c:\temp\thelist.txt"
$results = "c:\temp\results.txt"
Write-output "" > $raw
Write-output "Examination base path:  $exampath" > $results
Write-output "" >> $results
Write-host "Beginning search. Please wait."
cmd /c dir "$exampath" /s /b /a |? {$_.length -gt 260}|Out-File $raw -width 300 
$count = cat $raw
foreach ($i in $count) {$a=$i | Measure-Object -Character ; write-output $i "-------------" $a.Characters Characters >> $results; write-output "" >> $results} 
write-output "" >> $results
$items = $count.count
write-output "Total bad paths found: $items" >> $results
write-host "Total bad paths found: $items" >> $results
notepad $results
pause

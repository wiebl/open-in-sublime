(**
	Modification of https://github.com/pjv/open-in-sublime

**)

using terms from application "Path Finder"
	
	script theScript
		
		on run
			
			-- find out if path finder is installed
			set pathfinder_installed to true
			try
				tell application "Finder"
					set pathFinder to name of application file id "com.cocoatech.pathfinder"
				end tell
			on error
				set pathfinder_installed to false
			end try
			
			if pathfinder_installed then tell application "System Events"
				-- if anyone knows a better way to find out if the script was
				-- launched from path finder, this would be a good place to put it
				set pathFinder_running to (get name of processes) contains "Path Finder"
			end tell
			
			if name of me as string is "open folder in imageOptim" then
				set openFiles to false
			else
				set openFiles to true
			end if
			
			if pathfinder_installed and pathFinder_running then
				
				tell application pathFinder
					if openFiles then
						set finderSelection to {}
						set selectedItems to selection
						repeat with theItem in selectedItems
							copy (path of theItem as alias) to the end of finderSelection
						end repeat
					else
						set finderSelection to path of target of item 1 of finder windows
					end if
				end tell
			else
				tell application "Finder"
					if openFiles then
						if selection is {} then
							set finderSelection to folder of the front window as string
						else
							set finderSelection to selection as alias list
						end if
					else
						set finderSelection to folder of the front window as string
					end if
				end tell
			end if
			
			st2(finderSelection)
		end run
		
		-- script was drag-and-dropped onto
		on open (theList)
			io(theList)
		end open
		
		-- open in Sublime
		on io(listOfAliases)
			tell application "ImageOptim"
				open listOfAliases
				activate
			end tell
		end io
		
	end script
	
end using terms from

store script theScript in (path to home folder as string) & "Open Folder in ImageOptim.scpt"

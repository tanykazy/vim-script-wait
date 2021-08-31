let s:interval = 10 " Interval to check conditions (milliseconds)

" condition - condition function
" a:1 - timeout (milliseconds)
function wait#wait(condition, ...)
	let l:timeout = get(a:, 1, -1) / 1000.0
	let l:start = reltime()
	try
		while l:timeout < 0 || reltimefloat(reltime(l:start)) < l:timeout
			" Execute conditional function
			if call(a:condition, [])
				return 0
			endif
			if s:interval > 0
				" Interval to execute conditional function
				execute 'sleep' s:interval . 'm'
			endif
		endwhile
		return -1
	catch /^Vim:Interrupt$/
		return -2
	endtry
endfunction


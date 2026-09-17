return function(arg_1_0)
	arg_1_0._lock = false

	if arg_1_0:getState() == STATE_REVIVAL then
		arg_1_0:revivalByChunge()
	else
		arg_1_0._aniWait = false
	end
end

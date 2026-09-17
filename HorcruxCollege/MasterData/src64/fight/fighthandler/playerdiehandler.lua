return function(arg_1_0)
	arg_1_0._lock = false
	arg_1_0._replaydie = false

	if arg_1_0:getState() == STATE_REVIVAL then
		arg_1_0:revivalByChunge()
	else
		arg_1_0._hideondie = true

		arg_1_0:setVisible(false)

		if arg_1_0.charactertype == "enemy" then
			arg_1_0._aniWait = false
		end
	end
end

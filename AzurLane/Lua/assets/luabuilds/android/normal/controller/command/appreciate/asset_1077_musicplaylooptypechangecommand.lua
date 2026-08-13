class = var_0_10000

local var_0_0 = "MusicPlayLoopTypeChangeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().loopType

	getProxy = var_1_10004
	AppreciateProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2

	if var_1_0 == "list" then
		var_1_2 = 0
	elseif var_1_0 == "random" then
		var_1_2 = 1
	elseif var_1_0 == "one" then
		var_1_2 = 2
	else
		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17513, {
		music_no = var_1_1.mainMarkMusicId,
		music_mode = var_1_2
	}, 17514, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1

			var_2_2.setMusicPlayerLoopType(var_2_0, var_1_2)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.APPRECIATE_CHANGE_MUSIC_PLAY_LOOP_TYPE_DONE)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

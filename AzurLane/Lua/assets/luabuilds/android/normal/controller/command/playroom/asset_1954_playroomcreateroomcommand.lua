class = var_0_10000

local var_0_0 = "PlayRoomCreateRoomCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 23005, {
		type = var_1_1.type,
		game_type = var_1_1.gameType
	}, 23006, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayRoomProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			var_1.UpdateRoomData(var_2_10003, arg_2_0.room)

			var_2_10003 = var_1

			var_1.ClearInviteList(var_2_10003)

			var_2_10003 = var_1

			var_1.ClearInviteRecordList(var_2_10003)

			var_2_10003 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_4

			var_2_0(var_2_10003, var_4.PLAY_ROOM_CREATE_ROOM_DONE)
		elseif arg_2_0.result == 19 then
			PlayRoomTools = var_1

			var_1.ShowPunishementBox(arg_2_0.cd)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_2(var_2_1, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

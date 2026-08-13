class = var_0_10000

local var_0_0 = "PlayRoomJoinRoomCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 23007, {
		room_id = var_1_1.id
	}, 23008, function(arg_2_0)
		if arg_2_0.result == 0 then
			PlayRoomTools = var_1

			var_1.SetGameTypeID(var_1_1.gameType)

			getProxy = var_1
			PlayRoomProxy = var_2
			var_2_10003 = var_1(var_2)

			var_1.UpdateRoomData(var_2_10003, arg_2_0.room)

			var_2_10003 = var_1

			var_1.ClearInviteList(var_2_10003)

			var_2_10003 = var_1

			var_1.ClearInviteRecordList(var_2_10003)

			var_2_10003 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_4

			var_2_0(var_2_10003, var_4.PLAY_ROOM_JOIN_ROOM_DONE, {
				gameType = var_1_1.gameType
			})
		elseif var_1_1.id == 0 and arg_2_0.result == 20 then
			local var_2_1 = arg_1_0
			local var_2_2 = var_1.sendNotification

			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.PLAY_ROOM_JOIN_ROOM_QUICK_FAIL)
		elseif arg_2_0.result == 19 then
			PlayRoomTools = var_1

			var_1.ShowPunishementBox(arg_2_0.cd)
		else
			local var_2_4

			if arg_2_0.result == 6 then
				pg = var_2_4

				local var_2_3 = var_2_4.TipsMgr.GetInstance()

				var_2_4 = var_2_4.ShowTips
				i18n = var_2_10003

				var_2_4(var_2_3, var_2_10003("match_room_full2"))
			else
				pg = var_2_4

				local var_2_5 = var_2_4.TipsMgr.GetInstance()
				local var_2_6 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_6(var_2_5, var_2_10003("", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1

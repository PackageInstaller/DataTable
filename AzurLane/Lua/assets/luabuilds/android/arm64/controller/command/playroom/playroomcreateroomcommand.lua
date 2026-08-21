local var_0_0 = class("PlayRoomCreateRoomCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23005, {
		type = var_1_0.type,
		game_type = var_1_0.gameType
	}, 23006, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(PlayRoomProxy)

			var_2_0:UpdateRoomData(arg_2_0.room)
			var_2_0:ClearInviteList()
			var_2_0:ClearInviteRecordList()
			arg_1_0:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM_DONE)
		elseif arg_2_0.result == 19 then
			PlayRoomTools.ShowPunishementBox(arg_2_0.cd)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0

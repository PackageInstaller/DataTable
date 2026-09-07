local PlayRoomJoinRoomCommand = class("PlayRoomJoinRoomCommand", pm.SimpleCommand)

function PlayRoomJoinRoomCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23007, {
		room_id = var_1_0.id
	}, 23008, function(arg_2_0)
		if arg_2_0.result == 0 then
			PlayRoomTools.SetGameTypeID(var_1_0.gameType)

			local var_2_0 = getProxy(PlayRoomProxy)

			var_2_0:UpdateRoomData(arg_2_0.room)
			var_2_0:ClearInviteList()
			var_2_0:ClearInviteRecordList()
			self:sendNotification(GAME.PLAY_ROOM_JOIN_ROOM_DONE, {
				gameType = var_1_0.gameType
			})
		elseif var_1_0.id == 0 and arg_2_0.result == 20 then
			self:sendNotification(GAME.PLAY_ROOM_JOIN_ROOM_QUICK_FAIL)
		elseif arg_2_0.result == 19 then
			PlayRoomTools.ShowPunishementBox(arg_2_0.cd)
		elseif arg_2_0.result == 6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("match_room_full2"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return PlayRoomJoinRoomCommand

local PlayRoomInviteCommand = class("PlayRoomInviteCommand", pm.SimpleCommand)

function PlayRoomInviteCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23021, {
		user_id = var_1_0.id
	}, 23022, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(PlayRoomProxy):AddInviteRecord(var_1_0.id)
			self:sendNotification(GAME.PLAY_ROOM_INVITE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return PlayRoomInviteCommand

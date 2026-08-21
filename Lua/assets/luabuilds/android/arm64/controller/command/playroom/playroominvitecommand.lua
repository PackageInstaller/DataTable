local var_0_0 = class("PlayRoomInviteCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23021, {
		user_id = arg_1_1:getBody().id
	}, 23022, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(PlayRoomProxy):AddInviteRecord(var_0.id)
			arg_1_0:sendNotification(GAME.PLAY_ROOM_INVITE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return var_0_0

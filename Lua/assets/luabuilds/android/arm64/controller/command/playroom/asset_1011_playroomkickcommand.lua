local PlayRoomKickCommand = class("PlayRoomKickCommand", pm.SimpleCommand)

function PlayRoomKickCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23013, {
		user_id = arg_1_1:getBody().id
	}, 23014, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.PLAY_ROOM_KICK_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return PlayRoomKickCommand

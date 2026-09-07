local PlayRoomReadyCommand = class("PlayRoomReadyCommand", pm.SimpleCommand)

function PlayRoomReadyCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23015, {
		arg = arg_1_1:getBody().arg
	}, 23016, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.PLAY_ROOM_READY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return PlayRoomReadyCommand

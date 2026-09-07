local PlayRoomStartGameCommand = class("PlayRoomStartGameCommand", pm.SimpleCommand)

function PlayRoomStartGameCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23017, {
		arg = 1
	}, 23018, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.PLAY_ROOM_START_GAME_DONE)

			if getProxy(PlayRoomProxy):GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
				getProxy(PlayRoomProxy):SetStartMatch(true)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return PlayRoomStartGameCommand

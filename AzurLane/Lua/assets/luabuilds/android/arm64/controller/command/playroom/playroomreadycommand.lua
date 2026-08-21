local var_0_0 = class("PlayRoomReadyCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23015, {
		arg = arg_1_1:getBody().arg
	}, 23016, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.PLAY_ROOM_READY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return var_0_0

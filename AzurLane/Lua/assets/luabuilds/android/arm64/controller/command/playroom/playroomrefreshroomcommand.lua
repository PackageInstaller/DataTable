local var_0_0 = class("PlayRoomRefreshRoomCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23001, {
		arg = 1
	}, 23002, function(arg_2_0)
		getProxy(PlayRoomProxy):UpdateRoomList(arg_2_0.room_list)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM_DONE)

		return
	end, false)

	return
end

return var_0_0

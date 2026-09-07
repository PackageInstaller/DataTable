local PlayRoomRefreshRoomCommand = class("PlayRoomRefreshRoomCommand", pm.SimpleCommand)

function PlayRoomRefreshRoomCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23001, {
		arg = 1
	}, 23002, function(arg_2_0)
		getProxy(PlayRoomProxy):UpdateRoomList(arg_2_0.room_list)
		self:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM_DONE)

		return
	end, false)

	return
end

return PlayRoomRefreshRoomCommand

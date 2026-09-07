local PlayRoomRefreshRoomInfoCommand = class("PlayRoomRefreshRoomInfoCommand", pm.SimpleCommand)

function PlayRoomRefreshRoomInfoCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23003, {
		arg = 1
	}, 23004, function(arg_2_0)
		if arg_2_0.room.id ~= 0 then
			getProxy(PlayRoomProxy):UpdateRoomData(arg_2_0.room)
			self:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM_INFO_DONE)
		end

		return
	end, false)

	return
end

return PlayRoomRefreshRoomInfoCommand

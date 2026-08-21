local var_0_0 = class("PlayRoomExitRoomCommand", pm.SimpleCommand)

var_0_0.PLAY_ROOM_EXIT_ROOM_DONE = "PlayRoomExitRoomCommand:PLAY_ROOM_EXIT_ROOM_DONE"

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(IslandProxy):GetIsland()

	pg.ConnectionMgr.GetInstance():Send(23011, {
		arg = 1
	}, 23012, function(arg_2_0)
		local var_2_0 = getProxy(PlayRoomProxy)

		var_2_0:ExitRoom()
		var_2_0:SetMatchCD(arg_2_0.time)
		existCall(arg_1_1:getBody().callback)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM_DONE)

		if var_1_0 then
			var_1_0:DispatchEvent(var_0_0.PLAY_ROOM_EXIT_ROOM_DONE)
		end

		return
	end)

	return
end

return var_0_0

class = var_0_10000

local var_0_0 = "PlayRoomRefreshRoomInfoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 23003, {
		arg = 1
	}, 23004, function(arg_2_0)
		if arg_2_0.room.id ~= 0 then
			getProxy = var_1
			PlayRoomProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.UpdateRoomData(var_2_0, arg_2_0.room)

			local var_2_1 = arg_1_0
			local var_2_2 = var_1.sendNotification

			GAME = var_4

			var_2_2(var_2_1, var_4.PLAY_ROOM_REFRESH_ROOM_INFO_DONE)
		end

		return
	end, false)

	return
end

return var_0_1

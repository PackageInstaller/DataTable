class = var_0_10000

local var_0_0 = "PlayRoomRefreshRoomCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 23001, {
		arg = 1
	}, 23002, function(arg_2_0)
		getProxy = var_2_10001
		PlayRoomProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.UpdateRoomList(var_2_0, arg_2_0.room_list)

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_4

		var_2_2(var_2_1, var_4.PLAY_ROOM_REFRESH_ROOM_DONE)

		return
	end, false)

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "PlayRoomExitRoomCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.PLAY_ROOM_EXIT_ROOM_DONE = "PlayRoomExitRoomCommand:PLAY_ROOM_EXIT_ROOM_DONE"

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.GetIsland(var_1_0)

	pg = var_1_10003

	local var_1_2 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 23011, {
		arg = 1
	}, 23012, function(arg_2_0)
		getProxy = var_2_10001
		PlayRoomProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.ExitRoom(var_2_0)
		var_1:SetMatchCD(arg_2_0.time)

		existCall = var_2

		local var_2_1 = arg_1_1

		var_2(var_4.getBody(var_2_1).callback)

		local var_2_2 = arg_1_0
		local var_2_3 = var_2.sendNotification

		GAME = var_5

		var_2_3(var_2_2, var_5.PLAY_ROOM_EXIT_ROOM_DONE)

		if var_1_1 then
			local var_2_4 = var_1_1

			var_2.DispatchEvent(var_2_4, var_0_1.PLAY_ROOM_EXIT_ROOM_DONE)
		end

		return
	end)

	return
end

return var_0_1

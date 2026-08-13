class = var_0_10000

local var_0_0 = var_0_10000("IslandHearBeatMgr")

var_0_0.SERVER_HEART_BEAT_INTERVAL = 10

function var_0_0.Ctor(arg_1_0)
	Timer = var_1_10001

	local var_1_0 = var_1_10001.New

	local function var_1_1()
		local var_2_0 = arg_1_0

		var_0.SendHeartBeat(var_2_0)

		return
	end

	IslandConst = var_1_10003
	arg_1_0.heartBeatTimer = var_1_0(var_1_1, var_1_10003.HEART_BEAT_INTERVAL, -1)
	arg_1_0.islandId = nil
	arg_1_0.lastHeartBeatTime = 0

	return
end

function var_0_0.SendHeartBeat(arg_3_0)
	if not arg_3_0.islandId then
		return
	end

	os = var_1

	local var_3_0 = var_1.time()

	if arg_3_0.lastHeartBeatTime ~= 0 and var_3_0 - arg_3_0.lastHeartBeatTime > var_0_0.SERVER_HEART_BEAT_INTERVAL then
		warning = var_2

		var_2("心跳时间间隔异常", arg_3_0.lastHeartBeatTime, var_3_0)
	end

	arg_3_0.lastHeartBeatTime = var_3_0
	pg = var_2

	local var_3_1 = var_2.ConnectionMgr.GetInstance()

	var_2.Send(var_3_1, 21215, {
		island_id = arg_3_0.islandId
	})

	return
end

function var_0_0.EnterIsland(arg_4_0, arg_4_1)
	arg_4_0.islandId = arg_4_1

	local var_4_0 = arg_4_0.heartBeatTimer

	var_2.Stop(var_4_0)

	local var_4_1 = arg_4_0.heartBeatTimer

	var_2.Start(var_4_1)
	arg_4_0:SendHeartBeat()

	return
end

function var_0_0.ExitIsland(arg_5_0)
	local var_5_0 = arg_5_0.heartBeatTimer

	var_1.Stop(var_5_0)

	arg_5_0.islandId = nil

	return
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.heartBeatTimer then
		local var_6_0 = arg_6_0.heartBeatTimer

		var_1.Stop(var_6_0)

		arg_6_0.heartBeatTimer = nil
	end

	return
end

return var_0_0

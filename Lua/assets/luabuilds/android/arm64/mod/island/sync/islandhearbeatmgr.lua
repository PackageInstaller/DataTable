local var_0_0 = class("IslandHearBeatMgr")

var_0_0.SERVER_HEART_BEAT_INTERVAL = 10

function var_0_0.Ctor(arg_1_0)
	arg_1_0.heartBeatTimer = Timer.New(function()
		arg_1_0:SendHeartBeat()

		return
	end, IslandConst.HEART_BEAT_INTERVAL, -1)
	arg_1_0.islandId = nil
	arg_1_0.lastHeartBeatTime = 0

	return
end

function var_0_0.SendHeartBeat(arg_3_0)
	if not arg_3_0.islandId then
		return
	end

	local var_3_0 = os.time()

	if arg_3_0.lastHeartBeatTime ~= 0 and var_3_0 - arg_3_0.lastHeartBeatTime > var_0_0.SERVER_HEART_BEAT_INTERVAL then
		warning("心跳时间间隔异常", arg_3_0.lastHeartBeatTime, var_3_0)
	end

	arg_3_0.lastHeartBeatTime = var_3_0

	pg.ConnectionMgr.GetInstance():Send(21215, {
		island_id = arg_3_0.islandId
	})

	return
end

function var_0_0.EnterIsland(arg_4_0, arg_4_1)
	arg_4_0.islandId = arg_4_1

	arg_4_0.heartBeatTimer:Stop()
	arg_4_0.heartBeatTimer:Start()
	arg_4_0:SendHeartBeat()

	return
end

function var_0_0.ExitIsland(arg_5_0)
	arg_5_0.heartBeatTimer:Stop()

	arg_5_0.islandId = nil

	return
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.heartBeatTimer then
		arg_6_0.heartBeatTimer:Stop()

		arg_6_0.heartBeatTimer = nil
	end

	return
end

return var_0_0

local IslandHearBeatMgr = class("IslandHearBeatMgr")

IslandHearBeatMgr.SERVER_HEART_BEAT_INTERVAL = 10

function IslandHearBeatMgr:Ctor()
	self.heartBeatTimer = Timer.New(function()
		self:SendHeartBeat()

		return
	end, IslandConst.HEART_BEAT_INTERVAL, -1)
	self.islandId = nil
	self.lastHeartBeatTime = 0

	return
end

function IslandHearBeatMgr:SendHeartBeat()
	if not self.islandId then
		return
	end

	local var_3_0 = os.time()

	if self.lastHeartBeatTime ~= 0 and var_3_0 - self.lastHeartBeatTime > IslandHearBeatMgr.SERVER_HEART_BEAT_INTERVAL then
		warning("心跳时间间隔异常", self.lastHeartBeatTime, var_3_0)
	end

	self.lastHeartBeatTime = var_3_0

	pg.ConnectionMgr.GetInstance():Send(21215, {
		island_id = self.islandId
	})

	return
end

function IslandHearBeatMgr:EnterIsland(arg_4_1)
	self.islandId = arg_4_1

	self.heartBeatTimer:Stop()
	self.heartBeatTimer:Start()
	self:SendHeartBeat()

	return
end

function IslandHearBeatMgr:ExitIsland()
	self.heartBeatTimer:Stop()

	self.islandId = nil

	return
end

function IslandHearBeatMgr:Dispose()
	if self.heartBeatTimer then
		self.heartBeatTimer:Stop()

		self.heartBeatTimer = nil
	end

	return
end

return IslandHearBeatMgr

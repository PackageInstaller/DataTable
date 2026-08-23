local ServiceManager = class("ServiceManager")

function ServiceManager:ctor()
	self._services = {}
end

function ServiceManager:reset()
	for iter_2_0 = #self._services, 1, -1 do
		if type(self._services[iter_2_0].instance.reset) == "function" then
			self._services[iter_2_0].instance:reset()
		end
	end
end

function ServiceManager:clearService()
	for iter_3_0 = #self._services, 1, -1 do
		self._services[iter_3_0].instance = nil
	end

	self._services = {}
end

function ServiceManager:launch()
	for iter_4_0, iter_4_1 in ipairs({
		"LaunchService",
		"SuperSdkService",
		"GuideService",
		"GameRuntimeService",
		"BattleService",
		"ServerTimeSyncService",
		"RebelService",
		"StoryService",
		"ShowService",
		"AutoRecoverService",
		"ScheduleService",
		"CrossDayService",
		"BroadcastService",
		"BattleResultService",
		"ShowFeedBackService",
		"ShowPopService",
		"RedPointService",
		"LuaGcService",
		"BioTeamInviteFloatService",
		"CustomActivityService",
		"TipGuideService",
		"CheckRechargeService",
		"SnapShotCacheService",
		"NewSlgService",
		"LoopService"
	}) do
		self:_launchService(iter_4_1)
	end
end

function ServiceManager:_launchService(arg_5_1)
	table.insert(self._services, {
		name = arg_5_1,
		instance = require("app.core.service." .. arg_5_1).new()
	})
end

function ServiceManager:getServiceByName(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self._services) do
		if iter_6_1.name == arg_6_1 then
			return iter_6_1.instance
		end
	end

	return nil
end

return ServiceManager

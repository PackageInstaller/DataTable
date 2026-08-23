local CustomActivityService = class("CustomActivityService")
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.const.ConstMgr.ActivityConst
local var_0_3 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

function CustomActivityService:ctor()
	self._hideActivityDataMap = {}
	self._activityDataMap = {}
	self._activityStateInfoMap = {}
	self._runningSchedule = false
	self._scheduleHandler = nil

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO, self._onRcvActivityInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER, self._onModuleEnter, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO, self._onActivityUpdateInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_REQINFO, self._onActivityReqInfo, self)
end

function CustomActivityService:reset()
	self._hideActivityDataMap = {}
	self._activityDataMap = {}
	self._activityStateInfoMap = {}
	self._runningSchedule = false

	if self._scheduleHandler then
		g.core.common.Scheduler:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

function CustomActivityService:_updateActivityInfo()
	self._hideActivityDataMap = g.core.model.User.activityDataManager:getHideCustomActivityDataMap()
	self._activityDataMap = {}

	local var_3_0 = var_0_1:getTime()

	for iter_3_0, iter_3_1 in pairs((g.core.model.User.activityDataManager:getCustomActivityDataMap())) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_3:isDuringDisplay(var_3_0) then
				self._activityDataMap[iter_3_2] = iter_3_3
			end
		end
	end
end

function CustomActivityService:_onRcvActivityInfo()
	self:_updateActivityInfo()

	local var_4_0 = g.core.model.User:getLevel()
	local var_4_1 = g.core.common.ServerTime:getTime()
	local var_4_2 = {
		[var_0_3.TROOP] = {},
		[var_0_3.GOLD_RECRUIT] = {},
		[var_0_3.PHANTOM] = {},
		[var_0_3.RICH] = {},
		[var_0_3.SPACE_TIME_RECRUIT] = {}
	}

	for iter_4_0, iter_4_1 in pairs((g.core.model.User.activityDataManager:getCustomActivityDataMap())) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			local var_4_3 = iter_4_3:getInfo()

			if var_4_1 >= iter_4_3:getStartTime() and var_4_1 < iter_4_3:getExpireTime() and var_4_0 >= var_4_3.min_level then
				local var_4_4 = iter_4_3:getActivityType()
				local var_4_5 = var_4_3.sub_activity_id or 0

				if var_4_4 == var_0_3.TROOP then
					if var_4_5 ~= 0 then
						table.insert(var_4_2[var_0_3.TROOP], iter_4_3)
					end
				elseif var_4_4 == var_0_3.GOLD_RECRUIT then
					if var_4_5 ~= 0 then
						table.insert(var_4_2[var_0_3.GOLD_RECRUIT], iter_4_3)
					end
				elseif var_4_4 == var_0_3.PHANTOM then
					if var_4_5 ~= 0 then
						table.insert(var_4_2[var_0_3.PHANTOM], iter_4_3)
					end
				elseif var_4_4 == var_0_3.RICH then
					if var_4_5 ~= 0 then
						table.insert(var_4_2[var_0_3.RICH], iter_4_3)
					end
				elseif var_4_4 == var_0_3.SPACE_TIME_RECRUIT and var_4_5 ~= 0 then
					table.insert(var_4_2[var_0_3.SPACE_TIME_RECRUIT], iter_4_3)
				end
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_4_2) do
		if next(iter_4_5) then
			if #iter_4_5 > 1 then
				table.sort(iter_4_5, function(arg_5_0, arg_5_1)
					return arg_5_0.id > arg_5_1.id
				end)
			end

			local var_4_6 = iter_4_5[1]
			local var_4_7 = iter_4_5[1]:getActivityType()
			local var_4_8 = iter_4_5[1]:getActivityId()

			if var_4_7 == var_0_3.TROOP then
				g.core.model.User.troopData:setCustomTroop(var_4_6)
				g.core.network.GameNetProxy:send_C2S_GoldEquip_GetInfo({
					activity_id = var_4_8
				})
				g.core.network.GameNetProxy:send_C2S_Activity_Common_Task_Get({
					activity_type = var_4_7,
					activity_id = var_4_8
				})
			elseif var_4_7 == var_0_3.GOLD_RECRUIT then
				g.core.model.User.goldRecruitData:setCustomTroop(var_4_6)
				g.core.network.GameNetProxy:send_C2S_Recruit_GetRecruitKnightInfo({
					activity_id = var_4_8
				})

				if var_4_6:isDuringOpening(var_4_1) then
					g.core.network.GameNetProxy:send_C2S_Activity_Common_Task_Get({
						activity_type = var_4_7,
						activity_id = var_4_8
					})
				end
			elseif var_4_7 == var_0_3.SPACE_TIME_RECRUIT then
				g.core.model.User.spaceTimeRecruitData:setCustomTroop(var_4_6)
				g.core.network.GameNetProxy:send_C2S_Recruit_GetRecruitAuKnightInfo({
					activity_id = var_4_8
				})

				if var_4_6:isDuringOpening(var_4_1) then
					g.core.network.GameNetProxy:send_C2S_Activity_Common_Task_Get({
						activity_type = var_4_7,
						activity_id = var_4_8
					})
				end
			elseif var_4_7 == var_0_3.PHANTOM then
				g.core.model.User.phantomData:setCustomTroop(var_4_6)

				if var_4_6:isDuringOpening((g.core.common.ServerTime:getTime())) then
					g.core.network.GameNetProxy:send_C2S_Activity_Common_Task_Get({
						activity_type = var_4_7,
						activity_id = var_4_8
					})
				end
			elseif var_4_7 == var_0_3.RICH then
				g.core.model.User.richData:setCustomTroop(var_4_6)

				if var_4_6:isDuringOpening(var_4_1) then
					g.core.network.GameNetProxy:send_C2S_Richest_GetInfo({
						activity_id = var_4_8
					})
					g.core.network.GameNetProxy:send_C2S_ActivityCommon_EventList({
						activity_type = var_4_7,
						activity_id = var_4_8
					})
					g.core.network.GameNetProxy:send_C2S_Activity_Common_Task_Get({
						activity_type = var_4_7,
						activity_id = var_4_8
					})
				end
			end
		end
	end

	if not self._runningSchedule then
		self._runningSchedule = true
		self._scheduleHandler = g.core.common.Scheduler:newSchedule(handler(self, self._onSchedulerUpdate), 1)
	end
end

function CustomActivityService:_onModuleEnter()
	self:_onSchedulerUpdate(1, 0)
end

function CustomActivityService:_onActivityUpdateInfo()
	self:_updateActivityInfo()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CUSTOM_ACTIVITY_UPDATE_INFO, false)
end

function CustomActivityService:_onActivityReqInfo()
	self:_updateActivityInfo()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CUSTOM_ACTIVITY_START_PREVIEW, false)
end

function CustomActivityService:_onSchedulerUpdate(arg_9_1, arg_9_2)
	if not next(self._activityDataMap) and not next(self._hideActivityDataMap) then
		return
	end

	local var_9_0 = var_0_1:getTime()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(self._hideActivityDataMap) do
		if iter_9_1:isDuringDisplay(var_9_0) then
			table.insert(var_9_1, iter_9_1:getActivityId())
		end
	end

	if #var_9_1 > 0 and not g.core.guide.GuideProxy:isGuideRunning() then
		g.core.network.GameNetProxy:send_C2S_CustomActivity_ReqInfo({
			ids = var_9_1
		})
	end

	for iter_9_2, iter_9_3 in pairs(self._activityDataMap) do
		local var_9_2 = iter_9_3:getActivityState()

		if not iter_9_3:isDuringDisplay(var_9_0) then
			self._activityDataMap[iter_9_2] = nil
		end

		if var_9_2 == var_0_2.ACTIVITY_STATE.EXPIRE then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CUSTOM_ACTIVITY_EXPIRE, false, {
				activityType = iter_9_3:getActivityType(),
				activityValue = iter_9_2
			})
		end

		local var_9_3 = self._activityStateInfoMap[iter_9_2]

		self._activityStateInfoMap[iter_9_2] = var_9_2

		if var_9_3 and var_9_3 == var_0_2.ACTIVITY_STATE.BEFORE_PREVIEW and iter_9_3:isDuringDisplay(var_9_0) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CUSTOM_ACTIVITY_START_PREVIEW, false)
		end
	end
end

return CustomActivityService

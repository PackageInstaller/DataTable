local var_0_0 = g.core.config.succuba_launch_task_info
local var_0_1 = g.core.config.succuba_launch_info
local var_0_2 = g.core.model.User.shopData
local var_0_3 = g.core.const.ConstMgr.ShopConst
local SuccubaLaunchLayer = class("SuccubaLaunchLayer")

function SuccubaLaunchLayer:ctor()
	self._activityCfg = nil
	self._taskMaps = {}
	self._taskInfo = {}
	self._taskValues = {}
	self._taskRewardIds = {}
	self._activity = {}
end

function SuccubaLaunchLayer:onS2CRedPoint(arg_2_1)
	self:updateActivityInfo(arg_2_1)
end

function SuccubaLaunchLayer:onActivityOpen(arg_3_1)
	self._activityCfg = arg_3_1.data
end

function SuccubaLaunchLayer:onTaskRefresh(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.tasks or {}) do
		self._taskValues[iter_4_1.key] = iter_4_1.value
	end
end

function SuccubaLaunchLayer:updateActivityInfo(arg_5_1)
	if not arg_5_1.activity then
		return
	end

	self._taskValues = {}
	self._taskRewardIds = {}

	self:updateActivity(arg_5_1.activity)

	local var_5_0 = not self._activityCfg

	self._activityCfg = var_0_1.get(self._activity.sub_id)

	if var_5_0 then
		self:updateTaskCfg()
	end

	self:updateTask(arg_5_1.task)
end

function SuccubaLaunchLayer:getActivityId()
	return (self._activity or nil) and (self._activity.sub_id or 0)
end

function SuccubaLaunchLayer:getActivityShopType()
	return (self._activityCfg or nil) and (self._activityCfg.gift or 0)
end

function SuccubaLaunchLayer:onActivityTaskFinish(arg_8_1)
	if arg_8_1.task_ids then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1.task_ids) do
			self._taskRewardIds[iter_8_1] = true
		end
	end
end

function SuccubaLaunchLayer:updateTask(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.tasks or {}) do
		self._taskValues[iter_9_1.key] = iter_9_1.value
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_1.award_ids or {}) do
		self._taskRewardIds[iter_9_3] = true
	end
end

function SuccubaLaunchLayer:isActOpen(arg_10_1)
	arg_10_1 = arg_10_1 or self._activity.sub_id

	if self._activity.sub_id ~= arg_10_1 then
		return false
	end

	return tonumber((self._activity or nil) and (self._activity.end_time or 0)) >= g.core.common.ServerTime:getTime()
end

function SuccubaLaunchLayer:updateActivity(arg_11_1)
	self._activity = arg_11_1
end

function SuccubaLaunchLayer:getActivityEndTime(arg_12_1)
	if arg_12_1 then
		if self._activity.sub_id == arg_12_1 then
			return self._activity.end_time
		end

		return 0
	end

	return self._activity.end_time or 0
end

function SuccubaLaunchLayer:updateTaskCfg()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in var_0_0.ipairs() do
		if iter_13_1.task_group == self._activityCfg.task_group then
			var_13_0[iter_13_1.action_type] = var_13_0[iter_13_1.action_type] or {}
			var_13_0[iter_13_1.action_type].order = var_13_0[iter_13_1.action_type].order or iter_13_1.order

			table.insert(var_13_0[iter_13_1.action_type], iter_13_1)
		end
	end

	local var_13_1 = {}

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		table.sort(iter_13_3, function(arg_14_0, arg_14_1)
			if arg_14_0.goal ~= arg_14_1.goal then
				return arg_14_0.goal < arg_14_1.goal
			end

			return arg_14_0.id < arg_14_1.id
		end)
		table.insert(var_13_1, {
			taskList = iter_13_3,
			order = iter_13_3.order
		})
	end

	table.sort(var_13_1, function(arg_15_0, arg_15_1)
		return arg_15_0.order < arg_15_1.order
	end)

	self._taskMaps = var_13_1
end

function SuccubaLaunchLayer:getAllShowTasks()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self._taskMaps) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1.taskList) do
			if not self._taskRewardIds[iter_16_3.id] or iter_16_2 == #iter_16_1.taskList then
				local var_16_1 = {
					cfg = iter_16_3
				}

				var_16_1.taskValue = self._taskValues[iter_16_3.id] or 0
				var_16_1.isGet = self._taskRewardIds[iter_16_3.id]
				var_16_1.sort = var_16_1.isGet and 0 or var_16_1.taskValue >= iter_16_3.goal and 3 or 2

				table.insert(var_16_0, var_16_1)

				break
			end
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		if arg_17_0.sort ~= arg_17_1.sort then
			return arg_17_0.sort > arg_17_1.sort
		end

		return arg_17_0.cfg.id < arg_17_1.cfg.id
	end)

	return var_16_0
end

function SuccubaLaunchLayer:getTaskCanRewardIds()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs((self:getAllShowTasks())) do
		if not iter_18_1.isGet and iter_18_1.taskValue >= iter_18_1.cfg.goal then
			table.insert(var_18_0, iter_18_1.cfg.id)
		end
	end

	return var_18_0
end

function SuccubaLaunchLayer:hasTaskReward()
	for iter_19_0, iter_19_1 in ipairs((self:getAllShowTasks())) do
		if not iter_19_1.isGet and iter_19_1.taskValue >= iter_19_1.cfg.goal then
			return true
		end
	end

	return false
end

function SuccubaLaunchLayer:checkSuccubaLaunchShow()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA_LAUNCH) and not next(self._activity) then
		g.core.network.GameNetProxy:send_C2S_Succuba_Activity_GetInfo({})
	end
end

function SuccubaLaunchLayer:canBuyItem()
	for iter_21_0 = 1, 20 do
		local var_21_0 = var_0_2:getInfo(var_0_3.SHOP_TYPE.SUCCUBA_LAUNCH, iter_21_0, true)

		if #var_21_0 == 0 then
			break
		elseif not var_0_2:checkBuyBan(var_21_0[1]) then
			for iter_21_1, iter_21_2 in ipairs(var_21_0) do
				if var_0_2:getBuyLimitLeft(iter_21_2) > 0 and var_0_2:getBuyItemPrice(iter_21_2, 1) <= g.core.model.User.bagData:getOwnNum(iter_21_2.price_type_1, iter_21_2.price_value_1) then
					return true
				end
			end
		end
	end

	return false
end

return SuccubaLaunchLayer

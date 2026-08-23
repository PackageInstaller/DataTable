local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.config.quest_anniversary_info
local AnniversaryTaskData = class("AnniversaryTaskData")

function AnniversaryTaskData:ctor()
	self._activityId = 1
	self._actions = {}
	self._awardTaskIds = {}

	self:initTaskData()
end

function AnniversaryTaskData:updateTaskDataByActivityId(arg_2_1)
	self._activityId = arg_2_1 or 1

	self:initTaskData()
end

function AnniversaryTaskData:initTaskData()
	self._taskArray = {}
	self._taskTypeDict = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		if self._activityId == iter_3_1.activity_id then
			table.insert(self._taskArray, iter_3_1)

			self._taskTypeDict[iter_3_1.reset_type] = self._taskTypeDict[iter_3_1.reset_type] or {}

			table.insert(self._taskTypeDict[iter_3_1.reset_type], iter_3_1)
		end
	end
end

function AnniversaryTaskData:getTaskAwardByCfg(arg_4_1)
	local var_4_0 = {}

	while var_0_1.hasKey("reward_type_" .. 1) do
		if arg_4_1["reward_type_" .. 1] > 0 then
			table.insert(var_4_0, {
				type = arg_4_1["reward_type_" .. 1],
				value = arg_4_1["reward_value_" .. 1],
				size = arg_4_1["reward_size_" .. 1]
			})
		end
	end

	return var_4_0
end

function AnniversaryTaskData:updateTaskData(arg_5_1)
	self._actions = {}
	self._awardTaskIds = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1.actions or {}) do
			self._actions[iter_5_3.key .. "_" .. iter_5_3.type] = iter_5_3.value
		end

		for iter_5_4, iter_5_5 in ipairs(iter_5_1.award_task_ids or {}) do
			self._awardTaskIds[iter_5_5] = true
		end

		if iter_5_1.reset_type == var_0_0.TASK_TYPE.DAILY then
			self._lastResetTime = iter_5_1.last_reset_time
		end
	end

	if not g.core.common.ServerTime:isToday(self._lastResetTime) then
		self:resetDailyTaskProgress()
	end
end

function AnniversaryTaskData:onS2CActionStatusFlush(arg_6_1)
	self._actions[arg_6_1.status.key .. "_" .. arg_6_1.status.id] = arg_6_1.status.status
end

function AnniversaryTaskData:resetDailyTaskProgress()
	for iter_7_0, iter_7_1 in ipairs(self._taskTypeDict[var_0_0.TASK_TYPE.DAILY] or {}) do
		if self._actions[iter_7_1.action_key .. "_" .. iter_7_1.action_type] then
			self._actions[iter_7_1.action_key .. "_" .. iter_7_1.action_type] = 0
		end
	end
end

function AnniversaryTaskData:isTaskAwarded(arg_8_1)
	return self._awardTaskIds[arg_8_1]
end

function AnniversaryTaskData:getTaskValue(arg_9_1, arg_9_2)
	return self._actions[arg_9_1 .. "_" .. arg_9_2] or 0
end

function AnniversaryTaskData:onTaskAward(arg_10_1)
	self._awardTaskIds[arg_10_1] = true
end

function AnniversaryTaskData:getTaskState(arg_11_1)
	local var_11_0 = var_0_1.get(arg_11_1)
	local var_11_1 = var_0_0.TASK_STATE.NOT_FINISH

	if self._awardTaskIds[var_11_0.id] then
		var_11_1 = var_0_0.TASK_STATE.REWARD
	elseif (self._actions[var_11_0.action_key .. "_" .. var_11_0.action_type] or 0) >= var_11_0.goal then
		var_11_1 = var_0_0.TASK_STATE.FINISH
	end

	return var_11_1
end

function AnniversaryTaskData:getTaskList(arg_12_1)
	local var_12_0 = {
		[var_0_0.TASK_STATE.REWARD] = 3,
		[var_0_0.TASK_STATE.NOT_FINISH] = 2,
		[var_0_0.TASK_STATE.FINISH] = 1
	}
	local var_12_1 = {}
	local var_12_2 = self._taskArray

	if arg_12_1 and self._taskTypeDict[arg_12_1] then
		var_12_2 = self._taskTypeDict[arg_12_1]
	end

	for iter_12_0 = 1, #var_12_2 do
		if var_12_2[iter_12_0].function_id > 0 then
			if g.core.common.ModuleUnlock:isModuleUnlock(var_12_2[iter_12_0].function_id) then
				table.insert(var_12_1, var_12_2[iter_12_0])
			end
		else
			table.insert(var_12_1, var_12_2[iter_12_0])
		end
	end

	table.sort(var_12_1, function(arg_13_0, arg_13_1)
		local var_13_0 = self:getTaskState(arg_13_0.id)
		local var_13_1 = self:getTaskState(arg_13_1.id)

		if var_13_0 ~= var_13_1 then
			return var_12_0[var_13_0] < var_12_0[var_13_1]
		end

		return arg_13_0.sort < arg_13_1.sort
	end)

	return var_12_1
end

function AnniversaryTaskData:isCanRewardTask()
	for iter_14_0, iter_14_1 in ipairs(self._taskArray) do
		if self:getTaskState(iter_14_1.id) == var_0_0.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

function AnniversaryTaskData:getCanRewardTaskList(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self._taskArray) do
		if (not arg_15_1 or iter_15_1.reset_type == arg_15_1) and self:getTaskState(iter_15_1.id) == var_0_0.TASK_STATE.FINISH then
			table.insert(var_15_0, iter_15_1.id)
		end
	end

	return var_15_0
end

return AnniversaryTaskData

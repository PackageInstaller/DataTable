local var_0_0 = g.core.const.ConstMgr.BlazingArenaConst
local var_0_1 = g.core.config.blazing_arena_task_info
local BlazingArenaTaskData = class("BlazingArenaTaskData")

function BlazingArenaTaskData:ctor()
	self._actions = {}
	self._awardTaskIds = {}

	self:initTaskData()
end

function BlazingArenaTaskData:initTaskData()
	self._taskArray = {}
	self._taskTypeDict = {}

	for iter_2_0, iter_2_1 in var_0_1.ipairs() do
		table.insert(self._taskArray, iter_2_1)

		self._taskTypeDict[iter_2_1.reset] = self._taskTypeDict[iter_2_1.reset] or {}

		table.insert(self._taskTypeDict[iter_2_1.reset], iter_2_1)
	end
end

function BlazingArenaTaskData:getTaskAwardByCfg(arg_3_1)
	local var_3_0 = {}

	while var_0_1.hasKey("reward_type_" .. 1) do
		if arg_3_1["reward_type_" .. 1] > 0 then
			table.insert(var_3_0, {
				type = arg_3_1["reward_type_" .. 1],
				value = arg_3_1["reward_value_" .. 1],
				size = arg_3_1["reward_size_" .. 1]
			})
		end
	end

	return var_3_0
end

function BlazingArenaTaskData:updateTaskData(arg_4_1)
	self._resetType = arg_4_1.reset_type
	self._actions = {}
	self._awardTaskIds = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1.actions or {}) do
			self._actions[iter_4_3.key .. "_" .. iter_4_3.type] = iter_4_3.value
		end

		for iter_4_4, iter_4_5 in ipairs(iter_4_1.award_task_ids or {}) do
			self._awardTaskIds[iter_4_5] = true
		end

		self._lastResetTime = arg_4_1.last_reset_time
	end

	if not g.core.common.ServerTime:isToday(self._lastResetTime) then
		self:resetDailyTaskProgress()
	end
end

function BlazingArenaTaskData:onS2CActionStatusFlush(arg_5_1)
	self._actions[arg_5_1.status.key .. "_" .. arg_5_1.status.id] = arg_5_1.status.status
end

function BlazingArenaTaskData:resetDailyTaskProgress()
	for iter_6_0, iter_6_1 in ipairs(self._taskTypeDict[var_0_0.TASK_TYPE.DAILY] or {}) do
		if self._actions[iter_6_1.action_key .. "_" .. iter_6_1.action_type] then
			self._actions[iter_6_1.action_key .. "_" .. iter_6_1.action_type] = 0
		end
	end
end

function BlazingArenaTaskData:isTaskAwarded(arg_7_1)
	return self._awardTaskIds[arg_7_1]
end

function BlazingArenaTaskData:getTaskValue(arg_8_1, arg_8_2)
	return self._actions[arg_8_1 .. "_" .. arg_8_2] or 0
end

function BlazingArenaTaskData:onTaskAward(arg_9_1)
	self._awardTaskIds[arg_9_1] = true
end

function BlazingArenaTaskData:getTaskState(arg_10_1)
	local var_10_0 = var_0_1.get(arg_10_1)
	local var_10_1 = var_0_0.TASK_STATE.NOT_FINISH

	if self._awardTaskIds[var_10_0.id] then
		var_10_1 = var_0_0.TASK_STATE.REWARD
	elseif (self._actions[var_10_0.action_key .. "_" .. var_10_0.action_type] or 0) >= var_10_0.goal then
		var_10_1 = var_0_0.TASK_STATE.FINISH
	end

	return var_10_1
end

function BlazingArenaTaskData:getTaskList()
	local var_11_0 = {
		[var_0_0.TASK_STATE.REWARD] = 3,
		[var_0_0.TASK_STATE.NOT_FINISH] = 2,
		[var_0_0.TASK_STATE.FINISH] = 1
	}

	table.sort(self._taskArray, function(arg_12_0, arg_12_1)
		local var_12_0 = self:getTaskState(arg_12_0.id)
		local var_12_1 = self:getTaskState(arg_12_1.id)

		if var_12_0 ~= var_12_1 then
			return var_11_0[var_12_0] < var_11_0[var_12_1]
		end

		return arg_12_0.sort < arg_12_1.sort
	end)

	return self._taskArray
end

function BlazingArenaTaskData:isCanRewardTask()
	for iter_13_0, iter_13_1 in ipairs(self._taskArray) do
		if self:getTaskState(iter_13_1.id) == var_0_0.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

function BlazingArenaTaskData:getCanRewardTaskList()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self._taskArray) do
		if self:getTaskState(iter_14_1.id) == var_0_0.TASK_STATE.FINISH then
			table.insert(var_14_0, iter_14_1.id)
		end
	end

	return var_14_0
end

return BlazingArenaTaskData

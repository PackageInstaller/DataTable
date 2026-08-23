local var_0_0 = g.core.const.ConstMgr.PubgConst
local var_0_1 = g.core.config.pubg_task_info
local PubgTaskData = class("PubgTaskData")

function PubgTaskData:ctor()
	self._actions = {}
	self._awardTaskIds = {}

	self:initTaskData()
end

function PubgTaskData:initTaskData()
	self._taskArray = {}
	self._taskTypeDict = {}

	for iter_2_0, iter_2_1 in var_0_1.ipairs() do
		table.insert(self._taskArray, iter_2_1)

		self._taskTypeDict[iter_2_1.refresh] = self._taskTypeDict[iter_2_1.refresh] or {}

		table.insert(self._taskTypeDict[iter_2_1.refresh], iter_2_1)
	end
end

function PubgTaskData:getTaskAwardByCfg(arg_3_1)
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

function PubgTaskData:updateTaskData(arg_4_1)
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

function PubgTaskData:resetDailyTaskProgress()
	for iter_5_0, iter_5_1 in ipairs(self._taskTypeDict[var_0_0.TASK_TYPE.DAILY]) do
		if self._actions[iter_5_1.action_key .. "_" .. iter_5_1.action_type] then
			self._actions[iter_5_1.action_key .. "_" .. iter_5_1.action_type] = 0
		end
	end
end

function PubgTaskData:isTaskAwarded(arg_6_1)
	return self._awardTaskIds[arg_6_1]
end

function PubgTaskData:getTaskValue(arg_7_1, arg_7_2)
	return self._actions[arg_7_1 .. "_" .. arg_7_2] or 0
end

function PubgTaskData:onTaskAward(arg_8_1)
	self._awardTaskIds[arg_8_1] = true
end

function PubgTaskData:getTaskState(arg_9_1)
	local var_9_0 = var_0_1.get(arg_9_1)
	local var_9_1 = var_0_0.TASK_STATE.NOT_FINISH

	if self._awardTaskIds[var_9_0.id] then
		var_9_1 = var_0_0.TASK_STATE.REWARD
	elseif (self._actions[var_9_0.action_key .. "_" .. var_9_0.action_type] or 0) >= var_9_0.goal then
		var_9_1 = var_0_0.TASK_STATE.FINISH
	end

	return var_9_1
end

function PubgTaskData:getTaskList()
	local var_10_0 = {
		[var_0_0.TASK_STATE.REWARD] = 3,
		[var_0_0.TASK_STATE.NOT_FINISH] = 2,
		[var_0_0.TASK_STATE.FINISH] = 1
	}

	table.sort(self._taskArray, function(arg_11_0, arg_11_1)
		local var_11_0 = self:getTaskState(arg_11_0.id)
		local var_11_1 = self:getTaskState(arg_11_1.id)

		if var_11_0 ~= var_11_1 then
			return var_10_0[var_11_0] < var_10_0[var_11_1]
		end

		return arg_11_0.order < arg_11_1.order
	end)

	return self._taskArray
end

function PubgTaskData:isCanRewardTask()
	for iter_12_0, iter_12_1 in ipairs(self._taskArray) do
		if self:getTaskState(iter_12_1.id) == var_0_0.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

return PubgTaskData

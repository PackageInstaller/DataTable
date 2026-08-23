local var_0_0 = g.core.config.guild_alliance_task_info
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local AllianceTaskData = class("AllianceTaskData")

function AllianceTaskData:ctor()
	self._actions = {}
	self._awardTaskIds = {}

	self:initTaskData()
end

function AllianceTaskData:initTaskData()
	self._taskTypeDict = {}

	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		self._taskTypeDict[iter_2_1.type] = self._taskTypeDict[iter_2_1.type] or {}

		table.insert(self._taskTypeDict[iter_2_1.type], iter_2_1)
	end
end

function AllianceTaskData:getTaskAwardByCfg(arg_3_1)
	local var_3_0 = {}

	while var_0_0.hasKey("reward_type_" .. 1) do
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

function AllianceTaskData:updateTaskData(arg_4_1)
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

function AllianceTaskData:isTaskAwarded(arg_5_1)
	return self._awardTaskIds[arg_5_1]
end

function AllianceTaskData:getTaskValue(arg_6_1, arg_6_2)
	return self._actions[arg_6_1 .. "_" .. arg_6_2] or 0
end

function AllianceTaskData:onTaskAward(arg_7_1)
	self._awardTaskIds[arg_7_1] = true
end

function AllianceTaskData:getTaskState(arg_8_1)
	local var_8_0 = var_0_0.get(arg_8_1)
	local var_8_1 = var_0_1.TASK_STATE.NOT_FINISH

	if self._awardTaskIds[var_8_0.id] then
		var_8_1 = var_0_1.TASK_STATE.REWARD
	elseif (self._actions[var_8_0.action_key .. "_" .. var_8_0.action_id] or 0) >= var_8_0.action_value then
		var_8_1 = var_0_1.TASK_STATE.FINISH
	end

	return var_8_1
end

function AllianceTaskData:getTaskList(arg_9_1)
	local var_9_0 = {
		[var_0_1.TASK_STATE.NOT_FINISH] = 2,
		[var_0_1.TASK_STATE.FINISH] = 1,
		[var_0_1.TASK_STATE.REWARD] = 3
	}

	table.sort(self._taskTypeDict[arg_9_1], function(arg_10_0, arg_10_1)
		local var_10_0 = self:getTaskState(arg_10_0.id)
		local var_10_1 = self:getTaskState(arg_10_1.id)

		if var_10_0 ~= var_10_1 then
			return var_9_0[var_10_0] < var_9_0[var_10_1]
		end

		return arg_10_0.order < arg_10_1.order
	end)

	return self._taskTypeDict[arg_9_1]
end

function AllianceTaskData:resetDailyTaskProgress()
	for iter_11_0, iter_11_1 in ipairs(self._taskTypeDict[var_0_1.TASK_TYPE.DAILY]) do
		if self._actions[iter_11_1.action_key .. "_" .. iter_11_1.action_type] then
			self._actions[iter_11_1.action_key .. "_" .. iter_11_1.action_type] = 0
		end
	end
end

function AllianceTaskData:isCanRewardDailyTask()
	for iter_12_0, iter_12_1 in ipairs(self._taskTypeDict[var_0_1.TASK_TYPE.DAILY]) do
		if self:getTaskState(iter_12_1.id) == var_0_1.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

function AllianceTaskData:isCanRewardAchievementTask()
	for iter_13_0, iter_13_1 in ipairs(self._taskTypeDict[var_0_1.TASK_TYPE.ACHIEVEMENT]) do
		if self:getTaskState(iter_13_1.id) == var_0_1.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

return AllianceTaskData

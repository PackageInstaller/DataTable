local var_0_0 = g.core.config.activity_retro_task_info
local var_0_1 = g.core.config.activity_retro_parameter_info
local var_0_3 = g.core.const.ConstMgr.RetroConst
local var_0_4 = {
	[g.core.const.ConstMgr.RetroConst.TASK_STATE.NOT_FINISH] = 2,
	[g.core.const.ConstMgr.RetroConst.TASK_STATE.FINISH] = 1,
	[g.core.const.ConstMgr.RetroConst.TASK_STATE.REWARD] = 3
}
local RetroTaskData = class("RetroTaskData")

function RetroTaskData:ctor()
	self._taskGroup = {}
	self._actions = {}
	self._awardTaskIds = {}

	self:initTaskData()
end

function RetroTaskData:initTaskData(arg_2_1)
	self._groupId = arg_2_1
	self._taskGroup = {}
	self._taskTypeDict = {}

	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		if iter_2_1.group == self._groupId then
			table.insert(self._taskGroup, iter_2_1)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(self._taskGroup) do
		self._taskTypeDict[iter_2_3.task_type] = self._taskTypeDict[iter_2_3.task_type] or {}

		table.insert(self._taskTypeDict[iter_2_3.task_type], iter_2_3)
	end
end

function RetroTaskData:getTaskAwardByCfg(arg_3_1)
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

function RetroTaskData:updateTaskData(arg_4_1)
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

function RetroTaskData:onS2CActionStatusFlush(arg_5_1)
	self._actions[arg_5_1.status.key .. "_" .. arg_5_1.status.id] = arg_5_1.status.status
end

function RetroTaskData:isTaskAwarded(arg_6_1)
	return self._awardTaskIds[arg_6_1]
end

function RetroTaskData:getTaskValue(arg_7_1, arg_7_2)
	return self._actions[arg_7_1 .. "_" .. arg_7_2] or 0
end

function RetroTaskData:onTaskAward(arg_8_1)
	self._awardTaskIds[arg_8_1] = true
end

function RetroTaskData:getTaskState(arg_9_1)
	local var_9_0 = var_0_0.get(arg_9_1)
	local var_9_1 = var_0_3.TASK_STATE.NOT_FINISH

	if self._awardTaskIds[var_9_0.id] then
		var_9_1 = var_0_3.TASK_STATE.REWARD
	elseif (self._actions[var_9_0.action_key .. "_" .. var_9_0.action_id] or 0) >= var_9_0.action_value then
		var_9_1 = var_0_3.TASK_STATE.FINISH
	end

	return var_9_1
end

function RetroTaskData:getRetroStageList()
	local var_10_0 = var_0_1.get(3).parameter
	local var_10_1 = self:getCurProgressStageIndex()
	local var_10_2 = {}
	local var_10_3 = 0

	for iter_10_0, iter_10_1 in ipairs((self:getStageList())) do
		if iter_10_0 <= var_10_1 then
			table.insert(var_10_2, iter_10_1)
		else
			var_10_3 = var_10_3 + 1

			if var_10_3 <= var_10_0 then
				table.insert(var_10_2, iter_10_1)
			end
		end
	end

	return var_10_2
end

function RetroTaskData:getTaskPopListData()
	local var_11_0 = {}

	if self._taskTypeDict[var_0_3.TASK_TYPE.DAILY] then
		table.merge(var_11_0, self._taskTypeDict[var_0_3.TASK_TYPE.DAILY])
	end

	if self._taskTypeDict[var_0_3.TASK_TYPE.PERIOD] then
		table.merge(var_11_0, self._taskTypeDict[var_0_3.TASK_TYPE.PERIOD])
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		local var_12_0 = self:getTaskState(arg_12_0.id)
		local var_12_1 = self:getTaskState(arg_12_1.id)

		if var_12_0 ~= var_12_1 then
			return var_0_4[var_12_0] < var_0_4[var_12_1]
		end

		return arg_12_0.id < arg_12_1.id
	end)

	return var_11_0
end

function RetroTaskData:resetDailyTaskProgress()
	for iter_13_0, iter_13_1 in ipairs(self._taskTypeDict[var_0_3.TASK_TYPE.DAILY]) do
		if self._actions[iter_13_1.action_key .. "_" .. iter_13_1.action_type] then
			self._actions[iter_13_1.action_key .. "_" .. iter_13_1.action_type] = 0
		end
	end
end

function RetroTaskData:getCurStageProgress()
	local var_14_0 = self:getStageList()[1]

	return (self:getTaskValue(var_14_0.action_key, var_14_0.action_id))
end

function RetroTaskData:getStageList()
	table.sort(self._taskTypeDict[var_0_3.TASK_TYPE.STAGE], function(arg_16_0, arg_16_1)
		return arg_16_0.action_value < arg_16_1.action_value
	end)

	return self._taskTypeDict[var_0_3.TASK_TYPE.STAGE]
end

function RetroTaskData:getCurCanAwardStageIndex()
	local var_17_0 = self:getStageList()
	local var_17_1 = 1

	for iter_17_0 = 1, #var_17_0 do
		local var_17_2 = self:getTaskState(var_17_0[iter_17_0].id)

		if var_17_2 == var_0_3.TASK_STATE.FINISH then
			var_17_1 = iter_17_0

			break
		elseif var_17_2 == var_0_3.TASK_STATE.REWARD then
			var_17_1 = iter_17_0 + 1

			if #var_17_0 < iter_17_0 + 1 then
				var_17_1 = #var_17_0
			end
		end
	end

	return var_17_1
end

function RetroTaskData:getCurProgressStageIndex()
	local var_18_0 = self:getStageList()
	local var_18_1 = self:getTaskValue(var_18_0[1].action_key, var_18_0[1].action_id)
	local var_18_2 = 0

	for iter_18_0 = 1, #var_18_0 do
		if var_18_1 >= var_18_0[iter_18_0].action_value then
			var_18_2 = iter_18_0
		end
	end

	return var_18_2
end

function RetroTaskData:isCanRewardTask()
	for iter_19_0, iter_19_1 in ipairs(self._taskTypeDict[var_0_3.TASK_TYPE.DAILY] or {}) do
		if self:getTaskState(iter_19_1.id) == var_0_3.TASK_STATE.FINISH then
			return true
		end
	end

	for iter_19_2, iter_19_3 in ipairs(self._taskTypeDict[var_0_3.TASK_TYPE.PERIOD] or {}) do
		if self:getTaskState(iter_19_3.id) == var_0_3.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

function RetroTaskData:isCanRewardStageTask()
	for iter_20_0, iter_20_1 in ipairs((self:getRetroStageList())) do
		if self:getTaskState(iter_20_1.id) == var_0_3.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

return RetroTaskData

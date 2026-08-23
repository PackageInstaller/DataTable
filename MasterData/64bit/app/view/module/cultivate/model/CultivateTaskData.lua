local var_0_0 = g.core.config.cultivate_activity_task_info
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_2 = {
	[CultivateConst.TASK_REWARD_STATE.CAN_REWARD] = 3,
	[CultivateConst.TASK_REWARD_STATE.NOT_FINISH] = 2,
	[CultivateConst.TASK_REWARD_STATE.TASK_NOT_START] = 1,
	[CultivateConst.TASK_REWARD_STATE.GOT] = 0
}
local CultivateTaskData = class("CultivateTaskData")

function CultivateTaskData:ctor(arg_1_1, arg_1_2)
	self._groupId = arg_1_1
	self._taskList = nil
	self._taskIdMap = {}
	self._allTaskType = {}
	self._taskGroup = {}
	self._actData = arg_1_2
end

function CultivateTaskData:initPassCardData()
	if self._taskList then
		return
	end

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		if iter_2_1.task_group == self._groupId then
			var_2_0[iter_2_1.task_type] = var_2_0[iter_2_1.task_type] or {}
			var_2_0[iter_2_1.task_type][iter_2_1.group] = var_2_0[iter_2_1.task_type][iter_2_1.group] or {}

			if not var_2_1[iter_2_1.task_type] then
				table.insert(self._allTaskType, iter_2_1.task_type)

				var_2_1[iter_2_1.task_type] = true
			end

			table.insert(var_2_0[iter_2_1.task_type][iter_2_1.group], iter_2_1)
		end
	end

	self._taskList = var_2_0
end

function CultivateTaskData:getAllTaskType()
	self:initPassCardData()

	return self._allTaskType
end

function CultivateTaskData:getTargetTasks(arg_4_1)
	self:initPassCardData()

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self._taskList[arg_4_1]) do
		local var_4_1 = false

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_2 = self:getTaskRewardState(iter_4_3.id)

			if var_4_2 ~= CultivateConst.TASK_REWARD_STATE.GOT then
				var_4_1 = true

				local var_4_4 = {
					cfg = iter_4_3,
					taskState = var_4_2
				}

				var_4_4.taskData = self._taskIdMap[iter_4_3.id] or {
					progress = 0
				}
				var_4_4.startTime = g.core.common.ServerTime:getNextNDayZeroTime(self._actData.start_time, iter_4_3.open_day)

				table.insert(var_4_0, var_4_4)

				break
			end
		end

		if not var_4_1 then
			local var_4_6 = {
				cfg = iter_4_1[#iter_4_1],
				taskState = self:getTaskRewardState(iter_4_1[#iter_4_1].id)
			}

			var_4_6.taskData = self._taskIdMap[iter_4_1[#iter_4_1].id] or {
				progress = 0
			}
			var_4_6.startTime = g.core.common.ServerTime:getNextNDayZeroTime(self._actData.start_time, iter_4_1[#iter_4_1].open_day)

			table.insert(var_4_0, var_4_6)
		end
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		if arg_5_0.taskState ~= arg_5_1.taskState then
			return var_0_2[arg_5_0.taskState] > var_0_2[arg_5_1.taskState]
		end

		if arg_5_0.taskState == CultivateConst.TASK_REWARD_STATE.NOT_FINISH then
			if arg_5_0.taskData.progress / arg_5_0.cfg.action_value ~= arg_5_1.taskData.progress / arg_5_1.cfg.action_value then
				return arg_5_1.taskData.progress / arg_5_1.cfg.action_value < arg_5_0.taskData.progress / arg_5_0.cfg.action_value
			end
		end

		if arg_5_0.cfg.id ~= arg_5_1.cfg.id then
			return arg_5_0.cfg.id < arg_5_1.cfg.id
		end

		return false
	end)

	return var_4_0
end

function CultivateTaskData:getTaskReward(arg_6_1)
	local var_6_0 = {}

	while var_0_0.hasKey("reward_type_" .. 1) do
		if arg_6_1["reward_size_" .. 1] > 0 then
			table.insert(var_6_0, {
				type = arg_6_1["reward_type_" .. 1],
				value = arg_6_1["reward_value_" .. 1],
				size = arg_6_1["reward_size_" .. 1]
			})
		end
	end

	return var_6_0
end

function CultivateTaskData:updateTaskData(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1 or {}) do
		self._taskIdMap[iter_7_1.task_id] = iter_7_1
	end
end

function CultivateTaskData:onTaskAward(arg_8_1)
	self._taskIdMap[arg_8_1.task_id] = self._taskIdMap[arg_8_1.task_id] or {
		progress = 0
	}
	self._taskIdMap[arg_8_1.task_id].state = true
end

function CultivateTaskData:getTaskRewardState(arg_9_1)
	local var_9_0 = var_0_0.get(arg_9_1)

	if var_9_0.open_day ~= 1 and g.core.common.ServerTime:getNextNDayZeroTime(self._actData.start_time, var_9_0.open_day) > g.core.common.ServerTime:getTime() then
		return CultivateConst.TASK_REWARD_STATE.TASK_NOT_START
	end

	if (self._taskIdMap[arg_9_1] or {
		progress = 0
	}).state then
		return CultivateConst.TASK_REWARD_STATE.GOT
	end

	if self._taskIdMap[arg_9_1] then
		if (self._taskIdMap[arg_9_1].progress or 0) >= var_9_0.action_value then
			return CultivateConst.TASK_REWARD_STATE.CAN_REWARD
		end
	end

	return CultivateConst.TASK_REWARD_STATE.NOT_FINISH
end

function CultivateTaskData:isHasTaskCanReward(arg_10_1)
	self:initPassCardData()

	for iter_10_0, iter_10_1 in pairs(self._taskList[arg_10_1] or {}) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			if self:getTaskRewardState(iter_10_3.id) == CultivateConst.TASK_REWARD_STATE.CAN_REWARD then
				return true
			end
		end
	end

	return false
end

return CultivateTaskData

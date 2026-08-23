local var_0_0 = g.core.config.richman_task_info
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local RichmanTaskData = class("RichmanTaskData")

function RichmanTaskData:ctor()
	self._actions = {}
	self._awardTaskIds = {}

	self:initTaskData()
end

function RichmanTaskData:initTaskData()
	self._taskData = {}

	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		table.insert(self._taskData, {
			cfg = iter_2_1,
			state = RichmanConst.TASK_STATE.NOT_FINISH,
			awards = self:getTaskAwardByCfg(iter_2_1)
		})
	end
end

function RichmanTaskData:getTaskAwardByCfg(arg_3_1)
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

function RichmanTaskData:updateTaskData(arg_4_1)
	if not arg_4_1 then
		return
	end

	self._resetType = arg_4_1.reset_type
	self._awardTaskIds = {}
	self._actions = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1.award_task_ids or {}) do
			self._awardTaskIds[iter_4_3] = true
		end

		self._lastResetTime = arg_4_1.last_reset_time

		for iter_4_4, iter_4_5 in ipairs(iter_4_1.actions or {}) do
			self._actions[iter_4_5.key .. "_" .. iter_4_5.type] = iter_4_5.value
		end
	end

	self:updateTaskState()
end

function RichmanTaskData:onS2CActionStatusFlush(arg_5_1)
	self._actions[arg_5_1.status.key .. "_" .. arg_5_1.status.id] = arg_5_1.status.status

	self:updateTaskState()
end

function RichmanTaskData:isTaskAwarded(arg_6_1)
	return self._awardTaskIds[arg_6_1]
end

function RichmanTaskData:getTaskValue(arg_7_1, arg_7_2)
	return self._actions[arg_7_1 .. "_" .. arg_7_2] or 0
end

function RichmanTaskData:onTaskAward(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self._awardTaskIds[iter_8_1] = true
	end

	self:updateTaskState()
end

function RichmanTaskData:updateTaskState()
	for iter_9_0, iter_9_1 in ipairs(self._taskData) do
		local var_9_1

		if self._awardTaskIds[iter_9_1.cfg.id] then
			var_9_1 = RichmanConst.TASK_STATE.REWARD

			if not RichmanConst.TASK_STATE.REWARD then
				if (self._actions[iter_9_1.cfg.action_key .. "_" .. iter_9_1.cfg.action_type] or 0) >= iter_9_1.cfg.goal then
					var_9_1 = RichmanConst.TASK_STATE.FINISH or RichmanConst.TASK_STATE.NOT_FINISH
				end
			end
		end

		iter_9_1.state = var_9_1
	end
end

function RichmanTaskData:getTaskList()
	local var_10_0 = {
		[RichmanConst.TASK_STATE.NOT_FINISH] = 2,
		[RichmanConst.TASK_STATE.FINISH] = 1,
		[RichmanConst.TASK_STATE.REWARD] = 3
	}

	table.sort(self._taskData, function(arg_11_0, arg_11_1)
		if arg_11_0.state ~= arg_11_1.state then
			return var_10_0[arg_11_0.state] < var_10_0[arg_11_1.state]
		end

		return arg_11_0.cfg.order < arg_11_1.cfg.order
	end)

	return self._taskData
end

function RichmanTaskData:isCanRewardTask()
	for iter_12_0, iter_12_1 in ipairs(self._taskData) do
		if iter_12_1.state == RichmanConst.TASK_STATE.FINISH then
			return true
		end
	end

	return false
end

return RichmanTaskData

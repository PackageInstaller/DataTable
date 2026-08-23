local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostTaskData = class("OutpostTaskData")

function OutpostTaskData:ctor()
	self:initData()
end

function OutpostTaskData:initData()
	self._limitTriggerTime = 0
	self._limitTask = {}
	self._taskIdList = {}
	self._taskIdDic = {}
	self._actionDic = {
		[var_0_0.TASK_TYPE.MAIN] = {},
		[var_0_0.TASK_TYPE.LIMIT] = {}
	}
	self._curTask = nil

	self:_initTaskIdList()
end

function OutpostTaskData:_initTaskIdList()
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = {}

	for iter_3_0 = 1, g.core.config.outpost_main_quest_info.getLength() do
		local var_3_3 = g.core.config.outpost_main_quest_info.indexOf(iter_3_0)
		local var_3_4 = {
			cfg = var_3_3
		}

		var_3_1[var_3_3.id] = var_3_4

		if var_3_3.next_id ~= 0 then
			if var_3_1[var_3_3.next_id] then
				var_3_4.nextInfo = var_3_1[var_3_3.next_id]
				var_3_2[var_3_3.id] = nil
			else
				var_3_0[var_3_3.next_id] = var_3_4
			end
		end

		if var_3_0[var_3_3.id] then
			var_3_0[var_3_3.id].nextInfo = var_3_4
		else
			var_3_2[var_3_3.id] = var_3_4
		end
	end

	self._taskIdList = {}

	for iter_3_1, iter_3_2 in pairs(var_3_2) do
		local var_3_5 = {}
		local var_3_6 = {}

		while iter_3_2 do
			var_3_5[#var_3_5 + 1] = iter_3_2.cfg.id
			var_3_6[iter_3_2.cfg.id] = #var_3_5 + 1
			iter_3_2 = iter_3_2.nextInfo
		end

		self._taskIdList[#self._taskIdList + 1] = var_3_5
		self._taskIdDic[#self._taskIdDic + 1] = var_3_6
	end

	for iter_3_3 = 1, g.core.config.outpost_limit_quest_info.getLength() do
		self._limitTask[iter_3_3] = g.core.config.outpost_limit_quest_info.indexOf(iter_3_3)
	end
end

function OutpostTaskData:getTaskAward(arg_4_1)
	local var_4_0 = {}
	local var_4_1 = 1
	local var_4_2 = {
		"reward_type_"
	}

	var_4_2[2] = 1

	local var_4_3 = table.concat(var_4_2)
	local var_4_4 = table.concat({
		"reward_value_",
		var_4_1
	})
	local var_4_5 = table.concat({
		"reward_size_",
		var_4_1
	})

	while g.core.config.outpost_main_quest_info.hasKey(var_4_3) do
		if arg_4_1[var_4_3] ~= 0 then
			var_4_0[#var_4_0 + 1] = {
				type = arg_4_1[var_4_3],
				value = arg_4_1[var_4_4],
				size = arg_4_1[var_4_5]
			}
		end

		var_4_1 = var_4_1 + 1
		var_4_3 = table.concat({
			"reward_type_",
			var_4_1
		})
		var_4_4 = table.concat({
			"reward_value_",
			var_4_1
		})
		var_4_5 = table.concat({
			"reward_size_",
			var_4_1
		})
	end

	return var_4_0
end

function OutpostTaskData:setCurTask(arg_5_1)
	local var_5_0 = g.core.config.outpost_main_quest_info.get(arg_5_1)

	self._curTask = {
		cfg = var_5_0,
		action = self._actionDic[var_0_0.TASK_TYPE.MAIN][arg_5_1],
		awards = self:getTaskAward(var_5_0)
	}
end

function OutpostTaskData:setMainTaskIsALLFinish()
	local var_6_0 = self._taskIdList[var_0_0.TASK_TYPE.MAIN][#self._taskIdList[var_0_0.TASK_TYPE.MAIN]]

	if not self._curTask or self._curTask.cfg.id ~= var_6_0 then
		self:setCurTask(var_6_0)
	end

	self._curTask.action = {
		action_value = self._curTask.cfg.quest_value,
		task_id = var_6_0
	}
	self._curTask.isAllFinish = true
end

function OutpostTaskData:getCurTask()
	return self._curTask
end

function OutpostTaskData:getCurTaskIdx()
	if not self._curTask then
		return 1
	end

	return self._taskIdDic[var_0_0.TASK_TYPE.MAIN][self._curTask.cfg.id]
end

function OutpostTaskData:getTaskIdx(arg_9_1)
	return self._taskIdDic[var_0_0.TASK_TYPE.MAIN][arg_9_1]
end

function OutpostTaskData:getTaskIdList(arg_10_1)
	return self._taskIdList[arg_10_1]
end

function OutpostTaskData:getAction(arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or var_0_0.TASK_TYPE.MAIN

	return self._actionDic[arg_11_2][arg_11_1]
end

function OutpostTaskData:isTaskGetAward(arg_12_1)
	local var_12_0 = self:getAction(arg_12_1)

	if not var_12_0 then
		return false
	end

	return var_12_0.finished
end

function OutpostTaskData:_onTriggerLimitTask()
	for iter_13_0, iter_13_1 in ipairs(self._limitTask) do
		local var_13_0 = self:getAction(iter_13_1.id, var_0_0.TASK_TYPE.LIMIT)

		if var_13_0 then
			self._limitTriggerTime = var_13_0.trigger_time

			break
		end
	end
end

function OutpostTaskData:isTriggerLimit()
	return self._limitTriggerTime ~= 0
end

function OutpostTaskData:getLimitPassEndTime()
	return self._limitTriggerTime + g.core.config.outpost_parameter_info.get(var_0_0.ParameterID.LIMIT_TASK_TIME).parameter
end

function OutpostTaskData:getLimitTaskList()
	return self._limitTask
end

function OutpostTaskData:updateTask(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1 or {}) do
		local var_17_1 = iter_17_1.task_type
		local var_17_2 = self._actionDic[iter_17_1.task_type]

		if var_0_0.TASK_TYPE.LIMIT == iter_17_1.task_type and iter_17_1.actions then
			self:_onTriggerLimitTask()
		elseif var_0_0.TASK_TYPE.MAIN == var_17_1 and not iter_17_1.actions then
			self:setMainTaskIsALLFinish()
		end

		for iter_17_2, iter_17_3 in ipairs(iter_17_1.actions or {}) do
			var_17_2[iter_17_3.task_id] = iter_17_3

			if var_0_0.TASK_TYPE.MAIN == var_17_1 then
				if self._curTask and self._curTask.id == iter_17_3.task_id then
					self._curTask.action = iter_17_3
				else
					self:setCurTask(iter_17_3.task_id)
				end
			end
		end
	end
end

function OutpostTaskData:onS2COutpostSyncTask(arg_18_1)
	local var_18_0 = false

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.actions) do
		self._actionDic[arg_18_1.task_type][iter_18_1.task_id] = iter_18_1

		if var_0_0.TASK_TYPE.MAIN == arg_18_1.task_type and self._curTask and self._curTask.cfg.id == iter_18_1.task_id then
			self._curTask.action = iter_18_1
		end

		var_18_0 = true
	end

	if var_0_0.TASK_TYPE.LIMIT == arg_18_1.task_type and var_18_0 then
		self:_onTriggerLimitTask()
	elseif var_0_0.TASK_TYPE.MAIN == arg_18_1.task_type and not var_18_0 then
		self:setMainTaskIsALLFinish()
	end
end

function OutpostTaskData:onS2COutpostGetTaskAward(arg_19_1)
	if arg_19_1.task_tp == var_0_0.TASK_TYPE.MAIN then
		self._actionDic[arg_19_1.task_tp][arg_19_1.task_id].finished = true

		local var_19_0 = g.core.config.outpost_main_quest_info.get(arg_19_1.task_id)

		if var_19_0.next_id and var_19_0.next_id ~= 0 then
			self:setCurTask(var_19_0.next_id)
		else
			self:setMainTaskIsALLFinish()
		end
	else
		for iter_19_0, iter_19_1 in pairs(self._actionDic[arg_19_1.task_tp]) do
			iter_19_1.finished = true
		end

		self._limitTriggerTime = 0
	end
end

function OutpostTaskData:canGetLimitTaskAward()
	local var_20_0 = true

	for iter_20_0, iter_20_1 in ipairs(self._limitTask) do
		local var_20_1 = self:getAction(iter_20_1.id, var_0_0.TASK_TYPE.LIMIT)

		if not var_20_1 or var_20_1.action_value < iter_20_1.quest_value or var_20_1.finished then
			var_20_0 = false

			break
		end
	end

	return var_20_0
end

return OutpostTaskData

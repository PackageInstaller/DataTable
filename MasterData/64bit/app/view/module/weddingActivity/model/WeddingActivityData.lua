local WeddingActivityData = class("WeddingActivityData")

function WeddingActivityData:ctor()
	self._actList = {}
	self._actIdMap = {}
	self._requestedMap = {}
	self._waitIdList = {}
end

function WeddingActivityData:initData()
	return
end

function WeddingActivityData:_createOneActivityData(arg_3_1)
	local var_3_0 = {
		actId = arg_3_1
	}

	var_3_0.openTime = 0
	var_3_0.taskList, var_3_0.taskMap = self:_getTaskList(arg_3_1)
	var_3_0.awards = self:_getAwards(arg_3_1)

	local var_3_1 = g.core.config.wedding_activity_info.get(arg_3_1)

	var_3_0.holdTime = var_3_1.time
	var_3_0.functionId = var_3_1.function_id
	var_3_0.getAward = false
	self._actList[#self._actList + 1] = var_3_0
	self._actIdMap[arg_3_1] = var_3_0

	return var_3_0
end

function WeddingActivityData:_getTaskList(arg_4_1)
	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = g.core.config.wedding_activity_info.get(arg_4_1)
	local var_4_3 = 1
	local var_4_4 = {
		"action_id"
	}

	var_4_4[2] = 1

	local var_4_5 = table.concat(var_4_4, "_")

	while g.core.config.wedding_activity_info.hasKey(var_4_5) do
		local var_4_6

		if var_4_2[var_4_5] == 0 then
			do break end

			var_4_6 = {
				var_4_2[var_4_5]
			}
		end

		var_4_6[2] = var_4_2[table.concat({
			"action_key",
			var_4_3
		}, "_")]

		local var_4_7 = table.concat(var_4_6, "_")
		local var_4_8 = {
			cur = 0,
			des = var_4_2[table.concat({
				"des",
				var_4_3
			}, "_")],
			key = var_4_7,
			target = var_4_2[table.concat({
				"action_value",
				var_4_3
			}, "_")]
		}

		var_4_0[#var_4_0 + 1] = var_4_8
		var_4_1[var_4_7] = var_4_8
		var_4_3 = var_4_3 + 1
		var_4_5 = table.concat({
			"action_id",
			var_4_3
		}, "_")
	end

	return var_4_0, var_4_1
end

function WeddingActivityData:_getAwards(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = g.core.config.wedding_activity_info.get(arg_5_1)
	local var_5_3 = 1
	local var_5_4 = {
		"reward_type"
	}

	var_5_4[2] = 1

	local var_5_5 = table.concat(var_5_4, "_")

	while g.core.config.wedding_activity_info.hasKey(var_5_5) do
		if var_5_2[var_5_5] == 0 then
			break
		end

		local var_5_6 = var_5_2[table.concat({
			"reward_value",
			var_5_3
		}, "_")]
		local var_5_7 = table.concat({
			var_5_2[var_5_5],
			var_5_6
		}, "_")
		local var_5_8 = var_5_2[table.concat({
			"reward_size",
			var_5_3
		}, "_")]

		if not var_5_1[var_5_7] then
			var_5_0[#var_5_0 + 1] = {
				type = var_5_2[var_5_5],
				value = var_5_6,
				size = var_5_8
			}
		else
			var_5_1[var_5_7].size = var_5_1[var_5_7].size + var_5_8
		end

		var_5_3 = var_5_3 + 1
		var_5_5 = table.concat({
			"reward_type",
			var_5_3
		}, "_")
	end

	return var_5_0
end

function WeddingActivityData:_removeActivityData(arg_6_1)
	if not self._actIdMap[arg_6_1] then
		return
	end

	self._actIdMap[arg_6_1] = nil

	for iter_6_0, iter_6_1 in ipairs(self._actList) do
		if iter_6_1.actId == arg_6_1 then
			table.remove(self._actList, iter_6_0)

			break
		end
	end
end

function WeddingActivityData:_checkOneActIsOpen(arg_7_1)
	if arg_7_1.actId == 0 then
		return false
	end

	local var_7_0 = g.core.config.wedding_activity_info.get(arg_7_1.actId)

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_7_0.function_id) then
		return false
	end

	local var_7_1 = g.core.common.ServerTime:getTime()

	return arg_7_1.openTime <= var_7_1 and var_7_1 < arg_7_1.openTime + var_7_0.time
end

function WeddingActivityData:checkNeedRequestedActivityId()
	self._waitIdList = {}

	for iter_8_0 = 1, g.core.config.wedding_activity_info.getLength() do
		local var_8_0 = g.core.config.wedding_activity_info.indexOf(iter_8_0)

		if not self._requestedMap[var_8_0.id] and g.core.common.ModuleUnlock:isModuleUnlock(var_8_0.function_id) then
			self._waitIdList[#self._waitIdList + 1] = var_8_0.id
		end
	end

	return self._waitIdList
end

function WeddingActivityData:_inputRequestedActivityIdList()
	for iter_9_0, iter_9_1 in ipairs(self._waitIdList) do
		self._requestedMap[iter_9_1] = true
	end

	if #self._waitIdList > 0 then
		g.core.model.User.giftData:refreshInTime()
	end

	self._waitIdList = {}
end

function WeddingActivityData:isOpen(arg_10_1)
	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(self._actList) do
		if iter_10_1.actId == arg_10_1 then
			var_10_0 = self:_checkOneActIsOpen(iter_10_1)

			break
		elseif not arg_10_1 and self:_checkOneActIsOpen(iter_10_1) then
			var_10_0 = true

			break
		end
	end

	return var_10_0
end

function WeddingActivityData:getFrontActData()
	return self._actList[1]
end

function WeddingActivityData:onS2CWeddingActivityGetInfo(arg_12_1)
	self._actList = {}
	self._actIdMap = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.infos or {}) do
		local var_12_0 = self:_createOneActivityData(iter_12_1.id)

		var_12_0.openTime = iter_12_1.open_time
		var_12_0.getAward = iter_12_1.task_award

		self:_updateTaskData(var_12_0.taskMap, iter_12_1.tasks or {})
	end

	self:_inputRequestedActivityIdList()
end

function WeddingActivityData:onS2CWeddingActivityNotify(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1.infos) do
		local var_13_0 = self._actIdMap[iter_13_1.id] or self:_createOneActivityData(iter_13_1.id)

		var_13_0.openTime = iter_13_1.open_time

		self:_updateTaskData(var_13_0.taskMap, iter_13_1.tasks or {})

		var_13_0.getAward = iter_13_1.task_award
	end
end

function WeddingActivityData:onS2CWeddingActivityTaskAward(arg_14_1)
	if not self._actIdMap[arg_14_1.id] then
		return
	end

	self._actIdMap[arg_14_1.id].getAward = true
end

function WeddingActivityData:_updateTaskData(arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in ipairs(arg_15_2) do
		local var_15_0 = arg_15_1[table.concat({
			iter_15_1.type,
			iter_15_1.key
		}, "_")]

		if var_15_0 then
			var_15_0.cur = iter_15_1.value
		end
	end
end

function WeddingActivityData:isCanGetTaskAward(arg_16_1)
	if arg_16_1.id then
		return self:_isOneActDataGetTaskAward(arg_16_1.id)
	end

	for iter_16_0, iter_16_1 in ipairs(self._actList) do
		if self:_isOneActDataGetTaskAward(iter_16_1.actId) then
			return true
		end
	end

	return false
end

function WeddingActivityData:_isOneActDataGetTaskAward(arg_17_1)
	if not self._actIdMap[arg_17_1] then
		return
	end

	local var_17_0 = true

	for iter_17_0, iter_17_1 in ipairs(self._actIdMap[arg_17_1].taskList) do
		if iter_17_1.cur < iter_17_1.target or self._actIdMap[arg_17_1].getAward then
			var_17_0 = false

			break
		end
	end

	return var_17_0
end

return WeddingActivityData

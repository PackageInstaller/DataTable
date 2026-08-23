local var_0_0 = g.core.config.gve_task_info
local var_0_1 = g.core.config.gve_task_group_info
local var_0_2 = g.core.const.ConstMgr.GveConst.TASK_RECEIVE_STATUS
local GveTaskData = class("GveTaskData")

function GveTaskData:ctor()
	self:initData()
end

function GveTaskData:initData()
	self._taskData = {}
	self._hasReceivedChapters = {}
	self._maxChapterId = 0
	self._haveRedPoint = false
	self._taskData = {}
end

function GveTaskData:updateTaskInfo(arg_3_1)
	self._haveRedPoint = false

	local var_3_0 = arg_3_1.task_data or {}

	self:_initTaskData()
	self:_mergeData(var_3_0)

	self._hasReceivedChapters = arg_3_1.award_chapters or {}
	self._maxChapterId = arg_3_1.max_chapter_id or 0
end

function GveTaskData:taskActionFlush(arg_4_1)
	for iter_4_0 = 1, #self._taskData do
		local var_4_0 = var_0_0.get(self._taskData[iter_4_0].task_id)

		if var_4_0.type == arg_4_1.id and arg_4_1.key == var_4_0.key then
			self._taskData[iter_4_0].value = arg_4_1.status
		end
	end
end

function GveTaskData:_initTaskData()
	self._taskData = {}

	for iter_5_0 = 1, var_0_0.getLength() do
		local var_5_0 = {}
		local var_5_1 = var_0_0.indexOf(iter_5_0)

		var_5_0.chapter_id = var_5_1.title_id
		var_5_0.task_id = var_5_1.id
		var_5_0.value = 0
		var_5_0.target = var_5_1.value
		var_5_0.is_award = false

		table.insert(self._taskData, var_5_0)
	end
end

function GveTaskData:_mergeData(arg_6_1)
	for iter_6_0 = 1, #arg_6_1 do
		for iter_6_1 = 1, #self._taskData do
			if arg_6_1[iter_6_0].task_id == self._taskData[iter_6_1].task_id then
				self._taskData[iter_6_1].is_award = arg_6_1[iter_6_0].is_award
				self._taskData[iter_6_1].value = arg_6_1[iter_6_0].value
			end
		end
	end
end

function GveTaskData:updateTaskStatus(arg_7_1)
	for iter_7_0 = 1, #self._taskData do
		if arg_7_1.id and self._taskData[iter_7_0].task_id == arg_7_1.id then
			self._taskData[iter_7_0].is_award = true
		end
	end

	self._maxChapterId = arg_7_1.max_chapter_id
end

function GveTaskData:updateChapterStatus(arg_8_1)
	if arg_8_1.id then
		table.insert(self._hasReceivedChapters, arg_8_1.id)
	end
end

function GveTaskData:getTaskByChapterId(arg_9_1)
	local var_9_0 = {}

	for iter_9_0 = 1, #self._taskData do
		if self._taskData[iter_9_0].chapter_id == arg_9_1 then
			table.insert(var_9_0, self._taskData[iter_9_0])
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		local var_10_0 = self:getTaskStatus(arg_10_0)
		local var_10_1 = self:getTaskStatus(arg_10_1)

		if var_10_0 == var_10_1 then
			if arg_10_0.task_id < arg_10_1.task_id then
				return true
			end
		elseif var_10_0 == var_0_2.CAN_RECEIVE then
			return true
		elseif var_10_1 == var_0_2.CAN_RECEIVE then
			return false
		elseif var_10_0 == var_0_2.HAVE_RECEIVED then
			return false
		elseif var_10_1 == var_0_2.HAVE_RECEIVED then
			return true
		end

		return arg_10_0.task_id < arg_10_1.task_id
	end)

	return var_9_0
end

function GveTaskData:getCompleteTaskByChapterId(arg_11_1)
	local var_11_0 = self:getTaskByChapterId(arg_11_1)
	local var_11_1 = {}

	for iter_11_0 = 1, #var_11_0 do
		if var_11_0[iter_11_0].value >= var_11_0[iter_11_0].target and var_11_0[iter_11_0].is_award then
			table.insert(var_11_1, var_11_0[iter_11_0])
		end
	end

	return var_11_1
end

function GveTaskData:getMaxCompleteChapterId()
	return self._maxChapterId or 0
end

function GveTaskData:getChapterStatus(arg_13_1)
	local var_13_0 = var_0_2.CAN_NOT_RECEIVE

	for iter_13_0 = 1, #self._hasReceivedChapters do
		if self._hasReceivedChapters[iter_13_0] == arg_13_1 then
			var_13_0 = var_0_2.HAVE_RECEIVED
		end
	end

	if var_13_0 ~= var_0_2.HAVE_RECEIVED and self:isCompleteChapter(arg_13_1) then
		var_13_0 = var_0_2.CAN_RECEIVE
	end

	return var_13_0
end

function GveTaskData:getTaskStatus(arg_14_1)
	return arg_14_1.is_award and var_0_2.HAVE_RECEIVED or arg_14_1.value >= arg_14_1.target and var_0_2.CAN_RECEIVE or var_0_2.CAN_NOT_RECEIVE
end

function GveTaskData:isCompleteChapter(arg_15_1)
	if arg_15_1 == 0 then
		return true
	end

	local var_15_0 = self:getTaskByChapterId(arg_15_1)

	for iter_15_0 = 1, #var_15_0 do
		if var_15_0[iter_15_0].value < var_15_0[iter_15_0].target or var_15_0[iter_15_0].is_award == false then
			return false
		end
	end

	return true
end

function GveTaskData:isHavePreChapter(arg_16_1)
	if arg_16_1 - 1 > 0 then
		return true, arg_16_1 - 1
	end

	return false
end

function GveTaskData:isHaveNextChapter(arg_17_1)
	if arg_17_1 == 0 then
		return true, 1
	end

	local var_17_0 = var_0_1.get(arg_17_1)

	if var_17_0.next_id ~= 0 then
		return true, var_17_0.next_id
	end

	return false
end

function GveTaskData:getProfileAwardInfo(arg_18_1)
	local var_18_0 = {}
	local var_18_1 = g.core.config.drop_info.get(arg_18_1, 1)

	for iter_18_0 = 1, 5 do
		if var_18_1["reward_type_" .. iter_18_0] ~= 0 then
			table.insert(var_18_0, {
				type = var_18_1["reward_type_" .. iter_18_0],
				value = var_18_1["reward_value_" .. iter_18_0],
				size = var_18_1["reward_min_" .. iter_18_0]
			})
		end
	end

	return var_18_0
end

function GveTaskData:getPrivilegeByChapterId(arg_19_1)
	local var_19_0 = {}

	if not arg_19_1 or arg_19_1 == 0 then
		var_19_0 = {
			{
				privilegeType = 1,
				privilegeValue = 12
			},
			{
				privilegeType = 2,
				privilegeValue = 10
			},
			{
				privilegeType = 3,
				privilegeValue = 3
			}
		}

		return var_19_0
	end

	local var_19_1 = var_0_1.get(arg_19_1)

	while var_0_1.hasKey("privilege_" .. 1) do
		if var_19_1["privilege_" .. 1] > 0 then
			local var_19_2 = {
				privilegeType = var_19_1["privilege_" .. 1],
				privilegeValue = var_19_1["privilege_value_" .. 1]
			}

			if var_19_2.privilegeType == 1 then
				var_19_2.privilegeValue = var_19_2.privilegeValue + 12
			elseif var_19_2.privilegeType == 2 then
				var_19_2.privilegeValue = var_19_2.privilegeValue + 10
			elseif var_19_2.privilegeType == 3 then
				var_19_2.privilegeValue = var_19_2.privilegeValue + 3
			end

			table.insert(var_19_0, var_19_2)
		end
	end

	return var_19_0
end

function GveTaskData:getNewPrivilege(arg_20_1)
	local var_20_0 = {}

	if arg_20_1 - 1 == 0 then
		var_20_0 = self:getPrivilegeByChapterId(arg_20_1)
	else
		local var_20_1 = self:getPrivilegeByChapterId(arg_20_1 - 1)
		local var_20_2 = self:getPrivilegeByChapterId(arg_20_1)

		for iter_20_0 = 1, #var_20_2 do
			local var_20_3 = false

			for iter_20_1 = 1, #var_20_1 do
				if var_20_2[iter_20_0].privilegeType == var_20_1[iter_20_1].privilegeType and var_20_2[iter_20_0].privilegeValue == var_20_1[iter_20_1].privilegeValue then
					var_20_3 = true
				end
			end

			if not var_20_3 then
				table.insert(var_20_0, var_20_2[iter_20_0])
			end
		end
	end

	return var_20_0
end

function GveTaskData:getPrivilegeLevel()
	if self._maxChapterId == 0 then
		return 0
	end

	return var_0_1.get(self._maxChapterId).level
end

function GveTaskData:getPrivilegeGridNum()
	for iter_22_0, iter_22_1 in ipairs((self:getPrivilegeByChapterId(self:getMaxCompleteChapterId()))) do
		if iter_22_1.privilegeType == 2 then
			return iter_22_1.privilegeValue
		end
	end

	return 0
end

function GveTaskData:haveTaskRedPoint()
	local var_23_0 = {}

	for iter_23_0 = 1, #self._taskData do
		if self._taskData[iter_23_0].value >= self._taskData[iter_23_0].target and not self._taskData[iter_23_0].is_award and self._maxChapterId + 1 >= self._taskData[iter_23_0].chapter_id then
			return true
		end

		var_23_0[self._taskData[iter_23_0].chapter_id] = true
	end

	for iter_23_1, iter_23_2 in pairs(var_23_0) do
		if self:getChapterStatus(iter_23_1) == var_0_2.CAN_RECEIVE then
			return true
		end
	end

	return self._haveRedPoint
end

function GveTaskData:updateTaskRewardStatus(arg_24_1)
	self._haveRedPoint = arg_24_1
end

return GveTaskData

local CommanderManualPage = class("CommanderManualPage", import(".BaseVO"))

function CommanderManualPage:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.configId = arg_1_1.id
	self.id = arg_1_1.id
	self.pt = arg_1_1.pt
	self.award = arg_1_1.award
	self.finishedTaskIds = arg_1_2
	self.topFinishedTaskIds = arg_1_2
	self.isUnlock = arg_1_3
	self.topPage = 0
	self.topUnlockTaskIds = {}

	for iter_1_0, iter_1_1 in ipairs(pg.tutorial_handbook.all) do
		if table.contains(pg.tutorial_handbook[iter_1_1].tag_list, self.id) then
			self.topPage = iter_1_1
			self.topUnlockTaskIds = pg.tutorial_handbook[iter_1_1].unlock_param

			break
		end
	end

	self.leftUnlockTaskIds = self:getConfig("unlock")
	self.unlockTaskIds = {}
	self.taskIds = {}
	self.taskIdList = {}

	for iter_1_2, iter_1_3 in ipairs(self:getConfig("task_list")) do
		table.insert(self.unlockTaskIds, iter_1_3[2])
		table.insert(self.taskIds, iter_1_3[1])
		table.insertto(self.taskIdList, iter_1_3[1])
	end

	self.initTaskIdList = Clone(self.taskIdList)

	self:ChangeUnlock()

	self.doingGetTaskIndexes = {}

	return
end

function CommanderManualPage:bindConfigTable()
	return pg.tutorial_handbook_task
end

function CommanderManualPage:AddPt()
	self.isUnlock = true
	self.pt = self.pt + 1

	return
end

function CommanderManualPage:AddAward()
	self.isUnlock = true
	self.award = self.award + 1

	return
end

function CommanderManualPage:AddFinishedTaskId(arg_5_1)
	self.isUnlock = true

	table.insert(self.finishedTaskIds, arg_5_1)

	return
end

function CommanderManualPage:ChangeUnlock(arg_6_1)
	if arg_6_1 then
		self.topFinishedTaskIds = arg_6_1
	end

	for iter_6_0, iter_6_1 in ipairs(self.topUnlockTaskIds) do
		if not table.contains(self.topFinishedTaskIds, iter_6_1) then
			return
		end
	end

	for iter_6_2, iter_6_3 in ipairs(self.leftUnlockTaskIds) do
		if not table.contains(self.finishedTaskIds, iter_6_3) then
			return
		end
	end

	self.isUnlock = true

	return
end

function CommanderManualPage:GetTasks()
	if not self.isUnlock then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(self.unlockTaskIds) do
		local var_7_0 = true

		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			if not table.contains(self.finishedTaskIds, iter_7_3) then
				var_7_0 = false

				break
			end
		end

		if var_7_0 then
			for iter_7_4, iter_7_5 in ipairs(self.taskIds[iter_7_0]) do
				if not getProxy(TaskProxy):getTaskById(iter_7_5) and not table.contains(self.finishedTaskIds, iter_7_5) and not table.contains(self.doingGetTaskIndexes, iter_7_0) then
					pg.m02:sendNotification(GAME.COMMANDER_MANUAL_OP, {
						operation = CommanderManualProxy.GET_TASK,
						pageId = self.id,
						index = iter_7_0
					})
					table.insert(self.doingGetTaskIndexes, iter_7_0)

					break
				end
			end
		end
	end

	return
end

function CommanderManualPage:RemoveDoingGetTaskIndex(arg_8_1)
	table.remove(self.doingGetTaskIndexes, arg_8_1)

	return
end

function CommanderManualPage:IsComplete()
	for iter_9_0, iter_9_1 in ipairs(self.taskIdList) do
		if not table.contains(self.finishedTaskIds, iter_9_1) then
			return false
		end
	end

	if self.award < #self:getConfig("target") then
		return false
	end

	return true
end

function CommanderManualPage:GetLockTip()
	if not self.leftUnlockTaskIds or #self.leftUnlockTaskIds == 0 then
		return ""
	end

	return pg.task_data_template[self.leftUnlockTaskIds[1]].desc
end

function CommanderManualPage:GetTaskLockTip(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.taskIds) do
		if table.contains(iter_11_1, arg_11_1) and #self.unlockTaskIds[iter_11_0] > 0 then
			return pg.task_data_template[self.unlockTaskIds[iter_11_0][1]].desc
		end
	end

	return ""
end

function CommanderManualPage:IsTaskComplete(arg_12_1)
	return table.contains(self.finishedTaskIds, arg_12_1)
end

function CommanderManualPage:GetCurrentPtTarget()
	local var_13_0 = self:getConfig("target")

	if self.award == #var_13_0 then
		return var_13_0[self.award]
	else
		return var_13_0[self.award + 1]
	end

	return
end

function CommanderManualPage:GetCurrentPtAward()
	local var_14_0 = self:getConfig("drop_client")

	if self.award == #var_14_0 then
		return var_14_0[self.award]
	else
		return var_14_0[self.award + 1]
	end

	return
end

function CommanderManualPage:SortTaskIdList()
	local var_15_0 = getProxy(TaskProxy)

	table.sort(self.taskIdList, CompareFuncs({
		function(arg_16_0)
			if var_15_0:getTaskById(arg_16_0) then
				return 1
			elseif self:IsTaskComplete(arg_16_0) then
				return 2
			else
				return 3
			end

			return
		end,
		function(arg_17_0)
			local var_17_0 = var_15_0:getTaskById(arg_17_0)

			if var_17_0 then
				return -var_17_0:getTaskStatus()
			else
				return 0
			end

			return
		end,
		function(arg_18_0)
			return table.indexof(self.initTaskIdList, arg_18_0)
		end
	}))

	return
end

function CommanderManualPage:ShouldShowTip()
	for iter_19_0, iter_19_1 in ipairs(self.taskIdList) do
		local var_19_0 = getProxy(TaskProxy):getTaskById(iter_19_1)

		if var_19_0 and var_19_0:getTaskStatus() == 1 then
			return true
		end
	end

	if self.pt >= self:GetCurrentPtTarget() and self.award < #self:getConfig("target") then
		return true
	end

	return false
end

return CommanderManualPage

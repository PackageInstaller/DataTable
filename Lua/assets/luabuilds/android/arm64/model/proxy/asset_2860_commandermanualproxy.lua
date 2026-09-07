local CommanderManualProxy = class("CommanderManualProxy", import(".NetProxy"))

CommanderManualProxy.GET_TASK = 1
CommanderManualProxy.GET_PT_AWARD = 2
CommanderManualProxy.TOP_PAGE_TASK = 100
CommanderManualProxy.TOP_PAGE_GUIDE = 200
CommanderManualProxy.TOP_PAGE_TECH = 900

function CommanderManualProxy:register()
	self:on(22300, function(arg_2_0)
		self.commanderManualPages = {}
		self.topFinishedTaskIds = arg_2_0.finished_task_ids or {}

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.handbooks) do
			var_2_0[iter_2_1.id] = iter_2_1
		end

		for iter_2_2, iter_2_3 in ipairs(pg.tutorial_handbook_task.all) do
			table.insert(self.commanderManualPages, var_2_0[iter_2_3] and CommanderManualPage.New(var_2_0[iter_2_3], self.topFinishedTaskIds, true) or CommanderManualPage.New({
				pt = 0,
				award = 0,
				id = iter_2_3,
				finished_task_ids = {}
			}, self.topFinishedTaskIds, false))
		end

		return
	end)

	return
end

function CommanderManualProxy:GetPagesByType(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.commanderManualPages) do
		if iter_3_1:getConfig("type") == arg_3_1 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function CommanderManualProxy:GetPageById(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.commanderManualPages) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function CommanderManualProxy:AddPagePt(arg_5_1)
	local var_5_0 = self:GetPageById(arg_5_1)

	if var_5_0 then
		var_5_0:AddPt()
	end

	return
end

function CommanderManualProxy:AddPageAward(arg_6_1)
	local var_6_0 = self:GetPageById(arg_6_1)

	if var_6_0 then
		var_6_0:AddAward()
	end

	return
end

function CommanderManualProxy:TaskAutoSubmitCall(arg_7_1)
	self:UnlockTaskSubmitCall(arg_7_1)
	self:ShowTaskSubmitCall(arg_7_1)

	return
end

function CommanderManualProxy:UnlockTaskSubmitCall(arg_8_1)
	local var_8_0 = false

	for iter_8_0, iter_8_1 in ipairs(pg.tutorial_handbook.all) do
		if table.contains(pg.tutorial_handbook[iter_8_1].unlock_param, arg_8_1) then
			table.insert(self.topFinishedTaskIds, arg_8_1)

			var_8_0 = true

			break
		end
	end

	for iter_8_2, iter_8_3 in ipairs(self.commanderManualPages) do
		if table.contains(iter_8_3.leftUnlockTaskIds, arg_8_1) then
			iter_8_3:AddFinishedTaskId(arg_8_1)

			var_8_0 = true
		end

		for iter_8_4, iter_8_5 in ipairs(iter_8_3.unlockTaskIds) do
			if table.contains(iter_8_5, arg_8_1) then
				iter_8_3:AddFinishedTaskId(arg_8_1)

				var_8_0 = true

				break
			end
		end
	end

	if var_8_0 then
		for iter_8_6, iter_8_7 in ipairs(self.commanderManualPages) do
			iter_8_7:ChangeUnlock(self.topFinishedTaskIds)
			iter_8_7:GetTasks()
		end
	end

	return
end

function CommanderManualProxy:GetPagesTasks()
	for iter_9_0, iter_9_1 in ipairs(self.commanderManualPages) do
		iter_9_1:GetTasks()
	end

	return
end

function CommanderManualProxy:ShowTaskSubmitCall(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.commanderManualPages) do
		if table.contains(iter_10_1.taskIdList, arg_10_1) and not iter_10_1:IsTaskComplete(arg_10_1) then
			iter_10_1:AddFinishedTaskId(arg_10_1)
			iter_10_1:AddPt()

			break
		end
	end

	return
end

function CommanderManualProxy:AddPageTaskDone(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.commanderManualPages) do
		local var_11_0 = 0

		for iter_11_2, iter_11_3 in ipairs(iter_11_1.taskIds) do
			if table.contains(iter_11_3, arg_11_1.id) then
				var_11_0 = iter_11_2

				break
			end
		end

		if var_11_0 ~= 0 then
			self:sendNotification(GAME.COMMANDER_MANUAL_OP_DONE, {
				operation = CommanderManualProxy.GET_TASK,
				pageId = iter_11_1.id,
				index = var_11_0
			})

			break
		end
	end

	return
end

function CommanderManualProxy:IsTopUnlock(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(pg.tutorial_handbook[arg_12_1].unlock_param) do
		if not table.contains(self.topFinishedTaskIds, iter_12_1) then
			return false
		end
	end

	return true
end

function CommanderManualProxy:GetLockTip(arg_13_1)
	return pg.tutorial_handbook[arg_13_1].lock_hint
end

function CommanderManualProxy:ShouldShowTipByType(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs((self:GetPagesByType(arg_14_1))) do
		if iter_14_1:ShouldShowTip() then
			return true
		end
	end

	return false
end

function CommanderManualProxy:ShouldShowTaskOrGuideTip()
	return self:ShouldShowTipByType(1) or self:ShouldShowTipByType(2)
end

function CommanderManualProxy:IsTopPageComplete(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs((self:GetPagesByType(arg_16_1))) do
		if not iter_16_1:IsComplete() then
			return false
		end
	end

	return true
end

function CommanderManualProxy:TaskProgressAdd(arg_17_1, arg_17_2)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(pg.task_data_template.all) do
		if pg.task_data_template[iter_17_1].type == Task.TYPE_COMMANDER_MANUAL and pg.task_data_template[iter_17_1].sub_type == arg_17_1 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		local var_17_1 = getProxy(TaskProxy):getTaskById(iter_17_3)

		if var_17_1 and var_17_1:getTaskStatus() == 0 then
			self:sendNotification(GAME.MINI_GAME_TASK_PROGRESS_UPDATE, {
				taskId = iter_17_3,
				progressAdd = arg_17_2
			})
		end
	end

	return
end

return CommanderManualProxy

local CommanderManualMediator = class("CommanderManualMediator", import("..base.ContextMediator"))

CommanderManualMediator.ON_TASK_GO = "CommanderManualMediator.ON_TASK_GO"
CommanderManualMediator.ON_TASK_SUBMIT = "CommanderManualMediator.ON_TASK_SUBMIT"
CommanderManualMediator.GET_PT_AWARD = "CommanderManualMediator.GET_PT_AWARD"
CommanderManualMediator.ON_TRIGGER = "CommanderManualMediator.ON_TRIGGER"
CommanderManualMediator.ON_UPDATE = "CommanderManualMediator.ON_UPDATE"

function CommanderManualMediator:register()
	self:bind(CommanderManualMediator.ON_TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(CommanderManualMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.SUBMIT_TASK, {
			normal_submit = true,
			virtual = false,
			taskId = arg_3_1.id
		}, arg_3_2)

		return
	end)
	self:bind(CommanderManualMediator.GET_PT_AWARD, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.COMMANDER_MANUAL_OP, {
			operation = CommanderManualProxy.GET_PT_AWARD,
			pageId = arg_4_1
		})

		return
	end)
	self:bind(CommanderManualMediator.ON_TRIGGER, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_5_1)

		return
	end)
	self:bind(CommanderManualMediator.ON_UPDATE, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
			taskId = arg_6_1.id
		})

		return
	end)

	return
end

function CommanderManualMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_DONE,
		GAME.COMMANDER_MANUAL_OP_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function CommanderManualMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.SUBMIT_TASK_DONE then
		if #var_8_1 > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
		end

		if self.viewComponent.contextData.currentPageId then
			local var_8_2 = getProxy(CommanderManualProxy):GetPageById(self.viewComponent.contextData.currentPageId)

			if table.contains(var_8_2.taskIdList, arg_8_1:getType()[1]) and not var_8_2:IsTaskComplete(arg_8_1:getType()[1]) then
				var_8_2:AddFinishedTaskId(arg_8_1:getType()[1])
				var_8_2:AddPt()
			end
		end

		self.viewComponent:RefreshAll()
	elseif var_8_0 == GAME.COMMANDER_MANUAL_OP_DONE then
		if var_8_1.operation == CommanderManualProxy.GET_TASK then
			-- block empty
		elseif var_8_1.operation == CommanderManualProxy.GET_PT_AWARD then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		end

		self.viewComponent:RefreshAll()
	elseif var_8_0 == ActivityProxy.ACTIVITY_OPERATION_DONE and var_8_1 == self.viewComponent.techActivity.id then
		self.viewComponent:UpdateTechActivity()

		if isActive(self.viewComponent.techPage) then
			self.viewComponent:ShowTechPage()
		end
	end

	return
end

return CommanderManualMediator

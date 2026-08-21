local var_0_0 = class("CommanderManualMediator", import("..base.ContextMediator"))

var_0_0.ON_TASK_GO = "CommanderManualMediator.ON_TASK_GO"
var_0_0.ON_TASK_SUBMIT = "CommanderManualMediator.ON_TASK_SUBMIT"
var_0_0.GET_PT_AWARD = "CommanderManualMediator.GET_PT_AWARD"
var_0_0.ON_TRIGGER = "CommanderManualMediator.ON_TRIGGER"
var_0_0.ON_UPDATE = "CommanderManualMediator.ON_UPDATE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, {
			normal_submit = true,
			virtual = false,
			taskId = arg_3_1.id
		}, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_0.GET_PT_AWARD, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.COMMANDER_MANUAL_OP, {
			operation = CommanderManualProxy.GET_PT_AWARD,
			pageId = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TRIGGER, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPDATE, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
			taskId = arg_6_1.id
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.SUBMIT_TASK_DONE,
		GAME.COMMANDER_MANUAL_OP_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()
	local var_8_2 = arg_8_1:getType()

	if var_8_0 == GAME.SUBMIT_TASK_DONE then
		if #var_8_1 > 0 then
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
		end

		if arg_8_0.viewComponent.contextData.currentPageId then
			local var_8_3 = getProxy(CommanderManualProxy):GetPageById(arg_8_0.viewComponent.contextData.currentPageId)

			if table.contains(var_8_3.taskIdList, var_8_2[1]) and not var_8_3:IsTaskComplete(var_8_2[1]) then
				var_8_3:AddFinishedTaskId(var_8_2[1])
				var_8_3:AddPt()
			end
		end

		arg_8_0.viewComponent:RefreshAll()
	elseif var_8_0 == GAME.COMMANDER_MANUAL_OP_DONE then
		if var_8_1.operation == CommanderManualProxy.GET_TASK then
			-- block empty
		elseif var_8_1.operation == CommanderManualProxy.GET_PT_AWARD then
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		end

		arg_8_0.viewComponent:RefreshAll()
	elseif var_8_0 == ActivityProxy.ACTIVITY_OPERATION_DONE and var_8_1 == arg_8_0.viewComponent.techActivity.id then
		arg_8_0.viewComponent:UpdateTechActivity()

		if isActive(arg_8_0.viewComponent.techPage) then
			arg_8_0.viewComponent:ShowTechPage()
		end
	end

	return
end

return var_0_0

local var_0_0 = class("MedalCollectionTemplateMediator", import("view.base.ContextMediator"))

var_0_0.MEMORYBOOK_UNLOCK = "MEMORYBOOK_UNLOCK"
var_0_0.MEMORYBOOK_GO = "MEMORYBOOK_GO"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()
	arg_1_0.viewComponent:UpdateActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.MEMORYBOOK_UNLOCK, function(arg_3_0, ...)
		arg_2_0:sendNotification(GAME.MEMORYBOOK_UNLOCK, ...)

		return
	end)
	arg_2_0:bind(var_0_0.MEMORYBOOK_GO, function(arg_4_0, arg_4_1)
		arg_2_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		ActivityProxy.ACTIVITY_ADDED,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_ADDED or var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_6_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PUZZLA then
			arg_6_0.viewComponent:UpdateActivity(var_6_1)
		end
	elseif var_6_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		arg_6_0.viewComponent:UpdateActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
		arg_6_0.viewComponent:UpdateAfterSubmit(var_6_1)
	elseif var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		local var_6_2 = getProxy(ActivityProxy):getActivityById(var_6_1)

		if var_6_2:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PUZZLA then
			arg_6_0.viewComponent:UpdateActivity(var_6_2)
			arg_6_0.viewComponent:UpdateAfterFinalMedal()
		end
	elseif var_6_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getContextByMediator(ActivityMediator) then
			return
		end

		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, var_6_1.callback)
	end

	return
end

return var_0_0

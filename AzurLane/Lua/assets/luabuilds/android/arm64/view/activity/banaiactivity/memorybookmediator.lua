local var_0_0 = class("MemoryBookMediator", import("...base.ContextMediator"))

var_0_0.ON_UNLOCK = "MemoryBookMediator:ON_UNLOCK"
var_0_0.EVENT_OPERATION = "MemoryBookMediator:EVENT_OPERATION"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_UNLOCK, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
			id = arg_2_1,
			actId = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_OPERATION, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		arg_5_0.viewComponent:updateMemorys()
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1.id == arg_5_0.viewComponent.activity.id then
			arg_5_0.viewComponent:setActivity(var_5_1)
			arg_5_0.viewComponent:updateProgress()
		end
	elseif var_5_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getCurrentContext().mediator == ActivityMediator then
			return
		end

		arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, var_5_1.callback)
	end

	return
end

return var_0_0

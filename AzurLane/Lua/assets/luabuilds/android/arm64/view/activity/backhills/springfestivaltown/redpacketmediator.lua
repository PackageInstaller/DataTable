local var_0_0 = class("RedPacketMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS then
		arg_3_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_3_1.awards, var_3_1.callback)
	elseif var_3_0 == ActivityProxy.ACTIVITY_UPDATED and var_3_1.id == arg_3_0.viewComponent.activityID then
		arg_3_0.viewComponent:onSubmitFinished()
	end

	return
end

return var_0_0

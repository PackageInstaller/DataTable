local var_0_0 = class("BeachPacketMediator", import("view.base.ContextMediator"))

function var_0_0.listNotificationInterests(arg_1_0)
	return {
		ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getName()
	local var_2_1 = arg_2_1:getBody()

	if var_2_0 == ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS then
		arg_2_0.viewComponent:playAni(function()
			arg_2_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_2_1.awards, var_2_1.callback)

			return
		end)
	elseif var_2_0 == ActivityProxy.ACTIVITY_UPDATED and arg_2_1:getBody().id == arg_2_0.viewComponent.activityID then
		arg_2_0.viewComponent:onSubmitFinished()
	end

	return
end

return var_0_0

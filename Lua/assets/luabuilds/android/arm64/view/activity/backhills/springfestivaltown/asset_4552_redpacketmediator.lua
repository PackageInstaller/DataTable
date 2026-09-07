local RedPacketMediator = class("RedPacketMediator", import("view.base.ContextMediator"))

function RedPacketMediator:register()
	return
end

function RedPacketMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function RedPacketMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_3_1.awards, var_3_1.callback)
	elseif var_3_0 == ActivityProxy.ACTIVITY_UPDATED and var_3_1.id == self.viewComponent.activityID then
		self.viewComponent:onSubmitFinished()
	end

	return
end

return RedPacketMediator

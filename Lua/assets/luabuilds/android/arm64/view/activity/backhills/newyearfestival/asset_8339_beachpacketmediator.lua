local BeachPacketMediator = class("BeachPacketMediator", import("view.base.ContextMediator"))

function BeachPacketMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function BeachPacketMediator:handleNotification(arg_2_1)
	local var_2_0 = arg_2_1:getName()
	local var_2_1 = arg_2_1:getBody()

	if var_2_0 == ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS then
		self.viewComponent:playAni(function()
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_2_1.awards, var_2_1.callback)

			return
		end)
	elseif var_2_0 == ActivityProxy.ACTIVITY_UPDATED and var_2_1.id == self.viewComponent.activityID then
		self.viewComponent:onSubmitFinished()
	end

	return
end

return BeachPacketMediator

local LinkLinkMediator = class("LinkLinkMediator", import("..base.ContextMediator"))

LinkLinkMediator.EVENT_OPERATION = "event operation"

function LinkLinkMediator:register()
	self:bind(LinkLinkMediator.EVENT_OPERATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_2_1)

		return
	end)
	self:SetActivityData()
	self:SetPlayerData()

	return
end

function LinkLinkMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function LinkLinkMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == PlayerProxy.UPDATED then
		self.viewComponent:SetPlayer(var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	elseif var_4_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		local var_4_2 = getProxy(ActivityProxy):getActivityById(var_4_1)

		if var_4_2:getConfig("type") == ActivityConst.ACTIVITY_TYPE_LINK_LINK then
			self.viewComponent:DisplayResult(var_4_2)
		end
	end

	return
end

function LinkLinkMediator:SetPlayerData()
	self.viewComponent:SetPlayer((getProxy(PlayerProxy):getRawData()))

	return
end

function LinkLinkMediator:SetActivityData()
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINK_LINK)))

	return
end

return LinkLinkMediator

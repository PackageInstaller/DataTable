local FireworkPanelMediator = class("FireworkPanelMediator", import("view.base.ContextMediator"))

FireworkPanelMediator.LET_OFF_FIREWORKS = "LET_OFF_FIREWORKS"

function FireworkPanelMediator:register()
	self:bind(FireworkPanelMediator.LET_OFF_FIREWORKS, function(arg_2_0, arg_2_1)
		self:sendNotification(SpringFestival2023Mediator.PLAY_FIREWORKS, arg_2_1)
		self.viewComponent:closeView()

		return
	end)

	return
end

function FireworkPanelMediator:listNotificationInterests()
	return {}
end

function FireworkPanelMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return FireworkPanelMediator

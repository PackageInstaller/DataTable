local var_0_0 = class("FireworkPanelMediator", import("view.base.ContextMediator"))

var_0_0.LET_OFF_FIREWORKS = "LET_OFF_FIREWORKS"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.LET_OFF_FIREWORKS, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(SpringFestival2023Mediator.PLAY_FIREWORKS, arg_2_1)
		arg_1_0.viewComponent:closeView()

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0

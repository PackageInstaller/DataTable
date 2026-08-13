class = var_0_10000

local var_0_0 = "FireworkPanelMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.LET_OFF_FIREWORKS = "LET_OFF_FIREWORKS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.LET_OFF_FIREWORKS, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		SpringFestival2023Mediator = var_2_10004

		var_2_1(var_2_0, var_2_10004.PLAY_FIREWORKS, arg_2_1)

		local var_2_2 = arg_1_0.viewComponent

		var_2.closeView(var_2_2)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1

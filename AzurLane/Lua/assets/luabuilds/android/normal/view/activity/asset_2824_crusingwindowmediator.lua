class = var_0_10000

local var_0_0 = "CrusingWindowMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GO_CRUSING = "CrusingWindowMediator.GO_CRUSING"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_CRUSING, function(arg_2_0)
		arg_1_0.contextData.onClose = nil

		local var_2_0 = arg_1_0.viewComponent

		var_1.closeView(var_2_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_2_10003

		local var_2_3 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_2_2(var_2_1, var_2_3, var_2_10004.CRUSING)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.remove(arg_4_0)
	if arg_4_0.contextData.onClose then
		arg_4_0.contextData.onClose()
	end

	return
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_1

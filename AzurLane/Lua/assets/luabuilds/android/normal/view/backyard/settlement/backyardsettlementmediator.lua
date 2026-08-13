class = var_0_10000

local var_0_0 = "BackYardSettlementMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	DormProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = arg_1_0.viewComponent

	var_2.setShipVOs(var_1_1, arg_1_0.contextData.oldShips, arg_1_0.contextData.newShips)

	local var_1_2 = arg_1_0.viewComponent

	var_2.setDormVO(var_1_2, var_1_0:getRawData())

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_1.handleNotification(arg_3_0)
	return
end

return var_0_1

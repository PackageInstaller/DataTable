class = var_0_10000

local var_0_0 = "ShipPreviewMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	assert = var_1_10001

	var_1_10001(arg_1_0.contextData.shipVO, "shipVO is nil")

	assert = var_1_10001

	var_1_10001(arg_1_0.contextData.weaponIds, "weaponIds is nil")

	assert = var_1_10001

	var_1_10001(arg_1_0.contextData.equipSkinId, "equipment skin id is nil")

	local var_1_0 = arg_1_0.viewComponent

	var_1.setShip(var_1_0, arg_1_0.contextData.shipVO, arg_1_0.contextData.weaponIds, arg_1_0.contextData.equipSkinId)

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return var_0_1

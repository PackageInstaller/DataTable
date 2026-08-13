class = var_0_10000

local var_0_0 = "SkinAtlasMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.OPEN_INDEX = "SkinAtlasMediator:OPEN_INDEX"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_INDEX, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		SkinAtlasIndexLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		var_2_3.data = arg_2_1

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	SetShipSkinCommand = var_1_10002
	var_3_0[1] = var_1_10002.SKIN_UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	SetShipSkinCommand = var_4_1

	if var_4_0 == var_4_1.SKIN_UPDATED then
		local var_4_3 = arg_4_0.viewComponent

		var_4.UpdateSkinCards(var_4_3)
	end

	return
end

return var_0_1

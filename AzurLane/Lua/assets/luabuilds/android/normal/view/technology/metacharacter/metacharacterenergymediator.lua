class = var_0_10000

local var_0_0 = "MetaCharacterEnergyMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_ACTIVATION = "MetaCharacterEnergyMediator:ON_ACTIVATION"
var_0_1.ON_PREVIEW = "MetaCharacterEnergyMediator:ON_PREVIEW"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_ACTIVATION, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.ENERGY_META_ACTIVATION, {
			shipId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_PREVIEW, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = {
			equipSkinId = 0,
			shipVO = arg_3_1,
			weaponIds = arg_3_2
		}
		local var_3_1 = arg_1_0
		local var_3_2 = var_4.addSubLayers

		Context = var_2_10006

		local var_3_3 = var_2_10006.New
		local var_3_4 = {}

		ShipPreviewLayer = var_2_10008
		var_3_4.viewComponent = var_2_10008
		ShipPreviewMediator = var_2_10008
		var_3_4.mediator = var_2_10008
		var_3_4.data = var_3_0

		var_3_2(var_3_1, var_3_3(var_3_4))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.ENERGY_META_ACTIVATION_DONE
	BayProxy = var_2
	var_4_0[2] = var_2.SHIP_UPDATED
	BagProxy = var_2
	var_4_0[3] = var_2.ITEM_UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	if var_5_0 == var_5_1.ENERGY_META_ACTIVATION_DONE then
		local var_5_3 = arg_5_0
		local var_5_4 = arg_5_0.addSubLayers

		Context = var_1_10006

		local var_5_5 = var_1_10006.New
		local var_5_6 = {}

		ShipBreakResultLayer = var_1_10008
		var_5_6.viewComponent = var_1_10008
		ShipBreakResultMediator = var_1_10008
		var_5_6.mediator = var_1_10008
		var_5_6.data = {
			newShip = var_5_2.newShip,
			oldShip = var_5_2.oldShip
		}

		var_5_4(var_5_3, var_5_5(var_5_6))

		local var_5_7 = arg_5_0.viewComponent

		var_4.updateData(var_5_7)

		local var_5_8 = arg_5_0.viewComponent

		var_4.updateNamePanel(var_5_8)

		local var_5_9 = arg_5_0.viewComponent

		var_4.updateAttrPanel(var_5_9)

		local var_5_10 = arg_5_0.viewComponent

		var_4.updateMaterialPanel(var_5_10)

		local var_5_11 = arg_5_0.viewComponent

		var_4.initPreviewPanel(var_5_11)
	end

	return
end

return var_0_1

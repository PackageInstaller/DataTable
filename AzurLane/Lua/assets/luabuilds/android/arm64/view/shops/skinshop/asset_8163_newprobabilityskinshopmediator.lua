class = var_0_10000

local var_0_0 = "NewProbabilitySkinShopMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewSkinShopMediator"))

var_0_1.OPEN_CHARGE_BIRTHDAY = "NewProbabilitySkinShopMediator:OPEN_CHARGE_BIRTHDAY"
var_0_1.CHARGE = "NewProbabilitySkinShopMediator:CHARGE"
var_0_1.OPEN_CHARGE_ITEM_PANEL = "NewProbabilitySkinShopMediator:OPEN_CHARGE_ITEM_PANEL"

function var_0_1.register(arg_1_0)
	var_0_1.super.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_BIRTHDAY, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		ChargeBirthdayMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		ChargeBirthdayLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = {}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.CHARGE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.CHARGE_OPERATION, {
			shopId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_PANEL, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		ChargeItemPanelMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		ChargeItemPanelLayer = var_2_10008
		var_4_3.viewComponent = var_2_10008
		var_4_3.data = {
			panelConfig = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = var_0_1.super.listNotificationInterests(arg_5_0)

	table = var_1_10002

	local var_5_1 = var_1_10002.insert
	local var_5_2 = var_5_0

	GAME = var_1_10005

	var_5_1(var_5_2, var_1_10005.CHARGE_SUCCESS)

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	var_0_1.super.handleNotification(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.CHARGE_SUCCESS then
		local var_6_3 = arg_6_0.viewComponent

		var_4.OnChargeSuccess(var_6_3, var_6_2.shopId)
	end

	return
end

return var_0_1

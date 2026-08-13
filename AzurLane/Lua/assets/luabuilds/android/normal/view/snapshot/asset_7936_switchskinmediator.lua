class = var_0_10000

local var_0_0 = "SwitchSkinMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.CHANGE_SKIN = "SwitchSkinMediator:CHANGE_SKIN"
var_0_1.BUY_ITEM = "SwitchSkinMediator:BUY_ITEM"
var_0_1.UPDATE_SKINCONFIG = "SwitchSkinMediator:UPDATE_SKINCONFIG"
var_0_1.BUY_ITEM_BY_ACT = "SwitchSkinMediator:BUY_ITEM_BY_ACT"

function var_0_1.register(arg_1_0)
	arg_1_0.shipVO = arg_1_0.contextData.shipVO

	if arg_1_0.shipVO then
		local var_1_0 = arg_1_0.viewComponent

		var_1.setShip(var_1_0, arg_1_0.shipVO)

		getProxy = var_1
		ShipSkinProxy = var_1_0

		local var_1_1 = var_1(var_1_0)
		local var_1_2 = var_1.getSkinList(var_1_1)
		local var_1_3 = arg_1_0.viewComponent

		var_3.setSkinList(var_1_3, var_1_2)
	end

	arg_1_0:bind(var_0_1.BUY_ITEM_BY_ACT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SKIN_COUPON_SHOPPING, {
			shopId = arg_2_1,
			cnt = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_SKIN, function(arg_3_0, arg_3_1, arg_3_2)
		ShipPhantom = var_2_10003

		local var_3_0, var_3_1 = var_2_10003.UnpackMark(arg_3_1)
		local var_3_2 = arg_1_0
		local var_3_3 = var_5.sendNotification

		GAME = var_2_10007

		var_3_3(var_3_2, var_2_10007.SET_SHIP_SKIN, {
			shipId = var_3_0,
			phantomId = var_3_1,
			skinId = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.BUY_ITEM, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SKIN_SHOPPIGN, {
			id = arg_4_1,
			count = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_SKINCONFIG, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.UPDATE_SKINCONFIG, {
			skinId = arg_5_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	ShipSkinProxy = var_1_10002
	var_6_0[1] = var_1_10002.SHIP_SKINS_UPDATE
	GAME = var_2
	var_6_0[2] = var_2.SKIN_SHOPPIGN_DONE
	GAME = var_2
	var_6_0[3] = var_2.SKIN_COUPON_SHOPPING_DONE
	GAME = var_2
	var_6_0[4] = var_2.CHANGE_SKIN_UPDATE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.getBody(var_7_1)

	GAME = var_7_1

	if var_7_0 ~= var_7_1.SKIN_SHOPPIGN_DONE then
		GAME = var_4

		if var_7_0 == var_4.SKIN_COUPON_SHOPPING_DONE then
			pg = var_4

			if var_4.shop_template[var_7_2.id] then
				var_1_10005 = var_4.genre
				ShopArgs = var_1_10006

				if var_1_10005 == var_1_10006.SkinShop then
					local var_7_3 = arg_7_0

					var_1_10005 = arg_7_0.addSubLayers
					Context = var_1_10007

					local var_7_4 = var_1_10007.New
					local var_7_5 = {}

					NewSkinMediator = var_1_10009
					var_7_5.mediator = var_1_10009
					NewSkinLayer = var_1_10009
					var_7_5.viewComponent = var_1_10009
					var_7_5.data = {
						skinId = var_4.effect_args[1]
					}

					var_1_10005(var_7_3, var_7_4(var_7_5))
				end
			end
		else
			ShipSkinProxy = var_4

			if var_7_0 == var_4.SHIP_SKINS_UPDATE then
				getProxy = var_4
				ShipSkinProxy = var_1_10005

				local var_7_6 = var_4(var_1_10005)
				local var_7_7 = var_4.getSkinList(var_7_6)
				local var_7_8 = arg_7_0.viewComponent

				var_6.setSkinList(var_7_8, var_7_7)

				local var_7_9 = arg_7_0.viewComponent

				var_6.openSelectSkinPanel(var_7_9)
			else
				GAME = var_4

				if var_7_0 == var_4.CHANGE_SKIN_UPDATE then
					local var_7_10 = arg_7_0.viewComponent

					var_4.setShip(var_7_10, arg_7_0.contextData.shipVO)

					getProxy = var_4
					ShipSkinProxy = var_7_10

					local var_7_11 = var_4(var_7_10)
					local var_7_12 = var_4.getSkinList(var_7_11)
					local var_7_13 = arg_7_0.viewComponent

					var_6.setSkinList(var_7_13, var_7_12)

					local var_7_14 = arg_7_0.viewComponent

					var_6.openSelectSkinPanel(var_7_14)
				end
			end
		end

		return
	end
end

return var_0_1

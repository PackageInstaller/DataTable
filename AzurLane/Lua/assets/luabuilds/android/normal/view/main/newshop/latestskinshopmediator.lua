class = var_0_10000

local var_0_0 = "LatestSkinShopMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_RECORD_ANIM_PREVIEW_BTN = "LatestSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN"
var_0_1.OPEN_ACTIVITY = "LatestSkinShopMediator.OPEN_ACTIVITY"
var_0_1.ON_SHOPPING_BY_ACT = "LatestSkinShopMediator.ON_SHOPPING_BY_ACT"
var_0_1.ON_SHOPPING = "LatestSkinShopMediator.ON_SHOPPING"
var_0_1.ON_ITEM_PURCHASE = "LatestSkinShopMediator.ON_ITEM_PURCHASE"
var_0_1.GO_SHOPS_LAYER = "LatestSkinShopMediator.GO_SHOPS_LAYER"
var_0_1.OPEN_SCENE = "LatestSkinShopMediator.OPEN_SCENE"
var_0_1.ON_BACKYARD_SHOP = "LatestSkinShopMediator.ON_BACKYARD_SHOP"
var_0_1.ON_ITEM_EXPERIENCE = "LatestSkinShopMediator.ON_ITEM_EXPERIENCE"
var_0_1.OPEN_OWN_SKIN_LAYER = "LatestSkinShopMediator.OPEN_OWN_SKIN_LAYER"
var_0_1.OPEN_GIFT_PACK_LAYER = "LatestSkinShopMediator.OPEN_GIFT_PACK_LAYER"
var_0_1.OPEN_CHARGE_BIRTHDAY = "LatestSkinShopMediator:OPEN_CHARGE_BIRTHDAY"
var_0_1.CHARGE = "LatestSkinShopMediator:CHARGE"
var_0_1.OPEN_CHARGE_ITEM_PANEL = "LatestSkinShopMediator:OPEN_CHARGE_ITEM_PANEL"
var_0_1.OPEN_CHARGE_ITEM_BOX = "LatestSkinShopMediator:OPEN_CHARGE_ITEM_BOX"
var_0_1.BUY_ITEM = "LatestSkinShopMediator:BUY_ITEM"
var_0_1.OPEN_GIFT_ACT_LAYER = "LatestSkinShopMediator.OPEN_GIFT_ACT_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_RECORD_ANIM_PREVIEW_BTN, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.RECORD_SKIN_ANIM_PREVIEW, {
			isOpen = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ACTIVITY, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_3_1(var_3_0, var_3_2, var_2_10005.ACTIVITY, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING_BY_ACT, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SKIN_COUPON_SHOPPING, {
			shopId = arg_4_1,
			cnt = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.SKIN_SHOPPIGN, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ITEM_PURCHASE, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.USE_ITEM, {
			count = 1,
			id = arg_6_1,
			arg = {
				arg_6_2
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_SHOPS_LAYER, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_7_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_7_3 = var_2_10005.SHOP
		local var_7_4 = {}

		NewShopsScene = var_2_10007
		var_7_4.warp = var_2_10007.TYPE_ACTIVITY
		var_7_4.actId = arg_7_1

		var_7_1(var_7_0, var_7_2, var_7_3, var_7_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SCENE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10004

		var_8_1(var_8_0, var_2_10004.GO_SCENE, arg_8_1[1], arg_8_1[2])

		return
	end)
	arg_1_0:bind(var_0_1.ON_BACKYARD_SHOP, function(arg_9_0)
		local var_9_0 = arg_1_0
		local var_9_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_9_2 = var_2_10003.New
		local var_9_3 = {}

		NewBackYardShopMediator = var_2_10005
		var_9_3.mediator = var_2_10005
		NewBackYardShopLayer = var_2_10005
		var_9_3.viewComponent = var_2_10005
		var_9_3.data = {
			topLayer = true,
			page = 5
		}

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_ITEM_EXPERIENCE, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = arg_1_0
		local var_10_1 = var_4.sendNotification

		GAME = var_2_10006

		var_10_1(var_10_0, var_2_10006.USE_ITEM, {
			id = arg_10_1,
			count = arg_10_3,
			arg = {
				arg_10_2
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_OWN_SKIN_LAYER, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = arg_1_0
		local var_11_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_11_2 = var_2_10006.New
		local var_11_3 = {}

		NewSkinAtlasLayer = var_2_10008
		var_11_3.viewComponent = var_2_10008
		NewSkinAtlasMediator = var_2_10008
		var_11_3.mediator = var_2_10008

		var_11_1(var_11_0, var_11_2(var_11_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_GIFT_PACK_LAYER, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = arg_1_0
		local var_12_1 = var_4.sendNotification

		GAME = var_2_10006

		local var_12_2 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		var_12_1(var_12_0, var_12_2, var_2_10007.PROBABILITY_SKINSHOP, {
			giftPackCommodity = arg_12_1,
			skinCommodities = arg_12_2,
			skinProbabilitys = arg_12_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_BIRTHDAY, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0
		local var_13_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_13_2 = var_2_10004.New
		local var_13_3 = {}

		ChargeBirthdayMediator = var_2_10006
		var_13_3.mediator = var_2_10006
		ChargeBirthdayLayer = var_2_10006
		var_13_3.viewComponent = var_2_10006
		var_13_3.data = {}

		var_13_1(var_13_0, var_13_2(var_13_3))

		return
	end)
	arg_1_0:bind(var_0_1.CHARGE, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_1_0
		local var_14_1 = var_2.sendNotification

		GAME = var_2_10004

		var_14_1(var_14_0, var_2_10004.CHARGE_OPERATION, {
			shopId = arg_14_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_PANEL, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_15_2 = var_2_10004.New
		local var_15_3 = {}

		ChargeItemPanelMediator = var_2_10006
		var_15_3.mediator = var_2_10006
		ChargeItemPanelLayer = var_2_10006
		var_15_3.viewComponent = var_2_10006
		var_15_3.data = {
			panelConfig = arg_15_1
		}

		var_15_1(var_15_0, var_15_2(var_15_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_BOX, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_1_0
		local var_16_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_16_2 = var_2_10004.New
		local var_16_3 = {}

		ChargeItemBoxMediator = var_2_10006
		var_16_3.mediator = var_2_10006
		ChargeItemBoxLayer = var_2_10006
		var_16_3.viewComponent = var_2_10006
		var_16_3.data = {
			panelConfig = arg_16_1
		}

		var_16_1(var_16_0, var_16_2(var_16_3))

		return
	end)
	arg_1_0:bind(var_0_1.BUY_ITEM, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_1_0
		local var_17_1 = var_3.sendNotification

		GAME = var_2_10005

		var_17_1(var_17_0, var_2_10005.SHOPPING, {
			id = arg_17_1,
			count = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_GIFT_ACT_LAYER, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_1_0
		local var_18_1 = var_2.sendNotification

		NewShopMainMediator = var_2_10004

		local var_18_2 = var_2_10004.ON_SUBLAYER_EVENT
		local var_18_3 = {}

		NewShopMainMediator = var_2_10006
		var_18_3[1] = var_2_10006.OPEN_GIFT_ACT_LAYER
		var_18_3[2] = arg_18_1

		var_18_1(var_18_0, var_18_2, var_18_3)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_19_0)
	local var_19_0 = {}

	NewShopMainScene = var_1_10002
	var_19_0[var_1_10002.CLOSE_ALL_LAYER] = function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0.viewComponent

		var_2.closeView(var_20_0)

		return
	end
	PlayerProxy = var_2
	var_19_0[var_2.UPDATED] = function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_0.viewComponent

		var_2.SetResource(var_21_0)

		return
	end
	GAME = var_2
	var_19_0[var_2.SKIN_SHOPPIGN_DONE] = function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_1
		local var_22_1 = arg_22_1.getBody(var_22_0)

		pg = var_22_0

		if var_22_0.shop_template[var_22_1.id] then
			local var_22_2 = var_3.genre

			ShopArgs = var_2_10005

			if var_22_2 ~= var_2_10005.SkinShop then
				local var_22_3 = var_3.genre

				ShopArgs = var_5

				if var_22_3 == var_5.SkinShopTimeLimit then
					local var_22_4 = var_3.effect_args[1]

					pg = var_5

					local var_22_5 = var_5.ship_skin_template[var_22_4].skin_type

					ShipSkin = var_2_10006

					local var_22_6

					if var_22_5 == var_2_10006.SKIN_TYPE_TB then
						var_22_6 = arg_22_0

						local var_22_7 = arg_22_0.addSubLayers

						Context = var_2_10007

						local var_22_8 = var_2_10007.New

						var_2_10008 = {}
						NewSkinTBMediator = var_2_10009
						var_2_10008.mediator = var_2_10009
						NewSkinTBLayer = var_2_10009
						var_2_10008.viewComponent = var_2_10009

						local var_22_9 = {
							skinId = var_3.effect_args[1]
						}

						var_2_10010 = var_3.genre
						ShopArgs = var_2_10011
						var_2_10010 = var_2_10010 == var_2_10011.SkinShopTimeLimit
						var_22_9.timeLimit = var_2_10010
						var_2_10008.data = var_22_9

						var_22_7(var_22_6, var_22_8(var_2_10008))
					else
						local function var_22_10()
							local var_23_0 = arg_22_0
							local var_23_1 = var_0.addSubLayers

							Context = var_3_10002

							local var_23_2 = var_3_10002.New
							local var_23_3 = {}

							NewSkinMediator = var_3_10004
							var_23_3.mediator = var_3_10004
							NewSkinLayer = var_3_10004
							var_23_3.viewComponent = var_3_10004

							local var_23_4 = {
								skinId = var_0.effect_args[1]
							}
							local var_23_5 = var_0.genre

							ShopArgs = var_3_10006
							var_23_4.timeLimit = var_23_5 == var_3_10006.SkinShopTimeLimit
							var_23_3.data = var_23_4

							var_23_1(var_23_0, var_23_2(var_23_3))

							return
						end

						PaintingShowScene = var_22_6

						if var_22_6.GetSkinShowAble(var_22_4) then
							local var_22_11 = arg_22_0
							local var_22_12 = arg_22_0.addSubLayers

							Context = var_2_10008

							local var_22_13 = var_2_10008.New
							local var_22_14 = {}

							PaintingShowMediator = var_2_10010
							var_22_14.mediator = var_2_10010
							PaintingShowScene = var_2_10010
							var_22_14.viewComponent = var_2_10010
							var_22_14.data = {
								is_shop = true,
								skinId = var_22_4,
								callback = var_22_10
							}

							var_22_12(var_22_11, var_22_13(var_22_14))
						else
							var_22_10()
						end
					end

					local var_22_15 = arg_22_0.viewComponent

					var_5.OnShopping(var_22_15, var_22_1.id)

					pg = var_5

					local var_22_16 = var_5.EasyRedDotMgr.GetInstance()

					var_5.TriggerMarks(var_22_16, "specialShop")
				end

				return
			end
		end
	end
	GAME = var_2

	local var_19_1 = var_2.SKIN_COUPON_SHOPPING_DONE

	GAME = var_3
	var_19_0[var_19_1] = var_3.SKIN_SHOPPIGN_DONE
	GAME = var_19_1
	var_19_0[var_19_1.BUY_FURNITURE_DONE] = function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_1:getType()
		local var_24_1 = arg_24_0.viewComponent

		var_3.OnFurnitureUpdate(var_24_1, var_24_0[1])

		return
	end
	NewShopMainMediator = var_2
	var_19_0[var_2.NOTI_UPDATE_CURRENT] = function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0.viewComponent

		var_2.GetAllCommodities(var_25_0)

		local var_25_1 = arg_25_0.viewComponent

		var_2.Refresh(var_25_1, true)

		return
	end
	GAME = var_2
	var_19_0[var_2.CHARGE_OPERATION_DONE] = function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0.viewComponent

		var_2.closeView(var_26_0)

		return
	end
	arg_19_0.handleDic = var_19_0

	return
end

return var_0_1

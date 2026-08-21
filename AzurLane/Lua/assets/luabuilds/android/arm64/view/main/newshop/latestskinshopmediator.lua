local var_0_0 = class("LatestSkinShopMediator", import("...base.ContextMediator"))

var_0_0.ON_RECORD_ANIM_PREVIEW_BTN = "LatestSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN"
var_0_0.OPEN_ACTIVITY = "LatestSkinShopMediator.OPEN_ACTIVITY"
var_0_0.ON_SHOPPING_BY_ACT = "LatestSkinShopMediator.ON_SHOPPING_BY_ACT"
var_0_0.ON_SHOPPING = "LatestSkinShopMediator.ON_SHOPPING"
var_0_0.ON_ITEM_PURCHASE = "LatestSkinShopMediator.ON_ITEM_PURCHASE"
var_0_0.GO_SHOPS_LAYER = "LatestSkinShopMediator.GO_SHOPS_LAYER"
var_0_0.OPEN_SCENE = "LatestSkinShopMediator.OPEN_SCENE"
var_0_0.ON_BACKYARD_SHOP = "LatestSkinShopMediator.ON_BACKYARD_SHOP"
var_0_0.ON_ITEM_EXPERIENCE = "LatestSkinShopMediator.ON_ITEM_EXPERIENCE"
var_0_0.OPEN_OWN_SKIN_LAYER = "LatestSkinShopMediator.OPEN_OWN_SKIN_LAYER"
var_0_0.OPEN_GIFT_PACK_LAYER = "LatestSkinShopMediator.OPEN_GIFT_PACK_LAYER"
var_0_0.OPEN_CHARGE_BIRTHDAY = "LatestSkinShopMediator:OPEN_CHARGE_BIRTHDAY"
var_0_0.CHARGE = "LatestSkinShopMediator:CHARGE"
var_0_0.OPEN_CHARGE_ITEM_PANEL = "LatestSkinShopMediator:OPEN_CHARGE_ITEM_PANEL"
var_0_0.OPEN_CHARGE_ITEM_BOX = "LatestSkinShopMediator:OPEN_CHARGE_ITEM_BOX"
var_0_0.BUY_ITEM = "LatestSkinShopMediator:BUY_ITEM"
var_0_0.OPEN_GIFT_ACT_LAYER = "LatestSkinShopMediator.OPEN_GIFT_ACT_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_RECORD_ANIM_PREVIEW_BTN, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.RECORD_SKIN_ANIM_PREVIEW, {
			isOpen = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ACTIVITY, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHOPPING_BY_ACT, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.SKIN_COUPON_SHOPPING, {
			shopId = arg_4_1,
			cnt = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHOPPING, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.SKIN_SHOPPIGN, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ITEM_PURCHASE, function(arg_6_0, arg_6_1, arg_6_2)
		arg_1_0:sendNotification(GAME.USE_ITEM, {
			count = 1,
			id = arg_6_1,
			arg = {
				arg_6_2
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SHOPS_LAYER, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SCENE, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_8_1[1], arg_8_1[2])

		return
	end)
	arg_1_0:bind(var_0_0.ON_BACKYARD_SHOP, function(arg_9_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewBackYardShopMediator,
			viewComponent = NewBackYardShopLayer,
			data = {
				topLayer = true,
				page = 5
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_ITEM_EXPERIENCE, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		arg_1_0:sendNotification(GAME.USE_ITEM, {
			id = arg_10_1,
			count = arg_10_3,
			arg = {
				arg_10_2
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_OWN_SKIN_LAYER, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = NewSkinAtlasLayer,
			mediator = NewSkinAtlasMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_GIFT_PACK_LAYER, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.PROBABILITY_SKINSHOP, {
			giftPackCommodity = arg_12_1,
			skinCommodities = arg_12_2,
			skinProbabilitys = arg_12_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_BIRTHDAY, function(arg_13_0, arg_13_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CHARGE, function(arg_14_0, arg_14_1)
		arg_1_0:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_14_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_PANEL, function(arg_15_0, arg_15_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_15_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_BOX, function(arg_16_0, arg_16_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemBoxMediator,
			viewComponent = ChargeItemBoxLayer,
			data = {
				panelConfig = arg_16_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.BUY_ITEM, function(arg_17_0, arg_17_1, arg_17_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_17_1,
			count = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_GIFT_ACT_LAYER, function(arg_18_0, arg_18_1)
		arg_1_0:sendNotification(NewShopMainMediator.ON_SUBLAYER_EVENT, {
			NewShopMainMediator.OPEN_GIFT_ACT_LAYER,
			arg_18_1
		})

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_19_0)
	arg_19_0.handleDic = {
		[NewShopMainScene.CLOSE_ALL_LAYER] = function(arg_20_0, arg_20_1)
			arg_20_0.viewComponent:closeView()

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_21_0, arg_21_1)
			arg_21_0.viewComponent:SetResource()

			return
		end,
		[GAME.SKIN_SHOPPIGN_DONE] = function(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_1:getBody()
			local var_22_1 = pg.shop_template[var_22_0.id]

			if pg.shop_template[var_22_0.id] and (var_22_1.genre == ShopArgs.SkinShop or var_22_1.genre == ShopArgs.SkinShopTimeLimit) then
				local var_22_2 = var_22_1.effect_args[1]

				if pg.ship_skin_template[var_22_1.effect_args[1]].skin_type == ShipSkin.SKIN_TYPE_TB then
					arg_22_0:addSubLayers(Context.New({
						mediator = NewSkinTBMediator,
						viewComponent = NewSkinTBLayer,
						data = {
							skinId = var_22_1.effect_args[1],
							timeLimit = var_22_1.genre == ShopArgs.SkinShopTimeLimit
						}
					}))
				elseif PaintingShowScene.GetSkinShowAble(var_22_2) then
					arg_22_0:addSubLayers(Context.New({
						mediator = PaintingShowMediator,
						viewComponent = PaintingShowNewSkinScene,
						data = {
							is_shop = true,
							skinId = var_22_2,
							timeLimit = var_22_1.genre == ShopArgs.SkinShopTimeLimit
						}
					}))
				else
					arg_22_0:addSubLayers(Context.New({
						mediator = NewSkinMediator,
						viewComponent = NewSkinLayer,
						data = {
							skinId = var_22_1.effect_args[1],
							timeLimit = var_22_1.genre == ShopArgs.SkinShopTimeLimit
						}
					}))
				end

				arg_22_0.viewComponent:OnShopping(var_22_0.id)
				pg.EasyRedDotMgr.GetInstance():TriggerMarks("specialShop")
			end

			return
		end,
		[GAME.SKIN_COUPON_SHOPPING_DONE] = GAME.SKIN_SHOPPIGN_DONE,
		[GAME.BUY_FURNITURE_DONE] = function(arg_23_0, arg_23_1)
			arg_23_0.viewComponent:OnFurnitureUpdate(arg_23_1:getType()[1])

			return
		end,
		[NewShopMainMediator.NOTI_UPDATE_CURRENT] = function(arg_24_0, arg_24_1)
			arg_24_0.viewComponent:GetAllCommodities()
			arg_24_0.viewComponent:Refresh(true)

			return
		end,
		[GAME.CHARGE_OPERATION_DONE] = function(arg_25_0, arg_25_1)
			arg_25_0.viewComponent:closeView()

			return
		end
	}

	return
end

return var_0_0

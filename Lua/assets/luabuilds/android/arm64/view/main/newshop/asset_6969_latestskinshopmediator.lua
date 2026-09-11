local LatestSkinShopMediator = class("LatestSkinShopMediator", import("...base.ContextMediator"))

LatestSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN = "LatestSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN"
LatestSkinShopMediator.OPEN_ACTIVITY = "LatestSkinShopMediator.OPEN_ACTIVITY"
LatestSkinShopMediator.ON_SHOPPING_BY_ACT = "LatestSkinShopMediator.ON_SHOPPING_BY_ACT"
LatestSkinShopMediator.ON_SHOPPING = "LatestSkinShopMediator.ON_SHOPPING"
LatestSkinShopMediator.ON_ITEM_PURCHASE = "LatestSkinShopMediator.ON_ITEM_PURCHASE"
LatestSkinShopMediator.GO_SHOPS_LAYER = "LatestSkinShopMediator.GO_SHOPS_LAYER"
LatestSkinShopMediator.OPEN_SCENE = "LatestSkinShopMediator.OPEN_SCENE"
LatestSkinShopMediator.ON_BACKYARD_SHOP = "LatestSkinShopMediator.ON_BACKYARD_SHOP"
LatestSkinShopMediator.ON_ITEM_EXPERIENCE = "LatestSkinShopMediator.ON_ITEM_EXPERIENCE"
LatestSkinShopMediator.OPEN_OWN_SKIN_LAYER = "LatestSkinShopMediator.OPEN_OWN_SKIN_LAYER"
LatestSkinShopMediator.OPEN_GIFT_PACK_LAYER = "LatestSkinShopMediator.OPEN_GIFT_PACK_LAYER"
LatestSkinShopMediator.OPEN_CHARGE_BIRTHDAY = "LatestSkinShopMediator:OPEN_CHARGE_BIRTHDAY"
LatestSkinShopMediator.CHARGE = "LatestSkinShopMediator:CHARGE"
LatestSkinShopMediator.OPEN_CHARGE_ITEM_PANEL = "LatestSkinShopMediator:OPEN_CHARGE_ITEM_PANEL"
LatestSkinShopMediator.OPEN_CHARGE_ITEM_BOX = "LatestSkinShopMediator:OPEN_CHARGE_ITEM_BOX"
LatestSkinShopMediator.BUY_ITEM = "LatestSkinShopMediator:BUY_ITEM"
LatestSkinShopMediator.OPEN_GIFT_ACT_LAYER = "LatestSkinShopMediator.OPEN_GIFT_ACT_LAYER"

function LatestSkinShopMediator:register()
	self:bind(LatestSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.RECORD_SKIN_ANIM_PREVIEW, {
			isOpen = arg_2_1
		})

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_ACTIVITY, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_3_1
		})

		return
	end)
	self:bind(LatestSkinShopMediator.ON_SHOPPING_BY_ACT, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.SKIN_COUPON_SHOPPING, {
			shopId = arg_4_1,
			cnt = arg_4_2
		})

		return
	end)
	self:bind(LatestSkinShopMediator.ON_SHOPPING, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.SKIN_SHOPPIGN, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	self:bind(LatestSkinShopMediator.ON_ITEM_PURCHASE, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.USE_ITEM, {
			count = 1,
			id = arg_6_1,
			arg = {
				arg_6_2
			}
		})

		return
	end)
	self:bind(LatestSkinShopMediator.GO_SHOPS_LAYER, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = arg_7_1
		})

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_SCENE, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.GO_SCENE, arg_8_1[1], arg_8_1[2])

		return
	end)
	self:bind(LatestSkinShopMediator.ON_BACKYARD_SHOP, function(arg_9_0)
		self:addSubLayers(Context.New({
			mediator = NewBackYardShopMediator,
			viewComponent = NewBackYardShopLayer,
			data = {
				topLayer = true,
				page = 5
			}
		}))

		return
	end)
	self:bind(LatestSkinShopMediator.ON_ITEM_EXPERIENCE, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_10_1,
			count = arg_10_3,
			arg = {
				arg_10_2
			}
		})

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_OWN_SKIN_LAYER, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		self:addSubLayers(Context.New({
			viewComponent = NewSkinAtlasLayer,
			mediator = NewSkinAtlasMediator
		}))

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_GIFT_PACK_LAYER, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		self:sendNotification(GAME.GO_SCENE, SCENE.PROBABILITY_SKINSHOP, {
			giftPackCommodity = arg_12_1,
			skinCommodities = arg_12_2,
			skinProbabilitys = arg_12_3
		})

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_CHARGE_BIRTHDAY, function(arg_13_0, arg_13_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	self:bind(LatestSkinShopMediator.CHARGE, function(arg_14_0, arg_14_1)
		self:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_14_1
		})

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_CHARGE_ITEM_PANEL, function(arg_15_0, arg_15_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_15_1
			}
		}))

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_CHARGE_ITEM_BOX, function(arg_16_0, arg_16_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemBoxMediator,
			viewComponent = ChargeItemBoxLayer,
			data = {
				panelConfig = arg_16_1
			}
		}))

		return
	end)
	self:bind(LatestSkinShopMediator.BUY_ITEM, function(arg_17_0, arg_17_1, arg_17_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_17_1,
			count = arg_17_2
		})

		return
	end)
	self:bind(LatestSkinShopMediator.OPEN_GIFT_ACT_LAYER, function(arg_18_0, arg_18_1)
		self:sendNotification(NewShopMainMediator.ON_SUBLAYER_EVENT, {
			NewShopMainMediator.OPEN_GIFT_ACT_LAYER,
			arg_18_1
		})

		return
	end)

	return
end

function LatestSkinShopMediator:initNotificationHandleDic()
	self.handleDic = {
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
			local var_22_1 = ShopConst.GetShopConfig(var_22_0.id)

			if var_22_1 then
				if var_22_1.genre ~= ShopArgs.SkinShop then
					if var_22_1.genre == ShopArgs.SkinShopTimeLimit then
						arg_22_0:HandleNewSkin(var_22_0.id, var_22_1.effect_args[1], var_22_1.genre == ShopArgs.SkinShopTimeLimit)
					end
				end
			end

			return
		end,
		[GAME.SKIN_BY_CHARGE_DONE] = function(arg_23_0, arg_23_1)
			local var_23_0 = arg_23_1:getBody()
			local var_23_1 = 0

			for iter_23_0, iter_23_1 in ipairs(arg_23_0.viewComponent.commodities or {}) do
				if var_23_0.skinId == iter_23_1:getSkinId() then
					var_23_1 = iter_23_1.id

					break
				end
			end

			print(var_23_0.skinId, var_23_1)

			if var_23_1 > 0 then
				arg_23_0:HandleNewSkin(var_23_1, var_23_0.skinId, false)
			end

			return
		end,
		[GAME.SKIN_COUPON_SHOPPING_DONE] = GAME.SKIN_SHOPPIGN_DONE,
		[GAME.BUY_FURNITURE_DONE] = function(arg_24_0, arg_24_1)
			arg_24_0.viewComponent:OnFurnitureUpdate(arg_24_1:getType()[1])

			return
		end,
		[NewShopMainMediator.NOTI_UPDATE_CURRENT] = function(arg_25_0, arg_25_1)
			arg_25_0.viewComponent:GetAllCommodities()
			arg_25_0.viewComponent:Refresh(true)

			return
		end,
		[GAME.CHARGE_OPERATION_DONE] = function(arg_26_0, arg_26_1)
			if not getProxy(ShopsProxy):IsSkinTypeCharge(arg_26_1:getBody().shopId) then
				arg_26_0.viewComponent:closeView()
			end

			return
		end
	}

	return
end

function LatestSkinShopMediator:HandleNewSkin(arg_27_1, arg_27_2, arg_27_3)
	if pg.ship_skin_template[arg_27_2].skin_type == ShipSkin.SKIN_TYPE_TB then
		self:addSubLayers(Context.New({
			mediator = NewSkinTBMediator,
			viewComponent = NewSkinTBLayer,
			data = {
				skinId = arg_27_2,
				timeLimit = arg_27_3
			}
		}))
	elseif PaintingShowScene.GetSkinShowAble(arg_27_2) then
		self:addSubLayers(Context.New({
			mediator = PaintingShowMediator,
			viewComponent = PaintingShowNewSkinScene,
			data = {
				is_shop = true,
				skinId = arg_27_2,
				timeLimit = arg_27_3
			}
		}))
	else
		self:addSubLayers(Context.New({
			mediator = NewSkinMediator,
			viewComponent = NewSkinLayer,
			data = {
				skinId = arg_27_2,
				timeLimit = arg_27_3
			}
		}))
	end

	self.viewComponent:OnShopping(arg_27_1)
	pg.EasyRedDotMgr.GetInstance():TriggerMarks("specialShop")

	return
end

return LatestSkinShopMediator

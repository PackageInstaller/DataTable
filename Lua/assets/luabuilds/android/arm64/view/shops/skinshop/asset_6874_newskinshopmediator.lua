local NewSkinShopMediator = class("NewSkinShopMediator", import("view.base.ContextMediator"))

NewSkinShopMediator.ON_ATLAS = "NewSkinShopMediator:ON_ATLAS"
NewSkinShopMediator.ON_INDEX = "NewSkinShopMediator:ON_INDEX"
NewSkinShopMediator.ON_BACKYARD_SHOP = "NewSkinShopMediator:ON_BACKYARD_SHOP"
NewSkinShopMediator.GO_SHOPS_LAYER = "NewSkinShopMediator:GO_SHOPS_LAYER"
NewSkinShopMediator.OPEN_SCENE = "NewSkinShopMediator:OPEN_SCENE"
NewSkinShopMediator.OPEN_ACTIVITY = "NewSkinShopMediator:OPEN_ACTIVITY"
NewSkinShopMediator.ON_SHOPPING_BY_ACT = "NewSkinShopMediator:ON_SHOPPING_BY_ACT"
NewSkinShopMediator.ON_SHOPPING = "NewSkinShopMediator:ON_SHOPPING"
NewSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN = "NewSkinShopMediator:ON_RECORD_ANIM_PREVIEW_BTN"
NewSkinShopMediator.ON_ITEM_PURCHASE = "NewSkinShopMediator:ON_ITEM_PURCHASE"
NewSkinShopMediator.ON_ITEM_EXPERIENCE = "NewSkinShopMediator:ON_ITEM_EXPERIENCE"

function NewSkinShopMediator:register()
	self:bind(NewSkinShopMediator.ON_ITEM_EXPERIENCE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_3,
			arg = {
				arg_2_2
			}
		})

		return
	end)
	self:bind(NewSkinShopMediator.ON_ITEM_PURCHASE, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.USE_ITEM, {
			count = 1,
			id = arg_3_1,
			arg = {
				arg_3_2
			}
		})

		return
	end)
	self:bind(NewSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.RECORD_SKIN_ANIM_PREVIEW, {
			isOpen = arg_4_1
		})

		return
	end)
	self:bind(NewSkinShopMediator.ON_SHOPPING, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.SKIN_SHOPPIGN, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	self:bind(NewSkinShopMediator.ON_SHOPPING_BY_ACT, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.SKIN_COUPON_SHOPPING, {
			shopId = arg_6_1,
			cnt = arg_6_2
		})

		return
	end)
	self:bind(NewSkinShopMediator.OPEN_ACTIVITY, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_7_1
		})

		return
	end)
	self:bind(NewSkinShopMediator.GO_SHOPS_LAYER, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = arg_8_1
		})

		return
	end)
	self:bind(NewSkinShopMediator.OPEN_SCENE, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.GO_SCENE, arg_9_1[1], arg_9_1[2])

		return
	end)
	self:bind(NewSkinShopMediator.ON_BACKYARD_SHOP, function(arg_10_0)
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
	self:bind(NewSkinShopMediator.ON_ATLAS, function(arg_11_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.SKINATALAS)

		return
	end)
	self:bind(NewSkinShopMediator.ON_INDEX, function(arg_12_0, arg_12_1)
		self:addSubLayers(Context.New({
			viewComponent = SkinIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_12_1
		}))

		return
	end)

	return
end

function NewSkinShopMediator:listNotificationInterests()
	return {
		GAME.SKIN_SHOPPIGN_DONE,
		GAME.SKIN_COUPON_SHOPPING_DONE,
		GAME.BUY_FURNITURE_DONE,
		GAME.LOAD_LAYERS,
		GAME.REMOVE_LAYERS
	}
end

function NewSkinShopMediator:handleNotification(arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1:getBody()

	if var_14_0 == GAME.SKIN_SHOPPIGN_DONE or var_14_0 == GAME.SKIN_COUPON_SHOPPING_DONE then
		local var_14_2 = pg.shop_template[var_14_1.id]

		if pg.shop_template[var_14_1.id] and (var_14_2.genre == ShopArgs.SkinShop or var_14_2.genre == ShopArgs.SkinShopTimeLimit) then
			local var_14_3 = var_14_2.effect_args[1]

			if pg.ship_skin_template[var_14_2.effect_args[1]].skin_type == ShipSkin.SKIN_TYPE_TB then
				self:addSubLayers(Context.New({
					mediator = NewSkinTBMediator,
					viewComponent = NewSkinTBLayer,
					data = {
						skinId = var_14_2.effect_args[1],
						timeLimit = var_14_2.genre == ShopArgs.SkinShopTimeLimit
					}
				}))
			elseif PaintingShowScene.GetSkinShowAble(var_14_3) then
				self:addSubLayers(Context.New({
					mediator = PaintingShowMediator,
					viewComponent = PaintingShowNewSkinScene,
					data = {
						is_shop = true,
						skinId = var_14_3,
						timeLimit = var_14_2.genre == ShopArgs.SkinShopTimeLimit
					}
				}))
			else
				self:addSubLayers(Context.New({
					mediator = NewSkinMediator,
					viewComponent = NewSkinLayer,
					data = {
						skinId = var_14_2.effect_args[1],
						timeLimit = var_14_2.genre == ShopArgs.SkinShopTimeLimit
					}
				}))
			end

			self.viewComponent:OnShopping(var_14_1.id)
		end
	elseif var_14_0 == GAME.BUY_FURNITURE_DONE then
		self.viewComponent:OnFurnitureUpdate(arg_14_1:getType()[1])
	elseif var_14_0 == GAME.LOAD_LAYERS then
		if var_14_1.context.mediator == NewBackYardShopMediator then
			self:sendNotification(PlayerResUI.HIDE)
		end
	elseif var_14_0 == GAME.REMOVE_LAYERS and var_14_1.context.mediator == NewBackYardShopMediator then
		self:sendNotification(PlayerResUI.SHOW)
	end

	return
end

return NewSkinShopMediator

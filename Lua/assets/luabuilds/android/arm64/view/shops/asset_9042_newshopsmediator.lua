local NewShopsMediator = class("NewShopsMediator", import("..base.ContextMediator"))

NewShopsMediator.FAST_BUILD_ITEM_ID = 61004
NewShopsMediator.ON_SHOPPING = "NewShopsMediator:ON_SHOPPING"
NewShopsMediator.REFRESH_STREET_SHOP = "NewShopsMediator:REFRESH_STREET_SHOP"
NewShopsMediator.REFRESH_MILITARY_SHOP = "NewShopsMediator:REFRESH_MILITARY_SHOP"
NewShopsMediator.ON_SHAM_SHOPPING = "NewShopsMediator:ON_SHAM_SHOPPING"
NewShopsMediator.ON_FRAGMENT_SHOPPING = "NewShopsMediator:ON_FRAGMENT_SHOPPING"
NewShopsMediator.ON_ACT_SHOPPING = "NewShopsMediator:ON_ACT_SHOPPING"
NewShopsMediator.SELL_BLUEPRINT = "NewShopsMediator:SELL_BLUEPRINT"
NewShopsMediator.GO_MALL = "NewShopsMediator:GO_MALL"
NewShopsMediator.ON_SKIN_SHOP = "NewShopsMediator:ON_SKIN_SHOP"
NewShopsMediator.SET_PLAYER_FLAG = "NewShopsMediator:SET_PLAYER_FLAG"
NewShopsMediator.ON_GUILD_SHOPPING = "NewShopsMediator:ON_GUILD_SHOPPING"
NewShopsMediator.ON_MEDAL_SHOPPING = "NewShopsMediator:ON_MEDAL_SHOPPING"
NewShopsMediator.REFRESH_GUILD_SHOP = "NewShopsMediator:REFRESH_GUILD_SHOP"
NewShopsMediator.REFRESH_MEDAL_SHOP = "NewShopsMediator:REFRESH_MEDAL_SHOP"
NewShopsMediator.ON_GUILD_PURCHASE = "NewShopsMediator:ON_GUILD_PURCHASE"
NewShopsMediator.ON_META_SHOP = "NewShopsMediator:ON_META_SHOP"
NewShopsMediator.ON_ESKIN_PREVIEW = "NewShopsMediator:ON_ESKIN_PREVIEW"
NewShopsMediator.ON_QUOTA_SHOPPING = "NewShopsMediator:ON_QUOTA_SHOPPING"
NewShopsMediator.ON_MINI_GAME_SHOP_BUY = "NewShopsMediator:ON_MINI_GAME_SHOP_BUY"
NewShopsMediator.ON_MINI_GAME_SHOP_FLUSH = "NewShopsMediator:ON_MINI_GAME_SHOP_FLUSH"
NewShopsMediator.MINI_GAME_SHOP_BUY_DONE = "NewShopsMediator:MINI_GAME_SHOP_BUY_DONE"
NewShopsMediator.UR_EXCHANGE_TRACKING = "NewShopsMediator:UR_EXCHANGE_TRACKING"

function NewShopsMediator:register()
	self:bind(NewShopsMediator.ON_META_SHOP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		self:sendNotification(GAME.ON_META_SHOPPING, {
			activity_id = arg_2_1,
			cmd = arg_2_2,
			arg1 = arg_2_3,
			arg2 = arg_2_4,
			kvargs1 = arg_2_5
		})

		return
	end)
	self:bind(NewShopsMediator.ON_GUILD_SHOPPING, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.ON_GUILD_SHOP_PURCHASE, {
			goodsId = arg_3_1,
			selectedId = arg_3_2
		})

		return
	end)
	self:bind(NewShopsMediator.ON_MINI_GAME_SHOP_BUY, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.MINI_GAME_SHOP_BUY, arg_4_1)

		return
	end)
	self:bind(NewShopsMediator.ON_MINI_GAME_SHOP_FLUSH, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.MINI_GAME_SHOP_FLUSH, arg_5_1)

		return
	end)
	self:bind(NewShopsMediator.ON_MEDAL_SHOPPING, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.ON_MEDAL_SHOP_PURCHASE, {
			goodsId = arg_6_1,
			selectedId = arg_6_2
		})

		return
	end)
	self:bind(NewShopsMediator.REFRESH_GUILD_SHOP, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GET_GUILD_SHOP, {
			type = (arg_7_1 or nil) and (GuildConst.MANUAL_REFRESH or GuildConst.AUTO_REFRESH)
		})

		return
	end)
	self:bind(NewShopsMediator.REFRESH_MEDAL_SHOP, function(arg_8_0)
		self:sendNotification(GAME.GET_MEDALSHOP, {})

		return
	end)
	self:bind(NewShopsMediator.ON_SKIN_SHOP, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:bind(NewShopsMediator.GO_MALL, function(arg_10_0, arg_10_1)
		if self.contextData.fromMediatorName == NewShopMainMediator.__cname then
			local var_10_0 = getProxy(ContextProxy):getContextByMediator(NewShopMainMediator)

			self.viewComponent:closeView()
		else
			pg.m02:sendNotification(GAME.CHANGE_SCENE, SCENE.CHARGE, {
				wrap = arg_10_1
			})
		end

		return
	end)
	self:bind(NewShopsMediator.SELL_BLUEPRINT, function(arg_11_0, arg_11_1)
		self:sendNotification(GAME.FRAG_SELL, arg_11_1)

		return
	end)
	self:bind(NewShopsMediator.ON_ACT_SHOPPING, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = arg_12_1,
			cmd = arg_12_2,
			arg1 = arg_12_3,
			arg2 = arg_12_4
		})

		return
	end)
	self:bind(NewShopsMediator.ON_FRAGMENT_SHOPPING, function(arg_13_0, arg_13_1, arg_13_2)
		self:sendNotification(GAME.FRAG_SHOPPING, {
			id = arg_13_1,
			count = arg_13_2
		})

		return
	end)
	self:bind(NewShopsMediator.ON_SHAM_SHOPPING, function(arg_14_0, arg_14_1, arg_14_2)
		self:sendNotification(GAME.SHAM_SHOPPING, {
			id = arg_14_1,
			count = arg_14_2
		})

		return
	end)
	self:bind(NewShopsMediator.ON_SHOPPING, function(arg_15_0, arg_15_1, arg_15_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_15_1,
			count = arg_15_2
		})

		return
	end)
	self:bind(NewShopsMediator.REFRESH_MILITARY_SHOP, function(arg_16_0, arg_16_1)
		if not arg_16_1 then
			self:sendNotification(GAME.GET_MILITARY_SHOP)
		else
			self:sendNotification(GAME.REFRESH_MILITARY_SHOP)
		end

		return
	end)
	self:bind(NewShopsMediator.REFRESH_STREET_SHOP, function(arg_17_0, arg_17_1)
		if not arg_17_1 then
			self:sendNotification(GAME.GET_SHOPSTREET)
		else
			self:sendNotification(GAME.SHOPPING, {
				count = 1,
				id = arg_17_1
			})
		end

		return
	end)
	self:bind(NewShopsMediator.SET_PLAYER_FLAG, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_2 then
			self:sendNotification(GAME.COMMON_FLAG, {
				flagID = arg_18_1
			})
		else
			self:sendNotification(GAME.CANCEL_COMMON_FLAG, {
				flagID = arg_18_1
			})
		end

		return
	end)
	self:bind(NewShopsMediator.ON_ESKIN_PREVIEW, function(arg_19_0, arg_19_1)
		local var_19_0 = Ship.New({
			id = pg.equip_skin_template[arg_19_1].ship_config_id,
			configId = pg.equip_skin_template[arg_19_1].ship_config_id,
			skin_id = pg.equip_skin_template[arg_19_1].ship_skin_id
		})
		local var_19_1 = {}

		var_19_1 = pg.equip_skin_template[arg_19_1].ship_skin_id ~= 0 and {
			equipSkinId = 0,
			shipVO = var_19_0,
			weaponIds = {}
		} or {
			shipVO = var_19_0,
			weaponIds = Clone(pg.equip_skin_template[arg_19_1].weapon_ids),
			equipSkinId = arg_19_1
		}

		self:addSubLayers(Context.New({
			viewComponent = ShipPreviewLayer,
			mediator = ShipPreviewMediator,
			data = var_19_1
		}))

		return
	end)
	self:bind(NewShopsMediator.UR_EXCHANGE_TRACKING, function(arg_20_0, arg_20_1)
		local var_20_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_UR_EXCHANGE)

		if var_20_0 and not var_20_0:isEnd() then
			if getProxy(ShopsProxy):getActivityShopById(var_20_0:getConfig("config_client").shopId):GetCommodityById(var_20_0:getConfig("config_client").goodsId[1]):getConfig("commodity_id") == arg_20_1 then
				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrRedeem(arg_20_1, 1))
			end
		end

		return
	end)
	self.viewComponent:SetShops(self.contextData.shops)
	self:bind(NewShopsMediator.ON_QUOTA_SHOPPING, function(arg_21_0, arg_21_1, arg_21_2)
		self:sendNotification(GAME.QUOTA_SHOPPING, {
			id = arg_21_1,
			count = arg_21_2
		})

		return
	end)
	self.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())
	self.viewComponent:OnUpdateItems(getProxy(BagProxy):getRawData())

	return
end

function NewShopsMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE,
		ShopsProxy.SHOPPINGSTREET_UPDATE,
		ShopsProxy.MERITOROUS_SHOP_UPDATED,
		ShopsProxy.SHAM_SHOP_UPDATED,
		GAME.SHAM_SHOPPING_DONE,
		BagProxy.ITEM_UPDATED,
		GAME.FRAG_SHOPPING_DONE,
		ShopsProxy.FRAGMENT_SHOP_UPDATED,
		ShopsProxy.ACTIVITY_SHOP_GOODS_UPDATED,
		ShopsProxy.ACTIVITY_SHOP_UPDATED,
		GAME.FRAG_SELL_DONE,
		ActivityProxy.ACTIVITY_SHOP_SHOW_AWARDS,
		GAME.USE_ITEM_DONE,
		GAME.ON_GUILD_SHOP_PURCHASE_DONE,
		GAME.ON_MEDAL_SHOP_PURCHASE_DONE,
		ShopsProxy.GUILD_SHOP_UPDATED,
		ShopsProxy.MEDAL_SHOP_UPDATED,
		GAME.ON_META_SHOPPING_DONE,
		ShopsProxy.META_SHOP_GOODS_UPDATED,
		ShopsProxy.QUOTA_SHOP_UPDATED,
		GAME.QUOTA_SHOPPING_DONE,
		GAME.MINI_GAME_SHOP_BUY_DONE
	}
end

function NewShopsMediator:handleNotification(arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1:getBody()

	if var_23_0 == PlayerProxy.UPDATED then
		self.viewComponent:SetPlayer(var_23_1)
	elseif var_23_0 == ShopsProxy.SHOPPINGSTREET_UPDATE then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_SHOP_STREET, var_23_1.shopStreet)
	elseif var_23_0 == GAME.SHOPPING_DONE then
		if var_23_1.shopType == ShopArgs.ShopStreet then
			local var_23_3 = getProxy(ShopsProxy):getShopStreet()
			local var_23_4 = var_23_3:getGoodsById(var_23_1.id)

			self.viewComponent:OnUpdateCommodity(NewShopsScene.TYPE_SHOP_STREET, var_23_3, var_23_1.id)
		elseif var_23_1.shopType == ShopArgs.MilitaryShop then
			self.viewComponent:OnUpdateCommodity(NewShopsScene.TYPE_MILITARY_SHOP, getProxy(ShopsProxy):getMeritorousShop(), var_23_1.id)
		end

		if var_23_1.awards and #var_23_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)
		end
	elseif var_23_0 == ShopsProxy.MERITOROUS_SHOP_UPDATED then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_MILITARY_SHOP, var_23_1)
	elseif var_23_0 == ShopsProxy.SHAM_SHOP_UPDATED then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_SHAM_SHOP, var_23_1)
	elseif var_23_0 == GAME.SHAM_SHOPPING_DONE then
		self.viewComponent:OnUpdateCommodity(NewShopsScene.TYPE_SHAM_SHOP, getProxy(ShopsProxy):getShamShop(), var_23_1.id)
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)
	elseif var_23_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:OnUpdateItems((getProxy(BagProxy):getRawData()))
	elseif var_23_0 == GAME.FRAG_SHOPPING_DONE then
		self.viewComponent:OnUpdateCommodity(NewShopsScene.TYPE_FRAGMENT, getProxy(ShopsProxy):getFragmentShop(), var_23_1.id)
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)
	elseif var_23_0 == ShopsProxy.FRAGMENT_SHOP_UPDATED then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_FRAGMENT, var_23_1)
	elseif var_23_0 == ShopsProxy.ACTIVITY_SHOP_GOODS_UPDATED then
		self.viewComponent:OnUpdateCommodity(NewShopsScene.TYPE_ACTIVITY, getProxy(ShopsProxy):getActivityShopById(var_23_1.activityId), var_23_1.goodsId)
	elseif var_23_0 == ShopsProxy.META_SHOP_GOODS_UPDATED then
		self.viewComponent:OnUpdateCommodity(NewShopsScene.TYPE_META, getProxy(ShopsProxy):GetMetaShop(), var_23_1.goodsId)
	elseif var_23_0 == ShopsProxy.ACTIVITY_SHOP_UPDATED then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_ACTIVITY, var_23_1.shop)
	elseif var_23_0 == ActivityProxy.ACTIVITY_SHOP_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards, var_23_1.callback)
	elseif var_23_0 == GAME.USE_ITEM_DONE then
		if #var_23_1.drops ~= 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_23_1.drops
			})
		end
	elseif var_23_0 == GAME.FRAG_SELL_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)

		if self.viewComponent.page == self.viewComponent.pages[NewShopsScene.TYPE_FRAGMENT] then
			self.viewComponent.page:OnFragmentSellUpdate()
		end
	elseif var_23_0 == GAME.ON_GUILD_SHOP_PURCHASE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)
	elseif var_23_0 == GAME.ON_MEDAL_SHOP_PURCHASE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)
	elseif var_23_0 == ShopsProxy.GUILD_SHOP_UPDATED then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_GUILD, var_23_1.shop)
	elseif var_23_0 == ShopsProxy.MEDAL_SHOP_UPDATED then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_MEDAL, var_23_1)
	elseif var_23_0 == GAME.ON_META_SHOPPING_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)
	elseif var_23_0 == ShopsProxy.QUOTA_SHOP_UPDATED then
		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_QUOTA, var_23_1.shop)
	elseif var_23_0 == GAME.QUOTA_SHOPPING_DONE then
		self.viewComponent:OnUpdateCommodity(NewShopsScene.TYPE_QUOTA_SHOP, getProxy(ShopsProxy):getQuotaShop(), var_23_1.id)
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.awards)
	elseif var_23_0 == GAME.MINI_GAME_SHOP_BUY_DONE then
		if var_23_1.list and #var_23_1.list > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_23_1.list)
		end

		self.viewComponent:OnUpdateShop(NewShopsScene.TYPE_MINI_GAME, (getProxy(ShopsProxy):getMiniShop()))
	end

	return
end

return NewShopsMediator

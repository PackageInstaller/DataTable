local ChargeMediator = class("ChargeMediator", import("...base.ContextMediator"))

ChargeMediator.SWITCH_TO_SHOP = "ChargeMediator:SWITCH_TO_SHOP"
ChargeMediator.CHARGE = "ChargeMediator:CHARGE"
ChargeMediator.BUY_ITEM = "ChargeMediator:BUY_ITEM"
ChargeMediator.CLICK_MING_SHI = "ChargeMediator:CLICK_MING_SHI"
ChargeMediator.GET_CHARGE_LIST = "ChargeMediator:GET_CHARGE_LIST"
ChargeMediator.ON_SKIN_SHOP = "ChargeMediator:ON_SKIN_SHOP"
ChargeMediator.OPEN_CHARGE_ITEM_PANEL = "ChargeMediator:OPEN_CHARGE_ITEM_PANEL"
ChargeMediator.OPEN_CHARGE_ITEM_BOX = "ChargeMediator:OPEN_CHARGE_ITEM_BOX"
ChargeMediator.OPEN_CHARGE_BIRTHDAY = "ChargeMediator:OPEN_CHARGE_BIRTHDAY"
ChargeMediator.OPEN_USER_AGREE = "ChargeMediator:OPEN_USER_AGREE"
ChargeMediator.VIEW_SKIN_PROBABILITY = "ChargeMediator:VIEW_SKIN_PROBABILITY"
ChargeMediator.OPEN_TEC_SHIP_GIFT_SELL_LAYER = "ChargeMediator:OPEN_TEC_SHIP_GIFT_SELL_LAYER"
ChargeMediator.OPEN_BATTLE_UI_SELL_LAYER = "ChargeMediator:OPEN_BATTLE_UI_SELL_LAYER"

function ChargeMediator:register()
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	self.viewComponent:checkFreeGiftTag()
	self:bind(ChargeMediator.VIEW_SKIN_PROBABILITY, function(arg_2_0, arg_2_1, arg_2_2)
		self.contextData.wrap = arg_2_2

		self:sendNotification(GAME.GO_SCENE, SCENE.PROBABILITY_SKINSHOP, {
			commodityId = arg_2_1
		})

		return
	end)
	self:bind(ChargeMediator.GET_CHARGE_LIST, function(arg_3_0)
		self:sendNotification(GAME.GET_CHARGE_LIST)

		return
	end)
	self:bind(ChargeMediator.ON_SKIN_SHOP, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:bind(ChargeMediator.SWITCH_TO_SHOP, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_5_1)

		return
	end)
	self:bind(ChargeMediator.CHARGE, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_6_1
		})

		return
	end)
	self:bind(ChargeMediator.BUY_ITEM, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_7_1,
			count = arg_7_2
		})

		return
	end)
	self:bind(ChargeMediator.CLICK_MING_SHI, function(arg_8_0)
		self:sendNotification(GAME.CLICK_MING_SHI)

		return
	end)
	self:bind(ChargeMediator.OPEN_CHARGE_ITEM_PANEL, function(arg_9_0, arg_9_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_9_1
			}
		}))

		return
	end)
	self:bind(ChargeMediator.OPEN_CHARGE_ITEM_BOX, function(arg_10_0, arg_10_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemBoxMediator,
			viewComponent = ChargeItemBoxLayer,
			data = {
				panelConfig = arg_10_1
			}
		}))

		return
	end)
	self:bind(ChargeMediator.OPEN_CHARGE_BIRTHDAY, function(arg_11_0, arg_11_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	self:bind(ChargeMediator.OPEN_USER_AGREE, function(arg_12_0, arg_12_1)
		self:addSubLayers(Context.New({
			mediator = ChargeJPUserAgreeMediator,
			viewComponent = ChargeJPUserAgreeLayer,
			data = {
				contentStr = arg_12_1
			}
		}))

		return
	end)
	self:bind(ChargeMediator.OPEN_TEC_SHIP_GIFT_SELL_LAYER, function(arg_13_0, arg_13_1, arg_13_2)
		self:addSubLayers(Context.New({
			mediator = ChargeTecShipGiftSellMediator,
			viewComponent = ChargeTecShipGiftSellLayer,
			data = {
				showGoodVO = arg_13_1,
				chargedList = arg_13_2
			}
		}))

		return
	end)
	self:bind(ChargeMediator.OPEN_BATTLE_UI_SELL_LAYER, function(arg_14_0, arg_14_1, arg_14_2)
		self:addSubLayers(Context.New({
			mediator = ChargeBattleUISellMediator,
			viewComponent = ChargeBattleUISellLayer,
			data = {
				showGoodVO = arg_14_1,
				chargedList = arg_14_2
			}
		}))

		return
	end)

	return
end

function ChargeMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		ShopsProxy.FIRST_CHARGE_IDS_UPDATED,
		ShopsProxy.CHARGED_LIST_UPDATED,
		GAME.CHARGE_CONFIRM_FAILED,
		GAME.GET_CHARGE_LIST_DONE,
		GAME.SHOPPING_DONE,
		GAME.USE_ITEM_DONE,
		GAME.CLICK_MING_SHI_SUCCESS,
		GAME.REMOVE_LAYERS,
		PlayerResUI.GO_MALL,
		GAME.CHARGE_SUCCESS
	}
end

function ChargeMediator:handleNotification(arg_16_1)
	local var_16_0 = arg_16_1:getName()
	local var_16_1 = arg_16_1:getBody()

	if var_16_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_16_1)
		self.viewComponent:updateNoRes()
	elseif var_16_0 == ShopsProxy.FIRST_CHARGE_IDS_UPDATED then
		self.viewComponent:setFirstChargeIds(var_16_1)
		self.viewComponent:updateCurSubView()
	elseif var_16_0 == ShopsProxy.CHARGED_LIST_UPDATED then
		self.viewComponent:setChargedList(var_16_1)
		self.viewComponent:updateCurSubView()
	elseif var_16_0 == GAME.CHARGE_CONFIRM_FAILED then
		getProxy(ShopsProxy):chargeFailed(var_16_1.payId, var_16_1.bsId)
	elseif var_16_0 == GAME.SHOPPING_DONE then
		if var_16_1.awards and #var_16_1.awards > 0 then
			self.viewComponent:unBlurView()
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_16_1.awards
			})
		end

		if var_16_1.normalList then
			self.viewComponent:setNormalList(var_16_1.normalList)
		end

		if var_16_1.normalGroupList then
			self.viewComponent:setNormalGroupList(var_16_1.normalGroupList)
		end

		self.viewComponent:checkBuyDone(var_16_1.id)
		self.viewComponent:updateCurSubView()
		self.viewComponent:checkFreeGiftTag()
	elseif var_16_0 == GAME.USE_ITEM_DONE then
		if #var_16_1.drops ~= 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_16_1.drops
			})
		end
	elseif var_16_0 == GAME.GET_CHARGE_LIST_DONE then
		if var_16_1.firstChargeIds then
			self.viewComponent:setFirstChargeIds(var_16_1.firstChargeIds)
		end

		if var_16_1.chargedList then
			self.viewComponent:setChargedList(var_16_1.chargedList)
		end

		if var_16_1.normalList then
			self.viewComponent:setNormalList(var_16_1.normalList)
		end

		if var_16_1.normalGroupList then
			self.viewComponent:setNormalGroupList(var_16_1.normalGroupList)
		end

		if var_16_1.firstChargeIds or var_16_1.chargedList or var_16_1.normalList or var_16_1.normalGroupList then
			self.viewComponent:updateCurSubView()
		end

		self.viewComponent:checkFreeGiftTag()
	elseif var_16_0 == GAME.CLICK_MING_SHI_SUCCESS then
		self.viewComponent:playHeartEffect()
	elseif var_16_0 == PlayerResUI.GO_MALL then
		self.viewComponent:switchSubViewByTogger((var_16_1 or nil) and (var_16_1.type or ChargeScene.TYPE_DIAMOND))
		self.viewComponent:updateNoRes((var_16_1 or nil) and (var_16_1.noRes or nil))
	elseif var_16_0 == GAME.CHARGE_SUCCESS then
		self.viewComponent:checkBuyDone("damonds")
		self.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_16_1.shopId
		}, Goods.TYPE_CHARGE)))
	end

	return
end

return ChargeMediator

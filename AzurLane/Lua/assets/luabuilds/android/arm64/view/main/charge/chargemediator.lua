local var_0_0 = class("ChargeMediator", import("...base.ContextMediator"))

var_0_0.SWITCH_TO_SHOP = "ChargeMediator:SWITCH_TO_SHOP"
var_0_0.CHARGE = "ChargeMediator:CHARGE"
var_0_0.BUY_ITEM = "ChargeMediator:BUY_ITEM"
var_0_0.CLICK_MING_SHI = "ChargeMediator:CLICK_MING_SHI"
var_0_0.GET_CHARGE_LIST = "ChargeMediator:GET_CHARGE_LIST"
var_0_0.ON_SKIN_SHOP = "ChargeMediator:ON_SKIN_SHOP"
var_0_0.OPEN_CHARGE_ITEM_PANEL = "ChargeMediator:OPEN_CHARGE_ITEM_PANEL"
var_0_0.OPEN_CHARGE_ITEM_BOX = "ChargeMediator:OPEN_CHARGE_ITEM_BOX"
var_0_0.OPEN_CHARGE_BIRTHDAY = "ChargeMediator:OPEN_CHARGE_BIRTHDAY"
var_0_0.OPEN_USER_AGREE = "ChargeMediator:OPEN_USER_AGREE"
var_0_0.VIEW_SKIN_PROBABILITY = "ChargeMediator:VIEW_SKIN_PROBABILITY"
var_0_0.OPEN_TEC_SHIP_GIFT_SELL_LAYER = "ChargeMediator:OPEN_TEC_SHIP_GIFT_SELL_LAYER"
var_0_0.OPEN_BATTLE_UI_SELL_LAYER = "ChargeMediator:OPEN_BATTLE_UI_SELL_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	arg_1_0.viewComponent:checkFreeGiftTag()
	arg_1_0:bind(var_0_0.VIEW_SKIN_PROBABILITY, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0.contextData.wrap = arg_2_2

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.PROBABILITY_SKINSHOP, {
			commodityId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_CHARGE_LIST, function(arg_3_0)
		arg_1_0:sendNotification(GAME.GET_CHARGE_LIST)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SKIN_SHOP, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_1_0:bind(var_0_0.SWITCH_TO_SHOP, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_0.CHARGE, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.BUY_ITEM, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_7_1,
			count = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.CLICK_MING_SHI, function(arg_8_0)
		arg_1_0:sendNotification(GAME.CLICK_MING_SHI)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_PANEL, function(arg_9_0, arg_9_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_9_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_BOX, function(arg_10_0, arg_10_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemBoxMediator,
			viewComponent = ChargeItemBoxLayer,
			data = {
				panelConfig = arg_10_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_BIRTHDAY, function(arg_11_0, arg_11_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_USER_AGREE, function(arg_12_0, arg_12_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeJPUserAgreeMediator,
			viewComponent = ChargeJPUserAgreeLayer,
			data = {
				contentStr = arg_12_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_TEC_SHIP_GIFT_SELL_LAYER, function(arg_13_0, arg_13_1, arg_13_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeTecShipGiftSellMediator,
			viewComponent = ChargeTecShipGiftSellLayer,
			data = {
				showGoodVO = arg_13_1,
				chargedList = arg_13_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_BATTLE_UI_SELL_LAYER, function(arg_14_0, arg_14_1, arg_14_2)
		arg_1_0:addSubLayers(Context.New({
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

function var_0_0.listNotificationInterests(arg_15_0)
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

function var_0_0.handleNotification(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getName()
	local var_16_1 = arg_16_1:getBody()

	if var_16_0 == PlayerProxy.UPDATED then
		arg_16_0.viewComponent:setPlayer(var_16_1)
		arg_16_0.viewComponent:updateNoRes()

		goto label_16_0
	end

	if var_16_0 == ShopsProxy.FIRST_CHARGE_IDS_UPDATED then
		arg_16_0.viewComponent:setFirstChargeIds(var_16_1)
		arg_16_0.viewComponent:updateCurSubView()

		goto label_16_0
	end

	if var_16_0 == ShopsProxy.CHARGED_LIST_UPDATED then
		arg_16_0.viewComponent:setChargedList(var_16_1)
		arg_16_0.viewComponent:updateCurSubView()

		goto label_16_0
	end

	if var_16_0 == GAME.CHARGE_CONFIRM_FAILED then
		getProxy(ShopsProxy):chargeFailed(var_16_1.payId, var_16_1.bsId)

		goto label_16_0
	end

	if var_16_0 == GAME.SHOPPING_DONE then
		if var_16_1.awards and #var_16_1.awards > 0 then
			arg_16_0.viewComponent:unBlurView()
			arg_16_0.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_16_1.awards
			})
		end

		local var_16_2 = var_16_1.normalList

		if var_16_1.normalList then
			arg_16_0.viewComponent:setNormalList(var_16_2)
		end

		if var_16_1.normalGroupList then
			arg_16_0.viewComponent:setNormalGroupList(var_16_1.normalGroupList)
		end

		arg_16_0.viewComponent:checkBuyDone(var_16_1.id)
		arg_16_0.viewComponent:updateCurSubView()
		arg_16_0.viewComponent:checkFreeGiftTag()

		goto label_16_0
	end

	if var_16_0 == GAME.USE_ITEM_DONE then
		if #var_16_1.drops ~= 0 then
			arg_16_0.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_16_1.drops
			})
		end

		goto label_16_0
	end

	if var_16_0 == GAME.GET_CHARGE_LIST_DONE then
		if var_16_1.firstChargeIds then
			arg_16_0.viewComponent:setFirstChargeIds(var_16_1.firstChargeIds)
		end

		if var_16_1.chargedList then
			arg_16_0.viewComponent:setChargedList(var_16_1.chargedList)
		end

		if var_16_1.normalList then
			arg_16_0.viewComponent:setNormalList(var_16_1.normalList)
		end

		if var_16_1.normalGroupList then
			arg_16_0.viewComponent:setNormalGroupList(var_16_1.normalGroupList)
		end

		if var_16_1.firstChargeIds or var_16_1.chargedList or var_16_1.normalList or var_16_1.normalGroupList then
			arg_16_0.viewComponent:updateCurSubView()
		end

		arg_16_0.viewComponent:checkFreeGiftTag()

		goto label_16_0
	end

	if var_16_0 == GAME.CLICK_MING_SHI_SUCCESS then
		arg_16_0.viewComponent:playHeartEffect()

		goto label_16_0
	end

	::label_16_0::

	if var_16_0 == PlayerResUI.GO_MALL then
		local var_16_4 = ChargeScene.TYPE_DIAMOND

		if var_16_1 then
			var_16_4 = var_16_1.type or ChargeScene.TYPE_DIAMOND
		end

		arg_16_0.viewComponent:switchSubViewByTogger(var_16_4)

		local var_16_5 = arg_16_0.viewComponent

		if var_16_1 then
			do
				local var_16_7 = var_16_1.noRes or nil

				var_16_6(var_16_5, var_16_7)

				if false then
					if var_16_0 == GAME.CHARGE_SUCCESS then
						arg_16_0.viewComponent:checkBuyDone("damonds")
						arg_16_0.viewComponent:OnChargeSuccess((Goods.Create({
							shop_id = var_16_1.shopId
						}, Goods.TYPE_CHARGE)))
					end
				end
			end

			return
		end
	end
end

return var_0_0

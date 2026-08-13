class = var_0_10000

local var_0_0 = "ChargeMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.SWITCH_TO_SHOP = "ChargeMediator:SWITCH_TO_SHOP"
var_0_1.CHARGE = "ChargeMediator:CHARGE"
var_0_1.BUY_ITEM = "ChargeMediator:BUY_ITEM"
var_0_1.CLICK_MING_SHI = "ChargeMediator:CLICK_MING_SHI"
var_0_1.GET_CHARGE_LIST = "ChargeMediator:GET_CHARGE_LIST"
var_0_1.ON_SKIN_SHOP = "ChargeMediator:ON_SKIN_SHOP"
var_0_1.OPEN_CHARGE_ITEM_PANEL = "ChargeMediator:OPEN_CHARGE_ITEM_PANEL"
var_0_1.OPEN_CHARGE_ITEM_BOX = "ChargeMediator:OPEN_CHARGE_ITEM_BOX"
var_0_1.OPEN_CHARGE_BIRTHDAY = "ChargeMediator:OPEN_CHARGE_BIRTHDAY"
var_0_1.OPEN_USER_AGREE = "ChargeMediator:OPEN_USER_AGREE"
var_0_1.VIEW_SKIN_PROBABILITY = "ChargeMediator:VIEW_SKIN_PROBABILITY"
var_0_1.OPEN_TEC_SHIP_GIFT_SELL_LAYER = "ChargeMediator:OPEN_TEC_SHIP_GIFT_SELL_LAYER"
var_0_1.OPEN_BATTLE_UI_SELL_LAYER = "ChargeMediator:OPEN_BATTLE_UI_SELL_LAYER"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)

	local var_1_3 = arg_1_0.viewComponent

	var_3.checkFreeGiftTag(var_1_3)
	arg_1_0:bind(var_0_1.VIEW_SKIN_PROBABILITY, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0.contextData.wrap = arg_2_2

		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_2_1(var_2_0, var_2_2, var_2_10006.PROBABILITY_SKINSHOP, {
			commodityId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GET_CHARGE_LIST, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		var_3_1(var_3_0, var_2_10003.GET_CHARGE_LIST)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKIN_SHOP, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_4_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.SKINSHOP)

		return
	end)
	arg_1_0:bind(var_0_1.SWITCH_TO_SHOP, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_5_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_5_1(var_5_0, var_5_2, var_2_10005.SHOP, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHARGE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.CHARGE_OPERATION, {
			shopId = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.BUY_ITEM, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.SHOPPING, {
			id = arg_7_1,
			count = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_MING_SHI, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.sendNotification

		GAME = var_2_10003

		var_8_1(var_8_0, var_2_10003.CLICK_MING_SHI)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_PANEL, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_9_2 = var_2_10004.New
		local var_9_3 = {}

		ChargeItemPanelMediator = var_2_10006
		var_9_3.mediator = var_2_10006
		ChargeItemPanelLayer = var_2_10006
		var_9_3.viewComponent = var_2_10006
		var_9_3.data = {
			panelConfig = arg_9_1
		}

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_BOX, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_10_2 = var_2_10004.New
		local var_10_3 = {}

		ChargeItemBoxMediator = var_2_10006
		var_10_3.mediator = var_2_10006
		ChargeItemBoxLayer = var_2_10006
		var_10_3.viewComponent = var_2_10006
		var_10_3.data = {
			panelConfig = arg_10_1
		}

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_BIRTHDAY, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_11_2 = var_2_10004.New
		local var_11_3 = {}

		ChargeBirthdayMediator = var_2_10006
		var_11_3.mediator = var_2_10006
		ChargeBirthdayLayer = var_2_10006
		var_11_3.viewComponent = var_2_10006
		var_11_3.data = {}

		var_11_1(var_11_0, var_11_2(var_11_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_USER_AGREE, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_12_2 = var_2_10004.New
		local var_12_3 = {}

		ChargeJPUserAgreeMediator = var_2_10006
		var_12_3.mediator = var_2_10006
		ChargeJPUserAgreeLayer = var_2_10006
		var_12_3.viewComponent = var_2_10006
		var_12_3.data = {
			contentStr = arg_12_1
		}

		var_12_1(var_12_0, var_12_2(var_12_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_TEC_SHIP_GIFT_SELL_LAYER, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_1_0
		local var_13_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_13_2 = var_2_10005.New
		local var_13_3 = {}

		ChargeTecShipGiftSellMediator = var_2_10007
		var_13_3.mediator = var_2_10007
		ChargeTecShipGiftSellLayer = var_2_10007
		var_13_3.viewComponent = var_2_10007
		var_13_3.data = {
			showGoodVO = arg_13_1,
			chargedList = arg_13_2
		}

		var_13_1(var_13_0, var_13_2(var_13_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_BATTLE_UI_SELL_LAYER, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0
		local var_14_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_14_2 = var_2_10005.New
		local var_14_3 = {}

		ChargeBattleUISellMediator = var_2_10007
		var_14_3.mediator = var_2_10007
		ChargeBattleUISellLayer = var_2_10007
		var_14_3.viewComponent = var_2_10007
		var_14_3.data = {
			showGoodVO = arg_14_1,
			chargedList = arg_14_2
		}

		var_14_1(var_14_0, var_14_2(var_14_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_15_0)
	local var_15_0 = {}

	PlayerProxy = var_1_10002
	var_15_0[1] = var_1_10002.UPDATED
	ShopsProxy = var_2
	var_15_0[2] = var_2.FIRST_CHARGE_IDS_UPDATED
	ShopsProxy = var_2
	var_15_0[3] = var_2.CHARGED_LIST_UPDATED
	GAME = var_2
	var_15_0[4] = var_2.CHARGE_CONFIRM_FAILED
	GAME = var_2
	var_15_0[5] = var_2.GET_CHARGE_LIST_DONE
	GAME = var_2
	var_15_0[6] = var_2.SHOPPING_DONE
	GAME = var_2
	var_15_0[7] = var_2.USE_ITEM_DONE
	GAME = var_2
	var_15_0[8] = var_2.CLICK_MING_SHI_SUCCESS
	GAME = var_2
	var_15_0[9] = var_2.REMOVE_LAYERS
	PlayerResUI = var_2
	var_15_0[10] = var_2.GO_MALL
	GAME = var_2
	var_15_0[11] = var_2.CHARGE_SUCCESS

	return var_15_0
end

function var_0_1.handleNotification(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getName()
	local var_16_1 = arg_16_1
	local var_16_2 = arg_16_1.getBody(var_16_1)

	PlayerProxy = var_16_1

	if var_16_0 == var_16_1.UPDATED then
		var_1_10005 = arg_16_0.viewComponent

		var_4.setPlayer(var_1_10005, var_16_2)

		var_1_10005 = arg_16_0.viewComponent

		var_4.updateNoRes(var_1_10005)
	else
		ShopsProxy = var_4

		if var_16_0 == var_4.FIRST_CHARGE_IDS_UPDATED then
			var_1_10005 = arg_16_0.viewComponent

			var_4.setFirstChargeIds(var_1_10005, var_16_2)

			var_1_10005 = arg_16_0.viewComponent

			var_4.updateCurSubView(var_1_10005)
		else
			ShopsProxy = var_4

			if var_16_0 == var_4.CHARGED_LIST_UPDATED then
				var_1_10005 = arg_16_0.viewComponent

				var_4.setChargedList(var_1_10005, var_16_2)

				var_1_10005 = arg_16_0.viewComponent

				var_4.updateCurSubView(var_1_10005)
			else
				GAME = var_4

				if var_16_0 == var_4.CHARGE_CONFIRM_FAILED then
					getProxy = var_4
					ShopsProxy = var_1_10005
					var_1_10006 = var_4(var_1_10005)

					var_4.chargeFailed(var_1_10006, var_16_2.payId, var_16_2.bsId)
				else
					GAME = var_4

					local var_16_5

					if var_16_0 == var_4.SHOPPING_DONE then
						if var_16_2.awards and #var_16_2.awards > 0 then
							local var_16_3 = arg_16_0.viewComponent

							var_16_5.unBlurView(var_16_3)

							local var_16_4 = arg_16_0.viewComponent

							var_16_5 = var_16_5.emit
							BaseUI = var_1_10006

							var_16_5(var_16_4, var_1_10006.ON_AWARD, {
								items = var_16_2.awards
							})
						end

						var_16_5 = var_16_2.normalList

						local var_16_6 = var_16_2.normalGroupList

						if var_16_5 then
							local var_16_7 = arg_16_0.viewComponent

							var_1_10006.setNormalList(var_16_7, var_16_5)
						end

						if var_16_6 then
							local var_16_8 = arg_16_0.viewComponent

							var_1_10006.setNormalGroupList(var_16_8, var_16_6)
						end

						pg = var_1_10006
						var_1_10006 = var_1_10006.shop_template[var_16_2.id]

						local var_16_9 = arg_16_0.viewComponent

						var_7.checkBuyDone(var_16_9, var_16_2.id)

						local var_16_10 = arg_16_0.viewComponent

						var_7.updateCurSubView(var_16_10)

						local var_16_11 = arg_16_0.viewComponent

						var_7.checkFreeGiftTag(var_16_11)
					else
						GAME = var_16_5

						local var_16_13

						if var_16_0 == var_16_5.USE_ITEM_DONE then
							if #var_16_2.drops ~= 0 then
								local var_16_12 = arg_16_0.viewComponent

								var_16_13 = var_16_13.emit
								BaseUI = var_1_10006

								var_16_13(var_16_12, var_1_10006.ON_AWARD, {
									items = var_16_2.drops
								})
							end
						else
							GAME = var_16_13

							local var_16_14

							if var_16_0 == var_16_13.GET_CHARGE_LIST_DONE then
								var_16_14 = var_16_2.firstChargeIds

								local var_16_15 = var_16_2.chargedList
								local var_16_16 = var_16_2.normalList
								local var_16_17 = var_16_2.normalGroupList

								if var_16_14 then
									local var_16_18 = arg_16_0.viewComponent

									var_8.setFirstChargeIds(var_16_18, var_16_14)
								end

								if var_16_15 then
									local var_16_19 = arg_16_0.viewComponent

									var_8.setChargedList(var_16_19, var_16_15)
								end

								if var_16_16 then
									local var_16_20 = arg_16_0.viewComponent

									var_8.setNormalList(var_16_20, var_16_16)
								end

								if var_16_17 then
									local var_16_21 = arg_16_0.viewComponent

									var_8.setNormalGroupList(var_16_21, var_16_17)
								end

								if var_16_14 or var_16_15 or var_16_16 or var_16_17 then
									local var_16_22 = arg_16_0.viewComponent

									var_8.updateCurSubView(var_16_22)
								end

								local var_16_23 = arg_16_0.viewComponent

								var_8.checkFreeGiftTag(var_16_23)
							else
								GAME = var_16_14

								if var_16_0 == var_16_14.CLICK_MING_SHI_SUCCESS then
									local var_16_24 = arg_16_0.viewComponent

									var_4.playHeartEffect(var_16_24)
								else
									PlayerResUI = var_4

									local var_16_25

									if var_16_0 == var_4.GO_MALL then
										ChargeScene = var_16_25
										var_16_25 = var_16_25.TYPE_DIAMOND

										if var_16_2 and not var_16_2.type then
											::label_16_0::

											ChargeScene = var_5
											var_16_25 = var_5.TYPE_DIAMOND
										end

										local var_16_26 = arg_16_0.viewComponent

										var_5.switchSubViewByTogger(var_16_26, var_16_25)

										local var_16_27 = arg_16_0.viewComponent
										local var_16_28 = var_5.updateNoRes
										local var_16_29

										if not var_16_2 or not var_16_2.noRes then
											var_16_29 = nil
										end

										var_16_28(var_16_27, var_16_29)
									else
										GAME = var_16_25

										if var_16_0 == var_16_25.CHARGE_SUCCESS then
											local var_16_30 = arg_16_0.viewComponent

											var_4.checkBuyDone(var_16_30, "damonds")

											Goods = var_4

											local var_16_31 = var_4.Create
											local var_16_32 = {
												shop_id = var_16_2.shopId
											}

											Goods = var_6

											local var_16_33 = var_16_31(var_16_32, var_6.TYPE_CHARGE)
											local var_16_34 = arg_16_0.viewComponent

											var_5.OnChargeSuccess(var_16_34, var_16_33)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1

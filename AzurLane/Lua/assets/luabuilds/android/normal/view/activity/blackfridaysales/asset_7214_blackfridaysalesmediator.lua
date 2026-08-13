class = var_0_10000

local var_0_0 = "BlackFridaySalesMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.TASK_GO = "BlackFridaySalesMediator.TASK_GO"
var_0_1.TASK_SUBMIT = "BlackFridaySalesMediator.TASK_SUBMIT"
var_0_1.TASK_SUBMIT_ONESTEP = "BlackFridaySalesMediator.TASK_SUBMIT_ONESTEP"
var_0_1.GIFT_BUY_ITEM = "BlackFridaySalesMediator.GIFT_BUY_ITEM"
var_0_1.GIFT_OPEN_ITEM_PANEL = "BlackFridaySalesMediator.GIFT_OPEN_ITEM_PANEL"
var_0_1.UPDATE_SHOP_RED_DOT = "BlackFridaySalesMediator.UPDATE_SHOP_RED_DOT"
var_0_1.CHARGE = "BlackFridaySalesMediator:CHARGE"
var_0_1.OPEN_CHARGE_BIRTHDAY = "BlackFridaySalesMediator:OPEN_CHARGE_BIRTHDAY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1)
		pg = var_2_10002

		local var_4_0 = var_2_10002.m02
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.SUBMIT_TASK_ONESTEP, {
			resultList = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GIFT_BUY_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.GIFT_OPEN_ITEM_PANEL, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		ChargeItemPanelMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		ChargeItemPanelLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		var_6_3.data = {
			panelConfig = arg_6_1
		}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_SHOP_RED_DOT, function(arg_7_0)
		local var_7_0 = arg_1_0.viewComponent

		var_1.updateShopDedDot(var_7_0)

		return
	end)
	arg_1_0:bind(var_0_1.CHARGE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10004

		var_8_1(var_8_0, var_2_10004.CHARGE_OPERATION, {
			shopId = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_BIRTHDAY, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_9_2 = var_2_10004.New
		local var_9_3 = {}

		ChargeBirthdayMediator = var_2_10006
		var_9_3.mediator = var_2_10006
		ChargeBirthdayLayer = var_2_10006
		var_9_3.viewComponent = var_2_10006
		var_9_3.data = {}

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.setData(var_1_0)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	GAME = var_1_10002
	var_10_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE
	PlayerProxy = var_2
	var_10_0[2] = var_2.UPDATED
	GAME = var_2
	var_10_0[3] = var_2.SHOPPING_DONE
	GAME = var_2
	var_10_0[4] = var_2.CHARGE_SUCCESS
	GAME = var_2
	var_10_0[5] = var_2.NEW_SERVER_SHOP_SHOPPING_DONE

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1
	local var_11_2 = arg_11_1.getBody(var_11_1)

	GAME = var_11_1

	local var_11_4

	if var_11_0 == var_11_1.SUBMIT_ACTIVITY_TASK_DONE then
		local var_11_3 = arg_11_0.viewComponent

		var_11_4 = var_11_4.emit
		BaseUI = var_1_10006

		var_11_4(var_11_3, var_1_10006.ON_AWARD, {
			items = var_11_2.awards
		})

		local var_11_5 = arg_11_0.viewComponent

		var_11_4 = var_11_4.emit
		BaseUI = var_1_10006

		var_11_4(var_11_5, var_1_10006.ON_ACHIEVE, var_11_2, function()
			local var_12_0 = arg_11_0.viewComponent

			var_0.onUpdateTask(var_12_0)

			return
		end)
	else
		PlayerProxy = var_11_4

		if var_11_0 == var_11_4.UPDATED then
			local var_11_6 = arg_11_0.viewComponent

			var_4.onUpdatePlayer(var_11_6, var_11_2)
		else
			GAME = var_4

			local var_11_8

			if var_11_0 == var_4.SHOPPING_DONE then
				if #var_11_2.awards > 0 then
					local var_11_7 = arg_11_0.viewComponent

					var_11_8 = var_11_8.emit
					BaseUI = var_1_10006

					var_11_8(var_11_7, var_1_10006.ON_ACHIEVE, var_11_2.awards)
				end

				local var_11_9 = arg_11_0.viewComponent

				var_11_8.onUpdateGift(var_11_9)
			else
				GAME = var_11_8

				local var_11_11

				if var_11_0 == var_11_8.NEW_SERVER_SHOP_SHOPPING_DONE then
					if #var_11_2.awards > 0 then
						local var_11_10 = arg_11_0.viewComponent

						var_11_11 = var_11_11.emit
						BaseUI = var_1_10006

						var_11_11(var_11_10, var_1_10006.ON_ACHIEVE, var_11_2.awards)
					end

					if arg_11_0.viewComponent.blackFridaySalesShopPage then
						local var_11_12 = arg_11_0.viewComponent.blackFridaySalesShopPage

						if var_11_11.GetLoaded(var_11_12) then
							local var_11_13 = arg_11_0.viewComponent.blackFridaySalesShopPage

							var_11_11.Refresh(var_11_13)
						end
					end
				else
					GAME = var_11_11

					if var_11_0 == var_11_11.CHARGE_SUCCESS then
						Goods = var_4

						local var_11_14 = var_4.Create
						local var_11_15 = {
							shop_id = var_11_2.shopId
						}

						Goods = var_6

						local var_11_16 = var_11_14(var_11_15, var_6.TYPE_CHARGE)
						local var_11_17 = arg_11_0.viewComponent

						var_5.onUpdateGift(var_11_17)

						local var_11_18 = arg_11_0.viewComponent

						var_5.OnChargeSuccess(var_11_18, var_11_16)
					end
				end
			end
		end
	end

	return
end

return var_0_1

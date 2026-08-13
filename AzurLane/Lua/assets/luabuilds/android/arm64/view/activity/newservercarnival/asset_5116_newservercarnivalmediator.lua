class = var_0_10000

local var_0_0 = "NewServerCarnivalMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.TASK_GO = "NewServerCarnivalMediator.TASK_GO"
var_0_1.TASK_SUBMIT = "NewServerCarnivalMediator.TASK_SUBMIT"
var_0_1.TASK_SUBMIT_ONESTEP = "NewServerCarnivalMediator.TASK_SUBMIT_ONESTEP"
var_0_1.GIFT_BUY_ITEM = "NewServerCarnivalMediator.GIFT_BUY_ITEM"
var_0_1.GIFT_OPEN_ITEM_PANEL = "NewServerCarnivalMediator.GIFT_OPEN_ITEM_PANEL"
var_0_1.UPDATE_SHOP_RED_DOT = "NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1)
		pg = var_2_10002

		local var_4_0 = var_2_10002.m02
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SUBMIT_TASK_ONESTEP, {
			resultList = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GIFT_BUY_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.GIFT_OPEN_ITEM_PANEL, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_6_2 = var_2_10005.New
		local var_6_3 = {}

		ChargeItemPanelMediator = var_2_10008
		var_6_3.mediator = var_2_10008
		ChargeItemPanelLayer = var_2_10008
		var_6_3.viewComponent = var_2_10008
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

	local var_1_0 = arg_1_0.viewComponent

	var_1.setData(var_1_0)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.SUBMIT_TASK_DONE
	PlayerProxy = var_2
	var_8_0[2] = var_2.UPDATED
	GAME = var_2
	var_8_0[3] = var_2.SHOPPING_DONE
	GAME = var_2
	var_8_0[4] = var_2.NEW_SERVER_SHOP_SHOPPING_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	GAME = var_9_0

	local var_9_4

	if var_9_1 == var_9_0.SUBMIT_TASK_DONE then
		local var_9_3 = arg_9_0.viewComponent

		var_9_4 = var_9_4.emit
		BaseUI = var_1_10007

		var_9_4(var_9_3, var_1_10007.ON_ACHIEVE, var_9_2, function()
			local var_10_0 = arg_9_0.viewComponent

			var_0.onUpdateTask(var_10_0)

			return
		end)
	else
		PlayerProxy = var_9_4

		if var_9_1 == var_9_4.UPDATED then
			local var_9_5 = arg_9_0.viewComponent

			var_4.onUpdatePlayer(var_9_5, var_9_2)
		else
			GAME = var_4

			local var_9_7

			if var_9_1 == var_4.SHOPPING_DONE then
				if #var_9_2.awards > 0 then
					local var_9_6 = arg_9_0.viewComponent

					var_9_7 = var_9_7.emit
					BaseUI = var_1_10007

					var_9_7(var_9_6, var_1_10007.ON_ACHIEVE, var_9_2.awards)
				end

				local var_9_8 = arg_9_0.viewComponent

				var_9_7.onUpdateGift(var_9_8)
			else
				GAME = var_9_7

				if var_9_1 == var_9_7.NEW_SERVER_SHOP_SHOPPING_DONE then
					if #var_9_2.awards > 0 then
						local var_9_9 = arg_9_0.viewComponent
						local var_9_10 = var_4.emit

						BaseUI = var_1_10007

						var_9_10(var_9_9, var_1_10007.ON_ACHIEVE, var_9_2.awards)
					end

					if arg_9_0.viewComponent.newServerShopPage then
						local var_9_11 = arg_9_0.viewComponent.newServerShopPage

						if var_4.GetLoaded(var_9_11) then
							local var_9_12 = arg_9_0.viewComponent.newServerShopPage

							var_4.Refresh(var_9_12)
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1

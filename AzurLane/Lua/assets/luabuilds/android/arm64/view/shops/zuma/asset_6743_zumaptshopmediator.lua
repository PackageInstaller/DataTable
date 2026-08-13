class = var_0_10000

local var_0_0 = "ZumaPTShopMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.OPEN_ZUMA_PT_SHOP_BUY_WINDOW = "ZumaPTShopMediator.OPEN_ZUMA_PT_SHOP_BUY_WINDOW"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_ZUMA_PT_SHOP_BUY_WINDOW, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		ZumaPTShopWindowMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		ZumaPTShopWindowLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = {
			actShopVO = arg_1_0.viewComponent.actShopVO,
			goodVO = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.ISLAND_SHOPPING_DONE
	GAME = var_2
	var_3_0[2] = var_2.USE_ITEM_DONE
	PlayerProxy = var_2
	var_3_0[3] = var_2.UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	local var_4_3

	if var_4_1 == var_4_0.ISLAND_SHOPPING_DONE then
		var_4_3 = arg_4_1:getBody()

		local var_4_4 = {}

		if #var_4_3.awards > 0 then
			table = var_6

			var_6.insert(var_4_4, function(arg_5_0)
				local var_5_0 = arg_4_0.viewComponent
				local var_5_1 = var_1.emit

				BaseUI = var_2_10004

				var_5_1(var_5_0, var_2_10004.ON_ACHIEVE, var_4_3.awards, arg_5_0)

				return
			end)
		end

		seriesAsync = var_6

		var_6(var_4_4, function()
			local var_6_0 = arg_4_0.viewComponent

			var_0.updateTplByGoodID(var_6_0, var_4_3.goodsId)

			return
		end)
	else
		GAME = var_4_3

		if var_4_1 == var_4_3.USE_ITEM_DONE then
			if #arg_4_1:getBody().drops > 0 then
				local var_4_5 = arg_4_0.viewComponent
				local var_4_6 = var_5.emit

				BaseUI = var_1_10008

				var_4_6(var_4_5, var_1_10008.ON_ACHIEVE, var_4)
			end
		else
			PlayerProxy = var_4

			if var_4_1 == var_4.UPDATED then
				local var_4_7 = arg_4_0.viewComponent

				var_4.updatePTPanel(var_4_7)
			end
		end
	end

	return
end

return var_0_1

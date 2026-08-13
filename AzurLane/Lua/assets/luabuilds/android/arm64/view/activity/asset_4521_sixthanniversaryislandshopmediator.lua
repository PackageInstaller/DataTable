class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandShopMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OPEN_GOODS_WINDOW = "SixthAnniversaryIslandShopMediator.OPEN_GOODS_WINDOW"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.viewComponent

	var_1.setShop(var_1_0, arg_1_0.contextData.shop)

	local var_1_1 = arg_1_0.viewComponent
	local var_1_2 = var_1.setPlayer

	getProxy = var_4
	PlayerProxy = var_1_10006

	local var_1_3 = var_4(var_1_10006)

	var_1_2(var_1_1, var_4.getData(var_1_3))
	arg_1_0:bind(var_0_1.OPEN_GOODS_WINDOW, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		SixthAnniversaryIslandShopWindowMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		SixthAnniversaryIslandShopWindowLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = {
			activityId = arg_1_0.contextData.shop.activityId,
			shop = arg_1_0.contextData.shop,
			goods = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.ISLAND_SHOPPING_DONE] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1:getBody()
		local var_4_1 = {}

		if #var_4_0.awards > 0 then
			table = var_4

			var_4.insert(var_4_1, function(arg_5_0)
				local var_5_0 = arg_4_0.viewComponent
				local var_5_1 = var_1.emit

				BaseUI = var_3_10004

				var_5_1(var_5_0, var_3_10004.ON_ACHIEVE, var_4_0.awards, arg_5_0)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_4_1, function()
			local var_6_0 = arg_4_0.viewComponent

			var_0.refreshGoodsCard(var_6_0, var_4_0.goodsId)

			return
		end)

		return
	end
	GAME = var_2
	var_3_0[var_2.USE_ITEM_DONE] = function(arg_7_0, arg_7_1)
		if #arg_7_1:getBody().drops > 0 then
			local var_7_0 = arg_7_0.viewComponent
			local var_7_1 = var_3.emit

			BaseUI = var_2_10006

			var_7_1(var_7_0, var_2_10006.ON_ACHIEVE, var_2)
		end

		return
	end
	PlayerProxy = var_2
	var_3_0[var_2.UPDATED] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1:getBody()
		local var_8_1 = arg_8_0.viewComponent

		var_3.setPlayer(var_8_1, var_8_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

return var_0_1

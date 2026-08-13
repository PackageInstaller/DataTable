class = var_0_10000

local var_0_0 = "RefreshMilitaryShopCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_1_0, 18102, {
		type = 0
	}, 18103, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ShopsProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getMeritorousShop(var_2_10003)

			pg = var_2_10003

			local var_2_1

			if not var_2_10003.arena_data_shop[1].refresh_price[var_2_0.refreshCount] then
				var_2_1 = var_2_10003.refresh_price[#var_2_10003.refresh_price]
			end

			getProxy = var_5
			PlayerProxy = var_2_10006

			local var_2_2 = var_5(var_2_10006)
			local var_2_3 = var_5.getData(var_2_2)

			var_6.consume(var_2_3, {
				gem = var_2_1
			})
			var_5:updatePlayer(var_6)

			local var_2_4 = var_2_0

			var_2_0.increaseRefreshCount(var_2_4)

			local var_2_5 = {}

			ipairs = var_2_4

			for iter_2_0, iter_2_1 in var_2_4(arg_2_0.arena_shop_list) do
				Goods = var_2_10013
				var_2_10013 = var_2_10013.Create

				local var_2_6 = iter_2_1

				Goods = var_2_10015
				var_2_5[var_2_10013(var_2_6, var_2_10015.TYPE_MILITARY).id] = var_2_10013
			end

			var_2_0:updateAllGoods(var_2_5)
			var_1:addMeritorousShop(var_2_0)

			pg = var_8

			local var_2_7 = var_8.TipsMgr.GetInstance()
			local var_2_8 = var_8.ShowTips

			i18n = var_10

			var_2_8(var_2_7, var_10("refresh_shopStreet_ok"))

			local var_2_9 = arg_1_0
			local var_2_10 = var_8.sendNotification

			GAME = var_10

			local var_2_11 = var_10.REFRESH_MILITARY_SHOP_DONE

			Clone = var_11

			var_2_10(var_2_9, var_2_11, var_11(var_2_0))
		else
			pg = var_1

			local var_2_12 = var_1.TipsMgr.GetInstance()
			local var_2_13 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_13(var_2_12, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

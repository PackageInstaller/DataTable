class = var_0_10000

local var_0_0 = "EducateShoppingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1

	var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback
	getProxy = var_1_0
	EducateProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetShopProxy(var_1_2)
	local var_1_4 = var_5.GetShopWithId(var_1_3, var_2.shopId)
	local var_1_5 = var_5
	local var_1_6 = var_5.GetDiscountById(var_1_5, var_2.shopId)
	local var_1_7 = {}

	ipairs = var_1_5

	for iter_1_0, iter_1_1 in var_1_5(var_2.goods) do
		table = var_1_10014
		var_1_10014 = var_1_10014.insert

		local var_1_8 = var_1_7
		local var_1_9 = var_1_4:GetGoodById(iter_1_1.id)

		var_1_10014(var_1_8, var_17.GetCost(var_1_9, var_1_6))
	end

	pg = var_9

	local var_1_10 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_10, 27033, {
		shop_id = var_2.shopId,
		goods = var_2.goods
	}, 27034, function(arg_2_0)
		local var_2_6

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_6.ReduceResForCosts(var_2_0, var_1_7)

			EducateHelper = var_2_6

			var_2_6.UpdateDropsData(arg_2_0.drops)

			ipairs = var_2_6

			for iter_2_0, iter_2_1 in var_2_6(var_0.goods) do
				local var_2_1 = var_1_4
				local var_2_2 = var_6.GetGoodById(var_2_1, iter_2_1.id)

				var_6.ReduceRemainCnt(var_2_2, iter_2_1.num)

				local var_2_3 = var_1_4

				var_7.UpdateGood(var_2_3, var_6)
			end

			local var_2_4 = var_0

			var_2_6.UpdateShop(var_2_4, var_1_4)

			local var_2_5 = arg_1_0

			var_2_6 = var_2_6.sendNotification
			GAME = iter_2_0

			var_2_6(var_2_5, iter_2_0.EDUCATE_SHOPPING_DONE, {
				id = var_0.shopId,
				drops = arg_2_0.drops
			})
		else
			pg = var_2_6

			local var_2_7 = var_2_6.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = iter_2_0

			var_2_8(var_2_7, iter_2_0("educate shop buy error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

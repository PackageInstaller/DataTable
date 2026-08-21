local var_0_0 = class("EducateShoppingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = getProxy(EducateProxy)
	local var_1_3 = var_1_2:GetShopProxy()
	local var_1_4 = var_1_3:GetShopWithId(var_1_0.shopId)
	local var_1_5 = var_1_3:GetDiscountById(var_1_0.shopId)
	local var_1_6 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.goods) do
		local var_1_7 = var_1_4:GetGoodById(iter_1_1.id)

		table.insert({}, var_1_7:GetCost(var_1_5))
	end

	pg.ConnectionMgr.GetInstance():Send(27033, {
		shop_id = var_1_0.shopId,
		goods = var_1_0.goods
	}, 27034, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:ReduceResForCosts(var_1_6)
			EducateHelper.UpdateDropsData(arg_2_0.drops)

			for iter_2_0, iter_2_1 in ipairs(var_1_0.goods) do
				local var_2_0 = var_1_4:GetGoodById(iter_2_1.id)

				var_2_0:ReduceRemainCnt(iter_2_1.num)
				var_1_4:UpdateGood(var_2_0)
			end

			var_1_3:UpdateShop(var_1_4)
			arg_1_0:sendNotification(GAME.EDUCATE_SHOPPING_DONE, {
				id = var_1_0.shopId,
				drops = arg_2_0.drops
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate shop buy error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0

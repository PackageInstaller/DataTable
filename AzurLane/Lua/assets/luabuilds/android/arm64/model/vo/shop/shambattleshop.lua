class = var_0_10000

local var_0_0 = "ShamBattleShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MonthlyShop"))

Goods = var_0_10001
var_0_1.GoodsType = var_0_10001.TYPE_SHAM_BATTLE
ShopArgs = var_1
var_0_1.type = var_1.ShopShamBattle

function var_0_1.update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_1

	local var_1_0 = {}

	ipairs = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10004(arg_1_2) do
		var_1_0[iter_1_1.shop_id] = iter_1_1.pay_count
	end

	table = var_4

	var_4.clear(arg_1_0.goods)

	if arg_1_0.id and arg_1_0.id > 0 and arg_1_0:getConfigTable() then
		ipairs = var_4

		for iter_1_2, iter_1_3 in var_4(arg_1_0:getConfig("core_shop_goods")) do
			local var_1_1

			if not var_1_0[iter_1_3] then
				var_1_1 = 0
			end

			local var_1_2 = arg_1_0.goods

			Goods = var_1_10011
			var_1_2[iter_1_3] = var_1_10011.Create({
				shop_id = iter_1_3,
				buy_count = var_1_1
			}, arg_1_0.GoodsType)
		end
	end

	return
end

function var_0_1.GetResList(arg_2_0)
	return {
		59900
	}
end

function var_0_1.IsSameKind(arg_3_0, arg_3_1)
	isa = var_1_10002

	local var_3_0 = arg_3_1

	ShamBattleShop = var_1_10005

	return var_1_10002(var_3_0, var_1_10005)
end

return var_0_1

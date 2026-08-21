local var_0_0 = class("ShamBattleShop", import(".MonthlyShop"))

var_0_0.GoodsType = Goods.TYPE_SHAM_BATTLE
var_0_0.type = ShopArgs.ShopShamBattle

function var_0_0.update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		({})[iter_1_1.shop_id] = iter_1_1.pay_count
	end

	table.clear(arg_1_0.goods)

	if arg_1_0.id and arg_1_0.id > 0 and arg_1_0:getConfigTable() then
		for iter_1_2, iter_1_3 in ipairs(arg_1_0:getConfig("core_shop_goods")) do
			local var_1_0 = ({})[iter_1_3]

			if not ({})[iter_1_3] then
				var_1_0 = 0
			end

			arg_1_0.goods[iter_1_3] = Goods.Create({
				shop_id = iter_1_3,
				buy_count = var_1_0
			}, arg_1_0.GoodsType)
		end
	end

	return
end

function var_0_0.GetResList(arg_2_0)
	return {
		59900
	}
end

function var_0_0.IsSameKind(arg_3_0, arg_3_1)
	return isa(arg_3_1, ShamBattleShop)
end

return var_0_0

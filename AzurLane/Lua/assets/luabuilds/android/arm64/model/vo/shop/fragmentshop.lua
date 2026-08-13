class = var_0_10000

local var_0_0 = "FragmentShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MonthlyShop"))

Goods = var_0_10001
var_0_1.GoodsType = var_0_10001.TYPE_FRAGMENT
ShopArgs = var_1
var_0_1.type = var_1.ShopFragment

function var_0_1.update(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_1

	local var_1_0 = {}

	ipairs = var_1_10005

	for iter_1_0, iter_1_1 in var_1_10005(arg_1_2) do
		var_1_0[iter_1_1.shop_id] = iter_1_1.pay_count
	end

	ipairs = var_5

	for iter_1_2, iter_1_3 in var_5(arg_1_3) do
		var_1_0[iter_1_3.shop_id] = iter_1_3.pay_count
	end

	table = var_5

	var_5.clear(arg_1_0.goods)

	if arg_1_0.id then
		local var_1_1 = arg_1_0.id

		if 0 < var_1_1 and arg_1_0:getConfigTable() then
			local function var_1_2(arg_2_0, arg_2_1)
				local var_2_0

				if not var_1_0[arg_2_0] then
					var_2_0 = 0
				end

				local var_2_1 = arg_1_0.goods

				Goods = var_2_10004
				var_2_1[arg_2_0] = var_2_10004.Create({
					shop_id = arg_2_0,
					buy_count = var_2_0
				}, arg_2_1)

				return
			end

			ipairs = var_6

			for iter_1_4, iter_1_5 in var_6(arg_1_0:getConfig("blueprint_shop_goods")) do
				local var_1_3 = var_1_2
				local var_1_4 = iter_1_5

				Goods = var_1_10014

				var_1_3(var_1_4, var_1_10014.TYPE_FRAGMENT)
			end

			ipairs = var_6

			for iter_1_6, iter_1_7 in var_6(arg_1_0:getConfig("blueprint_shop_limit_goods")) do
				local var_1_5 = var_1_2
				local var_1_6 = iter_1_7

				Goods = var_1_10014

				var_1_5(var_1_6, var_1_10014.TYPE_FRAGMENT_NORMAL)
			end
		end
	end

	return
end

function var_0_1.Reset(arg_3_0, arg_3_1)
	local var_3_0 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0:getConfig("blueprint_shop_limit_goods")) do
		if arg_3_0.goods[iter_3_1] then
			table = var_1_10009

			var_1_10009.insert(var_3_0, {
				shop_id = iter_3_1,
				pay_count = var_8.buyCount
			})
		end
	end

	arg_3_0:update(arg_3_1, {}, var_3_0)

	return
end

function var_0_1.IsSameKind(arg_4_0, arg_4_1)
	isa = var_1_10002

	local var_4_0 = arg_4_1

	FragmentShop = var_1_10005

	return var_1_10002(var_4_0, var_1_10005)
end

return var_0_1

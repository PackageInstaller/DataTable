class = var_0_10000

local var_0_0 = "QuotaShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShop"))

function var_0_1.Ctor(arg_1_0)
	ShopArgs = var_1_10001
	arg_1_0.type = var_1_10001.ShopQuota
	pg = var_1

	local var_1_0 = var_1.quota_shop_template[1].shop_goods

	arg_1_0.goods = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.getOwnedGoodCount(var_1_1, iter_1_1)
		local var_1_3 = arg_1_0.goods

		Goods = var_1_1

		local var_1_4 = var_1_1.Create
		local var_1_5 = {
			shop_id = iter_1_1
		}

		Goods = var_1_10012
		var_1_3[iter_1_1] = var_1_4(var_1_5, var_1_10012.TYPE_QUOTA)
	end

	return
end

function var_0_1.getOwnedGoodCount(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.activity_shop_template[arg_2_1]

	assert = var_1_10003

	var_1_10003(var_2_0, "config is missing in activity_shop_template, id: " .. arg_2_1)

	Drop = var_1_10003

	local var_2_1 = var_1_10003.New({
		id = var_2_0.commodity_id,
		type = var_2_0.commodity_type,
		count = var_2_0.num
	})

	return var_3.getOwnedCount(var_2_1)
end

function var_0_1.IsSameKind(arg_3_0, arg_3_1)
	isa = var_1_10002

	local var_3_0 = arg_3_1

	QuotaShop = var_1_10005

	return var_1_10002(var_3_0, var_1_10005)
end

function var_0_1.GetCommodityById(arg_4_0, arg_4_1)
	return arg_4_0:getGoodsById(arg_4_1)
end

function var_0_1.GetCommodities(arg_5_0)
	return arg_5_0:getSortGoods()
end

function var_0_1.getSortGoods(arg_6_0)
	local var_6_0 = {}

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_6_0, iter_6_1)
	end

	table = var_2

	local var_6_1 = var_2.sort
	local var_6_2 = var_6_0

	CompareFuncs = iter_6_0

	var_6_1(var_6_2, iter_6_0({
		function(arg_7_0)
			return arg_7_0:canPurchase() and 0 or 1
		end,
		function(arg_8_0)
			return arg_8_0:getConfig("order")
		end,
		function(arg_9_0)
			return arg_9_0.id
		end
	}))

	return var_6_0
end

function var_0_1.getGoodsCfg(arg_10_0, arg_10_1)
	pg = var_1_10002

	return var_1_10002.activity_shop_template[arg_10_1]
end

function var_0_1.getGoodsById(arg_11_0, arg_11_1)
	assert = var_1_10002

	var_1_10002(arg_11_0.goods[arg_11_1], "goods should exist")

	return arg_11_0.goods[arg_11_1]
end

function var_0_1.getLimitGoodCount(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.activity_shop_template[arg_12_1].limit_args

	type = var_1_10003

	if var_1_10003(var_12_0) == "table" then
		ipairs = var_3

		for iter_12_0, iter_12_1 in var_3(var_12_0) do
			if iter_12_1[1] == "quota" then
				return iter_12_1[2]
			end
		end
	end

	assert = var_3

	var_3(false, "good not limit_args 'quota' with good id: " .. arg_12_1)

	return
end

function var_0_1.GetResList(arg_13_0)
	return {
		59900
	}
end

return var_0_1

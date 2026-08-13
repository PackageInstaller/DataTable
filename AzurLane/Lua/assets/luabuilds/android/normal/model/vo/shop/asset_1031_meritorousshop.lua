class = var_0_10000

local var_0_0 = "MeritorousShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseShop"))

var_0_1.REFRESH_TYPE_AUTO = 1
var_0_1.REFRESH_TYPE_MANUAL = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.goods = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.good_list) do
		Goods = var_1_10007
		var_1_10007 = var_1_10007.Create

		local var_1_0 = iter_1_1

		Goods = var_1_10009
		var_1_10007 = var_1_10007(var_1_0, var_1_10009.TYPE_MILITARY)
		arg_1_0.goods[var_1_10007.id] = var_1_10007
	end

	arg_1_0.nextTime = arg_1_1.nextTime
	arg_1_0.refreshCount = arg_1_1.refreshCount + 1
	ShopArgs = var_2
	arg_1_0.type = var_2.MilitaryShop

	return
end

function var_0_1.IsSameKind(arg_2_0, arg_2_1)
	isa = var_1_10002

	local var_2_0 = arg_2_1

	MeritorousShop = var_1_10004

	return var_1_10002(var_2_0, var_1_10004)
end

function var_0_1.GetCommodityById(arg_3_0, arg_3_1)
	return arg_3_0:getGoodsById(arg_3_1)
end

function var_0_1.GetCommodities(arg_4_0)
	local var_4_0 = {}

	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_4_0, iter_4_1)
	end

	table = var_2

	var_2.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_0:getConfig("order") < arg_5_1:getConfig("order")
	end)

	return var_4_0
end

function var_0_1.bindConfigTable(arg_6_0)
	pg = var_1_10001

	return var_1_10001.arena_data_shop
end

function var_0_1.getRefreshCount(arg_7_0)
	return arg_7_0.refreshCount
end

function var_0_1.resetRefreshCount(arg_8_0)
	arg_8_0.refreshCount = 1

	return
end

function var_0_1.increaseRefreshCount(arg_9_0)
	arg_9_0.refreshCount = arg_9_0.refreshCount + 1

	return
end

function var_0_1.updateAllGoods(arg_10_0, arg_10_1)
	arg_10_0.goods = arg_10_1

	return
end

function var_0_1.getGoodsById(arg_11_0, arg_11_1)
	assert = var_1_10002

	var_1_10002(arg_11_0.goods[arg_11_1], "should exist good" .. arg_11_1)

	Clone = var_1_10002

	return var_1_10002(arg_11_0.goods[arg_11_1])
end

function var_0_1.updateGoods(arg_12_0, arg_12_1)
	assert = var_1_10002

	var_1_10002(arg_12_0.goods[arg_12_1.id], "should exist good" .. arg_12_1.id)

	arg_12_0.goods[arg_12_1.id] = arg_12_1

	return
end

function var_0_1.GetResList(arg_13_0)
	local var_13_0 = {}

	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.goods) do
		var_1_10008 = iter_13_1
		var_13_0[iter_13_1.getConfig(var_1_10008, "resource_type")] = true
	end

	local var_13_1 = {}

	pairs = var_3

	for iter_13_2, iter_13_3 in var_3(var_13_0) do
		table = var_1_10008

		var_1_10008.insert(var_13_1, iter_13_2)
	end

	return var_13_1
end

return var_0_1

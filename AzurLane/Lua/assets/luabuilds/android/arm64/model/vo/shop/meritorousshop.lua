local var_0_0 = class("MeritorousShop", import(".BaseShop"))

var_0_0.REFRESH_TYPE_AUTO = 1
var_0_0.REFRESH_TYPE_MANUAL = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.goods = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.good_list) do
		local var_1_0 = Goods.Create(iter_1_1, Goods.TYPE_MILITARY)

		arg_1_0.goods[var_1_0.id] = var_1_0
	end

	arg_1_0.nextTime = arg_1_1.nextTime
	arg_1_0.refreshCount = arg_1_1.refreshCount + 1
	arg_1_0.type = ShopArgs.MilitaryShop

	return
end

function var_0_0.IsSameKind(arg_2_0, arg_2_1)
	return isa(arg_2_1, MeritorousShop)
end

function var_0_0.GetCommodityById(arg_3_0, arg_3_1)
	return arg_3_0:getGoodsById(arg_3_1)
end

function var_0_0.GetCommodities(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.goods) do
		table.insert({}, iter_4_1)
	end

	table.sort({}, function(arg_5_0, arg_5_1)
		return arg_5_0:getConfig("order") < arg_5_1:getConfig("order")
	end)

	return {}
end

function var_0_0.bindConfigTable(arg_6_0)
	return pg.arena_data_shop
end

function var_0_0.getRefreshCount(arg_7_0)
	return arg_7_0.refreshCount
end

function var_0_0.resetRefreshCount(arg_8_0)
	arg_8_0.refreshCount = 1

	return
end

function var_0_0.increaseRefreshCount(arg_9_0)
	arg_9_0.refreshCount = arg_9_0.refreshCount + 1

	return
end

function var_0_0.updateAllGoods(arg_10_0, arg_10_1)
	arg_10_0.goods = arg_10_1

	return
end

function var_0_0.getGoodsById(arg_11_0, arg_11_1)
	assert(arg_11_0.goods[arg_11_1], "should exist good" .. arg_11_1)

	return Clone(arg_11_0.goods[arg_11_1])
end

function var_0_0.updateGoods(arg_12_0, arg_12_1)
	assert(arg_12_0.goods[arg_12_1.id], "should exist good" .. arg_12_1.id)

	arg_12_0.goods[arg_12_1.id] = arg_12_1

	return
end

function var_0_0.GetResList(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.goods) do
		({})[iter_13_1:getConfig("resource_type")] = true
	end

	for iter_13_2, iter_13_3 in pairs({}) do
		table.insert({}, iter_13_2)
	end

	return {}
end

return var_0_0

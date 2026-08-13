class = var_0_10000

local var_0_0 = "GuildShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShop"))

var_0_1.AUTO_REFRESH = 1
var_0_1.MANUAL_REFRESH = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.id then
		var_1_0 = 1
	end

	arg_1_0.id = var_1_0
	arg_1_0.configId = arg_1_0.id
	arg_1_0.goods = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.good_list) do
		GuildGoods = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_1)
		arg_1_0.goods[var_1_10007.id] = var_1_10007
	end

	arg_1_0.refreshCount = arg_1_1.refresh_count
	arg_1_0.nextTime = arg_1_1.next_refresh_time
	ShopArgs = var_2
	arg_1_0.type = var_2.ShopGUILD

	return
end

function var_0_1.IsSameKind(arg_2_0, arg_2_1)
	isa = var_1_10002

	local var_2_0 = arg_2_1

	GuildShop = var_1_10005

	return var_1_10002(var_2_0, var_1_10005)
end

function var_0_1.GetCommodityById(arg_3_0, arg_3_1)
	return arg_3_0:getGoodsById(arg_3_1)
end

function var_0_1.GetCommodities(arg_4_0)
	return arg_4_0:getSortGoods()
end

function var_0_1.updateNextRefreshTime(arg_5_0, arg_5_1)
	arg_5_0.nextTime = arg_5_1

	return
end

function var_0_1.CanRefresh(arg_6_0)
	return arg_6_0.refreshCount <= 0
end

function var_0_1.getSortGoods(arg_7_0)
	local var_7_0 = {}

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_7_0, iter_7_1)
	end

	table = var_2

	var_2.sort(var_7_0, function(arg_8_0, arg_8_1)
		local var_8_0

		if not arg_8_0:getConfig("order") then
			var_8_0 = 0
		end

		local var_8_1

		if not arg_8_1:getConfig("order") then
			var_8_1 = 0
		end

		if var_8_0 == var_8_1 then
			return arg_8_0.id < arg_8_1.id
		else
			return var_8_1 < var_8_0
		end

		return
	end)

	return var_7_0
end

function var_0_1.getGoodsById(arg_9_0, arg_9_1)
	assert = var_1_10002

	var_1_10002(arg_9_0.goods[arg_9_1], "goods should exist")

	return arg_9_0.goods[arg_9_1]
end

function var_0_1.GetResetConsume(arg_10_0)
	pg = var_1_10001

	return var_1_10001.guildset.store_reset_cost.key_value
end

function var_0_1.UpdateGoodsCnt(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getGoodsById(arg_11_1)

	var_3.UpdateCnt(var_11_0, arg_11_2)

	return
end

function var_0_1.GetResList(arg_12_0)
	return {
		8
	}
end

return var_0_1

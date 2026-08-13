class = var_0_10000

local var_0_0 = "MedalShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShop"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.goods = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.good_list) do
		MedalGoods = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_1)
		var_1_10007.id = iter_1_0
		arg_1_0.goods[iter_1_0] = var_1_10007
	end

	arg_1_0.nextTime = arg_1_1.item_flash_time
	ShopArgs = var_2
	arg_1_0.type = var_2.ShopMedal

	return
end

function var_0_1.IsSameKind(arg_2_0, arg_2_1)
	isa = var_1_10002

	local var_2_0 = arg_2_1

	MedalShop = var_1_10005

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
	return false
end

function var_0_1.getSortGoods(arg_7_0)
	underscore = var_1_10001

	local var_7_0 = var_1_10001.values(arg_7_0.goods)

	table = var_1_10002

	local var_7_1 = var_1_10002.sort
	local var_7_2 = var_7_0

	CompareFuncs = var_1_10005

	var_7_1(var_7_2, var_1_10005({
		function(arg_8_0)
			return arg_8_0:CanPurchase() and 0 or 1
		end,
		function(arg_9_0)
			return arg_9_0:getConfig("order")
		end
	}))

	return var_7_0
end

function var_0_1.getGoodsById(arg_10_0, arg_10_1)
	assert = var_1_10002

	var_1_10002(arg_10_0.goods[arg_10_1], "goods should exist")

	return arg_10_0.goods[arg_10_1]
end

function var_0_1.GetResetConsume(arg_11_0)
	pg = var_1_10001

	return var_1_10001.guildset.store_reset_cost.key_value
end

function var_0_1.UpdateGoodsCnt(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getGoodsById(arg_12_1)

	var_3.UpdateCnt(var_12_0, arg_12_2)

	return
end

function var_0_1.GetResList(arg_13_0)
	local var_13_0 = {}

	ITEM_ID_SILVER_HOOK = var_1_10002
	var_13_0[1] = var_1_10002

	return var_13_0
end

return var_0_1

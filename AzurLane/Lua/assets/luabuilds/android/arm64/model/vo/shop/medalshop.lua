local var_0_0 = class("MedalShop", import(".BaseShop"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.goods = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.good_list) do
		local var_1_0 = MedalGoods.New(iter_1_1)

		var_1_0.id = iter_1_0
		arg_1_0.goods[iter_1_0] = var_1_0
	end

	arg_1_0.nextTime = arg_1_1.item_flash_time
	arg_1_0.type = ShopArgs.ShopMedal

	return
end

function var_0_0.IsSameKind(arg_2_0, arg_2_1)
	return isa(arg_2_1, MedalShop)
end

function var_0_0.GetCommodityById(arg_3_0, arg_3_1)
	return arg_3_0:getGoodsById(arg_3_1)
end

function var_0_0.GetCommodities(arg_4_0)
	return arg_4_0:getSortGoods()
end

function var_0_0.updateNextRefreshTime(arg_5_0, arg_5_1)
	arg_5_0.nextTime = arg_5_1

	return
end

function var_0_0.CanRefresh(arg_6_0)
	return false
end

function var_0_0.getSortGoods(arg_7_0)
	local var_7_0 = underscore.values(arg_7_0.goods)

	table.sort(var_7_0, CompareFuncs({
		function(arg_8_0)
			return arg_8_0:CanPurchase() and 0 or 1
		end,
		function(arg_9_0)
			return arg_9_0:getConfig("order")
		end
	}))

	return var_7_0
end

function var_0_0.getGoodsById(arg_10_0, arg_10_1)
	assert(arg_10_0.goods[arg_10_1], "goods should exist")

	return arg_10_0.goods[arg_10_1]
end

function var_0_0.GetResetConsume(arg_11_0)
	return pg.guildset.store_reset_cost.key_value
end

function var_0_0.UpdateGoodsCnt(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:getGoodsById(arg_12_1):UpdateCnt(arg_12_2)

	return
end

function var_0_0.GetResList(arg_13_0)
	return {
		ITEM_ID_SILVER_HOOK
	}
end

return var_0_0

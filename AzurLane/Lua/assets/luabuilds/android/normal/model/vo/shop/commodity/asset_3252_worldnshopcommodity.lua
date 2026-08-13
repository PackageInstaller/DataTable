class = var_0_10000

local var_0_0 = "WorldNShopCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseCommodity"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.world_newshop_data
end

function var_0_1.canPurchase(arg_2_0)
	return arg_2_0:GetPurchasableCnt() > 0
end

function var_0_1.GetPurchasableCnt(arg_3_0)
	return arg_3_0:GetLimitGoodCount() - arg_3_0.buyCount
end

function var_0_1.GetLimitGoodCount(arg_4_0)
	return arg_4_0:getConfig("frequency")
end

function var_0_1.GetDropInfo(arg_5_0)
	Drop = var_1_10001

	return var_1_10001.New({
		type = arg_5_0:getConfig("item_type"),
		id = arg_5_0:getConfig("item_id"),
		count = arg_5_0:getConfig("item_num")
	})
end

function var_0_1.GetPriceInfo(arg_6_0)
	Drop = var_1_10001

	return var_1_10001.New({
		type = arg_6_0:getConfig("price_type"),
		id = arg_6_0:getConfig("price_id"),
		count = arg_6_0:getConfig("price_num")
	})
end

return var_0_1

local var_0_0 = class("WorldNShopCommodity", import(".BaseCommodity"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.world_newshop_data
end

function var_0_0.canPurchase(arg_2_0)
	return arg_2_0:GetPurchasableCnt() > 0
end

function var_0_0.GetPurchasableCnt(arg_3_0)
	return arg_3_0:GetLimitGoodCount() - arg_3_0.buyCount
end

function var_0_0.GetLimitGoodCount(arg_4_0)
	return arg_4_0:getConfig("frequency")
end

function var_0_0.GetDropInfo(arg_5_0)
	return Drop.New({
		type = arg_5_0:getConfig("item_type"),
		id = arg_5_0:getConfig("item_id"),
		count = arg_5_0:getConfig("item_num")
	})
end

function var_0_0.GetPriceInfo(arg_6_0)
	return Drop.New({
		type = arg_6_0:getConfig("price_type"),
		id = arg_6_0:getConfig("price_id"),
		count = arg_6_0:getConfig("price_num")
	})
end

return var_0_0

local var_0_0 = class("QuotaShop", import(".BaseShop"))

function var_0_0.Ctor(arg_1_0)
	arg_1_0.type = ShopArgs.ShopQuota
	arg_1_0.goods = {}

	for iter_1_0, iter_1_1 in ipairs(pg.quota_shop_template[1].shop_goods) do
		local var_1_0 = arg_1_0:getOwnedGoodCount(iter_1_1)

		arg_1_0.goods[iter_1_1] = Goods.Create({
			shop_id = iter_1_1
		}, Goods.TYPE_QUOTA)
	end

	return
end

function var_0_0.getOwnedGoodCount(arg_2_0, arg_2_1)
	assert(pg.activity_shop_template[arg_2_1], "config is missing in activity_shop_template, id: " .. arg_2_1)

	return Drop.New({
		id = pg.activity_shop_template[arg_2_1].commodity_id,
		type = pg.activity_shop_template[arg_2_1].commodity_type,
		count = pg.activity_shop_template[arg_2_1].num
	}):getOwnedCount()
end

function var_0_0.IsSameKind(arg_3_0, arg_3_1)
	return isa(arg_3_1, QuotaShop)
end

function var_0_0.GetCommodityById(arg_4_0, arg_4_1)
	return arg_4_0:getGoodsById(arg_4_1)
end

function var_0_0.GetCommodities(arg_5_0)
	return arg_5_0:getSortGoods()
end

function var_0_0.getSortGoods(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.goods) do
		table.insert({}, iter_6_1)
	end

	table.sort({}, CompareFuncs({
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

	return {}
end

function var_0_0.getGoodsCfg(arg_10_0, arg_10_1)
	return pg.activity_shop_template[arg_10_1]
end

function var_0_0.getGoodsById(arg_11_0, arg_11_1)
	assert(arg_11_0.goods[arg_11_1], "goods should exist")

	return arg_11_0.goods[arg_11_1]
end

function var_0_0.getLimitGoodCount(arg_12_0, arg_12_1)
	if type(pg.activity_shop_template[arg_12_1].limit_args) == "table" then
		for iter_12_0, iter_12_1 in ipairs(pg.activity_shop_template[arg_12_1].limit_args) do
			if iter_12_1[1] == "quota" then
				return iter_12_1[2]
			end
		end
	end

	assert(false, "good not limit_args 'quota' with good id: " .. arg_12_1)

	return
end

function var_0_0.GetResList(arg_13_0)
	return {
		59900
	}
end

return var_0_0

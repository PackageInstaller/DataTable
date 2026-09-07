local QuotaShop = class("QuotaShop", import(".BaseShop"))

function QuotaShop:Ctor()
	self.type = ShopArgs.ShopQuota
	self.goods = {}

	for iter_1_0, iter_1_1 in ipairs(pg.quota_shop_template[1].shop_goods) do
		local var_1_0 = self:getOwnedGoodCount(iter_1_1)

		self.goods[iter_1_1] = Goods.Create({
			shop_id = iter_1_1
		}, Goods.TYPE_QUOTA)
	end

	return
end

function QuotaShop:getOwnedGoodCount(arg_2_1)
	assert(pg.activity_shop_template[arg_2_1], "config is missing in activity_shop_template, id: " .. arg_2_1)

	return Drop.New({
		id = pg.activity_shop_template[arg_2_1].commodity_id,
		type = pg.activity_shop_template[arg_2_1].commodity_type,
		count = pg.activity_shop_template[arg_2_1].num
	}):getOwnedCount()
end

function QuotaShop:IsSameKind(arg_3_1)
	return isa(arg_3_1, QuotaShop)
end

function QuotaShop:GetCommodityById(arg_4_1)
	return self:getGoodsById(arg_4_1)
end

function QuotaShop:GetCommodities()
	return self:getSortGoods()
end

function QuotaShop:getSortGoods()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.goods) do
		table.insert(var_6_0, iter_6_1)
	end

	table.sort(var_6_0, CompareFuncs({
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

function QuotaShop:getGoodsCfg(arg_10_1)
	return pg.activity_shop_template[arg_10_1]
end

function QuotaShop:getGoodsById(arg_11_1)
	assert(self.goods[arg_11_1], "goods should exist")

	return self.goods[arg_11_1]
end

function QuotaShop:getLimitGoodCount(arg_12_1)
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

function QuotaShop:GetResList()
	return {
		59900
	}
end

return QuotaShop

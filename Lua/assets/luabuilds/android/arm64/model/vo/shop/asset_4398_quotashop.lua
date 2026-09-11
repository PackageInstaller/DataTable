local QuotaShop = class("QuotaShop", import(".BaseShop"))

function QuotaShop:Ctor()
	self.type = ShopArgs.ShopQuota
	self.goods = {}

	for iter_1_0, iter_1_1 in ipairs(pg.quota_shop_template[1].shop_goods) do
		self.goods[iter_1_1] = Goods.Create({
			shop_id = iter_1_1
		}, Goods.TYPE_QUOTA)
	end

	return
end

function QuotaShop:IsSameKind(arg_2_1)
	return isa(arg_2_1, QuotaShop)
end

function QuotaShop:GetCommodityById(arg_3_1)
	return self:getGoodsById(arg_3_1)
end

function QuotaShop:GetCommodities()
	return self:getSortGoods()
end

function QuotaShop:getSortGoods()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.goods) do
		table.insert(var_5_0, iter_5_1)
	end

	table.sort(var_5_0, CompareFuncs({
		function(arg_6_0)
			return arg_6_0:canPurchase() and 0 or 1
		end,
		function(arg_7_0)
			return arg_7_0:getConfig("order")
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	return var_5_0
end

function QuotaShop:getGoodsCfg(arg_9_1)
	return pg.activity_shop_template[arg_9_1]
end

function QuotaShop:getGoodsById(arg_10_1)
	assert(self.goods[arg_10_1], "goods should exist")

	return self.goods[arg_10_1]
end

function QuotaShop:getLimitGoodCount(arg_11_1)
	if type(pg.activity_shop_template[arg_11_1].limit_args) == "table" then
		for iter_11_0, iter_11_1 in ipairs(pg.activity_shop_template[arg_11_1].limit_args) do
			if iter_11_1[1] == "quota" then
				return iter_11_1[2]
			end
		end
	end

	assert(false, "good not limit_args 'quota' with good id: " .. arg_11_1)

	return
end

function QuotaShop:GetResList()
	return {
		59900
	}
end

return QuotaShop

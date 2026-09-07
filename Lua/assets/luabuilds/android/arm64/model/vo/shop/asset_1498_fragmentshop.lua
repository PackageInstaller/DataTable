local FragmentShop = class("FragmentShop", import(".MonthlyShop"))

FragmentShop.GoodsType = Goods.TYPE_FRAGMENT
FragmentShop.type = ShopArgs.ShopFragment

function FragmentShop:update(arg_1_1, arg_1_2, arg_1_3)
	self.id = arg_1_1
	self.configId = arg_1_1

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		var_1_0[iter_1_1.shop_id] = iter_1_1.pay_count
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_3) do
		var_1_0[iter_1_3.shop_id] = iter_1_3.pay_count
	end

	table.clear(self.goods)

	if self.id and self.id > 0 and self:getConfigTable() then
		local function var_1_1(arg_2_0, arg_2_1)
			local var_2_0 = var_1_0[arg_2_0] or 0

			self.goods[arg_2_0] = Goods.Create({
				shop_id = arg_2_0,
				buy_count = var_2_0
			}, arg_2_1)

			return
		end

		for iter_1_4, iter_1_5 in ipairs(self:getConfig("blueprint_shop_goods")) do
			var_1_1(iter_1_5, Goods.TYPE_FRAGMENT)
		end

		for iter_1_6, iter_1_7 in ipairs(self:getConfig("blueprint_shop_limit_goods")) do
			var_1_1(iter_1_7, Goods.TYPE_FRAGMENT_NORMAL)
		end
	end

	return
end

function FragmentShop:Reset(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self:getConfig("blueprint_shop_limit_goods")) do
		if self.goods[iter_3_1] then
			table.insert(var_3_0, {
				shop_id = iter_3_1,
				pay_count = self.goods[iter_3_1].buyCount
			})
		end
	end

	self:update(arg_3_1, {}, var_3_0)

	return
end

function FragmentShop:IsSameKind(arg_4_1)
	return isa(arg_4_1, FragmentShop)
end

return FragmentShop

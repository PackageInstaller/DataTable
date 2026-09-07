local MeritorousShop = class("MeritorousShop", import(".BaseShop"))

MeritorousShop.REFRESH_TYPE_AUTO = 1
MeritorousShop.REFRESH_TYPE_MANUAL = 2

function MeritorousShop:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.goods = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.good_list) do
		local var_1_0 = Goods.Create(iter_1_1, Goods.TYPE_MILITARY)

		self.goods[var_1_0.id] = var_1_0
	end

	self.nextTime = arg_1_1.nextTime
	self.refreshCount = arg_1_1.refreshCount + 1
	self.type = ShopArgs.MilitaryShop

	return
end

function MeritorousShop:IsSameKind(arg_2_1)
	return isa(arg_2_1, MeritorousShop)
end

function MeritorousShop:GetCommodityById(arg_3_1)
	return self:getGoodsById(arg_3_1)
end

function MeritorousShop:GetCommodities()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.goods) do
		table.insert(var_4_0, iter_4_1)
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_0:getConfig("order") < arg_5_1:getConfig("order")
	end)

	return var_4_0
end

function MeritorousShop:bindConfigTable()
	return pg.arena_data_shop
end

function MeritorousShop:getRefreshCount()
	return self.refreshCount
end

function MeritorousShop:resetRefreshCount()
	self.refreshCount = 1

	return
end

function MeritorousShop:increaseRefreshCount()
	self.refreshCount = self.refreshCount + 1

	return
end

function MeritorousShop:updateAllGoods(arg_10_1)
	self.goods = arg_10_1

	return
end

function MeritorousShop:getGoodsById(arg_11_1)
	assert(self.goods[arg_11_1], "should exist good" .. arg_11_1)

	return Clone(self.goods[arg_11_1])
end

function MeritorousShop:updateGoods(arg_12_1)
	assert(self.goods[arg_12_1.id], "should exist good" .. arg_12_1.id)

	self.goods[arg_12_1.id] = arg_12_1

	return
end

function MeritorousShop:GetResList()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self.goods) do
		var_13_0[iter_13_1:getConfig("resource_type")] = true
	end

	local var_13_1 = {}

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		table.insert(var_13_1, iter_13_2)
	end

	return var_13_1
end

return MeritorousShop

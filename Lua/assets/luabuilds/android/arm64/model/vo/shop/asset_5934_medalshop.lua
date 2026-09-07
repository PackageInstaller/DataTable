local MedalShop = class("MedalShop", import(".BaseShop"))

function MedalShop:Ctor(arg_1_1)
	self.goods = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.good_list) do
		local var_1_0 = MedalGoods.New(iter_1_1)

		var_1_0.id = iter_1_0
		self.goods[iter_1_0] = var_1_0
	end

	self.nextTime = arg_1_1.item_flash_time
	self.type = ShopArgs.ShopMedal

	return
end

function MedalShop:IsSameKind(arg_2_1)
	return isa(arg_2_1, MedalShop)
end

function MedalShop:GetCommodityById(arg_3_1)
	return self:getGoodsById(arg_3_1)
end

function MedalShop:GetCommodities()
	return self:getSortGoods()
end

function MedalShop:updateNextRefreshTime(arg_5_1)
	self.nextTime = arg_5_1

	return
end

function MedalShop:CanRefresh()
	return false
end

function MedalShop:getSortGoods()
	local var_7_0 = underscore.values(self.goods)

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

function MedalShop:getGoodsById(arg_10_1)
	assert(self.goods[arg_10_1], "goods should exist")

	return self.goods[arg_10_1]
end

function MedalShop:GetResetConsume()
	return pg.guildset.store_reset_cost.key_value
end

function MedalShop:UpdateGoodsCnt(arg_12_1, arg_12_2)
	self:getGoodsById(arg_12_1):UpdateCnt(arg_12_2)

	return
end

function MedalShop:GetResList()
	return {
		ITEM_ID_SILVER_HOOK
	}
end

return MedalShop

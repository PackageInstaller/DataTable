local GuildShop = class("GuildShop", import(".BaseShop"))

GuildShop.AUTO_REFRESH = 1
GuildShop.MANUAL_REFRESH = 2

function GuildShop:Ctor(arg_1_1)
	self.id = arg_1_1.id or 1
	self.configId = self.id
	self.goods = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.good_list) do
		local var_1_0 = GuildGoods.New(iter_1_1)

		self.goods[var_1_0.id] = var_1_0
	end

	self.refreshCount = arg_1_1.refresh_count
	self.nextTime = arg_1_1.next_refresh_time
	self.type = ShopArgs.ShopGUILD

	return
end

function GuildShop:IsSameKind(arg_2_1)
	return isa(arg_2_1, GuildShop)
end

function GuildShop:GetCommodityById(arg_3_1)
	return self:getGoodsById(arg_3_1)
end

function GuildShop:GetCommodities()
	return self:getSortGoods()
end

function GuildShop:updateNextRefreshTime(arg_5_1)
	self.nextTime = arg_5_1

	return
end

function GuildShop:CanRefresh()
	return self.refreshCount <= 0
end

function GuildShop:getSortGoods()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.goods) do
		table.insert(var_7_0, iter_7_1)
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0:getConfig("order") or 0
		local var_8_1 = arg_8_1:getConfig("order") or 0

		if var_8_0 == var_8_1 then
			return arg_8_0.id < arg_8_1.id
		else
			return var_8_1 < var_8_0
		end

		return
	end)

	return var_7_0
end

function GuildShop:getGoodsById(arg_9_1)
	assert(self.goods[arg_9_1], "goods should exist")

	return self.goods[arg_9_1]
end

function GuildShop:GetResetConsume()
	return pg.guildset.store_reset_cost.key_value
end

function GuildShop:UpdateGoodsCnt(arg_11_1, arg_11_2)
	self:getGoodsById(arg_11_1):UpdateCnt(arg_11_2)

	return
end

function GuildShop:GetResList()
	return {
		8
	}
end

return GuildShop

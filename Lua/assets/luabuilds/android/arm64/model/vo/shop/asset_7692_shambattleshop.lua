local ShamBattleShop = class("ShamBattleShop", import(".MonthlyShop"))

ShamBattleShop.GoodsType = Goods.TYPE_SHAM_BATTLE
ShamBattleShop.type = ShopArgs.ShopShamBattle

function ShamBattleShop:update(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.configId = arg_1_1

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		var_1_0[iter_1_1.shop_id] = iter_1_1.pay_count
	end

	table.clear(self.goods)

	if self.id and self.id > 0 and self:getConfigTable() then
		for iter_1_2, iter_1_3 in ipairs(self:getConfig("core_shop_goods")) do
			local var_1_1 = var_1_0[iter_1_3] or 0

			self.goods[iter_1_3] = Goods.Create({
				shop_id = iter_1_3,
				buy_count = var_1_1
			}, self.GoodsType)
		end
	end

	return
end

function ShamBattleShop:GetResList()
	return {
		59900
	}
end

function ShamBattleShop:IsSameKind(arg_3_1)
	return isa(arg_3_1, ShamBattleShop)
end

return ShamBattleShop

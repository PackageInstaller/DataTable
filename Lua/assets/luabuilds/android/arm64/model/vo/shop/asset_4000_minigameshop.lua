local MiniGameShop = class("MiniGameShop", import(".BaseShop"))

function MiniGameShop:Ctor(arg_1_1)
	self.goodsData = arg_1_1.goods
	self.nextFlashTime = arg_1_1.next_flash_time
	self.goods = {}

	for iter_1_0, iter_1_1 in ipairs(pg.gameroom_shop_template.all) do
		local var_1_0 = Goods.Create(pg.gameroom_shop_template[iter_1_1], Goods.TYPE_MINI_GAME)

		var_1_0:UpdateCnt(self:getGoodData(iter_1_1) or 0)

		self.goods[var_1_0:getId()] = var_1_0
	end

	self.type = ShopArgs.ShopMiniGame

	return
end

function MiniGameShop:setNextTime(arg_2_1)
	self.nextFlashTime = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(self.goodsData) do
		local var_2_0 = false

		if pg.gameroom_shop_template[iter_2_1.id] then
			var_2_0 = pg.gameroom_shop_template[iter_2_1.id].month_re ~= 0
		else
			warning("gameroom_shop_template 不存在 id = " .. tostring(iter_2_1.id) .. "的物品")
		end

		if var_2_0 then
			self.goodsData[iter_2_0].count = 0
		end
	end

	return
end

function MiniGameShop:checkShopFlash()
	if self.nextFlashTime and self.nextFlashTime > 0 then
		return pg.TimeMgr.GetInstance():GetServerTime() > self.nextFlashTime
	end

	return false
end

function MiniGameShop:getGoodData(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.goodsData) do
		if iter_4_1 and iter_4_1.id == arg_4_1 then
			return iter_4_1.count
		end
	end

	return
end

function MiniGameShop:consume(arg_5_1, arg_5_2)
	self.goods[arg_5_1]:UpdateCnt(arg_5_2)

	return
end

function MiniGameShop:IsSameKind(arg_6_1)
	return isa(arg_6_1, MiniGameShop)
end

function MiniGameShop:GetCommodityById(arg_7_1)
	return self:getGoodsById(arg_7_1)
end

function MiniGameShop:GetCommodities()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.goods) do
		table.insert(var_8_0, iter_8_1)
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:CanPurchase() and 1 or 0
		local var_9_1 = arg_9_1:CanPurchase() and 1 or 0

		if var_9_0 == var_9_1 then
			if arg_9_0:getConfig("order") ~= arg_9_1:getConfig("order") then
				return arg_9_0:getConfig("order") < arg_9_1:getConfig("order")
			else
				return arg_9_0:getConfig("id") < arg_9_1:getConfig("id")
			end
		else
			return var_9_1 < var_9_0
		end

		return
	end)

	return var_8_0
end

function MiniGameShop:bindConfigTable()
	return nil
end

function MiniGameShop:getRefreshCount()
	return self.refreshCount
end

function MiniGameShop:resetRefreshCount()
	self.refreshCount = 1

	return
end

function MiniGameShop:increaseRefreshCount()
	self.refreshCount = self.refreshCount + 1

	return
end

function MiniGameShop:updateAllGoods(arg_14_1)
	self.goods = arg_14_1

	return
end

function MiniGameShop:getGoodsById(arg_15_1)
	assert(self.goods[arg_15_1], "should exist good" .. arg_15_1)

	return Clone(self.goods[arg_15_1])
end

function MiniGameShop:updateGoods(arg_16_1)
	assert(self.goods[arg_16_1.id], "should exist good" .. arg_16_1.id)

	self.goods[arg_16_1.id] = arg_16_1

	return
end

function MiniGameShop:GetResList()
	return {
		12
	}
end

return MiniGameShop

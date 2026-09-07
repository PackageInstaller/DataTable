local ShoppingStreet = class("ShoppingStreet", import(".BaseShop"))

function ShoppingStreet:getRiseShopId(arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(pg.shop_template.all) do
		if pg.shop_template[iter_1_1].genre == self and arg_1_1 >= pg.shop_template[iter_1_1].limit_args[2] and arg_1_1 <= pg.shop_template[iter_1_1].limit_args[3] then
			return iter_1_1
		end
	end

	return
end

function ShoppingStreet:Ctor(arg_2_1)
	self.level = arg_2_1.lv
	self.configId = self.level
	self.nextFlashTime = arg_2_1.next_flash_time
	self.levelUpTime = arg_2_1.lv_up_time
	self.flashCount = arg_2_1.flash_count
	self.goods = {}

	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHOP_DISCOUNT)
	local var_2_1 = var_2_0 and not var_2_0:isEnd()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.goods_list) do
		local var_2_2 = Goods.Create(iter_2_1, Goods.TYPE_SHOPSTREET)

		var_2_2.activityDiscount = var_2_1

		table.insert(self.goods, var_2_2)
	end

	self.type = ShopArgs.ShopStreet

	return
end

function ShoppingStreet:IsSameKind(arg_3_1)
	return isa(arg_3_1, ShoppingStreet)
end

function ShoppingStreet:GetCommodityById(arg_4_1)
	return self:getGoodsById(arg_4_1)
end

function ShoppingStreet:GetCommodities()
	return self.goods
end

function ShoppingStreet:bindConfigTable()
	return pg.navalacademy_shoppingstreet_template
end

function ShoppingStreet:resetflashCount()
	self.flashCount = 0

	return
end

function ShoppingStreet:increaseFlashCount()
	self.flashCount = self.flashCount + 1

	return
end

function ShoppingStreet:isUpdateGoods()
	if pg.TimeMgr.GetInstance():GetServerTime() >= self.nextFlashTime then
		return true
	end

	return false
end

function ShoppingStreet:getMaxLevel()
	local var_10_0 = self:bindConfigTable()

	return var_10_0.all[#var_10_0.all]
end

function ShoppingStreet:isMaxLevel()
	return self:getMaxLevel() <= self.level
end

function ShoppingStreet:isUpgradeProcess()
	return pg.TimeMgr.GetInstance():GetServerTime() < self.levelUpTime
end

function ShoppingStreet:isFinishUpgrade()
	if pg.TimeMgr.GetInstance():GetServerTime() >= self.levelUpTime then
		return true
	end

	return false
end

function ShoppingStreet:getLevelUpTime()
	return self.levelUpTime
end

function ShoppingStreet:updateLeftTime()
	return self.levelUpTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function ShoppingStreet:levelUp()
	self.levelUpTime = 0
	self.level = math.min(self.level + 1, #self:bindConfigTable().all)

	if self.level == self.level then
		warning("商品街配置最大等级")
	end

	self.configId = self.level

	return
end

function ShoppingStreet:setLevelUpTime()
	self.levelUpTime = getConfigFromLevel1(pg.navalacademy_shoppingstreet_template, self.level).levelUpTime + pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function ShoppingStreet:getGoodsById(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self.goods) do
		if arg_18_1 == iter_18_1.id then
			return iter_18_1
		end
	end

	return
end

function ShoppingStreet:GetResList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(self.goods) do
		var_19_0[iter_19_1:getConfig("resource_type")] = true
	end

	local var_19_1 = {}

	for iter_19_2, iter_19_3 in pairs(var_19_0) do
		table.insert(var_19_1, iter_19_2)
	end

	return var_19_1
end

return ShoppingStreet

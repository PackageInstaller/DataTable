local EscortShop = class("EscortShop", import(".BaseVO"))

function EscortShop:Ctor()
	self.goods = {}
	self.type = ShopArgs.ShopEscort

	return
end

function EscortShop:update(arg_2_1, arg_2_2)
	self.id = arg_2_1
	self.configId = self.id

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
		var_2_0[iter_2_1.shop_id] = iter_2_1.count
	end

	self.goods = {}

	if self.id and self.id > 0 then
		for iter_2_2, iter_2_3 in ipairs(self:getConfig("goods")) do
			local var_2_1 = var_2_0[iter_2_3] or 0

			self.goods[iter_2_3] = Goods.Create({
				shop_id = iter_2_3,
				buy_count = var_2_1
			}, Goods.TYPE_SHAM_BATTLE)
		end
	end

	return
end

function EscortShop:isOpen()
	local var_3_0 = false
	local var_3_1 = self:bindConfigTable()[self.id]

	if var_3_1 then
		local var_3_2 = pg.TimeMgr.GetInstance()
		local var_3_3 = var_3_2:STimeDescS(var_3_2:GetServerTime(), "*t")

		if var_3_3.month == self.id then
			var_3_0 = var_3_3.day >= var_3_1.time[1] and var_3_3.day <= var_3_1.time[2]
		end
	end

	return var_3_0
end

function EscortShop:getRestDays()
	local var_4_1 = self:bindConfigTable()[self.id]

	return (math.max((var_4_1 or nil) and var_4_1.time[2] - pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t").day + 1, 1))
end

function EscortShop:getSortGoods()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.goods) do
		table.insert(var_5_0, iter_5_1)
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:canPurchase() and 1 or 0
		local var_6_1 = arg_6_1:canPurchase() and 1 or 0

		if var_6_0 == var_6_1 then
			local var_6_2 = arg_6_0:getConfig("order")
			local var_6_3 = arg_6_1:getConfig("order")

			if var_6_2 == var_6_3 then
				return arg_6_0.id < arg_6_1.id
			else
				return var_6_2 < var_6_3
			end
		else
			return var_6_1 < var_6_0
		end

		return
	end)

	return var_5_0
end

function EscortShop:bindConfigTable()
	return pg.escort_shop_template
end

function EscortShop:getGoodsCfg(arg_8_1)
	return pg.activity_shop_template[arg_8_1]
end

function EscortShop:getGoodsById(arg_9_1)
	return self.goods[arg_9_1]
end

return EscortShop

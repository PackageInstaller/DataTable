local CruiseShop = class("CruiseShop", import(".BaseShop"))

CruiseShop.TYPE_SKIN = "skin"
CruiseShop.TYPE_EQUIP_SKIN = "equip_skin"

function CruiseShop:Ctor(arg_1_1, arg_1_2)
	self.type = CruiseShop.ShopCruise
	self.genres = {
		[CruiseShop.TYPE_SKIN] = ShopArgs.CruiseSkin,
		[CruiseShop.TYPE_EQUIP_SKIN] = ShopArgs.CruiseGearSkin
	}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(self.genres) do
		if pg.shop_template.get_id_list_by_genre[iter_1_1] then
			local var_1_1 = pg.TimeMgr.GetInstance()

			for iter_1_2, iter_1_3 in ipairs(pg.shop_template.get_id_list_by_genre[iter_1_1]) do
				if var_1_1:inTime(pg.shop_template[iter_1_3].time) then
					table.insert(var_1_0, iter_1_3)
				end
			end
		end
	end

	local var_1_2 = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1) do
		var_1_2[iter_1_5.shop_id] = iter_1_5.pay_count
	end

	local var_1_3 = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_2) do
		var_1_3[iter_1_7.shop_id] = iter_1_7.pay_count
	end

	self.goods = {}

	for iter_1_8, iter_1_9 in ipairs(var_1_0) do
		local var_1_4 = var_1_2[iter_1_9] or 0
		local var_1_5 = var_1_3[pg.shop_template[iter_1_9].group] or 0

		self.goods[iter_1_9] = Goods.Create({
			shop_id = iter_1_9,
			buy_count = var_1_4,
			groupCount = var_1_5
		}, Goods.TYPE_CRUISE)
	end

	return
end

function CruiseShop:GetRemainEquipSkinCnt()
	for iter_2_0, iter_2_1 in pairs(self.goods) do
		if iter_2_1:getConfig("genre") == ShopArgs.CruiseGearSkin then
			return iter_2_1:getConfig("group_limit") - iter_2_1.groupCount
		end
	end

	return 0
end

function CruiseShop:IsSameKind(arg_3_1)
	return isa(arg_3_1, CruiseShop)
end

function CruiseShop:GetCommodityById(arg_4_1)
	return self:getGoodsById(arg_4_1)
end

function CruiseShop:GetCommodities()
	return self:getSortGoods()
end

function CruiseShop:GetCommoditiesByType(arg_6_1)
	return self:getSortGoodsByType(arg_6_1)
end

function CruiseShop:getGoodsById(arg_7_1)
	return self.goods[arg_7_1]
end

function CruiseShop:getSortGoods()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.goods) do
		table.insert(var_8_0, iter_8_1)
	end

	return self:sort(var_8_0)
end

function CruiseShop:getSortGoodsByType(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.goods) do
		if iter_9_1:getConfig("genre") == self.genres[arg_9_1] then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return self:sort(var_9_0)
end

function CruiseShop:sort(arg_10_1)
	table.sort(arg_10_1, CompareFuncs({
		function(arg_11_0)
			return arg_11_0:canPurchase() and 0 or 1
		end,
		function(arg_12_0)
			return arg_12_0:getConfig("order")
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))

	return arg_10_1
end

return CruiseShop

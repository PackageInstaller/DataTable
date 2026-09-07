local EducateShop = class("EducateShop", import("model.vo.BaseVO"))

function EducateShop:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.configId = self.id
	self.goods = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		self.goods[iter_1_1.id] = EducateGood.New(iter_1_1)
	end

	self:initRefreshTime()

	return
end

function EducateShop:bindConfigTable()
	return pg.child_shop
end

function EducateShop:initRefreshTime()
	self.refreshWeeks = {}

	local var_3_0 = self:getConfig("goods_refresh_time")

	if var_3_0 ~= -1 then
		local var_3_1 = 9

		table.insert(self.refreshWeeks, 9)

		while var_3_1 < 60 do
			var_3_1 = var_3_1 + var_3_0

			table.insert(self.refreshWeeks, var_3_1)
		end
	end

	return
end

function EducateShop:GetShopTip()
	if #self.refreshWeeks == 0 then
		return i18n("child_shop_tip2")
	else
		return i18n("child_shop_tip1", self:getConfig("goods_refresh_time"))
	end

	return
end

function EducateShop:GetCommodities()
	return self:getSortGoods()
end

function EducateShop:GetGoods(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.goods) do
		if iter_6_1:InTime(arg_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	table.sort(var_6_0, CompareFuncs({
		function(arg_7_0)
			return arg_7_0:CanBuy() and 0 or 1
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	return var_6_0
end

function EducateShop:GetGoodById(arg_9_1)
	return self.goods[arg_9_1]
end

function EducateShop:UpdateGood(arg_10_1)
	self.goods[arg_10_1.id] = arg_10_1

	return
end

function EducateShop:IsRefreshWeek(arg_11_1)
	return table.contains(self.refreshWeeks, arg_11_1)
end

function EducateShop:IsRefreshShop(arg_12_1)
	return self:IsRefreshWeek((EducateHelper.GetWeekIdxWithTime(arg_12_1)))
end

return EducateShop

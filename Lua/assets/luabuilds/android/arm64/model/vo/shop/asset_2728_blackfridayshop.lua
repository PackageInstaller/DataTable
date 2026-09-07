local BlackFridayShop = class("BlackFridayShop", import("..BaseVO"))

function BlackFridayShop:Ctor(arg_1_1)
	self.startTime = arg_1_1.start_time
	self.stopTime = arg_1_1.stop_time
	self.goods = {}
	self.activityId = arg_1_1.id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.goods) do
		self.goods[iter_1_1.id] = BlackFridayCommodity.New(iter_1_1, Goods.TYPE_SHOPSTREET)
	end

	self.tabList = {}
	self.tabCount = 0

	for iter_1_2, iter_1_3 in pairs(getProxy(ActivityProxy):getActivityById(self.activityId):getConfig("config_client").tabLabel) do
		self.tabCount = self.tabCount + 1

		local var_1_1 = self.tabList[iter_1_2] or {}

		for iter_1_4, iter_1_5 in ipairs(iter_1_3) do
			table.insert(var_1_1, self.goods[iter_1_5])
		end

		self.tabList[iter_1_2] = var_1_1
	end

	return
end

function BlackFridayShop:GetResID(arg_2_1)
	return self.tabList[arg_2_1][1]:GetResType()
end

function BlackFridayShop:GetStartTime()
	return self.startTime
end

function BlackFridayShop:GetEndTime()
	return self.stopTime
end

function BlackFridayShop:GetTabCount()
	return self.tabCount
end

function BlackFridayShop:GetCommodityById(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.goods) do
		if arg_6_1 == iter_6_1.id then
			return iter_6_1
		end
	end

	return
end

function BlackFridayShop:GetGoodsByTabs(arg_7_1)
	return self.tabList[arg_7_1]
end

return BlackFridayShop

local var_0_0 = class("BlackFridayShop", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.startTime = arg_1_1.start_time
	arg_1_0.stopTime = arg_1_1.stop_time
	arg_1_0.goods = {}
	arg_1_0.activityId = arg_1_1.id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.goods) do
		arg_1_0.goods[iter_1_1.id] = BlackFridayCommodity.New(iter_1_1, Goods.TYPE_SHOPSTREET)
	end

	arg_1_0.tabList = {}
	arg_1_0.tabCount = 0

	for iter_1_2, iter_1_3 in pairs(getProxy(ActivityProxy):getActivityById(arg_1_0.activityId):getConfig("config_client").tabLabel) do
		arg_1_0.tabCount = arg_1_0.tabCount + 1

		local var_1_1 = arg_1_0.tabList[iter_1_2] or {}

		for iter_1_4, iter_1_5 in ipairs(iter_1_3) do
			table.insert(var_1_1, arg_1_0.goods[iter_1_5])
		end

		arg_1_0.tabList[iter_1_2] = var_1_1
	end

	return
end

function var_0_0.GetResID(arg_2_0, arg_2_1)
	return arg_2_0.tabList[arg_2_1][1]:GetResType()
end

function var_0_0.GetStartTime(arg_3_0)
	return arg_3_0.startTime
end

function var_0_0.GetEndTime(arg_4_0)
	return arg_4_0.stopTime
end

function var_0_0.GetTabCount(arg_5_0)
	return arg_5_0.tabCount
end

function var_0_0.GetCommodityById(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.goods) do
		if arg_6_1 == iter_6_1.id then
			return iter_6_1
		end
	end

	return
end

function var_0_0.GetGoodsByTabs(arg_7_0, arg_7_1)
	return arg_7_0.tabList[arg_7_1]
end

return var_0_0

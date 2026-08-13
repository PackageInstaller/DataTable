class = var_0_10000

local var_0_0 = "BlackFridayShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.startTime = arg_1_1.start_time
	arg_1_0.stopTime = arg_1_1.stop_time
	arg_1_0.goods = {}
	arg_1_0.activityId = arg_1_1.id

	local var_1_0 = {}

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(arg_1_1.goods) do
		local var_1_1 = arg_1_0.goods
		local var_1_2 = iter_1_1.id

		BlackFridayCommodity = var_1_10010
		var_1_10010 = var_1_10010.New

		local var_1_3 = iter_1_1

		Goods = var_1_10013
		var_1_1[var_1_2] = var_1_10010(var_1_3, var_1_10013.TYPE_SHOPSTREET)
	end

	arg_1_0.tabList = {}
	arg_1_0.tabCount = 0
	getProxy = var_3
	ActivityProxy = var_5

	local var_1_4 = var_3(var_5)
	local var_1_5 = var_3.getActivityById(var_1_4, arg_1_0.activityId)
	local var_1_6 = var_3.getConfig(var_1_5, "config_client").tabLabel

	pairs = var_1_4

	for iter_1_2, iter_1_3 in var_1_4(var_1_6) do
		arg_1_0.tabCount = arg_1_0.tabCount + 1

		local var_1_7

		if not arg_1_0.tabList[iter_1_2] then
			var_1_7 = {}
		end

		ipairs = var_1_10011

		for iter_1_4, iter_1_5 in var_1_10011(iter_1_3) do
			table = var_1_10016

			var_1_10016.insert(var_1_7, arg_1_0.goods[iter_1_5])
		end

		var_1_10011 = arg_1_0.tabList
		var_1_10011[iter_1_2] = var_1_7
	end

	return
end

function var_0_1.GetResID(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.tabList[arg_2_1][1]

	return var_2.GetResType(var_2_0)
end

function var_0_1.GetStartTime(arg_3_0)
	return arg_3_0.startTime
end

function var_0_1.GetEndTime(arg_4_0)
	return arg_4_0.stopTime
end

function var_0_1.GetTabCount(arg_5_0)
	return arg_5_0.tabCount
end

function var_0_1.GetCommodityById(arg_6_0, arg_6_1)
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.goods) do
		if arg_6_1 == iter_6_1.id then
			return iter_6_1
		end
	end

	return
end

function var_0_1.GetGoodsByTabs(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 + arg_7_1

	return arg_7_0.tabList[arg_7_1]
end

return var_0_1

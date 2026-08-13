class = var_0_10000

local var_0_0 = "EducateShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.goods = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_2) do
		local var_1_0 = arg_1_0.goods
		local var_1_1 = iter_1_1.id

		EducateGood = var_1_10010
		var_1_0[var_1_1] = var_1_10010.New(iter_1_1)
	end

	arg_1_0:initRefreshTime()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_shop
end

function var_0_1.initRefreshTime(arg_3_0)
	arg_3_0.refreshWeeks = {}

	if arg_3_0:getConfig("goods_refresh_time") ~= -1 then
		local var_3_0 = 9
		local var_3_1 = 60

		table = var_1_10004

		var_1_10004.insert(arg_3_0.refreshWeeks, var_3_0)

		while var_3_0 < var_3_1 do
			var_3_0 = var_3_0 + var_1
			table = var_4

			var_4.insert(arg_3_0.refreshWeeks, var_3_0)
		end
	end

	return
end

function var_0_1.GetShopTip(arg_4_0)
	if #arg_4_0.refreshWeeks == 0 then
		i18n = var_1

		return var_1("child_shop_tip2")
	else
		i18n = var_1

		return var_1("child_shop_tip1", arg_4_0:getConfig("goods_refresh_time"))
	end

	return
end

function var_0_1.GetCommodities(arg_5_0)
	return arg_5_0:getSortGoods()
end

function var_0_1.GetGoods(arg_6_0, arg_6_1)
	local var_6_0 = {}

	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.goods) do
		if iter_6_1:InTime(arg_6_1) then
			table = var_8

			var_8.insert(var_6_0, iter_6_1)
		end
	end

	table = var_3

	local var_6_1 = var_3.sort
	local var_6_2 = var_6_0

	CompareFuncs = var_5

	var_6_1(var_6_2, var_5({
		function(arg_7_0)
			return arg_7_0:CanBuy() and 0 or 1
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	return var_6_0
end

function var_0_1.GetGoodById(arg_9_0, arg_9_1)
	return arg_9_0.goods[arg_9_1]
end

function var_0_1.UpdateGood(arg_10_0, arg_10_1)
	arg_10_0.goods[arg_10_1.id] = arg_10_1

	return
end

function var_0_1.IsRefreshWeek(arg_11_0, arg_11_1)
	table = var_1_10002

	return var_1_10002.contains(arg_11_0.refreshWeeks, arg_11_1)
end

function var_0_1.IsRefreshShop(arg_12_0, arg_12_1)
	EducateHelper = var_1_10002

	local var_12_0 = var_1_10002.GetWeekIdxWithTime(arg_12_1)

	return arg_12_0:IsRefreshWeek(var_12_0)
end

return var_0_1

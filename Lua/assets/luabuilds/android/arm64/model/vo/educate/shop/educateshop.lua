local var_0_0 = class("EducateShop", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.goods = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		arg_1_0.goods[iter_1_1.id] = EducateGood.New(iter_1_1)
	end

	arg_1_0:initRefreshTime()

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_shop
end

function var_0_0.initRefreshTime(arg_3_0)
	arg_3_0.refreshWeeks = {}

	local var_3_0 = arg_3_0:getConfig("goods_refresh_time")

	if var_3_0 ~= -1 then
		local var_3_1 = 9

		table.insert(arg_3_0.refreshWeeks, 9)

		while var_3_1 < 60 do
			var_3_1 = var_3_1 + var_3_0

			table.insert(arg_3_0.refreshWeeks, var_3_1)
		end
	end

	return
end

function var_0_0.GetShopTip(arg_4_0)
	if #arg_4_0.refreshWeeks == 0 then
		return i18n("child_shop_tip2")
	else
		return i18n("child_shop_tip1", arg_4_0:getConfig("goods_refresh_time"))
	end

	return
end

function var_0_0.GetCommodities(arg_5_0)
	return arg_5_0:getSortGoods()
end

function var_0_0.GetGoods(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.goods) do
		if iter_6_1:InTime(arg_6_1) then
			table.insert({}, iter_6_1)
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_7_0)
			return arg_7_0:CanBuy() and 0 or 1
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	return {}
end

function var_0_0.GetGoodById(arg_9_0, arg_9_1)
	return arg_9_0.goods[arg_9_1]
end

function var_0_0.UpdateGood(arg_10_0, arg_10_1)
	arg_10_0.goods[arg_10_1.id] = arg_10_1

	return
end

function var_0_0.IsRefreshWeek(arg_11_0, arg_11_1)
	return table.contains(arg_11_0.refreshWeeks, arg_11_1)
end

function var_0_0.IsRefreshShop(arg_12_0, arg_12_1)
	return arg_12_0:IsRefreshWeek((EducateHelper.GetWeekIdxWithTime(arg_12_1)))
end

return var_0_0

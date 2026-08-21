local var_0_0 = class("ActivityShop", import(".BaseShop"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data1_list) do
		({})[iter_1_1] = arg_1_1.data2_list[iter_1_0]
	end

	arg_1_0.goods = {}

	local var_1_0 = arg_1_0:bindConfigTable()

	for iter_1_2, iter_1_3 in ipairs(var_1_0.all) do
		if arg_1_1.id == var_1_0[iter_1_3].activity then
			local var_1_1 = ({})[iter_1_3]

			if not ({})[iter_1_3] then
				var_1_1 = 0
			end

			arg_1_0.goods[iter_1_3] = Goods.Create({
				shop_id = iter_1_3,
				buy_count = var_1_1
			}, Goods.TYPE_ACTIVITY)
		end
	end

	arg_1_0.type = ShopArgs.ShopActivity
	arg_1_0.config = pg.activity_template[arg_1_0.activityId]

	return
end

function var_0_0.IsSameKind(arg_2_0, arg_2_1)
	local var_2_0 = isa(arg_2_1, ActivityShop)

	if var_2_0 then
		var_2_0 = arg_2_1.activityId and arg_2_1.activityId == arg_2_0.activityId
	end

	return var_2_0
end

function var_0_0.GetCommodityById(arg_3_0, arg_3_1)
	return arg_3_0:getGoodsById(arg_3_1)
end

function var_0_0.GetCommodities(arg_4_0)
	return arg_4_0:getSortGoods()
end

function var_0_0.getSortGoods(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.goods) do
		table.insert({}, iter_5_1)
	end

	arg_5_0:SortGoods({})

	return {}
end

function var_0_0.SortGoods(arg_6_0, arg_6_1)
	table.sort(arg_6_1, CompareFuncs({
		function(arg_7_0)
			local var_7_0 = arg_7_0:CheckArgLimit()

			return (arg_7_0:canPurchase() or var_7_0) and arg_7_0:CheckCntLimit() and 0 or 1
		end,
		function(arg_8_0)
			local var_8_0, var_8_1, var_8_2 = arg_8_0:CheckTimeLimit()

			return var_8_0 and var_8_1 and 0 or 1
		end,
		function(arg_9_0)
			return arg_9_0:getConfig("order")
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))

	return
end

function var_0_0.GetSplitNameCodes(arg_11_0)
	if arg_11_0.config and arg_11_0.config.config_client and arg_11_0.config.config_client.category then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.config.config_client.category) do
			table.insert({}, iter_11_1[1])
		end
	end

	return {}
end

function var_0_0.GetSplitCommodities(arg_12_0)
	if arg_12_0.config and arg_12_0.config.config_client and arg_12_0.config.config_client.category then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.config.config_client.category) do
			for iter_12_2, iter_12_3 in ipairs(iter_12_1[2]) do
				table.insert({}, arg_12_0.goods[iter_12_3])
			end

			arg_12_0:SortGoods({})
			table.insert({}, {})
		end
	end

	return {}
end

function var_0_0.bindConfigTable(arg_13_0)
	return pg.activity_shop_template
end

function var_0_0.getGoodsById(arg_14_0, arg_14_1)
	return arg_14_0.goods[arg_14_1]
end

function var_0_0.isEnd(arg_15_0)
	local var_15_0 = getProxy(ActivityProxy):getActivityById(arg_15_0.activityId)

	return not var_15_0 or var_15_0:isEnd()
end

function var_0_0.getOpenTime(arg_16_0)
	return string.format("%d.%d.%d~%d.%d.%d %d:%d:%d", pg.activity_template[arg_16_0.activityId].time[2][1][1], pg.activity_template[arg_16_0.activityId].time[2][1][2], pg.activity_template[arg_16_0.activityId].time[2][1][3], pg.activity_template[arg_16_0.activityId].time[3][1][1], pg.activity_template[arg_16_0.activityId].time[3][1][2], pg.activity_template[arg_16_0.activityId].time[3][1][3], pg.activity_template[arg_16_0.activityId].time[3][2][1], pg.activity_template[arg_16_0.activityId].time[3][2][2], pg.activity_template[arg_16_0.activityId].time[3][2][3])
end

function var_0_0.getStartTime(arg_17_0)
	if arg_17_0:isEnd() then
		return 0
	end

	return getProxy(ActivityProxy):getActivityById(arg_17_0.activityId):getStartTime()
end

function var_0_0.getBgPath(arg_18_0)
	local var_18_0 = pg.activity_template[arg_18_0.activityId].config_client[2] or {
		255,
		255,
		255,
		255
	}
	local var_18_1 = pg.activity_template[arg_18_0.activityId].config_client.outline or {
		0,
		0,
		0,
		1
	}
	local var_18_3 = Color.New(var_18_0[1], var_18_0[2], var_18_0[3], var_18_0[4])
	local var_18_4 = Color.New(var_18_1[1], var_18_1[2], var_18_1[3], var_18_1[4])
end

function var_0_0.getToggleImage(arg_19_0)
	return pg.activity_template[arg_19_0.activityId].config_client.toggle or "huodongdduihuan_butten"
end

function var_0_0.getResId(arg_20_0)
	local var_20_0

	for iter_20_0, iter_20_1 in pairs(arg_20_0.goods) do
		var_20_0 = iter_20_1

		break
	end

	return (var_20_0:getConfig("resource_type"))
end

function var_0_0.GetResList(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.goods) do
		({})[iter_21_1:getConfig("resource_type")] = true
	end

	for iter_21_2, iter_21_3 in pairs({}) do
		table.insert({}, iter_21_2)
	end

	return {}
end

function var_0_0.GetEnterVoice(arg_22_0)
	if arg_22_0.config.config_client.enter then
		return arg_22_0.config.config_client.enter[1], arg_22_0.config.config_client.enter[2], arg_22_0.config.config_client.enter[3]
	end

	return
end

function var_0_0.GetPurchaseVoice(arg_23_0)
	if arg_23_0.config.config_client.purchase then
		return arg_23_0.config.config_client.purchase[1], arg_23_0.config.config_client.purchase[2], arg_23_0.config.config_client.purchase[3]
	end

	return
end

function var_0_0.GetPurchaseAllVoice(arg_24_0)
	if arg_24_0.config.config_client.purchase_all then
		return arg_24_0.config.config_client.purchase_all[1], arg_24_0.config.config_client.purchase_all[2], arg_24_0.config.config_client.purchase_all[3]
	end

	return
end

function var_0_0.GetTouchVoice(arg_25_0)
	if arg_25_0.config.config_client.touch then
		return arg_25_0.config.config_client.touch[1], arg_25_0.config.config_client.touch[2], arg_25_0.config.config_client.touch[3]
	end

	return
end

function var_0_0.IsEventShop(arg_26_0)
	return pg.activity_template[arg_26_0.activityId].config_client.event_shop
end

function var_0_0.GetBGM(arg_27_0)
	return pg.activity_template[arg_27_0.activityId].config_client.bgm or ""
end

return var_0_0

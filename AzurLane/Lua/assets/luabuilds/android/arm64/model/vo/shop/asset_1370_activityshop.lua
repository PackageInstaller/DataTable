class = var_0_10000

local var_0_0 = "ActivityShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShop"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.id

	local var_1_0 = {}

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(arg_1_1.data1_list) do
		var_1_0[iter_1_1] = arg_1_1.data2_list[iter_1_0]
	end

	arg_1_0.goods = {}

	local var_1_1 = arg_1_0:bindConfigTable()

	ipairs = var_4

	for iter_1_2, iter_1_3 in var_4(var_1_1.all) do
		if arg_1_1.id == var_1_1[iter_1_3].activity then
			local var_1_2

			if not var_1_0[iter_1_3] then
				var_1_2 = 0
			end

			local var_1_3 = arg_1_0.goods

			Goods = var_1_10011
			var_1_10011 = var_1_10011.Create

			local var_1_4 = {
				shop_id = iter_1_3,
				buy_count = var_1_2
			}

			Goods = var_1_10014
			var_1_3[iter_1_3] = var_1_10011(var_1_4, var_1_10014.TYPE_ACTIVITY)
		end
	end

	ShopArgs = var_4
	arg_1_0.type = var_4.ShopActivity
	pg = var_4
	arg_1_0.config = var_4.activity_template[arg_1_0.activityId]

	return
end

function var_0_1.IsSameKind(arg_2_0, arg_2_1)
	isa = var_1_10002

	local var_2_0 = arg_2_1

	ActivityShop = var_1_10005

	local var_2_1

	if var_1_10002(var_2_0, var_1_10005) and arg_2_1.activityId then
		var_2_1 = arg_2_1.activityId == arg_2_0.activityId
	end

	return var_2_1
end

function var_0_1.GetCommodityById(arg_3_0, arg_3_1)
	return arg_3_0:getGoodsById(arg_3_1)
end

function var_0_1.GetCommodities(arg_4_0)
	return arg_4_0:getSortGoods()
end

function var_0_1.getSortGoods(arg_5_0)
	local var_5_0 = {}

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_5_0, iter_5_1)
	end

	arg_5_0:SortGoods(var_5_0)

	return var_5_0
end

function var_0_1.SortGoods(arg_6_0, arg_6_1)
	table = var_1_10002

	local var_6_0 = var_1_10002.sort
	local var_6_1 = arg_6_1

	CompareFuncs = var_1_10005

	var_6_0(var_6_1, var_1_10005({
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

function var_0_1.GetSplitNameCodes(arg_11_0)
	local var_11_0 = {}

	if arg_11_0.config and arg_11_0.config.config_client and arg_11_0.config.config_client.category then
		ipairs = var_2

		for iter_11_0, iter_11_1 in var_2(arg_11_0.config.config_client.category) do
			table = var_1_10007

			var_1_10007.insert(var_11_0, iter_11_1[1])
		end
	end

	return var_11_0
end

function var_0_1.GetSplitCommodities(arg_12_0)
	local var_12_0 = {}

	if arg_12_0.config and arg_12_0.config.config_client and arg_12_0.config.config_client.category then
		ipairs = var_2

		for iter_12_0, iter_12_1 in var_2(arg_12_0.config.config_client.category) do
			local var_12_1 = {}

			ipairs = var_1_10008

			for iter_12_2, iter_12_3 in var_1_10008(iter_12_1[2]) do
				table = var_1_10013

				var_1_10013.insert(var_12_1, arg_12_0.goods[iter_12_3])
			end

			arg_12_0:SortGoods(var_12_1)

			table = var_1_10008

			var_1_10008.insert(var_12_0, var_12_1)
		end
	end

	return var_12_0
end

function var_0_1.bindConfigTable(arg_13_0)
	pg = var_1_10001

	return var_1_10001.activity_shop_template
end

function var_0_1.getGoodsById(arg_14_0, arg_14_1)
	return arg_14_0.goods[arg_14_1]
end

function var_0_1.isEnd(arg_15_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)

	return not var_1.getActivityById(var_15_0, arg_15_0.activityId) or var_1:isEnd()
end

function var_0_1.getOpenTime(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.activity_template[arg_16_0.activityId].time[2][1]
	local var_16_1 = var_2[3][1]
	local var_16_2 = var_2[3][2]

	string = var_1_10006

	return var_1_10006.format("%d.%d.%d~%d.%d.%d %d:%d:%d", var_16_0[1], var_16_0[2], var_16_0[3], var_16_1[1], var_16_1[2], var_16_1[3], var_16_2[1], var_16_2[2], var_16_2[3])
end

function var_0_1.getStartTime(arg_17_0)
	local var_17_0 = arg_17_0

	if arg_17_0.isEnd(var_17_0) then
		return 0
	end

	getProxy = var_1
	ActivityProxy = var_17_0

	local var_17_1 = var_1(var_17_0)
	local var_17_2 = var_1.getActivityById(var_17_1, arg_17_0.activityId)

	return var_1.getStartTime(var_17_2)
end

function var_0_1.getBgPath(arg_18_0)
	pg = var_1_10001

	local var_18_0

	if not var_1_10001.activity_template[arg_18_0.activityId].config_client[2] then
		var_18_0 = {
			255,
			255,
			255,
			255
		}
	end

	local var_18_1

	if not var_1.config_client.outline then
		var_18_1 = {
			0,
			0,
			0,
			1
		}
	end

	local var_18_2 = var_1.config_client[1]

	Color = var_1_10005

	local var_18_3 = var_1_10005.New(var_18_0[1], var_18_0[2], var_18_0[3], var_18_0[4])

	Color = var_1_10006

	local var_18_4 = var_1_10006.New(var_18_1[1], var_18_1[2], var_18_1[3], var_18_1[4])
end

function var_0_1.getToggleImage(arg_19_0)
	pg = var_1_10001

	local var_19_0

	if not var_1_10001.activity_template[arg_19_0.activityId].config_client.toggle then
		var_19_0 = "huodongdduihuan_butten"
	end

	return var_19_0
end

function var_0_1.getResId(arg_20_0)
	local var_20_0

	pairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.goods) do
		var_20_0 = iter_20_1

		break
	end

	return (var_20_0:getConfig("resource_type"))
end

function var_0_1.GetResList(arg_21_0)
	local var_21_0 = {}

	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.goods) do
		var_21_0[iter_21_1:getConfig("resource_type")] = true
	end

	local var_21_1 = {}

	pairs = var_3

	for iter_21_2, iter_21_3 in var_3(var_21_0) do
		table = var_1_10008

		var_1_10008.insert(var_21_1, iter_21_2)
	end

	return var_21_1
end

function var_0_1.GetEnterVoice(arg_22_0)
	if arg_22_0.config.config_client.enter then
		return var_1[1], var_1[2], var_1[3]
	end

	return
end

function var_0_1.GetPurchaseVoice(arg_23_0)
	if arg_23_0.config.config_client.purchase then
		return var_1[1], var_1[2], var_1[3]
	end

	return
end

function var_0_1.GetPurchaseAllVoice(arg_24_0)
	if arg_24_0.config.config_client.purchase_all then
		return var_1[1], var_1[2], var_1[3]
	end

	return
end

function var_0_1.GetTouchVoice(arg_25_0)
	if arg_25_0.config.config_client.touch then
		return var_1[1], var_1[2], var_1[3]
	end

	return
end

function var_0_1.IsEventShop(arg_26_0)
	pg = var_1_10001

	return var_1_10001.activity_template[arg_26_0.activityId].config_client.event_shop
end

function var_0_1.GetBGM(arg_27_0)
	pg = var_1_10001

	local var_27_0

	if not var_1_10001.activity_template[arg_27_0.activityId].config_client.bgm then
		var_27_0 = ""
	end

	return var_27_0
end

return var_0_1

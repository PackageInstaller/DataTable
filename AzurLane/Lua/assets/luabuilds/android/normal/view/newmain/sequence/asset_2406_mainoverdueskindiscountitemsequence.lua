class = var_0_10000

local var_0_0 = "MainOverDueSkinDiscountItemSequence"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainOverDueAttireSequence"))

function var_0_1.Execute(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = arg_1_0:CollectExpiredItems()
	local var_1_2

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.RecycleItems(var_2_0, var_1_0, var_1_1, function(arg_3_0)
				var_1_2 = arg_3_0

				arg_2_0()

				return
			end)

			return
		end,
		function(arg_4_0)
			if not var_1_2 then
				arg_4_0()

				return
			end

			local var_4_0 = arg_1_0

			var_1.DisplayResult(var_4_0, var_1_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			if not var_1_2 then
				arg_5_0()

				return
			end

			local var_5_0 = arg_1_0

			var_1.ShowAwardInfo(var_5_0, var_1_2, arg_5_0)

			return
		end,
		function(arg_6_0)
			onNextTick = var_2_10001

			var_2_10001(arg_6_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_1.ShowAwardInfo(arg_7_0, arg_7_1, arg_7_2)
	pg = var_1_10003

	local var_7_0 = var_1_10003.m02
	local var_7_1 = var_3.sendNotification

	NewMainMediator = var_1_10005

	var_7_1(var_7_0, var_1_10005.ON_AWRADS, {
		items = arg_7_1,
		callback = arg_7_2
	})

	return
end

function var_0_1.RecycleItems(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {}

	ipairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(arg_8_1) do
		table = var_1_10010

		var_1_10010.insert(var_8_0, iter_8_1)
	end

	ipairs = var_5

	for iter_8_2, iter_8_3 in var_5(arg_8_2) do
		table = var_1_10010

		var_1_10010.insert(var_8_0, iter_8_3)
	end

	pg = var_5

	local var_8_1 = var_5.m02
	local var_8_2 = var_5.sendNotification

	GAME = var_7

	var_8_2(var_8_1, var_7.SELL_ITEM, {
		items = var_8_0,
		callback = arg_8_3
	})

	return
end

function var_0_1.DisplayResult(arg_9_0, arg_9_1, arg_9_2)
	if #arg_9_1 > 0 then
		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.Display

		SkinDiscountItemExpireDisplayPage = var_1_10005

		var_9_1(var_9_0, var_1_10005, arg_9_1, arg_9_2)
	else
		arg_9_2()
	end

	return
end

function var_0_1.CollectExpiredItems(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._CollectExpiredItems

	ItemUsage = var_1_10003

	local var_10_2 = var_10_1(var_10_0, var_1_10003.USAGE_SHOP_DISCOUNT)
	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0._CollectExpiredItems

	ItemUsage = var_1_10004

	local var_10_5 = var_10_4(var_10_3, var_1_10004.USAGE_SKIN_EXP)

	return var_10_2, var_10_5
end

function var_0_1._CollectExpiredItems(arg_11_0, arg_11_1)
	local var_11_0 = {}

	pg = var_1_10003

	local var_11_1 = var_1_10003.shop_template.get_id_list_by_genre

	ShopArgs = var_1_10004

	local var_11_2 = var_11_1[var_1_10004.GiftPackage]

	pairs = var_4

	for iter_11_0, iter_11_1 in var_4(var_11_2) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.shop_template[iter_11_1]

		local var_11_3 = arg_11_0

		if arg_11_0.InTime(var_11_3, var_1_10009.time) then
			local var_11_4

			if not var_1_10009.effect_args[1] then
				var_11_4 = 0
			end

			pg = var_11_3

			if var_11_3.item_data_statistics[var_11_4] then
				arg_11_0:GetExpiredItemIdFromDropList(var_11_0, var_11.display_icon, arg_11_1)
			end
		end
	end

	return var_11_0
end

function var_0_1.InTime(arg_12_0, arg_12_1)
	type = var_1_10002

	if var_1_10002(arg_12_1) == "table" then
		pg = var_2

		local var_12_0 = var_2.TimeMgr.GetInstance()

		return var_2.passTime(var_12_0, arg_12_1[2])
	elseif arg_12_1 == "stop" then
		return true
	end

	return
end

function var_0_1.GetExpiredItemIdFromDropList(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local function var_13_0(arg_14_0)
		pg = var_2_10001

		local var_14_0 = var_2_10001.item_data_statistics[arg_14_0]

		assert = var_2_10002

		var_2_10002(var_14_0, arg_14_0)

		return var_14_0 and var_14_0.usage == arg_13_3
	end

	getProxy = var_1_10005
	BagProxy = var_1_10006

	local var_13_1 = var_1_10005(var_1_10006)

	local function var_13_2(arg_15_0)
		local var_15_0 = var_13_1

		return var_1.getItemCountById(var_15_0, arg_15_0) > 0
	end

	pairs = var_1_10007

	for iter_13_0, iter_13_1 in var_1_10007(arg_13_2) do
		local var_13_3 = iter_13_1[1]
		local var_13_4 = iter_13_1[2]

		DROP_TYPE_ITEM = var_1_10014

		if var_13_3 == var_1_10014 and var_13_2(var_13_4) and var_13_0(var_13_4) then
			local var_13_5 = var_13_1

			var_1_10014 = var_13_1.RawGetItemById(var_13_5, var_13_4)
			_ = var_13_5

			if not var_13_5.any(arg_13_1, function(arg_16_0)
				return arg_16_0.id == var_13_4
			end) then
				table = var_15

				var_15.insert(arg_13_1, {
					id = var_1_10014.id,
					count = var_1_10014.count
				})
			end
		end
	end

	return
end

return var_0_1

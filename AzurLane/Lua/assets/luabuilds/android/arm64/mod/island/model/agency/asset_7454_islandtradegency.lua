class = var_0_10000

local var_0_0 = "IslandTradegency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.WEEK_NUM_UPDATE = "IslandTradegency:WEEK_NUM_UPDATE"
var_0_1.RESET_PRICE = "IslandTradegency:RESET_PRICE"
var_0_1.INVITE_LIST_UPDATE = "IslandTradegency:INVITE_LIST_UPDATE"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.treasure then
		var_1_0 = {}
	end

	local var_1_1

	if not var_1_0.week_buy_num then
		var_1_1 = 0
	end

	arg_1_0.weekNum = var_1_1
	pg = var_1_1
	arg_1_0.weekNumMax = var_1_1.island_set.treasure_week_limit.key_value_varchar[1]
	pg = var_3
	arg_1_0.sellNumMax = var_3.island_set.treasure_week_limit.key_value_varchar[2]
	pg = var_3
	arg_1_0.coefficient = var_3.island_set.treasure_price_buy.key_value_int * 0.01
	arg_1_0.sellList = {}
	ipairs = var_3

	local var_1_2

	if not var_1_0.sell_list then
		var_1_2 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_2) do
		var_1_10008 = arg_1_0.sellList
		var_1_10008[iter_1_1.island_id] = iter_1_1.num
	end

	arg_1_0.priceList = {}
	ipairs = var_3

	local var_1_3

	if not var_1_0.price_list then
		var_1_3 = {}
	end

	for iter_1_2, iter_1_3 in var_3(var_1_3) do
		var_1_10008 = arg_1_0.priceList
		var_1_10008[iter_1_3.timestamp] = iter_1_3.price
	end

	arg_1_0.ranks = {}
	arg_1_0.inviteList = {}
	ipairs = var_3

	local var_1_4

	if not var_1_0.invite_list then
		var_1_4 = {}
	end

	for iter_1_4, iter_1_5 in var_3(var_1_4) do
		table = var_1_10008

		var_1_10008.insert(arg_1_0.inviteList, iter_1_5)
	end

	arg_1_0.cacheRankTime = 0

	return
end

function var_0_1.IsInvited(arg_2_0, arg_2_1)
	table = var_1_10002

	return var_1_10002.contains(arg_2_0.inviteList, arg_2_1)
end

function var_0_1.UpdateInviteList(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_1) do
		table = var_1_10007

		var_1_10007.insert(arg_3_0.inviteList, iter_3_1)
	end

	arg_3_0:DispatchEvent(var_0_1.INVITE_LIST_UPDATE)

	return
end

function var_0_1.ClearInviteList(arg_4_0)
	arg_4_0.inviteList = {}

	arg_4_0:DispatchEvent(var_0_1.INVITE_LIST_UPDATE)

	return
end

function var_0_1.GetSellLimit(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_0.sellList[arg_5_1] then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_1.UpdateSellLimit(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.sellList[arg_6_1] then
		arg_6_0.sellList[arg_6_1] = 0
	end

	arg_6_0.sellList[arg_6_1] = arg_6_0.sellList[arg_6_1] + arg_6_2

	return
end

function var_0_1.GetSellLimitMax(arg_7_0)
	return arg_7_0.sellNumMax
end

function var_0_1.GetCanSellCnt(arg_8_0, arg_8_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_8_0 = var_1_10002(var_1_10004)
	local var_8_1 = var_2.GetIsland(var_8_0)
	local var_8_2 = var_2.GetInventoryAgency(var_8_1)
	local var_8_3 = var_3.GetOwnCount

	IslandItem = var_1_10007

	local var_8_4 = var_8_3(var_8_2, var_1_10007.PEARL_ID)

	if var_2.id == arg_8_1 then
		return var_8_4
	end

	math = var_5

	return var_5.min(var_8_4, arg_8_0.sellNumMax - arg_8_0:GetSellLimit(arg_8_1))
end

function var_0_1.GetCanPurchaseCnt(arg_9_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.GetIsland(var_9_0)
	local var_9_2 = var_1.GetInventoryAgency(var_9_1)
	local var_9_3 = var_2.GetOwnCount

	IslandItem = var_1_10006

	local var_9_4 = var_9_3(var_9_2, var_1_10006.GOLD_ID)
	local var_9_5 = arg_9_0
	local var_9_6 = arg_9_0.GetTodayPrice(var_9_5)

	math = var_9_2

	local var_9_7 = var_9_2.floor(var_9_4 / var_9_6)

	math = var_9_5

	return var_9_5.min(var_9_7, arg_9_0.weekNumMax - arg_9_0.weekNum)
end

function var_0_1.GetWeekNum(arg_10_0)
	return arg_10_0.weekNum
end

function var_0_1.GetWeekNumMax(arg_11_0)
	return arg_11_0.weekNumMax
end

function var_0_1.UpdateWeekNum(arg_12_0, arg_12_1)
	arg_12_0.weekNum = arg_12_0.weekNum + arg_12_1

	arg_12_0:DispatchEvent(var_0_1.WEEK_NUM_UPDATE)

	return
end

function var_0_1.ResetWeekNum(arg_13_0)
	arg_13_0.weekNum = 0

	arg_13_0:DispatchEvent(var_0_1.WEEK_NUM_UPDATE)

	return
end

function var_0_1.ShouldRefreshRank(arg_14_0)
	if #arg_14_0.ranks <= 0 then
		return true
	end

	local var_14_0 = arg_14_0.cacheRankTime

	pg = var_2

	local var_14_1 = var_2.TimeMgr.GetInstance()

	return var_14_0 < var_2.GetServerTime(var_14_1)
end

function var_0_1.SetRanks(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.ranks = arg_15_1
	arg_15_0.cacheRankTime = arg_15_2

	return
end

function var_0_1.GetRanks(arg_16_0)
	local var_16_0 = arg_16_0:GetSelfRank()
	local var_16_1 = var_1.SetValue

	math = var_1_10005

	var_16_1(var_16_0, var_1_10005.floor(var_1.value * arg_16_0.coefficient))

	_ = var_16_1

	return var_16_1.map(arg_16_0.ranks, function(arg_17_0)
		Clone = var_2_10001

		local var_17_0 = var_2_10001(arg_17_0)
		local var_17_1 = var_1.SetValue

		math = var_2_10005

		var_17_1(var_17_0, var_2_10005.floor(arg_17_0.value * arg_16_0.coefficient))

		return var_1
	end), var_1
end

function var_0_1.GetSelfRank(arg_18_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)
	local var_18_1 = var_1.getRawData(var_18_0)

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_18_2 = var_1_10002(var_1_10004)
	local var_18_3 = var_2.GetIsland(var_18_2)
	local var_18_4 = var_2.GetLevel(var_18_3)
	local var_18_5 = var_2:GetTradeAgency()
	local var_18_6 = var_4.GetTodaySellPrice(var_18_5)

	IslandTradeRank = var_18_3

	local var_18_7 = var_18_3.New
	local var_18_8 = {
		id = var_18_1.id,
		value = var_18_6,
		skinId = var_18_1.skinId,
		islandLevel = var_18_4
	}
	local var_18_9

	if not var_18_1.name then
		var_18_9 = ""
	end

	var_18_8.name = var_18_9

	return (var_18_7(var_18_8))
end

function var_0_1.GetSellRanks(arg_19_0)
	local var_19_0 = arg_19_0:GetSelfRank()

	return arg_19_0.ranks, var_19_0
end

function var_0_1.GetLatestTime(arg_20_0)
	local var_20_0 = {}

	pairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.priceList) do
		table = var_1_10007

		var_1_10007.insert(var_20_0, iter_20_0)
	end

	table = var_2

	var_2.sort(var_20_0, function(arg_21_0, arg_21_1)
		return arg_21_1 < arg_21_0
	end)

	local var_20_1

	if not var_20_0[1] then
		var_20_1 = -1
	end

	return var_20_1
end

function var_0_1.CanPurchase(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_22_0) <= arg_22_0:GetLatestTime()
end

function var_0_1.GetTodayPrice(arg_23_0)
	local var_23_0 = arg_23_0:GetTodaySellPrice()

	math = var_1_10002

	return var_1_10002.floor(var_23_0 * arg_23_0.coefficient)
end

function var_0_1.GetTodaySellPrice(arg_24_0)
	local var_24_0 = arg_24_0:GetLatestTime()
	local var_24_1

	if not arg_24_0.priceList[var_24_0] then
		var_24_1 = 0
	end

	return var_24_1
end

function var_0_1.UpdateTodayPrice(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.priceList[arg_25_1] = arg_25_2

	arg_25_0:ClearInviteList()

	arg_25_0.sellList = {}

	arg_25_0:DispatchEvent(var_0_1.RESET_PRICE)

	return
end

function var_0_1.GetPriceTrend(arg_26_0)
	local var_26_0 = {}

	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.priceList) do
		local var_26_1 = iter_26_0 - 0

		math = var_1_10008
		var_26_0[var_26_1] = var_1_10008.floor(iter_26_1 * arg_26_0.coefficient)
	end

	return var_26_0
end

function var_0_1.GetSellPriceTrend(arg_27_0)
	local var_27_0 = {}

	pairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0.priceList) do
		var_27_0[iter_27_0 - 0] = iter_27_1
	end

	return var_27_0
end

function var_0_1.ExistTrade(arg_28_0, arg_28_1)
	return arg_28_0:GetPriceTrend()[arg_28_1] ~= nil
end

function var_0_1.UpdatePerHour(arg_29_0, arg_29_1)
	pg = var_1_10002

	local var_29_0 = var_1_10002.TimeMgr.GetInstance()

	if var_2.GetServerWeek(var_29_0) == 1 and arg_29_1 == 3 then
		arg_29_0:ResetWeekNum()
	end

	if arg_29_1 == 3 then
		-- block empty
	end

	return
end

return var_0_1

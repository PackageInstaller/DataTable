class = var_0_10000

local var_0_0 = "AuctionGameBaseProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0:UpdateData({})

	arg_1_0.needInitFlag = true

	return
end

function var_0_1.UpdateData(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.gold then
		var_2_0 = 0
	end

	arg_2_0.gold = var_2_0

	local var_2_1

	if not arg_2_1.game_num then
		var_2_1 = 0
	end

	arg_2_0.matchNum = var_2_1

	local var_2_2

	if not arg_2_1.buy_num then
		var_2_2 = 0
	end

	arg_2_0.bidSuccessCnt = var_2_2

	local var_2_3

	if not arg_2_1.max_profit then
		var_2_3 = 0
	end

	arg_2_0.highestProfit = var_2_3

	local var_2_4

	if not arg_2_1.acc_profit then
		var_2_4 = 0
	end

	arg_2_0.totalProfit = var_2_4

	local var_2_5

	if not arg_2_1.item_list or not #arg_2_1.item_list then
		var_2_5 = 0
	end

	arg_2_0.unlockCollectionCnt = var_2_5
	arg_2_0.unlockCollectionList = {}
	ipairs = var_2

	local var_2_6

	if not arg_2_1.item_list then
		var_2_6 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_6) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.unlockCollectionList, iter_2_1)
	end

	local var_2_7

	if not arg_2_1.acc_buy_price then
		var_2_7 = 0
	end

	arg_2_0.totalBidPrice = var_2_7

	local var_2_8

	if not arg_2_1.acc_item_price then
		var_2_8 = 0
	end

	arg_2_0.totalCollectionPrice = var_2_8

	local var_2_9

	if not arg_2_1.pre_buy_state then
		var_2_9 = 0
	end

	arg_2_0.preorderState = var_2_9

	local var_2_10

	if not arg_2_1.pre_timestamp then
		var_2_10 = 0
	end

	arg_2_0.preorderTimestamp = var_2_10

	local var_2_11

	if not arg_2_1.match_time then
		var_2_11 = 0
	end

	arg_2_0.forbiddenTime = var_2_11

	local var_2_12

	if not arg_2_1.is_forbidden then
		var_2_12 = 0
	end

	arg_2_0.isForbidden = var_2_12

	local var_2_13

	if not arg_2_1.inactive_num then
		var_2_13 = 0
	end

	arg_2_0.inactiveNum = var_2_13

	local var_2_14

	if not arg_2_1.inactive_state then
		var_2_14 = 0
	end

	arg_2_0.isMatchWarning = var_2_14

	local var_2_15

	if not arg_2_1.back_forbidden then
		var_2_15 = 0
	end

	arg_2_0.serverForbidden = var_2_15

	local var_2_16

	if not arg_2_1.get_relief_num then
		var_2_16 = 0
	end

	arg_2_0.reliefCnt = var_2_16

	return
end

function var_0_1.AddGold(arg_3_0, arg_3_1)
	arg_3_0.gold = arg_3_0.gold + arg_3_1
	pg = var_2

	if var_2.gameset.auction_currency_ceiling.key_value < arg_3_0.gold then
		arg_3_0.gold = var_2
	end

	return
end

function var_0_1.GetPreorderState(arg_4_0)
	return arg_4_0.preorderState
end

function var_0_1.GetPreorderTimestamp(arg_5_0)
	return arg_5_0.preorderTimestamp
end

function var_0_1.SetOrderTimestamp(arg_6_0, arg_6_1)
	arg_6_0.preorderTimestamp = arg_6_1
	arg_6_0.preorderState = 1

	return
end

function var_0_1.SetMatchWarning(arg_7_0)
	arg_7_0.isMatchWarning = 1

	return
end

function var_0_1.GetNeedInitFlag(arg_8_0)
	return arg_8_0.needInitFlag
end

function var_0_1.SetNeedInitFlag(arg_9_0, arg_9_1)
	arg_9_0.needInitFlag = arg_9_1

	return
end

function var_0_1.GetUnlockCollectionList(arg_10_0)
	return arg_10_0.unlockCollectionList
end

function var_0_1.AddReliefCnt(arg_11_0)
	arg_11_0.reliefCnt = arg_11_0.reliefCnt + 1

	return
end

function var_0_1.UpdateSettlementData(arg_12_0, arg_12_1)
	local var_12_0

	if not arg_12_1.line then
		var_12_0 = 10
	end

	arg_12_0.storeLine = var_12_0
	arg_12_0.bidItemList = {}
	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(arg_12_1.item_list) do
		local var_12_1 = arg_12_0.bidItemList

		AuctionGameStoreItemData = var_1_10008
		var_12_1[iter_12_0] = var_1_10008.New(iter_12_1)
	end

	return
end

function var_0_1.GetItemList(arg_13_0)
	return arg_13_0.bidItemList
end

function var_0_1.GetMaxLineCnt(arg_14_0)
	local var_14_0

	if not (arg_14_0.storeLine > 10) or not arg_14_0.storeLine then
		var_14_0 = 10
	end

	return var_14_0
end

return var_0_1

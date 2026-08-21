local var_0_0 = class("AuctionGameBaseProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0:UpdateData({})

	arg_1_0.needInitFlag = true

	return
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.gold = arg_2_1.gold or 0
	arg_2_0.matchNum = arg_2_1.game_num or 0
	arg_2_0.bidSuccessCnt = arg_2_1.buy_num or 0
	arg_2_0.highestProfit = arg_2_1.max_profit or 0
	arg_2_0.totalProfit = arg_2_1.acc_profit or 0

	if arg_2_1.item_list then
		arg_2_0.unlockCollectionCnt = #arg_2_1.item_list or 0
		arg_2_0.unlockCollectionList = {}

		local var_2_0 = arg_2_1.item_list or {}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			table.insert(arg_2_0.unlockCollectionList, iter_2_1)
		end

		arg_2_0.totalBidPrice = arg_2_1.acc_buy_price or 0
		arg_2_0.totalCollectionPrice = arg_2_1.acc_item_price or 0
		arg_2_0.preorderState = arg_2_1.pre_buy_state or 0
		arg_2_0.preorderTimestamp = arg_2_1.pre_timestamp or 0
		arg_2_0.forbiddenTime = arg_2_1.match_time or 0
		arg_2_0.isForbidden = arg_2_1.is_forbidden or 0
		arg_2_0.inactiveNum = arg_2_1.inactive_num or 0
		arg_2_0.isMatchWarning = arg_2_1.inactive_state or 0
		arg_2_0.serverForbidden = arg_2_1.back_forbidden or 0
		arg_2_0.reliefCnt = arg_2_1.get_relief_num or 0

		return
	end
end

function var_0_0.AddGold(arg_3_0, arg_3_1)
	arg_3_0.gold = arg_3_0.gold + arg_3_1

	if pg.gameset.auction_currency_ceiling.key_value < arg_3_0.gold then
		arg_3_0.gold = pg.gameset.auction_currency_ceiling.key_value
	end

	return
end

function var_0_0.GetPreorderState(arg_4_0)
	return arg_4_0.preorderState
end

function var_0_0.GetPreorderTimestamp(arg_5_0)
	return arg_5_0.preorderTimestamp
end

function var_0_0.SetOrderTimestamp(arg_6_0, arg_6_1)
	arg_6_0.preorderTimestamp = arg_6_1
	arg_6_0.preorderState = 1

	return
end

function var_0_0.SetMatchWarning(arg_7_0)
	arg_7_0.isMatchWarning = 1

	return
end

function var_0_0.GetNeedInitFlag(arg_8_0)
	return arg_8_0.needInitFlag
end

function var_0_0.SetNeedInitFlag(arg_9_0, arg_9_1)
	arg_9_0.needInitFlag = arg_9_1

	return
end

function var_0_0.GetUnlockCollectionList(arg_10_0)
	return arg_10_0.unlockCollectionList
end

function var_0_0.AddReliefCnt(arg_11_0)
	arg_11_0.reliefCnt = arg_11_0.reliefCnt + 1

	return
end

function var_0_0.UpdateSettlementData(arg_12_0, arg_12_1)
	arg_12_0.storeLine = arg_12_1.line or 10
	arg_12_0.bidItemList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.item_list) do
		arg_12_0.bidItemList[iter_12_0] = AuctionGameStoreItemData.New(iter_12_1)
	end

	return
end

function var_0_0.GetItemList(arg_13_0)
	return arg_13_0.bidItemList
end

function var_0_0.GetMaxLineCnt(arg_14_0)
	if arg_14_0.storeLine > 10 then
		return arg_14_0.storeLine or 10
	end
end

return var_0_0

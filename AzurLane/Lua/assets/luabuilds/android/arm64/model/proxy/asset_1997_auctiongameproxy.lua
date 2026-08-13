class = var_0_10000

local var_0_0 = "AuctionGameProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0:on(23400, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.UpdatePlayerList(var_2_0, arg_2_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_4

		var_2_2(var_2_1, var_4.PLAY_ROOM_QUICK_MATCH_SUCCESS)

		return
	end)
	arg_1_0:on(23401, function(arg_3_0)
		print = var_2_10001

		var_2_10001("竞拍活动：新轮次开始")

		local var_3_0 = arg_1_0

		var_1.UpdateRoundData(var_3_0, arg_3_0)

		local var_3_1 = arg_1_0

		var_1.ResetPlayerOptState(var_3_1)

		arg_1_0.phaseTimestamp = arg_3_0.timestamp

		local var_3_2 = arg_1_0
		local var_3_3 = var_1.sendNotification

		GAME = var_4

		var_3_3(var_3_2, var_4.AUCTION_GAME_NEW_ROUND)

		return
	end)
	arg_1_0:on(23404, function(arg_4_0)
		print = var_2_10001

		var_2_10001("竞拍活动：所有玩家完成个人选择事件")

		local var_4_0 = arg_1_0

		var_1.UpdateGroundEventList(var_4_0, arg_4_0.player_events)

		if arg_4_0.event_effect and arg_4_0.event_effect.event_id ~= 0 then
			local var_4_1 = arg_1_0

			var_1.SetPersonalEventSelectedID(var_4_1, arg_4_0.event_effect.event_id)

			local var_4_2 = arg_1_0

			var_1.UpdateEventEffect(var_4_2, arg_4_0.event_effect)
		end

		local var_4_3 = arg_1_0

		AuctionGameConst = var_2_10002
		var_4_3.auctionState = var_2_10002.AUCTION_PHASE.BID

		local var_4_4 = arg_1_0

		var_1.ResetPlayerOptState(var_4_4)

		arg_1_0.phaseTimestamp = arg_4_0.timestamp

		local var_4_5 = arg_1_0
		local var_4_6 = var_1.sendNotification

		GAME = var_4

		var_4_6(var_4_5, var_4.AUCTION_GAME_BID_PHASE)

		return
	end)
	arg_1_0:on(23412, function(arg_5_0)
		print = var_2_10001

		var_2_10001("竞拍活动：玩家操作完成", arg_5_0.user_id)

		local var_5_0 = arg_1_0

		var_1.UpdatePlayerOptState(var_5_0, arg_5_0)

		return
	end)
	arg_1_0:on(23407, function(arg_6_0)
		print = var_2_10001

		var_2_10001("竞拍活动：出价结果通知")

		table = var_2_10001

		local var_6_0 = var_2_10001.keyof
		local var_6_1 = arg_1_0.leaverList

		getProxy = var_2_10004
		PlayerProxy = var_2_10006

		local var_6_2 = var_2_10004(var_2_10006)

		if var_6_0(var_6_1, var_4.getPlayerId(var_6_2)) then
			return
		end

		local var_6_3 = arg_1_0

		var_1.UpdatePlayerBidList(var_6_3, arg_6_0.bid_list)

		arg_1_0.phaseTimestamp = arg_6_0.timestamp

		local var_6_4 = arg_1_0
		local var_6_5 = var_1.sendNotification

		GAME = var_4

		var_6_5(var_6_4, var_4.AUCTION_GAME_ROUND_OVER)

		local var_6_6 = arg_1_0

		AuctionGameConst = var_2
		var_6_6.auctionState = var_2.AUCTION_PHASE.ROUND_OVER

		return
	end)
	arg_1_0:on(23408, function(arg_7_0)
		print = var_2_10001

		var_2_10001("竞拍活动：竞拍结算")

		local var_7_0 = arg_1_0

		var_1.UpdateSettlementData(var_7_0, arg_7_0)

		local var_7_1 = arg_1_0
		local var_7_2 = var_1.sendNotification

		GAME = var_4

		var_7_2(var_7_1, var_4.AUCTION_GAME_SETTLEMENT)

		return
	end)
	arg_1_0:on(23411, function(arg_8_0)
		ipairs = var_2_10001

		for iter_8_0, iter_8_1 in var_2_10001(arg_8_0.user_ids) do
			getProxy = var_2_10006
			PlayerProxy = var_2_10008
			var_2_10008 = var_2_10006(var_2_10008)

			if iter_8_1 == var_2_10006.getPlayerId(var_2_10008) then
				var_2_10008 = arg_1_0
				var_2_10006 = var_2_10006.sendNotification
				GAME = var_2_10009

				var_2_10006(var_2_10008, var_2_10009.AUCTION_GAME_KICK)
			end

			print = var_2_10006

			var_2_10006("竞拍活动：被服务器踢出游戏", iter_8_1)

			table = var_2_10006

			var_2_10006.insert(arg_1_0.leaverList, iter_8_1)
		end

		return
	end)
	arg_1_0:on(23415, function(arg_9_0)
		if arg_1_0.switchEmojiFlag == 1 then
			return
		end

		print = var_1

		var_1("竞拍活动：收到表情")

		local var_9_0 = arg_1_0
		local var_9_1 = var_1.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.AUCTION_GAME_SHOW_EMOJI, {
			userID = arg_9_0.user_id,
			emojiID = arg_9_0.expression_id
		})

		return
	end)
	arg_1_0:InitGameData()

	return
end

function var_0_1.InitGameData(arg_10_0, arg_10_1)
	arg_10_0.auctionID = arg_10_1
	arg_10_0.playerList = {}
	arg_10_0.round = 0
	arg_10_0.storeItemDataList = {}
	arg_10_0.personalEventList = {}
	arg_10_0.personalEventSelectedID = 0
	arg_10_0.eventSummary = {}
	arg_10_0.roundEventAndBidInfoList = {}
	arg_10_0.forfeit = false
	arg_10_0.playerOptStateList = {}
	arg_10_0.phaseTimestamp = 0
	arg_10_0.leaverList = {}
	arg_10_0.forfeitList = {}
	arg_10_0.sendEmojiTimestamp = 0
	arg_10_0.switchEmojiFlag = 0
	AuctionGameConst = var_2
	arg_10_0.auctionState = var_2.AUCTION_PHASE.WAIT

	return
end

function var_0_1.UpdatePlayerList(arg_11_0, arg_11_1)
	local var_11_0 = {}

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_1.player_list) do
		local var_11_1 = iter_11_1.sort

		Player = var_1_10009
		var_11_0[var_11_1] = var_1_10009.New({
			id = iter_11_1.user_id,
			name = iter_11_1.player_info.name,
			display = iter_11_1.player_info.display
		})
	end

	local var_11_2 = {}
	local var_11_3

	ipairs = var_5

	for iter_11_2, iter_11_3 in var_5(var_11_0) do
		local var_11_4 = iter_11_3.id

		getProxy = var_1_10011
		PlayerProxy = var_1_10013
		var_1_10013 = var_1_10011(var_1_10013)

		if var_11_4 == var_1_10011.getPlayerId(var_1_10013) then
			var_11_3 = iter_11_3
		else
			table = var_11_4

			var_11_4.insert(var_11_2, iter_11_3)
		end
	end

	table = var_5

	var_5.insert(var_11_2, var_11_3)

	arg_11_0.playerList = var_11_2

	local var_11_5

	if not arg_11_1.line then
		var_11_5 = 10
	end

	arg_11_0.storeLine = var_11_5
	print = var_11_5

	var_11_5("最大行数：", arg_11_1.line)

	return
end

function var_0_1.GetPlayerList(arg_12_0)
	return arg_12_0.playerList
end

function var_0_1.GetPlayerVO(arg_13_0, arg_13_1)
	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.playerList) do
		if iter_13_1.id == arg_13_1 then
			return iter_13_1
		end
	end

	return
end

function var_0_1.UpdateRoundData(arg_14_0, arg_14_1)
	arg_14_0.round = arg_14_1.round

	arg_14_0:UpdateEventEffect(arg_14_1.public_event_effect)

	AuctionGameConst = var_2
	arg_14_0.auctionState = var_2.AUCTION_PHASE.COMMON_EVENT
	arg_14_0.personalEventList = {}
	ipairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_1.event_list) do
		table = var_1_10007

		var_1_10007.insert(arg_14_0.personalEventList, iter_14_1)
	end

	AuctionGameConst = var_2
	arg_14_0.auctionState = var_2.AUCTION_PHASE.PERSONAL_EVENT
	arg_14_0.personalEventSelectedID = 0

	if arg_14_1.round == 1 then
		arg_14_0.startTime = arg_14_1.start_time
	end

	return
end

function var_0_1.GetAuctionID(arg_15_0)
	return arg_15_0.auctionID
end

function var_0_1.GetRound(arg_16_0)
	return arg_16_0.round
end

function var_0_1.GetTimestamp(arg_17_0)
	return arg_17_0.phaseTimestamp
end

function var_0_1.GetMaxLineCnt(arg_18_0)
	local var_18_0

	if not (arg_18_0.storeLine > 10) or not arg_18_0.storeLine then
		var_18_0 = 10
	end

	return var_18_0
end

function var_0_1.GetCurStoreLine(arg_19_0)
	local var_19_0 = 10

	pairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.storeItemDataList) do
		local var_19_1 = iter_19_1.position.y

		if var_19_0 < iter_19_1.contour[2] + var_19_1 - 1 then
			var_19_0 = var_7
		end
	end

	return var_19_0
end

function var_0_1.GetStoreItemDataList(arg_20_0)
	return arg_20_0.storeItemDataList
end

function var_0_1.GetLeaverList(arg_21_0)
	return arg_21_0.leaverList
end

function var_0_1.GetForfeitList(arg_22_0)
	return arg_22_0.forfeitList
end

function var_0_1.UpdateEventEffect(arg_23_0, arg_23_1)
	AuctionGameTools = var_1_10002

	var_1_10002.RefreshItemDataByEvent(arg_23_1)

	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.sendNotification

	GAME = var_1_10005

	var_23_1(var_23_0, var_1_10005.AUCTION_GAME_EVENT_EFFECT_UPDATE)

	return
end

function var_0_1.GetPersonalEventList(arg_24_0)
	return arg_24_0.personalEventList
end

function var_0_1.GetPersonalEventSelectedID(arg_25_0)
	return arg_25_0.personalEventSelectedID
end

function var_0_1.SetPersonalEventSelectedID(arg_26_0, arg_26_1)
	arg_26_0.personalEventSelectedID = arg_26_1

	local var_26_0 = arg_26_0.auctionState

	AuctionGameConst = var_1_10003

	if var_26_0 < var_1_10003.AUCTION_PHASE.WAIT_BID then
		AuctionGameConst = var_26_0
		arg_26_0.auctionState = var_26_0.AUCTION_PHASE.WAIT_BID
	end

	return
end

function var_0_1.AddEventSummary(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0.eventSummary
	local var_27_1

	if not arg_27_0.eventSummary[arg_27_1] then
		var_27_1 = {}
	end

	var_27_0[arg_27_1] = var_27_1

	if arg_27_2 then
		arg_27_0.eventSummary[arg_27_1].commonEventData = arg_27_3
	else
		arg_27_0.eventSummary[arg_27_1].personalEventData = arg_27_3
	end

	return
end

function var_0_1.GetEventSummary(arg_28_0)
	return arg_28_0.eventSummary
end

function var_0_1.GetRoundEventAndBidInfoList(arg_29_0)
	return arg_29_0.roundEventAndBidInfoList
end

function var_0_1.GetRoundEventAndBidInfo(arg_30_0, arg_30_1, arg_30_2)
	return arg_30_0.roundEventAndBidInfoList[arg_30_1][arg_30_2]
end

function var_0_1.UpdateGroundEventList(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.roundEventAndBidInfoList
	local var_31_1 = arg_31_0.round
	local var_31_2

	if not arg_31_0.roundEventAndBidInfoList[arg_31_0.round] then
		var_31_2 = {}
	end

	var_31_0[var_31_1] = var_31_2
	ipairs = var_31_0

	for iter_31_0, iter_31_1 in var_31_0(arg_31_1) do
		local var_31_3 = arg_31_0.roundEventAndBidInfoList[arg_31_0.round]
		local var_31_4 = iter_31_1.user_id
		local var_31_5

		if not arg_31_0.roundEventAndBidInfoList[arg_31_0.round][iter_31_1.user_id] then
			var_31_5 = {}
		end

		var_31_3[var_31_4] = var_31_5
		arg_31_0.roundEventAndBidInfoList[arg_31_0.round][iter_31_1.user_id].eventID = iter_31_1.event_id

		if iter_31_1.event_id == nil or iter_31_1.event_id == 0 then
			originalPrint = var_7
			string = var_31_5

			var_7(var_31_5.format("竞拍活动:轮数:%s, 玩家ID:%s, 选择事件ID:<color=red>%s</color>", arg_31_0.round, iter_31_1.user_id, iter_31_1.event_id))
		end
	end

	return
end

function var_0_1.UpdatePlayerBidList(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.roundEventAndBidInfoList
	local var_32_1 = arg_32_0.round
	local var_32_2

	if not arg_32_0.roundEventAndBidInfoList[arg_32_0.round] then
		var_32_2 = {}
	end

	var_32_0[var_32_1] = var_32_2
	ipairs = var_32_0

	for iter_32_0, iter_32_1 in var_32_0(arg_32_1) do
		local var_32_3 = arg_32_0.roundEventAndBidInfoList[arg_32_0.round]
		local var_32_4 = iter_32_1.user_id
		local var_32_5

		if not arg_32_0.roundEventAndBidInfoList[arg_32_0.round][iter_32_1.user_id] then
			var_32_5 = {}
		end

		var_32_3[var_32_4] = var_32_5
		arg_32_0.roundEventAndBidInfoList[arg_32_0.round][iter_32_1.user_id].bidValue = iter_32_1.price

		local var_32_6 = arg_32_0.roundEventAndBidInfoList[arg_32_0.round][iter_32_1.user_id]

		var_32_6.state = iter_32_1.state
		originalPrint = var_32_6
		string = var_32_5

		var_32_6(var_32_5.format("竞拍活动:轮数:%s, 玩家ID:%s, 出价:%s", arg_32_0.round, iter_32_1.user_id, iter_32_1.price))
	end

	return
end

function var_0_1.ResetPlayerOptState(arg_33_0)
	arg_33_0.playerOptStateList = {}
	arg_33_0.playerBidOrderList = {}

	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.sendNotification

	GAME = var_1_10004

	var_33_1(var_33_0, var_1_10004.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE)

	return
end

function var_0_1.UpdatePlayerOptState(arg_34_0, arg_34_1)
	arg_34_0.playerOptStateList[arg_34_1.user_id] = arg_34_1.opt_type

	if arg_34_1.opt_type == 2 then
		table = var_2

		var_2.insert(arg_34_0.playerBidOrderList, arg_34_1.user_id)
	elseif arg_34_1.opt_type == 3 then
		table = var_2

		var_2.insert(arg_34_0.forfeitList, arg_34_1.user_id)
	end

	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.sendNotification

	GAME = var_1_10005

	var_34_1(var_34_0, var_1_10005.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE)

	return
end

function var_0_1.GetPlayerOptStateList(arg_35_0)
	return arg_35_0.playerOptStateList
end

function var_0_1.GetBidOrderList(arg_36_0)
	return arg_36_0.playerBidOrderList
end

function var_0_1.FinishBid(arg_37_0, arg_37_1)
	AuctionGameConst = var_1_10002
	arg_37_0.auctionState = var_1_10002.AUCTION_PHASE.WAIT_OVER

	return
end

function var_0_1.GetAuctionState(arg_38_0)
	return arg_38_0.auctionState
end

function var_0_1.SetForfeit(arg_39_0)
	arg_39_0.forfeit = true

	return
end

function var_0_1.GetForfeit(arg_40_0)
	return arg_40_0.forfeit
end

function var_0_1.SetSendEmojiTimestamp(arg_41_0, arg_41_1)
	arg_41_0.sendEmojiTimestamp = arg_41_1

	return
end

function var_0_1.GetSendEmojiTimestamp(arg_42_0)
	return arg_42_0.sendEmojiTimestamp
end

function var_0_1.SetSwitchEmojiFlag(arg_43_0, arg_43_1)
	arg_43_0.switchEmojiFlag = arg_43_1

	return
end

function var_0_1.GetSwitchEmojiFlag(arg_44_0)
	return arg_44_0.switchEmojiFlag
end

function var_0_1.UpdateSettlementData(arg_45_0, arg_45_1)
	AuctionGameSettlementData = var_1_10002
	arg_45_0.settlementVO = var_1_10002.New(arg_45_1)

	return
end

function var_0_1.GetSettlementData(arg_46_0)
	return arg_46_0.settlementVO
end

return var_0_1

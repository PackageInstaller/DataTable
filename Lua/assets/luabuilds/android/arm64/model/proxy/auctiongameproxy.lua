local var_0_0 = class("AuctionGameProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0:on(23400, function(arg_2_0)
		arg_1_0:UpdatePlayerList(arg_2_0)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_QUICK_MATCH_SUCCESS)

		return
	end)
	arg_1_0:on(23401, function(arg_3_0)
		print("竞拍活动：新轮次开始")
		arg_1_0:UpdateRoundData(arg_3_0)
		arg_1_0:ResetPlayerOptState()

		arg_1_0.phaseTimestamp = arg_3_0.timestamp

		arg_1_0:sendNotification(GAME.AUCTION_GAME_NEW_ROUND)

		return
	end)
	arg_1_0:on(23404, function(arg_4_0)
		print("竞拍活动：所有玩家完成个人选择事件")
		arg_1_0:UpdateGroundEventList(arg_4_0.player_events)

		if arg_4_0.event_effect and arg_4_0.event_effect.event_id ~= 0 then
			arg_1_0:SetPersonalEventSelectedID(arg_4_0.event_effect.event_id)
			arg_1_0:UpdateEventEffect(arg_4_0.event_effect)
		end

		arg_1_0.auctionState = AuctionGameConst.AUCTION_PHASE.BID

		arg_1_0:ResetPlayerOptState()

		arg_1_0.phaseTimestamp = arg_4_0.timestamp

		arg_1_0:sendNotification(GAME.AUCTION_GAME_BID_PHASE)

		return
	end)
	arg_1_0:on(23412, function(arg_5_0)
		print("竞拍活动：玩家操作完成", arg_5_0.user_id)
		arg_1_0:UpdatePlayerOptState(arg_5_0)

		return
	end)
	arg_1_0:on(23407, function(arg_6_0)
		print("竞拍活动：出价结果通知")

		if table.keyof(arg_1_0.leaverList, getProxy(PlayerProxy):getPlayerId()) then
			return
		end

		arg_1_0:UpdatePlayerBidList(arg_6_0.bid_list)

		arg_1_0.phaseTimestamp = arg_6_0.timestamp

		arg_1_0:sendNotification(GAME.AUCTION_GAME_ROUND_OVER)

		arg_1_0.auctionState = AuctionGameConst.AUCTION_PHASE.ROUND_OVER

		return
	end)
	arg_1_0:on(23408, function(arg_7_0)
		print("竞拍活动：竞拍结算")
		arg_1_0:UpdateSettlementData(arg_7_0)
		arg_1_0:sendNotification(GAME.AUCTION_GAME_SETTLEMENT)

		return
	end)
	arg_1_0:on(23411, function(arg_8_0)
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.user_ids) do
			local var_8_0 = getProxy(PlayerProxy)

			if iter_8_1 == var_8_0:getPlayerId() then
				arg_1_0:sendNotification(GAME.AUCTION_GAME_KICK)
			end

			print("竞拍活动：被服务器踢出游戏", iter_8_1)
			table.insert(arg_1_0.leaverList, iter_8_1)
		end

		return
	end)
	arg_1_0:on(23415, function(arg_9_0)
		if arg_1_0.switchEmojiFlag == 1 then
			return
		end

		print("竞拍活动：收到表情")
		arg_1_0:sendNotification(GAME.AUCTION_GAME_SHOW_EMOJI, {
			userID = arg_9_0.user_id,
			emojiID = arg_9_0.expression_id
		})

		return
	end)
	arg_1_0:InitGameData()

	return
end

function var_0_0.InitGameData(arg_10_0, arg_10_1)
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
	arg_10_0.auctionState = AuctionGameConst.AUCTION_PHASE.WAIT

	return
end

function var_0_0.UpdatePlayerList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.player_list) do
		({})[iter_11_1.sort] = Player.New({
			id = iter_11_1.user_id,
			name = iter_11_1.player_info.name,
			display = iter_11_1.player_info.display
		})
	end

	local var_11_0

	for iter_11_2, iter_11_3 in ipairs({}) do
		local var_11_1 = getProxy(PlayerProxy)

		if iter_11_3.id == var_11_1:getPlayerId() then
			var_11_0 = iter_11_3
		else
			table.insert({}, iter_11_3)
		end
	end

	table.insert({}, var_11_0)

	arg_11_0.playerList = {}
	arg_11_0.storeLine = arg_11_1.line or 10

	print("最大行数：", arg_11_1.line)

	return
end

function var_0_0.GetPlayerList(arg_12_0)
	return arg_12_0.playerList
end

function var_0_0.GetPlayerVO(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.playerList) do
		if iter_13_1.id == arg_13_1 then
			return iter_13_1
		end
	end

	return
end

function var_0_0.UpdateRoundData(arg_14_0, arg_14_1)
	arg_14_0.round = arg_14_1.round

	arg_14_0:UpdateEventEffect(arg_14_1.public_event_effect)

	arg_14_0.auctionState = AuctionGameConst.AUCTION_PHASE.COMMON_EVENT
	arg_14_0.personalEventList = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.event_list) do
		table.insert(arg_14_0.personalEventList, iter_14_1)
	end

	arg_14_0.auctionState = AuctionGameConst.AUCTION_PHASE.PERSONAL_EVENT
	arg_14_0.personalEventSelectedID = 0

	if arg_14_1.round == 1 then
		arg_14_0.startTime = arg_14_1.start_time
	end

	return
end

function var_0_0.GetAuctionID(arg_15_0)
	return arg_15_0.auctionID
end

function var_0_0.GetRound(arg_16_0)
	return arg_16_0.round
end

function var_0_0.GetTimestamp(arg_17_0)
	return arg_17_0.phaseTimestamp
end

function var_0_0.GetMaxLineCnt(arg_18_0)
	if arg_18_0.storeLine > 10 then
		return arg_18_0.storeLine or 10
	end
end

function var_0_0.GetCurStoreLine(arg_19_0)
	local var_19_0 = 10

	for iter_19_0, iter_19_1 in pairs(arg_19_0.storeItemDataList) do
		if var_19_0 < iter_19_1.contour[2] + iter_19_1.position.y - 1 then
			var_19_0 = iter_19_1.contour[2] + iter_19_1.position.y - 1
		end
	end

	return var_19_0
end

function var_0_0.GetStoreItemDataList(arg_20_0)
	return arg_20_0.storeItemDataList
end

function var_0_0.GetLeaverList(arg_21_0)
	return arg_21_0.leaverList
end

function var_0_0.GetForfeitList(arg_22_0)
	return arg_22_0.forfeitList
end

function var_0_0.UpdateEventEffect(arg_23_0, arg_23_1)
	AuctionGameTools.RefreshItemDataByEvent(arg_23_1)
	arg_23_0:sendNotification(GAME.AUCTION_GAME_EVENT_EFFECT_UPDATE)

	return
end

function var_0_0.GetPersonalEventList(arg_24_0)
	return arg_24_0.personalEventList
end

function var_0_0.GetPersonalEventSelectedID(arg_25_0)
	return arg_25_0.personalEventSelectedID
end

function var_0_0.SetPersonalEventSelectedID(arg_26_0, arg_26_1)
	arg_26_0.personalEventSelectedID = arg_26_1

	if arg_26_0.auctionState < AuctionGameConst.AUCTION_PHASE.WAIT_BID then
		arg_26_0.auctionState = AuctionGameConst.AUCTION_PHASE.WAIT_BID
	end

	return
end

function var_0_0.AddEventSummary(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0.eventSummary[arg_27_1] = arg_27_0.eventSummary[arg_27_1] or {}

	if arg_27_2 then
		arg_27_0.eventSummary[arg_27_1].commonEventData = arg_27_3
	else
		arg_27_0.eventSummary[arg_27_1].personalEventData = arg_27_3
	end

	return
end

function var_0_0.GetEventSummary(arg_28_0)
	return arg_28_0.eventSummary
end

function var_0_0.GetRoundEventAndBidInfoList(arg_29_0)
	return arg_29_0.roundEventAndBidInfoList
end

function var_0_0.GetRoundEventAndBidInfo(arg_30_0, arg_30_1, arg_30_2)
	return arg_30_0.roundEventAndBidInfoList[arg_30_1][arg_30_2]
end

function var_0_0.UpdateGroundEventList(arg_31_0, arg_31_1)
	arg_31_0.roundEventAndBidInfoList[arg_31_0.round] = arg_31_0.roundEventAndBidInfoList[arg_31_0.round] or {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		arg_31_0.roundEventAndBidInfoList[arg_31_0.round][iter_31_1.user_id] = arg_31_0.roundEventAndBidInfoList[arg_31_0.round][iter_31_1.user_id] or {}
		arg_31_0.roundEventAndBidInfoList[arg_31_0.round][iter_31_1.user_id].eventID = iter_31_1.event_id

		if iter_31_1.event_id == nil or iter_31_1.event_id == 0 then
			originalPrint(string.format("竞拍活动:轮数:%s, 玩家ID:%s, 选择事件ID:<color=red>%s</color>", arg_31_0.round, iter_31_1.user_id, iter_31_1.event_id))
		end
	end

	return
end

function var_0_0.UpdatePlayerBidList(arg_32_0, arg_32_1)
	arg_32_0.roundEventAndBidInfoList[arg_32_0.round] = arg_32_0.roundEventAndBidInfoList[arg_32_0.round] or {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		arg_32_0.roundEventAndBidInfoList[arg_32_0.round][iter_32_1.user_id] = arg_32_0.roundEventAndBidInfoList[arg_32_0.round][iter_32_1.user_id] or {}
		arg_32_0.roundEventAndBidInfoList[arg_32_0.round][iter_32_1.user_id].bidValue = iter_32_1.price
		arg_32_0.roundEventAndBidInfoList[arg_32_0.round][iter_32_1.user_id].state = iter_32_1.state

		originalPrint(string.format("竞拍活动:轮数:%s, 玩家ID:%s, 出价:%s", arg_32_0.round, iter_32_1.user_id, iter_32_1.price))
	end

	return
end

function var_0_0.ResetPlayerOptState(arg_33_0)
	arg_33_0.playerOptStateList = {}
	arg_33_0.playerBidOrderList = {}

	arg_33_0:sendNotification(GAME.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE)

	return
end

function var_0_0.UpdatePlayerOptState(arg_34_0, arg_34_1)
	arg_34_0.playerOptStateList[arg_34_1.user_id] = arg_34_1.opt_type

	if arg_34_1.opt_type == 2 then
		table.insert(arg_34_0.playerBidOrderList, arg_34_1.user_id)
	elseif arg_34_1.opt_type == 3 then
		table.insert(arg_34_0.forfeitList, arg_34_1.user_id)
	end

	arg_34_0:sendNotification(GAME.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE)

	return
end

function var_0_0.GetPlayerOptStateList(arg_35_0)
	return arg_35_0.playerOptStateList
end

function var_0_0.GetBidOrderList(arg_36_0)
	return arg_36_0.playerBidOrderList
end

function var_0_0.FinishBid(arg_37_0, arg_37_1)
	arg_37_0.auctionState = AuctionGameConst.AUCTION_PHASE.WAIT_OVER

	return
end

function var_0_0.GetAuctionState(arg_38_0)
	return arg_38_0.auctionState
end

function var_0_0.SetForfeit(arg_39_0)
	arg_39_0.forfeit = true

	return
end

function var_0_0.GetForfeit(arg_40_0)
	return arg_40_0.forfeit
end

function var_0_0.SetSendEmojiTimestamp(arg_41_0, arg_41_1)
	arg_41_0.sendEmojiTimestamp = arg_41_1

	return
end

function var_0_0.GetSendEmojiTimestamp(arg_42_0)
	return arg_42_0.sendEmojiTimestamp
end

function var_0_0.SetSwitchEmojiFlag(arg_43_0, arg_43_1)
	arg_43_0.switchEmojiFlag = arg_43_1

	return
end

function var_0_0.GetSwitchEmojiFlag(arg_44_0)
	return arg_44_0.switchEmojiFlag
end

function var_0_0.UpdateSettlementData(arg_45_0, arg_45_1)
	arg_45_0.settlementVO = AuctionGameSettlementData.New(arg_45_1)

	return
end

function var_0_0.GetSettlementData(arg_46_0)
	return arg_46_0.settlementVO
end

return var_0_0

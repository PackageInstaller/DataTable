local AuctionGameProxy = class("AuctionGameProxy", import(".NetProxy"))

function AuctionGameProxy:register()
	self:on(23400, function(arg_2_0)
		self:UpdatePlayerList(arg_2_0)
		self:sendNotification(GAME.PLAY_ROOM_QUICK_MATCH_SUCCESS)

		return
	end)
	self:on(23401, function(arg_3_0)
		print("竞拍活动：新轮次开始")
		self:UpdateRoundData(arg_3_0)
		self:ResetPlayerOptState()

		self.phaseTimestamp = arg_3_0.timestamp

		self:sendNotification(GAME.AUCTION_GAME_NEW_ROUND)

		return
	end)
	self:on(23404, function(arg_4_0)
		print("竞拍活动：所有玩家完成个人选择事件")
		self:UpdateGroundEventList(arg_4_0.player_events)

		if arg_4_0.event_effect and arg_4_0.event_effect.event_id ~= 0 then
			self:SetPersonalEventSelectedID(arg_4_0.event_effect.event_id)
			self:UpdateEventEffect(arg_4_0.event_effect)
		end

		self.auctionState = AuctionGameConst.AUCTION_PHASE.BID

		self:ResetPlayerOptState()

		self.phaseTimestamp = arg_4_0.timestamp

		self:sendNotification(GAME.AUCTION_GAME_BID_PHASE)

		return
	end)
	self:on(23412, function(arg_5_0)
		print("竞拍活动：玩家操作完成", arg_5_0.user_id)
		self:UpdatePlayerOptState(arg_5_0)

		return
	end)
	self:on(23407, function(arg_6_0)
		print("竞拍活动：出价结果通知")

		if table.keyof(self.leaverList, getProxy(PlayerProxy):getPlayerId()) then
			return
		end

		self:UpdatePlayerBidList(arg_6_0.bid_list)

		self.phaseTimestamp = arg_6_0.timestamp

		self:sendNotification(GAME.AUCTION_GAME_ROUND_OVER)

		self.auctionState = AuctionGameConst.AUCTION_PHASE.ROUND_OVER

		return
	end)
	self:on(23408, function(arg_7_0)
		print("竞拍活动：竞拍结算")
		self:UpdateSettlementData(arg_7_0)
		self:sendNotification(GAME.AUCTION_GAME_SETTLEMENT)

		return
	end)
	self:on(23411, function(arg_8_0)
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.user_ids) do
			if iter_8_1 == getProxy(PlayerProxy):getPlayerId() then
				self:sendNotification(GAME.AUCTION_GAME_KICK)
			end

			print("竞拍活动：被服务器踢出游戏", iter_8_1)
			table.insert(self.leaverList, iter_8_1)
		end

		return
	end)
	self:on(23415, function(arg_9_0)
		if self.switchEmojiFlag == 1 then
			return
		end

		print("竞拍活动：收到表情")
		self:sendNotification(GAME.AUCTION_GAME_SHOW_EMOJI, {
			userID = arg_9_0.user_id,
			emojiID = arg_9_0.expression_id
		})

		return
	end)
	self:InitGameData()

	return
end

function AuctionGameProxy:InitGameData(arg_10_1)
	self.auctionID = arg_10_1
	self.playerList = {}
	self.round = 0
	self.storeItemDataList = {}
	self.personalEventList = {}
	self.personalEventSelectedID = 0
	self.eventSummary = {}
	self.roundEventAndBidInfoList = {}
	self.forfeit = false
	self.playerOptStateList = {}
	self.phaseTimestamp = 0
	self.leaverList = {}
	self.forfeitList = {}
	self.sendEmojiTimestamp = 0
	self.switchEmojiFlag = 0
	self.auctionState = AuctionGameConst.AUCTION_PHASE.WAIT

	return
end

function AuctionGameProxy:UpdatePlayerList(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.player_list) do
		var_11_0[iter_11_1.sort] = Player.New({
			id = iter_11_1.user_id,
			name = iter_11_1.player_info.name,
			display = iter_11_1.player_info.display
		})
	end

	local var_11_1 = {}
	local var_11_2

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		if iter_11_3.id == getProxy(PlayerProxy):getPlayerId() then
			var_11_2 = iter_11_3
		else
			table.insert(var_11_1, iter_11_3)
		end
	end

	table.insert(var_11_1, var_11_2)

	self.playerList = var_11_1
	self.storeLine = arg_11_1.line or 10

	print("最大行数：", arg_11_1.line)

	return
end

function AuctionGameProxy:GetPlayerList()
	return self.playerList
end

function AuctionGameProxy:GetPlayerVO(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.playerList) do
		if iter_13_1.id == arg_13_1 then
			return iter_13_1
		end
	end

	return
end

function AuctionGameProxy:UpdateRoundData(arg_14_1)
	self.round = arg_14_1.round

	self:UpdateEventEffect(arg_14_1.public_event_effect)

	self.auctionState = AuctionGameConst.AUCTION_PHASE.COMMON_EVENT
	self.personalEventList = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.event_list) do
		table.insert(self.personalEventList, iter_14_1)
	end

	self.auctionState = AuctionGameConst.AUCTION_PHASE.PERSONAL_EVENT
	self.personalEventSelectedID = 0

	if arg_14_1.round == 1 then
		self.startTime = arg_14_1.start_time
	end

	return
end

function AuctionGameProxy:GetAuctionID()
	return self.auctionID
end

function AuctionGameProxy:GetRound()
	return self.round
end

function AuctionGameProxy:GetTimestamp()
	return self.phaseTimestamp
end

function AuctionGameProxy:GetMaxLineCnt()
	return (self.storeLine > 10 or nil) and (self.storeLine or 10)
end

function AuctionGameProxy:GetCurStoreLine()
	local var_19_0 = 10

	for iter_19_0, iter_19_1 in pairs(self.storeItemDataList) do
		if var_19_0 < iter_19_1.contour[2] + iter_19_1.position.y - 1 then
			var_19_0 = iter_19_1.contour[2] + iter_19_1.position.y - 1
		end
	end

	return var_19_0
end

function AuctionGameProxy:GetStoreItemDataList()
	return self.storeItemDataList
end

function AuctionGameProxy:GetLeaverList()
	return self.leaverList
end

function AuctionGameProxy:GetForfeitList()
	return self.forfeitList
end

function AuctionGameProxy:UpdateEventEffect(arg_23_1)
	AuctionGameTools.RefreshItemDataByEvent(arg_23_1)
	self:sendNotification(GAME.AUCTION_GAME_EVENT_EFFECT_UPDATE)

	return
end

function AuctionGameProxy:GetPersonalEventList()
	return self.personalEventList
end

function AuctionGameProxy:GetPersonalEventSelectedID()
	return self.personalEventSelectedID
end

function AuctionGameProxy:SetPersonalEventSelectedID(arg_26_1)
	self.personalEventSelectedID = arg_26_1

	if self.auctionState < AuctionGameConst.AUCTION_PHASE.WAIT_BID then
		self.auctionState = AuctionGameConst.AUCTION_PHASE.WAIT_BID
	end

	return
end

function AuctionGameProxy:AddEventSummary(arg_27_1, arg_27_2, arg_27_3)
	self.eventSummary[arg_27_1] = self.eventSummary[arg_27_1] or {}

	if arg_27_2 then
		self.eventSummary[arg_27_1].commonEventData = arg_27_3
	else
		self.eventSummary[arg_27_1].personalEventData = arg_27_3
	end

	return
end

function AuctionGameProxy:GetEventSummary()
	return self.eventSummary
end

function AuctionGameProxy:GetRoundEventAndBidInfoList()
	return self.roundEventAndBidInfoList
end

function AuctionGameProxy:GetRoundEventAndBidInfo(arg_30_1, arg_30_2)
	return self.roundEventAndBidInfoList[arg_30_1][arg_30_2]
end

function AuctionGameProxy:UpdateGroundEventList(arg_31_1)
	self.roundEventAndBidInfoList[self.round] = self.roundEventAndBidInfoList[self.round] or {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		self.roundEventAndBidInfoList[self.round][iter_31_1.user_id] = self.roundEventAndBidInfoList[self.round][iter_31_1.user_id] or {}
		self.roundEventAndBidInfoList[self.round][iter_31_1.user_id].eventID = iter_31_1.event_id

		if iter_31_1.event_id == nil or iter_31_1.event_id == 0 then
			originalPrint(string.format("竞拍活动:轮数:%s, 玩家ID:%s, 选择事件ID:<color=red>%s</color>", self.round, iter_31_1.user_id, iter_31_1.event_id))
		end
	end

	return
end

function AuctionGameProxy:UpdatePlayerBidList(arg_32_1)
	self.roundEventAndBidInfoList[self.round] = self.roundEventAndBidInfoList[self.round] or {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		self.roundEventAndBidInfoList[self.round][iter_32_1.user_id] = self.roundEventAndBidInfoList[self.round][iter_32_1.user_id] or {}
		self.roundEventAndBidInfoList[self.round][iter_32_1.user_id].bidValue = iter_32_1.price
		self.roundEventAndBidInfoList[self.round][iter_32_1.user_id].state = iter_32_1.state

		originalPrint(string.format("竞拍活动:轮数:%s, 玩家ID:%s, 出价:%s", self.round, iter_32_1.user_id, iter_32_1.price))
	end

	return
end

function AuctionGameProxy:ResetPlayerOptState()
	self.playerOptStateList = {}
	self.playerBidOrderList = {}

	self:sendNotification(GAME.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE)

	return
end

function AuctionGameProxy:UpdatePlayerOptState(arg_34_1)
	self.playerOptStateList[arg_34_1.user_id] = arg_34_1.opt_type

	if arg_34_1.opt_type == 2 then
		table.insert(self.playerBidOrderList, arg_34_1.user_id)
	elseif arg_34_1.opt_type == 3 then
		table.insert(self.forfeitList, arg_34_1.user_id)
	end

	self:sendNotification(GAME.AUCTION_GAME_PLAYER_OPT_STATE_UPDATE)

	return
end

function AuctionGameProxy:GetPlayerOptStateList()
	return self.playerOptStateList
end

function AuctionGameProxy:GetBidOrderList()
	return self.playerBidOrderList
end

function AuctionGameProxy:FinishBid(arg_37_1)
	self.auctionState = AuctionGameConst.AUCTION_PHASE.WAIT_OVER

	return
end

function AuctionGameProxy:GetAuctionState()
	return self.auctionState
end

function AuctionGameProxy:SetForfeit()
	self.forfeit = true

	return
end

function AuctionGameProxy:GetForfeit()
	return self.forfeit
end

function AuctionGameProxy:SetSendEmojiTimestamp(arg_41_1)
	self.sendEmojiTimestamp = arg_41_1

	return
end

function AuctionGameProxy:GetSendEmojiTimestamp()
	return self.sendEmojiTimestamp
end

function AuctionGameProxy:SetSwitchEmojiFlag(arg_43_1)
	self.switchEmojiFlag = arg_43_1

	return
end

function AuctionGameProxy:GetSwitchEmojiFlag()
	return self.switchEmojiFlag
end

function AuctionGameProxy:UpdateSettlementData(arg_45_1)
	self.settlementVO = AuctionGameSettlementData.New(arg_45_1)

	return
end

function AuctionGameProxy:GetSettlementData()
	return self.settlementVO
end

return AuctionGameProxy

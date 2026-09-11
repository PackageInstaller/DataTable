local var_0_0 = singletonClass("AutoChessCardData")

function var_0_0.Init(arg_1_0)
	arg_1_0.CardBagPower = 0
	arg_1_0.CardList = {}
	arg_1_0.RankScore = 0
	arg_1_0.sunglassesState = 0
	arg_1_0.FriendExchangeCardNum = 0
	arg_1_0.OtherExchangeCardNum = 0
	arg_1_0.DesireNum = 0
	arg_1_0.IsDayReward_ = 0
	arg_1_0.LastDesireTime = 0
	arg_1_0.desire = AutoChessDesireDataTemplate.New()
	arg_1_0.FriendDesireList = nil
	arg_1_0.OtherDesireList = nil
	arg_1_0.OpenCardRecordList = {}
	arg_1_0.ChatDesire = nil
	arg_1_0.RewardItemList = {}
	arg_1_0.CardChatOrData_ = {}
	arg_1_0.UnsortCardData_ = {}
	arg_1_0.CardChatTempData_ = {}
	arg_1_0.LastTimestamp_ = 0
	arg_1_0.LastShareTimestamp_ = 0
end

function var_0_0:InitData(arg_2_1)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.card_list or {}) do
		self.CardList[iter_2_1.id] = iter_2_1.num
		var_2_0 = var_2_0 + 1
	end

	self.RankScore = arg_2_1.rank_score
	self.CardBagPower = arg_2_1.energy
	self.sunglassesState = arg_2_1.sunglasses

	self:RefreshRedPoint(var_2_0)
end

function var_0_0:RefreshRedPoint(arg_3_1)
	self:StopTimer()

	local var_3_0 = GameSetting.auto_chess_2_pack_energy_max.value[1]

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
		self.timer_ = Timer.New(function()
			if self.CardBagPower < var_3_0 then
				saveData("auto_chess_4_8", "card_power_is_show", 1)
			end

			if (getData("auto_chess_4_8", "card_power_is_show") or 0) == 1 and arg_3_1 < #AutoChessCardCfg.get_id_list_by_is_card_pool[1] and self.CardBagPower >= var_3_0 then
				manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 1)
			else
				manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
			end

			self:StopTimer()
		end, 0.5, 1)

		self.timer_:Start()
	else
		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
	end
end

function var_0_0:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function var_0_0:InitDesireInfo(arg_6_1)
	self.desire.CardID = arg_6_1.target_id
	self.desire.CardList = arg_6_1.cost_ids
	self.desire.State = arg_6_1.status
	self.desire.BlessID = arg_6_1.bless_id
	self.DesireNum = arg_6_1.self_times
	self.FriendExchangeCardNum = arg_6_1.friend_times
	self.OtherExchangeCardNum = arg_6_1.stranger_times
	self.IsDayReward_ = arg_6_1.reward
	self.LastDesireTime = arg_6_1.last_wish_time

	if arg_6_1.trade_user then
		self.desire.CompleteDesireUser.PlayerID = arg_6_1.trade_user.user_id
		self.desire.CompleteDesireUser.NickName = arg_6_1.trade_user.nick
		self.desire.CompleteDesireUser.Icon = arg_6_1.trade_user.icon
		self.desire.CompleteDesireUser.Level = arg_6_1.trade_user.rank_score
	end

	if arg_6_1.to_bless_id then
		self.desire.CompleteDesireUser.BlessID = arg_6_1.to_bless_id
		self.desire.CompleteDesireUser.SelectCardId = arg_6_1.be_select_id
	end

	if self.desire.State == AutoChessCardConst.DESIRE_STATE.YES then
		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_DESIRE_VIEW, 1)
	end
end

function var_0_0:InitOpenCardRecordInfo(arg_7_1)
	self.OpenCardRecordList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(self.OpenCardRecordList, {
			cardId = iter_7_1.id,
			openTime = iter_7_1.num
		})
	end
end

function var_0_0:UpdateDesireInfo(arg_8_1)
	self.desire.CardID = arg_8_1.target_id
	self.desire.CardList = arg_8_1.cost_ids
	self.desire.BlessID = arg_8_1.bless_id
end

function var_0_0:ConfirmDesire(arg_9_1, arg_9_2)
	if arg_9_1 == AutoChessCardConst.DESIRE_TYPE.MY then
		if manager.time:IsToday(self.LastDesireTime) then
			self.DesireNum = self.DesireNum + 1
		end

		self.desire = AutoChessDesireDataTemplate.New()

		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_DESIRE_VIEW, 0)
	elseif arg_9_1 == AutoChessCardConst.DESIRE_TYPE.OTHER then
		table.remove(self.OtherDesireList, arg_9_2)
	elseif arg_9_1 == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		table.remove(self.FriendDesireList, arg_9_2)
	else
		self.ChatDesire = nil
	end
end

function var_0_0:CompleteOtherDesire(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0
	local var_10_2

	if arg_10_3 == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		var_10_0 = AutoChessCardData:GetFriendDesire(arg_10_2)
		var_10_2 = 1
	elseif arg_10_3 == AutoChessCardConst.DESIRE_TYPE.CHAT then
		var_10_0 = AutoChessCardData:GetChatDesire()
		var_10_2 = 3
	else
		var_10_0 = AutoChessCardData:GetOtherDesire(arg_10_2)
		var_10_2 = 2
	end

	var_10_0:InitCompleteDesireUser(arg_10_1.select_id, arg_10_1.to_bless_id)

	if FriendsData:IsFriend(var_10_0.PlayerID) then
		self.FriendExchangeCardNum = self.FriendExchangeCardNum + 1
	else
		self.OtherExchangeCardNum = self.OtherExchangeCardNum + 1
	end

	SDKTools.SendMessageToSDK("activity_letter", {
		opt = 2,
		activity_id = ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD,
		mail_id_str = var_10_0.TradeID,
		publish_player_uid = var_10_0.PlayerID,
		item_id = var_10_0.CardID,
		cost_item_list = string.format("[%s]", table.concat(var_10_0.CardList, ",")),
		direction_channel = var_10_2,
		reward_id = arg_10_1.select_id
	})
end

function var_0_0:AddCardNum(arg_11_1, arg_11_2)
	self.CardList[arg_11_1] = (self.CardList[arg_11_1] or 0) + arg_11_2
end

function var_0_0:AddRewardItem(arg_12_1)
	self.RewardItemList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		table.insert(self.RewardItemList, iter_12_1)
	end
end

function var_0_0:GetRewardItemList()
	return self.RewardItemList
end

function var_0_0:UpdateCardList(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1.card_list) do
		self.CardList[iter_14_1.id] = iter_14_1.num
	end

	local var_14_0 = true

	for iter_14_2, iter_14_3 in ipairs(AutoChessCardCfg.get_id_list_by_is_card_pool[1]) do
		if self:GetCardNum(iter_14_3) <= 0 then
			var_14_0 = false

			break
		end
	end

	if var_14_0 then
		self:SetSunglassesState(1)
		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
	end
end

function var_0_0.SetChatCardDesire(arg_15_0, arg_15_1)
	local var_15_0 = AutoChessDesireDataTemplate.New()

	var_15_0:InitData(arg_15_1)

	arg_15_0.ChatDesire = var_15_0
end

function var_0_0:GetChatDesire()
	return self.ChatDesire or {}
end

function var_0_0:SetFriendCardList(arg_17_1)
	self.FriendDesireList = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_0 = AutoChessDesireDataTemplate.New()

		var_17_0:InitData(iter_17_1)
		table.insert(self.FriendDesireList, var_17_0)
	end
end

function var_0_0:SetOtherCardList(arg_18_1)
	self.OtherDesireList = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = AutoChessDesireDataTemplate.New()

		var_18_0:InitData(iter_18_1)
		table.insert(self.OtherDesireList, var_18_0)
	end
end

function var_0_0:GetFriendDesire(arg_19_1)
	return self.FriendDesireList[arg_19_1]
end

function var_0_0:GetOtherDesire(arg_20_1)
	return self.OtherDesireList[arg_20_1]
end

function var_0_0:GetFriendDesireNum()
	return (self.FriendDesireList or nil) and (#self.FriendDesireList or 0)
end

function var_0_0:GetOtherDesireNum()
	return (self.OtherDesireList or nil) and (#self.OtherDesireList or 0)
end

function var_0_0:GetFriendCardList()
	return self.FriendDesireList
end

function var_0_0:GetOtherCardList()
	return self.OtherDesireList
end

function var_0_0:GetDesireInfo()
	return self.desire
end

function var_0_0:GetCardNum(arg_26_1)
	return self.CardList[arg_26_1] or 0
end

function var_0_0:GetCardList()
	return self.CardList
end

function var_0_0:GetCardNumByType(arg_28_1)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(self.CardList) do
		if AutoChessCardCfg[iter_28_0].type == arg_28_1 then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function var_0_0:GetOpenCardRecord()
	return self.OpenCardRecordList
end

function var_0_0:GetOpenCardRecordNum()
	return #self.OpenCardRecordList
end

function var_0_0:GetOpenCardRecordByIndex(arg_31_1)
	return self.OpenCardRecordList[arg_31_1] or {}
end

function var_0_0:GetSunglassesState()
	return self.sunglassesState
end

function var_0_0.SetSunglassesState(arg_33_0, arg_33_1)
	arg_33_0.sunglassesState = arg_33_1
end

function var_0_0:GetFriendExchangeCardNum()
	return self.FriendExchangeCardNum
end

function var_0_0:GetOtherExchangeCardNum()
	return self.OtherExchangeCardNum
end

function var_0_0:GetDesireNum()
	return self.DesireNum
end

function var_0_0:GetRankScore()
	return self.RankScore
end

function var_0_0:GetCardBagPower()
	return self.CardBagPower
end

function var_0_0:GetIsDayReward()
	return self.IsDayReward_
end

function var_0_0.SetIsDayReward(arg_40_0, arg_40_1)
	arg_40_0.IsDayReward_ = arg_40_1
end

function var_0_0.SetLastShareTimestamp(arg_41_0)
	arg_41_0.lastShareTimestamp_ = manager.time:GetServerTime()
end

function var_0_0:GetLastShareTimestamp()
	return self.lastShareTimestamp_ or 0
end

function var_0_0:GetLastTimestamp()
	return self.LastTimestamp_
end

function var_0_0:GetChatData()
	return self.CardChatTempData_ or {}
end

function var_0_0:GetOriginChatData()
	return self.CardChatOrData_
end

function var_0_0:InitShareRecordInfo(arg_46_1)
	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		table.insert(self.UnsortCardData_, self:ParseMsg(iter_46_1))
	end
end

function var_0_0:SortMsg()
	local var_47_0 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	table.sort(self.UnsortCardData_, function(arg_48_0, arg_48_1)
		return arg_48_0.timestamp < arg_48_1.timestamp
	end)

	for iter_47_0, iter_47_1 in ipairs(self.UnsortCardData_) do
		self.CardChatOrData_ = self.CardChatOrData_ or {}

		table.insert(self.CardChatOrData_, iter_47_1)
		self:AddChatMsg(iter_47_1, table.keyof(var_47_0, iter_47_1.id))

		if iter_47_0 == #self.UnsortCardData_ then
			self.LastTimestamp_ = iter_47_1.timestamp
		end
	end

	if #self.UnsortCardData_ <= 0 then
		self.LastTimestamp_ = manager.time:GetServerTime()
	end

	self.UnsortCardData_ = {}
end

function var_0_0:InitCacheContent()
	local var_49_1 = clone(self.CardChatOrData_ or {})

	self.CardChatTempData_ = {}

	local var_49_2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_49_0, iter_49_1 in ipairs(var_49_1) do
		self:AddChatMsg(iter_49_1, table.keyof(var_49_2, iter_49_1.id))
	end
end

function var_0_0:AddChatMsg(arg_50_1, arg_50_2)
	if not arg_50_2 then
		for iter_50_0, iter_50_1 in ipairs(self.CardChatTempData_) do
			if iter_50_1.id and iter_50_1.id == arg_50_1.id then
				table.remove(self.CardChatTempData_, iter_50_0)

				if self.CardChatTempData_[iter_50_0 - 1] and self.CardChatTempData_[iter_50_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
					if self.CardChatTempData_[iter_50_0] and self.CardChatTempData_[iter_50_0].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(self.CardChatTempData_, iter_50_0 - 1)

						break
					end

					if iter_50_0 == #self.CardChatTempData_ + 1 then
						table.remove(self.CardChatTempData_, iter_50_0 - 1)
					end
				end

				break
			end
		end

		if #self.CardChatTempData_ > 0 then
			if arg_50_1.timestamp - self.CardChatTempData_[#self.CardChatTempData_ - 1].timestamp > ChatConst.MESSAGE_SPACE then
				table.insert(self.CardChatTempData_, {
					timestamp = arg_50_1.timestamp,
					contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
				})
			end
		end

		table.insert(self.CardChatTempData_, arg_50_1)
	end
end

function var_0_0.ParseMsg(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1.user_wish.user_info
	local var_51_1 = {
		id = arg_51_1.user_wish.trade_id,
		userId = arg_51_1.user_wish.user_info.user_id,
		nick = arg_51_1.user_wish.user_info.nick,
		icon = arg_51_1.user_wish.user_info.icon,
		iconFrame = arg_51_1.user_wish.user_info.icon_frame,
		timestamp = arg_51_1.time,
		contentType = ChatConst.CHAT_CONTENT_TYPE.AUTO_CHESS,
		myCardId = arg_51_1.user_wish.target_id,
		otherCardList = arg_51_1.user_wish.cost_ids
	}

	var_51_1.ip = (arg_51_1.user_wish.user_info.ip_location == nil or var_51_0.ip_location == "") and GetTips("IP_UNKNOWN") or var_51_0.ip_location

	return var_51_1
end

return var_0_0

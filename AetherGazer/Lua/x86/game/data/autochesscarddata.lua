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

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.card_list or {}) do
		arg_2_0.CardList[iter_2_1.id] = iter_2_1.num
		var_2_0 = var_2_0 + 1
	end

	arg_2_0.RankScore = arg_2_1.rank_score
	arg_2_0.CardBagPower = arg_2_1.energy
	arg_2_0.sunglassesState = arg_2_1.sunglasses

	arg_2_0:RefreshRedPoint(var_2_0)
end

function var_0_0.RefreshRedPoint(arg_3_0, arg_3_1)
	arg_3_0:StopTimer()

	local var_3_0 = GameSetting.auto_chess_2_pack_energy_max.value[1]

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0.CardBagPower < var_3_0 then
				saveData("auto_chess_4_8", "card_power_is_show", 1)
			end

			if (getData("auto_chess_4_8", "card_power_is_show") or 0) == 1 and arg_3_1 < #AutoChessCardCfg.get_id_list_by_is_card_pool[1] and arg_3_0.CardBagPower >= var_3_0 then
				manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 1)
			else
				manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
			end

			arg_3_0:StopTimer()
		end, 0.5, 1)

		arg_3_0.timer_:Start()
	else
		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
	end
end

function var_0_0.StopTimer(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end
end

function var_0_0.InitDesireInfo(arg_6_0, arg_6_1)
	arg_6_0.desire.CardID = arg_6_1.target_id
	arg_6_0.desire.CardList = arg_6_1.cost_ids
	arg_6_0.desire.State = arg_6_1.status
	arg_6_0.desire.BlessID = arg_6_1.bless_id
	arg_6_0.DesireNum = arg_6_1.self_times
	arg_6_0.FriendExchangeCardNum = arg_6_1.friend_times
	arg_6_0.OtherExchangeCardNum = arg_6_1.stranger_times
	arg_6_0.IsDayReward_ = arg_6_1.reward
	arg_6_0.LastDesireTime = arg_6_1.last_wish_time

	if arg_6_1.trade_user then
		arg_6_0.desire.CompleteDesireUser.PlayerID = arg_6_1.trade_user.user_id
		arg_6_0.desire.CompleteDesireUser.NickName = arg_6_1.trade_user.nick
		arg_6_0.desire.CompleteDesireUser.Icon = arg_6_1.trade_user.icon
		arg_6_0.desire.CompleteDesireUser.Level = arg_6_1.trade_user.rank_score
	end

	if arg_6_1.to_bless_id then
		arg_6_0.desire.CompleteDesireUser.BlessID = arg_6_1.to_bless_id
		arg_6_0.desire.CompleteDesireUser.SelectCardId = arg_6_1.be_select_id
	end

	if arg_6_0.desire.State == AutoChessCardConst.DESIRE_STATE.YES then
		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_DESIRE_VIEW, 1)
	end
end

function var_0_0.InitOpenCardRecordInfo(arg_7_0, arg_7_1)
	arg_7_0.OpenCardRecordList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(arg_7_0.OpenCardRecordList, {
			cardId = iter_7_1.id,
			openTime = iter_7_1.num
		})
	end
end

function var_0_0.UpdateDesireInfo(arg_8_0, arg_8_1)
	arg_8_0.desire.CardID = arg_8_1.target_id
	arg_8_0.desire.CardList = arg_8_1.cost_ids
	arg_8_0.desire.BlessID = arg_8_1.bless_id
end

function var_0_0.ConfirmDesire(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == AutoChessCardConst.DESIRE_TYPE.MY then
		if manager.time:IsToday(arg_9_0.LastDesireTime) then
			arg_9_0.DesireNum = arg_9_0.DesireNum + 1
		end

		arg_9_0.desire = AutoChessDesireDataTemplate.New()

		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_DESIRE_VIEW, 0)
	elseif arg_9_1 == AutoChessCardConst.DESIRE_TYPE.OTHER then
		table.remove(arg_9_0.OtherDesireList, arg_9_2)
	elseif arg_9_1 == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		table.remove(arg_9_0.FriendDesireList, arg_9_2)
	else
		arg_9_0.ChatDesire = nil
	end
end

function var_0_0.CompleteOtherDesire(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0
	local var_10_1 = 0
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
		arg_10_0.FriendExchangeCardNum = arg_10_0.FriendExchangeCardNum + 1
	else
		arg_10_0.OtherExchangeCardNum = arg_10_0.OtherExchangeCardNum + 1
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

function var_0_0.AddCardNum(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.CardList[arg_11_1] = (arg_11_0.CardList[arg_11_1] or 0) + arg_11_2
end

function var_0_0.AddRewardItem(arg_12_0, arg_12_1)
	arg_12_0.RewardItemList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		table.insert(arg_12_0.RewardItemList, iter_12_1)
	end
end

function var_0_0.GetRewardItemList(arg_13_0)
	return arg_13_0.RewardItemList
end

function var_0_0.UpdateCardList(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1.card_list) do
		arg_14_0.CardList[iter_14_1.id] = iter_14_1.num
	end

	local var_14_0 = true

	for iter_14_2, iter_14_3 in ipairs(AutoChessCardCfg.get_id_list_by_is_card_pool[1]) do
		if arg_14_0:GetCardNum(iter_14_3) <= 0 then
			var_14_0 = false

			break
		end
	end

	if var_14_0 then
		arg_14_0:SetSunglassesState(1)
		manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
	end
end

function var_0_0.SetChatCardDesire(arg_15_0, arg_15_1)
	local var_15_0 = AutoChessDesireDataTemplate.New()

	var_15_0:InitData(arg_15_1)

	arg_15_0.ChatDesire = var_15_0
end

function var_0_0.GetChatDesire(arg_16_0)
	return arg_16_0.ChatDesire or {}
end

function var_0_0.SetFriendCardList(arg_17_0, arg_17_1)
	arg_17_0.FriendDesireList = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_0 = AutoChessDesireDataTemplate.New()

		var_17_0:InitData(iter_17_1)
		table.insert(arg_17_0.FriendDesireList, var_17_0)
	end
end

function var_0_0.SetOtherCardList(arg_18_0, arg_18_1)
	arg_18_0.OtherDesireList = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = AutoChessDesireDataTemplate.New()

		var_18_0:InitData(iter_18_1)
		table.insert(arg_18_0.OtherDesireList, var_18_0)
	end
end

function var_0_0.GetFriendDesire(arg_19_0, arg_19_1)
	return arg_19_0.FriendDesireList[arg_19_1]
end

function var_0_0.GetOtherDesire(arg_20_0, arg_20_1)
	return arg_20_0.OtherDesireList[arg_20_1]
end

function var_0_0.GetFriendDesireNum(arg_21_0)
	return arg_21_0.FriendDesireList and #arg_21_0.FriendDesireList or 0
end

function var_0_0.GetOtherDesireNum(arg_22_0)
	return arg_22_0.OtherDesireList and #arg_22_0.OtherDesireList or 0
end

function var_0_0.GetFriendCardList(arg_23_0)
	return arg_23_0.FriendDesireList
end

function var_0_0.GetOtherCardList(arg_24_0)
	return arg_24_0.OtherDesireList
end

function var_0_0.GetDesireInfo(arg_25_0)
	return arg_25_0.desire
end

function var_0_0.GetCardNum(arg_26_0, arg_26_1)
	return arg_26_0.CardList[arg_26_1] or 0
end

function var_0_0.GetCardList(arg_27_0)
	return arg_27_0.CardList
end

function var_0_0.GetCardNumByType(arg_28_0, arg_28_1)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(arg_28_0.CardList) do
		if AutoChessCardCfg[iter_28_0].type == arg_28_1 then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function var_0_0.GetOpenCardRecord(arg_29_0)
	return arg_29_0.OpenCardRecordList
end

function var_0_0.GetOpenCardRecordNum(arg_30_0)
	return #arg_30_0.OpenCardRecordList
end

function var_0_0.GetOpenCardRecordByIndex(arg_31_0, arg_31_1)
	return arg_31_0.OpenCardRecordList[arg_31_1] or {}
end

function var_0_0.GetSunglassesState(arg_32_0)
	return arg_32_0.sunglassesState
end

function var_0_0.SetSunglassesState(arg_33_0, arg_33_1)
	arg_33_0.sunglassesState = arg_33_1
end

function var_0_0.GetFriendExchangeCardNum(arg_34_0)
	return arg_34_0.FriendExchangeCardNum
end

function var_0_0.GetOtherExchangeCardNum(arg_35_0)
	return arg_35_0.OtherExchangeCardNum
end

function var_0_0.GetDesireNum(arg_36_0)
	return arg_36_0.DesireNum
end

function var_0_0.GetRankScore(arg_37_0)
	return arg_37_0.RankScore
end

function var_0_0.GetCardBagPower(arg_38_0)
	return arg_38_0.CardBagPower
end

function var_0_0.GetIsDayReward(arg_39_0)
	return arg_39_0.IsDayReward_
end

function var_0_0.SetIsDayReward(arg_40_0, arg_40_1)
	arg_40_0.IsDayReward_ = arg_40_1
end

function var_0_0.SetLastShareTimestamp(arg_41_0)
	arg_41_0.lastShareTimestamp_ = manager.time:GetServerTime()
end

function var_0_0.GetLastShareTimestamp(arg_42_0)
	return arg_42_0.lastShareTimestamp_ or 0
end

function var_0_0.GetLastTimestamp(arg_43_0)
	return arg_43_0.LastTimestamp_
end

function var_0_0.GetChatData(arg_44_0)
	return arg_44_0.CardChatTempData_ or {}
end

function var_0_0.GetOriginChatData(arg_45_0)
	return arg_45_0.CardChatOrData_
end

function var_0_0.InitShareRecordInfo(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		table.insert(arg_46_0.UnsortCardData_, arg_46_0:ParseMsg(iter_46_1))
	end
end

function var_0_0.SortMsg(arg_47_0)
	local var_47_0 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	table.sort(arg_47_0.UnsortCardData_, function(arg_48_0, arg_48_1)
		return arg_48_0.timestamp < arg_48_1.timestamp
	end)

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.UnsortCardData_) do
		arg_47_0.CardChatOrData_ = arg_47_0.CardChatOrData_ or {}

		table.insert(arg_47_0.CardChatOrData_, iter_47_1)
		arg_47_0:AddChatMsg(iter_47_1, table.keyof(var_47_0, iter_47_1.id))

		if iter_47_0 == #arg_47_0.UnsortCardData_ then
			arg_47_0.LastTimestamp_ = iter_47_1.timestamp
		end
	end

	if #arg_47_0.UnsortCardData_ <= 0 then
		arg_47_0.LastTimestamp_ = manager.time:GetServerTime()
	end

	arg_47_0.UnsortCardData_ = {}
end

function var_0_0.InitCacheContent(arg_49_0)
	local var_49_0 = clone(arg_49_0.CardChatOrData_ or {})

	arg_49_0.CardChatTempData_ = {}

	local var_49_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		arg_49_0:AddChatMsg(iter_49_1, table.keyof(var_49_1, iter_49_1.id))
	end
end

function var_0_0.AddChatMsg(arg_50_0, arg_50_1, arg_50_2)
	if not arg_50_2 then
		for iter_50_0, iter_50_1 in ipairs(arg_50_0.CardChatTempData_) do
			if iter_50_1.id and iter_50_1.id == arg_50_1.id then
				table.remove(arg_50_0.CardChatTempData_, iter_50_0)

				if arg_50_0.CardChatTempData_[iter_50_0 - 1] and arg_50_0.CardChatTempData_[iter_50_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
					if arg_50_0.CardChatTempData_[iter_50_0] and arg_50_0.CardChatTempData_[iter_50_0].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(arg_50_0.CardChatTempData_, iter_50_0 - 1)

						break
					end

					if iter_50_0 == #arg_50_0.CardChatTempData_ + 1 then
						table.remove(arg_50_0.CardChatTempData_, iter_50_0 - 1)
					end
				end

				break
			end
		end

		local var_50_0 = #arg_50_0.CardChatTempData_

		if var_50_0 <= 0 or arg_50_1.timestamp - arg_50_0.CardChatTempData_[var_50_0 - 1].timestamp > ChatConst.MESSAGE_SPACE then
			local var_50_1 = {
				timestamp = arg_50_1.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			}

			table.insert(arg_50_0.CardChatTempData_, var_50_1)
		end

		table.insert(arg_50_0.CardChatTempData_, arg_50_1)
	end
end

function var_0_0.ParseMsg(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1.time
	local var_51_1 = arg_51_1.user_wish
	local var_51_2 = var_51_1.user_info

	return {
		id = var_51_1.trade_id,
		userId = var_51_2.user_id,
		nick = var_51_2.nick,
		icon = var_51_2.icon,
		iconFrame = var_51_2.icon_frame,
		timestamp = var_51_0,
		contentType = ChatConst.CHAT_CONTENT_TYPE.AUTO_CHESS,
		myCardId = var_51_1.target_id,
		otherCardList = var_51_1.cost_ids,
		ip = (var_51_2.ip_location == nil or var_51_2.ip_location == "") and GetTips("IP_UNKNOWN") or var_51_2.ip_location
	}
end

return var_0_0

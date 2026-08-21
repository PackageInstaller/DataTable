local var_0_0 = {}

manager.net:Bind(90051, function(arg_1_0)
	AutoChessCardData:InitData(arg_1_0)
end)
manager.net:Bind(90053, function(arg_2_0)
	AutoChessCardData:UpdateCardList(arg_2_0)
end)
manager.net:Bind(90055, function(arg_3_0)
	AutoChessCardData:InitDesireInfo(arg_3_0)
end)
manager.net:Bind(90079, function(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.reward_list) do
		table.insert(var_4_0, {
			id = iter_4_1.id,
			num = iter_4_1.num
		})
	end

	AutoChessCardData:AddRewardItem(var_4_0)
end)

function var_0_0.GetCardDesireList(arg_5_0, arg_5_1)
	local var_5_0 = {
		type = arg_5_0
	}

	manager.net:SendWithLoadingNew(90058, var_5_0, 90059, function(arg_6_0, arg_6_1)
		var_0_0.OnCardDesireListBack(arg_6_0, arg_6_1, arg_5_1)
	end)
end

function var_0_0.OnCardDesireListBack(arg_7_0, arg_7_1, arg_7_2)
	if isSuccess(arg_7_0.result) then
		if arg_7_1.type == AutoChessCardConst.DESIRE_TYPE.FRIEND then
			AutoChessCardData:SetFriendCardList(arg_7_0.wish_list)
		else
			AutoChessCardData:SetOtherCardList(arg_7_0.wish_list)
		end

		if arg_7_2 then
			arg_7_2()
		end
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.CompleteDesire(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		user_id = arg_8_0.playerId,
		select_id = arg_8_0.otherList[arg_8_0.selectCard],
		to_bless_id = arg_8_0.selectBlessId
	}

	manager.net:SendWithLoadingNew(90060, var_8_0, 90061, function(arg_9_0, arg_9_1)
		var_0_0.OnCompleteDesireBack(arg_9_0, arg_9_1, arg_8_1, arg_8_2)
	end)
end

function var_0_0.OnCompleteDesireBack(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if isSuccess(arg_10_0.result) then
		AutoChessCardData:CompleteOtherDesire(arg_10_1, arg_10_2, arg_10_3)
		JumpTools.Back()

		local var_10_0 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_0.reward_list) do
			table.insert(var_10_0, {
				id = iter_10_1.id,
				num = iter_10_1.num
			})
		end

		if #var_10_0 > 0 then
			AutoChessCardData:SetIsDayReward(1)
		end

		JumpTools.OpenPageByJump("autoChessDesireCurSceceView", {
			mode = arg_10_3,
			index = arg_10_2,
			rewardList = var_10_0
		})
	else
		ShowTips(arg_10_0.result)
	end
end

function var_0_0.ConfirmDesire(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {
		activity_id = ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD
	}

	manager.net:SendWithLoadingNew(90062, var_11_0, 90063, function(arg_12_0, arg_12_1)
		var_0_0.OnConfirmDesireBack(arg_12_0, arg_12_1, arg_11_0, arg_11_1, arg_11_2)
	end)
end

function var_0_0.OnConfirmDesireBack(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if isSuccess(arg_13_0.result) then
		AutoChessCardData:ConfirmDesire(arg_13_2, arg_13_3)
		JumpTools.Back()

		;({})[1] = {
			id = 1,
			num = 1
		}

		if #arg_13_0.reward_list > 0 then
			AutoChessCardData:SetIsDayReward(1)
			sortMergeGetReward(arg_13_0.reward_list, nil, arg_13_4)
		elseif arg_13_4 then
			arg_13_4()
		end
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.EditDesire(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.otherList) do
		if iter_14_1 ~= 0 then
			table.insert(var_14_0, iter_14_1)
		end
	end

	local var_14_1 = {
		type = arg_14_0,
		target_id = arg_14_1.cardId,
		bless_id = arg_14_1.blessId,
		cost_ids = var_14_0
	}

	manager.net:SendWithLoadingNew(90056, var_14_1, 90057, var_0_0.OnEditDesireBack)
end

function var_0_0.OnEditDesireBack(arg_15_0, arg_15_1)
	if isSuccess(arg_15_0.result) then
		saveData("autochess_4_8", "isShowWish", 0)
		AutoChessCardData:UpdateDesireInfo(arg_15_1)
		JumpTools.Back()

		if #arg_15_0.reward_list > 0 then
			AutoChessCardData:SetIsDayReward(1)
			sortMergeGetReward(arg_15_0.reward_list, nil, function()
				JumpTools.OpenPageByJump("autoChessDesireDatailPopView", {
					mode = AutoChessCardConst.DESIRE_TYPE.MY
				})
			end)
		else
			JumpTools.OpenPageByJump("autoChessDesireDatailPopView", {
				mode = AutoChessCardConst.DESIRE_TYPE.MY
			})
		end
	else
		ShowTips(arg_15_0.result)
	end
end

function var_0_0.PublishDesire()
	local var_17_0 = {}

	manager.net:SendWithLoadingNew(90070, var_17_0, 90071, var_0_0.OnPublishDesireBack)
end

function var_0_0.OnPublishDesireBack(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		AutoChessCardData:SetLastShareTimestamp()
		JumpTools.Back()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_AUTO_CHESS
		})
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_item_exchange_channel_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	else
		ShowTips(arg_18_0.result)
	end
end

function var_0_0.RequestShareRecord()
	local var_19_0 = {
		timestamp = AutoChessCardData:GetLastTimestamp() + 1
	}

	manager.net:SendWithLoadingNew(90072, var_19_0, 90073, var_0_0.OnRequestShareRecordBack)
end

function var_0_0.OnRequestShareRecordBack(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		if #arg_20_0.user_wish_list > 0 then
			AutoChessCardData:InitShareRecordInfo(arg_20_0.user_wish_list)
			AutoChessCardData:SortMsg()
			manager.notify:Invoke(CHAT_NEW_MESSAGE, {
				chatToggleID = ChatConst.CHAT_CHANNEL_AUTO_CHESS
			})
		end
	else
		ShowTips(arg_20_0.result)
	end
end

function var_0_0.RequestViewPlayerDesire(arg_21_0, arg_21_1)
	local var_21_0 = {
		user_ids = {
			arg_21_1
		}
	}

	manager.net:SendWithLoadingNew(90074, var_21_0, 90075, function(arg_22_0, arg_22_1)
		var_0_0.OnRequestViewPlayerDesireBack(arg_22_0, arg_22_1, arg_21_0)
	end)
end

function var_0_0.OnRequestViewPlayerDesireBack(arg_23_0, arg_23_1, arg_23_2)
	if isSuccess(arg_23_0.result) then
		local var_23_0 = arg_23_0.wish_list[1]

		if var_23_0.status == AutoChessCardConst.DESIRE_STATE.NO then
			if var_23_0.trade_id ~= arg_23_2 then
				ShowTips("TIP_EXPIRED")

				return
			end

			AutoChessCardData:SetChatCardDesire(var_23_0)
			JumpTools.OpenPageByJump("autoChessDesireDatailPopView", {
				mode = AutoChessCardConst.DESIRE_TYPE.CHAT
			})
		else
			ShowTips("AUTO_CHESS_2_WISH_GRANTED_BY_OTHERS")
		end
	else
		ShowTips(arg_23_0.result)
	end
end

function var_0_0.OpenCard(arg_24_0, arg_24_1)
	local var_24_0 = {
		times = arg_24_0
	}

	manager.net:SendWithLoadingNew(90064, var_24_0, 90065, function(arg_25_0, arg_25_1)
		var_0_0.OnOpenCardBack(arg_25_0, arg_25_1, arg_24_1)
	end)
end

function var_0_0.OnOpenCardBack(arg_26_0, arg_26_1, arg_26_2)
	if isSuccess(arg_26_0.result) then
		if arg_26_2 then
			arg_26_2(arg_26_1.times, arg_26_0.card_ids)
		end
	else
		ShowTips(arg_26_0.result)
	end
end

function var_0_0.RequestRecord(arg_27_0)
	local var_27_0 = {}

	manager.net:SendWithLoadingNew(90066, var_27_0, 90067, function(arg_28_0, arg_28_1)
		var_0_0.OnRequestRecordBack(arg_28_0, arg_28_1, arg_27_0)
	end)
end

function var_0_0.OnRequestRecordBack(arg_29_0, arg_29_1, arg_29_2)
	if isSuccess(arg_29_0.result) then
		AutoChessCardData:InitOpenCardRecordInfo(arg_29_0.card_his)

		if arg_29_2 then
			arg_29_2()
		end
	else
		ShowTips(arg_29_0.result)
	end
end

function var_0_0.MixCard(arg_30_0, arg_30_1)
	local var_30_0 = {
		target_id = arg_30_0,
		cost_cards = arg_30_1
	}

	manager.net:SendWithLoadingNew(90068, var_30_0, 90069, var_0_0.OnMixCardBack)
end

function var_0_0.OnMixCardBack(arg_31_0, arg_31_1)
	if isSuccess(arg_31_0.result) then
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = AutoChessCardConst.MIX_CARD_TYPE,
			cardList = {
				arg_31_1.target_id
			}
		})
	else
		ShowTips(arg_31_0.result)
	end
end

function var_0_0.RequestSunglasses(arg_32_0, arg_32_1)
	local var_32_0 = {
		type = arg_32_1
	}

	manager.net:SendWithLoadingNew(90076, var_32_0, 90077, function(arg_33_0, arg_33_1)
		var_0_0.OnSunglassesBack(arg_33_0, arg_33_1, arg_32_0)
	end)
end

function var_0_0.OnSunglassesBack(arg_34_0, arg_34_1, arg_34_2)
	if isSuccess(arg_34_0.result) then
		AutoChessCardData:SetSunglassesState(arg_34_1.type)

		if arg_34_2 then
			arg_34_2()
		end
	else
		ShowTips(arg_34_0.result)
	end
end

return var_0_0

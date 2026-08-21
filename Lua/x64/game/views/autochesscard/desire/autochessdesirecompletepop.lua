local var_0_0 = class("AutoChessDesireCompletePop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishSuccessPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.getCard_ = AutoChessCardItem.New(arg_4_0.getCardGo_)
	arg_4_0.loseCard_ = AutoChessCardItem.New(arg_4_0.loseCardGo_)
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.friendController_ = arg_4_0.controller_:GetController("friendBtn")
	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:BackFunc()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnAddFriend_, nil, function()
		if FriendsData:IsFriend(arg_5_0.addFriendUserID) then
			arg_5_0:BackFunc(function()
				AutoChessCardTools.JumpChatPage(arg_5_0.addFriendUserID)
			end)
		else
			if FriendsData:IsRequesting(arg_5_0.addFriendUserID) then
				FriendsAction:TryToDealRequest(arg_5_0.addFriendUserID, 1)
				arg_5_0.friendController_:SetSelectedState("message")
				ShowTips(GetTipsF("FRIEND_MAKE_SUCCESS", arg_5_0.addFriendName))

				return
			end

			if FriendsData:IsInRequest(arg_5_0.addFriendUserID) then
				return
			end

			if FriendsData:IsCanBeFriend(arg_5_0.addFriendUserID) then
				FriendsAction:TryToRequestToFriend(arg_5_0.addFriendUserID, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
				arg_5_0.friendController_:SetSelectedState("gou")
			end
		end
	end)
end

function var_0_0.BackFunc(arg_9_0, arg_9_1)
	if arg_9_0.mode_ == AutoChessCardConst.DESIRE_TYPE.MY then
		AutoChessCardAction.ConfirmDesire(arg_9_0.mode_, arg_9_0.index_, arg_9_1)
	else
		AutoChessCardData:ConfirmDesire(arg_9_0.mode_, arg_9_0.index_)
		arg_9_0:Back()

		if arg_9_0.params_.rewardList then
			sortMergeGetReward(arg_9_0.params_.rewardList)
		end

		if arg_9_1 then
			arg_9_1()
		end
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.index_ = arg_10_0.params_.index
	arg_10_0.mode_ = arg_10_0.params_.mode

	if arg_10_0.mode_ == AutoChessCardConst.DESIRE_TYPE.MY then
		local var_10_0 = AutoChessCardData:GetDesireInfo()

		arg_10_0.getCard_:SetData(var_10_0.CardID, arg_10_0.URFactoryItem_:GetItem(var_10_0.CardID))
		arg_10_0.loseCard_:SetData(var_10_0.CompleteDesireUser.SelectCardId, arg_10_0.URFactoryItem_:GetItem(var_10_0.CompleteDesireUser.SelectCardId))

		local var_10_1, var_10_2 = AutoChessTools.GetRankLevelCfg(var_10_0.CompleteDesireUser.Level)

		arg_10_0.rankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_10_1.icon)
		arg_10_0.txtRankLevel_.text = var_10_1.name
		arg_10_0.txtPlayerName_.text = var_10_0.CompleteDesireUser.NickName

		arg_10_0.commonPortrait_:RenderHead(var_10_0.CompleteDesireUser.Icon)

		arg_10_0.txtBless_.text = GetTips(var_10_0.CompleteDesireUser.BlessID)
		arg_10_0.txtTitle_.text = GetTips("AUTO_CHESS_2_WISH_COMPLETE_POP")
		arg_10_0.txtTitleLine_.text = GetTips("AUTO_CHESS_2_WISH_COMPLETE_POP")
		arg_10_0.addFriendUserID = var_10_0.CompleteDesireUser.PlayerID
		arg_10_0.addFriendName = var_10_0.CompleteDesireUser.NickName
	else
		local var_10_3

		if arg_10_0.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND then
			var_10_3 = AutoChessCardData:GetFriendDesire(arg_10_0.index_)
		elseif arg_10_0.mode_ == AutoChessCardConst.DESIRE_TYPE.OTHER then
			var_10_3 = AutoChessCardData:GetOtherDesire(arg_10_0.index_)
		else
			var_10_3 = AutoChessCardData:GetChatDesire()
		end

		arg_10_0.getCard_:SetData(var_10_3.CompleteDesireUser.SelectCardId, arg_10_0.URFactoryItem_:GetItem(var_10_3.CompleteDesireUser.SelectCardId))
		arg_10_0.loseCard_:SetData(var_10_3.CardID, arg_10_0.URFactoryItem_:GetItem(var_10_3.CardID))

		local var_10_4, var_10_5 = AutoChessTools.GetRankLevelCfg(var_10_3.Level)

		arg_10_0.rankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_10_4.icon)
		arg_10_0.txtRankLevel_.text = var_10_4.name
		arg_10_0.txtPlayerName_.text = var_10_3.NickName

		arg_10_0.commonPortrait_:RenderHead(var_10_3.Icon)

		arg_10_0.txtBless_.text = GetTips(var_10_3.BlessID)
		arg_10_0.txtTitle_.text = GetTips("AUTO_CHESS_2_EXCHANGE_COMPLETE_POP")
		arg_10_0.txtTitleLine_.text = GetTips("AUTO_CHESS_2_EXCHANGE_COMPLETE_POP")
		arg_10_0.addFriendUserID = var_10_3.PlayerID
		arg_10_0.addFriendName = var_10_3.NickName
	end

	if FriendsData:IsFriend(arg_10_0.addFriendUserID) then
		arg_10_0.friendController_:SetSelectedState("message")
	elseif FriendsData:IsInRequest(arg_10_0.addFriendUserID) then
		arg_10_0.friendController_:SetSelectedState("gou")
	else
		arg_10_0.friendController_:SetSelectedState("add")
	end
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.getCard_:Dispose()
	arg_12_0.loseCard_:Dispose()
	arg_12_0.commonPortrait_:Dispose()
	arg_12_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

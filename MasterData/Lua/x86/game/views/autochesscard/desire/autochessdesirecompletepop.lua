local AutoChessDesireCompletePop = class("AutoChessDesireCompletePop", ReduxView)

function AutoChessDesireCompletePop:UIName()
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishSuccessPopUI"
end

function AutoChessDesireCompletePop:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessDesireCompletePop:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireCompletePop:InitUI()
	self:BindCfgUI()

	self.getCard_ = AutoChessCardItem.New(self.getCardGo_)
	self.loseCard_ = AutoChessCardItem.New(self.loseCardGo_)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.friendController_ = self.controller_:GetController("friendBtn")
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessDesireCompletePop:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:BackFunc()
	end)
	self:AddBtnListener(self.btnAddFriend_, nil, function()
		if FriendsData:IsFriend(self.addFriendUserID) then
			self:BackFunc(function()
				AutoChessCardTools.JumpChatPage(self.addFriendUserID)
			end)
		else
			if FriendsData:IsRequesting(self.addFriendUserID) then
				FriendsAction:TryToDealRequest(self.addFriendUserID, 1)
				self.friendController_:SetSelectedState("message")
				ShowTips(GetTipsF("FRIEND_MAKE_SUCCESS", self.addFriendName))

				return
			end

			if FriendsData:IsInRequest(self.addFriendUserID) then
				return
			end

			if FriendsData:IsCanBeFriend(self.addFriendUserID) then
				FriendsAction:TryToRequestToFriend(self.addFriendUserID, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
				self.friendController_:SetSelectedState("gou")
			end
		end
	end)
end

function AutoChessDesireCompletePop:BackFunc(arg_9_1)
	if self.mode_ == AutoChessCardConst.DESIRE_TYPE.MY then
		AutoChessCardAction.ConfirmDesire(self.mode_, self.index_, arg_9_1)
	else
		AutoChessCardData:ConfirmDesire(self.mode_, self.index_)
		self:Back()

		if self.params_.rewardList then
			sortMergeGetReward(self.params_.rewardList)
		end

		if arg_9_1 then
			arg_9_1()
		end
	end
end

function AutoChessDesireCompletePop:OnEnter()
	self.index_ = self.params_.index
	self.mode_ = self.params_.mode

	if self.mode_ == AutoChessCardConst.DESIRE_TYPE.MY then
		local var_10_0 = AutoChessCardData:GetDesireInfo()

		self.getCard_:SetData(var_10_0.CardID, self.URFactoryItem_:GetItem(var_10_0.CardID))
		self.loseCard_:SetData(var_10_0.CompleteDesireUser.SelectCardId, self.URFactoryItem_:GetItem(var_10_0.CompleteDesireUser.SelectCardId))

		local var_10_1, var_10_2 = AutoChessTools.GetRankLevelCfg(var_10_0.CompleteDesireUser.Level)

		self.rankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_10_1.icon)
		self.txtRankLevel_.text = var_10_1.name
		self.txtPlayerName_.text = var_10_0.CompleteDesireUser.NickName

		self.commonPortrait_:RenderHead(var_10_0.CompleteDesireUser.Icon)

		self.txtBless_.text = GetTips(var_10_0.CompleteDesireUser.BlessID)
		self.txtTitle_.text = GetTips("AUTO_CHESS_2_WISH_COMPLETE_POP")
		self.txtTitleLine_.text = GetTips("AUTO_CHESS_2_WISH_COMPLETE_POP")
		self.addFriendUserID = var_10_0.CompleteDesireUser.PlayerID
		self.addFriendName = var_10_0.CompleteDesireUser.NickName
	else
		local var_10_3 = self.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND and AutoChessCardData:GetFriendDesire(self.index_) or self.mode_ == AutoChessCardConst.DESIRE_TYPE.OTHER and AutoChessCardData:GetOtherDesire(self.index_) or AutoChessCardData:GetChatDesire()

		self.getCard_:SetData(var_10_3.CompleteDesireUser.SelectCardId, self.URFactoryItem_:GetItem(var_10_3.CompleteDesireUser.SelectCardId))
		self.loseCard_:SetData(var_10_3.CardID, self.URFactoryItem_:GetItem(var_10_3.CardID))

		local var_10_4, var_10_5 = AutoChessTools.GetRankLevelCfg(var_10_3.Level)

		self.rankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_10_4.icon)
		self.txtRankLevel_.text = var_10_4.name
		self.txtPlayerName_.text = var_10_3.NickName

		self.commonPortrait_:RenderHead(var_10_3.Icon)

		self.txtBless_.text = GetTips(var_10_3.BlessID)
		self.txtTitle_.text = GetTips("AUTO_CHESS_2_EXCHANGE_COMPLETE_POP")
		self.txtTitleLine_.text = GetTips("AUTO_CHESS_2_EXCHANGE_COMPLETE_POP")
		self.addFriendUserID = var_10_3.PlayerID
		self.addFriendName = var_10_3.NickName
	end

	if FriendsData:IsFriend(self.addFriendUserID) then
		self.friendController_:SetSelectedState("message")
	elseif FriendsData:IsInRequest(self.addFriendUserID) then
		self.friendController_:SetSelectedState("gou")
	else
		self.friendController_:SetSelectedState("add")
	end
end

function AutoChessDesireCompletePop:OnTop()
	manager.windowBar:HideBar()
end

function AutoChessDesireCompletePop:Dispose()
	self.getCard_:Dispose()
	self.loseCard_:Dispose()
	self.commonPortrait_:Dispose()
	self.URFactoryItem_:Dispose()
	AutoChessDesireCompletePop.super.Dispose(self)
end

return AutoChessDesireCompletePop

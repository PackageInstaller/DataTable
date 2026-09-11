local AutoChessDesireDatailPopView = class("AutoChessDesireDatailPopView", ReduxView)

function AutoChessDesireDatailPopView:UIName()
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishCheckPopUI"
end

function AutoChessDesireDatailPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessDesireDatailPopView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireDatailPopView:InitUI()
	self.needDesireItem_ = AutoChessDesireItem.New(self.cardGo_)
	self.desireItemList_ = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.desireItemList_, AutoChessDesireItem.New(self["cardGo" .. iter_4_0 .. "_"]))
	end

	self.okHandler_ = nil
	self.cancelHandler_ = nil
	self.popStateController_ = self.controller_:GetController("popState")
	self.dropDownController_ = self.controller_:GetController("dropDown")
	self.friendController_ = self.controller_:GetController("friendBtn")
	self.btnGreyController_ = self.btnController_:GetController("grey")
	self.desireBlessItemList_ = {}

	for iter_4_1, iter_4_2 in ipairs(GameSetting.auto_chess_2_wish_texts.value) do
		local var_4_0 = AutoChessDesireBlessItem.New(Object.Instantiate(self.blessGo_, self.blessTrans_), handler(self, self.onSelectBlessItem))

		var_4_0:SetData(iter_4_2)
		var_4_0:SetActive(true)
		table.insert(self.desireBlessItemList_, var_4_0)
	end

	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessDesireDatailPopView:onSelectBlessItem(arg_5_1)
	self.dropDownController_:SetSelectedState("hide")

	self.txtSelectBless_.text = GetTips(arg_5_1)

	if self.mode_ then
		self.context.selectBlessId = arg_5_1
	else
		self.context.blessId = arg_5_1
	end
end

function AutoChessDesireDatailPopView:BuildContext(arg_6_1)
	local var_6_0 = GameSetting.auto_chess_2_wish_texts.value
	local var_6_1 = {
		selectCard = 0,
		playerId = arg_6_1.PlayerID,
		cardId = arg_6_1.CardID
	}

	if arg_6_1.BlessID == 0 then
		var_6_1.blessId = var_6_0[1] or arg_6_1.BlessID
	end

	local var_6_2 = {}

	var_6_2[1] = arg_6_1.CardList[1] or 0
	var_6_2[2] = arg_6_1.CardList[2] or 0
	var_6_2[3] = arg_6_1.CardList[3] or 0
	var_6_1.otherList = var_6_2
	var_6_1.selectBlessId = var_6_0[1]
	self.context = var_6_1
end

function AutoChessDesireDatailPopView:AddListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.okHandler_ then
			self.okHandler_()
		end
	end)
	self:AddBtnListener(self.editDesireBtn_, nil, function()
		if self.cancelHandler_ then
			self.cancelHandler_()
		end
	end)
	self:AddBtnListener(self.publishDesireBtn_, nil, function()
		if self.okHandler_ then
			self.okHandler_()
		end
	end)
	self:AddBtnListener(self.addMyBtn_, nil, function()
		if self.addMyBtnHandle_ then
			self.addMyBtnHandle_()
		end
	end)
	self:AddBtnListener(self.addNeedBtn1_, nil, function()
		if self.addNeedBtn1Handle_ then
			self.addNeedBtn1Handle_()
		end
	end)
	self:AddBtnListener(self.addNeedBtn2_, nil, function()
		if self.addNeedBtn2Handle_ then
			self.addNeedBtn2Handle_()
		end
	end)
	self:AddBtnListener(self.addNeedBtn3_, nil, function()
		if self.addNeedBtn3Handle_ then
			self.addNeedBtn3Handle_()
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.maskHandler_ then
			self.maskHandler_()
		end
	end)
	self:AddBtnListener(self.openSelectBtn_, nil, function()
		if self.dropDownController_:GetSelectedState() == "show" then
			self.dropDownController_:SetSelectedState("hide")
		else
			self.dropDownController_:SetSelectedState("show")

			for iter_16_0, iter_16_1 in ipairs(self.desireBlessItemList_) do
				if self.mode_ then
					iter_16_1:SetState(self.context.selectBlessId)
				else
					iter_16_1:SetState(self.context.blessId)
				end
			end
		end
	end)
	self:AddBtnListener(self.btnAddFriend_, nil, function()
		self.dropDownController_:SetSelectedState("hide")

		if FriendsData:IsFriend(self.context.playerId) then
			AutoChessCardTools.JumpChatPage(self.context.playerId)
		else
			if FriendsData:IsRequesting(self.context.playerId) then
				FriendsAction:TryToDealRequest(self.context.playerId, 1)
				self.friendController_:SetSelectedState("message")

				return
			end

			if FriendsData:IsInRequest(self.context.playerId) then
				return
			end

			if FriendsData:IsCanBeFriend(self.context.playerId) then
				FriendsAction:TryToRequestToFriend(self.context.playerId, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
				self.friendController_:SetSelectedState("gou")
			end
		end
	end)
end

function AutoChessDesireDatailPopView:OnExit()
	self.dropDownController_:SetSelectedState("hide")
end

function AutoChessDesireDatailPopView:OnEnter()
	self.onUpdateSelectCard = nil
	self.index_ = self.params_.index
	self.mode_ = self.params_.mode

	if self.mode_ ~= AutoChessCardConst.DESIRE_TYPE.MY then
		local var_19_0 = self.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND and AutoChessCardData:GetFriendDesire(self.index_) or self.mode_ == AutoChessCardConst.DESIRE_TYPE.CHAT and AutoChessCardData:GetChatDesire() or AutoChessCardData:GetOtherDesire(self.index_)

		self:UpdateDesireInfo(var_19_0)
		self.needDesireItem_:RefreshHead(var_19_0.Icon, var_19_0.Level, var_19_0.NickName)

		self.okHandler_ = handler(self, self.OnCompleteDesire)
		self.cancelHandler_ = handler(self, self.OnCancelDesire)
		self.maskHandler_ = handler(self, self.OnCancelDesire)
		self.addMyBtnHandle_ = handler(self, self.OnMyCardDisabled)
		self.addNeedBtn1Handle_ = handler(self, function()
			self:OnSelectNeedCard(1)
		end)
		self.addNeedBtn2Handle_ = handler(self, function()
			self:OnSelectNeedCard(2)
		end)
		self.addNeedBtn3Handle_ = handler(self, function()
			self:OnSelectNeedCard(3)
		end)

		self.popStateController_:SetSelectedState("other")

		self.txtSelectBless_.text = GetTips(self.context.selectBlessId)

		self.needDesireItem_:SetOwnNumState(2)

		if FriendsData:IsFriend(self.context.playerId) then
			self.friendController_:SetSelectedState("messag")
		elseif FriendsData:IsInRequest(self.context.playerId) then
			self.friendController_:SetSelectedState("gou")
		else
			self.friendController_:SetSelectedState("add")
		end
	else
		local var_19_1 = AutoChessCardData:GetDesireInfo()

		self.isEdit_ = false
		self.okHandler_ = handler(self, self.onPublishDesire)
		self.cancelHandler_ = handler(self, self.OnEditDesire)
		self.maskHandler_ = handler(self, self.OnCancelDesire)

		self.popStateController_:SetSelectedState("me")

		local var_19_2 = PlayerData:GetPlayerInfo()

		self.needDesireItem_:RefreshHead(var_19_2.portrait, AutoChessCardData:GetRankScore(), var_19_2.nick)

		self.addMyBtnHandle_ = handler(self, self.OnMyCardDisabled)
		self.addNeedBtn1Handle_ = handler(self, self.OnMyCardDisabled)
		self.addNeedBtn2Handle_ = handler(self, self.OnMyCardDisabled)
		self.addNeedBtn3Handle_ = handler(self, self.OnMyCardDisabled)

		if AutoChessCardData:GetCardNum(var_19_1.CardID) > 0 then
			self.needDesireItem_:SetOwnNumState(0)
		else
			self.needDesireItem_:SetOwnNumState(1)
		end

		self:UpdateDesireInfo(var_19_1)

		self.txtSelectBless_.text = GetTips(self.context.blessId)
	end
end

function AutoChessDesireDatailPopView:OnTop()
	return
end

function AutoChessDesireDatailPopView:UpdateDesireInfo(arg_24_1)
	self:BuildContext(arg_24_1)
	self:RefreshUI()
end

function AutoChessDesireDatailPopView:RefreshUI()
	self.txtBless_.text = GetTips(self.context.blessId)

	local var_25_0 = self.mode_ ~= AutoChessCardConst.DESIRE_TYPE.MY

	self.needDesireItem_:SetData(self.context.cardId, self.URFactoryItem_:GetItem(self.context.cardId))
	self.needDesireItem_:SetWishState(0)

	if self.context.cardId == 0 then
		self.needDesireItem_:SetEmptyState(1)
	else
		self.needDesireItem_:SetEmptyState(0)

		if AutoChessCardData:GetCardNum(self.context.cardId) <= 1 and var_25_0 then
			self.needDesireItem_:SetGreyState(true)
		else
			self.needDesireItem_:SetGreyState(false)
		end
	end

	for iter_25_0 = 1, 3 do
		self.desireItemList_[iter_25_0]:SetOwnNumState(0)
		self.desireItemList_[iter_25_0]:SetSelectState(false)
		self.desireItemList_[iter_25_0]:SetData(self.context.otherList[iter_25_0], self.URFactoryItem_:GetItem(self.context.otherList[iter_25_0]))
		self.desireItemList_[iter_25_0]:RefreshWishState(var_25_0)

		if self.context.otherList[iter_25_0] == 0 and not self.isEdit_ then
			self.desireItemList_[iter_25_0]:SetActive(false)
		else
			self.desireItemList_[iter_25_0]:SetActive(true)

			if self.context.otherList[iter_25_0] == 0 then
				if self.context.cardId == 0 then
					self.desireItemList_[iter_25_0]:SetEmptyState(2)
				else
					self.desireItemList_[iter_25_0]:SetEmptyState(1)
				end
			else
				self.desireItemList_[iter_25_0]:SetEmptyState(0)
			end
		end
	end

	if self.context.selectCard == 0 or AutoChessCardData:GetCardNum(self.context.cardId) <= 1 then
		self.btnGreyController_:SetSelectedState("grey")
	else
		self.btnGreyController_:SetSelectedState("normal")
	end
end

function AutoChessDesireDatailPopView:OnCompleteDesire()
	if AutoChessCardData:GetCardNum(self.context.cardId) <= 1 then
		ShowTips(GetTips("AUTO_CHESS_2_EXCHANGE_INSUFFICIENT_CARD"))

		return
	end

	if self.context.selectBlessId == 0 then
		return
	end

	if self.context.selectCard == 0 then
		return
	end

	AutoChessCardAction.CompleteDesire(self.context, self.index_, self.mode_)
end

function AutoChessDesireDatailPopView:OnCancelDesire()
	self:Back()
end

function AutoChessDesireDatailPopView:onEditCancelDesire()
	for iter_28_0, iter_28_1 in ipairs(self.context.otherList) do
		if iter_28_1 ~= 0 then
			AutoChessCardData:AddCardNum(iter_28_1, -1)
		end
	end

	self:Back()
end

function AutoChessDesireDatailPopView:onPublishDesire()
	if manager.time:GetServerTime() - AutoChessCardData:GetLastShareTimestamp() <= GameSetting.auto_chess_2_chat_send_cd.value[1] then
		ShowTips(GetTips("ERROR_CHAT_WORD_TOO_FREQUENTLY"))

		return
	end

	AutoChessCardAction.PublishDesire()
end

function AutoChessDesireDatailPopView:OnEditDesire()
	JumpTools.Back()
	JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView")
end

function AutoChessDesireDatailPopView:OnMyCardDisabled()
	self.dropDownController_:SetSelectedState("hide")
end

function AutoChessDesireDatailPopView:OnSelectNeedCard(arg_32_1)
	self.dropDownController_:SetSelectedState("hide")

	if self.context.selectCard ~= 0 then
		self.desireItemList_[self.context.selectCard]:SetSelectState(false)
	end

	self.context.selectCard = arg_32_1

	self.desireItemList_[arg_32_1]:SetSelectState(true)

	if AutoChessCardData:GetCardNum(self.context.cardId) <= 1 then
		self.btnGreyController_:SetSelectedState("grey")
	else
		self.btnGreyController_:SetSelectedState("normal")
	end
end

function AutoChessDesireDatailPopView:Dispose()
	for iter_33_0, iter_33_1 in ipairs(self.desireBlessItemList_) do
		iter_33_1:Dispose()
	end

	self.needDesireItem_:Dispose()

	for iter_33_2 = 1, 3 do
		self.desireItemList_[iter_33_2]:Dispose()
	end

	self.URFactoryItem_:Dispose()
	AutoChessDesireDatailPopView.super.Dispose(self)
end

return AutoChessDesireDatailPopView

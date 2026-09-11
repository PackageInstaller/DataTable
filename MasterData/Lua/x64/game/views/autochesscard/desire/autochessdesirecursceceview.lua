local AutoChessDesireCurSceceView = class("AutoChessDesireCurSceceView", ReduxView)

function AutoChessDesireCurSceceView:UIName()
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishCutsceneUI"
end

function AutoChessDesireCurSceceView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessDesireCurSceceView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireCurSceceView:InitUI()
	self:BindCfgUI()

	self.getCard_ = AutoChessCardItem.New(self.getCardGo_)
	self.loseCard_ = AutoChessCardItem.New(self.loseCardGo_)
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessDesireCurSceceView:AddListeners()
	return
end

function AutoChessDesireCurSceceView:OnEnter()
	self.index_ = self.params_.index
	self.mode_ = self.params_.mode

	if self.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		local var_6_0 = AutoChessCardData:GetFriendDesire(self.index_)

		self.getCard_:SetData(var_6_0.CompleteDesireUser.SelectCardId, self.URFactoryItem_:GetItem(var_6_0.CompleteDesireUser.SelectCardId))
		self.loseCard_:SetData(var_6_0.CardID, self.URFactoryItem_:GetItem(var_6_0.CardID))
	elseif self.mode_ == AutoChessCardConst.DESIRE_TYPE.CHAT then
		local var_6_1 = AutoChessCardData:GetChatDesire()

		self.getCard_:SetData(var_6_1.CompleteDesireUser.SelectCardId, self.URFactoryItem_:GetItem(var_6_1.CompleteDesireUser.SelectCardId))
		self.loseCard_:SetData(var_6_1.CardID, self.URFactoryItem_:GetItem(var_6_1.CardID))
	elseif self.mode_ == AutoChessCardConst.DESIRE_TYPE.MY then
		local var_6_2 = AutoChessCardData:GetDesireInfo()

		self.getCard_:SetData(var_6_2.CardID, self.URFactoryItem_:GetItem(var_6_2.CardID))
		self.loseCard_:SetData(var_6_2.CompleteDesireUser.SelectCardId, self.URFactoryItem_:GetItem(var_6_2.CompleteDesireUser.SelectCardId))
	else
		local var_6_3 = AutoChessCardData:GetOtherDesire(self.index_)

		self.getCard_:SetData(var_6_3.CompleteDesireUser.SelectCardId, self.URFactoryItem_:GetItem(var_6_3.CompleteDesireUser.SelectCardId))
		self.loseCard_:SetData(var_6_3.CardID, self.URFactoryItem_:GetItem(var_6_3.CardID))
	end

	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:Back()
		JumpTools.OpenPageByJump("autoChessDesireCompletePop", {
			mode = self.mode_,
			index = self.index_,
			rewardList = self.params_.rewardList
		})
	end, 2, 1)

	self.timer_:Start()
end

function AutoChessDesireCurSceceView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AutoChessDesireCurSceceView:OnTop()
	manager.windowBar:HideBar()
end

function AutoChessDesireCurSceceView:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.getCard_:Dispose()
	self.loseCard_:Dispose()
	self.URFactoryItem_:Dispose()
	AutoChessDesireCurSceceView.super.Dispose(self)
end

return AutoChessDesireCurSceceView

local BloodCardDetailView = class("BloodCardDetailView", ReduxView)

function BloodCardDetailView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardCardDetailUI"
end

function BloodCardDetailView:UIParent()
	return manager.ui.uiPop.transform
end

function BloodCardDetailView:Init()
	self:InitUI()
	self:AddUIListener()

	self.cardInfoView_ = BloodCardInGameCardInfoView.New(self.cardInfoGo_)
	self.cardItem_ = BloodCardVisualCardView.New(self.cardItemGo_)
end

function BloodCardDetailView:InitUI()
	self:BindCfgUI()
end

function BloodCardDetailView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function BloodCardDetailView:OnEnter()
	self.cardID_ = self.params_.cardID
	self.isEnemy_ = self.params_.isEnemy

	self:RefreshUI()
end

function BloodCardDetailView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function BloodCardDetailView:RefreshUI()
	self.cardItem_:SetData(1, self.cardID_, self.isEnemy_)
	self.cardInfoView_:SetData(self.cardID_)
end

function BloodCardDetailView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function BloodCardDetailView:Dispose()
	self.cardItem_:Dispose()
	self.cardInfoView_:Dispose()
	BloodCardDetailView.super.Dispose(self)
end

return BloodCardDetailView

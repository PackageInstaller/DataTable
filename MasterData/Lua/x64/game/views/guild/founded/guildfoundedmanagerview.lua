local GuildFoundedManagerView = class("GuildFoundedManagerView", ReduxView)

function GuildFoundedManagerView:UIName()
	return "UI/ClubUI/CreateClubPanelTemplate"
end

function GuildFoundedManagerView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildFoundedManagerView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.foundedViewList_ = {}
end

function GuildFoundedManagerView:OnTop()
	self:RefreshWinBar()
end

function GuildFoundedManagerView:OnEnter()
	for iter_5_0, iter_5_1 in pairs(self.foundedViewList_) do
		iter_5_1:OnEnter()
	end

	self:RefreshToggle()
end

function GuildFoundedManagerView:RefreshWinBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function GuildFoundedManagerView:OnExit()
	manager.windowBar:HideBar()

	for iter_8_0, iter_8_1 in pairs(self.foundedViewList_) do
		iter_8_1:OnExit()
	end
end

function GuildFoundedManagerView:OnUpdate()
	self:RefreshToggle()
end

function GuildFoundedManagerView:Dispose()
	GuildFoundedManagerView.super.Dispose(self)

	for iter_10_0, iter_10_1 in pairs(self.toggleList_) do
		iter_10_1:Dispose()
	end

	self.toggleList_ = nil
	self.goButtonList_ = nil

	for iter_10_2, iter_10_3 in pairs(self.foundedViewList_) do
		iter_10_3:Dispose()
	end

	self.foundedViewList_ = nil
end

function GuildFoundedManagerView:AddListeners()
	return
end

function GuildFoundedManagerView:RefreshToggle()
	for iter_12_0, iter_12_1 in pairs(self.toggleList_) do
		iter_12_1:RefreshSelectType(self.selectType_)
	end

	self.foundedViewList_[self.selectType_] = self.foundedViewList_[self.selectType_] or self.selectType_ == GuildConst.FOUNDED_TYPE.RECOMMEND and GuildRecommendView.New(self.goRecommendPanel_) or GuildFoundedView.New(self.goFoundedPanel_)

	for iter_12_2, iter_12_3 in pairs(self.foundedViewList_) do
		iter_12_3:Show(iter_12_2 == self.selectType_)
	end
end

return GuildFoundedManagerView

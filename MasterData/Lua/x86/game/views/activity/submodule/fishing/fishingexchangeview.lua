local FishingExchangeView = class("FishingExchangeView", ReduxView)

function FishingExchangeView:UIName()
	return "UI/Fishing/FishingExchangeUI"
end

function FishingExchangeView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingExchangeView:OnCtor()
	return
end

function FishingExchangeView:Init()
	self.PrefabList_ = {
		"UI/Fishing/Pages/FishingGivePageUI",
		"UI/Fishing/Pages/FishingReceivePageUI",
		"UI/Fishing/Pages/FishingRequirePageUI"
	}
	self.Classes_ = {
		FishingGivePageView,
		FishingReceivePageView,
		FishingRequirePageView
	}
	self.pages_ = {}

	self:InitUI()
	self:AddUIListener()
end

function FishingExchangeView:InitUI()
	self:BindCfgUI()

	self.toggles_ = {
		self.toggle1_,
		self.toggle2_,
		self.toggle3_
	}
end

function FishingExchangeView:AddUIListener()
	for iter_6_0, iter_6_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_6_1, function(arg_7_0)
			if arg_7_0 then
				self:SwitchToPage(iter_6_0)
			end
		end)
	end

	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function FishingExchangeView:SwitchToPage(arg_10_1)
	if arg_10_1 == self.curPageIndex_ then
		return
	end

	if self.pages_[self.curPageIndex_] then
		SetActive(self.pages_[self.curPageIndex_].gameObject_, false)
	end

	self.curPageIndex_ = arg_10_1

	if not self.pages_[arg_10_1] then
		self.pages_[arg_10_1] = self.Classes_[arg_10_1].New((Object.Instantiate(Asset.Load(self.PrefabList_[arg_10_1]), self.container_)))

		self:CheckPageEnter(arg_10_1)
	else
		SetActive(self.pages_[arg_10_1].gameObject_, true)
	end

	self.toggles_[arg_10_1].isOn = true
end

function FishingExchangeView:AddEventListeners()
	return
end

function FishingExchangeView:OnTop()
	self:UpdateBar()
end

function FishingExchangeView:UpdateBar()
	return
end

function FishingExchangeView:OnEnter()
	self.enteredPage_ = {}

	FriendsAction:TryToRefreshFriendsView(1, function()
		self:AddEventListeners()

		for iter_15_0, iter_15_1 in pairs(self.pages_) do
			self:CheckPageEnter(iter_15_0)
		end

		self:SwitchToPage(self.params_.page or 1)
	end)
	manager.redPoint:bindUIandKey(self.redPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD, {
		x = 0,
		y = 0
	})
end

function FishingExchangeView:CheckPageEnter(arg_16_1)
	if not self.enteredPage_[arg_16_1] then
		self.pages_[arg_16_1]:OnEnter()

		self.enteredPage_[arg_16_1] = true
	end
end

function FishingExchangeView:OnExit()
	manager.redPoint:unbindUIandKey(self.redPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD)
	self:RemoveAllEventListener()

	for iter_17_0, iter_17_1 in pairs(self.pages_) do
		iter_17_1:OnExit()
	end
end

function FishingExchangeView:OnMainHomeViewTop()
	return
end

function FishingExchangeView:Dispose()
	if self.pages_ then
		for iter_19_0, iter_19_1 in pairs(self.pages_) do
			iter_19_1:Dispose()
		end

		self.pages_ = nil
	end

	FishingExchangeView.super.Dispose(self)
end

return FishingExchangeView

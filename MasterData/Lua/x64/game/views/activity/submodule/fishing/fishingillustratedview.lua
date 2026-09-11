local FishingIllustratedView = class("FishingIllustratedView", ReduxView)

function FishingIllustratedView:UIName()
	return "UI/Fishing/FishingIllustratedUI"
end

function FishingIllustratedView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingIllustratedView:OnCtor()
	return
end

function FishingIllustratedView:Init()
	self.PrefabList_ = {
		"UI/Fishing/Pages/FishingIllustratedPageUI",
		"UI/Fishing/Pages/FishingGroupPageUI"
	}
	self.Classes_ = {
		FishingIllustratedPageView,
		FishingGroupPageView
	}
	self.pages_ = {}

	self:InitUI()
	self:AddUIListener()
end

function FishingIllustratedView:InitUI()
	self:BindCfgUI()

	self.toggles_ = {
		self.toggle1_,
		self.toggle2_
	}
end

function FishingIllustratedView:AddUIListener()
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

function FishingIllustratedView:AddEventListeners()
	return
end

function FishingIllustratedView:OnTop()
	self:UpdateBar()
end

function FishingIllustratedView:UpdateBar()
	return
end

function FishingIllustratedView:OnEnter()
	self.enteredPage_ = {}

	self:AddEventListeners()

	for iter_13_0, iter_13_1 in pairs(self.pages_) do
		self:CheckPageEnter(iter_13_0)
	end

	self:SwitchToPage(self.params_.page or 1)
	manager.redPoint:bindUIandKey(self.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD, {
		x = 0,
		y = 0
	})
end

function FishingIllustratedView:CheckPageEnter(arg_14_1)
	if not self.enteredPage_[arg_14_1] then
		self.pages_[arg_14_1]:OnEnter()

		self.enteredPage_[arg_14_1] = true
	end
end

function FishingIllustratedView:OnExit()
	manager.redPoint:unbindUIandKey(self.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD)
	self:RemoveAllEventListener()
end

function FishingIllustratedView:SwitchToPage(arg_16_1)
	if arg_16_1 == self.curPageIndex_ then
		return
	end

	if self.pages_[self.curPageIndex_] then
		SetActive(self.pages_[self.curPageIndex_].gameObject_, false)
	end

	self.curPageIndex_ = arg_16_1

	if not self.pages_[arg_16_1] then
		self.pages_[arg_16_1] = self.Classes_[arg_16_1].New((Object.Instantiate(Asset.Load(self.PrefabList_[arg_16_1]), self.container_)))

		self:CheckPageEnter(arg_16_1)
	else
		SetActive(self.pages_[arg_16_1].gameObject_, true)
	end

	self.toggles_[arg_16_1].isOn = true
end

function FishingIllustratedView:OnMainHomeViewTop()
	return
end

function FishingIllustratedView:Dispose()
	if self.pages_ then
		for iter_18_0, iter_18_1 in pairs(self.pages_) do
			iter_18_1:Dispose()
		end

		self.pages_ = nil
	end

	FishingIllustratedView.super.Dispose(self)
end

return FishingIllustratedView

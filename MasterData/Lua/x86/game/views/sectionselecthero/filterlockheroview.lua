local FilterLockHeroView = class("FilterLockHeroView", ReduxView)

function FilterLockHeroView:UIName()
	return "Widget/System/Formation/FormationEliminatePopUI"
end

function FilterLockHeroView:UIParent()
	return manager.ui.uiPop.transform
end

function FilterLockHeroView:Init()
	self:InitUI()
	self:AddListener()
end

function FilterLockHeroView:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = LuaList.New(handler(self, self.IndexItem), self.heroListGo_, FilterLockHeroItem)
	self.typeController_ = self.controllerEx_:GetController("type")
	self.skipController_ = self.controllerEx_:GetController("skip")
end

function FilterLockHeroView:AddListener()
	self:AddBtnListener(self.comfirmBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backMaskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		self.skipFlag_ = not self.skipFlag_

		if self.skipFlag_ then
			SectionSelectHeroTools.SetSkipDisplayFilterLockHeroTime(manager.time:GetServerTime())
		else
			SectionSelectHeroTools.SetSkipDisplayFilterLockHeroTime(0)
		end

		self:RefreshSkip()
	end)
end

function FilterLockHeroView:OnEnter()
	self.skipFlag_ = false

	self:RefreshType()
	self:RefreshSkip()
	self:RefreshHeroItem()
	self:RefreshLockTips()
end

function FilterLockHeroView:RefreshType()
	self.typeController_:SetSelectedState(self.params_.type)

	self.titleText_.text = self.params_.type == SectionSelectHeroConst.DISPLAY_FILTER_LOCK_HERO_TYPE.NORMAL and GetTips("DEFAULT_TEAM_CHARACTER_HAS_LOCKED_TITLE") or GetTips("TEAM_CHARACTER_HAS_LOCKED_TITLE")
end

function FilterLockHeroView:RefreshSkip()
	self.skipController_:SetSelectedState(tostring(self.skipFlag_))
end

function FilterLockHeroView:RefreshHeroItem()
	self.heroIDList_ = self.params_.heroIDList

	self.heroItemList_:StartScroll(#self.heroIDList_)
end

function FilterLockHeroView:RefreshLockTips()
	local var_13_0 = ""

	for iter_13_0 = 1, #self.heroIDList_ do
		var_13_0 = var_13_0 .. string.format("「%s」", HeroTools.GetHeroFullName(HeroStandardSystemCfg[self.heroIDList_[iter_13_0]] and HeroStandardSystemCfg[self.heroIDList_[iter_13_0]].hero_id or self.heroIDList_[iter_13_0]))
	end

	self.lockHeroTips_.text = string.format(GetTips("TEAM_CHARACTER_HAS_LOCKED"), var_13_0)
end

function FilterLockHeroView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.heroIDList_[arg_14_1])
end

function FilterLockHeroView:Dispose()
	self.heroItemList_:Dispose()

	self.heroItemList_ = nil

	FilterLockHeroView.super.Dispose(self)
end

return FilterLockHeroView

local HeroChipView = class("HeroChipView", ReduxView)

function HeroChipView:UIName()
	return "UI/Chip/ChipInfoUI"
end

function HeroChipView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroChipView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.curHeroId_ = self.params_.HeroId
	self.chipUIList_ = LuaList.New(handler(self, self.RefreshChipItem), self.uiList_, self:GetChipItem())
	self.chipLockView_ = ChipLockView.New(self.lockPanel_)
	self.chipTypeCntList_ = self:GetChipTypeCntList()
	self.controller_ = ControllerUtil.GetController(self.transformBtnPanel_, "conName")
end

function HeroChipView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	if self.params_.HeroId then
		self.curHeroId_ = self.params_.HeroId
	end

	self.sortChipIDList_ = self:SortChip()
	self.defaultSelectID_ = self.sortChipIDList_[1]

	self.chipUIList_:StartScroll(#self.sortChipIDList_, 1)
	self:RefreshUI()
	SetActive(self.goResetBtn_, false)
	SetActive(self.filterPanel_, false)
	SetActive(self.prohibitPanel_, false)

	self.unlockChipHandler_ = handler(self, self.OnUnlockHeroChip)

	manager.notify:RegistListener(UNLOCK_HEROCHIP, self.unlockChipHandler_)

	self.enabledChipHandler_ = handler(self, self.OnEnabledHeroChip)

	manager.notify:RegistListener(ENABLED_HEROCHIP, self.enabledChipHandler_)

	self.clickItemHandler_ = handler(self, self.OnClickHeroItem)

	manager.notify:RegistListener(ON_CLICK_HEROCHIP_ITEM, self.clickItemHandler_)
end

function HeroChipView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_HEROCHIP, self.unlockChipHandler_)
	manager.notify:RemoveListener(ENABLED_HEROCHIP, self.enabledChipHandler_)
	manager.notify:RemoveListener(ON_CLICK_HEROCHIP_ITEM, self.clickItemHandler_)

	self.unlockChipHandler_ = nil
	self.enabledChipHandler_ = nil
	self.clickItemHandler_ = nil
end

function HeroChipView:OnUpdate()
	self.defaultSelectID_ = self.params_.selectChipID or self.sortChipIDList_[1]

	self:OnEnabledHeroChip()
end

function HeroChipView:AddListeners()
	self:AddBtnListener(self.useBtn_, nil, function()
		ChipAction.EnabledHeroChip(self.curHeroId_, self.defaultSelectID_)
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		ChipAction.UnlockHeroChip(self.defaultSelectID_)
	end)
	self:AddBtnListener(self.unloadBtn_, nil, function()
		ChipAction.EnabledHeroChip(self.curHeroId_, 0)
	end)
end

function HeroChipView:OnUnlockHeroChip()
	self.sortChipIDList_ = self:SortChip()

	self:OnEnabledHeroChip()
end

function HeroChipView:OnEnabledHeroChip()
	self:RefreshUI()
	self.chipUIList_:Refresh()
end

function HeroChipView:OnClickHeroItem(arg_13_1)
	self:Go("/heroChipView", {
		chipManagerID = self.params_.chipManagerID,
		selectChipID = arg_13_1,
		selectChipIndex = self.params_.selectChipIndex
	})
end

function HeroChipView:RefreshChipItem(arg_14_1, arg_14_2)
	arg_14_2:SetChipID(self.sortChipIDList_[arg_14_1], self.curHeroId_)
	arg_14_2:RefreshUI(self.defaultSelectID_, self.curHeroId_)
end

function HeroChipView:RefreshUI()
	self:RefreshRightInfo()
	self.chipLockView_:SetChipID(self.defaultSelectID_, self.params_.chipManagerID)
end

function HeroChipView:RefreshRightInfo()
	self.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[self.defaultSelectID_].picture_id)
	self.name_.text = GetI18NText(ChipCfg[self.defaultSelectID_].suit_name)
	self.effectText_.text = GetI18NText(ChipCfg[self.defaultSelectID_].desc)
	self.typeText_.text = ChipCfg[self.defaultSelectID_].spec_char ~= 0 and GetTips("EXCLUSIVE_CHIP") or GetTips("NORMAL_CHIP")

	if table.keyof(self:GetUnlockChipIDList(), self.defaultSelectID_) then
		SetActive(self.lockPanel_, false)
	else
		SetActive(self.lockPanel_, true)
		self.controller_:SetSelectedState("unlock")
	end
end

function HeroChipView:Dispose()
	HeroChipView.super.Dispose(self)

	if self.chipUIList_ then
		self.chipUIList_:Dispose()

		self.chipUIList_ = nil
	end

	self.chipLockView_:Dispose()

	self.chipLockView_ = nil
end

function HeroChipView:GetChipItem()
	return HeroChipItem
end

function HeroChipView:GetChipTypeCntList()
	return ChipData:GetHeroChipsByHeroId(self.curHeroId_)
end

function HeroChipView:SortChip()
	return ChipTools.SortChipList(ChipData:GetCurHeroChip(self.curHeroId_), ChipData:GetHeroChipsByHeroId(self.curHeroId_), nil, true)
end

function HeroChipView:GetUnlockChipIDList()
	return ChipData:GetUnlockHeroChipIDList()
end

return HeroChipView

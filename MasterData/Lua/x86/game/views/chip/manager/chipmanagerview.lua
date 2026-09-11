local ChipManagerView = class("ChipManagerView", ReduxView)

function ChipManagerView:UIName()
	return "Widget/System/MimirChip/MimirChipUI"
end

function ChipManagerView:UIParent()
	return manager.ui.uiMain.transform
end

function ChipManagerView:Init()
	self.isBattle = false
	self.tabIndex = 1

	self:BindCfgUI()

	self.iconImg_.immediate = true

	self:AddListeners()

	self.chipManagerUIList_ = LuaList.New(handler(self, self.RefreshChipManagerItem), self.uiList_, self:GetChipManagerItem())
	self.chipManagerInfoView_ = self:GetChipManagerInfoView().New(self.panelGo_, self)

	self.chipManagerInfoView_:RegistEnableIDFunc(handler(self, self.EnableChipManagerIDFunc))
end

function ChipManagerView:SetWindowBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back(1, {
			isSorted = true
		})
	end)
end

function ChipManagerView:OnEnter()
	self:SetWindowBar()

	self.handler_ = handler(self, self.OnUnlockChipManager)

	manager.notify:RegistListener(UNLOCK_CHIP_MANAGER, self.handler_)

	self.enabledChipHandler_ = handler(self, self.OnBattleChipUse)

	manager.notify:RegistListener(ENABLED_CHIP, self.enabledChipHandler_)

	self.chipManagerDataTemplate_ = self.chipManagerDataTemplate_ or self:GetChipDataTemplate()

	self:SetViewParam()

	self.chipManagerList_ = self:GetChipManagerList()
	self.defaultSelectID_ = self.params_.chipManagerID or self.chipManagerList_[1]

	self.chipManagerUIList_:StartScroll(#self.chipManagerList_, table.keyof(self.chipManagerList_, self.defaultSelectID_))
	self:RefreshUI()
end

function ChipManagerView:OnUpdate()
	self.defaultSelectID_ = self.params_.chipManagerID or self.chipManagerList_[1]

	self:RefreshUI()
	self.chipManagerUIList_:Refresh()
end

function ChipManagerView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, self.handler_)

	self.handler_ = nil

	manager.notify:RemoveListener(ENABLED_CHIP, self.enabledChipHandler_)

	self.enabledChipHandler_ = nil
end

function ChipManagerView:AddListeners()
	self:AddBtnListener(self.schemeBtn_, nil, function()
		self:OnSchemeBtn()
	end)
end

function ChipManagerView:OnUnlockChipManager()
	self:RefreshUI()
	self.chipManagerUIList_:Refresh()
end

function ChipManagerView:RefreshUI()
	if self.chipManagerInfoView_ then
		self.chipManagerInfoView_:OnEnter()
		self.chipManagerInfoView_:SetTemplateData(self.chipManagerDataTemplate_)
		self.chipManagerInfoView_:RefreshData(self.defaultSelectID_)
	end

	self.iconImg_.spriteSync = "TextureConfig/Managecat_l/" .. ChipCfg[self.defaultSelectID_].picture_id
end

function ChipManagerView:RefreshChipManagerItem(arg_13_1, arg_13_2)
	local var_13_0 = self.chipManagerList_[arg_13_1]

	arg_13_2:SetChipManagerID(self.chipManagerList_[arg_13_1])

	if self.chipManagerDataTemplate_ and arg_13_2.SetTemplateData then
		arg_13_2:SetTemplateData(self.chipManagerDataTemplate_)
	end

	arg_13_2:RefreshUI(var_13_0 == self.defaultSelectID_)
end

function ChipManagerView:RefreshManagerInfo()
	self.chipManagerName_.text = GetI18NText(ChipCfg[self.defaultSelectID_].suit_name)
	self.skillText_.text = GetI18NText(ChipCfg[self.defaultSelectID_].desc)
	self.descText_.text = GetI18NText(ChipCfg[self.defaultSelectID_].profile)
	self.textStory_.text = GetI18NText(ChipCfg[self.defaultSelectID_].story)
end

function ChipManagerView:Dispose()
	ChipManagerView.super.Dispose(self)
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, self.handler_)

	self.handler_ = nil

	manager.notify:RemoveListener(ENABLED_CHIP, self.enabledChipHandler_)

	self.enabledChipHandler_ = nil

	if self.chipManagerInfoView_ then
		self.chipManagerInfoView_:Dispose()

		self.chipManagerInfoView_ = nil
	end

	if self.chipManagerUIList_ then
		self.chipManagerUIList_:Dispose()

		self.chipManagerUIList_ = nil
	end
end

function ChipManagerView:GetChipDataTemplate()
	return ChipManagerDataTemplate.New({
		id = self.defaultSelectID_,
		unlockChipManagerIDList_ = self:GetUnlockChipManagerList(),
		unlockChipIDList_ = self:GetUnlockChipList()
	})
end

function ChipManagerView:GetChipManagerList()
	return ChipTools.SortChipManager((ChipData:GetEnabledChipManagerID()))
end

function ChipManagerView:GetUnlockChipManagerList()
	return ChipData:GetUnlockChipManagerIDList()
end

function ChipManagerView:GetUnlockChipList()
	return ChipData:GetUnlockChipIDList()
end

function ChipManagerView:GetChipTypeCntList()
	return ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]
end

function ChipManagerView:GetManagerUnlockView()
	return MimirChipManagerInfoView
end

function ChipManagerView:GetChipManagerItem()
	return ChipManagerItem
end

function ChipManagerView:GetChipManagerInfoView()
	return BattleChipManagerInfoView
end

function ChipManagerView:OnSchemeBtn()
	return
end

function ChipManagerView:SetViewParam()
	return
end

function ChipManagerView:EnableChipManagerIDFunc(arg_26_1)
	return
end

return ChipManagerView

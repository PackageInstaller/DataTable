local ChipInfoView = class("ChipInfoView", ReduxView)

function ChipInfoView:UIName()
	return "Widget/System/MimirChip/MimirChipEditUI"
end

function ChipInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function ChipInfoView:Init()
	self:BindCfgUI()

	self.chipUIList_ = LuaList.New(handler(self, self.RefreshChipItem), self.uiList_, self:GetChipItem())
	self.chipTypeCntList_ = self:GetChipTypeCntList() or {}
	self.btnState = self.btnControllerexcollection_:GetController("btn")
	self.conditionControl = self.conditionControllerexcollection_:GetController("clear")

	self:AddListeners()
end

function ChipInfoView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.chipManagerDataTemplate_ = self.params_.chipDataTemplate
	self.chipManagerID = self.params_.chipManagerID
	self.noBattle_ = self.params_.noBattle

	local var_4_0 = ChipData:GetChipManagerList()[self.params_.chipManagerID]

	self.sortChipIDList_ = self:SortChip()
	self.defaultSelectID_ = var_4_0[self.params_.selectChipIndex] or self.sortChipIDList_[1]

	self.chipUIList_:StartScroll(#self.sortChipIDList_, 1)
	self:RefreshUI()

	self.unlockChipHandler_ = handler(self, self.OnUnlockChip)

	manager.notify:RegistListener(UNLOCK_CHIP, self.unlockChipHandler_)

	self.enabledChipHandler_ = handler(self, self.OnEnabledChip)

	manager.notify:RegistListener(ENABLED_CHIP, self.enabledChipHandler_)

	self.clickItemHandler_ = handler(self, self.OnClickItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, self.clickItemHandler_)
end

function ChipInfoView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP, self.unlockChipHandler_)
	manager.notify:RemoveListener(ENABLED_CHIP, self.enabledChipHandler_)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, self.clickItemHandler_)

	self.unlockChipHandler_ = nil
	self.enabledChipHandler_ = nil
	self.clickItemHandler_ = nil

	manager.redPoint:unbindUIandKey(self.unlockBtn_.transform)
end

function ChipInfoView:OnUpdate()
	self.defaultSelectID_ = self.params_.selectChipID or self.sortChipIDList_[1]

	self:OnEnabledChip()
end

function ChipInfoView:AddListeners()
	self:AddBtnListener(self.useBtn_, nil, function()
		self.chipManagerDataTemplate_:SetUseChipId(self.defaultSelectID_)
		manager.notify:Invoke(ENABLED_CHIP, self.defaultSelectID)
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		ChipAction.UnlockChip(self.defaultSelectID_)
	end)
	self:AddBtnListener(self.unloadBtn_, nil, function()
		self.chipManagerDataTemplate_:SetNoUseChipId(self.defaultSelectID_)
		manager.notify:CallUpdateFunc(UNUSE_BATTLECHIP, self.defaultSelectID_)
	end)
end

function ChipInfoView:OnUnlockChip()
	self.sortChipIDList_ = self:SortChip()

	self:OnEnabledChip()
end

function ChipInfoView:OnEnabledChip()
	self:RefreshUI()
	self.chipUIList_:Refresh()
end

function ChipInfoView:OnClickItem(arg_13_1)
	self:Go(self.chipManagerDataTemplate_:GetChipInfoViewPath(), {
		chipManagerID = self.params_.chipManagerID,
		selectChipID = arg_13_1,
		selectChipIndex = self.params_.selectChipIndex,
		chipDataTemplate = self.chipManagerDataTemplate_
	})
end

function ChipInfoView:GetFirstUnSelectID()
	local var_14_0 = self:GetChipData()

	for iter_14_0, iter_14_1 in ipairs(self.sortChipIDList_) do
		if not table.keyof(var_14_0, iter_14_1) then
			return iter_14_1
		end
	end

	return self.sortChipIDList_[1]
end

function ChipInfoView:RefreshChipItem(arg_15_1, arg_15_2)
	arg_15_2:SetChipID(self.sortChipIDList_[arg_15_1])
	arg_15_2:SetTemplateData(self.chipManagerDataTemplate_)
	arg_15_2:RefreshUI(self.defaultSelectID_, self.chipManagerID)
end

function ChipInfoView:RefreshUI()
	if ChipCfg[self.defaultSelectID_] then
		local var_16_0, var_16_1, var_16_2 = IsConditionAchieved(ChipCfg[self.defaultSelectID_].new_condition)

		self.conditiondescireText_.text = GetI18NText(ConditionCfg[ChipCfg[self.defaultSelectID_].new_condition].desc)
		self.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[self.defaultSelectID_].picture_id)
		self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. ChipCfg[self.chipManagerID].picture_id)
		self.name_.text = GetI18NText(ChipCfg[self.defaultSelectID_].suit_name)
		self.effectText_.text = GetI18NText(ChipCfg[self.defaultSelectID_].desc)

		local var_16_3, var_16_4, var_16_5 = IsConditionAchieved(ChipCfg[self.defaultSelectID_].new_condition)
		local var_16_6 = self.chipManagerDataTemplate_:GetIsUnlockChip(self.defaultSelectID_)

		self.isUnlock_ = var_16_3

		if var_16_6 == false then
			if self.isUnlock_ then
				self.btnState:SetSelectedState("unLock2")
				self.conditionControl:SetSelectedState("clear")
			else
				self.btnState:SetSelectedState("unLock1")
				self.conditionControl:SetSelectedState("notClear")
			end
		elseif self.noBattle_ then
			self.btnState:SetSelectedState("hasUnLock")
		elseif self.chipManagerDataTemplate_:GetIsUesChipID(self.defaultSelectID_) then
			self.btnState:SetSelectedState("unUse")
		else
			self.btnState:SetSelectedState("use")
		end

		SetActive(self.lockPanel_, not var_16_6)
	end

	manager.redPoint:bindUIandKey(self.unlockBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_CHIP, self.defaultSelectID_))
end

function ChipInfoView:Dispose()
	ChipInfoView.super.Dispose(self)

	if self.chipUIList_ then
		self.chipUIList_:Dispose()

		self.chipUIList_ = nil
	end
end

function ChipInfoView:GetChipItem()
	return ChipItem
end

function ChipInfoView:GetChipTypeCntList()
	return ChipTools.GetChipTypeCntList(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP])
end

function ChipInfoView:GetChipData()
	return (ReserveTools.GetMimirChipList(self.reserveParams_))
end

function ChipInfoView:SortChip()
	return ChipTools.SortChip((self:GetChipTypeCntList() or {})[-1], self.params_.chipManagerID)
end

function ChipInfoView:GetUnlockChipIDList()
	return ChipData:GetUnlockChipIDList()
end

return ChipInfoView

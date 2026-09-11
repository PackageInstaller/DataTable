local MimirChipInfoView = class("MimirChipInfoView", ReduxView)

function MimirChipInfoView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.pCtrl = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.btnState = self.btnControllerexcollection_:GetController("btn")
	self.conditionControl = self.conditionControllerexcollection_:GetController("clear")
end

function MimirChipInfoView:AddListeners()
	self.clickItemHandler_ = handler(self, self.OnClickItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, self.clickItemHandler_)
	self:AddBtnListener(self.btn_unlock1Btn_, nil, function()
		ShowTips("CHIP_HERO_UNLOCK_FAILED")
	end)
	self:AddBtnListener(self.btn_unlock2Btn_, nil, function()
		ChipAction.UnlockChip(self.chipID)
	end)
end

function MimirChipInfoView:OnEnter()
	return
end

function MimirChipInfoView:OnClickItem(arg_6_1)
	self:RefreshData(arg_6_1)
end

function MimirChipInfoView:RefreshData(arg_7_1)
	if not ChipCfg[arg_7_1] then
		return
	end

	self.chipID = arg_7_1
	self.iconchipImg_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[arg_7_1].picture_id)
	self.txt_dyn_nameText_.text = GetI18NText(ChipCfg[arg_7_1].suit_name)
	self.textText_.text = GetI18NText(ChipCfg[arg_7_1].desc)

	local var_7_0, var_7_1, var_7_2 = IsConditionAchieved(ChipCfg[arg_7_1].new_condition)

	self.conditiondescireText_.text = GetI18NText(ConditionCfg[ChipCfg[arg_7_1].new_condition].desc)

	local var_7_3 = self.chipManagerDataTemplate_:GetIsUnlockChip(arg_7_1)

	if var_7_3 == false then
		if var_7_0 then
			self.btnState:SetSelectedState("unLock2")
			self.conditionControl:SetSelectedState("clear")
		else
			self.btnState:SetSelectedState("unLock1")
			self.conditionControl:SetSelectedState("notClear")
		end
	else
		self.btnState:SetSelectedState("unlocked")
	end

	SetActive(self.conditionGo_, not var_7_3)
end

function MimirChipInfoView:OnExit()
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, self.clickItemHandler_)

	self.clickItemHandler_ = nil
end

function MimirChipInfoView:SetChipManagerID(arg_9_1)
	self.chipManagerID = arg_9_1
end

function MimirChipInfoView:SetTemplateData(arg_10_1)
	self.chipManagerDataTemplate_ = arg_10_1
end

function MimirChipInfoView:Dispose()
	MimirChipInfoView.super.Dispose(self)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, self.clickItemHandler_)

	self.clickItemHandler_ = nil
	self.pCtrl = nil
end

return MimirChipInfoView

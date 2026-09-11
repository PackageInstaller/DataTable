local ChipManagerUnlockView = class("ChipManagerUnlockView", ReduxView)

function ChipManagerUnlockView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.handler_ = handler(self, self.RefreshBtn)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, self.handler_)

	self.btnCon_ = self.btnControllerexcollection_:GetController("btn")
end

function ChipManagerUnlockView:AddListeners()
	for iter_2_0 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		self:AddBtnListener(self[string.format("chipBtn%s_", iter_2_0)], nil, function()
			self:OnSelectChipBtn(iter_2_0)
		end)
	end
end

function ChipManagerUnlockView:SetDataTemplate(arg_4_1)
	self.chipDatatemplate_ = arg_4_1
end

function ChipManagerUnlockView:SetChipManagerID(arg_5_1)
	self.chipManagerID_ = arg_5_1

	local var_5_1 = self:GetChipData()

	for iter_5_0 = 1, #var_5_1 do
		self[string.format("chipIcon%s_", iter_5_0)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_5_1[iter_5_0]].picture_id)

		self[string.format("use%s_", iter_5_0)]:GetController("useState"):SetSelectedState("use")
	end

	for iter_5_1 = #var_5_1 + 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		if self[string.format("use%s_", iter_5_1)] then
			self[string.format("use%s_", iter_5_1)]:GetController("useState"):SetSelectedState("nouse")
		end
	end
end

function ChipManagerUnlockView:RefreshBtn()
	self.btnCon_:SetSelectedState("unlock")
end

function ChipManagerUnlockView:Dispose()
	self:UnbindRedPoint()
	ChipManagerUnlockView.super.Dispose(self)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, self.handler_)

	self.handler_ = nil
end

function ChipManagerUnlockView:GetChipData()
	return self.chipDatatemplate_:GetEquipChipList()
end

function ChipManagerUnlockView:GetEnabledManagerID()
	return self.chipDatatemplate_.useChipmanagerId
end

function ChipManagerUnlockView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.chipBtnTransform_, RedPointConst.CHIP_CHIP)
end

function ChipManagerUnlockView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.chipBtnTransform_)
end

function ChipManagerUnlockView:OnSelectChipBtn(arg_12_1)
	self:Go(self.chipDatatemplate_:GetChipInfoViewPath() or "/chipInfo", {
		chipManagerID = self.chipManagerID_,
		selectChipIndex = arg_12_1,
		chipDataTemplate = self.chipDatatemplate_
	})
end

function ChipManagerUnlockView:SetActive(arg_13_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_13_1)
	end
end

return ChipManagerUnlockView

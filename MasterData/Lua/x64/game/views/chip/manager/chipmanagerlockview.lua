local ChipManagerLockView = class("ChipManagerLockView", ReduxView)

function ChipManagerLockView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockState = self.conditionControllerexcollection_:GetController("clear")
end

function ChipManagerLockView:SetTemplateData()
	return
end

function ChipManagerLockView:AddListeners()
	self:AddBtnListener(self.unlockBtn_, nil, function()
		if self.isUnlock_ then
			ChipAction.UnlockChipManager(self.chipMnagerID_)
		end
	end)
end

function ChipManagerLockView:SetActive(arg_5_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_5_1)
	end
end

function ChipManagerLockView:SetChipManagerID(arg_6_1)
	self.chipMnagerID_ = arg_6_1

	local var_6_0, var_6_1, var_6_2 = IsConditionAchieved(ChipCfg[arg_6_1].new_condition)

	self.requireText_.text = GetI18NText(ConditionCfg[ChipCfg[arg_6_1].new_condition].desc)

	if var_6_0 then
		self.lockState:SetSelectedState("clear")
	else
		self.lockState:SetSelectedState("notclear")
	end

	self.isUnlock_ = var_6_0
end

function ChipManagerLockView:Dispose()
	ChipManagerLockView.super.Dispose(self)
end

return ChipManagerLockView

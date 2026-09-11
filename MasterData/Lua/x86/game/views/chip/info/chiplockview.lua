local ChipLockView = class("ChipLockView", ReduxView)

function ChipLockView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function ChipLockView:SetChipID(arg_2_1, arg_2_2)
	self.chipID_ = arg_2_1

	local var_2_0, var_2_1, var_2_2 = IsConditionAchieved(ChipCfg[arg_2_1].new_condition)

	self.requireText_.text = GetI18NText(ConditionCfg[ChipCfg[arg_2_1].new_condition].desc)
	self.requireNumText_.text = GetConditionProgressText(ChipCfg[arg_2_1].new_condition, var_2_1, var_2_2)
	self.isUnlock_ = var_2_0
end

function ChipLockView:Dispose()
	ChipLockView.super.Dispose(self)
end

return ChipLockView

local WeaponOneKeyBreakView = class("WeaponOneKeyBreakView", (import("game.views.weapon.WeaponBreakView")))

function WeaponOneKeyBreakView:OnEnter()
	self:CheckBack()
	self:RefreshBreakSuccess(self.params_.heroID, self.params_.beforeBreak, self.params_.afterBreak, self.params_.afterLevel, self.params_.beforeLevel)
end

function WeaponOneKeyBreakView:RefreshBreakSuccess(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0, var_2_1 = SkillTools.GetAttr(HeroCfg[arg_2_1].weapon_break_attribute[arg_2_2 + 1])
	local var_2_2, var_2_3 = SkillTools.GetAttr(HeroCfg[arg_2_1].weapon_break_attribute[arg_2_3 + 1])

	self.crinameText_.text = var_2_2
	self.descChangeText_.text = GameSetting.weapon_exp_limit.value[arg_2_2 + 1]
	self.desctextText_.text = GameSetting.weapon_exp_limit.value[arg_2_3 + 1]
	self.atkoriText_.text = string.format("%d", WeaponTools.WeaponAtk(arg_2_5, arg_2_2))
	self.atkafterText_.text = string.format("%d", WeaponTools.WeaponAtk(arg_2_4, arg_2_3))
	self.crioriText_.text = var_2_1
	self.criafterText_.text = var_2_3
end

function WeaponOneKeyBreakView:Dispose()
	self:RemoveAllListeners()
	WeaponOneKeyBreakView.super.Dispose(self)
end

function WeaponOneKeyBreakView:Cacheable()
	return false
end

return WeaponOneKeyBreakView

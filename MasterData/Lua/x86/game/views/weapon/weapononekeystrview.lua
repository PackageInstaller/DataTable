local WeaponOneKeyStrView = class("WeaponOneKeyStrView", (import("game.views.weapon.WeaponStrView")))

function WeaponOneKeyStrView:OnEnter()
	self:CheckBack()

	if self.params_.isBreak then
		self:RefreshBreak(self.params_)
	else
		self:RefreshStrSuccess(self.params_.oriLv, self.params_.afterLv, self.params_.beforeBreak, self.params_.afterBreak)
	end
end

function WeaponOneKeyStrView:RefreshStrSuccess(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	SetActive(self.lvGo_, false)
	SetActive(self.hxGo_, false)

	self.descChangeText_.text = arg_2_1
	self.desctextText_.text = arg_2_2
	self.originText_.text = string.format("%d", (WeaponTools.WeaponAtk(arg_2_1, arg_2_3)))
	self.afterText_.text = string.format("%d", (WeaponTools.WeaponAtk(arg_2_2, arg_2_4)))
end

function WeaponOneKeyStrView:RefreshBreak(arg_3_1)
	SetActive(self.lvGo_, true)
	SetActive(self.hxGo_, true)

	self.descChangeText_.text = arg_3_1.oriLv
	self.desctextText_.text = arg_3_1.afterLv
	self.lvoriText_.text = GameSetting.weapon_exp_limit.value[arg_3_1.beforeBreak + 1]
	self.lvafterText_.text = GameSetting.weapon_exp_limit.value[arg_3_1.afterBreak + 1]
	self.originText_.text = string.format("%d", (WeaponTools.WeaponAtk(arg_3_1.oriLv, arg_3_1.beforeBreak)))
	self.afterText_.text = string.format("%d", (WeaponTools.WeaponAtk(arg_3_1.afterLv, arg_3_1.afterBreak)))

	local var_3_0, var_3_1 = SkillTools.GetAttr(HeroCfg[arg_3_1.heroID].weapon_break_attribute[arg_3_1.beforeBreak + 1])
	local var_3_2, var_3_3 = SkillTools.GetAttr(HeroCfg[arg_3_1.heroID].weapon_break_attribute[arg_3_1.afterBreak + 1])

	self.crinameText_.text = var_3_2
	self.crioriText_.text = var_3_1
	self.criafterText_.text = var_3_3
end

return WeaponOneKeyStrView

local var_0_0 = import("game.views.weapon.WeaponBreakView")
local var_0_1 = class("WeaponOneKeyBreakView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0:CheckBack()
	arg_1_0:RefreshBreakSuccess(arg_1_0.params_.heroID, arg_1_0.params_.beforeBreak, arg_1_0.params_.afterBreak, arg_1_0.params_.afterLevel, arg_1_0.params_.beforeLevel)
end

function var_0_1.RefreshBreakSuccess(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = GameSetting.weapon_exp_limit.value[arg_2_2 + 1]
	local var_2_1 = GameSetting.weapon_exp_limit.value[arg_2_3 + 1]
	local var_2_2, var_2_3 = SkillTools.GetAttr(HeroCfg[arg_2_1].weapon_break_attribute[arg_2_2 + 1])
	local var_2_4, var_2_5 = SkillTools.GetAttr(HeroCfg[arg_2_1].weapon_break_attribute[arg_2_3 + 1])
	local var_2_6 = string.format("%d", WeaponTools.WeaponAtk(arg_2_5, arg_2_2))
	local var_2_7 = string.format("%d", WeaponTools.WeaponAtk(arg_2_4, arg_2_3))

	arg_2_0.crinameText_.text = var_2_4
	arg_2_0.descChangeText_.text = var_2_0
	arg_2_0.desctextText_.text = var_2_1
	arg_2_0.atkoriText_.text = var_2_6
	arg_2_0.atkafterText_.text = var_2_7
	arg_2_0.crioriText_.text = var_2_3
	arg_2_0.criafterText_.text = var_2_5
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0:RemoveAllListeners()
	var_0_1.super.Dispose(arg_3_0)
end

function var_0_1.Cacheable(arg_4_0)
	return false
end

return var_0_1

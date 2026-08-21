local var_0_0 = import("game.views.weapon.WeaponStrView")
local var_0_1 = class("WeaponOneKeyStrView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0:CheckBack()

	local var_1_0 = arg_1_0.params_

	if var_1_0.isBreak then
		arg_1_0:RefreshBreak(var_1_0)
	else
		arg_1_0:RefreshStrSuccess(var_1_0.oriLv, var_1_0.afterLv, var_1_0.beforeBreak, var_1_0.afterBreak)
	end
end

function var_0_1.RefreshStrSuccess(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	SetActive(arg_2_0.lvGo_, false)
	SetActive(arg_2_0.hxGo_, false)

	arg_2_0.descChangeText_.text = arg_2_1
	arg_2_0.desctextText_.text = arg_2_2

	local var_2_0 = WeaponTools.WeaponAtk(arg_2_1, arg_2_3)
	local var_2_1 = WeaponTools.WeaponAtk(arg_2_2, arg_2_4)

	arg_2_0.originText_.text = string.format("%d", var_2_0)
	arg_2_0.afterText_.text = string.format("%d", var_2_1)
end

function var_0_1.RefreshBreak(arg_3_0, arg_3_1)
	SetActive(arg_3_0.lvGo_, true)
	SetActive(arg_3_0.hxGo_, true)

	arg_3_0.descChangeText_.text = arg_3_1.oriLv
	arg_3_0.desctextText_.text = arg_3_1.afterLv

	local var_3_0 = GameSetting.weapon_exp_limit.value[arg_3_1.beforeBreak + 1]
	local var_3_1 = GameSetting.weapon_exp_limit.value[arg_3_1.afterBreak + 1]

	arg_3_0.lvoriText_.text = var_3_0
	arg_3_0.lvafterText_.text = var_3_1

	local var_3_2 = WeaponTools.WeaponAtk(arg_3_1.oriLv, arg_3_1.beforeBreak)
	local var_3_3 = WeaponTools.WeaponAtk(arg_3_1.afterLv, arg_3_1.afterBreak)

	arg_3_0.originText_.text = string.format("%d", var_3_2)
	arg_3_0.afterText_.text = string.format("%d", var_3_3)

	local var_3_4, var_3_5 = SkillTools.GetAttr(HeroCfg[arg_3_1.heroID].weapon_break_attribute[arg_3_1.beforeBreak + 1])
	local var_3_6, var_3_7 = SkillTools.GetAttr(HeroCfg[arg_3_1.heroID].weapon_break_attribute[arg_3_1.afterBreak + 1])

	arg_3_0.crinameText_.text = var_3_6
	arg_3_0.crioriText_.text = var_3_5
	arg_3_0.criafterText_.text = var_3_7
end

return var_0_1

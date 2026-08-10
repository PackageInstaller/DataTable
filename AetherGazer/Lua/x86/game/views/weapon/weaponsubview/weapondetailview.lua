local var_0_0 = class("WeaponDetailView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.constVar = {
		sliderBarWidth = 387
	}
end

function var_0_0.OnEnter(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.ShowWeaponInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.weaponnameText_.text = HeroCfg[arg_5_1].weapon_name
	arg_5_0.nowlevelText_.text = arg_5_2.level
	arg_5_0.toplevelText_.text = "/" .. GameSetting.weapon_exp_limit.value[arg_5_2.breakthrough + 1] or HeroConst.WEAPON_LV_MAX
	arg_5_0.weaponstoryText_.text = HeroCfg[arg_5_1].weapon_desc

	local var_5_0 = WeaponTools.WeaponAtk(arg_5_2.level, arg_5_2.breakthrough)
	local var_5_1 = HeroCfg[arg_5_1].weapon_break_attribute[arg_5_2.breakthrough + 1]

	arg_5_0.atknumText_.text = string.format("%d", var_5_0)

	local var_5_2, var_5_3 = SkillTools.GetAttr(var_5_1)

	arg_5_0.dcrinameText_.text = var_5_2
	arg_5_0.crinumText_.text = var_5_3

	local var_5_4, var_5_5, var_5_6 = WeaponTools.AddWeaponExp(arg_5_2.exp, arg_5_2.breakthrough, 0)
	local var_5_7 = GameLevelSetting[arg_5_2.level].weapon_level_exp
	local var_5_8 = var_5_4 / var_5_7 * arg_5_0.constVar.sliderBarWidth

	if var_5_5 == HeroConst.WEAPON_LV_MAX then
		var_5_8 = arg_5_0.constVar.sliderBarWidth
	end

	arg_5_0.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_5_8)

	if arg_5_2.level >= HeroConst.WEAPON_LV_MAX then
		arg_5_0.expShowTxt_.text = "-/-"
	else
		arg_5_0.expShowTxt_.text = var_5_4 .. "/" .. var_5_7
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0

local var_0_0 = import("game.views.pop.PopLevelUpBaseView")
local var_0_1 = class("WeaponBreakView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_key/HeroKeyBreakPopUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		arg_5_0:Back()

		if arg_5_0.params_.callback then
			arg_5_0.params_.callback()
		end
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0:CheckBack()
	arg_7_0:RefreshBreakSuccess(arg_7_0.params_.heroID, arg_7_0.params_.breakthrough)
end

function var_0_1.OnExit(arg_8_0)
	return
end

function var_0_1.RefreshBreakSuccess(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = GameSetting.weapon_exp_limit.value[arg_9_2 + 1]
	local var_9_1 = GameSetting.weapon_exp_limit.value[arg_9_2 + 2]
	local var_9_2, var_9_3 = SkillTools.GetAttr(HeroCfg[arg_9_1].weapon_break_attribute[arg_9_2 + 1])
	local var_9_4, var_9_5 = SkillTools.GetAttr(HeroCfg[arg_9_1].weapon_break_attribute[arg_9_2 + 2])
	local var_9_6 = string.format("%d", WeaponTools.WeaponAtk(var_9_0, arg_9_2))
	local var_9_7 = string.format("%d", WeaponTools.WeaponAtk(var_9_0, arg_9_2 + 1))

	arg_9_0.crinameText_.text = var_9_4
	arg_9_0.descChangeText_.text = var_9_0
	arg_9_0.desctextText_.text = var_9_1
	arg_9_0.atkoriText_.text = var_9_6
	arg_9_0.atkafterText_.text = var_9_7
	arg_9_0.crioriText_.text = var_9_3
	arg_9_0.criafterText_.text = var_9_5
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_1.super.Dispose(arg_10_0)
end

function var_0_1.Cacheable(arg_11_0)
	return false
end

return var_0_1

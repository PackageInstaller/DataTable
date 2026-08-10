local var_0_0 = class("CoreVerificationChallengeSeasonTipView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_TipUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshView()
end

function var_0_0.RefreshView(arg_8_0)
	local var_8_0 = CoreVerificationChallengeTools.GetActivityId()
	local var_8_1 = ActivityCfg[var_8_0].sub_activity_list[2]
	local var_8_2 = CoreVerificationChallengeTools.GetModeCfg()
	local var_8_3 = var_8_2[var_8_2.get_id_list_by_activity_id[var_8_1][1]].stage_com_affix[1]
	local var_8_4 = ActivityAffixPoolCfg[var_8_3].affix

	arg_8_0.titleText_.text = getAffixName(var_8_4)
	arg_8_0.descText_.text = getAffixDesc(var_8_4)

	local var_8_5 = CoreVerificationChallengeTools.GetModeIndex()

	if var_8_5 == 1 then
		CoreVerificationChallengeAction.UpdateRewardRedPoints()
	elseif var_8_5 == 2 then
		CoreVerificationChallengeMode2Action.UpdateRewardRedPoints()
	elseif var_8_5 == 3 then
		CoreVerificationChallengeMode3Action.UpdateRewardRedPoints()
	end

	arg_8_0.icon_.spriteSync = string.format("TextureConfig/Core_verification_new/Logo/img_coreVerification_%02d", var_8_5)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0

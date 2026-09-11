local CoreVerificationChallengeSeasonTipView = class("CoreVerificationChallengeSeasonTipView", ReduxView)

function CoreVerificationChallengeSeasonTipView:UIName()
	return "Widget/System/Core_verification_new/Core_verification_TipUI"
end

function CoreVerificationChallengeSeasonTipView:UIParent()
	return manager.ui.uiPop.transform
end

function CoreVerificationChallengeSeasonTipView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationChallengeSeasonTipView:InitUI()
	self:BindCfgUI()
end

function CoreVerificationChallengeSeasonTipView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function CoreVerificationChallengeSeasonTipView:OnEnter()
	self:RefreshView()
end

function CoreVerificationChallengeSeasonTipView:RefreshView()
	local var_8_0 = CoreVerificationChallengeTools.GetModeCfg()

	self.titleText_.text = getAffixName(ActivityAffixPoolCfg[var_8_0[var_8_0.get_id_list_by_activity_id[ActivityCfg[CoreVerificationChallengeTools.GetActivityId()].sub_activity_list[2]][1]].stage_com_affix[1]].affix)
	self.descText_.text = getAffixDesc(ActivityAffixPoolCfg[var_8_0[var_8_0.get_id_list_by_activity_id[ActivityCfg[CoreVerificationChallengeTools.GetActivityId()].sub_activity_list[2]][1]].stage_com_affix[1]].affix)

	local var_8_1 = CoreVerificationChallengeTools.GetModeIndex()

	if var_8_1 == 1 then
		CoreVerificationChallengeAction.UpdateRewardRedPoints()
	elseif var_8_1 == 2 then
		CoreVerificationChallengeMode2Action.UpdateRewardRedPoints()
	elseif var_8_1 == 3 then
		CoreVerificationChallengeMode3Action.UpdateRewardRedPoints()
	end

	self.icon_.spriteSync = string.format("TextureConfig/Core_verification_new/Logo/img_coreVerification_%02d", var_8_1)
end

function CoreVerificationChallengeSeasonTipView:OnExit()
	return
end

function CoreVerificationChallengeSeasonTipView:Dispose()
	CoreVerificationChallengeSeasonTipView.super.Dispose(self)
end

return CoreVerificationChallengeSeasonTipView

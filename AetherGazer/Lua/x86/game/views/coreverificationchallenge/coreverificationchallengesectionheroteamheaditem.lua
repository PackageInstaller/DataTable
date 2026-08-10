local var_0_0 = import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")
local var_0_1 = class("CoreVerificationChallengeSectionHeroTeamHeadItem", var_0_0)

function var_0_1.InitController(arg_1_0)
	var_0_1.super.InitController(arg_1_0)

	arg_1_0.coreVerificationRecommonController_ = arg_1_0.sectionController_:GetController("coreVerificationRecommon")
end

function var_0_1.SetSectionHeroData(arg_2_0, arg_2_1)
	var_0_1.super.SetSectionHeroData(arg_2_0, arg_2_1)

	arg_2_0.recommonTeam_ = CoreVerificationChallengeTools.GetModeCfg()[arg_2_0.stageID_].recommend_team

	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.recommonTeam_) do
		if iter_2_1 == arg_2_1.id then
			var_2_0 = true

			break
		end
	end

	arg_2_0.coreVerificationRecommonController_:SetSelectedState(tostring(var_2_0))
end

return var_0_1

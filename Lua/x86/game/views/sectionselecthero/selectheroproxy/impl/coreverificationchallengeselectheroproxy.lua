local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("CoreVerificationChallengeSelectHeroProxy", var_0_0)

function var_0_1.GetHeroTeamInfoRoute(arg_1_0)
	return "/heroTeamInfoCoreVerificationChallenge"
end

function var_0_1.GetStageInfoClass(arg_2_0)
	return CoreVerificationChallengeSectionStageInfoView
end

return var_0_1

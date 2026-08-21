local var_0_0 = import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")
local var_0_1 = class("CoreVerificationChallengeSectionSelectHeroView", var_0_0)

function var_0_1.CheckCanStartBattle(arg_1_0)
	local var_1_0, var_1_1 = var_0_1.super.CheckCanStartBattle(arg_1_0)

	if not var_1_0 then
		return false, var_1_1
	end

	local var_1_2, var_1_3 = CoreVerificationChallengeTools.CheckCanStartBattle(arg_1_0.reserveParams_)

	if not var_1_2 then
		return false, var_1_3
	end

	return true
end

return var_0_1

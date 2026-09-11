local CoreVerificationChallengeSectionSelectHeroView = class("CoreVerificationChallengeSectionSelectHeroView", (import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")))

function CoreVerificationChallengeSectionSelectHeroView:CheckCanStartBattle()
	local var_1_0, var_1_1 = CoreVerificationChallengeSectionSelectHeroView.super.CheckCanStartBattle(self)

	if not var_1_0 then
		return false, var_1_1
	end

	local var_1_2, var_1_3 = CoreVerificationChallengeTools.CheckCanStartBattle(self.reserveParams_)

	if not var_1_2 then
		return false, var_1_3
	end

	return true
end

return CoreVerificationChallengeSectionSelectHeroView

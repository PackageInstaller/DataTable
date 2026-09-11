local CoreVerificationChallengeSectionHeroTeamHeadItem = class("CoreVerificationChallengeSectionHeroTeamHeadItem", (import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")))

function CoreVerificationChallengeSectionHeroTeamHeadItem:InitController()
	CoreVerificationChallengeSectionHeroTeamHeadItem.super.InitController(self)

	self.coreVerificationRecommonController_ = self.sectionController_:GetController("coreVerificationRecommon")
end

function CoreVerificationChallengeSectionHeroTeamHeadItem:SetSectionHeroData(arg_2_1)
	CoreVerificationChallengeSectionHeroTeamHeadItem.super.SetSectionHeroData(self, arg_2_1)

	self.recommonTeam_ = CoreVerificationChallengeTools.GetModeCfg()[self.stageID_].recommend_team

	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(self.recommonTeam_) do
		if iter_2_1 == arg_2_1.id then
			var_2_0 = true

			break
		end
	end

	self.coreVerificationRecommonController_:SetSelectedState(tostring(var_2_0))
end

return CoreVerificationChallengeSectionHeroTeamHeadItem

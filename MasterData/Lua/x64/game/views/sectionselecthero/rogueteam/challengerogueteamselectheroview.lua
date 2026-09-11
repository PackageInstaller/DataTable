local ChallengeRogueTeamSelectHeroView = class("ChallengeRogueTeamSelectHeroView", (import("game.views.sectionSelectHero.SelectHeroBaseView")))

function ChallengeRogueTeamSelectHeroView:Init()
	ChallengeRogueTeamSelectHeroView.super.Init(self)

	self.teamBuffController_ = self.controllerExCollection_:GetController("atriEffect")
end

function ChallengeRogueTeamSelectHeroView:Refresh()
	ChallengeRogueTeamSelectHeroView.super.Refresh(self)
	self:RefreshTeamBuff()
end

function ChallengeRogueTeamSelectHeroView:RefreshTeamBuff()
	self.attriList_ = {}

	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(self.cacheHeroTeam_) do
		if iter_3_1 ~= 0 then
			var_3_0 = var_3_0 + 1
		end
	end

	if var_3_0 == 0 then
		self.teamBuffController_:SetSelectedState("off")
	else
		self.teamBuffController_:SetSelectedState(var_3_0)
	end

	for iter_3_2, iter_3_3 in ipairs(self.cacheHeroTeam_) do
		if HeroCfg[iter_3_3] then
			table.insert(self.attriList_, HeroCfg[iter_3_3].ATK_attribute[1])
		end
	end

	table.sort(self.attriList_, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	for iter_3_4, iter_3_5 in ipairs(self.attriList_) do
		self["attributeIcon" .. iter_3_4 .. "_"].sprite = HeroTools.GetSkillAttributeIcon(iter_3_5)
	end
end

function ChallengeRogueTeamSelectHeroView:AddListener()
	ChallengeRogueTeamSelectHeroView.super.AddListener(self)
	self:AddBtnListener(self.attriBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamSectionSelectAttriDescription", {
			heroList = self.cacheHeroTeam_
		})
	end)
end

return ChallengeRogueTeamSelectHeroView

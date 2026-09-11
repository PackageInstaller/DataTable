local ChallengeRogueTeamPropertyPage = class("ChallengeRogueTeamPropertyPage", HeroPropertyPage)

function ChallengeRogueTeamPropertyPage:AddUIListener()
	ChallengeRogueTeamPropertyPage.AddUIListener(self)
	self:AddBtnListener(self.rougeBuffBtn, nil, function()
		JumpTools:OpenPageByJump("challengeRougeTeamBuffPopView")
	end)
end

function ChallengeRogueTeamPropertyPage:CheckLocked()
	self.lockController_:SetSelectedState("true")
end

return ChallengeRogueTeamPropertyPage

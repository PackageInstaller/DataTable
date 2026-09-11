local ChallengRogueTeamAdditionalView = class("ChallengRogueTeamAdditionalView", (import("game.views.sectionSelectHero.SectionAdditionalView")))

function ChallengRogueTeamAdditionalView:AddListener()
	self:AddBtnListener(self.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = self.maxRaceID_,
			sameCamp = self.sameCamp_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if self.sectionProxy_:GetHeroIDList()[1] == 0 then
			ShowTips("TEAM_ERROR_LEADER")

			return
		end

		manager.notify:Invoke(SECTION_CLICK_START_BATTLE)
	end)
	self:AddBtnListener(self.reservesBtn_, nil, function()
		if not self.sectionProxy_.canChangeReserveProposal then
			return
		end

		self:GotoReservesProposalUI()
	end)
end

function ChallengRogueTeamAdditionalView:RefresgStageInfoActive()
	self.stageInfoActiveController_:SetSelectedState("false")
end

return ChallengRogueTeamAdditionalView

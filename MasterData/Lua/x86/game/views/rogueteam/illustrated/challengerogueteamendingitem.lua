local ChallengeRogueTeamEndingItem = class("ChallengeRogueTeamEndingItem", ReduxView)

function ChallengeRogueTeamEndingItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = self.controller_:GetController("lock")
end

function ChallengeRogueTeamEndingItem:Dispose()
	ChallengeRogueTeamEndingItem.super.Dispose(self)
end

function ChallengeRogueTeamEndingItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.passCount == 0 then
			ShowTips("CHALLENGE_ROGUE_TEAM_ENDING_LOCK")
		else
			JumpTools.OpenPageByJump("challengeRogueTeamIllustratedEndingPop", {
				id = self.id_,
				index = self.index_
			})
		end
	end)
end

function ChallengeRogueTeamEndingItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2
	self.cfg_ = RogueTeamEndingCfg[self.id_]
	self.titleText_.text = self.cfg_.story_name

	if self.index_ >= 10 then
		self.numText_.text = self.index_ or "0" .. self.index_
	end

	self.image_.sprite = pureGetSpriteWithoutAtlas(self.cfg_.image)
	self.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	self.passCount = ChallengeRogueTeamData:GetHistoryEndingPassCnt(self.templateID_, self.id_)

	self.lockController_:SetSelectedState(tostring(self.passCount == 0))
end

return ChallengeRogueTeamEndingItem

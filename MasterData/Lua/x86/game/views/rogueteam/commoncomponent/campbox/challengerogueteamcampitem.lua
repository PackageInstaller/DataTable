local ChallengeRogueTeamCampItem = class("ChallengeRogueTeamCampItem", ReduxView)

function ChallengeRogueTeamCampItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.activeController_ = self.controllerEx_:GetController("active")
end

function ChallengeRogueTeamCampItem:Dispose()
	ChallengeRogueTeamCampItem.super.Dispose(self)
end

function ChallengeRogueTeamCampItem:AddListeners()
	return
end

function ChallengeRogueTeamCampItem:RefreshState(arg_4_1)
	self.activeController_:SetSelectedState(tostring(arg_4_1))
end

function ChallengeRogueTeamCampItem:StopPlayAnimator()
	self.animator_.enabled = false

	SetActive(self.effectGo_, false)
end

function ChallengeRogueTeamCampItem:StartPalyAnimator()
	self.animator_.enabled = true

	SetActive(self.effectGo_, true)
end

return ChallengeRogueTeamCampItem

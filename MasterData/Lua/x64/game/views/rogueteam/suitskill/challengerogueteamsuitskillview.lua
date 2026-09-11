local ChallengeRogueTeamSuitSkillView = class("ChallengeRogueTeamSuitSkillView", ReduxView)

function ChallengeRogueTeamSuitSkillView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeGenremovesPopUI"
end

function ChallengeRogueTeamSuitSkillView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamSuitSkillView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamSuitSkillView:OnEnter()
	self.nameText_.text = RogueTeamItemCfg[self.params_.triggerValue.itemList[1].id].name
	self.descText_.text = ChallengeRogueTeamTools.GetItemDesc(self.params_.triggerValue.itemList[1].id, nil, self.descText_.color)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(self.params_.triggerValue.itemList[1].id))
end

function ChallengeRogueTeamSuitSkillView:OnExit()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
end

function ChallengeRogueTeamSuitSkillView:Dispose()
	ChallengeRogueTeamSuitSkillView.super.Dispose(self)
end

function ChallengeRogueTeamSuitSkillView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		ChallengeRogueTeamData:ClearObtainData()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		self:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end)
end

function ChallengeRogueTeamSuitSkillView:Cacheable()
	return false
end

return ChallengeRogueTeamSuitSkillView

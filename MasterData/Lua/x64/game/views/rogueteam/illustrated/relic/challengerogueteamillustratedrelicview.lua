local ChallengeRogueTeamIllustratedRelicView = class("ChallengeRogueTeamIllustratedRelicView", ReduxView)

function ChallengeRogueTeamIllustratedRelicView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedRemainsUI"
end

function ChallengeRogueTeamIllustratedRelicView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedRelicView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.relicPanelView_ = ChallengeRogueTeamIllustratedRelicPanel.New(self.gameObject_)
end

function ChallengeRogueTeamIllustratedRelicView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self.relicPanelView_:OnEnter(self.params_.templateID)
end

function ChallengeRogueTeamIllustratedRelicView:OnExit()
	self.relicPanelView_:OnExit()
end

function ChallengeRogueTeamIllustratedRelicView:Dispose()
	self.relicPanelView_:Dispose()

	self.relicPanelView_ = nil

	ChallengeRogueTeamIllustratedRelicView.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedRelicView:AddListeners()
	return
end

function ChallengeRogueTeamIllustratedRelicView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self.relicPanelView_:RefreshUI()
end

return ChallengeRogueTeamIllustratedRelicView

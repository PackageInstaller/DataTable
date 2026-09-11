local ChallengeRogueTeamReplaceNodeView = class("ChallengeRogueTeamReplaceNodeView", ReduxView)

function ChallengeRogueTeamReplaceNodeView:UIName()
	return "Widget/System/RogueTeam/RogueTeamReplaceNodeUI"
end

function ChallengeRogueTeamReplaceNodeView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamReplaceNodeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.mapView_ = ChallengeRogueTeamMapReplaceNode.New(self.scrollViewGo_)
end

function ChallengeRogueTeamReplaceNodeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	self.mapView_:OnEnter()
	self.mapView_:RefreshUI()
end

function ChallengeRogueTeamReplaceNodeView:OnEnterOver()
	self.mapView_:OnEnterOver()
end

function ChallengeRogueTeamReplaceNodeView:OnTop()
	self.mapView_:OnTop()
end

function ChallengeRogueTeamReplaceNodeView:OnExit()
	manager.windowBar:HideBar()
	self.mapView_:OnExit()
end

function ChallengeRogueTeamReplaceNodeView:Dispose()
	self.mapView_:Dispose()

	self.mapView_ = nil

	ChallengeRogueTeamReplaceNodeView.super.Dispose(self)
end

function ChallengeRogueTeamReplaceNodeView:AddListeners()
	return
end

return ChallengeRogueTeamReplaceNodeView

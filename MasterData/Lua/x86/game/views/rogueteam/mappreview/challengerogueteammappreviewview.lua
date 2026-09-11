local ChallengeRogueTeamMapPreviewView = class("ChallengeRogueTeamMapPreviewView", ReduxView)

function ChallengeRogueTeamMapPreviewView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeMapPopUI"
end

function ChallengeRogueTeamMapPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamMapPreviewView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.mapView_ = ChallengeRogueTeamMapPreviewNode.New(self.scrollViewGo_)
end

function ChallengeRogueTeamMapPreviewView:OnEnter()
	self.mapView_:OnEnter()
	self.mapView_:RefreshUI()
	manager.rogueTeamMapPreviewBtnBar:ShowBar()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.PREVIEW)
end

function ChallengeRogueTeamMapPreviewView:OnEnterOver()
	self.mapView_:SetOpenSectionInfoFlag(false)
	self.mapView_:OnEnterOver()
	self.mapView_:SetOpenSectionInfoFlag(true)
end

function ChallengeRogueTeamMapPreviewView:OnTop()
	self.mapView_:OnTop()
end

function ChallengeRogueTeamMapPreviewView:OnExit()
	self.mapView_:OnExit()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
end

function ChallengeRogueTeamMapPreviewView:Dispose()
	self.mapView_:Dispose()

	self.mapView_ = nil

	ChallengeRogueTeamMapPreviewView.super.Dispose(self)
end

function ChallengeRogueTeamMapPreviewView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

return ChallengeRogueTeamMapPreviewView

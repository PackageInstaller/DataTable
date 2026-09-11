local ChallengeRogueTeamPortraitFullView = class("ChallengeRogueTeamPortraitFullView", ReduxView)

function ChallengeRogueTeamPortraitFullView:UIName()
	return "Widget/System/ObtainUI/HeroMovie/PortraitFullUI"
end

function ChallengeRogueTeamPortraitFullView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamPortraitFullView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChallengeRogueTeamPortraitFullView:InitUI()
	self:BindCfgUI()
end

function ChallengeRogueTeamPortraitFullView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function ChallengeRogueTeamPortraitFullView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ChallengeRogueTeamPortraitFullView:OnExit()
	manager.windowBar:HideBar()
end

function ChallengeRogueTeamPortraitFullView:OnEnter()
	self.image_ = self.params_.image
	self.portriatImg_.sprite = pureGetSpriteWithoutAtlas(self.image_)

	self.portriatImg_:SetNativeSize()
end

return ChallengeRogueTeamPortraitFullView

local VolumeHeroRaceTrialDetailsView = class("VolumeHeroRaceTrialDetailsView", ReduxView)

function VolumeHeroRaceTrialDetailsView:UIName()
	return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIDownRaceDetailsUI"
end

function VolumeHeroRaceTrialDetailsView:UIParent()
	return manager.ui.uiPop.transform
end

function VolumeHeroRaceTrialDetailsView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function VolumeHeroRaceTrialDetailsView:InitUI()
	self:BindCfgUI()
end

function VolumeHeroRaceTrialDetailsView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function VolumeHeroRaceTrialDetailsView:OnExit()
	return
end

function VolumeHeroRaceTrialDetailsView:Dispose()
	self:RemoveAllListeners()
	VolumeHeroRaceTrialDetailsView.super.Dispose(self)
end

return VolumeHeroRaceTrialDetailsView

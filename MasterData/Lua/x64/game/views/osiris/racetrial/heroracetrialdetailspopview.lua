local HeroRaceTrialDetailsPopView = class("HeroRaceTrialDetailsPopView", ReduxView)

function HeroRaceTrialDetailsPopView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisRaceDetailsUI"
end

function HeroRaceTrialDetailsPopView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroRaceTrialDetailsPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HeroRaceTrialDetailsPopView:InitUI()
	self:BindCfgUI()
end

function HeroRaceTrialDetailsPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function HeroRaceTrialDetailsPopView:OnExit()
	return
end

function HeroRaceTrialDetailsPopView:Dispose()
	self:RemoveAllListeners()
	HeroRaceTrialDetailsPopView.super.Dispose(self)
end

return HeroRaceTrialDetailsPopView

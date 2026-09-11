local GuildActivitySPRateUpgradView = class("GuildActivitySPRateUpgradView", ReduxView)

function GuildActivitySPRateUpgradView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPUpgradeSuccessUI"
end

function GuildActivitySPRateUpgradView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPRateUpgradView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPRateUpgradView:InitUI()
	self:BindCfgUI()
end

function GuildActivitySPRateUpgradView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back()
	end)
end

function GuildActivitySPRateUpgradView:OnEnter()
	self.rateID_ = self.params_.rateID
	self.rateText_.text = ActivityClubSPLevelSettingCfg[self.rateID_].user_level
	self.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_CAT"), #ActivityClubSPLevelSettingCfg[self.rateID_].dispatch or 0)
	self.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), ActivityClubSPLevelSettingCfg[self.rateID_].max_hero)
end

return GuildActivitySPRateUpgradView

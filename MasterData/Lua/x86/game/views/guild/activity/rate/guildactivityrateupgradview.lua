local GuildActivityRateUpgradView = class("GuildActivityRateUpgradView", ReduxView)

function GuildActivityRateUpgradView:UIName()
	return "UI/GuildActivityUI/GuildActivityUpgradeSuccessUI"
end

function GuildActivityRateUpgradView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityRateUpgradView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityRateUpgradView:InitUI()
	self:BindCfgUI()
end

function GuildActivityRateUpgradView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back()
	end)
end

function GuildActivityRateUpgradView:OnEnter()
	self.rateID_ = self.params_.rateID
	self.rateText_.text = ActivityClubLevelSettingCfg[self.rateID_].user_level
	self.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_DOMAIN"), ActivityClubLevelSettingCfg[self.rateID_].max_domain)
	self.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), ActivityClubLevelSettingCfg[self.rateID_].max_hero)
end

return GuildActivityRateUpgradView

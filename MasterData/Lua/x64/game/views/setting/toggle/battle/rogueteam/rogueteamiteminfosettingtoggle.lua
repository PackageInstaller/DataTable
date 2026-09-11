local RogueTeamItemInfoSettingTogglee = class("RogueTeamItemInfoSettingTogglee", BaseSettingToggle)

function RogueTeamItemInfoSettingTogglee:GetName()
	return "RogueTaemItemInfo"
end

function RogueTeamItemInfoSettingTogglee:UIClass()
	return RogueTeamItemInfoSettingView
end

function RogueTeamItemInfoSettingTogglee:GetPath()
	return "Widget/System/Activity_Roulike/RoguePauseUI"
end

function RogueTeamItemInfoSettingTogglee:Order()
	return 10
end

function RogueTeamItemInfoSettingTogglee:RedPointKey()
	return nil
end

function RogueTeamItemInfoSettingTogglee:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting18")
end

function RogueTeamItemInfoSettingTogglee:GetParams()
	return nil
end

function RogueTeamItemInfoSettingTogglee:IsSetting()
	return false
end

return RogueTeamItemInfoSettingTogglee

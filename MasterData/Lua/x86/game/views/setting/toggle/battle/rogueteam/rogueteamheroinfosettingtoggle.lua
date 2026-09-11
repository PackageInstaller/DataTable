local RogueTeamHeroInfoSettingToggle = class("RogueTeamHeroInfoSettingToggle", BaseSettingToggle)

function RogueTeamHeroInfoSettingToggle:GetName()
	return "RogueTaemHeroInfo"
end

function RogueTeamHeroInfoSettingToggle:UIClass()
	return RogueTeamHeroInfoSettingView
end

function RogueTeamHeroInfoSettingToggle:GetPath()
	return "Widget/System/PolyhedronBattle/PolyhedronContingentUI"
end

function RogueTeamHeroInfoSettingToggle:Order()
	return 10
end

function RogueTeamHeroInfoSettingToggle:RedPointKey()
	return nil
end

function RogueTeamHeroInfoSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting10")
end

function RogueTeamHeroInfoSettingToggle:GetParams()
	return nil
end

function RogueTeamHeroInfoSettingToggle:IsSetting()
	return false
end

return RogueTeamHeroInfoSettingToggle

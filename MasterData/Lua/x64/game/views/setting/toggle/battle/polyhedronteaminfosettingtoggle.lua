local PolyhedronTeamInfoSettingToggle = class("PolyhedronTeamInfoSettingToggle", BaseSettingToggle)

function PolyhedronTeamInfoSettingToggle:GetName()
	return "PolyhedronTeamInfo"
end

function PolyhedronTeamInfoSettingToggle:UIClass()
	return PolyhedronTeamInfoSettingView
end

function PolyhedronTeamInfoSettingToggle:GetPath()
	return "Widget/System/PolyhedronBattle/PolyhedronRanksUI"
end

function PolyhedronTeamInfoSettingToggle:Order()
	return 9
end

function PolyhedronTeamInfoSettingToggle:RedPointKey()
	return nil
end

function PolyhedronTeamInfoSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting13")
end

function PolyhedronTeamInfoSettingToggle:GetParams()
	return nil
end

function PolyhedronTeamInfoSettingToggle:IsSetting()
	return false
end

return PolyhedronTeamInfoSettingToggle

local PolyhedronAdditionSettingToggle = class("PolyhedronAdditionSettingToggle", BaseSettingToggle)

function PolyhedronAdditionSettingToggle:GetName()
	return "PolyhedronAddition"
end

function PolyhedronAdditionSettingToggle:UIClass()
	return PolyhedronAdditionSettingView
end

function PolyhedronAdditionSettingToggle:GetPath()
	return "Widget/System/PolyhedronBattle/PolyhedronSettingUI"
end

function PolyhedronAdditionSettingToggle:Order()
	return 8
end

function PolyhedronAdditionSettingToggle:RedPointKey()
	return nil
end

function PolyhedronAdditionSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting12")
end

function PolyhedronAdditionSettingToggle:GetParams()
	return nil
end

function PolyhedronAdditionSettingToggle:IsSetting()
	return false
end

return PolyhedronAdditionSettingToggle

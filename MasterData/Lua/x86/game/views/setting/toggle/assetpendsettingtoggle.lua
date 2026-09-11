local SkillSettingToggle = class("SkillSettingToggle", BaseSettingToggle)

function SkillSettingToggle:Ctor(arg_1_1)
	return
end

function SkillSettingToggle:GetName()
	return "AssetPend"
end

function SkillSettingToggle:UIClass()
	return AssetPendSettingView
end

function SkillSettingToggle:GetPath()
	return "Widget/System/Setting/AssetPend/AssetPendSettingUI"
end

function SkillSettingToggle:Order()
	return 20
end

function SkillSettingToggle:RedPointKey()
	return nil
end

function SkillSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting15")
end

function SkillSettingToggle:GetParams()
	return
end

function SkillSettingToggle:IsSetting()
	return false
end

return SkillSettingToggle

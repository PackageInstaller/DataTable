local SoundSettingToggle = class("SoundSettingToggle", BaseSettingToggle)

function SoundSettingToggle:GetName()
	return "Sound"
end

function SoundSettingToggle:UIClass()
	return SoundSettingView
end

function SoundSettingToggle:GetPath()
	return "Widget/System/Setting/SoundSettingUI"
end

function SoundSettingToggle:Order()
	return 12
end

function SoundSettingToggle:RedPointKey()
	return nil
end

function SoundSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting07")
end

function SoundSettingToggle:GetParams()
	return nil
end

function SoundSettingToggle:IsSetting()
	return true
end

return SoundSettingToggle

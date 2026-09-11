local RemindSettingToggle = class("RemindSettingToggle", BaseSettingToggle)

function RemindSettingToggle:GetName()
	return "Remind"
end

function RemindSettingToggle:UIClass()
	return RemindSettingView
end

function RemindSettingToggle:GetPath()
	return "Widget/System/Setting/RemindSettingUI"
end

function RemindSettingToggle:Order()
	return 15
end

function RemindSettingToggle:RedPointKey()
	return nil
end

function RemindSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting05")
end

function RemindSettingToggle:GetParams()
	return nil
end

function RemindSettingToggle:IsSetting()
	return true
end

return RemindSettingToggle

local OperationSettingToggle = class("OperationSettingToggle", BaseSettingToggle)

function OperationSettingToggle:GetName()
	return "Operation"
end

function OperationSettingToggle:UIClass()
	return GameKeyOperationView
end

function OperationSettingToggle:GetPath()
	return "Widget/System/Setting/KeySettingUI"
end

function OperationSettingToggle:Order()
	return 14
end

function OperationSettingToggle:RedPointKey()
	return nil
end

function OperationSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting04")
end

function OperationSettingToggle:GetParams()
	return nil
end

function OperationSettingToggle:IsSetting()
	return true
end

return OperationSettingToggle

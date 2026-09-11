local BaseSettingToggle = class("BaseSettingToggle")

function BaseSettingToggle:GetName()
	return "BaseSettingToggle"
end

function BaseSettingToggle:UIClass()
	return nil
end

function BaseSettingToggle:GetPath()
	return nil
end

function BaseSettingToggle:Order()
	return 0
end

function BaseSettingToggle:RedPointKey()
	return nil
end

function BaseSettingToggle:Image()
	return nil, nil
end

function BaseSettingToggle:GetParams()
	return nil
end

function BaseSettingToggle:IsSetting()
	return false
end

return BaseSettingToggle

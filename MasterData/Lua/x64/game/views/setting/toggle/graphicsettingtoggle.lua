local GraphicSettingToggle = class("GraphicSettingToggle", BaseSettingToggle)

function GraphicSettingToggle:GetName()
	return "Graphic"
end

function GraphicSettingToggle:UIClass()
	if GameToSDK.IsPCPlatform() then
		return GraphicSettingPCView
	else
		return GraphicSettingView
	end
end

function GraphicSettingToggle:GetPath()
	if GameToSDK.IsPCPlatform() then
		return "Widget/System/Setting/FrameSetting_pcUI"
	else
		return "Widget/System/Setting/FrameSettingUI"
	end
end

function GraphicSettingToggle:Order()
	return 11
end

function GraphicSettingToggle:RedPointKey()
	return nil
end

function GraphicSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting06")
end

function GraphicSettingToggle:GetParams()
	return nil
end

function GraphicSettingToggle:IsSetting()
	return true
end

return GraphicSettingToggle

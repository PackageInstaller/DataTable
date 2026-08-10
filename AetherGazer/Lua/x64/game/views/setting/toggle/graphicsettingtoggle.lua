local var_0_0 = class("GraphicSettingToggle", BaseSettingToggle)

function var_0_0.GetName(arg_1_0)
	return "Graphic"
end

function var_0_0.UIClass(arg_2_0)
	if GameToSDK.IsPCPlatform() then
		return GraphicSettingPCView
	else
		return GraphicSettingView
	end
end

function var_0_0.GetPath(arg_3_0)
	if GameToSDK.IsPCPlatform() then
		return "Widget/System/Setting/FrameSetting_pcUI"
	else
		return "Widget/System/Setting/FrameSettingUI"
	end
end

function var_0_0.Order(arg_4_0)
	return 11
end

function var_0_0.RedPointKey(arg_5_0)
	return nil
end

function var_0_0.Image(arg_6_0)
	return getSprite("Atlas/SettingAtlas", "icon_setting06")
end

function var_0_0.GetParams(arg_7_0)
	return nil
end

function var_0_0.IsSetting(arg_8_0)
	return true
end

return var_0_0

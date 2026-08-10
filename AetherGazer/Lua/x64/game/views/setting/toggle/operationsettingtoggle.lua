local var_0_0 = class("OperationSettingToggle", BaseSettingToggle)

function var_0_0.GetName(arg_1_0)
	return "Operation"
end

function var_0_0.UIClass(arg_2_0)
	return GameKeyOperationView
end

function var_0_0.GetPath(arg_3_0)
	return "Widget/System/Setting/KeySettingUI"
end

function var_0_0.Order(arg_4_0)
	return 14
end

function var_0_0.RedPointKey(arg_5_0)
	return nil
end

function var_0_0.Image(arg_6_0)
	return getSprite("Atlas/SettingAtlas", "icon_setting04")
end

function var_0_0.GetParams(arg_7_0)
	return nil
end

function var_0_0.IsSetting(arg_8_0)
	return true
end

return var_0_0

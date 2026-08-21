local var_0_0 = class("SkillSettingToggle", BaseSettingToggle)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.params_ = arg_1_1
end

function var_0_0.GetName(arg_2_0)
	return "Skill"
end

function var_0_0.UIClass(arg_3_0)
	return SkillDescriptionView
end

function var_0_0.GetPath(arg_4_0)
	return "Widget/System/Setting/SkillSettingUI"
end

function var_0_0.Order(arg_5_0)
	return 20
end

function var_0_0.RedPointKey(arg_6_0)
	return nil
end

function var_0_0.Image(arg_7_0)
	return getSprite("Atlas/SettingAtlas", "icon_setting11")
end

function var_0_0.GetParams(arg_8_0)
	return arg_8_0.params_.stageData
end

function var_0_0.IsSetting(arg_9_0)
	return false
end

return var_0_0

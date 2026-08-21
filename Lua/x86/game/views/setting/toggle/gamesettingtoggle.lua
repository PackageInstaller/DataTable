local var_0_0 = class("GameSettingToggle", BaseSettingToggle)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.info_ = arg_1_1
end

function var_0_0.GetName(arg_2_0)
	return "Game"
end

function var_0_0.UIClass(arg_3_0)
	return GameSettingView
end

function var_0_0.GetPath(arg_4_0)
	return "Widget/System/Setting/GameSettingUI"
end

function var_0_0.Order(arg_5_0)
	return 13
end

function var_0_0.RedPointKey(arg_6_0)
	return {
		RedPointConst.SETING_GAME_RED
	}
end

function var_0_0.Image(arg_7_0)
	return getSprite("Atlas/SettingAtlas", "icon_setting03")
end

function var_0_0.GetParams(arg_8_0)
	return arg_8_0.info_
end

function var_0_0.IsSetting(arg_9_0)
	return true
end

return var_0_0

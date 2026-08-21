local var_0_0 = class("CaptureSettingDataTemplate")

function var_0_0.init(arg_1_0)
	arg_1_0.setting = {
		playerName = true,
		rotateModel = false,
		playerPivot = 2,
		lens = -1,
		uid = false,
		logoPivot = 1,
		level = false
	}
end

function var_0_0.CheckCanRotateModel(arg_2_0)
	return arg_2_0.setting.rotateModel
end

function var_0_0.SetRotModelState(arg_3_0, arg_3_1)
	arg_3_0.setting.rotateModel = arg_3_1
end

function var_0_0.CheckNeedPlayerName(arg_4_0)
	return arg_4_0.setting.playerName
end

function var_0_0.SetNeedPlayerNameState(arg_5_0, arg_5_1)
	arg_5_0.setting.playerName = arg_5_1
end

function var_0_0.CheckNeedLevel(arg_6_0)
	return arg_6_0.setting.level
end

function var_0_0.SetNeedLevelState(arg_7_0, arg_7_1)
	arg_7_0.setting.level = arg_7_1
end

function var_0_0.CheckNeedUid(arg_8_0)
	return arg_8_0.setting.uid
end

function var_0_0.SetNeedUidState(arg_9_0, arg_9_1)
	arg_9_0.setting.uid = arg_9_1
end

function var_0_0.SetLens(arg_10_0, arg_10_1)
	arg_10_0.setting.lens = arg_10_1
end

function var_0_0.GetLens(arg_11_0, arg_11_1)
	return arg_11_0.setting.lens
end

function var_0_0.GetLogoPos(arg_12_0)
	return arg_12_0.setting.logoPivot
end

function var_0_0.SetLogoPos(arg_13_0, arg_13_1)
	arg_13_0.setting.logoPivot = arg_13_1
end

function var_0_0.GetCardPos(arg_14_0)
	return arg_14_0.setting.playerPivot
end

function var_0_0.SetCardPos(arg_15_0, arg_15_1)
	arg_15_0.setting.playerPivot = arg_15_1
end

return var_0_0

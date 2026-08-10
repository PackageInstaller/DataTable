local var_0_0 = import("game.data.CaptureGame.CaptureSettingDataTemplate")
local var_0_1 = singletonClass("CaptureGameSettingData")

function var_0_1.Init(arg_1_0)
	return
end

function var_0_1.GetSetting(arg_2_0)
	if arg_2_0.setting == nil then
		arg_2_0.setting = var_0_0.New()

		arg_2_0.setting:init()
	end

	return arg_2_0.setting
end

function var_0_1.InitSetting(arg_3_0)
	arg_3_0:GetSetting():SetLens(-1)
end

function var_0_1.CheckCanRotateModel(arg_4_0)
	return arg_4_0:GetSetting():CheckCanRotateModel()
end

function var_0_1.SetRotModelState(arg_5_0, arg_5_1)
	arg_5_0:GetSetting():SetRotModelState(arg_5_1)
end

function var_0_1.CheckNeedPlayerName(arg_6_0)
	return arg_6_0:GetSetting():CheckNeedPlayerName()
end

function var_0_1.SetNeedPlayerNameState(arg_7_0, arg_7_1)
	arg_7_0:GetSetting():SetNeedPlayerNameState(arg_7_1)
end

function var_0_1.CheckNeedLevel(arg_8_0)
	return arg_8_0:GetSetting():CheckNeedLevel()
end

function var_0_1.SetNeedLevelState(arg_9_0, arg_9_1)
	arg_9_0:GetSetting():SetNeedLevelState(arg_9_1)
end

function var_0_1.CheckNeedUid(arg_10_0)
	return arg_10_0:GetSetting():CheckNeedUid()
end

function var_0_1.SetNeedUidState(arg_11_0, arg_11_1)
	arg_11_0:GetSetting():SetNeedUidState(arg_11_1)
end

function var_0_1.SetLens(arg_12_0, arg_12_1)
	arg_12_0:GetSetting():SetLens(arg_12_1)
	CaptureGameMgr:GetCameraMgr():SwitchLens(arg_12_1)
	manager.notify:Invoke(CAPTURE_GAME_LENS_UPDATE)
end

function var_0_1.GetLens(arg_13_0)
	return arg_13_0:GetSetting():GetLens()
end

function var_0_1.GetLogoPos(arg_14_0)
	return arg_14_0:GetSetting():GetLogoPos()
end

function var_0_1.SetLogoPos(arg_15_0, arg_15_1)
	arg_15_0:GetSetting():SetLogoPos(arg_15_1)
end

function var_0_1.GetCardPos(arg_16_0)
	return arg_16_0:GetSetting():GetCardPos()
end

function var_0_1.SetCardPos(arg_17_0, arg_17_1)
	arg_17_0:GetSetting():SetCardPos(arg_17_1)
end

return var_0_1

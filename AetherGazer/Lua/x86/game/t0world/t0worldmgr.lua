local var_0_0 = singletonClass("T0WorldMgr")

var_0_0.SwitchTypeEnum = {
	Filter = 3,
	Face = 2,
	Action = 1
}
var_0_0.CaptureModeStateEnum = {
	filter = 2,
	mainUIHide = 4,
	photo = 0,
	empty = 1,
	normal = 3
}
var_0_0.GeneralSceneType = 0

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.GetCaptureSwitchList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(T0WorldCaptureSwitchCfg.all) do
		local var_3_1 = T0WorldCaptureSwitchCfg[iter_3_1]

		if var_3_1.switchType == arg_3_2 and var_3_1.character == arg_3_3 then
			if var_3_1.scene == 0 then
				table.insert(var_3_0, iter_3_1)
			elseif var_3_1.scene == arg_3_1 then
				table.insert(var_3_0, iter_3_1)
			end
		end
	end

	return var_3_0
end

function var_0_0.GetCaptureSceneName(arg_4_0, arg_4_1)
	return T0WorldTools.GetCaptureSceneList()[arg_4_1]
end

function var_0_0.ClearContext(arg_5_0)
	if arg_5_0.context then
		arg_5_0.context.captureModel = nil
	end

	arg_5_0.context = nil
end

function var_0_0.InitContext(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = T0WorldTools.GetSkinDLC(arg_6_1)

	arg_6_0.context = {
		isUseLookAt = false,
		isTaking = false,
		useSceneType = 1,
		captureCount = 0,
		useSetting = {},
		character = arg_6_1 or 108502,
		scene = arg_6_2,
		dlcID = var_6_0
	}
end

function var_0_0.GetUseSettingByType(arg_7_0, arg_7_1)
	return arg_7_0.context.useSetting[arg_7_1] or -1
end

function var_0_0.GetDefalutSettingByScene(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return arg_8_0:GetCaptureSwitchList(arg_8_1, arg_8_2, arg_8_3)[1]
end

function var_0_0.SetCaptureSwitch(arg_9_0, arg_9_1)
	if not arg_9_0.context.useSetting then
		arg_9_0.context.useSetting = {}
	end

	local var_9_0 = T0WorldCaptureSwitchCfg[arg_9_1]

	arg_9_0.context.useSetting[var_9_0.switchType] = arg_9_1

	T0WorldLuaBridge.ChangeCapturePose(var_9_0.switchType, var_9_0.switchName)

	if var_9_0.switchType == arg_9_0.SwitchTypeEnum.Action then
		local var_9_1 = arg_9_0:GetDefalutSettingByScene(arg_9_0.context.useSceneType, arg_9_0.SwitchTypeEnum.Face, arg_9_0.context.character)

		arg_9_0:SetCaptureSwitch(var_9_1)
	end

	manager.notify:Invoke(T0_WORLD_CAPTURE_SWITCH_CHANGE, arg_9_1)
end

function var_0_0.GetTakingState(arg_10_0)
	return arg_10_0.context.isTaking
end

function var_0_0.GetHeroID(arg_11_0)
	return arg_11_0.context.character
end

function var_0_0.GetSceneID(arg_12_0)
	return arg_12_0.context.scene
end

function var_0_0.GetUseSceneType(arg_13_0)
	return arg_13_0.context.useSceneType
end

function var_0_0.GetDLCID(arg_14_0)
	return arg_14_0.context.dlcID
end

function var_0_0.SetCaptureScene(arg_15_0, arg_15_1)
	if arg_15_0.context.useSceneType == arg_15_1 then
		return
	end

	arg_15_0.context.useSceneType = arg_15_1

	T0WorldLuaBridge.ChangeCaptureScene(arg_15_1)
end

function var_0_0.DefalutSettingByScene(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetDefalutSettingByScene(arg_16_1, arg_16_0.SwitchTypeEnum.Action, arg_16_0.context.character)

	if var_16_0 then
		arg_16_0:SetCaptureSwitch(var_16_0)
	end

	if arg_16_0:GetUseSettingByType(arg_16_0.SwitchTypeEnum.Face) < 0 then
		local var_16_1 = arg_16_0:GetDefalutSettingByScene(arg_16_0.GeneralSceneType, arg_16_0.SwitchTypeEnum.Face, arg_16_0.context.character)

		if var_16_1 then
			arg_16_0:SetCaptureSwitch(var_16_1)
		end
	end

	if arg_16_0:GetUseSettingByType(arg_16_0.SwitchTypeEnum.Filter) < 0 then
		local var_16_2 = arg_16_0:GetDefalutSettingByScene(arg_16_0.GeneralSceneType, arg_16_0.SwitchTypeEnum.Filter, arg_16_0.context.character)

		if var_16_2 then
			arg_16_0:SetCaptureSwitch(var_16_2)
		end
	end
end

function var_0_0.GetCaptureModel(arg_17_0)
	if arg_17_0.context.captureModel == nil then
		arg_17_0.context.captureModel = GameObject.Find(T0WorldTools.GetCaptureModelPath()).transform
	end

	return arg_17_0.context.captureModel
end

return var_0_0

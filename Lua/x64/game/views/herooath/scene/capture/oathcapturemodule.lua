baseModule = import("game.views.t0World.Capture.T0CaptureModule")

local var_0_0 = class("OathCaptureModule", baseModule)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if arg_1_2 == 3 then
		var_1_0 = Asset.Load("Widget/System/Main_T0SceneGame/108502/FilterModule")
	else
		var_1_0 = Asset.Load("Widget/System/Main_T0SceneGame/108502/PoseModule")
	end

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.switchType = arg_1_2

	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	if arg_2_0.switchType == 3 then
		arg_2_0.scrollHelper = LuaList.New(handler(arg_2_0, arg_2_0.RenderItem), arg_2_0.uiList_, OathCapturePoseItem)
	else
		arg_2_0.scrollHelper = LuaList.New(handler(arg_2_0, arg_2_0.RenderItem), arg_2_0.poseList_, OathCapturePoseItem)
	end
end

function var_0_0.InitList(arg_3_0)
	local var_3_0 = OathToLuaBridge:GetUseOathCharacterID()

	arg_3_0.switchList = OathTools.GetCaptureSwitchList(var_3_0, arg_3_0.switchType)
end

return var_0_0

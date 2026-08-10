local var_0_0 = class("GotoSystemBase")

function var_0_0.GetId(arg_1_0)
	return arg_1_0.systemId
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.systemId = arg_2_1
end

function var_0_0.CustomEnable(arg_3_0)
	return false
end

function var_0_0.OnEnter(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.GetCamera(arg_5_0)
	return
end

function var_0_0.SetCameraParams(arg_6_0, arg_6_1)
	arg_6_0.cameraParams = arg_6_1
end

function var_0_0.GetCameraParams(arg_7_0)
	return arg_7_0.cameraParams
end

function var_0_0.EnableCamera(arg_8_0)
	if not arg_8_0:CustomEnable() and arg_8_0.cameraParams then
		local var_8_0 = arg_8_0.cameraParams[1]
		local var_8_1 = arg_8_0.cameraParams[2]

		QWorldMgr:EnableCustomCamera(var_8_0, var_8_1 or 1, QWorldCameraLayer.System)
	end
end

return var_0_0

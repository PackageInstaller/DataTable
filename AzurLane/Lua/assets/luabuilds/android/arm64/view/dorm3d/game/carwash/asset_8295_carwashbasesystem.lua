class = var_0_10000

local var_0_0 = "CarWashBaseSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Extra.BaseExtraSystem"))

function var_0_1.WrapContext(arg_1_0, arg_1_1)
	return {
		_raw = arg_1_1,
		GetMainCameraTF = function()
			return arg_1_1.mainCameraTF
		end,
		GetMainCamera = function()
			return arg_1_1.mainCamera
		end,
		GetCameraRoot = function()
			return arg_1_1.cameraRoot
		end,
		GetRaycaster = function()
			return arg_1_1.sceneRaycaster
		end,
		GetLadyGO = function()
			return arg_1_1.ladyGO
		end,
		GetGameConfig = function()
			return arg_1_1.contextData.gameConfig
		end,
		GetContextData = function()
			return arg_1_1.contextData
		end,
		GetLoader = function()
			return arg_1_1.loader
		end
	}
end

function var_0_1.GetMainCameraTF(arg_10_0)
	local var_10_0 = arg_10_0.context

	return var_1.GetMainCameraTF(var_10_0)
end

function var_0_1.GetMainCamera(arg_11_0)
	local var_11_0 = arg_11_0.context

	return var_1.GetMainCamera(var_11_0)
end

function var_0_1.GetCameraRoot(arg_12_0)
	local var_12_0 = arg_12_0.context

	return var_1.GetCameraRoot(var_12_0)
end

function var_0_1.GetRaycaster(arg_13_0)
	local var_13_0 = arg_13_0.context

	return var_1.GetRaycaster(var_13_0)
end

function var_0_1.GetLadyGO(arg_14_0)
	local var_14_0 = arg_14_0.context

	return var_1.GetLadyGO(var_14_0)
end

function var_0_1.GetGameConfig(arg_15_0)
	local var_15_0 = arg_15_0.context

	return var_1.GetGameConfig(var_15_0)
end

function var_0_1.GetContextData(arg_16_0)
	local var_16_0 = arg_16_0.context

	return var_1.GetContextData(var_16_0)
end

function var_0_1.GetLoader(arg_17_0)
	local var_17_0 = arg_17_0.context

	return var_1.GetLoader(var_17_0)
end

return var_0_1

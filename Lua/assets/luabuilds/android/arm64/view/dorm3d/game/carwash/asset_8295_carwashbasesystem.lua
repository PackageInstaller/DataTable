local CarWashBaseSystem = class("CarWashBaseSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

function CarWashBaseSystem:WrapContext(arg_1_1)
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

function CarWashBaseSystem:GetMainCameraTF()
	return self.context:GetMainCameraTF()
end

function CarWashBaseSystem:GetMainCamera()
	return self.context:GetMainCamera()
end

function CarWashBaseSystem:GetCameraRoot()
	return self.context:GetCameraRoot()
end

function CarWashBaseSystem:GetRaycaster()
	return self.context:GetRaycaster()
end

function CarWashBaseSystem:GetLadyGO()
	return self.context:GetLadyGO()
end

function CarWashBaseSystem:GetGameConfig()
	return self.context:GetGameConfig()
end

function CarWashBaseSystem:GetContextData()
	return self.context:GetContextData()
end

function CarWashBaseSystem:GetLoader()
	return self.context:GetLoader()
end

return CarWashBaseSystem

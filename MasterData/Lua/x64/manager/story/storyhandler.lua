local StoryHandler = class("StoryHandler")
local var_0_1 = Vector3(0, 1, -10)
local var_0_2 = 25
local var_0_3 = Vector3(0, -2000, 0)

function StoryHandler:Ctor()
	StoryHandler.fovChangeTime_ = 0
end

function StoryHandler:OnCameraEnter()
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	manager.ui.mainCamera.transform.parent = self.transform
	manager.ui.mainCamera.transform.localPosition = var_0_1

	manager.ui:SetMainCameraRot(Vector3.zero)

	StoryHandler.orignalFov = manager.ui.mainCameraCom_.fieldOfView
	manager.ui.mainCameraCom_.fieldOfView = var_0_2

	local var_2_0 = LeanTween.value(StoryHandler.orignalFov, var_0_2, StoryHandler.fovChangeTime_)

	var_2_0:setOnUpdate(LuaHelper.FloatAction(function(arg_3_0)
		manager.ui.mainCameraCom_.fieldOfView = arg_3_0
	end))
	var_2_0:setOnComplete(System.Action(function()
		var_2_0:setOnUpdate(nil):setOnComplete(nil)
	end))

	local var_2_1 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_2_1 then
		StoryHandler.originShadowRotationImmediately = var_2_1.shadowRotationImmediately
		var_2_1.shadowRotationImmediately = true
	end
end

function StoryHandler.OnCameraExit()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	manager.ui.mainCameraCom_.fieldOfView = StoryHandler.orignalFov or 35

	manager.ui:SetMainActive(true)

	manager.ui.mainCamera.transform.parent = nil

	manager.ui:SetMainCameraRot()
	manager.ui:SetMainCameraPos()

	local var_5_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_5_0 then
		var_5_0.shadowRotationImmediately = StoryHandler.originShadowRotationImmediately
	end
end

function StoryHandler:OnStageEnter()
	self.transform.position = var_0_3
	self.transform.localEulerAngles = Vector3(0, 0, 0)
end

return StoryHandler

local var_0_0 = class("StoryHandler")
local var_0_1 = Vector3(0, 1, -10)
local var_0_2 = 25
local var_0_3 = Vector3(0, -2000, 0)

function var_0_0.Ctor(arg_1_0)
	var_0_0.fovChangeTime_ = 0
end

function var_0_0.OnCameraEnter(arg_2_0)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	manager.ui.mainCamera.transform.parent = arg_2_0.transform
	manager.ui.mainCamera.transform.localPosition = var_0_1

	manager.ui:SetMainCameraRot(Vector3.zero)

	var_0_0.orignalFov = manager.ui.mainCameraCom_.fieldOfView
	manager.ui.mainCameraCom_.fieldOfView = var_0_2

	local var_2_0 = LeanTween.value(var_0_0.orignalFov, var_0_2, var_0_0.fovChangeTime_)

	var_2_0:setOnUpdate(LuaHelper.FloatAction(function(arg_3_0)
		manager.ui.mainCameraCom_.fieldOfView = arg_3_0
	end))
	var_2_0:setOnComplete(System.Action(function()
		var_2_0:setOnUpdate(nil):setOnComplete(nil)
	end))

	local var_2_1 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_2_1 then
		var_0_0.originShadowRotationImmediately = var_2_1.shadowRotationImmediately
		var_2_1.shadowRotationImmediately = true
	end
end

function var_0_0.OnCameraExit()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	manager.ui.mainCameraCom_.fieldOfView = var_0_0.orignalFov or 35

	manager.ui:SetMainActive(true)

	manager.ui.mainCamera.transform.parent = nil

	manager.ui:SetMainCameraRot()
	manager.ui:SetMainCameraPos()

	local var_5_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_5_0 then
		var_5_0.shadowRotationImmediately = var_0_0.originShadowRotationImmediately
	end
end

function var_0_0.OnStageEnter(arg_6_0)
	arg_6_0.transform.position = var_0_3
	arg_6_0.transform.localEulerAngles = Vector3(0, 0, 0)
end

return var_0_0

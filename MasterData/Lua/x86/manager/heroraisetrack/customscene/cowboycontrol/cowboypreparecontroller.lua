local CowboyPrepareController = class("CowboyPrepareController", CustomTrackSceneControllerBase)
local var_0_1 = "ModelUI/4_4Cowboy_UI/Activity_EkChuah_StandbyBg"
local var_0_2
local var_0_3 = "UI/HeroCamera/Cowboy_Virtual_Camera"
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9 = {
	-3,
	-2,
	167
}
local var_0_10 = 2.5
local var_0_11

function CowboyPrepareController:OnInit()
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	var_0_4 = GameObject.Instantiate(Asset.Load(var_0_3))
	var_0_2 = GameObject.Instantiate(Asset.Load(var_0_1))

	SetActive(var_0_2, false)

	var_0_2.transform.parent = manager.ui.mainCamera.transform
	var_0_2.transform.localPosition = Vector3.New(var_0_9[1], var_0_9[2], var_0_9[3])
	var_0_2.transform.localScale = Vector3.New(var_0_10, var_0_10, var_0_10)
	var_0_8 = var_0_2.transform:Find("playerPoint")

	SetActive(var_0_2, true)
	manager.ui:SetMainCameraPos(var_0_4.transform:Find("I19_Camera01").position)
	manager.ui:SetMainCameraRot(var_0_4.transform:Find("I19_Camera01").localEulerAngles)

	var_0_7 = var_0_4.transform:Find("playerShowPoint")
	var_0_6 = var_0_4.transform:Find("attributeCam").gameObject:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	var_0_5 = var_0_4.transform:Find("I19_Camera01").gameObject:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	var_0_11 = var_0_2.gameObject:GetComponent(typeof(DynamicTimelineController))
end

function CowboyPrepareController:Enter()
	return
end

function CowboyPrepareController:Exit()
	return
end

function CowboyPrepareController:GetPlayableLength()
	return var_0_11:GetDirectorLength()
end

function CowboyPrepareController:PlayHeroAnim(arg_5_1, arg_5_2, arg_5_3)
	var_0_11:PlayAnimation(arg_5_1, arg_5_2, arg_5_3)
end

function CowboyPrepareController:Restart()
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCameraPos(var_0_5.transform.position)
	manager.ui:SetMainCameraRot(var_0_5.transform.localEulerAngles)

	var_0_5.Priority = 50
	var_0_6.Priority = 10

	var_0_11:Restart()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function CowboyPrepareController:SetPlayerToShowPoint(arg_7_1)
	var_0_11:SetPlayerToTransform(arg_7_1, var_0_7)
end

function CowboyPrepareController:SwitchToShow()
	var_0_11:StopTimeline()
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

	var_0_5.Priority = 10
	var_0_6.Priority = 50

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCameraPos(var_0_6.transform.position)
	manager.ui:SetMainCameraRot(var_0_6.transform.localEulerAngles)
	self:SetPlayerToShowPoint("1083ui_dynamic")
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function CowboyPrepareController:Dispose()
	Object.DestroyImmediate(var_0_4)
	Asset.Unload(var_0_3)
	Object.DestroyImmediate(var_0_2)
	Asset.Unload(var_0_1)

	var_0_4 = nil
	var_0_2 = nil
	var_0_11 = nil

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:ResetMainCamera()
end

return CowboyPrepareController

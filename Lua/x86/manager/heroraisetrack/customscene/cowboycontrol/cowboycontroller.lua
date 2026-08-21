local var_0_0 = class("CowboyController", CustomTrackSceneControllerBase)
local var_0_1 = "ModelUI/4_4Cowboy_UI/Activity_EkChuah_IllustratedBg"
local var_0_2
local var_0_3 = "UI/HeroCamera/Cowboy_Virtual_Camera"
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11 = {
	-3,
	-2,
	167
}
local var_0_12 = 2.5
local var_0_13 = 0.7
local var_0_14
local var_0_15 = "Widget/System/Activity_EkChuah/EkChuah_MainUI/Activity_EkChuah_CutScenesUI"
local var_0_16
local var_0_17
local var_0_18
local var_0_19
local var_0_20 = false
local var_0_21
local var_0_22
local var_0_23 = false

function var_0_0.OnInit(arg_1_0)
	if AshSystemData:GetStoryState() or var_0_23 then
		return
	end

	var_0_23 = true

	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	var_0_4 = GameObject.Instantiate(Asset.Load(var_0_3))
	var_0_2 = GameObject.Instantiate(Asset.Load(var_0_1))

	SetActive(var_0_2, false)

	var_0_2.transform.parent = manager.ui.mainCamera.transform
	var_0_2.transform.localPosition = Vector3.New(var_0_11[1], var_0_11[2], var_0_11[3])
	var_0_2.transform.localScale = Vector3.New(var_0_12, var_0_12, var_0_12)
	var_0_9 = var_0_2.transform:Find("bgParent")

	local var_1_0 = Screen.width / Screen.height
	local var_1_1 = math.max(1, var_1_0 / 1.77) * var_0_13

	var_0_9.transform.localScale = Vector3.New(var_1_1, var_1_1, var_1_1)
	var_0_10 = var_0_2.transform:Find("playerPoint")

	SetActive(var_0_2, true)
	manager.ui:SetMainCameraPos(var_0_4.transform:Find("I19_Camera01").position)
	manager.ui:SetMainCameraRot(var_0_4.transform:Find("I19_Camera01").localEulerAngles)

	var_0_7 = var_0_4.transform:Find("playerShowPoint")
	var_0_8 = var_0_4.transform:Find("playerShowPoint2")
	var_0_6 = var_0_4.transform:Find("attributeCam").gameObject:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	var_0_5 = var_0_4.transform:Find("I19_Camera01").gameObject:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	var_0_14 = var_0_2.gameObject:GetComponent(typeof(DynamicTimelineController))

	local var_1_2 = var_0_2.gameObject:GetComponent("ControllerExCollection")

	var_0_21 = var_1_2:GetController("bg")
	var_0_22 = var_1_2:GetController("bgSwitch")
end

function var_0_0.Enter(arg_2_0)
	return
end

function var_0_0.Exit(arg_3_0)
	return
end

function var_0_0.SwitchBgState(arg_4_0, arg_4_1)
	if var_0_21 then
		var_0_21:SetSelectedIndex(arg_4_1)
	end
end

function var_0_0.SwitchBgStageIndex(arg_5_0, arg_5_1)
	if var_0_22 then
		var_0_22:SetSelectedIndex(arg_5_1 - 1)
	end
end

function var_0_0.GetPlayableLength(arg_6_0)
	return var_0_14:GetDirectorLength()
end

function var_0_0.PlayHeroAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_14:PlayAnimation(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.Restart(arg_8_0)
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCameraPos(var_0_5.transform.position)
	manager.ui:SetMainCameraRot(var_0_5.transform.localEulerAngles)

	var_0_5.Priority = 50
	var_0_6.Priority = 10

	var_0_14:Restart()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function var_0_0.SetPlayerToShowPoint(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == 1 then
		var_0_14:SetPlayerToTransform(arg_9_1, var_0_8)
	else
		var_0_14:SetPlayerToTransform(arg_9_1, var_0_7)
	end
end

function var_0_0.SwitchToShow(arg_10_0, arg_10_1)
	var_0_14:StopTimeline()
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

	var_0_5.Priority = 10
	var_0_6.Priority = 50

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCameraPos(var_0_6.transform.position)
	manager.ui:SetMainCameraRot(var_0_6.transform.localEulerAngles)
	arg_10_0:SetPlayerToShowPoint("1083ui_dynamic", arg_10_1)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function var_0_0.ReleaseHero(arg_11_0, arg_11_1)
	if not var_0_14 then
		return
	end

	var_0_14:StopTimeline()
	var_0_14:ReleaseHero(arg_11_1)
end

function var_0_0.ShowCutScene(arg_12_0, arg_12_1)
	if isNil(var_0_16) then
		var_0_16 = GameObject.Instantiate(Asset.Load(var_0_15))
		var_0_16.transform.parent = manager.ui.uiLoad.transform
		var_0_16.transform.localPosition = Vector3.zero
		var_0_16.transform.localScale = Vector3.one
		var_0_16.transform.localRotation = Quaternion.identity
		var_0_17 = var_0_16:GetComponent(typeof(Animator))

		local var_12_0 = var_0_16.gameObject:GetComponent("RectTransform")

		var_12_0.offsetMin = Vector2.New(0, 0)
		var_12_0.offsetMax = Vector2.New(0, 0)
	end

	SetActive(var_0_16, true)
	var_0_17:Play("in")
	arg_12_0:StopCutSceneTimer()

	var_0_20 = true
	var_0_19 = Timer.New(function()
		if arg_12_1 then
			arg_12_1()
		end
	end, 1, 1)

	var_0_19:Start()
end

function var_0_0.CloseCutScene(arg_14_0)
	if var_0_20 then
		var_0_17:Play("out")
		arg_14_0:StopCutSceneTimer()

		var_0_18 = Timer.New(function()
			SetActive(var_0_16, false)

			var_0_18 = nil
			var_0_20 = false
		end, 1, 1)

		var_0_18:Start()
	end
end

function var_0_0.StopCutSceneTimer(arg_16_0)
	if var_0_18 ~= nil then
		var_0_18:Stop()

		var_0_18 = nil
	end

	if var_0_19 then
		var_0_19:Stop()

		var_0_19 = nil
	end
end

function var_0_0.Dispose(arg_17_0)
	var_0_23 = false

	arg_17_0:StopCutSceneTimer()

	if not isNil(var_0_16) then
		Object.DestroyImmediate(var_0_16)
		Asset.Unload(var_0_15)

		var_0_16 = nil
		var_0_17 = nil
	end

	if var_0_4 then
		Object.DestroyImmediate(var_0_4)
		Asset.Unload(var_0_3)
	end

	if var_0_2 then
		Object.DestroyImmediate(var_0_2)
		Asset.Unload(var_0_1)
	end

	var_0_4 = nil
	var_0_2 = nil
	var_0_14 = nil

	if AshSystemData:GetStoryState() then
		return
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:ResetMainCamera()
end

return var_0_0

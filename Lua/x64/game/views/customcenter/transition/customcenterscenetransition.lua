local var_0_0 = class("CustomCenterSceneTransition", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/ReplacementSwitchUI/ReplacementSwitchUI"), arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:Show(false)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:ReleaseSnapShot()
	arg_3_0:StopTimer()
	arg_3_0:Show(false)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.PlayVagueAnimator(arg_6_0, arg_6_1)
	arg_6_0.animator_:Play("Vague", 0)
	arg_6_0.animator_:Update(0)
	arg_6_0:Show(true)
	arg_6_0:AddTimer(function()
		arg_6_1()
	end)
end

function var_0_0.PlayAlphaAnimator(arg_8_0)
	arg_8_0.animator_:Play("Alpha", 0)
	arg_8_0.animator_:Update(0)
	arg_8_0:AddTimer(function()
		arg_8_0:ReleaseSnapShot()
		arg_8_0:Show(false)
	end)
end

function var_0_0.SnapShot(arg_10_0)
	local var_10_0 = (Screen.width % 8 < 4 and math.floor(Screen.width / 8) or math.ceil(Screen.width / 8)) * 8
	local var_10_1 = (Screen.height % 8 < 4 and math.floor(Screen.height / 8) or math.ceil(Screen.height / 8)) * 8

	arg_10_0:ReleaseSnapShot()

	arg_10_0.snapshot_ = UnityEngine.RenderTexture.New(var_10_0, var_10_1, 0, UnityEngine.RenderTextureFormat.ARGB32)
	arg_10_0.snapshot_.useMipMap = true

	local var_10_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_10_2) then
		var_10_2:CaptureSnapshot(arg_10_0.snapshot_, true)
	end

	arg_10_0.bg_.texture = arg_10_0.snapshot_
end

function var_0_0.ReleaseSnapShot(arg_11_0)
	if arg_11_0.snapshot_ then
		arg_11_0.snapshot_:Release()

		arg_11_0.snapshot_ = nil

		if manager.ui.mainCamera ~= nil and not isNil(manager.ui.mainCamera) then
			local var_11_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

			if not isNil(var_11_0) then
				var_11_0:FreeSnapshot()
			end
		end
	end
end

function var_0_0.AddTimer(arg_12_0, arg_12_1)
	arg_12_0:StopTimer()

	arg_12_0.animatorTimer_ = FrameTimer.New(function()
		if arg_12_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			if arg_12_1 then
				arg_12_1()
			end

			arg_12_0:StopTimer()
		end
	end, 1, -1)

	arg_12_0.animatorTimer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.animatorTimer_ then
		arg_14_0.animatorTimer_:Stop()

		arg_14_0.animatorTimer_ = nil
	end
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

return var_0_0

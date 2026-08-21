local var_0_0 = class("SandPlayTakingPhotoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookInterludeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.photoTimer_ = Timer.New(function()
		if arg_6_0.photoTimer_ then
			arg_6_0.photoTimer_:Stop()

			arg_6_0.photoTimer_ = nil
		end

		arg_6_0:TakeSnap()
	end, 1, 1)

	arg_6_0.photoTimer_:Start()
end

function var_0_0.TakeSnap(arg_8_0)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		local var_9_0 = tonumber(SettingData:GetSettingData().pic.resolution)
		local var_9_1, var_9_2 = SettingTools.GetSettingScreenSize(var_9_0)

		if not SDKTools.IsSDK() then
			var_9_1, var_9_2 = Screen.width, Screen.height
		end

		arg_8_0.screenSnap_ = ScreenSnap.New(var_9_1, var_9_2)

		arg_8_0.screenSnap_:Take()

		local var_9_3 = arg_8_0.screenSnap_:GetSprite()

		arg_8_0.photoImg_.sprite = var_9_3

		arg_8_0.mainAnimator_:Play("UI_QuanZhou_CollectBookInterludeUI", -1, 0)

		arg_8_0.aniTimer_ = FrameTimer.New(function()
			local var_10_0 = arg_8_0.mainAnimator_:GetCurrentAnimatorStateInfo(0)

			if var_10_0:IsName("UI_QuanZhou_CollectBookInterludeUI") and var_10_0.normalizedTime >= 0.99 and arg_8_0.aniTimer_ then
				arg_8_0.aniTimer_:Stop()

				arg_8_0.aniTimer_ = nil

				arg_8_0:Back()
				QWorldLuaBridge.HidePlayer(true)
				manager.notify:Invoke(QWORLD_TAKE_PHOTO_SNAP)
			end
		end, 1, -1)

		arg_8_0.aniTimer_:Start()
	end)
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.photoTimer_ then
		arg_11_0.photoTimer_:Stop()

		arg_11_0.photoTimer_ = nil
	end

	if arg_11_0.aniTimer_ then
		arg_11_0.aniTimer_:Stop()

		arg_11_0.aniTimer_ = nil
	end

	arg_11_0.screenSnap_ = nil
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.photoTimer_ then
		arg_12_0.photoTimer_:Stop()

		arg_12_0.photoTimer_ = nil
	end

	if arg_12_0.aniTimer_ then
		arg_12_0.aniTimer_:Stop()

		arg_12_0.aniTimer_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

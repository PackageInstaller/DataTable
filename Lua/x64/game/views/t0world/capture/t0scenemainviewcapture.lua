local var_0_0 = partialClass("T0SceneMainView", ReduxView)

function var_0_0.AddCaptureBtnListener(arg_1_0)
	arg_1_0.isClickCaptureBtn_ = false

	arg_1_0:AddBtnListener(arg_1_0.captureBtn_, nil, function()
		if arg_1_0.isClickCaptureBtn_ then
			return
		end

		arg_1_0.isClickCaptureBtn_ = true

		T0WorldEnterHideUIMode(true)
		SetActive(arg_1_0.panelGo_, false)
		WaitRenderFrameUtil.inst.StartScreenShot(function()
			RecordT0WorldCaptureSDK(1, arg_1_0.sliderSlr_.value)

			T0WorldMgr.context.captureCount = T0WorldMgr.context.captureCount + 1

			SetActive(arg_1_0.panelGo_, true)
			arg_1_0.shareView_:OnSnape(true)
		end)
	end)
end

function var_0_0.InitCapture(arg_4_0)
	arg_4_0:AddCaptureBtnListener()
	arg_4_0:AddCaptureEventListener()

	arg_4_0.sceneChangeView_ = T0SceneChangeView.New(arg_4_0.sceneObj_)
	arg_4_0.shareView_ = T0ShareView.New(arg_4_0.goSharePanel_)

	arg_4_0.shareView_:ExitViewCallBack(function()
		arg_4_0.isClickCaptureBtn_ = false

		T0WorldEnterHideUIMode(false)
	end)
end

function var_0_0.EnterCaptrue(arg_6_0)
	arg_6_0.shareView_:OnEnter()
end

function var_0_0.AddCaptureEventListener(arg_7_0)
	arg_7_0:RegistEventListener(T0_WORLD_CAPTURE_SCENE_CHANGE, handler(arg_7_0, arg_7_0.OnSceneChange))
end

function var_0_0.OnSceneChange(arg_8_0)
	arg_8_0.sceneChangeView_:Render()
	arg_8_0:CloseSceneExpand()
end

function var_0_0.CloseSceneExpand(arg_9_0)
	arg_9_0.sceneChangeView_:SetExpandState(false)
end

function var_0_0.ExitCapture(arg_10_0)
	arg_10_0.shareView_:OnExit()
end

function var_0_0.DisposeCapture(arg_11_0)
	arg_11_0.shareView_:Dispose()

	arg_11_0.shareView_ = nil

	if arg_11_0.sceneChangeView_ then
		arg_11_0.sceneChangeView_:Dispose()

		arg_11_0.sceneChangeView_ = nil
	end
end

local var_0_0 = partialClass("T0SceneMainView", ReduxView)

function var_0_0:AddCaptureBtnListener()
	self.isClickCaptureBtn_ = false

	self:AddBtnListener(self.captureBtn_, nil, function()
		if self.isClickCaptureBtn_ then
			return
		end

		self.isClickCaptureBtn_ = true

		T0WorldEnterHideUIMode(true)
		SetActive(self.panelGo_, false)
		WaitRenderFrameUtil.inst.StartScreenShot(function()
			RecordT0WorldCaptureSDK(1, self.sliderSlr_.value)

			T0WorldMgr.context.captureCount = T0WorldMgr.context.captureCount + 1

			SetActive(self.panelGo_, true)
			self.shareView_:OnSnape(true)
		end)
	end)
end

function var_0_0:InitCapture()
	self:AddCaptureBtnListener()
	self:AddCaptureEventListener()

	self.sceneChangeView_ = T0SceneChangeView.New(self.sceneObj_)
	self.shareView_ = T0ShareView.New(self.goSharePanel_)

	self.shareView_:ExitViewCallBack(function()
		self.isClickCaptureBtn_ = false

		T0WorldEnterHideUIMode(false)
	end)
end

function var_0_0:EnterCaptrue()
	self.shareView_:OnEnter()
end

function var_0_0:AddCaptureEventListener()
	self:RegistEventListener(T0_WORLD_CAPTURE_SCENE_CHANGE, handler(self, self.OnSceneChange))
end

function var_0_0:OnSceneChange()
	self.sceneChangeView_:Render()
	self:CloseSceneExpand()
end

function var_0_0:CloseSceneExpand()
	self.sceneChangeView_:SetExpandState(false)
end

function var_0_0:ExitCapture()
	self.shareView_:OnExit()
end

function var_0_0:DisposeCapture()
	self.shareView_:Dispose()

	self.shareView_ = nil

	if self.sceneChangeView_ then
		self.sceneChangeView_:Dispose()

		self.sceneChangeView_ = nil
	end
end

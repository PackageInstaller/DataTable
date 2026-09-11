local CustomCenterSceneTransition = class("CustomCenterSceneTransition", ReduxView)

function CustomCenterSceneTransition:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/ReplacementSwitchUI/ReplacementSwitchUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function CustomCenterSceneTransition:OnEnter()
	self:Show(false)
end

function CustomCenterSceneTransition:OnExit()
	self:ReleaseSnapShot()
	self:StopTimer()
	self:Show(false)
end

function CustomCenterSceneTransition:Dispose()
	CustomCenterSceneTransition.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function CustomCenterSceneTransition:AddListeners()
	return
end

function CustomCenterSceneTransition:PlayVagueAnimator(arg_6_1)
	self.animator_:Play("Vague", 0)
	self.animator_:Update(0)
	self:Show(true)
	self:AddTimer(function()
		arg_6_1()
	end)
end

function CustomCenterSceneTransition:PlayAlphaAnimator()
	self.animator_:Play("Alpha", 0)
	self.animator_:Update(0)
	self:AddTimer(function()
		self:ReleaseSnapShot()
		self:Show(false)
	end)
end

function CustomCenterSceneTransition:SnapShot()
	local var_10_0 = (Screen.width % 8 < 4 and math.floor(Screen.width / 8) or math.ceil(Screen.width / 8)) * 8
	local var_10_1 = (Screen.height % 8 < 4 and math.floor(Screen.height / 8) or math.ceil(Screen.height / 8)) * 8

	self:ReleaseSnapShot()

	self.snapshot_ = UnityEngine.RenderTexture.New(var_10_0, var_10_1, 0, UnityEngine.RenderTextureFormat.ARGB32)
	self.snapshot_.useMipMap = true

	local var_10_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_10_2) then
		var_10_2:CaptureSnapshot(self.snapshot_, true)
	end

	self.bg_.texture = self.snapshot_
end

function CustomCenterSceneTransition:ReleaseSnapShot()
	if self.snapshot_ then
		self.snapshot_:Release()

		self.snapshot_ = nil

		if manager.ui.mainCamera ~= nil and not isNil(manager.ui.mainCamera) then
			local var_11_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

			if not isNil(var_11_0) then
				var_11_0:FreeSnapshot()
			end
		end
	end
end

function CustomCenterSceneTransition:AddTimer(arg_12_1)
	self:StopTimer()

	self.animatorTimer_ = FrameTimer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			if arg_12_1 then
				arg_12_1()
			end

			self:StopTimer()
		end
	end, 1, -1)

	self.animatorTimer_:Start()
end

function CustomCenterSceneTransition:StopTimer()
	if self.animatorTimer_ then
		self.animatorTimer_:Stop()

		self.animatorTimer_ = nil
	end
end

function CustomCenterSceneTransition:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

return CustomCenterSceneTransition

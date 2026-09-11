local SandPlayTakingPhotoView = class("SandPlayTakingPhotoView", ReduxView)

function SandPlayTakingPhotoView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookInterludeUI"
end

function SandPlayTakingPhotoView:UIParent()
	return manager.ui.uiMain.transform
end

function SandPlayTakingPhotoView:Init()
	self:InitUI()
end

function SandPlayTakingPhotoView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function SandPlayTakingPhotoView:AddUIListener()
	return
end

function SandPlayTakingPhotoView:OnEnter()
	self.photoTimer_ = Timer.New(function()
		if self.photoTimer_ then
			self.photoTimer_:Stop()

			self.photoTimer_ = nil
		end

		self:TakeSnap()
	end, 1, 1)

	self.photoTimer_:Start()
end

function SandPlayTakingPhotoView:TakeSnap()
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		local var_9_0, var_9_1 = SettingTools.GetSettingScreenSize((tonumber(SettingData:GetSettingData().pic.resolution)))

		if not SDKTools.IsSDK() then
			var_9_1 = Screen.height
			var_9_0 = Screen.width
		end

		self.screenSnap_ = ScreenSnap.New(var_9_0, var_9_1)

		self.screenSnap_:Take()

		self.photoImg_.sprite = self.screenSnap_:GetSprite()

		self.mainAnimator_:Play("UI_QuanZhou_CollectBookInterludeUI", -1, 0)

		self.aniTimer_ = FrameTimer.New(function()
			local var_10_0 = self.mainAnimator_:GetCurrentAnimatorStateInfo(0)

			if var_10_0:IsName("UI_QuanZhou_CollectBookInterludeUI") and var_10_0.normalizedTime >= 0.99 and self.aniTimer_ then
				self.aniTimer_:Stop()

				self.aniTimer_ = nil

				self:Back()
				QWorldLuaBridge.HidePlayer(true)
				manager.notify:Invoke(QWORLD_TAKE_PHOTO_SNAP)
			end
		end, 1, -1)

		self.aniTimer_:Start()
	end)
end

function SandPlayTakingPhotoView:OnExit()
	if self.photoTimer_ then
		self.photoTimer_:Stop()

		self.photoTimer_ = nil
	end

	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self.screenSnap_ = nil
end

function SandPlayTakingPhotoView:Dispose()
	if self.photoTimer_ then
		self.photoTimer_:Stop()

		self.photoTimer_ = nil
	end

	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	SandPlayTakingPhotoView.super.Dispose(self)
end

return SandPlayTakingPhotoView

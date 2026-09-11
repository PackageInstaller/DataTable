local OathPhotoDisplayView = class("OathPhotoDisplayView", ReduxView)

function OathPhotoDisplayView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.modeController_ = self.controller_:GetController("mode")
end

function OathPhotoDisplayView:SetAniPlayEnd()
	self.ani_:Play("UI_phototakenUI_cx", 0, 1)
end

function OathPhotoDisplayView:OnSnape()
	self.screenSnap_ = ScreenSnap.New(Screen.width, Screen.height)

	self.screenSnap_:Take()

	self.imageBg_.sprite = self.screenSnap_:GetSprite()
	self.imageBg_.transform.localScale = Vector3.one * (Screen.width / Screen.height > 1.7777777777777777 and self.maskNodeRect_.rect.height / Screen.height or self.maskNodeRect_.rect.width / Screen.width)

	self.imageBg_:SetNativeSize()

	self.screenSnapPath_ = self:GetSaveCachePath()

	self.screenSnap_:SaveSnap(self.screenSnapPath_)
	self:IsShowPanel(true)
end

function OathPhotoDisplayView:SetData(arg_4_1)
	self.sceneMode = arg_4_1

	self:RefreshUI()
end

function OathPhotoDisplayView:RefreshUI()
	if self.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
		self.modeController_:SetSelectedState("oathEnter")
	elseif self.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
		self.modeController_:SetSelectedState("bookEnter")
	end
end

function OathPhotoDisplayView:OnEnter()
	self:RegistEventListener(SDK_UPLOAD_IMG, OathCollectionContentAction.OnSDKUploadWeddingPhoto(handler(self, self.UploadImageSuccess), handler(self, self.UnloadImageFailed)))
end

function OathPhotoDisplayView:OnExit()
	self:RemoveAllEventListener()

	self.screenSnap_ = nil
end

function OathPhotoDisplayView:IsShowPanel(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function OathPhotoDisplayView:ExitPanel()
	if self.exitViewFunc then
		self.exitViewFunc()
	end

	self:IsShowPanel(false)
end

function OathPhotoDisplayView:Dispose()
	OathPhotoDisplayView.super.Dispose(self)
end

local var_0_1 = {
	go = 1,
	share = 3,
	re = 2
}

function OathPhotoDisplayView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		self:OnClickSureBtn()
		self:SendSelectSDK(var_0_1.go)
	end)
	self:AddBtnListener(self.reBtn_, nil, function()
		if self.reFunc then
			self.reFunc()
		end

		self:SendSelectSDK(var_0_1.re)
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		if self.shareFunc then
			self.shareFunc(self.screenSnap_:GetSprite(), self.screenSnapPath_)
		end

		self:SendSelectSDK(var_0_1.share)
	end)
end

function OathPhotoDisplayView:SendSelectSDK(arg_15_1)
	SDKTools.SendMessageToSDK("activity_sys_act", {
		params_list = "[1,2,3]",
		mould_id = 1,
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		type = OathConst.OATH_SCENE_ID.CAPTURE_SELECT,
		param_tree = arg_15_1
	})
end

function OathPhotoDisplayView:SetExitViewCallBack(arg_16_1)
	if arg_16_1 then
		self.exitViewFunc = arg_16_1
	end
end

function OathPhotoDisplayView:SetReCallBack(arg_17_1)
	if arg_17_1 then
		self.reFunc = arg_17_1
	end
end

function OathPhotoDisplayView:SetShareCallBack(arg_18_1)
	if arg_18_1 then
		self.shareFunc = arg_18_1
	end
end

function OathPhotoDisplayView:OnClickSureBtn()
	local var_19_0 = self.screenSnapPath_

	if self.screenSnapPath_ == nil then
		var_19_0 = self:GetSaveCachePath()

		self.screenSnap_:SaveSnap(var_19_0)
	end

	if GameToSDK.IsEditorPlatform() then
		self:UploadImageSuccess((string.match(var_19_0, "picture_(%d+)%.jpg")))
	else
		SDKUploadImage("oath", var_19_0)
	end
end

function OathPhotoDisplayView:GetSaveCachePath()
	return manager.share:GetSavePathByModule("oath") .. string.format("picture_%s_%s.jpg", USER_ID, (OathToLuaBridge:GetOathHeroID()))
end

function OathPhotoDisplayView:UploadImageSuccess(arg_21_1)
	local var_21_0 = OathToLuaBridge:GetOathHeroID()

	OathCollectionContentAction.UpdateWeddingPhoto(var_21_0, arg_21_1)
	self.screenSnap_:SaveSnap(manager.share:GetSavePathByModule("imgCache/oath") .. string.format("picture_%s_%s.jpg", USER_ID, var_21_0))
	self:JumpToOathBook()
end

function OathPhotoDisplayView:UnloadImageFailed()
	ShowTips("IMAGE_UPLOAD_FAIL")
end

function OathPhotoDisplayView:JumpToOathBook()
	OathToLuaBridge.OathEnterCaptureHideUIMode(false)

	local var_23_0 = OathToLuaBridge:GetOathHeroID()
	local var_23_1 = self.screenSnap_:GetSprite()

	if self.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
		JumpTools.OpenPageByJump("oathBookLoadingView", {
			heroID = var_23_0,
			sprite = var_23_1
		})
	elseif self.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
		OathToLuaBridge.OathExitBookReModeScene(var_23_0, var_23_1)
	end
end

return OathPhotoDisplayView

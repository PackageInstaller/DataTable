local OathSceneCaptureView = class("OathSceneCaptureView", ReduxView)

function OathSceneCaptureView:UIName()
	return "Widget/System/Hero_Oath/OathCaptureView/HeroOathSceneCaptureView"
end

local var_0_1 = {
	CAPTURE = 1,
	EXIT = 2
}
local var_0_2 = {
	BOOK = 2,
	SHARE = 1
}

function OathSceneCaptureView:UIParent()
	return manager.ui.uiMain.transform
end

function OathSceneCaptureView:Init()
	self:InitUI()
end

function OathSceneCaptureView:InitUI()
	self:BindCfgUI()

	self.lookStateController_ = self.controller_:GetController("lookBtnState")
	self.isClickCaptureBtn_ = false

	self:AddBtnListener(self.captureBtn_, nil, function()
		self:OnClickCaptureBtn()
	end)
	self:AddBtnListener(self.settingBtn_, nil, function()
		JumpTools.OpenPageByJump("oathCaptureSettingView")
	end)

	self.photoDisplayView_ = OathPhotoDisplayView.New(self.photoDispalyPanel_)

	self.photoDisplayView_:SetExitViewCallBack(function()
		self.isClickCaptureBtn_ = false

		OathToLuaBridge.OathEnterCaptureHideUIMode(false)
	end)
	self.photoDisplayView_:SetReCallBack(function()
		self.isClickCaptureBtn_ = false

		OathToLuaBridge.OathEnterCaptureHideUIMode(false)
		SetActive(self.gameObject_, true)
		self.photoDisplayView_:IsShowPanel(false)
	end)
	self.photoDisplayView_:SetShareCallBack(function(arg_9_0, arg_9_1)
		self:OnClickDisplayShareBtn(arg_9_0, arg_9_1)
	end)

	self.sharePanel_ = OathShareView.New(self.goSharePanel_)

	self.sharePanel_:ExitViewCallBack(function()
		self.isClickCaptureBtn_ = false

		OathToLuaBridge.OathEnterCaptureHideUIMode(false)

		if self.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
			self.photoDisplayView_:IsShowPanel(false)
		elseif self.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
			self.photoDisplayView_:IsShowPanel(true)
			self.photoDisplayView_:SetAniPlayEnd()
		end
	end)
end

function OathSceneCaptureView:OnClickDisplayShareBtn(arg_11_1, arg_11_2)
	self.photoDisplayView_:IsShowPanel(false)
	SetActive(self.gameObject_, false)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		SetActive(self.gameObject_, true)
		self.sharePanel_:OnSnape(true)
	end)
end

function OathSceneCaptureView:OnClickCaptureBtn()
	if self.isClickCaptureBtn_ then
		return
	end

	self.isClickCaptureBtn_ = true

	OathToLuaBridge.OathEnterCaptureHideUIMode(true)
	manager.ui:ShowScreenTap(false)
	SetActive(self.gameObject_, false)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		SetActive(self.gameObject_, true)

		if self.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
			manager.ui:SetUISeparateRender(true)
			self.photoDisplayView_:OnSnape()
			self:OathCaptureSDK(var_0_2.BOOK)
		elseif self.sceneMode == OathConst.OATH_SCENE_MODE.SHARE then
			self.sharePanel_:OnSnape(true)
			self:OathCaptureSDK(var_0_2.SHARE)
		elseif self.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
			self.photoDisplayView_:OnSnape()
			self:OathCaptureSDK(var_0_2.BOOK)
		end

		manager.ui:ShowScreenTap(true)
	end)
end

function OathSceneCaptureView:GetFilterSDKData()
	return (string.format("[{pose:%s},{emoji:%s},{filter:%s},{camera_look:%s},{camera_position:%s},{camera_distance:%s}]", OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Action) or -1, OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Face) or -1, OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Filter) or -1, self.lookStateController_:GetSelectedState() == "on" or false, self.sliderSlr_.value, manager.ui.mainCameraCom_.fieldOfView))
end

function OathSceneCaptureView:OathCaptureSDK(arg_16_1)
	local var_16_0 = {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		skin_id = OathToLuaBridge:GetUseOathCharacterID(),
		stage_id = arg_16_1,
		result = var_0_1.CAPTURE
	}

	var_16_0.other_data = self:GetFilterSDKData() or {}

	SDKTools.SendMessageToSDK("activity_combat_over", var_16_0)
end

function OathSceneCaptureView:OathExitSDK()
	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		skin_id = OathToLuaBridge:GetUseOathCharacterID(),
		stage_id = (self.sceneMode == OathConst.OATH_SCENE_MODE.SHARE or nil) and var_0_2.SHARE,
		result = var_0_1.EXIT,
		other_data = {}
	})
end

function OathSceneCaptureView:OnEnter()
	self.sceneMode = self.params_.sceneMode

	if self.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE or self.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
		self.photoDisplayView_:OnEnter()
		self.photoDisplayView_:SetData(self.sceneMode)

		if self.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
			self.sharePanel_:OnEnter()
		end

		self.sharePanel_:SetData(OathConst.OATH_SHARE_TYPE.BOOL_RE, OathToLuaBridge:GetOathHeroID())
	elseif self.sceneMode == OathConst.OATH_SCENE_MODE.SHARE then
		self.sharePanel_:OnEnter()
		self.sharePanel_:SetData(OathConst.OATH_SHARE_TYPE.SHARE, OathToLuaBridge:GetOathHeroID())
	end

	self:AddEventListeners()
end

function OathSceneCaptureView:AddEventListeners()
	self:RegistEventListener(OATH_SCENE_LOAD_MODEL, handler(self, self.OnLoadModel))
end

function OathSceneCaptureView:OnLoadModel()
	OathToLuaBridge:SetCaptureSwitch((OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Action)))
	OathToLuaBridge:SetCaptureSwitch((OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Filter)))
	OathToLuaBridge:SetCaptureSwitch((OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Face)))
end

function OathSceneCaptureView:OnTop()
	self:RefreshBar()
end

function OathSceneCaptureView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("SNAKEGAME_GIVE_UP"),
			OkCallback = function()
				self:OathExitSDK()
				OathToLuaBridge.OathExitScene()
			end
		})
	end)
end

function OathSceneCaptureView:OnExit()
	self:RemoveAllEventListener()
	self.photoDisplayView_:OnExit()
	self.sharePanel_:OnExit()
end

function OathSceneCaptureView:Dispose()
	self.photoDisplayView_:Dispose()

	self.photoDisplayView_ = nil

	self.sharePanel_:Dispose()

	self.sharePanel_ = nil

	self.super.Dispose(self)
end

return OathSceneCaptureView

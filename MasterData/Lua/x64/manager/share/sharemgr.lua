local cjson = require("cjson")
local ShareLogoView = import("manager.share.ShareLogoView")
local ShareMgr = class("ShareMgr")

function ShareMgr:Init()
	if self.isInit then
		return
	end

	self.isInit = true

	self:InitUI()
	self:AddListeners()
	SetActive(self.gameObject_, false)

	self.shareCallbackHandler_ = handler(self, self.ShareCallback)

	manager.notify:RegistListener(SHARE_CALLBACK, self.shareCallbackHandler_)
end

function ShareMgr:InitUI()
	self.screenSnapPath_ = Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"

	local var_2_0 = Asset.Load("Atlas/Share")

	self.gameObject_ = GameObject.Instantiate(Asset.Load("UI/Common/ShareUI"), GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/Canvas").transform)
	self.transform_ = self.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.shareLogoView_ = ShareLogoView.New(self.goSnapPanel_)

	if not SDKTools.GetIsOverSea() then
		if self.buttonTwiiter_ then
			SetActive(self.buttonTwiiter_.transform.gameObject, false)
		end

		if GameToSDK.PLATFORM_ID == 4 then
			SetActive(self.buttonWechat_.transform.gameObject, false)
			SetActive(self.buttonWeibo_.transform.gameObject, false)
			SetActive(self.buttonQQ_.transform.gameObject, false)
			SetActive(self.buttonQQZone_.transform.gameObject, false)
			SetActive(self.buttonWechatMoments_.transform.gameObject, false)
		end
	else
		SetActive(self.buttonWechat_.transform.gameObject, false)
		SetActive(self.buttonWeibo_.transform.gameObject, false)
		SetActive(self.buttonQQ_.transform.gameObject, false)
		SetActive(self.buttonQQZone_.transform.gameObject, false)
		SetActive(self.buttonWechatMoments_.transform.gameObject, false)

		if self.buttonTwiiter_ then
			SetActive(self.buttonTwiiter_.transform.gameObject, true)
		end

		if SDKTools.GetIsThisServer({
			"kr"
		}) and self.buttonTwiiter_ then
			SetActive(self.buttonTwiiter_.transform.gameObject, false)
		end
	end

	SetActive(self.buttonPath_.transform.gameObject, GameToSDK.IsEditorOrPcPlatform())
end

function ShareMgr:Share(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self:Init()
	SetActive(self.gameObject_, true)

	self.shareCallback_ = arg_3_3

	manager.ui:EventEnabled(false)
	manager.tips:Show(false)
	arg_3_1()
	self.shareLogoView_:HideLogo()
	manager.ui:ShowScreenTap(false)
	SetActive(self.goSharePanel_, false)
	manager.achievementTips:Hide(true)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		local var_4_0, var_4_1 = SettingTools.GetSettingScreenSize((tonumber(SettingData:GetSettingData().pic.resolution)))

		if not SDKTools.IsSDK() then
			var_4_1 = Screen.height
			var_4_0 = Screen.width
		end

		if arg_3_4 then
			self.screenSnap_ = ScreenSnap.New(var_4_1, var_4_0)
			self.screenSnap2_ = ScreenSnap.New(var_4_1, var_4_0)
		else
			self.screenSnap_ = ScreenSnap.New(var_4_0, var_4_1)
			self.screenSnap2_ = ScreenSnap.New(var_4_0, var_4_1)
		end

		self.screenSnap_:Take()

		local var_4_2 = self.screenSnap_:GetSprite()

		self.imageBg_.sprite = var_4_2

		self.shareLogoView_:ShowLogo(arg_3_5)
		WaitRenderFrameUtil.inst.StartScreenShot(function()
			self.screenSnap2_:Take()
			self.shareLogoView_:HideLogo()
			SetActive(self.goSharePanel_, true)
			manager.achievementTips:Hide(false)
			manager.ui:ShowScreenTap(true)
			arg_3_2()
			manager.tips:Show(true)
			manager.ui:EventEnabled(true)

			var_4_2 = self.screenSnap2_:GetSprite()
			self.imageShot_.sprite = var_4_2
			self.screenSnapPath_ = Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"

			self.screenSnap2_:SaveSnap(self.screenSnapPath_)
		end)
	end)
end

function ShareMgr:ShareWithSprite(arg_6_1, arg_6_2, arg_6_3)
	SetActive(self.gameObject_, true)

	self.shareCallback_ = arg_6_2
	self.imageBg_.sprite = arg_6_3

	self.shareLogoView_:HideLogo()
	SetActive(self.goSharePanel_, true)
	arg_6_1()

	self.imageShot_.sprite = arg_6_3
	self.screenSnapPath_ = self:SaveTexture(arg_6_3.texture)
end

function ShareMgr:SaveTexture(arg_7_1)
	if not isNil(arg_7_1) then
		local var_7_0 = Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"

		ScreenSnap.SaveTexture(var_7_0, arg_7_1)

		return var_7_0
	end

	return Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"
end

function ShareMgr:SaveRenderTextureByModule(arg_8_1, arg_8_2)
	if not isNil(arg_8_2) then
		local var_8_0 = Application.persistentDataPath .. "/" .. arg_8_1 .. "/picture_" .. manager.time:GetServerTime() .. ".jpg"

		ScreenSnap.SaveRenderTexture(var_8_0, arg_8_2)

		return var_8_0
	end

	return Application.persistentDataPath .. "/" .. arg_8_1 .. "/picture_" .. manager.time:GetServerTime() .. ".jpg"
end

function ShareMgr:GetSavePathByModule(arg_9_1)
	return Application.persistentDataPath .. "/" .. arg_9_1 .. "/"
end

function ShareMgr:AddListeners()
	self.buttonCancel_.onClick:AddListener(function()
		self:OnClickClose()
	end)

	if self.buttonQQ_ then
		self.buttonQQ_.onClick:AddListener(function()
			self:OnClickShare("QQ")
		end)
	end

	if self.buttonQQZone_ then
		self.buttonQQZone_.onClick:AddListener(function()
			self:OnClickShare("QZone")
		end)
	end

	if self.buttonWechat_ then
		self.buttonWechat_.onClick:AddListener(function()
			self:OnClickShare("Wechat")
		end)
	end

	if self.buttonWechatMoments_ then
		self.buttonWechatMoments_.onClick:AddListener(function()
			self:OnClickShare("WechatMoments")
		end)
	end

	if self.buttonWeibo_ then
		self.buttonWeibo_.onClick:AddListener(function()
			self:OnClickShare("SinaWeibo")
		end)
	end

	if self.buttonTwiiter_ then
		self.buttonTwiiter_.onClick:AddListener(function()
			self:OnClickShare(nil)
		end)
	end

	self.buttonSave_.onClick:AddListener(function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.SaveScreenShot(self.screenSnapPath_)
		else
			LuaForUtil.SavePhotoToAlbum(self.screenSnapPath_)
		end

		if CaptureGameMgr:IsInCaptureGame() then
			CaptureGameTools:SendShareSdk(6, 2)
		end
	end)
	self.buttonPath_.onClick:AddListener(function()
		LuaForUtil.OpenScreenShotFolder()
	end)
end

function ShareMgr:RemoveListeners()
	self.buttonCancel_.onClick:RemoveAllListeners()
	self.buttonQQ_.onClick:RemoveAllListeners()
	self.buttonQQZone_.onClick:RemoveAllListeners()
	self.buttonWechat_.onClick:RemoveAllListeners()
	self.buttonWechatMoments_.onClick:RemoveAllListeners()
	self.buttonWeibo_.onClick:RemoveAllListeners()
	self.buttonTwiiter_.onClick:RemoveAllListeners()
	self.buttonSave_.onClick:RemoveAllListeners()
	self.buttonPath_.onClick:RemoveAllListeners()
end

function ShareMgr:OnClickClose()
	SetActive(self.gameObject_, false)

	self.screenSnap_ = nil
	self.screenSnap2_ = nil
	self.shareCallback_ = nil
end

function ShareMgr:OnClickShare(arg_22_1)
	if GameToSDK.IsEditorOrPcPlatform() then
		ShowTips("USE_MOBILE")

		return
	end

	local var_22_0 = GetTips("SHARE_TITLE")
	local var_22_1 = GetTips("SHARE_CONTENT")
	local var_22_2 = GetTips("SHARE_URL")

	if CaptureGameMgr:IsInCaptureGame() then
		self.paltform_ = arg_22_1

		CaptureGameTools:SendShareSdk(SDKTools.PlatformStrToId(arg_22_1), 1)
	else
		self.paltform_ = arg_22_1

		SendMessageToSDK((cjson.encode({
			imageUrl = "",
			messageType = var_22_4,
			url = var_22_2,
			title = var_22_0,
			content = var_22_1,
			imagePath = self.screenSnapPath_,
			platform = arg_22_1
		})))
	end
end

function ShareMgr:ShareCallback(arg_23_1)
	if arg_23_1 == 0 then
		if self.shareCallback_ then
			self.shareCallback_()
		end
	elseif arg_23_1 == 2 then
		-- block empty
	end
end

function ShareMgr:Dispose()
	self.isInit = false

	if self.shareLogoView_ then
		self.shareLogoView_:Dispose()

		self.shareLogoView_ = nil
	end

	if self.gameObject_ then
		manager.notify:RemoveListener(SHARE_CALLBACK, self.shareCallbackHandler_)

		self.shareCallbackHandler_ = nil

		self:RemoveListeners()
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
		self.transform_ = nil
	end
end

return ShareMgr

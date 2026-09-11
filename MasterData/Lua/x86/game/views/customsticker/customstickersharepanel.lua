local cjson = require("cjson")
local CustomStickerSharePanel = class("CustomStickerSharePanel", ReduxView)

function CustomStickerSharePanel:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onClose_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
end

function CustomStickerSharePanel:OnSnape(arg_2_1)
	local var_2_0, var_2_1 = SettingTools.GetSettingScreenSize((tonumber(SettingData:GetSettingData().pic.resolution)))

	if not SDKTools.IsSDK() then
		var_2_1 = _G.SCREEN_HEIGHT
		var_2_0 = _G.SCREEN_WIDTH
	end

	self.screenSnapPath_ = manager.share:SaveTexture()
	self.screenSnap_ = ScreenSnap.New(var_2_0, var_2_1)

	self.screenSnap_:Take()

	self.imageShot_.sprite = self.screenSnap_:GetSprite()

	self.screenSnap_:SaveSnap(self.screenSnapPath_)
	SetActive(self.gameObject_, true)
end

function CustomStickerSharePanel:OnEnter()
	if not SDKTools.GetIsOverSea() then
		SetActive(self.buttonTwiiter_.transform.gameObject, false)

		if GameToSDK.PLATFORM_ID == 4 then
			SetActive(self.buttonWechat_.transform.gameObject, false)
			SetActive(self.buttonWeibo_.transform.gameObject, false)
			SetActive(self.buttonQQ_.transform.gameObject, false)
			SetActive(self.buttonQQZone_.transform.gameObject, false)
			SetActive(self.buttonWechatMoments_.transform.gameObject, false)
		end
	else
		SetActive(self.buttonQQ_.transform.gameObject, false)
		SetActive(self.buttonQQZone_.transform.gameObject, false)
		SetActive(self.buttonWechat_.transform.gameObject, false)
		SetActive(self.buttonWeibo_.transform.gameObject, false)
		SetActive(self.buttonWechatMoments_.transform.gameObject, false)
		SetActive(self.buttonTwiiter_.transform.gameObject, true)
	end
end

function CustomStickerSharePanel:OnExit()
	self.screenSnap_ = nil
end

function CustomStickerSharePanel:Dispose()
	CustomStickerSharePanel.super.Dispose(self)
end

function CustomStickerSharePanel:AddListeners()
	self:AddBtnListener(self.buttonCancel_, nil, function()
		if self.onClose_ then
			self.onClose_()
		end

		SetActive(self.gameObject_, false)
	end)
	self:AddBtnListener(self.buttonQQ_, nil, function()
		self:Share("QQ")
	end)
	self:AddBtnListener(self.buttonQQZone_, nil, function()
		self:Share("QZone")
	end)
	self:AddBtnListener(self.buttonWechat_, nil, function()
		self:Share("Wechat")
	end)
	self:AddBtnListener(self.buttonWechatMoments_, nil, function()
		self:Share("WechatMoments")
	end)
	self:AddBtnListener(self.buttonWeibo_, nil, function()
		self:Share("SinaWeibo")
	end)
	self:AddBtnListener(self.buttonTwiiter_, nil, function()
		self:Share(nil)
	end)
	self:AddBtnListener(self.buttonSave_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.SaveScreenShot(self.screenSnapPath_)
		else
			local var_14_0 = manager.share:SaveTexture()

			self.screenSnap_:SaveSnap(var_14_0)
			LuaForUtil.SavePhotoToAlbum(var_14_0)
		end
	end)
end

function CustomStickerSharePanel:Share(arg_15_1)
	local var_15_2
	local var_15_0

	if not SDKTools.IsSDK() then
		ShowTips("SHARE_PLATFORM")

		do return end

		var_15_0 = GetTips("SHARE_CONTENT")
		var_15_2 = {
			imageUrl = "",
			messageType = arg_15_1 == nil and "Share" or "ShareWithPlatform",
			url = GetTips("SHARE_URL")
		}
	end

	var_15_2.title = GetTips("SHARE_TITLE")
	var_15_2.content = var_15_0
	var_15_2.imagePath = self.screenSnapPath_
	var_15_2.platform = arg_15_1
	self.paltform_ = arg_15_1

	SendMessageToSDK((cjson.encode(var_15_2)))
end

return CustomStickerSharePanel

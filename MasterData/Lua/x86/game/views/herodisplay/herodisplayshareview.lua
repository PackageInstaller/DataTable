local cjson = require("cjson")
local HeroDisplayShareView = class("HeroDisplayShareView", ReduxView)

function HeroDisplayShareView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.shareCallbackHandler_ = handler(self, self.ShareCallback)
end

function HeroDisplayShareView:SetData(arg_2_1, arg_2_2, arg_2_3)
	self.heroId_ = arg_2_1
	self.showWeapon_ = arg_2_2
	self.posIndex_ = arg_2_3
end

function HeroDisplayShareView:OnSnape(arg_3_1)
	local var_3_0

	if GameToSDK.PLATFORM_ID == 3 then
		-- block empty
	else
		var_3_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	end

	local var_3_1, var_3_2 = SettingTools.GetSettingScreenSize(var_3_0)

	if not SDKTools.IsSDK() then
		var_3_2 = _G.SCREEN_HEIGHT
		var_3_1 = _G.SCREEN_WIDTH
	end

	self.screenSnap_ = arg_3_1 and ScreenSnap.New(var_3_1, var_3_2) or ScreenSnap.New(var_3_2, var_3_1)

	self.screenSnap_:Take()

	local var_3_3 = self.screenSnap_:GetSprite()

	if GameToSDK.IsPCPlatform() then
		SetActive(self.imageShotGo_, false)
		SetActive(self.imageShotGoPc_, true)

		self.imageShotPc_.sprite = var_3_3
	else
		SetActive(self.imageShotGo_, true)
		SetActive(self.imageShotGoPc_, false)

		self.imageShot_.sprite = var_3_3
	end

	self.imageBg_.sprite = var_3_3
	self.screenSnapPath_ = manager.share:SaveTexture()

	self.screenSnap_:SaveSnap(self.screenSnapPath_)
	SetActive(self.gameObject_, true)
end

function HeroDisplayShareView:OnEnter()
	print("分享功能差异化")

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

	SetActive(self.buttonPath_.transform.gameObject, GameToSDK.IsEditorOrPcPlatform())
	manager.notify:RegistListener(SHARE_CALLBACK, self.shareCallbackHandler_)
end

function HeroDisplayShareView:OnExit()
	manager.notify:RemoveListener(SHARE_CALLBACK, self.shareCallbackHandler_)

	self.screenSnap_ = nil
end

function HeroDisplayShareView:ExitPanel()
	if self.exitViewFunc then
		self.exitViewFunc()
	end

	SetActive(self.gameObject_, false)
end

function HeroDisplayShareView:Dispose()
	HeroDisplayShareView.super.Dispose(self)

	self.shareCallbackHandler_ = nil
end

function HeroDisplayShareView:AddListeners()
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:ExitPanel()
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
			local var_16_0 = manager.share:SaveTexture()

			self.screenSnap_:SaveSnap(var_16_0)
			LuaForUtil.SavePhotoToAlbum(var_16_0)
		end
	end)
	self:AddBtnListener(self.buttonPath_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.OpenScreenShotFolder()
		end
	end)
end

function HeroDisplayShareView:Share(arg_18_1)
	local var_18_2
	local var_18_0

	if GameToSDK.IsEditorOrPcPlatform() then
		ShowTips("SHARE_PLATFORM")

		do return end

		var_18_0 = GetTips("SHARE_CONTENT")
		var_18_2 = {
			imageUrl = "",
			messageType = arg_18_1 == nil and "Share" or "ShareWithPlatform",
			url = GetTips("SHARE_URL")
		}
	end

	var_18_2.title = GetTips("SHARE_TITLE")
	var_18_2.content = var_18_0
	var_18_2.imagePath = self.screenSnapPath_
	var_18_2.platform = arg_18_1
	self.paltform_ = arg_18_1

	SendMessageToSDK((cjson.encode(var_18_2)))
end

function HeroDisplayShareView:ShareCallback(arg_19_1)
	if arg_19_1 == 0 then
		self:SendToSDK(self.paltform_)
	elseif arg_19_1 == 2 then
		-- block empty
	end
end

function HeroDisplayShareView:SendToSDK(arg_20_1)
	if self.heroId_ then
		SDKTools.SendMessageToSDK("screenshot", {
			screenshot_oper = 2,
			hero_id = self.heroId_,
			weapon_on = (self.showWeapon_ and HeroDisplayData:GetHeroPoseList(self.heroId_)[self.posIndex_].weaponState ~= HeroDisplayConst.WEAPON_STATE.HIDE_WEAPON or nil) and 1,
			posture_id = self.posIndex_,
			logo_location = HeroDisplayData.settingProfile_.logoPos == 0 and 2 or HeroDisplayData.settingProfile_.logoPos,
			card_show = HeroDisplayData.settingProfile_.cardShow and 1 or 0,
			card_location = HeroDisplayData.settingProfile_.cardPos == 0 and 1 or HeroDisplayData.settingProfile_.cardPos,
			lv_show = HeroDisplayData.settingProfile_.cardShowLv and 1 or 0,
			uid_show = HeroDisplayData.settingProfile_.cardShowUID and 1 or 0,
			share_channel = SDKTools.PlatformStrToId(arg_20_1)
		})
	end
end

function HeroDisplayShareView:ExitViewCallBack(arg_21_1)
	if arg_21_1 then
		self.exitViewFunc = arg_21_1
	end
end

return HeroDisplayShareView

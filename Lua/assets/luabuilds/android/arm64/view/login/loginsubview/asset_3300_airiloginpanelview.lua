local AiriLoginPanelView = class("AiriLoginPanelView", import("...base.BaseSubView"))

function AiriLoginPanelView:getUIName()
	return "AiriLoginPanelView"
end

function AiriLoginPanelView:OnLoaded()
	return
end

function AiriLoginPanelView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function AiriLoginPanelView:OnInit()
	self.airijpPanel = self._tf
	self.airiLoginBtn = self.airijpPanel:Find("airi_login")
	self.clearTranscodeBtn = self.airijpPanel:Find("clear_transcode")
	self.jpLoginCon = self.airijpPanel:Find("jp_login_btns")
	self.jpYoStarLoginBtn = self.jpLoginCon:Find("yostar_login")
	self.jpTransBtn = self.jpLoginCon:Find("yostar_trans")
	self.enLoginCon = self.airijpPanel:Find("en_login_btns")
	self.twitterLoginBtn_en = self.enLoginCon:Find("twitter_login_en")
	self.facebookLoginBtn_en = self.enLoginCon:Find("facebook_login_en")
	self.yostarLoginBtn_en = self.enLoginCon:Find("yostar_login_en")
	self.appleLoginBtn_en = self.enLoginCon:Find("apple_login_en")
	self.amazonLoginBtn_en = self.enLoginCon:Find("amazon_login_en")

	setActive(self.clearTranscodeBtn, false)
	setText(self.jpYoStarLoginBtn:Find("Text"), i18n("yostar_login_btn"))
	setText(self.jpTransBtn:Find("Text"), i18n("yostar_trans_btn"))
	setActive(self.jpYoStarLoginBtn, PLATFORM_CODE == PLATFORM_JP)
	setActive(self.jpTransBtn, PLATFORM_CODE == PLATFORM_JP)
	setActive(self.twitterLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

	local var_4_0 = setActive
	local var_4_1 = self.facebookLoginBtn_en
	local var_4_2

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() == "3" then
			var_4_2 = false

			goto label_4_0
		end
	end

	::label_4_0::

	var_4_0(var_4_1, true)
	setActive(self.yostarLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

	local var_4_3 = setActive
	local var_4_4 = self.appleLoginBtn_en
	local var_4_5

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "1" then
			var_4_5 = false

			goto label_4_1
		end
	end

	::label_4_1::

	var_4_3(var_4_4, true)

	local var_4_6 = setActive
	local var_4_7 = self.amazonLoginBtn_en
	local var_4_8

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "3" then
			var_4_8 = false

			goto label_4_2
		end
	end

	::label_4_2::

	var_4_6(var_4_7, true)
	self:InitEvent()

	return
end

function AiriLoginPanelView:InitEvent()
	onButton(self, self.airiLoginBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		pg.SdkMgr.GetInstance():YoStarLoginSDK()

		return
	end)
	onButton(self, self.clearTranscodeBtn, function()
		return
	end)
	onButton(self, self.jpYoStarLoginBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		pg.SdkMgr.GetInstance():YoStarLoginSDK()

		return
	end)
	onButton(self, self.jpTransBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		Application.OpenURL("https://migration.yostar.co.jp?pid=JP-AZURLANE")

		return
	end)
	onButton(self, self.twitterLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_TWITTER)

		return
	end)
	onButton(self, self.facebookLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_FACEBOOK)

		return
	end)
	onButton(self, self.yostarLoginBtn_en, function()
		self:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.YOSTAR_ALERT_VIEW,
			LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN
		})

		return
	end)
	onButton(self, self.appleLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_APPLE)

		return
	end)
	onButton(self, self.amazonLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_AMAZON)

		return
	end)
	triggerButton(self.airiLoginBtn)

	return
end

function AiriLoginPanelView:OnDestroy()
	return
end

return AiriLoginPanelView

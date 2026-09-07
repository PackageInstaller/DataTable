local AiriUSLoginPanelView = class("AiriUSLoginPanelView", import("...base.BaseSubView"))

function AiriUSLoginPanelView:getUIName()
	return "AiriUSLoginPanelView"
end

function AiriUSLoginPanelView:OnLoaded()
	return
end

function AiriUSLoginPanelView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function AiriUSLoginPanelView:OnInit()
	self.airijpPanel = self._tf
	self.airiLoginBtn = self.airijpPanel:Find("airi_login")
	self.clearTranscodeBtn = self.airijpPanel:Find("clear_transcode")
	self.jpLoginCon = self.airijpPanel:Find("jp_login_btns")
	self.appleLoginBtn = self.jpLoginCon:Find("apple_login")
	self.amazonLoginBtn = self.jpLoginCon:Find("amazon_login")
	self.twitterLoginBtn = self.jpLoginCon:Find("twitter_login")
	self.transcodeLoginBtn = self.jpLoginCon:Find("transcode_login")
	self.touristLoginBtn = self.jpLoginCon:Find("tourist_login")
	self.yostarLoginBtn = self.jpLoginCon:Find("yostar_login")
	self.firstAlertWin = self.airijpPanel:Find("empty_alert")
	self.appleToggleTf = self.firstAlertWin:Find("window/content_bg/apple_toggle")
	self.amazonToggleTf = self.firstAlertWin:Find("window/content_bg/amazon_toggle")
	self.twitterToggleTf = self.firstAlertWin:Find("window/content_bg/twitter_toggle")
	self.transcodeToggleTf = self.firstAlertWin:Find("window/content_bg/transcode_toggle")
	self.touristToggleTf = self.firstAlertWin:Find("window/content_bg/tourist_toggle")
	self.yostarToggleTf = self.firstAlertWin:Find("window/content_bg/yostar_toggle")
	self.alertCloseBtn = self.firstAlertWin:Find("window/top/btnBack")
	self.alertCancelBtn = self.firstAlertWin:Find("window/button_container/custom_button_2")
	self.alertSureBtn = self.firstAlertWin:Find("window/button_container/custom_button_1")
	self.enLoginCon = self.airijpPanel:Find("en_login_btns")
	self.twitterLoginBtn_en = self.enLoginCon:Find("twitter_login_en")
	self.facebookLoginBtn_en = self.enLoginCon:Find("facebook_login_en")
	self.yostarLoginBtn_en = self.enLoginCon:Find("yostar_login_en")
	self.appleLoginBtn_en = self.enLoginCon:Find("apple_login_en")
	self.amazonLoginBtn_en = self.enLoginCon:Find("amazon_login_en")

	setActive(self.clearTranscodeBtn, not LOCK_CLEAR_ACCOUNT)
	setActive(self.transcodeLoginBtn, PLATFORM_CODE == PLATFORM_JP)
	setActive(self.touristLoginBtn, false)
	setActive(self.yostarLoginBtn, PLATFORM_CODE == PLATFORM_JP)

	local var_4_0 = setActive
	local var_4_1 = self.appleLoginBtn
	local var_4_2

	if PLATFORM_CODE == PLATFORM_JP then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "1" then
			var_4_2 = false

			goto label_4_0
		end
	end

	::label_4_0::

	var_4_0(var_4_1, true)

	local var_4_3 = setActive
	local var_4_4 = self.appleToggleTf
	local var_4_5

	if PLATFORM_CODE == PLATFORM_JP then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "1" then
			var_4_5 = false

			goto label_4_1
		end
	end

	::label_4_1::

	var_4_3(var_4_4, true)

	local var_4_6 = setActive
	local var_4_7 = self.amazonLoginBtn
	local var_4_8

	if PLATFORM_CODE == PLATFORM_JP then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "3" then
			var_4_8 = false

			goto label_4_2
		end
	end

	::label_4_2::

	var_4_6(var_4_7, true)

	local var_4_9 = setActive
	local var_4_10 = self.amazonToggleTf
	local var_4_11

	if PLATFORM_CODE == PLATFORM_JP then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "3" then
			var_4_11 = false

			goto label_4_3
		end
	end

	::label_4_3::

	var_4_9(var_4_10, true)

	if PLATFORM_CODE == PLATFORM_JP then
		setActive(self.firstAlertWin, false)
	end

	setActive(self.twitterLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

	local var_4_12 = setActive
	local var_4_13 = self.facebookLoginBtn_en
	local var_4_14

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() == "3" then
			var_4_14 = false

			goto label_4_4
		end
	end

	::label_4_4::

	var_4_12(var_4_13, true)
	setActive(self.yostarLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

	local var_4_15 = setActive
	local var_4_16 = self.appleLoginBtn_en
	local var_4_17

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "1" then
			var_4_17 = false

			goto label_4_5
		end
	end

	::label_4_5::

	var_4_15(var_4_16, true)

	local var_4_18 = setActive
	local var_4_19 = self.amazonLoginBtn_en
	local var_4_20

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "3" then
			var_4_20 = false

			goto label_4_6
		end
	end

	::label_4_6::

	var_4_18(var_4_19, true)
	setActive(self.clearTranscodeBtn, PLATFORM_CODE ~= PLATFORM_US)
	setActive(self.twitterLoginBtn, false)
	setActive(self.twitterToggleTf, false)
	self:InitEvent()

	return
end

function AiriUSLoginPanelView:InitEvent()
	local function var_5_0()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.firstAlertWin, self.airijpPanel)
		setActive(self.firstAlertWin, false)

		return
	end

	local function var_5_1()
		if not pg.SdkMgr.GetInstance():CheckHadAccountCache() then
			setActive(self.firstAlertWin, true)
			pg.UIMgr.GetInstance():BlurPanel(self.firstAlertWin)

			return true
		end

		return false
	end

	onButton(self, self.airiLoginBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)

		if getProxy(SettingsProxy):CheckNeedUserAgreement() then
			self.event:emit(LoginMediator.ON_LOGIN_PROCESS)
		elseif not var_5_1() then
			pg.SdkMgr.GetInstance():AiriLoginSDK()
		end

		return
	end)
	onButton(self, self.clearTranscodeBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("clear_transcode_cache_confirm"),
			onYes = function()
				ClearAccountCache()

				local var_10_0 = getProxy(SettingsProxy)

				var_10_0:deleteUserAreement()
				var_10_0:clearAllReadHelp()
				self.event:emit(LoginMediator.ON_LOGIN_PROCESS)
				pg.TipsMgr.GetInstance():ShowTips(i18n("clear_transcode_cache_success"))

				return
			end,
			onNo = function()
				return
			end
		})

		return
	end)
	onButton(self, self.appleLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_APPLE)

		return
	end)
	onButton(self, self.amazonLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_AMAZON)

		return
	end)
	onButton(self, self.yostarLoginBtn, function()
		self:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.YOSTAR_ALERT_VIEW,
			LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN
		})

		return
	end)
	onButton(self, self.transcodeLoginBtn, function()
		self:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.TRANSCODE_ALERT_VIEW,
			LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN
		})

		return
	end)
	onButton(self, self.touristLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginWithDevice()

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
	var_5_1()
	onButton(self, self.alertCloseBtn, function()
		var_5_0()

		return
	end)
	onButton(self, self.alertCancelBtn, function()
		var_5_0()

		return
	end)
	onButton(self, self.alertSureBtn, function()
		local var_24_0 = getToggleState(self.twitterToggleTf)

		if false then
			pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_TWITTER)
		elseif getToggleState(self.transcodeToggleTf) then
			self:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
				LoginSceneConst.DEFINE.TRANSCODE_ALERT_VIEW,
				LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
				LoginSceneConst.DEFINE.PRESS_TO_LOGIN
			})
		elseif getToggleState(self.touristToggleTf) then
			pg.SdkMgr.GetInstance():LoginWithDevice()
		elseif getToggleState(self.appleToggleTf) then
			pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_APPLE)
		elseif getToggleState(self.amazonToggleTf) then
			pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_AMAZON)
		elseif getToggleState(self.yostarToggleTf) then
			self:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
				LoginSceneConst.DEFINE.YOSTAR_ALERT_VIEW,
				LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
				LoginSceneConst.DEFINE.PRESS_TO_LOGIN
			})
		end

		var_5_0()

		return
	end)

	return
end

function AiriUSLoginPanelView:OnDestroy()
	return
end

return AiriUSLoginPanelView

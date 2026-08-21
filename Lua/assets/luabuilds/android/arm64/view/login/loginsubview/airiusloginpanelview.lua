local var_0_0 = class("AiriUSLoginPanelView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "AiriUSLoginPanelView"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.airijpPanel = arg_4_0._tf
	arg_4_0.airiLoginBtn = arg_4_0.airijpPanel:Find("airi_login")
	arg_4_0.clearTranscodeBtn = arg_4_0.airijpPanel:Find("clear_transcode")
	arg_4_0.jpLoginCon = arg_4_0.airijpPanel:Find("jp_login_btns")
	arg_4_0.appleLoginBtn = arg_4_0.jpLoginCon:Find("apple_login")
	arg_4_0.amazonLoginBtn = arg_4_0.jpLoginCon:Find("amazon_login")
	arg_4_0.twitterLoginBtn = arg_4_0.jpLoginCon:Find("twitter_login")
	arg_4_0.transcodeLoginBtn = arg_4_0.jpLoginCon:Find("transcode_login")
	arg_4_0.touristLoginBtn = arg_4_0.jpLoginCon:Find("tourist_login")
	arg_4_0.yostarLoginBtn = arg_4_0.jpLoginCon:Find("yostar_login")
	arg_4_0.firstAlertWin = arg_4_0.airijpPanel:Find("empty_alert")
	arg_4_0.appleToggleTf = arg_4_0.firstAlertWin:Find("window/content_bg/apple_toggle")
	arg_4_0.amazonToggleTf = arg_4_0.firstAlertWin:Find("window/content_bg/amazon_toggle")
	arg_4_0.twitterToggleTf = arg_4_0.firstAlertWin:Find("window/content_bg/twitter_toggle")
	arg_4_0.transcodeToggleTf = arg_4_0.firstAlertWin:Find("window/content_bg/transcode_toggle")
	arg_4_0.touristToggleTf = arg_4_0.firstAlertWin:Find("window/content_bg/tourist_toggle")
	arg_4_0.yostarToggleTf = arg_4_0.firstAlertWin:Find("window/content_bg/yostar_toggle")
	arg_4_0.alertCloseBtn = arg_4_0.firstAlertWin:Find("window/top/btnBack")
	arg_4_0.alertCancelBtn = arg_4_0.firstAlertWin:Find("window/button_container/custom_button_2")
	arg_4_0.alertSureBtn = arg_4_0.firstAlertWin:Find("window/button_container/custom_button_1")
	arg_4_0.enLoginCon = arg_4_0.airijpPanel:Find("en_login_btns")
	arg_4_0.twitterLoginBtn_en = arg_4_0.enLoginCon:Find("twitter_login_en")
	arg_4_0.facebookLoginBtn_en = arg_4_0.enLoginCon:Find("facebook_login_en")
	arg_4_0.yostarLoginBtn_en = arg_4_0.enLoginCon:Find("yostar_login_en")
	arg_4_0.appleLoginBtn_en = arg_4_0.enLoginCon:Find("apple_login_en")
	arg_4_0.amazonLoginBtn_en = arg_4_0.enLoginCon:Find("amazon_login_en")

	setActive(arg_4_0.clearTranscodeBtn, not LOCK_CLEAR_ACCOUNT)
	setActive(arg_4_0.transcodeLoginBtn, PLATFORM_CODE == PLATFORM_JP)
	setActive(arg_4_0.touristLoginBtn, false)
	setActive(arg_4_0.yostarLoginBtn, PLATFORM_CODE == PLATFORM_JP)

	local var_4_1 = arg_4_0.appleLoginBtn

	if PLATFORM_CODE == PLATFORM_JP then
		local var_4_2 = pg.SdkMgr.GetInstance():GetChannelUID() == "1"

		var_4_0(var_4_1, var_4_2)

		local var_4_4 = arg_4_0.appleToggleTf

		if PLATFORM_CODE == PLATFORM_JP then
			local var_4_5 = pg.SdkMgr.GetInstance():GetChannelUID() == "1"

			var_4_3(var_4_4, var_4_5)

			local var_4_7 = arg_4_0.amazonLoginBtn

			if PLATFORM_CODE == PLATFORM_JP then
				local var_4_8 = pg.SdkMgr.GetInstance():GetChannelUID() == "3"

				var_4_6(var_4_7, var_4_8)

				local var_4_10 = arg_4_0.amazonToggleTf

				if PLATFORM_CODE == PLATFORM_JP then
					local var_4_11 = pg.SdkMgr.GetInstance():GetChannelUID() == "3"

					var_4_9(var_4_10, var_4_11)

					if PLATFORM_CODE == PLATFORM_JP then
						setActive(arg_4_0.firstAlertWin, false)
					end

					setActive(arg_4_0.twitterLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

					local var_4_13 = arg_4_0.facebookLoginBtn_en

					if PLATFORM_CODE == PLATFORM_US then
						local var_4_14 = pg.SdkMgr.GetInstance():GetChannelUID() ~= "3"

						var_4_12(var_4_13, var_4_14)
						setActive(arg_4_0.yostarLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

						local var_4_16 = arg_4_0.appleLoginBtn_en

						if PLATFORM_CODE == PLATFORM_US then
							local var_4_17 = pg.SdkMgr.GetInstance():GetChannelUID() == "1"

							var_4_15(var_4_16, var_4_17)

							local var_4_19 = arg_4_0.amazonLoginBtn_en

							if PLATFORM_CODE == PLATFORM_US then
								local var_4_20 = pg.SdkMgr.GetInstance():GetChannelUID() == "3"

								var_4_18(var_4_19, var_4_20)
								setActive(arg_4_0.clearTranscodeBtn, PLATFORM_CODE ~= PLATFORM_US)
								setActive(arg_4_0.twitterLoginBtn, false)
								setActive(arg_4_0.twitterToggleTf, false)
								arg_4_0:InitEvent()

								return
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.InitEvent(arg_5_0)
	local function var_5_0()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_5_0.firstAlertWin, arg_5_0.airijpPanel)
		setActive(arg_5_0.firstAlertWin, false)

		return
	end

	local function var_5_1()
		if not pg.SdkMgr.GetInstance():CheckHadAccountCache() then
			setActive(arg_5_0.firstAlertWin, true)
			pg.UIMgr.GetInstance():BlurPanel(arg_5_0.firstAlertWin)

			return true
		end

		return false
	end

	onButton(arg_5_0, arg_5_0.airiLoginBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)

		if getProxy(SettingsProxy):CheckNeedUserAgreement() then
			arg_5_0.event:emit(LoginMediator.ON_LOGIN_PROCESS)
		elseif not var_5_1() then
			pg.SdkMgr.GetInstance():AiriLoginSDK()
		end

		return
	end)
	onButton(arg_5_0, arg_5_0.clearTranscodeBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("clear_transcode_cache_confirm"),
			onYes = function()
				ClearAccountCache()

				local var_10_0 = getProxy(SettingsProxy)

				var_10_0:deleteUserAreement()
				var_10_0:clearAllReadHelp()
				arg_5_0.event:emit(LoginMediator.ON_LOGIN_PROCESS)
				pg.TipsMgr.GetInstance():ShowTips(i18n("clear_transcode_cache_success"))

				return
			end,
			onNo = function()
				return
			end
		})

		return
	end)
	onButton(arg_5_0, arg_5_0.appleLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_APPLE)

		return
	end)
	onButton(arg_5_0, arg_5_0.amazonLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_AMAZON)

		return
	end)
	onButton(arg_5_0, arg_5_0.yostarLoginBtn, function()
		arg_5_0:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.YOSTAR_ALERT_VIEW,
			LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN
		})

		return
	end)
	onButton(arg_5_0, arg_5_0.transcodeLoginBtn, function()
		arg_5_0:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.TRANSCODE_ALERT_VIEW,
			LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN
		})

		return
	end)
	onButton(arg_5_0, arg_5_0.touristLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginWithDevice()

		return
	end)
	onButton(arg_5_0, arg_5_0.twitterLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_TWITTER)

		return
	end)
	onButton(arg_5_0, arg_5_0.facebookLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_FACEBOOK)

		return
	end)
	onButton(arg_5_0, arg_5_0.yostarLoginBtn_en, function()
		arg_5_0:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.YOSTAR_ALERT_VIEW,
			LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN
		})

		return
	end)
	onButton(arg_5_0, arg_5_0.appleLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_APPLE)

		return
	end)
	onButton(arg_5_0, arg_5_0.amazonLoginBtn_en, function()
		pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_AMAZON)

		return
	end)
	;(function()
		if not pg.SdkMgr.GetInstance():CheckHadAccountCache() then
			setActive(arg_5_0.firstAlertWin, true)
			pg.UIMgr.GetInstance():BlurPanel(arg_5_0.firstAlertWin)

			return true
		end

		return false
	end)()
	onButton(arg_5_0, arg_5_0.alertCloseBtn, function()
		var_5_0()

		return
	end)
	onButton(arg_5_0, arg_5_0.alertCancelBtn, function()
		var_5_0()

		return
	end)
	onButton(arg_5_0, arg_5_0.alertSureBtn, function()
		local var_24_0 = getToggleState(arg_5_0.twitterToggleTf)

		if false then
			pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_TWITTER)
		elseif getToggleState(arg_5_0.transcodeToggleTf) then
			arg_5_0:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
				LoginSceneConst.DEFINE.TRANSCODE_ALERT_VIEW,
				LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
				LoginSceneConst.DEFINE.PRESS_TO_LOGIN
			})
		elseif getToggleState(arg_5_0.touristToggleTf) then
			pg.SdkMgr.GetInstance():LoginWithDevice()
		elseif getToggleState(arg_5_0.appleToggleTf) then
			pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_APPLE)
		elseif getToggleState(arg_5_0.amazonToggleTf) then
			pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_AMAZON)
		elseif getToggleState(arg_5_0.yostarToggleTf) then
			arg_5_0:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
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

function var_0_0.OnDestroy(arg_25_0)
	return
end

return var_0_0

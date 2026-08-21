local var_0_0 = class("AiriLoginPanelView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "AiriLoginPanelView"
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
	arg_4_0.jpYoStarLoginBtn = arg_4_0.jpLoginCon:Find("yostar_login")
	arg_4_0.jpTransBtn = arg_4_0.jpLoginCon:Find("yostar_trans")
	arg_4_0.enLoginCon = arg_4_0.airijpPanel:Find("en_login_btns")
	arg_4_0.twitterLoginBtn_en = arg_4_0.enLoginCon:Find("twitter_login_en")
	arg_4_0.facebookLoginBtn_en = arg_4_0.enLoginCon:Find("facebook_login_en")
	arg_4_0.yostarLoginBtn_en = arg_4_0.enLoginCon:Find("yostar_login_en")
	arg_4_0.appleLoginBtn_en = arg_4_0.enLoginCon:Find("apple_login_en")
	arg_4_0.amazonLoginBtn_en = arg_4_0.enLoginCon:Find("amazon_login_en")

	setActive(arg_4_0.clearTranscodeBtn, false)
	setText(arg_4_0.jpYoStarLoginBtn:Find("Text"), i18n("yostar_login_btn"))
	setText(arg_4_0.jpTransBtn:Find("Text"), i18n("yostar_trans_btn"))
	setActive(arg_4_0.jpYoStarLoginBtn, PLATFORM_CODE == PLATFORM_JP)
	setActive(arg_4_0.jpTransBtn, PLATFORM_CODE == PLATFORM_JP)
	setActive(arg_4_0.twitterLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

	local var_4_1 = arg_4_0.facebookLoginBtn_en

	if PLATFORM_CODE == PLATFORM_US then
		local var_4_2 = pg.SdkMgr.GetInstance():GetChannelUID() ~= "3"

		var_4_0(var_4_1, var_4_2)
		setActive(arg_4_0.yostarLoginBtn_en, PLATFORM_CODE == PLATFORM_US)

		local var_4_4 = arg_4_0.appleLoginBtn_en

		if PLATFORM_CODE == PLATFORM_US then
			local var_4_5 = pg.SdkMgr.GetInstance():GetChannelUID() == "1"

			var_4_3(var_4_4, var_4_5)

			local var_4_7 = arg_4_0.amazonLoginBtn_en

			if PLATFORM_CODE == PLATFORM_US then
				local var_4_8 = pg.SdkMgr.GetInstance():GetChannelUID() == "3"

				var_4_6(var_4_7, var_4_8)
				arg_4_0:InitEvent()

				return
			end
		end
	end
end

function var_0_0.InitEvent(arg_5_0)
	onButton(arg_5_0, arg_5_0.airiLoginBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		pg.SdkMgr.GetInstance():YoStarLoginSDK()

		return
	end)
	onButton(arg_5_0, arg_5_0.clearTranscodeBtn, function()
		return
	end)
	onButton(arg_5_0, arg_5_0.jpYoStarLoginBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		pg.SdkMgr.GetInstance():YoStarLoginSDK()

		return
	end)
	onButton(arg_5_0, arg_5_0.jpTransBtn, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		Application.OpenURL("https://migration.yostar.co.jp?pid=JP-AZURLANE")

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
	triggerButton(arg_5_0.airiLoginBtn)

	return
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

return var_0_0

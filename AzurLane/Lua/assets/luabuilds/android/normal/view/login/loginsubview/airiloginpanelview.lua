class = var_0_10000

local var_0_0 = "AiriLoginPanelView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "AiriLoginPanelView"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.airijpPanel = arg_4_0._tf

	local var_4_0 = arg_4_0.airijpPanel

	arg_4_0.airiLoginBtn = var_1.Find(var_4_0, "airi_login")

	local var_4_1 = arg_4_0.airijpPanel

	arg_4_0.clearTranscodeBtn = var_1.Find(var_4_1, "clear_transcode")

	local var_4_2 = arg_4_0.airijpPanel

	arg_4_0.jpLoginCon = var_1.Find(var_4_2, "jp_login_btns")

	local var_4_3 = arg_4_0.jpLoginCon

	arg_4_0.jpYoStarLoginBtn = var_1.Find(var_4_3, "yostar_login")

	local var_4_4 = arg_4_0.jpLoginCon

	arg_4_0.jpTransBtn = var_1.Find(var_4_4, "yostar_trans")

	local var_4_5 = arg_4_0.airijpPanel

	arg_4_0.enLoginCon = var_1.Find(var_4_5, "en_login_btns")

	local var_4_6 = arg_4_0.enLoginCon

	arg_4_0.twitterLoginBtn_en = var_1.Find(var_4_6, "twitter_login_en")

	local var_4_7 = arg_4_0.enLoginCon

	arg_4_0.facebookLoginBtn_en = var_1.Find(var_4_7, "facebook_login_en")

	local var_4_8 = arg_4_0.enLoginCon

	arg_4_0.yostarLoginBtn_en = var_1.Find(var_4_8, "yostar_login_en")

	local var_4_9 = arg_4_0.enLoginCon

	arg_4_0.appleLoginBtn_en = var_1.Find(var_4_9, "apple_login_en")

	local var_4_10 = arg_4_0.enLoginCon

	arg_4_0.amazonLoginBtn_en = var_1.Find(var_4_10, "amazon_login_en")
	setActive = var_1

	var_1(arg_4_0.clearTranscodeBtn, false)

	setText = var_1

	local var_4_11 = arg_4_0.jpYoStarLoginBtn
	local var_4_12 = var_2.Find(var_4_11, "Text")

	i18n = var_4_11

	var_1(var_4_12, var_4_11("yostar_login_btn"))

	setText = var_1

	local var_4_13 = arg_4_0.jpTransBtn
	local var_4_14 = var_2.Find(var_4_13, "Text")

	i18n = var_4_13

	var_1(var_4_14, var_4_13("yostar_trans_btn"))

	setActive = var_1

	local var_4_15 = arg_4_0.jpYoStarLoginBtn

	PLATFORM_CODE = var_3
	PLATFORM_JP = var_4_19

	var_1(var_4_15, var_3 == var_4_19)

	setActive = var_1

	local var_4_16 = arg_4_0.jpTransBtn

	PLATFORM_CODE = var_3
	PLATFORM_JP = var_4_19

	var_1(var_4_16, var_3 == var_4_19)

	setActive = var_1

	local var_4_17 = arg_4_0.twitterLoginBtn_en

	PLATFORM_CODE = var_3
	PLATFORM_US = var_4_19

	var_1(var_4_17, var_3 == var_4_19)

	setActive = var_1

	local var_4_18 = arg_4_0.facebookLoginBtn_en

	PLATFORM_CODE = var_3
	PLATFORM_US = var_4_19

	if var_3 == var_4_19 then
		pg = var_3

		local var_4_19 = var_3.SdkMgr.GetInstance()
		local var_4_20

		if var_3.GetChannelUID(var_4_19) == "3" then
			var_4_20 = false
		else
			var_4_20 = true
		end

		var_1(var_4_18, var_4_20)

		setActive = var_1

		local var_4_21 = arg_4_0.yostarLoginBtn_en

		PLATFORM_CODE = var_4_20
		PLATFORM_US = var_4_19

		var_1(var_4_21, var_4_20 == var_4_19)

		setActive = var_1

		local var_4_22 = arg_4_0.appleLoginBtn_en

		PLATFORM_CODE = var_3
		PLATFORM_US = var_4_19

		if var_3 == var_4_19 then
			pg = var_3
			var_4_19 = var_3.SdkMgr.GetInstance()

			local var_4_23

			if var_3.GetChannelUID(var_4_19) ~= "1" then
				var_4_23 = false
			else
				var_4_23 = true
			end

			var_1(var_4_22, var_4_23)

			setActive = var_1

			local var_4_24 = arg_4_0.amazonLoginBtn_en

			PLATFORM_CODE = var_4_23
			PLATFORM_US = var_4_19

			if var_4_23 == var_4_19 then
				pg = var_4_23

				local var_4_25 = var_4_23.SdkMgr.GetInstance()
				local var_4_26

				if var_3.GetChannelUID(var_4_25) ~= "3" then
					var_4_26 = false
				else
					var_4_26 = true
				end

				var_1(var_4_24, var_4_26)
				arg_4_0:InitEvent()

				return
			end
		end
	end
end

function var_0_1.InitEvent(arg_5_0)
	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.airiLoginBtn, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.CriMgr.GetInstance()
		local var_6_1 = var_0.PlaySoundEffect_V3

		SFX_CONFIRM = var_2_10002

		var_6_1(var_6_0, var_2_10002)

		pg = var_6_1

		local var_6_2 = var_6_1.SdkMgr.GetInstance()

		var_0.YoStarLoginSDK(var_6_2)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.clearTranscodeBtn, function()
		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.jpYoStarLoginBtn, function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.CriMgr.GetInstance()
		local var_8_1 = var_0.PlaySoundEffect_V3

		SFX_CONFIRM = var_2_10002

		var_8_1(var_8_0, var_2_10002)

		pg = var_8_1

		local var_8_2 = var_8_1.SdkMgr.GetInstance()

		var_0.YoStarLoginSDK(var_8_2)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.jpTransBtn, function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.CriMgr.GetInstance()
		local var_9_1 = var_0.PlaySoundEffect_V3

		SFX_CONFIRM = var_2_10002

		var_9_1(var_9_0, var_2_10002)

		Application = var_9_1

		var_9_1.OpenURL("https://migration.yostar.co.jp?pid=JP-AZURLANE")

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.twitterLoginBtn_en, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.SdkMgr.GetInstance()
		local var_10_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_TWITTER = var_2_10002

		var_10_1(var_10_0, var_2_10002)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.facebookLoginBtn_en, function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.SdkMgr.GetInstance()
		local var_11_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_FACEBOOK = var_2_10002

		var_11_1(var_11_0, var_2_10002)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarLoginBtn_en, function()
		local var_12_0 = arg_5_0
		local var_12_1 = var_0.emit

		LoginSceneConst = var_2_10002

		local var_12_2 = var_2_10002.SWITCH_SUB_VIEW
		local var_12_3 = {}

		LoginSceneConst = var_2_10004
		var_12_3[1] = var_2_10004.DEFINE.YOSTAR_ALERT_VIEW
		LoginSceneConst = var_4
		var_12_3[2] = var_4.DEFINE.AIRI_LOGIN_PANEL_VIEW
		LoginSceneConst = var_4
		var_12_3[3] = var_4.DEFINE.PRESS_TO_LOGIN

		var_12_1(var_12_0, var_12_2, var_12_3)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.appleLoginBtn_en, function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.SdkMgr.GetInstance()
		local var_13_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_APPLE = var_2_10002

		var_13_1(var_13_0, var_2_10002)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.amazonLoginBtn_en, function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.SdkMgr.GetInstance()
		local var_14_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_AMAZON = var_2_10002

		var_14_1(var_14_0, var_2_10002)

		return
	end)

	triggerButton = var_1_10001

	var_1_10001(arg_5_0.airiLoginBtn)

	return
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

return var_0_1

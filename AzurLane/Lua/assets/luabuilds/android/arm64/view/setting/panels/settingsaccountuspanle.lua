class = var_0_10000

local var_0_0 = "SettingsAccountUSPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsAccountUS"
end

function var_0_1.GetTitle(arg_2_0)
	return "Account"
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / ACCOUNT"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	findTF = var_1_10002

	local var_4_1 = var_1_10002(var_4_0, "page1")

	findTF = var_1_10003

	local var_4_2 = var_1_10003(var_4_1, "btn_layout/twitter_con")

	findTF = var_4
	arg_4_0.btnBindTwitter = var_4(var_4_2, "bind_twitter")
	findTF = var_4
	arg_4_0.btnUnlinkTwitter = var_4(var_4_2, "unlink_twitter")
	findTF = var_4
	arg_4_0.twitterStatus = var_4(var_4_2, "twitter_status")
	findTF = var_4

	local var_4_3 = var_4(var_4_1, "btn_layout/facebook_con")

	findTF = var_5
	arg_4_0.btnBindFacebook = var_5(var_4_3, "bind_facebook")
	findTF = var_5
	arg_4_0.btnUnlinkFacebook = var_5(var_4_3, "unlink_facebook")
	findTF = var_5
	arg_4_0.facebookStatus = var_5(var_4_3, "facebook_status")
	setActive = var_5

	local var_4_4 = var_4_3

	PLATFORM_CODE = var_8
	PLATFORM_US = var_1_10009

	if var_8 == var_1_10009 then
		pg = var_8

		local var_4_5 = var_8.SdkMgr.GetInstance()
		local var_4_6

		if var_8.GetChannelUID(var_4_5) == "3" then
			var_4_6 = false
		else
			var_4_6 = true
		end

		var_5(var_4_4, var_4_6)

		findTF = var_5

		local var_4_7 = var_5(var_4_1, "btn_layout/yostar_con")

		findTF = var_6
		arg_4_0.btnBindYostar = var_6(var_4_7, "bind_yostar")
		findTF = var_6
		arg_4_0.btnUnlinkYostar = var_6(var_4_7, "unlink_yostar")
		findTF = var_6
		arg_4_0.yostarStatus = var_6(var_4_7, "yostar_status")
		findTF = var_6

		local var_4_8 = var_6(var_4_1, "btn_layout/apple_con")

		findTF = var_7
		arg_4_0.btnBindApple = var_7(var_4_8, "bind_apple")
		findTF = var_7
		arg_4_0.btnUnlinkApple = var_7(var_4_8, "unlink_apple")
		findTF = var_7
		arg_4_0.appleStatus = var_7(var_4_8, "apple_status")
		setActive = var_7

		local var_4_9 = var_4_8

		PLATFORM_CODE = var_10
		PLATFORM_US = var_1_10011

		if var_10 == var_1_10011 then
			pg = var_10
			var_1_10012 = var_10.SdkMgr.GetInstance()

			local var_4_10

			if var_10.GetChannelUID(var_1_10012) ~= "1" then
				var_4_10 = false
			else
				var_4_10 = true
			end

			var_7(var_4_9, var_4_10)

			findTF = var_7

			local var_4_11 = var_7(var_4_1, "btn_layout/amazon_con")

			findTF = var_8
			arg_4_0.btnBindAmazon = var_8(var_4_11, "bind_amazon")
			findTF = var_8
			arg_4_0.btnUnlinkAmazon = var_8(var_4_11, "unlink_amazon")
			findTF = var_8
			arg_4_0.amazonStatus = var_8(var_4_11, "amazon_status")
			setActive = var_8

			local var_4_12 = var_4_11

			PLATFORM_CODE = var_11
			PLATFORM_US = var_1_10012

			if var_11 == var_1_10012 then
				pg = var_11

				local var_4_13 = var_11.SdkMgr.GetInstance()
				local var_4_14

				if var_11.GetChannelUID(var_4_13) ~= "3" then
					var_4_14 = false
				else
					var_4_14 = true
				end

				var_8(var_4_12, var_4_14)

				findTF = var_8
				arg_4_0.pgsCon = var_8(var_4_1, "btn_layout/pgs_con")
				findTF = var_8
				arg_4_0.btnBindPGS = var_8(arg_4_0.pgsCon, "bind")
				findTF = var_8
				arg_4_0.btnUnlinkPGS = var_8(arg_4_0.pgsCon, "unlink")
				findTF = var_8
				arg_4_0.pgsStatus = var_8(arg_4_0.pgsCon, "status")
				findTF = var_8
				arg_4_0.yostarAlert = var_8(var_4_0, "page2")
				findTF = var_8
				arg_4_0.yostarEmailTxt = var_8(arg_4_0.yostarAlert, "email_input_txt")
				findTF = var_8
				arg_4_0.yostarCodeTxt = var_8(arg_4_0.yostarAlert, "code_input_txt")
				findTF = var_8
				arg_4_0.yostarGenCodeBtn = var_8(arg_4_0.yostarAlert, "gen_code_btn")
				findTF = var_8
				arg_4_0.yostarGenTxt = var_8(arg_4_0.yostarGenCodeBtn, "Text")
				findTF = var_8
				arg_4_0.yostarSureBtn = var_8(arg_4_0.yostarAlert, "login_btn")

				arg_4_0:RegisterEvent()

				return
			end
		end
	end
end

function var_0_1.RegisterEvent(arg_5_0)
	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnBindTwitter, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.SdkMgr.GetInstance()
		local var_6_1 = var_0.LinkSocial

		AIRI_PLATFORM_TWITTER = var_2_10003

		var_6_1(var_6_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnUnlinkTwitter, function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.SdkMgr.GetInstance()
		local var_7_1 = var_0.UnlinkSocial

		AIRI_PLATFORM_TWITTER = var_2_10003

		var_7_1(var_7_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnBindFacebook, function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.SdkMgr.GetInstance()
		local var_8_1 = var_0.LinkSocial

		AIRI_PLATFORM_FACEBOOK = var_2_10003

		var_8_1(var_8_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnUnlinkFacebook, function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.SdkMgr.GetInstance()
		local var_9_1 = var_0.UnlinkSocial

		AIRI_PLATFORM_FACEBOOK = var_2_10003

		var_9_1(var_9_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnBindApple, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.SdkMgr.GetInstance()
		local var_10_1 = var_0.LinkSocial

		AIRI_PLATFORM_APPLE = var_2_10003

		var_10_1(var_10_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnUnlinkApple, function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.SdkMgr.GetInstance()
		local var_11_1 = var_0.UnlinkSocial

		AIRI_PLATFORM_APPLE = var_2_10003

		var_11_1(var_11_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnBindAmazon, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.SdkMgr.GetInstance()
		local var_12_1 = var_0.LinkSocial

		AIRI_PLATFORM_AMAZON = var_2_10003

		var_12_1(var_12_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnUnlinkAmazon, function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.SdkMgr.GetInstance()
		local var_13_1 = var_0.UnlinkSocial

		AIRI_PLATFORM_AMAZON = var_2_10003

		var_13_1(var_13_0, var_2_10003)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnBindYostar, function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_14_0, arg_5_0.yostarAlert)

		setActive = var_0

		var_0(arg_5_0.yostarAlert, true)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarAlert, function()
		pg = var_2_10000

		local var_15_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_15_0, arg_5_0.yostarAlert, arg_5_0.accountUS)

		setActive = var_0

		var_0(arg_5_0.yostarAlert, false)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarGenCodeBtn, function()
		getInputText = var_2_10000

		if var_2_10000(arg_5_0.yostarEmailTxt) ~= "" then
			pg = var_2_10001

			local var_16_0 = var_2_10001.SdkMgr.GetInstance()

			var_2_10001.VerificationCodeReq(var_16_0, var_0)

			local var_16_1 = arg_5_0

			var_2_10001.checkAiriGenCodeCounter_US(var_16_1)
		else
			pg = var_2_10001

			local var_16_2 = var_2_10001.TipsMgr.GetInstance()
			local var_16_3 = var_1.ShowTips

			i18n = var_2_10004

			var_16_3(var_16_2, var_2_10004("verification_code_req_tip1"))
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarSureBtn, function()
		getInputText = var_2_10000

		local var_17_0 = var_2_10000(arg_5_0.yostarEmailTxt)

		getInputText = var_2_10001

		local var_17_1 = var_2_10001(arg_5_0.yostarCodeTxt)
		local var_17_4

		if var_17_0 ~= "" and var_17_1 ~= "" then
			pg = var_17_4

			local var_17_2 = var_17_4.UIMgr.GetInstance()

			var_17_4.LoadingOn(var_17_2)

			pg = var_17_4

			local var_17_3 = var_17_4.SdkMgr.GetInstance()

			var_17_4 = var_17_4.LinkSocial
			AIRI_PLATFORM_YOSTAR = var_2_10005

			var_17_4(var_17_3, var_2_10005, var_17_0, var_17_1)
		else
			pg = var_17_4

			local var_17_5 = var_17_4.TipsMgr.GetInstance()

			var_17_4 = var_17_4.ShowTips
			i18n = var_2_10005

			var_17_4(var_17_5, var_2_10005("verification_code_req_tip3"))
		end

		triggerButton = var_17_4

		var_17_4(arg_5_0.yostarAlert)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.btnUnlinkPGS, function()
		pg = var_2_10000

		local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_18_1 = var_0.ShowMsgBox
		local var_18_2 = {}

		i18n = var_2_10004
		var_18_2.content = var_2_10004("pgs_unbind_tip1")

		function var_18_2.onYes()
			pg = var_3_10000

			local var_19_0 = var_3_10000.SdkMgr.GetInstance()
			local var_19_1 = var_0.UnlinkSocial

			AIRI_PLATFORM_GPS = var_3_10003

			var_19_1(var_19_0, var_3_10003)

			return
		end

		var_18_1(var_18_0, var_18_2)

		return
	end)

	return
end

function var_0_1.OnUpdate(arg_20_0)
	arg_20_0:checkAllAccountState_US()
	arg_20_0:checkAiriGenCodeCounter_US()

	return
end

function var_0_1.checkAllAccountState_US(arg_21_0)
	arg_21_0:checkAccountTwitterView_US()
	arg_21_0:checkAccountFacebookView_US()
	arg_21_0:checkAccountAppleView_US()
	arg_21_0:checkAccountYostarView_US()
	arg_21_0:checkAccountAmazonView_US()
	arg_21_0:checkAccountPGSView_US()

	return
end

function var_0_1.checkAccountTwitterView_US(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.SdkMgr.GetInstance()
	local var_22_1 = var_1.IsSocialLink

	AIRI_PLATFORM_TWITTER = var_1_10004

	local var_22_2 = var_22_1(var_22_0, var_1_10004)

	setActive = var_1_10002

	var_1_10002(arg_22_0.btnUnlinkTwitter, var_22_2)

	setActive = var_1_10002

	var_1_10002(arg_22_0.twitterStatus, var_22_2)

	setActive = var_1_10002

	var_1_10002(arg_22_0.btnBindTwitter, not var_22_2)

	if var_22_2 then
		setText = var_1_10002

		local var_22_3 = arg_22_0.twitterStatus

		i18n = var_5

		local var_22_4 = "twitter_link_title"

		pg = var_1_10008

		local var_22_5 = var_1_10008.SdkMgr.GetInstance()
		local var_22_6 = var_8.GetSocialName

		AIRI_PLATFORM_TWITTER = var_1_10011

		var_1_10002(var_22_3, var_5(var_22_4, var_22_6(var_22_5, var_1_10011)))
	end

	return
end

function var_0_1.checkAccountFacebookView_US(arg_23_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_US = var_1_10002

	if var_1_10001 == var_1_10002 then
		pg = var_1_10001

		local var_23_0 = var_1_10001.SdkMgr.GetInstance()

		if var_1.GetChannelUID(var_23_0) ~= "3" then
			pg = var_1

			local var_23_1 = var_1.SdkMgr.GetInstance()
			local var_23_2 = var_1.IsSocialLink

			AIRI_PLATFORM_FACEBOOK = var_1_10004

			local var_23_3 = var_23_2(var_23_1, var_1_10004)

			setActive = var_1_10002

			var_1_10002(arg_23_0.btnUnlinkFacebook, var_23_3)

			setActive = var_1_10002

			var_1_10002(arg_23_0.facebookStatus, var_23_3)

			setActive = var_1_10002

			var_1_10002(arg_23_0.btnBindFacebook, not var_23_3)

			if var_23_3 then
				setText = var_1_10002

				local var_23_4 = arg_23_0.facebookStatus

				i18n = var_5

				local var_23_5 = "facebook_link_title"

				pg = var_1_10008

				local var_23_6 = var_1_10008.SdkMgr.GetInstance()
				local var_23_7 = var_8.GetSocialName

				AIRI_PLATFORM_FACEBOOK = var_1_10011

				var_1_10002(var_23_4, var_5(var_23_5, var_23_7(var_23_6, var_1_10011)))
			end
		end
	end

	return
end

function var_0_1.checkAccountAppleView_US(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.SdkMgr.GetInstance()
	local var_24_1 = var_1.IsSocialLink

	AIRI_PLATFORM_APPLE = var_1_10004

	local var_24_2 = var_24_1(var_24_0, var_1_10004)

	setActive = var_1_10002

	var_1_10002(arg_24_0.btnUnlinkApple, var_24_2)

	setActive = var_1_10002

	var_1_10002(arg_24_0.appleStatus, var_24_2)

	setActive = var_1_10002

	var_1_10002(arg_24_0.btnBindApple, not var_24_2)

	if var_24_2 then
		setText = var_1_10002

		local var_24_3 = arg_24_0.appleStatus

		i18n = var_5

		local var_24_4 = "apple_link_title"

		pg = var_1_10008

		local var_24_5 = var_1_10008.SdkMgr.GetInstance()
		local var_24_6 = var_8.GetSocialName

		AIRI_PLATFORM_APPLE = var_1_10011

		var_1_10002(var_24_3, var_5(var_24_4, var_24_6(var_24_5, var_1_10011)))
	end

	return
end

function var_0_1.checkAccountAmazonView_US(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.SdkMgr.GetInstance()

	if var_1.GetChannelUID(var_25_0) == "3" then
		pg = var_1

		local var_25_1 = var_1.SdkMgr.GetInstance()
		local var_25_2 = var_1.IsSocialLink

		AIRI_PLATFORM_AMAZON = var_1_10004

		local var_25_3 = var_25_2(var_25_1, var_1_10004)

		setActive = var_1_10002

		var_1_10002(arg_25_0.btnUnlinkAmazon, var_25_3)

		setActive = var_1_10002

		var_1_10002(arg_25_0.amazonStatus, var_25_3)

		setActive = var_1_10002

		var_1_10002(arg_25_0.btnBindAmazon, not var_25_3)

		if var_25_3 then
			setText = var_1_10002

			local var_25_4 = arg_25_0.amazonStatus

			i18n = var_5

			local var_25_5 = "amazon_link_title"

			pg = var_1_10008

			local var_25_6 = var_1_10008.SdkMgr.GetInstance()
			local var_25_7 = var_8.GetSocialName

			AIRI_PLATFORM_AMAZON = var_1_10011

			var_1_10002(var_25_4, var_5(var_25_5, var_25_7(var_25_6, var_1_10011)))
		end
	end

	return
end

function var_0_1.checkAccountYostarView_US(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.SdkMgr.GetInstance()
	local var_26_1 = var_1.IsSocialLink

	AIRI_PLATFORM_YOSTAR = var_1_10004

	local var_26_2 = var_26_1(var_26_0, var_1_10004)

	setActive = var_1_10002

	var_1_10002(arg_26_0.btnUnlinkYostar, var_26_2)

	setActive = var_1_10002

	var_1_10002(arg_26_0.yostarStatus, var_26_2)

	setActive = var_1_10002

	var_1_10002(arg_26_0.btnBindYostar, not var_26_2)

	if var_26_2 then
		setText = var_1_10002

		local var_26_3 = arg_26_0.yostarStatus

		i18n = var_5

		local var_26_4 = "yostar_link_title"

		pg = var_1_10008

		local var_26_5 = var_1_10008.SdkMgr.GetInstance()
		local var_26_6 = var_8.GetSocialName

		AIRI_PLATFORM_YOSTAR = var_1_10011

		var_1_10002(var_26_3, var_5(var_26_4, var_26_6(var_26_5, var_1_10011)))
	end

	return
end

function var_0_1.checkAccountPGSView_US(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.SdkMgr.GetInstance()
	local var_27_1 = var_1.IsSocialLink

	AIRI_PLATFORM_GPS = var_1_10004

	local var_27_2 = var_27_1(var_27_0, var_1_10004)

	setActive = var_1_10002

	var_1_10002(arg_27_0.pgsCon, var_27_2)

	setActive = var_1_10002

	var_1_10002(arg_27_0.btnUnlinkPGS, var_27_2)

	setActive = var_1_10002

	var_1_10002(arg_27_0.pgsStatus, var_27_2)

	setActive = var_1_10002

	var_1_10002(arg_27_0.btnBindPGS, false)

	if var_27_2 then
		setText = var_1_10002

		local var_27_3 = arg_27_0.pgsStatus

		i18n = var_5

		local var_27_4 = "pgs_binding_account"

		pg = var_1_10008

		local var_27_5 = var_1_10008.SdkMgr.GetInstance()
		local var_27_6 = var_8.GetSocialName

		AIRI_PLATFORM_GPS = var_1_10011

		var_1_10002(var_27_3, var_5(var_27_4, var_27_6(var_27_5, var_1_10011)))
	end

	return
end

function var_0_1.checkAiriGenCodeCounter_US(arg_28_0)
	GetAiriGenCodeTimeRemain = var_1_10001

	if var_1_10001() > 0 then
		setButtonEnabled = var_1

		var_1(arg_28_0.yostarGenCodeBtn, false)

		Timer = var_1
		arg_28_0.genCodeTimer = var_1.New(function()
			GetAiriGenCodeTimeRemain = var_2_10000

			local var_29_0 = var_2_10000()

			if 0 < var_29_0 then
				setText = var_1

				var_1(arg_28_0.yostarGenTxt, "(" .. var_29_0 .. ")")
			else
				setText = var_1

				var_1(arg_28_0.yostarGenTxt, "Generate")

				local var_29_1 = arg_28_0

				var_1.clearAiriGenCodeTimer_US(var_29_1)
			end

			return
		end, 1, -1)

		local var_28_0 = arg_28_0.genCodeTimer

		var_1.Start(var_28_0)
	end

	return
end

function var_0_1.clearAiriGenCodeTimer_US(arg_30_0)
	setButtonEnabled = var_1_10001

	var_1_10001(arg_30_0.yostarGenCodeBtn, true)

	if arg_30_0.genCodeTimer then
		local var_30_0 = arg_30_0.genCodeTimer

		var_1.Stop(var_30_0)

		arg_30_0.genCodeTimer = nil
	end

	return
end

function var_0_1.Dispose(arg_31_0)
	var_0_1.super.Dispose(arg_31_0)

	if arg_31_0.genCodeTimer then
		local var_31_0 = arg_31_0.genCodeTimer

		var_1.Stop(var_31_0)

		arg_31_0.genCodeTimer = nil
	end

	return
end

return var_0_1

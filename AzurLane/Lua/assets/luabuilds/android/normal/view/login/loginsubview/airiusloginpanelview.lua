class = var_0_10000

local var_0_0 = "AiriUSLoginPanelView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "AiriUSLoginPanelView"
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

	arg_4_0.appleLoginBtn = var_1.Find(var_4_3, "apple_login")

	local var_4_4 = arg_4_0.jpLoginCon

	arg_4_0.amazonLoginBtn = var_1.Find(var_4_4, "amazon_login")

	local var_4_5 = arg_4_0.jpLoginCon

	arg_4_0.twitterLoginBtn = var_1.Find(var_4_5, "twitter_login")

	local var_4_6 = arg_4_0.jpLoginCon

	arg_4_0.transcodeLoginBtn = var_1.Find(var_4_6, "transcode_login")

	local var_4_7 = arg_4_0.jpLoginCon

	arg_4_0.touristLoginBtn = var_1.Find(var_4_7, "tourist_login")

	local var_4_8 = arg_4_0.jpLoginCon

	arg_4_0.yostarLoginBtn = var_1.Find(var_4_8, "yostar_login")

	local var_4_9 = arg_4_0.airijpPanel

	arg_4_0.firstAlertWin = var_1.Find(var_4_9, "empty_alert")

	local var_4_10 = arg_4_0.firstAlertWin

	arg_4_0.appleToggleTf = var_1.Find(var_4_10, "window/content_bg/apple_toggle")

	local var_4_11 = arg_4_0.firstAlertWin

	arg_4_0.amazonToggleTf = var_1.Find(var_4_11, "window/content_bg/amazon_toggle")

	local var_4_12 = arg_4_0.firstAlertWin

	arg_4_0.twitterToggleTf = var_1.Find(var_4_12, "window/content_bg/twitter_toggle")

	local var_4_13 = arg_4_0.firstAlertWin

	arg_4_0.transcodeToggleTf = var_1.Find(var_4_13, "window/content_bg/transcode_toggle")

	local var_4_14 = arg_4_0.firstAlertWin

	arg_4_0.touristToggleTf = var_1.Find(var_4_14, "window/content_bg/tourist_toggle")

	local var_4_15 = arg_4_0.firstAlertWin

	arg_4_0.yostarToggleTf = var_1.Find(var_4_15, "window/content_bg/yostar_toggle")

	local var_4_16 = arg_4_0.firstAlertWin

	arg_4_0.alertCloseBtn = var_1.Find(var_4_16, "window/top/btnBack")

	local var_4_17 = arg_4_0.firstAlertWin

	arg_4_0.alertCancelBtn = var_1.Find(var_4_17, "window/button_container/custom_button_2")

	local var_4_18 = arg_4_0.firstAlertWin

	arg_4_0.alertSureBtn = var_1.Find(var_4_18, "window/button_container/custom_button_1")

	local var_4_19 = arg_4_0.airijpPanel

	arg_4_0.enLoginCon = var_1.Find(var_4_19, "en_login_btns")

	local var_4_20 = arg_4_0.enLoginCon

	arg_4_0.twitterLoginBtn_en = var_1.Find(var_4_20, "twitter_login_en")

	local var_4_21 = arg_4_0.enLoginCon

	arg_4_0.facebookLoginBtn_en = var_1.Find(var_4_21, "facebook_login_en")

	local var_4_22 = arg_4_0.enLoginCon

	arg_4_0.yostarLoginBtn_en = var_1.Find(var_4_22, "yostar_login_en")

	local var_4_23 = arg_4_0.enLoginCon

	arg_4_0.appleLoginBtn_en = var_1.Find(var_4_23, "apple_login_en")

	local var_4_24 = arg_4_0.enLoginCon

	arg_4_0.amazonLoginBtn_en = var_1.Find(var_4_24, "amazon_login_en")
	setActive = var_1

	local var_4_25 = arg_4_0.clearTranscodeBtn

	LOCK_CLEAR_ACCOUNT = var_3

	var_1(var_4_25, not var_3)

	setActive = var_1

	local var_4_26 = arg_4_0.transcodeLoginBtn

	PLATFORM_CODE = var_3
	PLATFORM_JP = var_1_10004

	var_1(var_4_26, var_3 == var_1_10004)

	setActive = var_1

	var_1(arg_4_0.touristLoginBtn, false)

	setActive = var_1

	local var_4_27 = arg_4_0.yostarLoginBtn

	PLATFORM_CODE = var_3
	PLATFORM_JP = var_1_10004

	var_1(var_4_27, var_3 == var_1_10004)

	setActive = var_1

	local var_4_28 = arg_4_0.appleLoginBtn

	PLATFORM_CODE = var_3
	PLATFORM_JP = var_1_10004

	if var_3 == var_1_10004 then
		pg = var_3
		var_1_10004 = var_3.SdkMgr.GetInstance()

		local var_4_29

		if var_3.GetChannelUID(var_1_10004) ~= "1" then
			var_4_29 = false
		else
			var_4_29 = true
		end

		var_1(var_4_28, var_4_29)

		setActive = var_1

		local var_4_30 = arg_4_0.appleToggleTf

		PLATFORM_CODE = var_4_29
		PLATFORM_JP = var_1_10004

		if var_4_29 == var_1_10004 then
			pg = var_4_29
			var_1_10004 = var_4_29.SdkMgr.GetInstance()

			local var_4_31

			if var_3.GetChannelUID(var_1_10004) ~= "1" then
				var_4_31 = false
			else
				var_4_31 = true
			end

			var_1(var_4_30, var_4_31)

			setActive = var_1

			local var_4_32 = arg_4_0.amazonLoginBtn

			PLATFORM_CODE = var_4_31
			PLATFORM_JP = var_1_10004

			if var_4_31 == var_1_10004 then
				pg = var_4_31
				var_1_10004 = var_4_31.SdkMgr.GetInstance()

				local var_4_33

				if var_3.GetChannelUID(var_1_10004) ~= "3" then
					var_4_33 = false
				else
					var_4_33 = true
				end

				var_1(var_4_32, var_4_33)

				setActive = var_1

				local var_4_34 = arg_4_0.amazonToggleTf

				PLATFORM_CODE = var_4_33
				PLATFORM_JP = var_1_10004

				if var_4_33 == var_1_10004 then
					pg = var_4_33
					var_1_10004 = var_4_33.SdkMgr.GetInstance()

					local var_4_35

					if var_3.GetChannelUID(var_1_10004) ~= "3" then
						var_4_35 = false
					else
						var_4_35 = true
					end

					var_1(var_4_34, var_4_35)

					PLATFORM_CODE = var_1
					PLATFORM_JP = var_4_34

					if var_1 == var_4_34 then
						setActive = var_1

						var_1(arg_4_0.firstAlertWin, false)
					end

					setActive = var_1

					local var_4_36 = arg_4_0.twitterLoginBtn_en

					PLATFORM_CODE = var_4_35
					PLATFORM_US = var_1_10004

					var_1(var_4_36, var_4_35 == var_1_10004)

					setActive = var_1

					local var_4_37 = arg_4_0.facebookLoginBtn_en

					PLATFORM_CODE = var_3
					PLATFORM_US = var_1_10004

					if var_3 == var_1_10004 then
						pg = var_3
						var_1_10004 = var_3.SdkMgr.GetInstance()

						local var_4_38

						if var_3.GetChannelUID(var_1_10004) == "3" then
							var_4_38 = false
						else
							var_4_38 = true
						end

						var_1(var_4_37, var_4_38)

						setActive = var_1

						local var_4_39 = arg_4_0.yostarLoginBtn_en

						PLATFORM_CODE = var_4_38
						PLATFORM_US = var_1_10004

						var_1(var_4_39, var_4_38 == var_1_10004)

						setActive = var_1

						local var_4_40 = arg_4_0.appleLoginBtn_en

						PLATFORM_CODE = var_3
						PLATFORM_US = var_1_10004

						if var_3 == var_1_10004 then
							pg = var_3
							var_1_10004 = var_3.SdkMgr.GetInstance()

							local var_4_41

							if var_3.GetChannelUID(var_1_10004) ~= "1" then
								var_4_41 = false
							else
								var_4_41 = true
							end

							var_1(var_4_40, var_4_41)

							setActive = var_1

							local var_4_42 = arg_4_0.amazonLoginBtn_en

							PLATFORM_CODE = var_4_41
							PLATFORM_US = var_1_10004

							if var_4_41 == var_1_10004 then
								pg = var_4_41
								var_1_10004 = var_4_41.SdkMgr.GetInstance()

								local var_4_43

								if var_3.GetChannelUID(var_1_10004) ~= "3" then
									var_4_43 = false
								else
									var_4_43 = true
								end

								var_1(var_4_42, var_4_43)

								setActive = var_1

								local var_4_44 = arg_4_0.clearTranscodeBtn

								PLATFORM_CODE = var_4_43
								PLATFORM_US = var_1_10004

								var_1(var_4_44, var_4_43 ~= var_1_10004)

								setActive = var_1

								var_1(arg_4_0.twitterLoginBtn, false)

								setActive = var_1

								var_1(arg_4_0.twitterToggleTf, false)
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

function var_0_1.InitEvent(arg_5_0)
	local function var_5_0()
		pg = var_2_10000

		local var_6_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_6_0, arg_5_0.firstAlertWin, arg_5_0.airijpPanel)

		setActive = var_0

		var_0(arg_5_0.firstAlertWin, false)

		return
	end

	local function var_5_1()
		pg = var_2_10000

		local var_7_0 = var_2_10000.SdkMgr.GetInstance()

		if not var_0.CheckHadAccountCache(var_7_0) then
			setActive = var_0

			var_0(arg_5_0.firstAlertWin, true)

			pg = var_0

			local var_7_1 = var_0.UIMgr.GetInstance()

			var_0.BlurPanel(var_7_1, arg_5_0.firstAlertWin)

			return true
		end

		return false
	end

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.airiLoginBtn, function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.CriMgr.GetInstance()
		local var_8_1 = var_0.PlaySoundEffect_V3

		SFX_CONFIRM = var_2_10002

		var_8_1(var_8_0, var_2_10002)

		getProxy = var_8_1
		SettingsProxy = var_8_0

		local var_8_2 = var_8_1(var_8_0)

		if var_0.CheckNeedUserAgreement(var_8_2) then
			local var_8_3 = arg_5_0.event
			local var_8_4 = var_1.emit

			LoginMediator = var_2_10003

			var_8_4(var_8_3, var_2_10003.ON_LOGIN_PROCESS)
		elseif not var_5_1() then
			pg = var_1

			local var_8_5 = var_1.SdkMgr.GetInstance()

			var_1.AiriLoginSDK(var_8_5)
		end

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.clearTranscodeBtn, function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		i18n = var_2_10003
		var_9_2.content = var_2_10003("clear_transcode_cache_confirm")

		function var_9_2.onYes()
			ClearAccountCache = var_3_10000

			var_3_10000()

			getProxy = var_3_10000
			SettingsProxy = var_3_10001

			local var_10_0 = var_3_10000(var_3_10001)

			var_0.deleteUserAreement(var_10_0)
			var_0:clearAllReadHelp()

			local var_10_1 = arg_5_0.event
			local var_10_2 = var_1.emit

			LoginMediator = var_3_10003

			var_10_2(var_10_1, var_3_10003.ON_LOGIN_PROCESS)

			pg = var_10_2

			local var_10_3 = var_10_2.TipsMgr.GetInstance()
			local var_10_4 = var_1.ShowTips

			i18n = var_3

			var_10_4(var_10_3, var_3("clear_transcode_cache_success"))

			return
		end

		function var_9_2.onNo()
			return
		end

		var_9_1(var_9_0, var_9_2)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.appleLoginBtn, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.SdkMgr.GetInstance()
		local var_12_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_APPLE = var_2_10002

		var_12_1(var_12_0, var_2_10002)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.amazonLoginBtn, function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.SdkMgr.GetInstance()
		local var_13_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_AMAZON = var_2_10002

		var_13_1(var_13_0, var_2_10002)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.yostarLoginBtn, function()
		local var_14_0 = arg_5_0
		local var_14_1 = var_0.emit

		LoginSceneConst = var_2_10002

		local var_14_2 = var_2_10002.SWITCH_SUB_VIEW
		local var_14_3 = {}

		LoginSceneConst = var_2_10004
		var_14_3[1] = var_2_10004.DEFINE.YOSTAR_ALERT_VIEW
		LoginSceneConst = var_4
		var_14_3[2] = var_4.DEFINE.AIRI_LOGIN_PANEL_VIEW
		LoginSceneConst = var_4
		var_14_3[3] = var_4.DEFINE.PRESS_TO_LOGIN

		var_14_1(var_14_0, var_14_2, var_14_3)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.transcodeLoginBtn, function()
		local var_15_0 = arg_5_0
		local var_15_1 = var_0.emit

		LoginSceneConst = var_2_10002

		local var_15_2 = var_2_10002.SWITCH_SUB_VIEW
		local var_15_3 = {}

		LoginSceneConst = var_2_10004
		var_15_3[1] = var_2_10004.DEFINE.TRANSCODE_ALERT_VIEW
		LoginSceneConst = var_4
		var_15_3[2] = var_4.DEFINE.AIRI_LOGIN_PANEL_VIEW
		LoginSceneConst = var_4
		var_15_3[3] = var_4.DEFINE.PRESS_TO_LOGIN

		var_15_1(var_15_0, var_15_2, var_15_3)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.touristLoginBtn, function()
		pg = var_2_10000

		local var_16_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.LoginWithDevice(var_16_0)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.twitterLoginBtn_en, function()
		pg = var_2_10000

		local var_17_0 = var_2_10000.SdkMgr.GetInstance()
		local var_17_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_TWITTER = var_2_10002

		var_17_1(var_17_0, var_2_10002)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.facebookLoginBtn_en, function()
		pg = var_2_10000

		local var_18_0 = var_2_10000.SdkMgr.GetInstance()
		local var_18_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_FACEBOOK = var_2_10002

		var_18_1(var_18_0, var_2_10002)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.yostarLoginBtn_en, function()
		local var_19_0 = arg_5_0
		local var_19_1 = var_0.emit

		LoginSceneConst = var_2_10002

		local var_19_2 = var_2_10002.SWITCH_SUB_VIEW
		local var_19_3 = {}

		LoginSceneConst = var_2_10004
		var_19_3[1] = var_2_10004.DEFINE.YOSTAR_ALERT_VIEW
		LoginSceneConst = var_4
		var_19_3[2] = var_4.DEFINE.AIRI_LOGIN_PANEL_VIEW
		LoginSceneConst = var_4
		var_19_3[3] = var_4.DEFINE.PRESS_TO_LOGIN

		var_19_1(var_19_0, var_19_2, var_19_3)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.appleLoginBtn_en, function()
		pg = var_2_10000

		local var_20_0 = var_2_10000.SdkMgr.GetInstance()
		local var_20_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_APPLE = var_2_10002

		var_20_1(var_20_0, var_2_10002)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.amazonLoginBtn_en, function()
		pg = var_2_10000

		local var_21_0 = var_2_10000.SdkMgr.GetInstance()
		local var_21_1 = var_0.LoginWithSocial

		AIRI_PLATFORM_AMAZON = var_2_10002

		var_21_1(var_21_0, var_2_10002)

		return
	end)
	var_5_1()

	onButton = var_3

	var_3(arg_5_0, arg_5_0.alertCloseBtn, function()
		var_5_0()

		return
	end)

	onButton = var_3

	var_3(arg_5_0, arg_5_0.alertCancelBtn, function()
		var_5_0()

		return
	end)

	onButton = var_3

	var_3(arg_5_0, arg_5_0.alertSureBtn, function()
		getToggleState = var_2_10000

		local var_24_0 = var_2_10000(arg_5_0.twitterToggleTf)
		local var_24_1 = false

		getToggleState = var_1

		local var_24_2 = var_1(arg_5_0.transcodeToggleTf)

		getToggleState = var_2

		local var_24_3 = var_2(arg_5_0.touristToggleTf)

		getToggleState = var_3

		local var_24_4 = var_3(arg_5_0.appleToggleTf)

		getToggleState = var_4

		local var_24_5 = var_4(arg_5_0.amazonToggleTf)

		getToggleState = var_5

		local var_24_6 = var_5(arg_5_0.yostarToggleTf)
		local var_24_8

		if var_24_1 then
			pg = var_24_8

			local var_24_7 = var_24_8.SdkMgr.GetInstance()

			var_24_8 = var_24_8.LoginWithSocial
			AIRI_PLATFORM_TWITTER = var_2_10008

			var_24_8(var_24_7, var_2_10008)
		elseif var_24_2 then
			local var_24_9 = arg_5_0

			var_24_8 = var_24_8.emit
			LoginSceneConst = var_2_10008
			var_2_10008 = var_2_10008.SWITCH_SUB_VIEW

			local var_24_10 = {}

			LoginSceneConst = var_2_10010
			var_24_10[1] = var_2_10010.DEFINE.TRANSCODE_ALERT_VIEW
			LoginSceneConst = var_2_10010
			var_24_10[2] = var_2_10010.DEFINE.AIRI_LOGIN_PANEL_VIEW
			LoginSceneConst = var_2_10010
			var_24_10[3] = var_2_10010.DEFINE.PRESS_TO_LOGIN

			var_24_8(var_24_9, var_2_10008, var_24_10)
		elseif var_24_3 then
			pg = var_24_8

			local var_24_11 = var_24_8.SdkMgr.GetInstance()

			var_24_8.LoginWithDevice(var_24_11)
		elseif var_24_4 then
			pg = var_24_8

			local var_24_12 = var_24_8.SdkMgr.GetInstance()

			var_24_8 = var_24_8.LoginWithSocial
			AIRI_PLATFORM_APPLE = var_2_10008

			var_24_8(var_24_12, var_2_10008)
		elseif var_24_5 then
			pg = var_24_8

			local var_24_13 = var_24_8.SdkMgr.GetInstance()
			local var_24_14 = var_6.LoginWithSocial

			AIRI_PLATFORM_AMAZON = var_2_10008

			var_24_14(var_24_13, var_2_10008)
		elseif var_24_6 then
			local var_24_15 = arg_5_0
			local var_24_16 = var_6.emit

			LoginSceneConst = var_2_10008

			local var_24_17 = var_2_10008.SWITCH_SUB_VIEW
			local var_24_18 = {}

			LoginSceneConst = var_2_10010
			var_24_18[1] = var_2_10010.DEFINE.YOSTAR_ALERT_VIEW
			LoginSceneConst = var_10
			var_24_18[2] = var_10.DEFINE.AIRI_LOGIN_PANEL_VIEW
			LoginSceneConst = var_10
			var_24_18[3] = var_10.DEFINE.PRESS_TO_LOGIN

			var_24_16(var_24_15, var_24_17, var_24_18)
		end

		var_5_0()

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	return
end

return var_0_1

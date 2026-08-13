local var_0_0 = {}

AiriJPSdkMgr = var_0_10001

local var_0_1 = var_0_10001.inst

AiriJPSdkMgr = var_0_10002

local var_0_2 = var_0_10002.AiriSDKInst

AiriJPSdkMgr = var_0_10003

local var_0_3 = var_0_10003.AiriSdkDataInst
local var_0_4 = "facebook"
local var_0_5 = AIRI_PLATFORM_FACEBOOK
local var_0_6 = "twitter"
local var_0_7 = AIRI_PLATFORM_TWITTER
local var_0_8 = "yostar"
local var_0_9 = AIRI_PLATFORM_YOSTAR
local var_0_10 = "apple"
local var_0_11 = AIRI_PLATFORM_APPLE
local var_0_12 = "amazon"
local var_0_13 = AIRI_PLATFORM_AMAZON
local var_0_14 = "gps"
local var_0_15 = AIRI_PLATFORM_GPS
local var_0_16 = false
local var_0_17 = AIRI_SDK_INITED

var_0_0.OnAiriBuying = -1
var_0_0.BuyingLimit = 60
var_0_0.isCache = false

function var_0_0.CheckAudit()
	NetConst = var_1_10000

	return var_1_10000.getwayType == 1
end

function var_0_0.CheckPreAudit()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_PORT == 30001 then
		NetConst = var_0

		local var_2_0

		if var_0.GATEWAY_HOST ~= "blhxjpauditapi.azurlane.jp" then
			var_2_0 = false
		else
			var_2_0 = true
		end

		NetConst = var_1_10001

		if var_1_10001.GATEWAY_PORT == 21 then
			NetConst = var_1

			local var_2_1

			if var_1.GATEWAY_HOST ~= "blhxjpauditapi.azurlane.jp" then
				var_2_1 = false
			else
				var_2_1 = true
			end

			return var_2_0 or var_2_1
		end
	end
end

function var_0_0.CheckPretest()
	IsUnityEditor = var_1_10000
	var_1_10000 = var_1_10000 or var_0_0.CheckPreAudit()

	return var_1_10000
end

function var_0_0.CheckGoogleSimulator()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_PORT == 4001 then
		NetConst = var_0

		local var_4_0

		if var_0.GATEWAY_HOST ~= "business.azurlane.jp" then
			var_4_0 = false
		else
			var_4_0 = true
		end

		return var_4_0
	end
end

function var_0_0.GoSDkLoginScene()
	local var_5_0 = var_0_1

	var_0.GoLoginScene(var_5_0)
	var_0_0.AiriInit()

	return
end

function var_0_0.AiriInit(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_6_0)

	local var_6_1 = var_0_1

	var_1.InitSdk(var_6_1)

	print = var_1

	local var_6_2 = "CSharpVersion:"

	tostring = var_1_10003
	CSharpVersion = var_1_10004

	var_1(var_6_2 .. var_1_10003(var_1_10004))

	return
end

function var_0_0.AiriLogin()
	pg = var_1_10000

	local var_7_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_7_0)

	local var_7_1 = var_0_1

	var_0.Login(var_7_1)

	return
end

function var_0_0.LoginWithDevice()
	pg = var_1_10000

	local var_8_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_8_0)

	local var_8_1 = var_0_1

	var_0.LoginWithDevice(var_8_1)

	return
end

function var_0_0.LoginWithSocial(arg_9_0, arg_9_1, arg_9_2)
	pg = var_1_10003

	local var_9_0 = var_1_10003.UIMgr.GetInstance()

	var_3.LoadingOn(var_9_0)

	AIRI_PLATFORM_FACEBOOK = var_3

	if arg_9_0 == var_3 then
		local var_9_1 = var_0_1

		var_3.LoginWithFB(var_9_1)
	else
		AIRI_PLATFORM_TWITTER = var_3

		if arg_9_0 == var_3 then
			local var_9_2 = var_0_1

			var_3.LoginWithTW(var_9_2)
		else
			AIRI_PLATFORM_YOSTAR = var_3

			if arg_9_0 == var_3 then
				local var_9_3 = var_0_1

				var_3.LoginWithSDKAccount(var_9_3, arg_9_1, arg_9_2)
			else
				AIRI_PLATFORM_APPLE = var_3

				if arg_9_0 == var_3 then
					local var_9_4 = var_0_1

					var_3.LoginWithApple(var_9_4)
				else
					AIRI_PLATFORM_AMAZON = var_3

					if arg_9_0 == var_3 then
						local var_9_5 = var_0_1

						var_3.LoginWithAmazon(var_9_5)
					end
				end
			end
		end
	end

	return
end

function var_0_0.LoginWithTranscode(arg_10_0, arg_10_1)
	pg = var_1_10002

	local var_10_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOn(var_10_0)

	local var_10_1 = var_0_1

	var_2.LoginWithTranscode(var_10_1, arg_10_0, arg_10_1)

	return
end

function var_0_0.TranscodeRequest()
	pg = var_1_10000

	local var_11_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_11_0)

	local var_11_1 = var_0_1

	var_0.TranscodeRequest(var_11_1)

	return
end

function var_0_0.AiriBuy(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_0

	Time = var_1_10004
	var_12_0.OnAiriBuying = var_1_10004.realtimeSinceStartup

	if arg_12_1 == "audit" then
		local var_12_1 = var_0_1
		local var_12_2 = var_3.NewBuy
		local var_12_3 = arg_12_0

		Airisdk = var_1_10006

		var_12_2(var_12_1, var_12_3, var_1_10006.BuyServerTag.audit, arg_12_2)
	elseif arg_12_1 == "preAudit" then
		local var_12_4 = var_0_1
		local var_12_5 = var_3.NewBuy
		local var_12_6 = arg_12_0

		Airisdk = var_1_10006

		var_12_5(var_12_4, var_12_6, var_1_10006.BuyServerTag.preAudit, arg_12_2)
	elseif arg_12_1 == "production" then
		local var_12_7 = var_0_1
		local var_12_8 = var_3.NewBuy
		local var_12_9 = arg_12_0

		Airisdk = var_1_10006

		var_12_8(var_12_7, var_12_9, var_1_10006.BuyServerTag.production, arg_12_2)
	elseif arg_12_1 == "test" then
		local var_12_10 = var_0_1
		local var_12_11 = var_3.NewBuy
		local var_12_12 = arg_12_0

		Airisdk = var_1_10006

		var_12_11(var_12_10, var_12_12, var_1_10006.BuyServerTag.test, arg_12_2)
	end

	return
end

function var_0_0.LinkSocial(arg_13_0, arg_13_1, arg_13_2)
	var_0_0.SetAiriTimeout()

	AIRI_PLATFORM_FACEBOOK = var_13_1

	local var_13_1

	if arg_13_0 == var_13_1 then
		local var_13_0 = var_0_1

		var_13_1 = var_13_1.LinkSocial
		Airisdk = var_1_10005

		var_13_1(var_13_0, var_1_10005.LoginPlatform.FACEBOOK)
	else
		AIRI_PLATFORM_TWITTER = var_13_1

		if arg_13_0 == var_13_1 then
			local var_13_2 = var_0_1

			var_13_1 = var_13_1.LinkSocial
			Airisdk = var_1_10005

			var_13_1(var_13_2, var_1_10005.LoginPlatform.TWITTER)
		else
			AIRI_PLATFORM_YOSTAR = var_13_1

			if arg_13_0 == var_13_1 then
				local var_13_3 = var_0_1

				var_13_1 = var_13_1.LinkSocial
				Airisdk = var_1_10005

				var_13_1(var_13_3, var_1_10005.LoginPlatform.YOSTAR, arg_13_1, arg_13_2)
			else
				AIRI_PLATFORM_APPLE = var_13_1

				if arg_13_0 == var_13_1 then
					local var_13_4 = var_0_1

					var_13_1 = var_13_1.LinkSocial
					Airisdk = var_1_10005

					var_13_1(var_13_4, var_1_10005.LoginPlatform.APPLE)
				else
					AIRI_PLATFORM_AMAZON = var_13_1

					if arg_13_0 == var_13_1 then
						local var_13_5 = var_0_1
						local var_13_6 = var_3.LinkSocial

						Airisdk = var_1_10005

						var_13_6(var_13_5, var_1_10005.LoginPlatform.AMAZON)
					end
				end
			end
		end
	end

	return
end

function var_0_0.UnlinkSocial(arg_14_0)
	var_0_0.SetAiriTimeout()

	AIRI_PLATFORM_FACEBOOK = var_14_1

	local var_14_1

	if arg_14_0 == var_14_1 then
		local var_14_0 = var_0_1

		var_14_1 = var_14_1.UnlinkSocial
		Airisdk = var_1_10003

		var_14_1(var_14_0, var_1_10003.LoginPlatform.FACEBOOK)
	else
		AIRI_PLATFORM_TWITTER = var_14_1

		if arg_14_0 == var_14_1 then
			local var_14_2 = var_0_1

			var_14_1 = var_14_1.UnlinkSocial
			Airisdk = var_1_10003

			var_14_1(var_14_2, var_1_10003.LoginPlatform.TWITTER)
		else
			AIRI_PLATFORM_APPLE = var_14_1

			if arg_14_0 == var_14_1 then
				local var_14_3 = var_0_1

				var_14_1 = var_14_1.UnlinkSocial
				Airisdk = var_1_10003

				var_14_1(var_14_3, var_1_10003.LoginPlatform.APPLE)
			else
				AIRI_PLATFORM_AMAZON = var_14_1

				if arg_14_0 == var_14_1 then
					local var_14_4 = var_0_1

					var_14_1 = var_14_1.UnlinkSocial
					Airisdk = var_1_10003

					var_14_1(var_14_4, var_1_10003.LoginPlatform.AMAZON)
				else
					AIRI_PLATFORM_GPS = var_14_1

					if arg_14_0 == var_14_1 then
						local var_14_5 = var_0_1
						local var_14_6 = var_1.UnlinkSocial

						Airisdk = var_1_10003

						var_14_6(var_14_5, var_1_10003.LoginPlatform.GOOGLEPLAY)
					end
				end
			end
		end
	end

	return
end

function var_0_0.IsSocialLink(arg_15_0)
	if not var_0_0.GetIsPlatform() then
		return false
	end

	AIRI_PLATFORM_FACEBOOK = var_15_1

	local var_15_1

	if arg_15_0 == var_15_1 then
		local var_15_0 = var_0_1

		var_15_1 = var_15_1.CheckPlatformLink
		Airisdk = var_1_10003

		return var_15_1(var_15_0, var_1_10003.LoginPlatform.FACEBOOK)
	else
		AIRI_PLATFORM_TWITTER = var_15_1

		if arg_15_0 == var_15_1 then
			local var_15_2 = var_0_1

			var_15_1 = var_15_1.CheckPlatformLink
			Airisdk = var_1_10003

			return var_15_1(var_15_2, var_1_10003.LoginPlatform.TWITTER)
		else
			AIRI_PLATFORM_YOSTAR = var_15_1

			if arg_15_0 == var_15_1 then
				local var_15_3 = var_0_1

				var_15_1 = var_15_1.CheckPlatformLink
				Airisdk = var_1_10003

				return var_15_1(var_15_3, var_1_10003.LoginPlatform.YOSTAR)
			else
				AIRI_PLATFORM_APPLE = var_15_1

				if arg_15_0 == var_15_1 then
					local var_15_4 = var_0_1

					var_15_1 = var_15_1.CheckPlatformLink
					Airisdk = var_1_10003

					return var_15_1(var_15_4, var_1_10003.LoginPlatform.APPLE)
				else
					AIRI_PLATFORM_AMAZON = var_15_1

					if arg_15_0 == var_15_1 then
						local var_15_5 = var_0_1

						var_15_1 = var_15_1.CheckPlatformLink
						Airisdk = var_1_10003

						return var_15_1(var_15_5, var_1_10003.LoginPlatform.AMAZON)
					else
						AIRI_PLATFORM_GPS = var_15_1

						if arg_15_0 == var_15_1 then
							local var_15_6 = var_0_1
							local var_15_7 = var_1.CheckPlatformLink

							Airisdk = var_1_10003

							return var_15_7(var_15_6, var_1_10003.LoginPlatform.GOOGLEPLAY)
						end
					end
				end
			end
		end
	end

	return false
end

function var_0_0.GetSocialName(arg_16_0)
	AIRI_PLATFORM_FACEBOOK = var_1_10001

	if arg_16_0 == var_1_10001 then
		return var_0_1.loginRet.FACEBOOK_NAME
	else
		AIRI_PLATFORM_TWITTER = var_1_10001

		if arg_16_0 == var_1_10001 then
			return var_0_1.loginRet.TWITTER_NAME
		else
			AIRI_PLATFORM_YOSTAR = var_1_10001

			if arg_16_0 == var_1_10001 then
				return var_0_1.loginRet.SDK_NAME
			else
				AIRI_PLATFORM_APPLE = var_1_10001

				if arg_16_0 == var_1_10001 then
					return var_0_1.loginRet.APPLE_ID
				else
					AIRI_PLATFORM_AMAZON = var_1_10001

					if arg_16_0 == var_1_10001 then
						return var_0_1.loginRet.AMAZON_NAME
					else
						AIRI_PLATFORM_GPS = var_1_10001

						if arg_16_0 == var_1_10001 then
							return var_0_1.loginRet.GOOGLE_PLAY_GAME_NAME
						end
					end
				end
			end
		end
	end

	return ""
end

function var_0_0.SetBirth(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_17_0)

	local var_17_1 = var_0_1

	var_1.SetBirth(var_17_1, arg_17_0)

	return
end

function var_0_0.GetIsBirthSet()
	local var_18_0 = var_0_1

	return var_0.IsBirthSet(var_18_0)
end

function var_0_0.ClearAccountCache()
	local var_19_0 = var_0_1

	var_0.ClearAccountCache(var_19_0)

	return
end

function var_0_0.GameShare(arg_20_0, arg_20_1)
	local var_20_0 = var_0_1

	var_2.SystemShare(var_20_0, arg_20_0, arg_20_1)

	return
end

function var_0_0.VerificationCodeReq(arg_21_0)
	local var_21_0 = var_0_1

	var_1.VerificationCodeReq(var_21_0, arg_21_0)

	Time = var_1

	local var_21_1 = var_1.realtimeSinceStartup
	local var_21_2 = AIRI_LAST_GEN_TIME

	return
end

function var_0_0.OpenYostarHelp()
	local var_22_0 = var_0_2

	var_0.OpenHelpShift(var_22_0)

	return
end

function var_0_0.GetYostarUid()
	return var_0_1.loginRet.UID
end

function var_0_0.GetDeviceId()
	local var_24_0 = var_0_2

	return var_0.GetDeviceID(var_24_0)
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GetChannelUID()
	local var_27_0 = var_0_1.channelUID

	originalPrint = var_1_10001

	var_1_10001("channelUID : " .. var_27_0)

	return var_27_0
end

function var_0_0.GetTransCode()
	IsUnityEditor = var_1_10000

	if var_1_10000 then
		return "NULL"
	else
		return var_0_1.loginRet.MIGRATIONCODE
	end

	return
end

function var_0_0.UserEventUpload(arg_29_0)
	if var_0_0.GetIsPlatform() then
		local var_29_0 = var_0_1

		var_1.UserEventUpload(var_29_0, arg_29_0)
	end

	return
end

function var_0_0.ShowSurvey(arg_30_0, arg_30_1)
	if var_0_0.GetIsPlatform() then
		getProxy = var_2
		PlayerProxy = var_1_10003

		local var_30_0 = var_2(var_1_10003)
		local var_30_1 = var_2.getData(var_30_0)
		local var_30_2 = var_0_2
		local var_30_3 = var_4.ShowSurvey
		local var_30_4 = arg_30_0

		tostring = var_1_10007

		var_30_3(var_30_2, var_30_4, var_1_10007(var_30_1.id), arg_30_1)
	end

	return
end

function var_0_0.Survey(arg_31_0)
	Application = var_1_10001

	var_1_10001.OpenURL(arg_31_0)

	return
end

function var_0_0.OnAndoridBackPress()
	PressBack = var_1_10000

	var_1_10000()

	return
end

function var_0_0.BindCPU()
	return
end

function var_0_0.CheckAiriCanBuy()
	if var_0_0.OnAiriBuying ~= -1 then
		Time = var_0

		if var_0.realtimeSinceStartup - var_0_0.OnAiriBuying > var_0_0.BuyingLimit then
			return true
		else
			return false
		end

		return
	end
end

function var_0_0.CheckHadAccountCache()
	if var_0_0.GetIsPlatform() then
		local var_35_0 = var_0_1
		local var_35_1

		if not var_0.CheckHadAccountCache(var_35_0) then
			var_35_1 = var_0_0.isCache
		end

		return var_35_1
	else
		return true
	end

	return
end

function var_0_0.AccountDelete()
	pg = var_1_10000

	local var_36_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_36_0)

	local var_36_1 = var_0_1

	var_0.AccountDeleteReq(var_36_1)

	return
end

function var_0_0.AccountReborn()
	pg = var_1_10000

	local var_37_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_37_0)

	local var_37_1 = var_0_1

	var_0.AccountRebornReq(var_37_1)

	return
end

function var_0_0.ConfirmLinkGooglePlayGame()
	local var_38_0 = var_0_1

	var_0.ConfirmLinkGooglePlayGame(var_38_0)

	return
end

function var_0_0.ConfirmUnLinkGooglePlayGame()
	local var_39_0 = var_0_1

	var_0.ConfirmUnLinkGooglePlayGame(var_39_0)

	return
end

function var_0_0.BindYostarPass()
	local var_40_0 = var_0_1

	var_0.BindYostarPassReq(var_40_0)

	return
end

local function var_0_18()
	print = var_1_10000

	var_1_10000("JP do nothing")

	return
end

local var_0_19 = GoLoginScene

local function var_0_20(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_42_0)

	if var_0_0.AiriResultCodeHandler(arg_42_0.R_CODE) then
		local var_42_1 = true

		OnAppPauseForSDK = AIRI_SDK_INITED

		var_1(false)

		AiriGoLogin = var_1

		var_1()
	end

	return
end

local var_0_21 = AiriInitResult

local function var_0_22(arg_43_0)
	pg = var_1_10001

	local var_43_0 = var_1_10001.m02
	local var_43_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_43_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_43_1(var_43_0, var_43_2, var_1_10004.LOGIN, {
		loginPlatform = arg_43_0
	})

	gcAll = var_43_1

	var_43_1()

	return
end

local var_0_23 = AiriGoLogin

local function var_0_24(arg_44_0)
	pg = var_1_10001

	local var_44_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_44_0)

	local function var_44_1()
		User = var_2_10000

		local var_45_0 = var_2_10000.New
		local var_45_1 = {
			type = 1
		}

		PLATFORM_YOSTARJP = var_2_10002
		var_45_1.arg1 = var_2_10002
		var_45_1.arg2 = arg_44_0.UID
		var_45_1.arg3 = arg_44_0.ACCESS_TOKEN

		local var_45_2 = var_45_0(var_45_1)

		pg = var_45_1

		local var_45_3 = var_45_1.m02
		local var_45_4 = var_1.sendNotification

		GAME = var_2_10003

		var_45_4(var_45_3, var_2_10003.PLATFORM_LOGIN_DONE, {
			user = var_45_2
		})

		return
	end

	if var_0_0.AiriYoStarPassMigrateHandler(arg_44_0) then
		return
	end

	if var_0_0.AiriResultCodeHandler(arg_44_0.R_CODE) then
		var_44_1()

		var_0_0.isCache = true
	else
		if var_0_0.AiriPGSResultCodeHandler(arg_44_0.R_CODE, function()
			var_44_1()

			var_0_0.isCache = true

			return
		end) then
			return
		end

		local var_44_2 = arg_44_0.R_CODE

		if var_4.ToInt(var_44_2) == 9 then
			pg = var_44_2

			local var_44_3 = var_44_2.TimeMgr.GetInstance()

			var_44_2 = var_44_2.GetServerTime(var_44_3)
			tonumber = var_44_3
			string = var_1_10007

			local var_44_4 = var_1_10007.sub
			local var_44_5 = arg_44_0.R_DELETETIME
			local var_44_6 = 1

			string = var_1_10010

			if var_44_2 < var_44_3(var_44_4(var_44_5, var_44_6, var_1_10010.len(arg_44_0.R_DELETETIME) - 3)) then
				pg = var_7

				local var_44_7 = var_7.TimeMgr.GetInstance()
				local var_44_8 = var_7.CTimeDescC(var_44_7, var_6, "%Y-%m-%d %H:%M:%S")

				pg = var_44_7

				local var_44_9 = var_44_7.MsgboxMgr.GetInstance()
				local var_44_10 = var_8.ShowMsgBox
				local var_44_11 = {
					modal = true
				}

				i18n = var_11
				var_44_11.content = var_11("box_account_reborn_content", var_44_8)

				function var_44_11.onYes()
					var_0_0.AccountReborn()

					return
				end

				var_44_10(var_44_9, var_44_11)
			end
		else
			originalPrint = var_44_2

			var_44_2("AiriLogin failed")
		end
	end

	return
end

local var_0_25 = AiriLogin

local function var_0_26(arg_48_0)
	pg = var_1_10001

	local var_48_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_48_0)

	if var_0_0.AiriResultCodeHandler(arg_48_0.R_CODE) then
		pg = var_1

		local var_48_1 = var_1.m02
		local var_48_2 = var_1.sendNotification

		GAME = var_1_10003

		var_48_2(var_48_1, var_1_10003.ON_GET_TRANSCODE, {
			transcode = arg_48_0.MIGRATIONCODE
		})
	end

	return
end

local var_0_27 = AiriTranscodeResult

local function var_0_28(arg_49_0)
	local var_49_0 = var_0_0

	var_49_0.OnAiriBuying = -1
	pg = var_49_0

	local var_49_1 = var_49_0.UIMgr.GetInstance()

	var_1.LoadingOff(var_49_1)

	local var_49_2, var_49_3

	if var_0_0.AiriResultCodeHandler(arg_49_0.R_CODE) then
		getProxy = var_49_3
		ShopsProxy = var_49_2
		var_49_2 = var_49_3(var_49_2)

		var_49_3.removeWaitTimer(var_49_2)

		pg = var_49_3
		var_49_2 = var_49_3.m02
		var_49_3 = var_49_3.sendNotification
		GAME = var_1_10003

		var_49_3(var_49_2, var_1_10003.CHARGE_CONFIRM, {
			payId = arg_49_0.EXTRADATA,
			bsId = arg_49_0.ORDERID
		})
	else
		getProxy = var_49_3
		ShopsProxy = var_49_2

		local var_49_4 = var_49_3(var_49_2)

		var_1.removeWaitTimer(var_49_4)

		pg = var_1

		local var_49_5 = var_1.m02
		local var_49_6 = var_1.sendNotification

		GAME = var_1_10003

		var_49_6(var_49_5, var_1_10003.CHARGE_FAILED, {
			payId = arg_49_0.EXTRADATA
		})
	end

	return
end

local var_0_29 = AiriBuyResult

local function var_0_30(arg_50_0)
	pg = var_1_10001

	local var_50_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_50_0)

	if var_0_0.AiriResultCodeHandler(arg_50_0.R_CODE) then
		pg = var_1

		local var_50_1 = var_1.TipsMgr.GetInstance()
		local var_50_2 = var_1.ShowTips

		i18n = var_1_10003

		var_50_2(var_50_1, var_1_10003("set_birth_success"))
	end

	return
end

local var_0_31 = SetBirthResult

local function var_0_32(arg_51_0)
	var_0_0.EndAiriTimeout()

	if var_0_0.AiriResultCodeHandler(arg_51_0.R_CODE) then
		pg = var_1

		local var_51_0 = var_1.m02
		local var_51_1 = var_1.sendNotification

		GAME = var_1_10003

		var_51_1(var_51_0, var_1_10003.ON_SOCIAL_LINKED)
	end

	return
end

local var_0_33 = LinkSocialResult

local function var_0_34(arg_52_0)
	var_0_0.EndAiriTimeout()

	if var_0_0.AiriResultCodeHandler(arg_52_0.R_CODE) then
		pg = var_1

		local var_52_0 = var_1.m02
		local var_52_1 = var_1.sendNotification

		GAME = var_1_10003

		var_52_1(var_52_0, var_1_10003.ON_SOCIAL_UNLINKED)
	elseif var_0_0.AiriPGSResultCodeHandler(arg_52_0.R_CODE) then
		return
	end

	return
end

local var_0_35 = UnlinkSocialResult

local function var_0_36(arg_53_0)
	pg = var_1_10001

	local var_53_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_53_0)

	if var_0_0.AiriResultCodeHandler(arg_53_0.R_CODE) then
		pg = var_1

		local var_53_1 = var_1.MsgboxMgr.GetInstance()
		local var_53_2 = var_1.ShowMsgBox
		local var_53_3 = {
			hideNo = true
		}

		i18n = var_1_10004
		var_53_3.content = var_1_10004("verification_code_req_tip2")

		var_53_2(var_53_1, var_53_3)
	end

	return
end

local var_0_37 = VerificationCodeResult

local function var_0_38(arg_54_0)
	AIRI_SDK_INITED = var_1_10001

	if not var_1_10001 then
		return
	end

	if arg_54_0 then
		local var_54_0 = var_0_2

		var_1.OnPause(var_54_0)
	else
		local var_54_1 = var_0_2

		var_1.OnResume(var_54_1)
	end

	return
end

local var_0_39 = OnAppPauseForSDK

local function var_0_40(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	pg = var_1_10005

	local var_55_0 = var_1_10005.UIMgr.GetInstance()

	var_5.LoadingOff(var_55_0)

	local var_55_1 = {
		ToInt = function()
			return arg_55_0
		end
	}

	if var_0_0.AiriResultCodeHandler(var_55_1) then
		tonumber = var_6
		string = var_7

		local var_55_2 = var_7.sub
		local var_55_3 = arg_55_3
		local var_55_4 = 1

		string = var_1_10010

		local var_55_5 = var_6(var_55_2(var_55_3, var_55_4, var_1_10010.len(arg_55_3) - 3))

		pg = var_7

		local var_55_6 = var_7.TimeMgr.GetInstance()
		local var_55_7 = var_7.CTimeDescC(var_55_6, var_55_5, "%Y-%m-%d %H:%M:%S")

		pg = var_55_6

		local var_55_8 = var_55_6.MsgboxMgr.GetInstance()
		local var_55_9 = var_8.ShowMsgBox
		local var_55_10 = {
			modal = true,
			hideNo = true
		}

		i18n = var_11
		var_55_10.content = var_11("box_account_del_success_content", var_55_7)

		function var_55_10.onYes()
			pg = var_2_10000

			local var_57_0 = var_2_10000.m02
			local var_57_1 = var_0.sendNotification

			GAME = var_2_10002

			var_57_1(var_57_0, var_2_10002.LOGOUT, {
				code = 0
			})

			return
		end

		function var_55_10.onClose()
			pg = var_2_10000

			local var_58_0 = var_2_10000.m02
			local var_58_1 = var_0.sendNotification

			GAME = var_2_10002

			var_58_1(var_58_0, var_2_10002.LOGOUT, {
				code = 0
			})

			return
		end

		var_55_9(var_55_8, var_55_10)
	end

	return
end

local var_0_41 = AccountDeleteResult

local function var_0_42(arg_59_0, arg_59_1)
	pg = var_1_10002

	local var_59_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOff(var_59_0)

	local var_59_1 = {
		ToInt = function()
			return arg_59_0
		end
	}

	if var_0_0.AiriResultCodeHandler(var_59_1) then
		pg = var_3

		local var_59_2 = var_3.TipsMgr.GetInstance()
		local var_59_3 = var_3.ShowTips

		i18n = var_1_10005

		var_59_3(var_59_2, var_1_10005("tip_account_del_reborn"))
	end

	return
end

local var_0_43 = AccountRebornResult

local function var_0_44(arg_61_0, arg_61_1)
	local var_61_0 = {
		ToInt = function()
			return arg_61_0
		end
	}

	if var_0_0.AiriResultCodeHandler(var_61_0) then
		pg = var_3

		local var_61_1 = var_3.TipsMgr.GetInstance()
		local var_61_2 = var_3.ShowTips

		i18n = var_1_10005

		var_61_2(var_61_1, var_1_10005("new_airi_error_code_0"))
	end

	return
end

local var_0_45 = BindYostarPassResult

local function var_0_46(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	warning = var_1_10004

	var_1_10004("OnYoStarMessageReceivedRespone")

	return
end

local var_0_47 = OnYoStarMessageReceivedRespone

function var_0_0.AiriResultCodeHandler(arg_64_0)
	local var_64_0 = arg_64_0:ToInt()
	local var_64_1 = ":" .. var_64_0

	if var_64_0 == 0 then
		return true
	else
		local var_64_2 = {
			100233,
			100201,
			100202,
			100203,
			100204,
			100205,
			100206,
			100214
		}

		table = var_1_10004

		if var_1_10004.contains(var_64_2, var_64_0) then
			return false
		end

		if var_64_0 == 14 then
			var_0_0.ClearAccountCache()
		end

		originalPrint = var_4

		var_4("SDK Error Code:" .. var_64_0)

		local var_64_3 = var_0_2
		local var_64_4 = var_4.GetSDKRecommendedErrorMsg
		local var_64_5 = var_64_0

		Airisdk = var_1_10007

		if var_64_4(var_64_3, var_64_5, var_1_10007.LanguageType.MSG_JP) then
			string = var_64_3

			if var_64_3.len(var_4) > 0 then
				pg = var_64_3

				local var_64_6 = var_64_3.TipsMgr.GetInstance()

				var_64_3.ShowTips(var_64_6, var_4)

				goto label_64_0
			end
		end

		i18n = var_64_3

		local var_64_7 = var_64_3("new_airi_error_code_" .. var_64_0)

		string = var_6

		local var_64_9

		if var_6.find(var_64_7, "UndefinedLanguage") then
			pg = var_64_9

			local var_64_8 = var_64_9.TipsMgr.GetInstance()

			var_64_9 = var_64_9.ShowTips
			i18n = var_8

			var_64_9(var_64_8, var_8("new_airi_error_code_other") .. var_64_1)
		else
			pg = var_64_9

			local var_64_10 = var_64_9.TipsMgr.GetInstance()

			var_6.ShowTips(var_64_10, var_64_7 .. var_64_1)
		end
	end

	::label_64_0::

	return false
end

function var_0_0.AiriPGSResultCodeHandler(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_0
	local var_65_1 = arg_65_0.ToInt(var_65_0)

	originalPrint = var_65_0

	local var_65_2 = "AiriPGSResultCodeHandler"

	tostring = var_1_10005

	var_65_0(var_65_2, var_1_10005(var_65_1))

	if var_65_1 == 100201 then
		pg = var_65_0

		local var_65_3 = var_65_0.MsgboxMgr.GetInstance()

		var_65_0 = var_65_0.ShowMsgBox

		local var_65_4 = {}

		i18n = var_6
		var_65_4.content = var_6("pgs_login_binding_exist2")

		function var_65_4.onYes()
			var_0_0.ConfirmLinkGooglePlayGame()

			return
		end

		var_65_0(var_65_3, var_65_4)

		return true
	elseif var_65_1 == 100202 then
		pg = var_65_0

		local var_65_5 = var_65_0.MsgboxMgr.GetInstance()

		var_65_0 = var_65_0.ShowMsgBox

		local var_65_6 = {}

		i18n = var_6
		var_65_6.content = var_6("pgs_login_binding_exist1")

		function var_65_6.onYes()
			var_0_0.ConfirmLinkGooglePlayGame()

			return
		end

		var_65_0(var_65_5, var_65_6)

		return true
	elseif var_65_1 == 100203 then
		pg = var_65_0

		local var_65_7 = var_65_0.MsgboxMgr.GetInstance()

		var_65_0 = var_65_0.ShowMsgBox

		local var_65_8 = {}

		i18n = var_6
		var_65_8.content = var_6("pgs_login_binding_exist3")

		function var_65_8.onYes()
			var_0_0.ConfirmLinkGooglePlayGame()

			return
		end

		var_65_0(var_65_7, var_65_8)

		return true
	elseif var_65_1 == 100204 then
		arg_65_1()

		return true
	elseif var_65_1 == 100205 then
		return true
	elseif var_65_1 == 100206 then
		pg = var_65_0

		local var_65_9 = var_65_0.MsgboxMgr.GetInstance()

		var_65_0 = var_65_0.ShowMsgBox

		local var_65_10 = {
			hideNo = true
		}

		i18n = var_6
		var_65_10.content = var_6("pgs_login_tip")

		function var_65_10.onYes()
			pg = var_2_10000

			local var_69_0 = var_2_10000.m02
			local var_69_1 = var_0.sendNotification

			GAME = var_2_10002

			var_69_1(var_69_0, var_2_10002.ON_SOCIAL_LINKED)

			return
		end

		function var_65_10.onClose()
			pg = var_2_10000

			local var_70_0 = var_2_10000.m02
			local var_70_1 = var_0.sendNotification

			GAME = var_2_10002

			var_70_1(var_70_0, var_2_10002.ON_SOCIAL_LINKED)

			return
		end

		var_65_0(var_65_9, var_65_10)

		return true
	elseif var_65_1 == 100214 then
		pg = var_65_0

		local var_65_11 = var_65_0.MsgboxMgr.GetInstance()
		local var_65_12 = var_3.ShowMsgBox
		local var_65_13 = {}

		i18n = var_6
		var_65_13.content = var_6("pgs_unbind_tip2")

		function var_65_13.onYes()
			var_0_0.ConfirmUnLinkGooglePlayGame()

			return
		end

		var_65_12(var_65_11, var_65_13)

		return true
	else
		return false
	end

	return
end

function var_0_0.AiriYoStarPassMigrateHandler(arg_72_0)
	local var_72_0 = {
		0,
		100204,
		100206
	}

	table = var_1_10002

	local var_72_1 = var_1_10002.contains
	local var_72_2 = var_72_0
	local var_72_3 = arg_72_0.R_CODE

	if var_72_1(var_72_2, var_4.ToInt(var_72_3)) and arg_72_0.SHOW_MIGRATE_PAGE == 1 then
		var_0_0.BindYostarPass()

		return true
	else
		return false
	end

	return
end

var_0_0.ON_AIRI_LOADING = false

function var_0_0.SetAiriTimeout()
	pg = var_1_10000

	local var_73_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_73_0)

	local var_73_1 = var_0_0

	var_73_1.ON_AIRI_LOADING = true
	onDelayTick = var_73_1

	var_73_1(function()
		if var_0_0.ON_AIRI_LOADING then
			pg = var_0

			local var_74_0 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_74_0)

			var_0_0.ON_AIRI_LOADING = false
		end

		return
	end, 15)

	return
end

function var_0_0.EndAiriTimeout()
	local var_75_0 = var_0_0

	var_75_0.ON_AIRI_LOADING = false
	pg = var_75_0

	local var_75_1 = var_75_0.UIMgr.GetInstance()

	var_0.LoadingOff(var_75_1)

	return
end

return var_0_0

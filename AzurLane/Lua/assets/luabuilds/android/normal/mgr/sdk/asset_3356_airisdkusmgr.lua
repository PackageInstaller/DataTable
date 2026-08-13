local var_0_0 = {}

AiriUSSdkMgr = var_0_10001

local var_0_1 = var_0_10001.inst

AiriUSSdkMgr = var_0_10002

local var_0_2 = var_0_10002.AiriSDKInst

AiriUSSdkMgr = var_0_10003

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

function var_0_0.CheckAudit()
	NetConst = var_1_10000

	return var_1_10000.getwayType == 1
end

function var_0_0.CheckPreAudit()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_PORT == 30001 then
		NetConst = var_0

		local var_2_0

		if var_0.GATEWAY_HOST ~= "audit.us.yo-star.com" then
			var_2_0 = false
		else
			var_2_0 = true
		end

		return var_2_0
	end
end

function var_0_0.CheckPretest()
	IsUnityEditor = var_1_10000
	var_1_10000 = var_1_10000 or var_0_0.CheckPreAudit()

	return var_1_10000
end

function var_0_0.CheckGoogleSimulator()
	NetConst = var_1_10000

	return var_1_10000.getwayType == 2
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

function var_0_0.LoginWithSocial(arg_8_0, arg_8_1, arg_8_2)
	pg = var_1_10003

	local var_8_0 = var_1_10003.UIMgr.GetInstance()

	var_3.LoadingOn(var_8_0)

	AIRI_PLATFORM_FACEBOOK = var_3

	if arg_8_0 == var_3 then
		local var_8_1 = var_0_1

		var_3.LoginWithFB(var_8_1)
	else
		AIRI_PLATFORM_TWITTER = var_3

		if arg_8_0 == var_3 then
			local var_8_2 = var_0_1

			var_3.LoginWithTW(var_8_2)
		else
			AIRI_PLATFORM_YOSTAR = var_3

			if arg_8_0 == var_3 then
				local var_8_3 = var_0_1

				var_3.LoginWithSDKAccount(var_8_3, arg_8_1, arg_8_2)
			else
				AIRI_PLATFORM_APPLE = var_3

				if arg_8_0 == var_3 then
					local var_8_4 = var_0_1

					var_3.LoginWithApple(var_8_4)
				else
					AIRI_PLATFORM_AMAZON = var_3

					if arg_8_0 == var_3 then
						local var_8_5 = var_0_1

						var_3.LoginWithAmazon(var_8_5)
					end
				end
			end
		end
	end

	return
end

function var_0_0.LoginWithTranscode(arg_9_0, arg_9_1)
	pg = var_1_10002

	local var_9_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOn(var_9_0)

	local var_9_1 = var_0_1

	var_2.LoginWithTranscode(var_9_1, arg_9_0, arg_9_1)

	return
end

function var_0_0.TranscodeRequest()
	pg = var_1_10000

	local var_10_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_10_0)

	local var_10_1 = var_0_1

	var_0.TranscodeRequest(var_10_1)

	return
end

function var_0_0.AiriBuy(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_0

	Time = var_1_10004
	var_11_0.OnAiriBuying = var_1_10004.realtimeSinceStartup

	if arg_11_1 == "audit" then
		local var_11_1 = var_0_1
		local var_11_2 = var_3.NewBuy
		local var_11_3 = arg_11_0

		Airisdk = var_1_10006

		var_11_2(var_11_1, var_11_3, var_1_10006.BuyServerTag.audit, arg_11_2)
	elseif arg_11_1 == "preAudit" then
		local var_11_4 = var_0_1
		local var_11_5 = var_3.NewBuy
		local var_11_6 = arg_11_0

		Airisdk = var_1_10006

		var_11_5(var_11_4, var_11_6, var_1_10006.BuyServerTag.preAudit, arg_11_2)
	elseif arg_11_1 == "production" then
		local var_11_7 = var_0_1
		local var_11_8 = var_3.NewBuy
		local var_11_9 = arg_11_0

		Airisdk = var_1_10006

		var_11_8(var_11_7, var_11_9, var_1_10006.BuyServerTag.production, arg_11_2)
	elseif arg_11_1 == "test" then
		local var_11_10 = var_0_1
		local var_11_11 = var_3.NewBuy
		local var_11_12 = arg_11_0

		Airisdk = var_1_10006

		var_11_11(var_11_10, var_11_12, var_1_10006.BuyServerTag.test, arg_11_2)
	end

	return
end

function var_0_0.LinkSocial(arg_12_0, arg_12_1, arg_12_2)
	var_0_0.SetAiriTimeout()

	AIRI_PLATFORM_FACEBOOK = var_12_1

	local var_12_1

	if arg_12_0 == var_12_1 then
		local var_12_0 = var_0_1

		var_12_1 = var_12_1.LinkSocial
		Airisdk = var_1_10005

		var_12_1(var_12_0, var_1_10005.LoginPlatform.FACEBOOK)
	else
		AIRI_PLATFORM_TWITTER = var_12_1

		if arg_12_0 == var_12_1 then
			local var_12_2 = var_0_1

			var_12_1 = var_12_1.LinkSocial
			Airisdk = var_1_10005

			var_12_1(var_12_2, var_1_10005.LoginPlatform.TWITTER)
		else
			AIRI_PLATFORM_YOSTAR = var_12_1

			if arg_12_0 == var_12_1 then
				local var_12_3 = var_0_1

				var_12_1 = var_12_1.LinkSocial
				Airisdk = var_1_10005

				var_12_1(var_12_3, var_1_10005.LoginPlatform.YOSTAR, arg_12_1, arg_12_2)
			else
				AIRI_PLATFORM_APPLE = var_12_1

				if arg_12_0 == var_12_1 then
					local var_12_4 = var_0_1

					var_12_1 = var_12_1.LinkSocial
					Airisdk = var_1_10005

					var_12_1(var_12_4, var_1_10005.LoginPlatform.APPLE)
				else
					AIRI_PLATFORM_AMAZON = var_12_1

					if arg_12_0 == var_12_1 then
						local var_12_5 = var_0_1
						local var_12_6 = var_3.LinkSocial

						Airisdk = var_1_10005

						var_12_6(var_12_5, var_1_10005.LoginPlatform.AMAZON)
					end
				end
			end
		end
	end

	return
end

function var_0_0.UnlinkSocial(arg_13_0)
	var_0_0.SetAiriTimeout()

	AIRI_PLATFORM_FACEBOOK = var_13_1

	local var_13_1

	if arg_13_0 == var_13_1 then
		local var_13_0 = var_0_1

		var_13_1 = var_13_1.UnlinkSocial
		Airisdk = var_1_10003

		var_13_1(var_13_0, var_1_10003.LoginPlatform.FACEBOOK)
	else
		AIRI_PLATFORM_TWITTER = var_13_1

		if arg_13_0 == var_13_1 then
			local var_13_2 = var_0_1

			var_13_1 = var_13_1.UnlinkSocial
			Airisdk = var_1_10003

			var_13_1(var_13_2, var_1_10003.LoginPlatform.TWITTER)
		else
			AIRI_PLATFORM_APPLE = var_13_1

			if arg_13_0 == var_13_1 then
				local var_13_3 = var_0_1

				var_13_1 = var_13_1.UnlinkSocial
				Airisdk = var_1_10003

				var_13_1(var_13_3, var_1_10003.LoginPlatform.APPLE)
			else
				AIRI_PLATFORM_AMAZON = var_13_1

				if arg_13_0 == var_13_1 then
					local var_13_4 = var_0_1

					var_13_1 = var_13_1.UnlinkSocial
					Airisdk = var_1_10003

					var_13_1(var_13_4, var_1_10003.LoginPlatform.AMAZON)
				else
					AIRI_PLATFORM_GPS = var_13_1

					if arg_13_0 == var_13_1 then
						local var_13_5 = var_0_1
						local var_13_6 = var_1.UnlinkSocial

						Airisdk = var_1_10003

						var_13_6(var_13_5, var_1_10003.LoginPlatform.GOOGLEPLAY)
					end
				end
			end
		end
	end

	return
end

function var_0_0.IsSocialLink(arg_14_0)
	if not var_0_0.GetIsPlatform() then
		return false
	end

	AIRI_PLATFORM_FACEBOOK = var_14_1

	local var_14_1

	if arg_14_0 == var_14_1 then
		local var_14_0 = var_0_1

		var_14_1 = var_14_1.CheckPlatformLink
		Airisdk = var_1_10003

		return var_14_1(var_14_0, var_1_10003.LoginPlatform.FACEBOOK)
	else
		AIRI_PLATFORM_TWITTER = var_14_1

		if arg_14_0 == var_14_1 then
			local var_14_2 = var_0_1

			var_14_1 = var_14_1.CheckPlatformLink
			Airisdk = var_1_10003

			return var_14_1(var_14_2, var_1_10003.LoginPlatform.TWITTER)
		else
			AIRI_PLATFORM_YOSTAR = var_14_1

			if arg_14_0 == var_14_1 then
				local var_14_3 = var_0_1

				var_14_1 = var_14_1.CheckPlatformLink
				Airisdk = var_1_10003

				return var_14_1(var_14_3, var_1_10003.LoginPlatform.YOSTAR)
			else
				AIRI_PLATFORM_APPLE = var_14_1

				if arg_14_0 == var_14_1 then
					local var_14_4 = var_0_1

					var_14_1 = var_14_1.CheckPlatformLink
					Airisdk = var_1_10003

					return var_14_1(var_14_4, var_1_10003.LoginPlatform.APPLE)
				else
					AIRI_PLATFORM_AMAZON = var_14_1

					if arg_14_0 == var_14_1 then
						local var_14_5 = var_0_1

						var_14_1 = var_14_1.CheckPlatformLink
						Airisdk = var_1_10003

						return var_14_1(var_14_5, var_1_10003.LoginPlatform.AMAZON)
					else
						AIRI_PLATFORM_GPS = var_14_1

						if arg_14_0 == var_14_1 then
							local var_14_6 = var_0_1
							local var_14_7 = var_1.CheckPlatformLink

							Airisdk = var_1_10003

							return var_14_7(var_14_6, var_1_10003.LoginPlatform.GOOGLEPLAY)
						end
					end
				end
			end
		end
	end

	return false
end

function var_0_0.GetSocialName(arg_15_0)
	AIRI_PLATFORM_FACEBOOK = var_1_10001

	if arg_15_0 == var_1_10001 then
		return var_0_1.loginRet.FACEBOOK_NAME
	else
		AIRI_PLATFORM_TWITTER = var_1_10001

		if arg_15_0 == var_1_10001 then
			return var_0_1.loginRet.TWITTER_NAME
		else
			AIRI_PLATFORM_YOSTAR = var_1_10001

			if arg_15_0 == var_1_10001 then
				return var_0_1.loginRet.SDK_NAME
			else
				AIRI_PLATFORM_APPLE = var_1_10001

				if arg_15_0 == var_1_10001 then
					return var_0_1.loginRet.APPLE_ID
				else
					AIRI_PLATFORM_AMAZON = var_1_10001

					if arg_15_0 == var_1_10001 then
						return var_0_1.loginRet.AMAZON_NAME
					else
						AIRI_PLATFORM_GPS = var_1_10001

						if arg_15_0 == var_1_10001 then
							return var_0_1.loginRet.GOOGLE_PLAY_GAME_NAME
						end
					end
				end
			end
		end
	end

	return ""
end

function var_0_0.SetBirth(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_16_0)

	local var_16_1 = var_0_1

	var_1.SetBirth(var_16_1, arg_16_0)

	return
end

function var_0_0.GetIsBirthSet()
	local var_17_0 = var_0_1

	return var_0.IsBirthSet(var_17_0)
end

function var_0_0.ClearAccountCache()
	local var_18_0 = var_0_1

	var_0.ClearAccountCache(var_18_0)

	return
end

function var_0_0.GameShare(arg_19_0, arg_19_1)
	local var_19_0 = var_0_1

	var_2.SystemShare(var_19_0, arg_19_0, arg_19_1)

	return
end

function var_0_0.VerificationCodeReq(arg_20_0)
	local var_20_0 = var_0_1

	var_1.VerificationCodeReq(var_20_0, arg_20_0)

	Time = var_1

	local var_20_1 = var_1.realtimeSinceStartup
	local var_20_2 = AIRI_LAST_GEN_TIME

	return
end

function var_0_0.OpenYostarHelp()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_21_0 = var_1_10000(var_1_10001)
	local var_21_1 = var_0.getData(var_21_0)

	getProxy = var_21_0
	UserProxy = var_1_10003

	local var_21_2 = var_21_0(var_1_10003)
	local var_21_3 = var_2.getData(var_21_2)

	getProxy = var_21_2
	ServerProxy = var_1_10005

	local var_21_4 = var_21_2(var_1_10005)
	local var_21_5 = var_4.getLastServer(var_21_4, var_21_3.uid)

	pg = var_21_4

	local var_21_6 = var_21_4.TimeMgr.GetInstance()
	local var_21_7 = var_6.STimeDescS(var_21_6, var_21_1.registerTime, "%Y-%m-%d %H:%M:%S")

	math = var_21_6

	local var_21_8 = var_21_6.modf(var_21_1.rmb / 100)

	originalPrint = var_8

	var_8("uid:" .. var_21_1.id .. ",name:" .. var_21_1.name .. ",level" .. var_21_1.level .. ",serverId:" .. var_21_5.id .. " - " .. var_21_5.name .. ",rmb:" .. var_21_8 .. ",createTime:" .. var_21_7)

	local var_21_9 = var_0_1
	local var_21_10 = var_8.OpenHelp

	tostring = var_10

	local var_21_11 = var_10(var_21_1.id)
	local var_21_12 = var_21_1.name

	tostring = var_12

	var_21_10(var_21_9, var_21_11, var_21_12, var_12(var_21_5.id .. " - " .. var_21_5.name), var_21_8, var_21_7)

	return
end

function var_0_0.GetYostarUid()
	return var_0_1.loginRet.UID
end

function var_0_0.GetDeviceId()
	local var_23_0 = var_0_2

	return var_0.GetDeviceID(var_23_0)
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GetChannelUID()
	local var_26_0 = var_0_1.channelUID

	originalPrint = var_1_10001

	var_1_10001("channelUID : " .. var_26_0)

	return var_26_0
end

function var_0_0.UserEventUpload(arg_27_0)
	if var_0_0.GetIsPlatform() then
		local var_27_0 = var_0_1

		var_1.UserEventUpload(var_27_0, arg_27_0)
	end

	return
end

function var_0_0.ShowSurvey(arg_28_0, arg_28_1)
	if var_0_0.GetIsPlatform() then
		getProxy = var_2
		PlayerProxy = var_1_10003

		local var_28_0 = var_2(var_1_10003)
		local var_28_1 = var_2.getData(var_28_0)
		local var_28_2 = var_0_2
		local var_28_3 = var_4.UserEventUpload
		local var_28_4 = arg_28_0

		tostring = var_1_10007

		var_28_3(var_28_2, var_28_4, var_1_10007(var_28_1.id), arg_28_1)
	end

	return
end

function var_0_0.Survey(arg_29_0)
	Application = var_1_10001

	var_1_10001.OpenURL(arg_29_0)

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

function var_0_0.AccountDelete()
	pg = var_1_10000

	local var_33_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_33_0)

	local var_33_1 = var_0_1

	var_0.AccountDeleteReq(var_33_1)

	return
end

function var_0_0.AccountReborn()
	pg = var_1_10000

	local var_34_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_34_0)

	local var_34_1 = var_0_1

	var_0.AccountRebornReq(var_34_1)

	return
end

function var_0_0.ConfirmLinkGooglePlayGame()
	local var_35_0 = var_0_1

	var_0.ConfirmLinkGooglePlayGame(var_35_0)

	return
end

function var_0_0.ConfirmUnLinkGooglePlayGame()
	local var_36_0 = var_0_1

	var_0.ConfirmUnLinkGooglePlayGame(var_36_0)

	return
end

function var_0_0.BindYostarPass()
	local var_37_0 = var_0_1

	var_0.BindYostarPassReq(var_37_0)

	return
end

local function var_0_18()
	print = var_1_10000

	var_1_10000("US do nothing")

	return
end

local var_0_19 = GoLoginScene

local function var_0_20(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_39_0)

	if var_0_0.AiriResultCodeHandler(arg_39_0.R_CODE) then
		local var_39_1 = true

		OnAppPauseForSDK = AIRI_SDK_INITED

		var_1(false)

		AiriGoLogin = var_1

		var_1()
	end

	return
end

local var_0_21 = AiriInitResult

local function var_0_22(arg_40_0)
	pg = var_1_10001

	local var_40_0 = var_1_10001.m02
	local var_40_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_40_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_40_1(var_40_0, var_40_2, var_1_10004.LOGIN, {
		loginPlatform = arg_40_0
	})

	gcAll = var_40_1

	var_40_1()

	return
end

local var_0_23 = AiriGoLogin

local function var_0_24(arg_41_0)
	pg = var_1_10001

	local var_41_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_41_0)

	local function var_41_1()
		User = var_2_10000

		local var_42_0 = var_2_10000.New
		local var_42_1 = {
			type = 1
		}

		PLATFORM_YOSTARUS = var_2_10002
		var_42_1.arg1 = var_2_10002
		var_42_1.arg2 = arg_41_0.UID
		var_42_1.arg3 = arg_41_0.ACCESS_TOKEN

		local var_42_2 = var_42_0(var_42_1)

		pg = var_42_1

		local var_42_3 = var_42_1.m02
		local var_42_4 = var_1.sendNotification

		GAME = var_2_10003

		var_42_4(var_42_3, var_2_10003.PLATFORM_LOGIN_DONE, {
			user = var_42_2
		})

		return
	end

	if var_0_0.AiriYoStarPassMigrateHandler(arg_41_0) then
		return
	end

	if var_0_0.AiriResultCodeHandler(arg_41_0.R_CODE) then
		var_41_1()
	else
		if var_0_0.AiriPGSResultCodeHandler(arg_41_0.R_CODE, function()
			var_41_1()

			return
		end) then
			return
		end

		local var_41_2 = arg_41_0.R_CODE

		if var_4.ToInt(var_41_2) == 9 then
			pg = var_41_2

			local var_41_3 = var_41_2.TimeMgr.GetInstance()

			var_41_2 = var_41_2.GetServerTime(var_41_3)
			tonumber = var_41_3
			string = var_1_10007

			local var_41_4 = var_1_10007.sub
			local var_41_5 = arg_41_0.R_DELETETIME
			local var_41_6 = 1

			string = var_1_10010

			if var_41_2 < var_41_3(var_41_4(var_41_5, var_41_6, var_1_10010.len(arg_41_0.R_DELETETIME) - 3)) then
				pg = var_7

				local var_41_7 = var_7.TimeMgr.GetInstance()
				local var_41_8 = var_7.CTimeDescC(var_41_7, var_6, "%Y-%m-%d %H:%M:%S")

				pg = var_41_7

				local var_41_9 = var_41_7.MsgboxMgr.GetInstance()
				local var_41_10 = var_8.ShowMsgBox
				local var_41_11 = {
					modal = true
				}

				i18n = var_11
				var_41_11.content = var_11("box_account_reborn_content", var_41_8)

				function var_41_11.onYes()
					var_0_0.AccountReborn()

					return
				end

				var_41_10(var_41_9, var_41_11)
			end
		else
			originalPrint = var_41_2

			var_41_2("AiriLogin failed")
		end
	end

	return
end

local var_0_25 = AiriLogin

local function var_0_26(arg_45_0)
	pg = var_1_10001

	local var_45_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_45_0)

	if var_0_0.AiriResultCodeHandler(arg_45_0.R_CODE) then
		pg = var_1

		local var_45_1 = var_1.m02
		local var_45_2 = var_1.sendNotification

		GAME = var_1_10003

		var_45_2(var_45_1, var_1_10003.ON_GET_TRANSCODE, {
			transcode = arg_45_0.MIGRATIONCODE
		})
	end

	return
end

local var_0_27 = AiriTranscodeResult

local function var_0_28(arg_46_0)
	local var_46_0 = var_0_0

	var_46_0.OnAiriBuying = -1
	pg = var_46_0

	local var_46_1 = var_46_0.UIMgr.GetInstance()

	var_1.LoadingOff(var_46_1)

	local var_46_2, var_46_3

	if var_0_0.AiriResultCodeHandler(arg_46_0.R_CODE) then
		getProxy = var_46_3
		ShopsProxy = var_46_2
		var_46_2 = var_46_3(var_46_2)

		var_46_3.removeWaitTimer(var_46_2)

		pg = var_46_3
		var_46_2 = var_46_3.m02
		var_46_3 = var_46_3.sendNotification
		GAME = var_1_10003

		var_46_3(var_46_2, var_1_10003.CHARGE_CONFIRM, {
			payId = arg_46_0.EXTRADATA,
			bsId = arg_46_0.ORDERID
		})
	else
		getProxy = var_46_3
		ShopsProxy = var_46_2

		local var_46_4 = var_46_3(var_46_2)

		var_1.removeWaitTimer(var_46_4)

		pg = var_1

		local var_46_5 = var_1.m02
		local var_46_6 = var_1.sendNotification

		GAME = var_1_10003

		var_46_6(var_46_5, var_1_10003.CHARGE_FAILED, {
			payId = arg_46_0.EXTRADATA
		})
	end

	return
end

local var_0_29 = AiriBuyResult

local function var_0_30(arg_47_0)
	pg = var_1_10001

	local var_47_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_47_0)

	if var_0_0.AiriResultCodeHandler(arg_47_0.R_CODE) then
		pg = var_1

		local var_47_1 = var_1.TipsMgr.GetInstance()
		local var_47_2 = var_1.ShowTips

		i18n = var_1_10003

		var_47_2(var_47_1, var_1_10003("set_birth_success"))
	end

	return
end

local var_0_31 = SetBirthResult

local function var_0_32(arg_48_0)
	var_0_0.EndAiriTimeout()

	if var_0_0.AiriResultCodeHandler(arg_48_0.R_CODE) then
		pg = var_1

		local var_48_0 = var_1.m02
		local var_48_1 = var_1.sendNotification

		GAME = var_1_10003

		var_48_1(var_48_0, var_1_10003.ON_SOCIAL_LINKED)
	end

	return
end

local var_0_33 = LinkSocialResult

local function var_0_34(arg_49_0)
	var_0_0.EndAiriTimeout()

	if var_0_0.AiriResultCodeHandler(arg_49_0.R_CODE) then
		pg = var_1

		local var_49_0 = var_1.m02
		local var_49_1 = var_1.sendNotification

		GAME = var_1_10003

		var_49_1(var_49_0, var_1_10003.ON_SOCIAL_UNLINKED)
	elseif var_0_0.AiriPGSResultCodeHandler(arg_49_0.R_CODE) then
		return
	end

	return
end

local var_0_35 = UnlinkSocialResult

local function var_0_36(arg_50_0)
	pg = var_1_10001

	local var_50_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOff(var_50_0)

	if var_0_0.AiriResultCodeHandler(arg_50_0.R_CODE) then
		pg = var_1

		local var_50_1 = var_1.MsgboxMgr.GetInstance()
		local var_50_2 = var_1.ShowMsgBox
		local var_50_3 = {
			hideNo = true
		}

		i18n = var_1_10004
		var_50_3.content = var_1_10004("verification_code_req_tip2")

		var_50_2(var_50_1, var_50_3)
	end

	return
end

local var_0_37 = VerificationCodeResult

local function var_0_38(arg_51_0)
	AIRI_SDK_INITED = var_1_10001

	if not var_1_10001 then
		return
	end

	if arg_51_0 then
		local var_51_0 = var_0_2

		var_1.OnPause(var_51_0)
	else
		local var_51_1 = var_0_2

		var_1.OnResume(var_51_1)
	end

	return
end

local var_0_39 = OnAppPauseForSDK

local function var_0_40(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	pg = var_1_10005

	local var_52_0 = var_1_10005.UIMgr.GetInstance()

	var_5.LoadingOff(var_52_0)

	local var_52_1 = {
		ToInt = function()
			return arg_52_0
		end
	}

	if var_0_0.AiriResultCodeHandler(var_52_1) then
		tonumber = var_6
		string = var_7

		local var_52_2 = var_7.sub
		local var_52_3 = arg_52_3
		local var_52_4 = 1

		string = var_1_10010

		local var_52_5 = var_6(var_52_2(var_52_3, var_52_4, var_1_10010.len(arg_52_3) - 3))

		pg = var_7

		local var_52_6 = var_7.TimeMgr.GetInstance()
		local var_52_7 = var_7.CTimeDescC(var_52_6, var_52_5, "%Y-%m-%d %H:%M:%S")

		pg = var_52_6

		local var_52_8 = var_52_6.MsgboxMgr.GetInstance()
		local var_52_9 = var_8.ShowMsgBox
		local var_52_10 = {
			modal = true,
			hideNo = true
		}

		i18n = var_11
		var_52_10.content = var_11("box_account_del_success_content", var_52_7)

		function var_52_10.onYes()
			pg = var_2_10000

			local var_54_0 = var_2_10000.m02
			local var_54_1 = var_0.sendNotification

			GAME = var_2_10002

			var_54_1(var_54_0, var_2_10002.LOGOUT, {
				code = 0
			})

			return
		end

		function var_52_10.onClose()
			pg = var_2_10000

			local var_55_0 = var_2_10000.m02
			local var_55_1 = var_0.sendNotification

			GAME = var_2_10002

			var_55_1(var_55_0, var_2_10002.LOGOUT, {
				code = 0
			})

			return
		end

		var_52_9(var_52_8, var_52_10)
	end

	return
end

local var_0_41 = AccountDeleteResult

local function var_0_42(arg_56_0, arg_56_1)
	pg = var_1_10002

	local var_56_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOff(var_56_0)

	local var_56_1 = {
		ToInt = function()
			return arg_56_0
		end
	}

	if var_0_0.AiriResultCodeHandler(var_56_1) then
		pg = var_3

		local var_56_2 = var_3.TipsMgr.GetInstance()
		local var_56_3 = var_3.ShowTips

		i18n = var_1_10005

		var_56_3(var_56_2, var_1_10005("tip_account_del_reborn"))
	end

	return
end

local var_0_43 = AccountRebornResult

local function var_0_44(arg_58_0, arg_58_1)
	local var_58_0 = {
		ToInt = function()
			return arg_58_0
		end
	}

	if var_0_0.AiriResultCodeHandler(var_58_0) then
		pg = var_3

		local var_58_1 = var_3.TipsMgr.GetInstance()
		local var_58_2 = var_3.ShowTips

		i18n = var_1_10005

		var_58_2(var_58_1, var_1_10005("new_airi_error_code_0"))
	end

	return
end

local var_0_45 = BindYostarPassResult

local function var_0_46(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	warning = var_1_10004

	var_1_10004("OnYoStarMessageReceivedRespone")

	return
end

local var_0_47 = OnYoStarMessageReceivedRespone

function var_0_0.AiriResultCodeHandler(arg_61_0)
	local var_61_0 = arg_61_0:ToInt()
	local var_61_1 = ":" .. var_61_0

	if var_61_0 == 0 then
		return true
	else
		local var_61_2 = {
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

		if var_1_10004.contains(var_61_2, var_61_0) then
			return false
		end

		if var_61_0 == 14 then
			var_0_0.ClearAccountCache()
		end

		originalPrint = var_4

		var_4("SDK Error Code:" .. var_61_0)

		local var_61_3 = var_0_2
		local var_61_4 = var_4.GetSDKRecommendedErrorMsg
		local var_61_5 = var_61_0

		Airisdk = var_1_10007

		if var_61_4(var_61_3, var_61_5, var_1_10007.LanguageType.MSG_EN) then
			string = var_61_3

			if var_61_3.len(var_4) > 0 then
				pg = var_61_3

				local var_61_6 = var_61_3.TipsMgr.GetInstance()

				var_61_3.ShowTips(var_61_6, var_4)

				goto label_61_0
			end
		end

		i18n = var_61_3

		local var_61_7 = var_61_3("new_airi_error_code_" .. var_61_0)

		string = var_6

		local var_61_9

		if var_6.find(var_61_7, "UndefinedLanguage") then
			pg = var_61_9

			local var_61_8 = var_61_9.TipsMgr.GetInstance()

			var_61_9 = var_61_9.ShowTips
			i18n = var_8

			var_61_9(var_61_8, var_8("new_airi_error_code_other") .. var_61_1)
		else
			pg = var_61_9

			local var_61_10 = var_61_9.TipsMgr.GetInstance()

			var_6.ShowTips(var_61_10, var_61_7 .. var_61_1)
		end
	end

	::label_61_0::

	return false
end

function var_0_0.AiriPGSResultCodeHandler(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0
	local var_62_1 = arg_62_0.ToInt(var_62_0)

	originalPrint = var_62_0

	local var_62_2 = "AiriPGSResultCodeHandler"

	tostring = var_1_10005

	var_62_0(var_62_2, var_1_10005(var_62_1))

	if var_62_1 == 100201 then
		pg = var_62_0

		local var_62_3 = var_62_0.MsgboxMgr.GetInstance()

		var_62_0 = var_62_0.ShowMsgBox

		local var_62_4 = {}

		i18n = var_6
		var_62_4.content = var_6("pgs_login_binding_exist2")

		function var_62_4.onYes()
			var_0_0.ConfirmLinkGooglePlayGame()

			return
		end

		var_62_0(var_62_3, var_62_4)

		return true
	elseif var_62_1 == 100202 then
		pg = var_62_0

		local var_62_5 = var_62_0.MsgboxMgr.GetInstance()

		var_62_0 = var_62_0.ShowMsgBox

		local var_62_6 = {}

		i18n = var_6
		var_62_6.content = var_6("pgs_login_binding_exist1")

		function var_62_6.onYes()
			var_0_0.ConfirmLinkGooglePlayGame()

			return
		end

		var_62_0(var_62_5, var_62_6)

		return true
	elseif var_62_1 == 100203 then
		pg = var_62_0

		local var_62_7 = var_62_0.MsgboxMgr.GetInstance()

		var_62_0 = var_62_0.ShowMsgBox

		local var_62_8 = {}

		i18n = var_6
		var_62_8.content = var_6("pgs_login_binding_exist3")

		function var_62_8.onYes()
			var_0_0.ConfirmLinkGooglePlayGame()

			return
		end

		var_62_0(var_62_7, var_62_8)

		return true
	elseif var_62_1 == 100204 then
		arg_62_1()

		return true
	elseif var_62_1 == 100205 then
		return true
	elseif var_62_1 == 100206 then
		pg = var_62_0

		local var_62_9 = var_62_0.MsgboxMgr.GetInstance()

		var_62_0 = var_62_0.ShowMsgBox

		local var_62_10 = {
			hideNo = true
		}

		i18n = var_6
		var_62_10.content = var_6("pgs_login_tip")

		function var_62_10.onYes()
			pg = var_2_10000

			local var_66_0 = var_2_10000.m02
			local var_66_1 = var_0.sendNotification

			GAME = var_2_10002

			var_66_1(var_66_0, var_2_10002.ON_SOCIAL_LINKED)

			return
		end

		function var_62_10.onClose()
			pg = var_2_10000

			local var_67_0 = var_2_10000.m02
			local var_67_1 = var_0.sendNotification

			GAME = var_2_10002

			var_67_1(var_67_0, var_2_10002.ON_SOCIAL_LINKED)

			return
		end

		var_62_0(var_62_9, var_62_10)

		return true
	elseif var_62_1 == 100214 then
		pg = var_62_0

		local var_62_11 = var_62_0.MsgboxMgr.GetInstance()
		local var_62_12 = var_3.ShowMsgBox
		local var_62_13 = {}

		i18n = var_6
		var_62_13.content = var_6("pgs_unbind_tip2")

		function var_62_13.onYes()
			var_0_0.ConfirmUnLinkGooglePlayGame()

			return
		end

		var_62_12(var_62_11, var_62_13)

		return true
	else
		return false
	end

	return
end

function var_0_0.AiriYoStarPassMigrateHandler(arg_69_0)
	local var_69_0 = {
		0,
		100204,
		100206
	}

	table = var_1_10002

	local var_69_1 = var_1_10002.contains
	local var_69_2 = var_69_0
	local var_69_3 = arg_69_0.R_CODE

	if var_69_1(var_69_2, var_4.ToInt(var_69_3)) and arg_69_0.SHOW_MIGRATE_PAGE == 1 then
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

	local var_70_0 = var_1_10000.UIMgr.GetInstance()

	var_0.LoadingOn(var_70_0)

	local var_70_1 = var_0_0

	var_70_1.ON_AIRI_LOADING = true
	onDelayTick = var_70_1

	var_70_1(function()
		if var_0_0.ON_AIRI_LOADING then
			pg = var_0

			local var_71_0 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_71_0)

			var_0_0.ON_AIRI_LOADING = false
		end

		return
	end, 15)

	return
end

function var_0_0.EndAiriTimeout()
	local var_72_0 = var_0_0

	var_72_0.ON_AIRI_LOADING = false
	pg = var_72_0

	local var_72_1 = var_72_0.UIMgr.GetInstance()

	var_0.LoadingOff(var_72_1)

	return
end

return var_0_0

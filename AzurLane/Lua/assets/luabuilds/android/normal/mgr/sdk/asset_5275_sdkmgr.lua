pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SdkMgr = var_0_10001("SdkMgr")
pg = var_0

local var_0_1 = var_0.SdkMgr

function var_0_1.Ctor(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		require = var_1_10001
		arg_1_0.instance = var_1_10001("Mgr.Sdk.BiliSDKMgr")
	else
		PLATFORM_CODE = var_1_10001
		PLATFORM_JP = var_1_10002

		if var_1_10001 == var_1_10002 then
			require = var_1_10001
			arg_1_0.instance = var_1_10001("Mgr.Sdk.YoStarMgr")

			arg_1_0.instance.InitJP()
		else
			PLATFORM_CODE = var_1_10001
			PLATFORM_KR = var_1_10002

			if var_1_10001 == var_1_10002 then
				require = var_1_10001
				arg_1_0.instance = var_1_10001("Mgr.Sdk.TxwyKrSDKMgr")
			else
				PLATFORM_CODE = var_1_10001
				PLATFORM_US = var_1_10002

				if var_1_10001 == var_1_10002 then
					require = var_1_10001
					arg_1_0.instance = var_1_10001("Mgr.Sdk.AiriSDKUSMgr")
				else
					PLATFORM_CODE = var_1_10001
					PLATFORM_CHT = var_1_10002

					if var_1_10001 == var_1_10002 then
						require = var_1_10001
						arg_1_0.instance = var_1_10001("Mgr.Sdk.YongshiSdkMgr")
					end
				end
			end
		end
	end

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.GetPlatformCode

	Application = var_1_10003
	arg_1_0.pcode = var_1_1(var_1_0, var_1_10003.identifier)

	return
end

function var_0_1.Call(arg_2_0, arg_2_1, ...)
	assert = var_1_10002

	var_1_10002(arg_2_0.instance)

	if arg_2_0.instance[arg_2_1] then
		arg_2_0.instance[arg_2_1](...)
	end

	return
end

function var_0_1.Get(arg_3_0, arg_3_1, ...)
	assert = var_1_10002

	var_1_10002(arg_3_0.instance)

	assert = var_1_10002

	var_1_10002(arg_3_0.instance[arg_3_1], "func should exist " .. arg_3_1)

	return arg_3_0.instance[arg_3_1](...)
end

local function var_0_2(arg_4_0)
	originalPrint = var_1_10001

	var_1_10001(".......EnterMultiWindow")

	return
end

local var_0_3 = EnterMultiWindow

local function var_0_4(arg_5_0)
	originalPrint = var_1_10001

	var_1_10001(".......ExitMultiWindow")

	return
end

local var_0_5 = ExitMultiWindow

function var_0_1.InitSDK(arg_6_0)
	arg_6_0:Call("InitSDK")

	return
end

function var_0_1.GoSDkLoginScene(arg_7_0)
	arg_7_0:Call("GoSDkLoginScene")

	return
end

function var_0_1.LoginSdk(arg_8_0, arg_8_1)
	arg_8_0:Call("LoginSdk", arg_8_1)

	return
end

function var_0_1.TryLoginSdk(arg_9_0)
	arg_9_0:Call("TryLoginSdk")

	return
end

function var_0_1.CreateRole(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	arg_10_0:Call("CreateRole", arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)

	return
end

function var_0_1.EnterServer(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	arg_11_0:Call("EnterServer", arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)

	return
end

function var_0_1.ChooseServer(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:Call("ChooseServer", arg_12_1, arg_12_2)

	return
end

function var_0_1.SdkGateWayLogined(arg_13_0)
	arg_13_0:Call("SdkGateWayLogined")

	return
end

function var_0_1.SdkLoginGetaWayFailed(arg_14_0)
	arg_14_0:Call("SdkLoginGetaWayFailed")

	return
end

function var_0_1.SdkLevelUp(arg_15_0)
	arg_15_0:Call("SdkLevelUp")

	return
end

function var_0_1.SdkPay(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10)
	arg_16_0:Call("SdkPay", arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10)

	return
end

function var_0_1.LogoutSDK(arg_17_0, arg_17_1)
	arg_17_0:Call("LogoutSDK", arg_17_1)

	return
end

function var_0_1.BindCPU(arg_18_0)
	arg_18_0:Call("BindCPU")

	return
end

function var_0_1.OnAndoridBackPress(arg_19_0)
	arg_19_0:Call("OnAndoridBackPress")

	return
end

function var_0_1.DeleteAccount(arg_20_0)
	arg_20_0:Call("DeleteAccount")

	return
end

function var_0_1.GetChannelUID(arg_21_0)
	if arg_21_0:Get("GetChannelUID") == "" then
		PLATFORM_LOCAL = var_1
	end

	return var_1
end

function var_0_1.IsTestServer(arg_22_0)
	NetConst = var_1_10001

	return var_1_10001.getwayType == 2
end

function var_0_1.GetChannelUIDIncludeHarmony(arg_23_0)
	local function var_23_0()
		local var_24_0 = arg_23_0

		if var_0.GetChannelUID(var_24_0) == "harmony" then
			return 9999
		else
			tonumber = var_24_0

			if var_24_0(var_0) then
				return var_1
			else
				return var_0 or 0
			end
		end

		return
	end

	local var_23_1 = arg_23_0

	if not arg_23_0.IsTestServer(var_23_1) then
		IsUnityEditor = var_2

		if var_2 then
			local var_23_2

			IsUnityEditor = var_23_1

			if var_23_1 then
				PathMgr = var_23_1
				var_23_2 = var_23_1.getAssetBundle("../localization.txt")
			else
				Application = var_23_1
				var_23_2 = var_23_1.persistentDataPath .. "/localization.txt"
			end

			PathMgr = var_23_1

			if not var_23_1.FileExists(var_23_2) then
				return var_23_0()
			end

			PathMgr = var_3

			local var_23_3

			if not (var_3.ReadAllLines(var_23_2).Length > 2) or not var_3[2] then
				var_23_3 = ""
			end

			if not var_23_3 or var_23_3 == "" then
				return var_23_0()
			end

			local var_23_4 = var_23_3
			local var_23_5 = var_23_3.match(var_23_4, "^%s*ChannelUID%s*=%s*(%d+)")

			tonumber = var_23_4

			if var_23_4(var_23_5) then
				return var_5
			else
				return var_23_0()
			end
		else
			return var_23_0()
		end

		return
	end
end

function var_0_1.GetLoginType(arg_25_0)
	Application = var_1_10001

	local var_25_0 = var_1_10001.persistentDataPath .. "/server_config.txt"

	PathMgr = var_2

	if var_2.FileExists(var_25_0) then
		LoginType = var_2

		return var_2.PLATFORM_INNER
	end

	string = var_2

	local var_25_1 = var_2.match

	NetConst = var_3

	if var_25_1(var_3.GATEWAY_HOST, "^10%.0") then
		LoginType = var_2

		return var_2.PLATFORM_INNER
	end

	return arg_25_0:Get("GetLoginType")
end

function var_0_1.GetIsPlatform(arg_26_0)
	return arg_26_0:Get("GetIsPlatform")
end

function var_0_1.EnterLoginScene(arg_27_0)
	arg_27_0.inLoginScene = true

	return
end

function var_0_1.ExitLoginScene(arg_28_0)
	arg_28_0.inLoginScene = false

	return
end

function var_0_1.IsInLoginScene(arg_29_0)
	return arg_29_0.inLoginScene
end

function var_0_1.IsYunPackage(arg_30_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	return var_1_10001 == var_1_10002 and arg_30_0:GetChannelUID() == "yun"
end

function var_0_1.Service(arg_31_0)
	arg_31_0:Call("Service")

	return
end

function var_0_1.Survey(arg_32_0, arg_32_1)
	arg_32_0:Call("Survey", arg_32_1)

	return
end

function var_0_1.IsHuaweiPackage(arg_33_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	return var_1_10001 == var_1_10002 and arg_33_0:Get("IsHuaweiPackage")
end

function var_0_1.CheckAudit(arg_34_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CODE = var_1_10001
		PLATFORM_US = var_1_10002

		if var_1_10001 == var_1_10002 then
			return arg_34_0:Get("CheckAudit")
		else
			return false
		end

		return
	end
end

function var_0_1.CheckPreAudit(arg_35_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CODE = var_1_10001
		PLATFORM_US = var_1_10002

		if var_1_10001 == var_1_10002 then
			return arg_35_0:Get("CheckPreAudit")
		else
			return false
		end

		return
	end
end

function var_0_1.CheckPretest(arg_36_0)
	return arg_36_0:Get("CheckPretest")
end

function var_0_1.CheckGoogleSimulator(arg_37_0)
	return arg_37_0:Get("CheckGoogleSimulator")
end

function var_0_1.CheckWorldTest(arg_38_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		return arg_38_0:Get("CheckWorldTest")
	else
		return false
	end

	return
end

function var_0_1.OnAppPauseForSDK(arg_39_0, arg_39_1)
	arg_39_0:Call("OnAppPauseForSDK", arg_39_1)

	return
end

function var_0_1.UserEventUpload(arg_40_0, arg_40_1)
	arg_40_0:Call("UserEventUpload", arg_40_1)

	return
end

function var_0_1.GameShare(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:Call("GameShare", arg_41_1, arg_41_2)

	return
end

local function var_0_6()
	function var_0_1.GetYostarUid(arg_43_0)
		return arg_43_0:Get("GetYostarUid")
	end

	function var_0_1.GetYostarTransCode(arg_44_0)
		return arg_44_0:Get("GetTransCode")
	end

	function var_0_1.AiriLoginSDK(arg_45_0)
		arg_45_0:Call("AiriLogin")

		return
	end

	function var_0_1.TranscodeRequest(arg_46_0)
		arg_46_0:Call("TranscodeRequest")

		return
	end

	function var_0_1.LoginWithTranscode(arg_47_0, arg_47_1, arg_47_2)
		arg_47_0:Call("LoginWithTranscode", arg_47_1, arg_47_2)

		return
	end

	function var_0_1.LoginWithSocial(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
		arg_48_0:Call("LoginWithSocial", arg_48_1, arg_48_2, arg_48_3)

		return
	end

	function var_0_1.LoginWithDevice(arg_49_0)
		arg_49_0:Call("LoginWithDevice")

		return
	end

	function var_0_1.AiriBuy(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
		arg_50_0:Call("AiriBuy", arg_50_1, arg_50_2, arg_50_3)

		return
	end

	function var_0_1.LinkSocial(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
		arg_51_0:Call("LinkSocial", arg_51_1, arg_51_2, arg_51_3)

		return
	end

	function var_0_1.UnlinkSocial(arg_52_0, arg_52_1)
		arg_52_0:Call("UnlinkSocial", arg_52_1)

		return
	end

	function var_0_1.IsSocialLink(arg_53_0, arg_53_1)
		PLATFORM_CODE = var_2_10002
		PLATFORM_JP = var_2_10003

		if var_2_10002 ~= var_2_10003 then
			PLATFORM_CODE = var_2_10002
			PLATFORM_US = var_2_10003

			if var_2_10002 == var_2_10003 then
				return arg_53_0:Get("IsSocialLink", arg_53_1)
			else
				return false
			end

			return
		end
	end

	function var_0_1.GetSocialName(arg_54_0, arg_54_1)
		PLATFORM_CODE = var_2_10002
		PLATFORM_JP = var_2_10003

		if var_2_10002 ~= var_2_10003 then
			PLATFORM_CODE = var_2_10002
			PLATFORM_US = var_2_10003

			if var_2_10002 == var_2_10003 then
				return arg_54_0:Get("GetSocialName", arg_54_1)
			else
				return "none"
			end

			return
		end
	end

	function var_0_1.GetIsBirthSet(arg_55_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_JP = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_US = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_55_0:Get("GetIsBirthSet")
			end

			return true
		end
	end

	function var_0_1.SetBirth(arg_56_0, arg_56_1)
		arg_56_0:Call("SetBirth", arg_56_1)

		return
	end

	function var_0_1.ClearAccountCache(arg_57_0)
		arg_57_0:Call("ClearAccountCache")

		return
	end

	function var_0_1.GameShare(arg_58_0, arg_58_1, arg_58_2)
		arg_58_0:Call("GameShare", arg_58_1, arg_58_2)

		return
	end

	function var_0_1.VerificationCodeReq(arg_59_0, arg_59_1)
		arg_59_0:Call("VerificationCodeReq", arg_59_1)

		return
	end

	function var_0_1.OpenYostarHelp(arg_60_0)
		arg_60_0:Call("OpenYostarHelp")

		return
	end

	function var_0_1.OnAppPauseForSDK(arg_61_0, arg_61_1)
		arg_61_0:Call("OnAppPauseForSDK", arg_61_1)

		return
	end

	function var_0_1.UserEventUpload(arg_62_0, arg_62_1)
		arg_62_0:Call("UserEventUpload", arg_62_1)

		return
	end

	function var_0_1.ShowSurvey(arg_63_0, arg_63_1, arg_63_2)
		return arg_63_0:Call("ShowSurvey", arg_63_1, arg_63_2)
	end

	function var_0_1.CheckAiriCanBuy(arg_64_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_64_0:Get("CheckAiriCanBuy")
			else
				return true
			end

			return
		end
	end

	function var_0_1.CheckHadAccountCache(arg_65_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_JP = var_2_10002

		if var_2_10001 == var_2_10002 then
			return arg_65_0:Get("CheckHadAccountCache")
		else
			return true
		end

		return
	end

	function var_0_1.AccountDelete(arg_66_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_66_0:Get("AccountDelete")
			else
				return true
			end

			return
		end
	end

	function var_0_1.AccountReborn(arg_67_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_67_0:Get("AccountReborn")
			else
				return true
			end

			return
		end
	end

	function var_0_1.ConfirmLinkGooglePlayGame(arg_68_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_68_0:Get("ConfirmLinkGooglePlayGame")
			else
				return true
			end

			return
		end
	end

	function var_0_1.ConfirmUnLinkGooglePlayGame(arg_69_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_69_0:Get("ConfirmUnLinkGooglePlayGame")
			else
				return true
			end

			return
		end
	end

	function var_0_1.BindYostarPass(arg_70_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_70_0:Get("BindYostarPass")
			else
				return true
			end

			return
		end
	end

	local var_42_0 = 0
	local var_42_1 = AIRI_LAST_GEN_TIME
	local var_42_2 = 30
	local var_42_3 = AIRI_GEN_LIMIT_TIME

	local function var_42_4()
		Time = var_2_10000

		local var_71_0 = var_2_10000.realtimeSinceStartup

		AIRI_LAST_GEN_TIME = var_2_10001

		local var_71_1 = var_71_0 - var_2_10001

		AIRI_GEN_LIMIT_TIME = var_2_10001

		if not (var_2_10001 < var_71_1) then
			AIRI_LAST_GEN_TIME = var_2_10001

			if var_2_10001 == 0 then
				return 0
			else
				math = var_2_10001

				local var_71_2 = var_2_10001.floor

				AIRI_GEN_LIMIT_TIME = var_2_10002

				return var_71_2(var_2_10002 - var_71_1)
			end

			return
		end
	end

	local var_42_5 = GetAiriGenCodeTimeRemain

	return
end

PLATFORM_CODE = var_2
PLATFORM_US = var_0_10003

if var_2 == var_0_10003 then
	var_0_6()
end

local function var_0_7()
	function var_0_1.YoStarLoginSDK(arg_73_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_JP = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_US = var_2_10002

			if var_2_10001 == var_2_10002 then
				arg_73_0:Call("Login")
			end

			return
		end
	end

	function var_0_1.YoStarPay(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
		PLATFORM_CODE = var_2_10004
		PLATFORM_JP = var_2_10005

		if var_2_10004 ~= var_2_10005 then
			PLATFORM_CODE = var_2_10004
			PLATFORM_US = var_2_10005

			if var_2_10004 == var_2_10005 then
				arg_74_0:Call("Pay", arg_74_1, arg_74_2, arg_74_3)
			end

			return
		end
	end

	function var_0_1.GameShare(arg_75_0, arg_75_1, arg_75_2)
		PLATFORM_CODE = var_2_10003
		PLATFORM_JP = var_2_10004

		if var_2_10003 ~= var_2_10004 then
			PLATFORM_CODE = var_2_10003
			PLATFORM_US = var_2_10004

			if var_2_10003 == var_2_10004 then
				arg_75_0:Call("SystemShare", arg_75_1, arg_75_2)
			end

			return
		end
	end

	function var_0_1.YostarOpenAiHelp(arg_76_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_JP = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_US = var_2_10002

			if var_2_10001 == var_2_10002 then
				arg_76_0:Call("ShowAihelp")
			end

			return
		end
	end

	function var_0_1.OnAppPauseForSDK(arg_77_0, arg_77_1)
		PLATFORM_CODE = var_2_10002
		PLATFORM_JP = var_2_10003

		if var_2_10002 ~= var_2_10003 then
			PLATFORM_CODE = var_2_10002
			PLATFORM_US = var_2_10003

			if var_2_10002 == var_2_10003 then
				arg_77_0:Call("OnAppPauseForSDK", arg_77_1)
			end

			return
		end
	end

	function var_0_1.YoStarShowSurvey(arg_78_0, arg_78_1, arg_78_2)
		PLATFORM_CODE = var_2_10003
		PLATFORM_JP = var_2_10004

		if var_2_10003 ~= var_2_10004 then
			PLATFORM_CODE = var_2_10003
			PLATFORM_US = var_2_10004

			if var_2_10003 == var_2_10004 then
				return arg_78_0:Call("ShowSurvey", arg_78_1, arg_78_2)
			end

			return
		end
	end

	function var_0_1.YoStarCheckCanBuy(arg_79_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_79_0:Get("CheckYoStarCanBuy")
			end

			return
		end
	end

	function var_0_1.YoStarCheckHadAccountCache(arg_80_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_80_0:Get("CheckHadAccountCache")
			end

			return
		end
	end

	function var_0_1.YoStarShowUserCenter(arg_81_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_81_0:Get("ShowUserCenter")
			end

			return
		end
	end

	function var_0_1.YoStarRoleInfoUpload(arg_82_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_82_0:Get("RoleInfoUpload")
			end

			return
		end
	end

	function var_0_1.YoStarShowSwitchAccount(arg_83_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_83_0:Get("ShowSwitchAccount")
			end

			return
		end
	end

	function var_0_1.YoStarShowAccountCenter(arg_84_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_US = var_2_10002

		if var_2_10001 ~= var_2_10002 then
			PLATFORM_CODE = var_2_10001
			PLATFORM_JP = var_2_10002

			if var_2_10001 == var_2_10002 then
				return arg_84_0:Get("ShowAccountCenter")
			end

			return
		end
	end

	function var_0_1.UserEventUpload(arg_85_0, arg_85_1)
		arg_85_0:Call("UserEventUpload", arg_85_1)

		return
	end

	return
end

PLATFORM_CODE = var_0_10003
PLATFORM_JP = var_0_10004

if var_0_10003 == var_0_10004 then
	var_0_7()
end

function var_0_1.UserCenter(arg_86_0)
	arg_86_0:Call("UserCenter")

	return
end

function var_0_1.BugReport(arg_87_0)
	arg_87_0:Call("BugReport")

	return
end

function var_0_1.StoreReview(arg_88_0)
	arg_88_0:Call("StoreReview")

	return
end

function var_0_1.QueryWithProduct(arg_89_0)
	arg_89_0:Call("QueryWithProduct")

	return
end

function var_0_1.QueryPendingTransaction(arg_90_0)
	arg_90_0:Call("QueryPendingTransaction")

	return
end

function var_0_1.ShareImg(arg_91_0, arg_91_1, arg_91_2)
	arg_91_0:Call("ShareImg", arg_91_1, arg_91_2)

	return
end

function var_0_1.SwitchAccount(arg_92_0)
	arg_92_0:Call("SwitchAccount")

	return
end

function var_0_1.EventTrack(arg_93_0, arg_93_1)
	arg_93_0:Call("EventTrack", arg_93_1)

	return
end

function var_0_1.EventTrack(arg_94_0, arg_94_1)
	arg_94_0:Call("EventTrack", arg_94_1)

	return
end

function var_0_1.IsBindFaceBook(arg_95_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return arg_95_0:Get("IsBindFaceBook")
	end

	return
end

function var_0_1.IsBindApple(arg_96_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return arg_96_0:Get("IsBindApple")
	end

	return
end

function var_0_1.IsBindGoogle(arg_97_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return arg_97_0:Get("IsBindGoogle")
	end

	return
end

function var_0_1.IsBindPhone(arg_98_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return arg_98_0:Get("IsBindPhone")
	end

	return
end

function var_0_1.IsBindGameCenter(arg_99_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return false
	end

	return
end

function var_0_1.CanTriggerDeepLinking(arg_100_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return arg_100_0:Get("CanTriggerDeepLinking")
	else
		return false
	end

	return
end

function var_0_1.TriggerDeepLinking(arg_101_0)
	arg_101_0:Call("TriggerDeepLinking")

	return
end

function var_0_1.BindSocial(arg_102_0, arg_102_1)
	if arg_102_1 == 1 then
		arg_102_0:BindFaceBook()
	elseif arg_102_1 == 2 then
		arg_102_0:BindGoogle()
	elseif arg_102_1 == 3 then
		arg_102_0:BindPhone()
	elseif arg_102_1 == 4 then
		-- block empty
	elseif arg_102_1 == 5 then
		arg_102_0:BindApple()
	end

	return
end

function var_0_1.UnbindSocial(arg_103_0, arg_103_1)
	if arg_103_1 == 1 then
		arg_103_0:UnBindFaceBook()
	elseif arg_103_1 == 2 then
		arg_103_0:UnBindGoogle()
	elseif arg_103_1 == 3 then
		arg_103_0:UnBindPhone()
	elseif arg_103_1 == 4 then
		-- block empty
	end

	return
end

function var_0_1.BindFaceBook(arg_104_0)
	arg_104_0:Call("BindFaceBook")

	return
end

function var_0_1.BindApple(arg_105_0)
	arg_105_0:Call("BindApple")

	return
end

function var_0_1.BindGoogle(arg_106_0)
	arg_106_0:Call("BindGoogle")

	return
end

function var_0_1.BindPhone(arg_107_0)
	arg_107_0:Call("BindPhone")

	return
end

function var_0_1.UnBindFaceBook(arg_108_0)
	arg_108_0:Call("UnBindFaceBook")

	return
end

function var_0_1.UnBindGoogle(arg_109_0)
	arg_109_0:Call("UnBindGoogle")

	return
end

function var_0_1.UnBindPhone(arg_110_0)
	arg_110_0:Call("UnBindPhone")

	return
end

function var_0_1.ShowLicence(arg_111_0)
	arg_111_0:Call("ShowLicence")

	return
end

function var_0_1.ShowPrivate(arg_112_0)
	arg_112_0:Call("ShowPrivate")

	return
end

function var_0_1.OpenMiniProgram(arg_113_0)
	arg_113_0:Call("OpenMiniProgram")

	return
end

function var_0_1.GetProduct(arg_114_0, arg_114_1)
	PLATFORM_CODE = var_1_10002
	PLATFORM_CHT = var_1_10003

	if var_1_10002 == var_1_10003 then
		return arg_114_0:Get("GetProduct", arg_114_1)
	end

	return
end

function var_0_1.GetDeviceId(arg_115_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CODE = var_1_10001
		PLATFORM_US = var_1_10002

		if var_1_10001 == var_1_10002 then
			var_1_10002 = arg_115_0

			return arg_115_0.Get(var_1_10002, "GetDeviceId")
		else
			PLATFORM_CODE = var_1_10001
			PLATFORM_KR = var_1_10002

			if var_1_10001 == var_1_10002 then
				var_1_10002 = arg_115_0

				return arg_115_0.Get(var_1_10002, "GetDeviceModel")
			else
				PLATFORM_CODE = var_1_10001
				PLATFORM_CHT = var_1_10002

				if var_1_10001 == var_1_10002 then
					SystemInfo = var_1_10001

					return var_1_10001.deviceUniqueIdentifier
				else
					return ""
				end
			end
		end

		return
	end
end

local function var_0_8()
	local function var_116_0()
		getProxy = var_2_10000
		UserProxy = var_2_10001

		local var_117_0 = var_2_10000(var_2_10001)

		return var_0.GetLoginedFlag(var_117_0)
	end

	pg = var_1_10001

	local var_116_1 = var_1_10001.SdkMgr.GetInstance()

	if var_1.IsInLoginScene(var_116_1) and not var_116_0() then
		return true
	end

	return false
end

local var_0_9 = InLoginScene

function var_0_1.GetPlatformCode(arg_118_0, arg_118_1)
	PLATFORM_CODE = var_1_10002
	PLATFORM_CHT = var_1_10003

	if var_1_10002 == var_1_10003 then
		return arg_118_0:Get("GetPackageCode", arg_118_1)
	else
		return nil
	end

	return
end

function var_0_1.IgnorePlatform(arg_119_0, arg_119_1)
	if arg_119_0.pcode and arg_119_1 and #arg_119_1 > 0 then
		_ = var_3

		if var_3.any(arg_119_1, function(arg_120_0)
			tostring = var_2_10001

			return var_2_10001(arg_120_0) == var_0
		end) then
			return true
		end
	end

	return false
end

return

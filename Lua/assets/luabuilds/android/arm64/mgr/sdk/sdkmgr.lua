pg = pg or {}
pg.SdkMgr = singletonClass("SdkMgr")

local var_0_0 = pg.SdkMgr

function pg.SdkMgr.Ctor(arg_1_0)
	if PLATFORM_CODE == PLATFORM_CH then
		arg_1_0.instance = require("Mgr.Sdk.BiliSDKMgr")
	elseif PLATFORM_CODE == PLATFORM_JP then
		arg_1_0.instance = require("Mgr.Sdk.YoStarMgr")

		arg_1_0.instance.InitJP()
	elseif PLATFORM_CODE == PLATFORM_KR then
		arg_1_0.instance = require("Mgr.Sdk.TxwyKrSDKMgr")
	elseif PLATFORM_CODE == PLATFORM_US then
		arg_1_0.instance = require("Mgr.Sdk.AiriSDKUSMgr")
	elseif PLATFORM_CODE == PLATFORM_CHT then
		arg_1_0.instance = require("Mgr.Sdk.YongshiSdkMgr")
	end

	arg_1_0.pcode = arg_1_0:GetPlatformCode(Application.identifier)

	return
end

function pg.SdkMgr.Call(arg_2_0, arg_2_1, ...)
	assert(arg_2_0.instance)

	if arg_2_0.instance[arg_2_1] then
		arg_2_0.instance[arg_2_1](...)
	end

	return
end

function pg.SdkMgr.Get(arg_3_0, arg_3_1, ...)
	assert(arg_3_0.instance)
	assert(arg_3_0.instance[arg_3_1], "func should exist " .. arg_3_1)

	return arg_3_0.instance[arg_3_1](...)
end

function EnterMultiWindow(arg_4_0)
	originalPrint(".......EnterMultiWindow")

	return
end

function ExitMultiWindow(arg_5_0)
	originalPrint(".......ExitMultiWindow")

	return
end

function pg.SdkMgr.InitSDK(arg_6_0)
	arg_6_0:Call("InitSDK")

	return
end

function pg.SdkMgr.GoSDkLoginScene(arg_7_0)
	arg_7_0:Call("GoSDkLoginScene")

	return
end

function pg.SdkMgr.LoginSdk(arg_8_0, arg_8_1)
	arg_8_0:Call("LoginSdk", arg_8_1)

	return
end

function pg.SdkMgr.TryLoginSdk(arg_9_0)
	arg_9_0:Call("TryLoginSdk")

	return
end

function pg.SdkMgr.CreateRole(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	arg_10_0:Call("CreateRole", arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)

	return
end

function pg.SdkMgr.EnterServer(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	arg_11_0:Call("EnterServer", arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)

	return
end

function pg.SdkMgr.ChooseServer(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:Call("ChooseServer", arg_12_1, arg_12_2)

	return
end

function pg.SdkMgr.SdkGateWayLogined(arg_13_0)
	arg_13_0:Call("SdkGateWayLogined")

	return
end

function pg.SdkMgr.SdkLoginGetaWayFailed(arg_14_0)
	arg_14_0:Call("SdkLoginGetaWayFailed")

	return
end

function pg.SdkMgr.SdkLevelUp(arg_15_0)
	arg_15_0:Call("SdkLevelUp")

	return
end

function pg.SdkMgr.SdkPay(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10)
	arg_16_0:Call("SdkPay", arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10)

	return
end

function pg.SdkMgr.LogoutSDK(arg_17_0, arg_17_1)
	arg_17_0:Call("LogoutSDK", arg_17_1)

	return
end

function pg.SdkMgr.BindCPU(arg_18_0)
	arg_18_0:Call("BindCPU")

	return
end

function pg.SdkMgr.OnAndoridBackPress(arg_19_0)
	arg_19_0:Call("OnAndoridBackPress")

	return
end

function pg.SdkMgr.DeleteAccount(arg_20_0)
	arg_20_0:Call("DeleteAccount")

	return
end

function pg.SdkMgr.GetChannelUID(arg_21_0)
	local var_21_0 = arg_21_0:Get("GetChannelUID")

	if var_21_0 == "" then
		var_21_0 = PLATFORM_LOCAL
	end

	return var_21_0
end

function pg.SdkMgr.IsTestServer(arg_22_0)
	return NetConst.getwayType == 2
end

function pg.SdkMgr.GetChannelUIDIncludeHarmony(arg_23_0)
	if arg_23_0:IsTestServer() or IsUnityEditor then
		local var_23_0 = IsUnityEditor and PathMgr.getAssetBundle("../localization.txt") or Application.persistentDataPath .. "/localization.txt"

		if not PathMgr.FileExists(var_23_0) then
			return (function()
				local var_24_0 = arg_23_0:GetChannelUID()

				if var_24_0 == "harmony" then
					return 9999
				else
					local var_24_1 = tonumber(var_24_0)

					if var_24_1 then
						return var_24_1
					else
						return var_24_0 or 0
					end
				end

				return
			end)()
		end

		local var_23_1 = PathMgr.ReadAllLines(var_23_0)

		if var_23_1.Length > 2 then
			local var_23_2 = var_23_1[2] or ""

			if not var_23_2 or var_23_2 == "" then
				return (function()
					local var_24_0 = arg_23_0:GetChannelUID()

					if var_24_0 == "harmony" then
						return 9999
					else
						local var_24_1 = tonumber(var_24_0)

						if var_24_1 then
							return var_24_1
						else
							return var_24_0 or 0
						end
					end

					return
				end)()
			end

			local var_23_3 = tonumber((var_23_2:match("^%s*ChannelUID%s*=%s*(%d+)")))

			if var_23_3 then
				return var_23_3
			else
				return (function()
					local var_24_0 = arg_23_0:GetChannelUID()

					if var_24_0 == "harmony" then
						return 9999
					else
						local var_24_1 = tonumber(var_24_0)

						if var_24_1 then
							return var_24_1
						else
							return var_24_0 or 0
						end
					end

					return
				end)()
			end

			if false then
				return (function()
					local var_24_0 = arg_23_0:GetChannelUID()

					if var_24_0 == "harmony" then
						return 9999
					else
						local var_24_1 = tonumber(var_24_0)

						if var_24_1 then
							return var_24_1
						else
							return var_24_0 or 0
						end
					end

					return
				end)()
			end

			return
		end
	end
end

function pg.SdkMgr.GetLoginType(arg_25_0)
	if PathMgr.FileExists(Application.persistentDataPath .. "/server_config.txt") then
		return LoginType.PLATFORM_INNER
	end

	if string.match(NetConst.GATEWAY_HOST, "^10%.0") then
		return LoginType.PLATFORM_INNER
	end

	return arg_25_0:Get("GetLoginType")
end

function pg.SdkMgr.GetIsPlatform(arg_26_0)
	return arg_26_0:Get("GetIsPlatform")
end

function pg.SdkMgr.EnterLoginScene(arg_27_0)
	arg_27_0.inLoginScene = true

	return
end

function pg.SdkMgr.ExitLoginScene(arg_28_0)
	arg_28_0.inLoginScene = false

	return
end

function pg.SdkMgr.IsInLoginScene(arg_29_0)
	return arg_29_0.inLoginScene
end

function pg.SdkMgr.IsYunPackage(arg_30_0)
	return PLATFORM_CODE == PLATFORM_CH and arg_30_0:GetChannelUID() == "yun"
end

function pg.SdkMgr.Service(arg_31_0)
	arg_31_0:Call("Service")

	return
end

function pg.SdkMgr.Survey(arg_32_0, arg_32_1)
	arg_32_0:Call("Survey", arg_32_1)

	return
end

function pg.SdkMgr.IsHuaweiPackage(arg_33_0)
	return PLATFORM_CODE == PLATFORM_CH and arg_33_0:Get("IsHuaweiPackage")
end

function pg.SdkMgr.CheckAudit(arg_34_0)
	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		return arg_34_0:Get("CheckAudit")
	else
		return false
	end

	return
end

function pg.SdkMgr.CheckPreAudit(arg_35_0)
	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		return arg_35_0:Get("CheckPreAudit")
	else
		return false
	end

	return
end

function pg.SdkMgr.CheckPretest(arg_36_0)
	return arg_36_0:Get("CheckPretest")
end

function pg.SdkMgr.CheckGoogleSimulator(arg_37_0)
	return arg_37_0:Get("CheckGoogleSimulator")
end

function pg.SdkMgr.CheckWorldTest(arg_38_0)
	if PLATFORM_CODE == PLATFORM_CH then
		return arg_38_0:Get("CheckWorldTest")
	else
		return false
	end

	return
end

function pg.SdkMgr.OnAppPauseForSDK(arg_39_0, arg_39_1)
	arg_39_0:Call("OnAppPauseForSDK", arg_39_1)

	return
end

function pg.SdkMgr.UserEventUpload(arg_40_0, arg_40_1)
	arg_40_0:Call("UserEventUpload", arg_40_1)

	return
end

function pg.SdkMgr.GameShare(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:Call("GameShare", arg_41_1, arg_41_2)

	return
end

if PLATFORM_CODE == PLATFORM_US then
	(function()
		function var_0_0.GetYostarUid(arg_43_0)
			return arg_43_0:Get("GetYostarUid")
		end

		function var_0_0.GetYostarTransCode(arg_44_0)
			return arg_44_0:Get("GetTransCode")
		end

		function var_0_0.AiriLoginSDK(arg_45_0)
			arg_45_0:Call("AiriLogin")

			return
		end

		function var_0_0.TranscodeRequest(arg_46_0)
			arg_46_0:Call("TranscodeRequest")

			return
		end

		function var_0_0.LoginWithTranscode(arg_47_0, arg_47_1, arg_47_2)
			arg_47_0:Call("LoginWithTranscode", arg_47_1, arg_47_2)

			return
		end

		function var_0_0.LoginWithSocial(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
			arg_48_0:Call("LoginWithSocial", arg_48_1, arg_48_2, arg_48_3)

			return
		end

		function var_0_0.LoginWithDevice(arg_49_0)
			arg_49_0:Call("LoginWithDevice")

			return
		end

		function var_0_0.AiriBuy(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
			arg_50_0:Call("AiriBuy", arg_50_1, arg_50_2, arg_50_3)

			return
		end

		function var_0_0.LinkSocial(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
			arg_51_0:Call("LinkSocial", arg_51_1, arg_51_2, arg_51_3)

			return
		end

		function var_0_0.UnlinkSocial(arg_52_0, arg_52_1)
			arg_52_0:Call("UnlinkSocial", arg_52_1)

			return
		end

		function var_0_0.IsSocialLink(arg_53_0, arg_53_1)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return arg_53_0:Get("IsSocialLink", arg_53_1)
			else
				return false
			end

			return
		end

		function var_0_0.GetSocialName(arg_54_0, arg_54_1)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return arg_54_0:Get("GetSocialName", arg_54_1)
			else
				return "none"
			end

			return
		end

		function var_0_0.GetIsBirthSet(arg_55_0)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return arg_55_0:Get("GetIsBirthSet")
			end

			return true
		end

		function var_0_0.SetBirth(arg_56_0, arg_56_1)
			arg_56_0:Call("SetBirth", arg_56_1)

			return
		end

		function var_0_0.ClearAccountCache(arg_57_0)
			arg_57_0:Call("ClearAccountCache")

			return
		end

		function var_0_0.GameShare(arg_58_0, arg_58_1, arg_58_2)
			arg_58_0:Call("GameShare", arg_58_1, arg_58_2)

			return
		end

		function var_0_0.VerificationCodeReq(arg_59_0, arg_59_1)
			arg_59_0:Call("VerificationCodeReq", arg_59_1)

			return
		end

		function var_0_0.OpenYostarHelp(arg_60_0)
			arg_60_0:Call("OpenYostarHelp")

			return
		end

		function var_0_0.OnAppPauseForSDK(arg_61_0, arg_61_1)
			arg_61_0:Call("OnAppPauseForSDK", arg_61_1)

			return
		end

		function var_0_0.UserEventUpload(arg_62_0, arg_62_1)
			arg_62_0:Call("UserEventUpload", arg_62_1)

			return
		end

		function var_0_0.ShowSurvey(arg_63_0, arg_63_1, arg_63_2)
			return arg_63_0:Call("ShowSurvey", arg_63_1, arg_63_2)
		end

		function var_0_0.CheckAiriCanBuy(arg_64_0)
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return arg_64_0:Get("CheckAiriCanBuy")
			else
				return true
			end

			return
		end

		function var_0_0.CheckHadAccountCache(arg_65_0)
			if PLATFORM_CODE == PLATFORM_JP then
				return arg_65_0:Get("CheckHadAccountCache")
			else
				return true
			end

			return
		end

		function var_0_0.AccountDelete(arg_66_0)
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return arg_66_0:Get("AccountDelete")
			else
				return true
			end

			return
		end

		function var_0_0.AccountReborn(arg_67_0)
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return arg_67_0:Get("AccountReborn")
			else
				return true
			end

			return
		end

		function var_0_0.ConfirmLinkGooglePlayGame(arg_68_0)
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return arg_68_0:Get("ConfirmLinkGooglePlayGame")
			else
				return true
			end

			return
		end

		function var_0_0.ConfirmUnLinkGooglePlayGame(arg_69_0)
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return arg_69_0:Get("ConfirmUnLinkGooglePlayGame")
			else
				return true
			end

			return
		end

		function var_0_0.BindYostarPass(arg_70_0)
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return arg_70_0:Get("BindYostarPass")
			else
				return true
			end

			return
		end

		AIRI_LAST_GEN_TIME = 0
		AIRI_GEN_LIMIT_TIME = 30

		function GetAiriGenCodeTimeRemain()
			if Time.realtimeSinceStartup - AIRI_LAST_GEN_TIME > AIRI_GEN_LIMIT_TIME or AIRI_LAST_GEN_TIME == 0 then
				return 0
			else
				return math.floor(AIRI_GEN_LIMIT_TIME - (Time.realtimeSinceStartup - AIRI_LAST_GEN_TIME))
			end

			return
		end

		return
	end)()
end

if PLATFORM_CODE == PLATFORM_JP then
	var_0_1()
end

function pg.SdkMgr.UserCenter(arg_86_0)
	arg_86_0:Call("UserCenter")

	return
end

function pg.SdkMgr.BugReport(arg_87_0)
	arg_87_0:Call("BugReport")

	return
end

function pg.SdkMgr.StoreReview(arg_88_0)
	arg_88_0:Call("StoreReview")

	return
end

function pg.SdkMgr.QueryWithProduct(arg_89_0)
	arg_89_0:Call("QueryWithProduct")

	return
end

function pg.SdkMgr.QueryPendingTransaction(arg_90_0)
	arg_90_0:Call("QueryPendingTransaction")

	return
end

function pg.SdkMgr.ShareImg(arg_91_0, arg_91_1, arg_91_2)
	arg_91_0:Call("ShareImg", arg_91_1, arg_91_2)

	return
end

function pg.SdkMgr.SwitchAccount(arg_92_0)
	arg_92_0:Call("SwitchAccount")

	return
end

function pg.SdkMgr.EventTrack(arg_93_0, arg_93_1)
	arg_93_0:Call("EventTrack", arg_93_1)

	return
end

function pg.SdkMgr.EventTrack(arg_94_0, arg_94_1)
	arg_94_0:Call("EventTrack", arg_94_1)

	return
end

function pg.SdkMgr.IsBindFaceBook(arg_95_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return arg_95_0:Get("IsBindFaceBook")
	end

	return
end

function pg.SdkMgr.IsBindApple(arg_96_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return arg_96_0:Get("IsBindApple")
	end

	return
end

function pg.SdkMgr.IsBindGoogle(arg_97_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return arg_97_0:Get("IsBindGoogle")
	end

	return
end

function pg.SdkMgr.IsBindPhone(arg_98_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return arg_98_0:Get("IsBindPhone")
	end

	return
end

function pg.SdkMgr.IsBindGameCenter(arg_99_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return false
	end

	return
end

function pg.SdkMgr.CanTriggerDeepLinking(arg_100_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return arg_100_0:Get("CanTriggerDeepLinking")
	else
		return false
	end

	return
end

function pg.SdkMgr.TriggerDeepLinking(arg_101_0)
	arg_101_0:Call("TriggerDeepLinking")

	return
end

function pg.SdkMgr.BindSocial(arg_102_0, arg_102_1)
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

function pg.SdkMgr.UnbindSocial(arg_103_0, arg_103_1)
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

function pg.SdkMgr.BindFaceBook(arg_104_0)
	arg_104_0:Call("BindFaceBook")

	return
end

function pg.SdkMgr.BindApple(arg_105_0)
	arg_105_0:Call("BindApple")

	return
end

function pg.SdkMgr.BindGoogle(arg_106_0)
	arg_106_0:Call("BindGoogle")

	return
end

function pg.SdkMgr.BindPhone(arg_107_0)
	arg_107_0:Call("BindPhone")

	return
end

function pg.SdkMgr.UnBindFaceBook(arg_108_0)
	arg_108_0:Call("UnBindFaceBook")

	return
end

function pg.SdkMgr.UnBindGoogle(arg_109_0)
	arg_109_0:Call("UnBindGoogle")

	return
end

function pg.SdkMgr.UnBindPhone(arg_110_0)
	arg_110_0:Call("UnBindPhone")

	return
end

function pg.SdkMgr.ShowLicence(arg_111_0)
	arg_111_0:Call("ShowLicence")

	return
end

function pg.SdkMgr.ShowPrivate(arg_112_0)
	arg_112_0:Call("ShowPrivate")

	return
end

function pg.SdkMgr.OpenMiniProgram(arg_113_0)
	arg_113_0:Call("OpenMiniProgram")

	return
end

function pg.SdkMgr.GetProduct(arg_114_0, arg_114_1)
	if PLATFORM_CODE == PLATFORM_CHT then
		return arg_114_0:Get("GetProduct", arg_114_1)
	end

	return
end

function pg.SdkMgr.GetDeviceId(arg_115_0)
	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		return arg_115_0:Get("GetDeviceId")
	elseif PLATFORM_CODE == PLATFORM_KR then
		return arg_115_0:Get("GetDeviceModel")
	elseif PLATFORM_CODE == PLATFORM_CHT then
		return SystemInfo.deviceUniqueIdentifier
	else
		return ""
	end

	return
end

function InLoginScene()
	if pg.SdkMgr.GetInstance():IsInLoginScene() and not (function()
		return getProxy(UserProxy):GetLoginedFlag()
	end)() then
		return true
	end

	return false
end

function pg.SdkMgr.GetPlatformCode(arg_118_0, arg_118_1)
	if PLATFORM_CODE == PLATFORM_CHT then
		return arg_118_0:Get("GetPackageCode", arg_118_1)
	else
		return nil
	end

	return
end

function pg.SdkMgr.IgnorePlatform(arg_119_0, arg_119_1)
	if arg_119_0.pcode and arg_119_1 and #arg_119_1 > 0 and _.any(arg_119_1, function(arg_120_0)
		return tostring(arg_120_0) == var_0
	end) then
		return true
	end

	return false
end

return

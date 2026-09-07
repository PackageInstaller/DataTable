pg = pg or {}
pg.SdkMgr = singletonClass("SdkMgr")

local var_0_0 = pg.SdkMgr

function pg.SdkMgr:Ctor()
	if PLATFORM_CODE == PLATFORM_CH then
		self.instance = require("Mgr.Sdk.BiliSDKMgr")
	elseif PLATFORM_CODE == PLATFORM_JP then
		self.instance = require("Mgr.Sdk.YoStarMgr")

		self.instance.InitJP()
	elseif PLATFORM_CODE == PLATFORM_KR then
		self.instance = require("Mgr.Sdk.TxwyKrSDKMgr")
	elseif PLATFORM_CODE == PLATFORM_US then
		self.instance = require("Mgr.Sdk.AiriSDKUSMgr")
	elseif PLATFORM_CODE == PLATFORM_CHT then
		self.instance = require("Mgr.Sdk.YongshiSdkMgr")
	end

	self.pcode = self:GetPlatformCode(Application.identifier)

	return
end

function pg.SdkMgr:Call(arg_2_1, ...)
	assert(self.instance)

	if self.instance[arg_2_1] then
		self.instance[arg_2_1](...)
	end

	return
end

function pg.SdkMgr:Get(arg_3_1, ...)
	assert(self.instance)
	assert(self.instance[arg_3_1], "func should exist " .. arg_3_1)

	return self.instance[arg_3_1](...)
end

function EnterMultiWindow(arg_4_0)
	originalPrint(".......EnterMultiWindow")

	return
end

function ExitMultiWindow(arg_5_0)
	originalPrint(".......ExitMultiWindow")

	return
end

function pg.SdkMgr:InitSDK()
	self:Call("InitSDK")

	return
end

function pg.SdkMgr:GoSDkLoginScene()
	self:Call("GoSDkLoginScene")

	return
end

function pg.SdkMgr:LoginSdk(arg_8_1)
	self:Call("LoginSdk", arg_8_1)

	return
end

function pg.SdkMgr:TryLoginSdk()
	self:Call("TryLoginSdk")

	return
end

function pg.SdkMgr:CreateRole(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	self:Call("CreateRole", arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)

	return
end

function pg.SdkMgr:EnterServer(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	self:Call("EnterServer", arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)

	return
end

function pg.SdkMgr:ChooseServer(arg_12_1, arg_12_2)
	self:Call("ChooseServer", arg_12_1, arg_12_2)

	return
end

function pg.SdkMgr:SdkGateWayLogined()
	self:Call("SdkGateWayLogined")

	return
end

function pg.SdkMgr:SdkLoginGetaWayFailed()
	self:Call("SdkLoginGetaWayFailed")

	return
end

function pg.SdkMgr:SdkLevelUp()
	self:Call("SdkLevelUp")

	return
end

function pg.SdkMgr:SdkPay(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10)
	self:Call("SdkPay", arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10)

	return
end

function pg.SdkMgr:LogoutSDK(arg_17_1)
	self:Call("LogoutSDK", arg_17_1)

	return
end

function pg.SdkMgr:BindCPU()
	self:Call("BindCPU")

	return
end

function pg.SdkMgr:OnAndoridBackPress()
	self:Call("OnAndoridBackPress")

	return
end

function pg.SdkMgr:DeleteAccount()
	self:Call("DeleteAccount")

	return
end

function pg.SdkMgr:GetChannelUID()
	local var_21_0 = self:Get("GetChannelUID")

	if var_21_0 == "" then
		var_21_0 = PLATFORM_LOCAL
	end

	return var_21_0
end

function pg.SdkMgr.IsTestServer(arg_22_0)
	return NetConst.getwayType == 2
end

function pg.SdkMgr:GetChannelUIDIncludeHarmony()
	local function var_23_0()
		local var_24_0 = self:GetChannelUID()

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
	end

	if self:IsTestServer() or IsUnityEditor then
		local var_23_1 = IsUnityEditor and PathMgr.getAssetBundle("../localization.txt") or Application.persistentDataPath .. "/localization.txt"

		if not PathMgr.FileExists(var_23_1) then
			return var_23_0()
		end

		local var_23_2 = PathMgr.ReadAllLines(var_23_1)
		local var_23_3

		if var_23_2.Length > 2 then
			var_23_3 = var_23_2[2] or ""

			if not var_23_3 or var_23_3 == "" then
				return var_23_0()
			end
		end

		local var_23_4 = tonumber((var_23_3:match("^%s*ChannelUID%s*=%s*(%d+)")))

		if var_23_4 then
			return var_23_4
		else
			return var_23_0()
		end
	else
		return var_23_0()
	end

	return
end

function pg.SdkMgr:GetLoginType()
	if PathMgr.FileExists(Application.persistentDataPath .. "/server_config.txt") then
		return LoginType.PLATFORM_INNER
	end

	if string.match(NetConst.GATEWAY_HOST, "^10%.0") then
		return LoginType.PLATFORM_INNER
	end

	return self:Get("GetLoginType")
end

function pg.SdkMgr:GetIsPlatform()
	return self:Get("GetIsPlatform")
end

function pg.SdkMgr.EnterLoginScene(arg_27_0)
	arg_27_0.inLoginScene = true

	return
end

function pg.SdkMgr.ExitLoginScene(arg_28_0)
	arg_28_0.inLoginScene = false

	return
end

function pg.SdkMgr:IsInLoginScene()
	return self.inLoginScene
end

function pg.SdkMgr:IsYunPackage()
	return PLATFORM_CODE == PLATFORM_CH and self:GetChannelUID() == "yun"
end

function pg.SdkMgr:Service()
	self:Call("Service")

	return
end

function pg.SdkMgr:Survey(arg_32_1)
	self:Call("Survey", arg_32_1)

	return
end

function pg.SdkMgr:IsHuaweiPackage()
	return PLATFORM_CODE == PLATFORM_CH and self:Get("IsHuaweiPackage")
end

function pg.SdkMgr:CheckAudit()
	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		return self:Get("CheckAudit")
	else
		return false
	end

	return
end

function pg.SdkMgr:CheckPreAudit()
	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		return self:Get("CheckPreAudit")
	else
		return false
	end

	return
end

function pg.SdkMgr:CheckPretest()
	return self:Get("CheckPretest")
end

function pg.SdkMgr:CheckGoogleSimulator()
	return self:Get("CheckGoogleSimulator")
end

function pg.SdkMgr:CheckWorldTest()
	if PLATFORM_CODE == PLATFORM_CH then
		return self:Get("CheckWorldTest")
	else
		return false
	end

	return
end

function pg.SdkMgr:OnAppPauseForSDK(arg_39_1)
	self:Call("OnAppPauseForSDK", arg_39_1)

	return
end

function pg.SdkMgr:UserEventUpload(arg_40_1)
	self:Call("UserEventUpload", arg_40_1)

	return
end

function pg.SdkMgr:GameShare(arg_41_1, arg_41_2)
	self:Call("GameShare", arg_41_1, arg_41_2)

	return
end

if PLATFORM_CODE == PLATFORM_US then
	(function()
		function var_0_0:GetYostarUid()
			return self:Get("GetYostarUid")
		end

		function var_0_0:GetYostarTransCode()
			return self:Get("GetTransCode")
		end

		function var_0_0:AiriLoginSDK()
			self:Call("AiriLogin")

			return
		end

		function var_0_0:TranscodeRequest()
			self:Call("TranscodeRequest")

			return
		end

		function var_0_0:LoginWithTranscode(arg_47_1, arg_47_2)
			self:Call("LoginWithTranscode", arg_47_1, arg_47_2)

			return
		end

		function var_0_0:LoginWithSocial(arg_48_1, arg_48_2, arg_48_3)
			self:Call("LoginWithSocial", arg_48_1, arg_48_2, arg_48_3)

			return
		end

		function var_0_0:LoginWithDevice()
			self:Call("LoginWithDevice")

			return
		end

		function var_0_0:AiriBuy(arg_50_1, arg_50_2, arg_50_3)
			self:Call("AiriBuy", arg_50_1, arg_50_2, arg_50_3)

			return
		end

		function var_0_0:LinkSocial(arg_51_1, arg_51_2, arg_51_3)
			self:Call("LinkSocial", arg_51_1, arg_51_2, arg_51_3)

			return
		end

		function var_0_0:UnlinkSocial(arg_52_1)
			self:Call("UnlinkSocial", arg_52_1)

			return
		end

		function var_0_0:IsSocialLink(arg_53_1)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return self:Get("IsSocialLink", arg_53_1)
			else
				return false
			end

			return
		end

		function var_0_0:GetSocialName(arg_54_1)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return self:Get("GetSocialName", arg_54_1)
			else
				return "none"
			end

			return
		end

		function var_0_0:GetIsBirthSet()
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return self:Get("GetIsBirthSet")
			end

			return true
		end

		function var_0_0:SetBirth(arg_56_1)
			self:Call("SetBirth", arg_56_1)

			return
		end

		function var_0_0:ClearAccountCache()
			self:Call("ClearAccountCache")

			return
		end

		function var_0_0:GameShare(arg_58_1, arg_58_2)
			self:Call("GameShare", arg_58_1, arg_58_2)

			return
		end

		function var_0_0:VerificationCodeReq(arg_59_1)
			self:Call("VerificationCodeReq", arg_59_1)

			return
		end

		function var_0_0:OpenYostarHelp()
			self:Call("OpenYostarHelp")

			return
		end

		function var_0_0:OnAppPauseForSDK(arg_61_1)
			self:Call("OnAppPauseForSDK", arg_61_1)

			return
		end

		function var_0_0:UserEventUpload(arg_62_1)
			self:Call("UserEventUpload", arg_62_1)

			return
		end

		function var_0_0:ShowSurvey(arg_63_1, arg_63_2)
			return self:Call("ShowSurvey", arg_63_1, arg_63_2)
		end

		function var_0_0:CheckAiriCanBuy()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("CheckAiriCanBuy")
			else
				return true
			end

			return
		end

		function var_0_0:CheckHadAccountCache()
			if PLATFORM_CODE == PLATFORM_JP then
				return self:Get("CheckHadAccountCache")
			else
				return true
			end

			return
		end

		function var_0_0:AccountDelete()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("AccountDelete")
			else
				return true
			end

			return
		end

		function var_0_0:AccountReborn()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("AccountReborn")
			else
				return true
			end

			return
		end

		function var_0_0:ConfirmLinkGooglePlayGame()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("ConfirmLinkGooglePlayGame")
			else
				return true
			end

			return
		end

		function var_0_0:ConfirmUnLinkGooglePlayGame()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("ConfirmUnLinkGooglePlayGame")
			else
				return true
			end

			return
		end

		function var_0_0:BindYostarPass()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("BindYostarPass")
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
	(function()
		function var_0_0:YoStarLoginSDK()
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				self:Call("Login")
			end

			return
		end

		function var_0_0:YoStarPay(arg_74_1, arg_74_2, arg_74_3)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				self:Call("Pay", arg_74_1, arg_74_2, arg_74_3)
			end

			return
		end

		function var_0_0:GameShare(arg_75_1, arg_75_2)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				self:Call("SystemShare", arg_75_1, arg_75_2)
			end

			return
		end

		function var_0_0:YostarOpenAiHelp()
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				self:Call("ShowAihelp")
			end

			return
		end

		function var_0_0:OnAppPauseForSDK(arg_77_1)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				self:Call("OnAppPauseForSDK", arg_77_1)
			end

			return
		end

		function var_0_0:YoStarShowSurvey(arg_78_1, arg_78_2)
			if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
				return self:Call("ShowSurvey", arg_78_1, arg_78_2)
			end

			return
		end

		function var_0_0:YoStarCheckCanBuy()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("CheckYoStarCanBuy")
			end

			return
		end

		function var_0_0:YoStarCheckHadAccountCache()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("CheckHadAccountCache")
			end

			return
		end

		function var_0_0:YoStarShowUserCenter()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("ShowUserCenter")
			end

			return
		end

		function var_0_0:YoStarRoleInfoUpload()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("RoleInfoUpload")
			end

			return
		end

		function var_0_0:YoStarShowSwitchAccount()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("ShowSwitchAccount")
			end

			return
		end

		function var_0_0:YoStarShowAccountCenter()
			if PLATFORM_CODE == PLATFORM_US or PLATFORM_CODE == PLATFORM_JP then
				return self:Get("ShowAccountCenter")
			end

			return
		end

		function var_0_0:UserEventUpload(arg_85_1)
			self:Call("UserEventUpload", arg_85_1)

			return
		end

		return
	end)()
end

function pg.SdkMgr:UserCenter()
	self:Call("UserCenter")

	return
end

function pg.SdkMgr:BugReport()
	self:Call("BugReport")

	return
end

function pg.SdkMgr:StoreReview()
	self:Call("StoreReview")

	return
end

function pg.SdkMgr:QueryWithProduct()
	self:Call("QueryWithProduct")

	return
end

function pg.SdkMgr:QueryPendingTransaction()
	self:Call("QueryPendingTransaction")

	return
end

function pg.SdkMgr:ShareImg(arg_91_1, arg_91_2)
	self:Call("ShareImg", arg_91_1, arg_91_2)

	return
end

function pg.SdkMgr:SwitchAccount()
	self:Call("SwitchAccount")

	return
end

function pg.SdkMgr:EventTrack(arg_93_1)
	self:Call("EventTrack", arg_93_1)

	return
end

function pg.SdkMgr:EventTrack(arg_94_1)
	self:Call("EventTrack", arg_94_1)

	return
end

function pg.SdkMgr:IsBindFaceBook()
	if PLATFORM_CODE == PLATFORM_CHT then
		return self:Get("IsBindFaceBook")
	end

	return
end

function pg.SdkMgr:IsBindApple()
	if PLATFORM_CODE == PLATFORM_CHT then
		return self:Get("IsBindApple")
	end

	return
end

function pg.SdkMgr:IsBindGoogle()
	if PLATFORM_CODE == PLATFORM_CHT then
		return self:Get("IsBindGoogle")
	end

	return
end

function pg.SdkMgr:IsBindPhone()
	if PLATFORM_CODE == PLATFORM_CHT then
		return self:Get("IsBindPhone")
	end

	return
end

function pg.SdkMgr.IsBindGameCenter(arg_99_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return false
	end

	return
end

function pg.SdkMgr:CanTriggerDeepLinking()
	if PLATFORM_CODE == PLATFORM_CHT then
		return self:Get("CanTriggerDeepLinking")
	else
		return false
	end

	return
end

function pg.SdkMgr:TriggerDeepLinking()
	self:Call("TriggerDeepLinking")

	return
end

function pg.SdkMgr:BindSocial(arg_102_1)
	if arg_102_1 == 1 then
		self:BindFaceBook()
	elseif arg_102_1 == 2 then
		self:BindGoogle()
	elseif arg_102_1 == 3 then
		self:BindPhone()
	elseif arg_102_1 == 4 then
		-- block empty
	elseif arg_102_1 == 5 then
		self:BindApple()
	end

	return
end

function pg.SdkMgr:UnbindSocial(arg_103_1)
	if arg_103_1 == 1 then
		self:UnBindFaceBook()
	elseif arg_103_1 == 2 then
		self:UnBindGoogle()
	elseif arg_103_1 == 3 then
		self:UnBindPhone()
	elseif arg_103_1 == 4 then
		-- block empty
	end

	return
end

function pg.SdkMgr:BindFaceBook()
	self:Call("BindFaceBook")

	return
end

function pg.SdkMgr:BindApple()
	self:Call("BindApple")

	return
end

function pg.SdkMgr:BindGoogle()
	self:Call("BindGoogle")

	return
end

function pg.SdkMgr:BindPhone()
	self:Call("BindPhone")

	return
end

function pg.SdkMgr:UnBindFaceBook()
	self:Call("UnBindFaceBook")

	return
end

function pg.SdkMgr:UnBindGoogle()
	self:Call("UnBindGoogle")

	return
end

function pg.SdkMgr:UnBindPhone()
	self:Call("UnBindPhone")

	return
end

function pg.SdkMgr:ShowLicence()
	self:Call("ShowLicence")

	return
end

function pg.SdkMgr:ShowPrivate()
	self:Call("ShowPrivate")

	return
end

function pg.SdkMgr:OpenMiniProgram()
	self:Call("OpenMiniProgram")

	return
end

function pg.SdkMgr:GetProduct(arg_114_1)
	if PLATFORM_CODE == PLATFORM_CHT then
		return self:Get("GetProduct", arg_114_1)
	end

	return
end

function pg.SdkMgr:GetDeviceId()
	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		return self:Get("GetDeviceId")
	elseif PLATFORM_CODE == PLATFORM_KR then
		return self:Get("GetDeviceModel")
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

function pg.SdkMgr:GetPlatformCode(arg_118_1)
	if PLATFORM_CODE == PLATFORM_CHT then
		return self:Get("GetPackageCode", arg_118_1)
	else
		return nil
	end

	return
end

function pg.SdkMgr:IgnorePlatform(arg_119_1)
	local var_119_0 = self.pcode

	if self.pcode and arg_119_1 and #arg_119_1 > 0 and _.any(arg_119_1, function(arg_120_0)
		return tostring(arg_120_0) == var_119_0
	end) then
		return true
	end

	return false
end

return

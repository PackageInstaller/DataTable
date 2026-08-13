local var_0_0 = {}

YoStarSDKMgr = var_0_10001

local var_0_1 = var_0_10001.inst

var_0_0.YOSTAR_SDK_INITED = false
var_0_0.OnYoStarPaying = -1
var_0_0.BuyingLimit = 60
var_0_0.isCache = false
var_0_0.DeviceID = "-1"
var_0_0.isAudit = false
var_0_0.isPreAudit = false
var_0_0.isPretest = false
var_0_0.isGoogleSimulator = false
var_0_0.isRelease = false
PLATFORM_YOSTARJP = var_2
var_0_0.LoginPlatform = var_2
var_0_0.SDK_PID_TEST = "JP-AZURLANE-TEST"
var_0_0.SDK_PID_RELEASE = "JP-AZURLANE"
var_0_0.SDK_SERVER_URL = "https://jp-sdk-api.yostarplat.com"
var_0_0.SDK_TRANS_URL = "https://migration.yostar.co.jp?pid=JP-AZURLANE"

function var_0_0.InitJP()
	local var_1_0 = var_0_0

	NetConst = var_1_10001

	if var_1_10001.GATEWAY_PORT == 20001 then
		NetConst = var_1

		local var_1_1

		if var_1.GATEWAY_HOST ~= "blhxjpauditapi.azurlane.jp" then
			var_1_1 = false
		else
			var_1_1 = true
		end

		var_1_0.isAudit = var_1_1

		local var_1_2 = var_0_0

		NetConst = var_1_1

		if var_1_1.GATEWAY_PORT == 30001 then
			NetConst = var_1

			if var_1.GATEWAY_HOST ~= "blhxjpauditapi.azurlane.jp" then
				NetConst = var_1

				if var_1.GATEWAY_PORT == 21 then
					NetConst = var_1

					local var_1_3

					if var_1.GATEWAY_HOST ~= "blhxjpauditapi.azurlane.jp" then
						var_1_3 = false

						goto label_1_0
					end

					var_1_3 = true

					::label_1_0::

					var_1_2.isPreAudit = var_1_3

					local var_1_4 = var_0_0

					IsUnityEditor = var_1_3
					var_1_3 = var_1_3 or var_0_0.isPreAudit
					var_1_4.isPretest = var_1_3

					local var_1_5 = var_0_0

					NetConst = var_1_3

					if var_1_3.GATEWAY_PORT == 4001 then
						NetConst = var_1

						local var_1_6

						if var_1.GATEWAY_HOST ~= "business.azurlane.jp" then
							var_1_6 = false
						else
							var_1_6 = true
						end

						var_1_5.isGoogleSimulator = var_1_6

						local var_1_7 = var_0_0

						NetConst = var_1_6

						if var_1_6.GATEWAY_PORT == 80 then
							NetConst = var_1

							local var_1_8

							if var_1.GATEWAY_HOST ~= "blhxjploginapi.azurlane.jp" then
								var_1_8 = false
							else
								var_1_8 = true
							end

							var_1_7.isRelease = var_1_8

							local var_1_9 = var_0_0

							PLATFORM_YOSTARJP = var_1_8
							var_1_9.LoginPlatform = var_1_8
							var_0_0.SDK_PID_TEST = "JP-AZURLANE-TEST"
							var_0_0.SDK_PID_RELEASE = "JP-AZURLANE"
							var_0_0.SDK_SERVER_URL = "https://jp-sdk-api.yostarplat.com"
							var_0_0.SDK_TRANS_URL = "https://migration.yostar.co.jp?pid=JP-AZURLANE"

							return
						end
					end
				end
			end
		end
	end
end

function var_0_0.InitUS()
	local var_2_0 = var_0_0

	NetConst = var_1_10001

	if var_1_10001.GATEWAY_PORT == 20001 then
		NetConst = var_1

		local var_2_1

		if var_1.GATEWAY_HOST ~= "audit.us.yo-star.com" then
			var_2_1 = false
		else
			var_2_1 = true
		end

		var_2_0.isAudit = var_2_1

		local var_2_2 = var_0_0

		NetConst = var_2_1

		if var_2_1.GATEWAY_PORT == 30001 then
			NetConst = var_1

			local var_2_3

			if var_1.GATEWAY_HOST ~= "audit.us.yo-star.com" then
				var_2_3 = false
			else
				var_2_3 = true
			end

			var_2_2.isPreAudit = var_2_3

			local var_2_4 = var_0_0

			IsUnityEditor = var_2_3
			var_2_3 = var_2_3 or var_0_0.isPreAudit
			var_2_4.isPretest = var_2_3

			local var_2_5 = var_0_0

			NetConst = var_2_3

			if var_2_3.GATEWAY_PORT == 50001 then
				NetConst = var_1

				local var_2_6

				if var_1.GATEWAY_HOST ~= "audit.us.yo-star.com" then
					var_2_6 = false
				else
					var_2_6 = true
				end

				var_2_5.isGoogleSimulator = var_2_6

				local var_2_7 = var_0_0

				NetConst = var_2_6

				if var_2_6.GATEWAY_PORT == 80 then
					NetConst = var_1

					local var_2_8

					if var_1.GATEWAY_HOST ~= "blhxusgate.yo-star.com" then
						var_2_8 = false
					else
						var_2_8 = true
					end

					var_2_7.isRelease = var_2_8

					local var_2_9 = var_0_0

					PLATFORM_YOSTARUS = var_2_8
					var_2_9.LoginPlatform = var_2_8
					var_0_0.SDK_PID_TEST = ""
					var_0_0.SDK_PID_RELEASE = ""
					var_0_0.SDK_SERVER_URL = ""
					var_0_0.SDK_TRANS_URL = ""

					return
				end
			end
		end
	end
end

function var_0_0.CheckAudit()
	NetConst = var_1_10000

	return var_1_10000.getwayType == 1
end

function var_0_0.CheckPreAudit()
	return var_0_0.isPreAudit
end

function var_0_0.CheckPretest()
	return var_0_0.isPretest
end

function var_0_0.CheckGoogleSimulator()
	NetConst = var_1_10000

	return var_1_10000.getwayType == 2
end

function var_0_0.CheckRelease()
	NetConst = var_1_10000

	return var_1_10000.getwayType == 0
end

function var_0_0.CheckBiz()
	NetConst = var_1_10000

	return var_1_10000.getwayType == 3
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GetChannelUID()
	return var_0_1.channelUID
end

function var_0_0.GoSDkLoginScene()
	local var_12_0 = var_0_1

	var_0.GoLoginScene(var_12_0)
	var_0_0.Init()

	return
end

local function var_0_2()
	IsUnityEditor = var_1_10000

	if var_1_10000 then
		onInit_YoStar = var_1_10000

		var_1_10000({
			R_CODE = 0
		})
	end

	return
end

local var_0_3 = GoLoginScene

function var_0_0.EnterServer()
	var_0_0.RoleInfoUpload()

	return
end

function var_0_0.Survey(arg_15_0)
	Application = var_1_10001

	var_1_10001.OpenURL(arg_15_0)

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

function var_0_0.CheckYoStarCanBuy()
	if var_0_0.OnYoStarPaying ~= -1 then
		Time = var_0

		if var_0.realtimeSinceStartup - var_0_0.OnYoStarPaying > var_0_0.BuyingLimit then
			return true
		else
			return false
		end

		return
	end
end

function var_0_0.OnAppPauseForSDK(arg_19_0)
	if not var_0_0.YOSTAR_SDK_INITED then
		return
	end

	if arg_19_0 then
		local var_19_0 = var_0_1

		var_1.OnPause(var_19_0)
	else
		local var_19_1 = var_0_1

		var_1.OnResume(var_19_1)
	end

	return
end

function var_0_0.YoStarGoLogin(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.m02
	local var_20_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_20_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_20_1(var_20_0, var_20_2, var_1_10004.LOGIN, {
		loginPlatform = arg_20_0
	})

	gcAll = var_20_1

	var_20_1()

	return
end

function var_0_0.GetDeviceId()
	return var_0_0.DeviceID
end

function var_0_0.CheckHadAccountCache()
	if var_0_0.GetIsPlatform() then
		local var_22_0

		if not var_0_0.CheckUserCacheExist() then
			var_22_0 = var_0_0.isCache
		end

		return var_22_0
	else
		return true
	end

	return
end

;(function()
	function var_0_0.Init(arg_24_0)
		pg = var_2_10001

		local var_24_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOn(var_24_0)

		if var_0_0.GetIsPlatform() then
			local var_24_1 = var_0_1
			local var_24_2

			if not var_0_0.CheckRelease() and not var_0_0.CheckAudit() or not var_0_0.SDK_PID_RELEASE then
				var_24_2 = var_0_0.SDK_PID_TEST
			end

			var_24_1.pid = var_24_2
			var_0_1.gameServerUrl = var_0_0.SDK_SERVER_URL

			local var_24_3 = var_0_1

			var_1.Init(var_24_3)
		end

		return
	end

	function var_0_0.Login()
		if var_0_0.GetIsPlatform() then
			pg = var_0

			local var_25_0 = var_0.UIMgr.GetInstance()

			var_0.LoadingOn(var_25_0)

			local var_25_1 = var_0_1

			var_0.Login(var_25_1)
		end

		return
	end

	function var_0_0.SetBirthday()
		if var_0_0.GetIsPlatform() then
			local var_26_0 = var_0_1

			var_0.SetBirthday(var_26_0)
		end

		return
	end

	function var_0_0.ShowUserCenter()
		if var_0_0.GetIsPlatform() then
			local var_27_0 = var_0_1

			var_0.ShowUserCenter(var_27_0)
		end

		return
	end

	function var_0_0.Pay(arg_28_0, arg_28_1, arg_28_2)
		if var_0_0.GetIsPlatform() then
			pg = var_3

			local var_28_0 = var_3.UIMgr.GetInstance()

			var_3.LoadingOn(var_28_0)

			local var_28_1 = var_0_0

			Time = var_28_0
			var_28_1.OnYoStarPaying = var_28_0.realtimeSinceStartup

			local var_28_2 = var_0_1

			var_3.Pay(var_28_2, arg_28_0, arg_28_1, arg_28_2)
		end

		return
	end

	function var_0_0.ShowAihelp()
		if var_0_0.GetIsPlatform() then
			local var_29_0 = var_0_1

			var_0.ShowAihelp(var_29_0)
		end

		return
	end

	function var_0_0.UserEventUpload(arg_30_0)
		if var_0_0.GetIsPlatform() then
			local var_30_0 = var_0_1

			var_1.UserEventUpload(var_30_0, arg_30_0)
		end

		return
	end

	function var_0_0.RoleInfoUpload()
		if var_0_0.GetIsPlatform() then
			getProxy = var_0
			PlayerProxy = var_2_10001

			local var_31_0 = var_0(var_2_10001)
			local var_31_1 = var_0.getData(var_31_0)

			getProxy = var_31_0
			UserProxy = var_2_10003

			local var_31_2 = var_31_0(var_2_10003)
			local var_31_3 = var_2.getData(var_31_2)

			getProxy = var_31_2
			ServerProxy = var_2_10005

			local var_31_4 = var_31_2(var_2_10005)
			local var_31_5 = var_4.getLastServer(var_31_4, var_31_3.uid)

			tostring = var_31_4

			local var_31_6 = var_31_4(var_31_5.id .. " - " .. var_31_5.name)

			tostring = var_7

			local var_31_7 = var_7(var_31_1.id)
			local var_31_8 = var_31_1.name
			local var_31_9 = {}

			tostring = var_2_10010
			var_31_9[1] = var_2_10010(var_31_1.rmb)
			YoStarRoleInfo = var_10

			local var_31_10 = var_10.New(var_31_6, var_31_7, var_31_8, var_31_9)
			local var_31_11 = var_0_1

			var_11.RoleInfoUpload(var_31_11, var_31_10)
		end

		return
	end

	function var_0_0.ShowSurvey(arg_32_0, arg_32_1)
		if var_0_0.GetIsPlatform() then
			getProxy = var_2
			PlayerProxy = var_2_10003

			local var_32_0 = var_2(var_2_10003)
			local var_32_1 = var_2.getData(var_32_0)
			local var_32_2 = var_0_1
			local var_32_3 = var_4.ShowSurvey
			local var_32_4 = arg_32_0

			tostring = var_2_10007

			var_32_3(var_32_2, var_32_4, var_2_10007(var_32_1.id), arg_32_1)
		end

		return
	end

	function var_0_0.ShowAgreement(arg_33_0)
		if var_0_0.GetIsPlatform() then
			local var_33_0 = var_0_1

			var_1.ShowSurvey(var_33_0, arg_33_0)
		end

		return
	end

	function var_0_0.ShowSwitchAccount()
		if var_0_0.GetIsPlatform() then
			local var_34_0 = var_0_1

			var_0.ShowSwitchAccount(var_34_0)
		end

		return
	end

	function var_0_0.SystemShare(arg_35_0, arg_35_1)
		if var_0_0.GetIsPlatform() then
			local var_35_0 = var_0_1

			var_2.SystemShare(var_35_0, arg_35_0, arg_35_1)
		end

		return
	end

	function var_0_0.ShareImage(arg_36_0)
		if var_0_0.GetIsPlatform() then
			local var_36_0 = var_0_1

			var_1.ShareImage(var_36_0, arg_36_0)
		end

		return
	end

	function var_0_0.ShareUrl(arg_37_0, arg_37_1)
		if var_0_0.GetIsPlatform() then
			local var_37_0 = var_0_1

			var_2.ShareUrl(var_37_0, arg_37_0, arg_37_1)
		end

		return
	end

	function var_0_0.ShowNetworkTest(arg_38_0)
		if var_0_0.GetIsPlatform() then
			local var_38_0 = var_0_1

			var_1.ShowNetworkTest(var_38_0, arg_38_0)
		end

		return
	end

	function var_0_0.ShowWebView(arg_39_0, arg_39_1)
		if var_0_0.GetIsPlatform() then
			local var_39_0 = var_0_1

			var_2.ShowWebView(var_39_0, arg_39_0, arg_39_1)
		end

		return
	end

	function var_0_0.RequestStoreReview()
		if var_0_0.GetIsPlatform() then
			local var_40_0 = var_0_1

			var_0.RequestStoreReview(var_40_0)
		end

		return
	end

	function var_0_0.QueryErrorMsg(arg_41_0)
		if var_0_0.GetIsPlatform() then
			local var_41_0 = var_0_1

			return var_1.QueryErrorMsg(var_41_0, arg_41_0)
		end

		return
	end

	function var_0_0.QuerySkuDetails(arg_42_0)
		if var_0_0.GetIsPlatform() then
			local var_42_0 = var_0_1

			var_1.QuerySkuDetails(var_42_0)
		end

		return
	end

	function var_0_0.QueryTextLegality(arg_43_0)
		if var_0_0.GetIsPlatform() then
			local var_43_0 = var_0_1

			var_1.QueryTextLegality(var_43_0, arg_43_0)
		end

		return
	end

	function var_0_0.ShowAccountCenter()
		if var_0_0.GetIsPlatform() then
			local var_44_0 = var_0_1

			var_0.ShowAccountCenter(var_44_0)
		end

		return
	end

	function var_0_0.FetchDeviceTrackingID()
		if var_0_0.GetIsPlatform() then
			local var_45_0 = var_0_1

			var_0.FetchDeviceTrackingID(var_45_0)
		end

		return
	end

	function var_0_0.CheckUserCacheExist()
		if var_0_0.GetIsPlatform() then
			local var_46_0 = var_0_1

			var_0.CheckUserCacheExist(var_46_0)
		end

		return
	end

	function var_0_0.BuildLocalNotification(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		if var_0_0.GetIsPlatform() then
			local var_47_0 = var_0_1

			var_4.BuildLocalNotification(var_47_0, arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		end

		return
	end

	function var_0_0.DeleteLocalNotification(arg_48_0)
		if var_0_0.GetIsPlatform() then
			local var_48_0 = var_0_1

			var_1.DeleteLocalNotification(var_48_0, arg_48_0)
		end

		return
	end

	return
end)()
;(function()
	local function var_49_0(arg_50_0)
		pg = var_2_10001

		local var_50_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_50_0)

		if var_0_0.YoStarRetCodeHandler(arg_50_0) then
			var_0_0.YOSTAR_SDK_INITED = true

			var_0_0.FetchDeviceTrackingID()
			var_0_0.YoStarGoLogin()
		end

		return
	end

	local var_49_1 = onInit_YoStar

	local function var_49_2(arg_51_0)
		pg = var_2_10001

		local var_51_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_51_0)

		if var_0_0.YoStarRetCodeHandler(arg_51_0) then
			User = var_1

			local var_51_1 = var_1.New({
				type = 1,
				arg1 = var_0_0.LoginPlatform,
				arg2 = arg_51_0.LOGIN_UID,
				arg3 = arg_51_0.LOGIN_TOKEN
			})

			pg = var_2

			local var_51_2 = var_2.m02
			local var_51_3 = var_2.sendNotification

			GAME = var_2_10004

			var_51_3(var_51_2, var_2_10004.PLATFORM_LOGIN_DONE, {
				user = var_51_1
			})
		end

		return
	end

	local var_49_3 = onLogin_YoStar

	local function var_49_4(arg_52_0)
		if var_0_0.YoStarRetCodeHandler(arg_52_0) then
			pg = var_1

			local var_52_0 = var_1.m02
			local var_52_1 = var_1.sendNotification

			GAME = var_2_10003

			var_52_1(var_52_0, var_2_10003.LOGOUT, {
				code = 0
			})
		end

		return
	end

	local var_49_5 = onLogout_YoStar

	local function var_49_6(arg_53_0)
		local var_53_0 = var_0_0

		var_53_0.OnYoStarPaying = -1
		pg = var_53_0

		local var_53_1 = var_53_0.UIMgr.GetInstance()

		var_1.LoadingOff(var_53_1)

		local var_53_2, var_53_3

		if var_0_0.YoStarRetCodeHandler(arg_53_0) then
			getProxy = var_53_3
			ShopsProxy = var_53_2
			var_53_2 = var_53_3(var_53_2)

			var_53_3.removeWaitTimer(var_53_2)

			pg = var_53_3
			var_53_2 = var_53_3.m02
			var_53_3 = var_53_3.sendNotification
			GAME = var_2_10003

			var_53_3(var_53_2, var_2_10003.CHARGE_CONFIRM, {
				payId = arg_53_0.EXTRA_DATA,
				bsId = arg_53_0.ORDER_ID
			})
		else
			getProxy = var_53_3
			ShopsProxy = var_53_2

			local var_53_4 = var_53_3(var_53_2)

			var_1.removeWaitTimer(var_53_4)

			pg = var_1

			local var_53_5 = var_1.m02
			local var_53_6 = var_1.sendNotification

			GAME = var_2_10003

			var_53_6(var_53_5, var_2_10003.CHARGE_FAILED, {
				payId = arg_53_0.EXTRA_DATA
			})
		end

		return
	end

	local var_49_7 = onPay_YoStar

	local function var_49_8(arg_54_0)
		if var_0_0.YoStarRetCodeHandler(arg_54_0) then
			-- block empty
		end

		return
	end

	local var_49_9 = onSystemShare_YoStar

	local function var_49_10(arg_55_0)
		if var_0_0.YoStarRetCodeHandler(arg_55_0) then
			pg = var_1

			local var_55_0 = var_1.m02
			local var_55_1 = var_1.sendNotification

			GAME = var_2_10003

			var_55_1(var_55_0, var_2_10003.LOGOUT, {
				code = 0
			})
		end

		return
	end

	local var_49_11 = onDeleteAccount_YoStar

	local function var_49_12(arg_56_0)
		if var_0_0.YoStarRetCodeHandler(arg_56_0) then
			pg = var_1

			local var_56_0 = var_1.m02
			local var_56_1 = var_1.sendNotification

			GAME = var_2_10003

			var_56_1(var_56_0, var_2_10003.LOGOUT, {
				code = 0
			})
		end

		return
	end

	local var_49_13 = onClearSDKCache_YoStar

	local function var_49_14(arg_57_0)
		if var_0_0.YoStarRetCodeHandler(arg_57_0) then
			-- block empty
		end

		return
	end

	local var_49_15 = onQuerySkuDetails_YoStar

	local function var_49_16(arg_58_0)
		if var_0_0.YoStarRetCodeHandler(arg_58_0) then
			-- block empty
		end

		return
	end

	local var_49_17 = onUserSurvey_YoStar

	local function var_49_18(arg_59_0)
		return
	end

	local var_49_19 = onSwitchServer_YoStar

	local function var_49_20(arg_60_0)
		if var_0_0.YoStarRetCodeHandler(arg_60_0) then
			-- block empty
		end

		return
	end

	local var_49_21 = onQueryTextLegality_YoStar

	local function var_49_22(arg_61_0)
		if var_0_0.YoStarRetCodeHandler(arg_61_0) then
			-- block empty
		end

		return
	end

	local var_49_23 = onPushMsgReceive_YoStar

	local function var_49_24(arg_62_0)
		if var_0_0.YoStarRetCodeHandler(arg_62_0) then
			-- block empty
		end

		return
	end

	local var_49_25 = onUniversalLink_YoStar

	local function var_49_26(arg_63_0)
		if var_0_0.YoStarRetCodeHandler(arg_63_0) then
			var_0_0.DeviceID = arg_63_0.DATA
		end

		return
	end

	local var_49_27 = onDeviceTrackingID_YoStar

	local function var_49_28(arg_64_0)
		if var_0_0.YoStarRetCodeHandler(arg_64_0) then
			-- block empty
		end

		return
	end

	local var_49_29 = onLocalNotification_YoStar

	local function var_49_30(arg_65_0)
		if var_0_0.YoStarRetCodeHandler(arg_65_0) then
			-- block empty
		end

		return
	end

	local var_49_31 = onSetBirthday_YoStar

	return
end)()

function var_0_0.YoStarRetCodeHandler(arg_66_0)
	if arg_66_0.R_CODE == 0 then
		return true
	else
		local var_66_0 = "SDK Error Code:" .. var_1

		originalPrint = var_3

		var_3(var_66_0)

		if var_0_0.QueryErrorMsg(var_1) then
			string = var_4

			if var_4.len(var_3) > 0 then
				pg = var_4

				local var_66_1 = var_4.TipsMgr.GetInstance()

				var_4.ShowTips(var_66_1, var_3)

				goto label_66_0
			end
		end

		pg = var_4

		local var_66_2 = var_4.TipsMgr.GetInstance()

		var_4.ShowTips(var_66_2, var_66_0)
	end

	::label_66_0::

	return false
end

return var_0_0

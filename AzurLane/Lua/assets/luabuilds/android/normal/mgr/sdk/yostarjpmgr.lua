local var_0_0 = {}

YoStarSDKMgr = var_0_10001

local var_0_1 = var_0_10001.inst

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

function var_0_0.CheckRelease()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_PORT == 80 then
		NetConst = var_0

		local var_5_0

		if var_0.GATEWAY_HOST ~= "blhxjploginapi.azurlane.jp" then
			var_5_0 = false
		else
			var_5_0 = true
		end

		return var_5_0
	end
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
	local var_9_0 = var_0_1

	var_0.GoLoginScene(var_9_0)
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

function var_0_0.Survey(arg_12_0)
	Application = var_1_10001

	var_1_10001.OpenURL(arg_12_0)

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

function var_0_0.OnAppPauseForSDK(arg_16_0)
	if not var_0_0.YOSTAR_SDK_INITED then
		return
	end

	if arg_16_0 then
		local var_16_0 = var_0_1

		var_1.OnPause(var_16_0)
	else
		local var_16_1 = var_0_1

		var_1.OnResume(var_16_1)
	end

	return
end

function var_0_0.YoStarGoLogin(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.m02
	local var_17_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_17_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_17_1(var_17_0, var_17_2, var_1_10004.LOGIN, {
		loginPlatform = arg_17_0
	})

	gcAll = var_17_1

	var_17_1()

	return
end

function var_0_0.GetDeviceId()
	return var_0_0.DeviceID
end

function var_0_0.CheckHadAccountCache()
	if var_0_0.GetIsPlatform() then
		local var_19_0

		if not var_0_0.CheckUserCacheExist() then
			var_19_0 = var_0_0.isCache
		end

		return var_19_0
	else
		return true
	end

	return
end

var_0_0.YOSTAR_SDK_INITED = false
var_0_0.OnYoStarPaying = -1
var_0_0.BuyingLimit = 60
var_0_0.isCache = false
var_0_0.DeviceID = "-1"
PLATFORM_YOSTARJP = var_2
var_0_0.LoginPlatform = var_2
var_0_0.SDK_PID_TEST = "JP-AZURLANE-TEST"
var_0_0.SDK_PID_RELEASE = "JP-AZURLANE"
var_0_0.SDK_SERVER_URL = "https://jp-sdk-api.yostarplat.com"
var_0_0.SDK_TRANS_URL = "https://migration.yostar.co.jp?pid=JP-AZURLANE"

;(function()
	function var_0_0.Init(arg_21_0)
		pg = var_2_10001

		local var_21_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOn(var_21_0)

		if var_0_0.GetIsPlatform() then
			local var_21_1 = var_0_1
			local var_21_2

			if not var_0_0.CheckRelease() and not var_0_0.CheckAudit() or not var_0_0.SDK_PID_RELEASE then
				var_21_2 = var_0_0.SDK_PID_TEST
			end

			var_21_1.pid = var_21_2
			var_0_1.gameServerUrl = var_0_0.SDK_SERVER_URL

			local var_21_3 = var_0_1

			var_1.Init(var_21_3)
		end

		return
	end

	function var_0_0.Login()
		if var_0_0.GetIsPlatform() then
			pg = var_0

			local var_22_0 = var_0.UIMgr.GetInstance()

			var_0.LoadingOn(var_22_0)

			local var_22_1 = var_0_1

			var_0.Login(var_22_1)
		end

		return
	end

	function var_0_0.SetBirthday()
		if var_0_0.GetIsPlatform() then
			local var_23_0 = var_0_1

			var_0.SetBirthday(var_23_0)
		end

		return
	end

	function var_0_0.ShowUserCenter()
		if var_0_0.GetIsPlatform() then
			local var_24_0 = var_0_1

			var_0.ShowUserCenter(var_24_0)
		end

		return
	end

	function var_0_0.Pay(arg_25_0, arg_25_1, arg_25_2)
		if var_0_0.GetIsPlatform() then
			pg = var_3

			local var_25_0 = var_3.UIMgr.GetInstance()

			var_3.LoadingOn(var_25_0)

			local var_25_1 = var_0_0

			Time = var_25_0
			var_25_1.OnYoStarPaying = var_25_0.realtimeSinceStartup

			local var_25_2 = var_0_1

			var_3.Pay(var_25_2, arg_25_0, arg_25_1, arg_25_2)
		end

		return
	end

	function var_0_0.ShowAihelp()
		if var_0_0.GetIsPlatform() then
			local var_26_0 = var_0_1

			var_0.ShowAihelp(var_26_0)
		end

		return
	end

	function var_0_0.UserEventUpload(arg_27_0)
		if var_0_0.GetIsPlatform() then
			local var_27_0 = var_0_1

			var_1.UserEventUpload(var_27_0, arg_27_0)
		end

		return
	end

	function var_0_0.RoleInfoUpload()
		if var_0_0.GetIsPlatform() then
			getProxy = var_0
			PlayerProxy = var_2_10001

			local var_28_0 = var_0(var_2_10001)
			local var_28_1 = var_0.getData(var_28_0)

			getProxy = var_28_0
			UserProxy = var_2_10003

			local var_28_2 = var_28_0(var_2_10003)
			local var_28_3 = var_2.getData(var_28_2)

			getProxy = var_28_2
			ServerProxy = var_2_10005

			local var_28_4 = var_28_2(var_2_10005)
			local var_28_5 = var_4.getLastServer(var_28_4, var_28_3.uid)

			tostring = var_28_4

			local var_28_6 = var_28_4(var_28_5.id .. " - " .. var_28_5.name)

			tostring = var_7

			local var_28_7 = var_7(var_28_1.id)
			local var_28_8 = var_28_1.name
			local var_28_9 = {}

			tostring = var_2_10010
			var_28_9[1] = var_2_10010(var_28_1.rmb)
			YoStarRoleInfo = var_10

			local var_28_10 = var_10.New(var_28_6, var_28_7, var_28_8, var_28_9)
			local var_28_11 = var_0_1

			var_11.RoleInfoUpload(var_28_11, var_28_10)
		end

		return
	end

	function var_0_0.ShowSurvey(arg_29_0, arg_29_1)
		if var_0_0.GetIsPlatform() then
			getProxy = var_2
			PlayerProxy = var_2_10003

			local var_29_0 = var_2(var_2_10003)
			local var_29_1 = var_2.getData(var_29_0)
			local var_29_2 = var_0_1
			local var_29_3 = var_4.ShowSurvey
			local var_29_4 = arg_29_0

			tostring = var_2_10007

			var_29_3(var_29_2, var_29_4, var_2_10007(var_29_1.id), arg_29_1)
		end

		return
	end

	function var_0_0.ShowAgreement(arg_30_0)
		if var_0_0.GetIsPlatform() then
			local var_30_0 = var_0_1

			var_1.ShowSurvey(var_30_0, arg_30_0)
		end

		return
	end

	function var_0_0.ShowSwitchAccount()
		if var_0_0.GetIsPlatform() then
			local var_31_0 = var_0_1

			var_0.ShowSwitchAccount(var_31_0)
		end

		return
	end

	function var_0_0.SystemShare(arg_32_0, arg_32_1)
		if var_0_0.GetIsPlatform() then
			local var_32_0 = var_0_1

			var_2.SystemShare(var_32_0, arg_32_0, arg_32_1)
		end

		return
	end

	function var_0_0.ShareImage(arg_33_0)
		if var_0_0.GetIsPlatform() then
			local var_33_0 = var_0_1

			var_1.ShareImage(var_33_0, arg_33_0)
		end

		return
	end

	function var_0_0.ShareUrl(arg_34_0, arg_34_1)
		if var_0_0.GetIsPlatform() then
			local var_34_0 = var_0_1

			var_2.ShareUrl(var_34_0, arg_34_0, arg_34_1)
		end

		return
	end

	function var_0_0.ShowNetworkTest(arg_35_0)
		if var_0_0.GetIsPlatform() then
			local var_35_0 = var_0_1

			var_1.ShowNetworkTest(var_35_0, arg_35_0)
		end

		return
	end

	function var_0_0.ShowWebView(arg_36_0, arg_36_1)
		if var_0_0.GetIsPlatform() then
			local var_36_0 = var_0_1

			var_2.ShowWebView(var_36_0, arg_36_0, arg_36_1)
		end

		return
	end

	function var_0_0.RequestStoreReview()
		if var_0_0.GetIsPlatform() then
			local var_37_0 = var_0_1

			var_0.RequestStoreReview(var_37_0)
		end

		return
	end

	function var_0_0.QueryErrorMsg(arg_38_0)
		if var_0_0.GetIsPlatform() then
			local var_38_0 = var_0_1

			return var_1.QueryErrorMsg(var_38_0, arg_38_0)
		end

		return
	end

	function var_0_0.QuerySkuDetails(arg_39_0)
		if var_0_0.GetIsPlatform() then
			local var_39_0 = var_0_1

			var_1.QuerySkuDetails(var_39_0)
		end

		return
	end

	function var_0_0.QueryTextLegality(arg_40_0)
		if var_0_0.GetIsPlatform() then
			local var_40_0 = var_0_1

			var_1.QueryTextLegality(var_40_0, arg_40_0)
		end

		return
	end

	function var_0_0.ShowAccountCenter()
		if var_0_0.GetIsPlatform() then
			local var_41_0 = var_0_1

			var_0.ShowAccountCenter(var_41_0)
		end

		return
	end

	function var_0_0.FetchDeviceTrackingID()
		if var_0_0.GetIsPlatform() then
			local var_42_0 = var_0_1

			var_0.FetchDeviceTrackingID(var_42_0)
		end

		return
	end

	function var_0_0.CheckUserCacheExist()
		if var_0_0.GetIsPlatform() then
			local var_43_0 = var_0_1

			var_0.CheckUserCacheExist(var_43_0)
		end

		return
	end

	function var_0_0.BuildLocalNotification(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
		if var_0_0.GetIsPlatform() then
			local var_44_0 = var_0_1

			var_4.BuildLocalNotification(var_44_0, arg_44_0, arg_44_1, arg_44_2, arg_44_3)
		end

		return
	end

	function var_0_0.DeleteLocalNotification(arg_45_0)
		if var_0_0.GetIsPlatform() then
			local var_45_0 = var_0_1

			var_1.DeleteLocalNotification(var_45_0, arg_45_0)
		end

		return
	end

	return
end)()
;(function()
	local function var_46_0(arg_47_0)
		pg = var_2_10001

		local var_47_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_47_0)

		if var_0_0.YoStarRetCodeHandler(arg_47_0) then
			var_0_0.YOSTAR_SDK_INITED = true

			var_0_0.FetchDeviceTrackingID()
			var_0_0.YoStarGoLogin()
		end

		return
	end

	local var_46_1 = onInit_YoStar

	local function var_46_2(arg_48_0)
		pg = var_2_10001

		local var_48_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_48_0)

		if var_0_0.YoStarRetCodeHandler(arg_48_0) then
			User = var_1

			local var_48_1 = var_1.New({
				type = 1,
				arg1 = var_0_0.LoginPlatform,
				arg2 = arg_48_0.LOGIN_UID,
				arg3 = arg_48_0.LOGIN_TOKEN
			})

			pg = var_2

			local var_48_2 = var_2.m02
			local var_48_3 = var_2.sendNotification

			GAME = var_2_10004

			var_48_3(var_48_2, var_2_10004.PLATFORM_LOGIN_DONE, {
				user = var_48_1
			})
		end

		return
	end

	local var_46_3 = onLogin_YoStar

	local function var_46_4(arg_49_0)
		if var_0_0.YoStarRetCodeHandler(arg_49_0) then
			pg = var_1

			local var_49_0 = var_1.m02
			local var_49_1 = var_1.sendNotification

			GAME = var_2_10003

			var_49_1(var_49_0, var_2_10003.LOGOUT, {
				code = 0
			})
		end

		return
	end

	local var_46_5 = onLogout_YoStar

	local function var_46_6(arg_50_0)
		local var_50_0 = var_0_0

		var_50_0.OnYoStarPaying = -1
		pg = var_50_0

		local var_50_1 = var_50_0.UIMgr.GetInstance()

		var_1.LoadingOff(var_50_1)

		local var_50_2, var_50_3

		if var_0_0.YoStarRetCodeHandler(arg_50_0) then
			getProxy = var_50_3
			ShopsProxy = var_50_2
			var_50_2 = var_50_3(var_50_2)

			var_50_3.removeWaitTimer(var_50_2)

			pg = var_50_3
			var_50_2 = var_50_3.m02
			var_50_3 = var_50_3.sendNotification
			GAME = var_2_10003

			var_50_3(var_50_2, var_2_10003.CHARGE_CONFIRM, {
				payId = arg_50_0.EXTRA_DATA,
				bsId = arg_50_0.ORDER_ID
			})
		else
			getProxy = var_50_3
			ShopsProxy = var_50_2

			local var_50_4 = var_50_3(var_50_2)

			var_1.removeWaitTimer(var_50_4)

			pg = var_1

			local var_50_5 = var_1.m02
			local var_50_6 = var_1.sendNotification

			GAME = var_2_10003

			var_50_6(var_50_5, var_2_10003.CHARGE_FAILED, {
				payId = arg_50_0.EXTRA_DATA
			})
		end

		return
	end

	local var_46_7 = onPay_YoStar

	local function var_46_8(arg_51_0)
		if var_0_0.YoStarRetCodeHandler(arg_51_0) then
			-- block empty
		end

		return
	end

	local var_46_9 = onSystemShare_YoStar

	local function var_46_10(arg_52_0)
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

	local var_46_11 = onDeleteAccount_YoStar

	local function var_46_12(arg_53_0)
		if var_0_0.YoStarRetCodeHandler(arg_53_0) then
			pg = var_1

			local var_53_0 = var_1.m02
			local var_53_1 = var_1.sendNotification

			GAME = var_2_10003

			var_53_1(var_53_0, var_2_10003.LOGOUT, {
				code = 0
			})
		end

		return
	end

	local var_46_13 = onClearSDKCache_YoStar

	local function var_46_14(arg_54_0)
		if var_0_0.YoStarRetCodeHandler(arg_54_0) then
			-- block empty
		end

		return
	end

	local var_46_15 = onQuerySkuDetails_YoStar

	local function var_46_16(arg_55_0)
		if var_0_0.YoStarRetCodeHandler(arg_55_0) then
			-- block empty
		end

		return
	end

	local var_46_17 = onUserSurvey_YoStar

	local function var_46_18(arg_56_0)
		return
	end

	local var_46_19 = onSwitchServer_YoStar

	local function var_46_20(arg_57_0)
		if var_0_0.YoStarRetCodeHandler(arg_57_0) then
			-- block empty
		end

		return
	end

	local var_46_21 = onQueryTextLegality_YoStar

	local function var_46_22(arg_58_0)
		if var_0_0.YoStarRetCodeHandler(arg_58_0) then
			-- block empty
		end

		return
	end

	local var_46_23 = onPushMsgReceive_YoStar

	local function var_46_24(arg_59_0)
		if var_0_0.YoStarRetCodeHandler(arg_59_0) then
			-- block empty
		end

		return
	end

	local var_46_25 = onUniversalLink_YoStar

	local function var_46_26(arg_60_0)
		if var_0_0.YoStarRetCodeHandler(arg_60_0) then
			var_0_0.DeviceID = arg_60_0.DATA
		end

		return
	end

	local var_46_27 = onDeviceTrackingID_YoStar

	local function var_46_28(arg_61_0)
		if var_0_0.YoStarRetCodeHandler(arg_61_0) then
			-- block empty
		end

		return
	end

	local var_46_29 = onLocalNotification_YoStar

	local function var_46_30(arg_62_0)
		if var_0_0.YoStarRetCodeHandler(arg_62_0) then
			-- block empty
		end

		return
	end

	local var_46_31 = onSetBirthday_YoStar

	return
end)()

function var_0_0.YoStarRetCodeHandler(arg_63_0)
	if arg_63_0.R_CODE == 0 then
		return true
	else
		local var_63_0 = "SDK Error Code:" .. var_1

		originalPrint = var_3

		var_3(var_63_0)

		if var_0_0.QueryErrorMsg(var_1) then
			string = var_4

			if var_4.len(var_3) > 0 then
				pg = var_4

				local var_63_1 = var_4.TipsMgr.GetInstance()

				var_4.ShowTips(var_63_1, var_3)

				goto label_63_0
			end
		end

		pg = var_4

		local var_63_2 = var_4.TipsMgr.GetInstance()

		var_4.ShowTips(var_63_2, var_63_0)
	end

	::label_63_0::

	return false
end

return var_0_0

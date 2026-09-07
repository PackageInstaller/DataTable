local var_0_0 = {}
local var_0_1 = YoStarSDKMgr.inst

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
var_0_0.LoginPlatform = PLATFORM_YOSTARJP
var_0_0.SDK_PID_TEST = "JP-AZURLANE-TEST"
var_0_0.SDK_PID_RELEASE = "JP-AZURLANE"
var_0_0.SDK_SERVER_URL = "https://jp-sdk-api.yostarplat.com"
var_0_0.SDK_TRANS_URL = "https://migration.yostar.co.jp?pid=JP-AZURLANE"

function var_0_0.InitJP()
	var_0_0.isAudit = NetConst.GATEWAY_PORT == 20001 and NetConst.GATEWAY_HOST == "blhxjpauditapi.azurlane.jp"
	var_0_0.isPreAudit = NetConst.GATEWAY_PORT == 30001 and NetConst.GATEWAY_HOST == "blhxjpauditapi.azurlane.jp" or NetConst.GATEWAY_PORT == 21 and NetConst.GATEWAY_HOST == "blhxjpauditapi.azurlane.jp"
	var_0_0.isPretest = IsUnityEditor or var_0_0.isPreAudit
	var_0_0.isGoogleSimulator = NetConst.GATEWAY_PORT == 4001 and NetConst.GATEWAY_HOST == "business.azurlane.jp"
	var_0_0.isRelease = NetConst.GATEWAY_PORT == 80 and NetConst.GATEWAY_HOST == "blhxjploginapi.azurlane.jp"
	var_0_0.LoginPlatform = PLATFORM_YOSTARJP
	var_0_0.SDK_PID_TEST = "JP-AZURLANE-TEST"
	var_0_0.SDK_PID_RELEASE = "JP-AZURLANE"
	var_0_0.SDK_SERVER_URL = "https://jp-sdk-api.yostarplat.com"
	var_0_0.SDK_TRANS_URL = "https://migration.yostar.co.jp?pid=JP-AZURLANE"

	return
end

function var_0_0.InitUS()
	var_0_0.isAudit = NetConst.GATEWAY_PORT == 20001 and NetConst.GATEWAY_HOST == "audit.us.yo-star.com"
	var_0_0.isPreAudit = NetConst.GATEWAY_PORT == 30001 and NetConst.GATEWAY_HOST == "audit.us.yo-star.com"
	var_0_0.isPretest = IsUnityEditor or var_0_0.isPreAudit
	var_0_0.isGoogleSimulator = NetConst.GATEWAY_PORT == 50001 and NetConst.GATEWAY_HOST == "audit.us.yo-star.com"
	var_0_0.isRelease = NetConst.GATEWAY_PORT == 80 and NetConst.GATEWAY_HOST == "blhxusgate.yo-star.com"
	var_0_0.LoginPlatform = PLATFORM_YOSTARUS
	var_0_0.SDK_PID_TEST = ""
	var_0_0.SDK_PID_RELEASE = ""
	var_0_0.SDK_SERVER_URL = ""
	var_0_0.SDK_TRANS_URL = ""

	return
end

function var_0_0.CheckAudit()
	return NetConst.getwayType == 1
end

function var_0_0.CheckPreAudit()
	return var_0_0.isPreAudit
end

function var_0_0.CheckPretest()
	return var_0_0.isPretest
end

function var_0_0.CheckGoogleSimulator()
	return NetConst.getwayType == 2
end

function var_0_0.CheckRelease()
	return NetConst.getwayType == 0
end

function var_0_0.CheckBiz()
	return NetConst.getwayType == 3
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
	var_0_1:GoLoginScene()
	var_0_0.Init()

	return
end

function GoLoginScene()
	if IsUnityEditor then
		onInit_YoStar({
			R_CODE = 0
		})
	end

	return
end

function var_0_0.EnterServer()
	var_0_0.RoleInfoUpload()

	return
end

function var_0_0.Survey(arg_15_0)
	Application.OpenURL(arg_15_0)

	return
end

function var_0_0.OnAndoridBackPress()
	PressBack()

	return
end

function var_0_0.BindCPU()
	return
end

function var_0_0.CheckYoStarCanBuy()
	if var_0_0.OnYoStarPaying == -1 or Time.realtimeSinceStartup - var_0_0.OnYoStarPaying > var_0_0.BuyingLimit then
		return true
	else
		return false
	end

	return
end

function var_0_0.OnAppPauseForSDK(arg_19_0)
	if not var_0_0.YOSTAR_SDK_INITED then
		return
	end

	if arg_19_0 then
		var_0_1:OnPause()
	else
		var_0_1:OnResume()
	end

	return
end

function var_0_0.YoStarGoLogin(arg_20_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LOGIN, {
		loginPlatform = arg_20_0
	})
	gcAll()

	return
end

function var_0_0.GetDeviceId()
	return var_0_0.DeviceID
end

function var_0_0.CheckHadAccountCache()
	if var_0_0.GetIsPlatform() then
		return var_0_0.CheckUserCacheExist() or var_0_0.isCache
	else
		return true
	end

	return
end

;(function()
	function var_0_0.Init(arg_24_0)
		pg.UIMgr.GetInstance():LoadingOn()

		if var_0_0.GetIsPlatform() then
			if var_0_0.CheckRelease() or var_0_0.CheckAudit() then
				var_0_1.pid = var_0_0.SDK_PID_RELEASE or var_0_0.SDK_PID_TEST
			end

			var_0_1.gameServerUrl = var_0_0.SDK_SERVER_URL

			var_0_1:Init()
		end

		return
	end

	function var_0_0.Login()
		if var_0_0.GetIsPlatform() then
			pg.UIMgr.GetInstance():LoadingOn()
			var_0_1:Login()
		end

		return
	end

	function var_0_0.SetBirthday()
		if var_0_0.GetIsPlatform() then
			var_0_1:SetBirthday()
		end

		return
	end

	function var_0_0.ShowUserCenter()
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowUserCenter()
		end

		return
	end

	function var_0_0.Pay(arg_28_0, arg_28_1, arg_28_2)
		if var_0_0.GetIsPlatform() then
			pg.UIMgr.GetInstance():LoadingOn()

			var_0_0.OnYoStarPaying = Time.realtimeSinceStartup

			var_0_1:Pay(arg_28_0, arg_28_1, arg_28_2)
		end

		return
	end

	function var_0_0.ShowAihelp()
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowAihelp()
		end

		return
	end

	function var_0_0.UserEventUpload(arg_30_0)
		if var_0_0.GetIsPlatform() then
			var_0_1:UserEventUpload(arg_30_0)
		end

		return
	end

	function var_0_0.RoleInfoUpload()
		if var_0_0.GetIsPlatform() then
			local var_31_0 = getProxy(PlayerProxy):getData()
			local var_31_1 = getProxy(ServerProxy):getLastServer(getProxy(UserProxy):getData().uid)

			var_0_1:RoleInfoUpload((YoStarRoleInfo.New(tostring(var_31_1.id .. " - " .. var_31_1.name), tostring(var_31_0.id), var_31_0.name, {
				(tostring(var_31_0.rmb))
			})))
		end

		return
	end

	function var_0_0.ShowSurvey(arg_32_0, arg_32_1)
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowSurvey(arg_32_0, tostring(getProxy(PlayerProxy):getData().id), arg_32_1)
		end

		return
	end

	function var_0_0.ShowAgreement(arg_33_0)
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowSurvey(arg_33_0)
		end

		return
	end

	function var_0_0.ShowSwitchAccount()
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowSwitchAccount()
		end

		return
	end

	function var_0_0.SystemShare(arg_35_0, arg_35_1)
		if var_0_0.GetIsPlatform() then
			var_0_1:SystemShare(arg_35_0, arg_35_1)
		end

		return
	end

	function var_0_0.ShareImage(arg_36_0)
		if var_0_0.GetIsPlatform() then
			var_0_1:ShareImage(arg_36_0)
		end

		return
	end

	function var_0_0.ShareUrl(arg_37_0, arg_37_1)
		if var_0_0.GetIsPlatform() then
			var_0_1:ShareUrl(arg_37_0, arg_37_1)
		end

		return
	end

	function var_0_0.ShowNetworkTest(arg_38_0)
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowNetworkTest(arg_38_0)
		end

		return
	end

	function var_0_0.ShowWebView(arg_39_0, arg_39_1)
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowWebView(arg_39_0, arg_39_1)
		end

		return
	end

	function var_0_0.RequestStoreReview()
		if var_0_0.GetIsPlatform() then
			var_0_1:RequestStoreReview()
		end

		return
	end

	function var_0_0.QueryErrorMsg(arg_41_0)
		if var_0_0.GetIsPlatform() then
			return var_0_1:QueryErrorMsg(arg_41_0)
		end

		return
	end

	function var_0_0.QuerySkuDetails(arg_42_0)
		if var_0_0.GetIsPlatform() then
			var_0_1:QuerySkuDetails()
		end

		return
	end

	function var_0_0.QueryTextLegality(arg_43_0)
		if var_0_0.GetIsPlatform() then
			var_0_1:QueryTextLegality(arg_43_0)
		end

		return
	end

	function var_0_0.ShowAccountCenter()
		if var_0_0.GetIsPlatform() then
			var_0_1:ShowAccountCenter()
		end

		return
	end

	function var_0_0.FetchDeviceTrackingID()
		if var_0_0.GetIsPlatform() then
			var_0_1:FetchDeviceTrackingID()
		end

		return
	end

	function var_0_0.CheckUserCacheExist()
		if var_0_0.GetIsPlatform() then
			var_0_1:CheckUserCacheExist()
		end

		return
	end

	function var_0_0.BuildLocalNotification(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		if var_0_0.GetIsPlatform() then
			var_0_1:BuildLocalNotification(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		end

		return
	end

	function var_0_0.DeleteLocalNotification(arg_48_0)
		if var_0_0.GetIsPlatform() then
			var_0_1:DeleteLocalNotification(arg_48_0)
		end

		return
	end

	return
end)()
;(function()
	function onInit_YoStar(arg_50_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if var_0_0.YoStarRetCodeHandler(arg_50_0) then
			var_0_0.YOSTAR_SDK_INITED = true

			var_0_0.FetchDeviceTrackingID()
			var_0_0.YoStarGoLogin()
		end

		return
	end

	function onLogin_YoStar(arg_51_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if var_0_0.YoStarRetCodeHandler(arg_51_0) then
			pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {
				user = User.New({
					type = 1,
					arg1 = var_0_0.LoginPlatform,
					arg2 = arg_51_0.LOGIN_UID,
					arg3 = arg_51_0.LOGIN_TOKEN
				})
			})
		end

		return
	end

	function onLogout_YoStar(arg_52_0)
		if var_0_0.YoStarRetCodeHandler(arg_52_0) then
			pg.m02:sendNotification(GAME.LOGOUT, {
				code = 0
			})
		end

		return
	end

	function onPay_YoStar(arg_53_0)
		var_0_0.OnYoStarPaying = -1

		pg.UIMgr.GetInstance():LoadingOff()

		if var_0_0.YoStarRetCodeHandler(arg_53_0) then
			getProxy(ShopsProxy):removeWaitTimer()
			pg.m02:sendNotification(GAME.CHARGE_CONFIRM, {
				payId = arg_53_0.EXTRA_DATA,
				bsId = arg_53_0.ORDER_ID
			})
		else
			getProxy(ShopsProxy):removeWaitTimer()
			pg.m02:sendNotification(GAME.CHARGE_FAILED, {
				payId = arg_53_0.EXTRA_DATA
			})
		end

		return
	end

	function onSystemShare_YoStar(arg_54_0)
		if var_0_0.YoStarRetCodeHandler(arg_54_0) then
			-- block empty
		end

		return
	end

	function onDeleteAccount_YoStar(arg_55_0)
		if var_0_0.YoStarRetCodeHandler(arg_55_0) then
			pg.m02:sendNotification(GAME.LOGOUT, {
				code = 0
			})
		end

		return
	end

	function onClearSDKCache_YoStar(arg_56_0)
		if var_0_0.YoStarRetCodeHandler(arg_56_0) then
			pg.m02:sendNotification(GAME.LOGOUT, {
				code = 0
			})
		end

		return
	end

	function onQuerySkuDetails_YoStar(arg_57_0)
		if var_0_0.YoStarRetCodeHandler(arg_57_0) then
			-- block empty
		end

		return
	end

	function onUserSurvey_YoStar(arg_58_0)
		if var_0_0.YoStarRetCodeHandler(arg_58_0) then
			-- block empty
		end

		return
	end

	function onSwitchServer_YoStar(arg_59_0)
		return
	end

	function onQueryTextLegality_YoStar(arg_60_0)
		if var_0_0.YoStarRetCodeHandler(arg_60_0) then
			-- block empty
		end

		return
	end

	function onPushMsgReceive_YoStar(arg_61_0)
		if var_0_0.YoStarRetCodeHandler(arg_61_0) then
			-- block empty
		end

		return
	end

	function onUniversalLink_YoStar(arg_62_0)
		if var_0_0.YoStarRetCodeHandler(arg_62_0) then
			-- block empty
		end

		return
	end

	function onDeviceTrackingID_YoStar(arg_63_0)
		if var_0_0.YoStarRetCodeHandler(arg_63_0) then
			var_0_0.DeviceID = arg_63_0.DATA
		end

		return
	end

	function onLocalNotification_YoStar(arg_64_0)
		if var_0_0.YoStarRetCodeHandler(arg_64_0) then
			-- block empty
		end

		return
	end

	function onSetBirthday_YoStar(arg_65_0)
		if var_0_0.YoStarRetCodeHandler(arg_65_0) then
			-- block empty
		end

		return
	end

	return
end)()

function var_0_0:YoStarRetCodeHandler()
	if self.R_CODE == 0 then
		return true
	else
		local var_66_0 = "SDK Error Code:" .. self.R_CODE

		originalPrint("SDK Error Code:" .. self.R_CODE)

		local var_66_1 = var_0_0.QueryErrorMsg(self.R_CODE)

		if var_66_1 and string.len(var_66_1) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(var_66_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_66_0)
		end
	end

	return false
end

return var_0_0

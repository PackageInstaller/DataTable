local var_0_0 = {}
local var_0_1 = YongshiSdkMgr.inst
local var_0_2 = "com.hkmanjuu.azurlane.gp.mc"
local var_0_3 = "com.hkmanjuu.azurlane.gp"
local var_0_4 = "com.hkmanjuu.azurlane.ios1"

;({}).CheckPretest = function()
	return NetConst.GATEWAY_HOST == "ts-all-login.azurlane.tw" and (NetConst.GATEWAY_PORT == 11001 or NetConst.GATEWAY_PORT == 11101) or IsUnityEditor
end
;({}).InitSDK = function()
	var_0_1:Init()

	return
end
;({}).GoSDkLoginScene = function()
	var_0_1:GoLoginScene()

	return
end
;({}).LoginSdk = function(arg_4_0)
	var_0_1:Login(0)

	return
end
;({}).TryLoginSdk = function()
	var_0_1:TryLogin()

	return
end
;({}).SdkGateWayLogined = function()
	var_0_1:OnGatewayLogined()

	return
end
;({}).SdkLoginGetaWayFailed = function()
	var_0_1:OnLoginGatewayFailed()

	return
end
;({}).IsBindApple = function()
	return var_0_1.bindInfo:IsBindApple()
end
;({}).IsBindFaceBook = function()
	return var_0_1.bindInfo:IsBindFaceBook()
end
;({}).IsBindGoogle = function()
	return var_0_1.bindInfo:IsBindGoogle()
end
;({}).IsBindPhone = function()
	return var_0_1.bindInfo:IsBindPhone()
end
;({}).BindApple = function()
	var_0_1:BindApple()

	return
end
;({}).BindFaceBook = function()
	var_0_1:BindFaceBook()

	return
end
;({}).BindGoogle = function()
	var_0_1:BindGoogle()

	return
end
;({}).BindPhone = function()
	var_0_1:BindPhone()

	return
end
;({}).UnBindPhone = function()
	var_0_1:UnBindPhone()

	return
end
;({}).UnBindApple = function()
	var_0_1:UnBindApple()

	return
end
;({}).UnBindFaceBook = function()
	var_0_1:UnBindFaceBook()

	return
end
;({}).UnBindGoogle = function()
	var_0_1:UnBindGoogle()

	return
end
;({}).CanTriggerDeepLinking = function()
	return var_0_1:CanTriggerDeepLinking()
end
;({}).TriggerDeepLinking = function()
	var_0_1:TriggerDeepLinking()

	return
end
;({}).SdkPay = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8, arg_22_9)
	local var_22_0 = getProxy(ServerProxy):getLastServer(getProxy(UserProxy):getData().uid)
	local var_22_1 = getProxy(PlayerProxy):getRawData()

	var_0_1:Pay(arg_22_0, arg_22_2, arg_22_5, arg_22_1, "1", arg_22_3, "1", var_22_0.id, var_22_0.name, var_22_0.id, var_22_1.id, var_22_1.name, var_22_1.level, arg_22_8, "1", arg_22_4, arg_22_6, arg_22_9)

	return
end
;({}).UserEventUpload = function(arg_23_0)
	var_0_1:UserEventUpload(arg_23_0)

	return
end
;({}).LogoutSDK = function()
	var_0_1:LocalLogout()

	return
end
;({}).BindCPU = function()
	var_0_1:callSdkApi("bindCpu", nil)

	return
end
;({}).DeleteAccount = function()
	var_0_1:Delete()

	return
end
;({}).OnAndoridBackPress = function()
	PressBack()

	return
end
;({}).ShareImg = function(arg_28_0, arg_28_1)
	var_0_1:Share(arg_28_0)

	return
end
;({}).GetBiliServerId = function()
	originalPrint("serverId : " .. var_0_1.serverId)

	return var_0_1.serverId
end
;({}).GetChannelUID = function()
	originalPrint("channelUID : " .. var_0_1.channelUID)

	return var_0_1.channelUID
end
;({}).GetLoginType = function()
	return var_0_1.loginType
end
;({}).GetIsPlatform = function()
	return var_0_1.isPlatform
end
;({}).GetPackageCode = function(arg_33_0)
	if arg_33_0 == var_0_2 then
		return "2"
	elseif arg_33_0 == var_0_3 then
		return "1"
	elseif arg_33_0 == var_0_4 then
		return "3"
	end

	return "0"
end
;({}).QueryWithProduct = function()
	if var_0_2 == Application.identifier then
		return
	end

	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(pg.pay_data_display.all) do
		table.insert(var_34_0, pg.pay_data_display[iter_34_1].id_str)
	end

	var_0_1:Query(var_34_0)

	return
end
;({}).GetProduct = function(arg_35_0)
	return var_0_1:GetProduct(arg_35_0)
end

function StartSdkLogin()
	Timer.New(function()
		var_0_1:OnLoginTimeOut()

		return
	end, 30, 1):Start()

	return
end

function GoLoginScene()
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LOGIN)
	gcAll()

	return
end

function SDKLogined(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	local var_39_0 = User.New({
		type = 1,
		arg1 = arg_39_0,
		arg2 = arg_39_1,
		arg3 = arg_39_2,
		arg4 = arg_39_3
	})

	pg.SdkMgr.GetInstance().airi_uid = arg_39_1 or "test"

	pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {
		user = var_39_0
	})

	return
end

function SDKLogouted(arg_40_0)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	pg.m02:sendNotification(GAME.LOGOUT, {
		code = arg_40_0
	})

	return
end

function PaySuccess(arg_41_0, arg_41_1)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	getProxy(ShopsProxy):removeWaitTimer()
	originalPrint(arg_41_0 + " - " + arg_41_1)
	pg.m02:sendNotification(GAME.CHARGE_CONFIRM, {
		payId = arg_41_0,
		bsId = arg_41_1
	})

	return
end

function PayFailed(arg_42_0, arg_42_1)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	getProxy(ShopsProxy):removeWaitTimer()

	arg_42_1 = tonumber(arg_42_1)

	if not arg_42_1 then
		return
	end

	if PLATFORM_CODE == PLATFORM_CHT and var_0_0.GetChannelUID() == "2" then
		return
	end

	pg.m02:sendNotification(GAME.CHARGE_FAILED, {
		payId = arg_42_0,
		code = arg_42_1
	})

	return
end

function GetUserInfoSuccess()
	return
end

function GetUserInfoFailed()
	return
end

local function var_0_5(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0 == YongshiSdkUserBindInfo.FACEBOOK then
		pg.TipsMgr.GetInstance():ShowTips(arg_45_1 .. "facebook" .. arg_45_2)
	elseif arg_45_0 == YongshiSdkUserBindInfo.APPLE then
		pg.TipsMgr.GetInstance():ShowTips(arg_45_1 .. "Apple Id" .. arg_45_2)
	elseif arg_45_0 == YongshiSdkUserBindInfo.GOOGLE then
		pg.TipsMgr.GetInstance():ShowTips(arg_45_1 .. "google" .. arg_45_2)
	elseif arg_45_0 == YongshiSdkUserBindInfo.PHONE then
		if arg_45_1 == "解綁" then
			arg_45_1 = "换绑"
		end

		pg.TipsMgr.GetInstance():ShowTips(arg_45_1 .. "手機" .. arg_45_2)
	else
		print("this platform is not supported")
	end

	return
end

function BindSuccess(arg_46_0)
	var_0_5(arg_46_0, "綁定", "成功")
	pg.m02:sendNotification(GAME.CHT_SOCIAL_LINK_STATE_CHANGE, arg_46_0)

	return
end

function BindFailed(arg_47_0, arg_47_1)
	if arg_47_1 and arg_47_1 ~= "" then
		pg.TipsMgr.GetInstance():ShowTips(arg_47_1)
	else
		var_0_5(arg_47_0, "綁定", "失敗")
	end

	return
end

function UnBindSuccess(arg_48_0)
	var_0_5(arg_48_0, "解綁", "成功")
	pg.m02:sendNotification(GAME.CHT_SOCIAL_LINK_STATE_CHANGE)

	return
end

function UnBindFailed(arg_49_0, arg_49_1)
	if arg_49_1 and arg_49_1 ~= "" then
		pg.TipsMgr.GetInstance():ShowTips(arg_49_1)
	else
		var_0_5(arg_49_0, "解綁", "失敗")
	end

	return
end

function OnDeepLinking(arg_50_0)
	pg.YongshiDeepLinkingMgr.GetInstance():SetData(arg_50_0)

	return
end

return {}

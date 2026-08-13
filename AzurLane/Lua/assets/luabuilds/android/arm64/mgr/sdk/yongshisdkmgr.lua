local var_0_0 = {}

YongshiSdkMgr = var_0_10001

local var_0_1 = var_0_10001.inst
local var_0_2 = "com.hkmanjuu.azurlane.gp.mc"
local var_0_3 = "com.hkmanjuu.azurlane.gp"
local var_0_4 = "com.hkmanjuu.azurlane.ios1"

function var_0_0.CheckPretest()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_HOST == "ts-all-login.azurlane.tw" then
		NetConst = var_1_0

		local var_1_0

		if var_1_0.GATEWAY_PORT ~= 11001 then
			NetConst = var_1_0

			if var_1_0.GATEWAY_PORT ~= 11101 then
				IsUnityEditor = var_1_0

				if false then
					var_1_0 = false
				end

				goto label_1_0
			end
		end

		var_1_0 = true

		::label_1_0::

		return var_1_0
	end
end

function var_0_0.InitSDK()
	local var_2_0 = var_0_1

	var_0.Init(var_2_0)

	return
end

function var_0_0.GoSDkLoginScene()
	local var_3_0 = var_0_1

	var_0.GoLoginScene(var_3_0)

	return
end

function var_0_0.LoginSdk(arg_4_0)
	local var_4_0 = var_0_1

	var_1.Login(var_4_0, 0)

	return
end

function var_0_0.TryLoginSdk()
	local var_5_0 = var_0_1

	var_0.TryLogin(var_5_0)

	return
end

function var_0_0.SdkGateWayLogined()
	local var_6_0 = var_0_1

	var_0.OnGatewayLogined(var_6_0)

	return
end

function var_0_0.SdkLoginGetaWayFailed()
	local var_7_0 = var_0_1

	var_0.OnLoginGatewayFailed(var_7_0)

	return
end

function var_0_0.IsBindApple()
	local var_8_0 = var_0_1.bindInfo

	return var_0.IsBindApple(var_8_0)
end

function var_0_0.IsBindFaceBook()
	local var_9_0 = var_0_1.bindInfo

	return var_0.IsBindFaceBook(var_9_0)
end

function var_0_0.IsBindGoogle()
	local var_10_0 = var_0_1.bindInfo

	return var_0.IsBindGoogle(var_10_0)
end

function var_0_0.IsBindPhone()
	local var_11_0 = var_0_1.bindInfo

	return var_0.IsBindPhone(var_11_0)
end

function var_0_0.BindApple()
	local var_12_0 = var_0_1

	var_0.BindApple(var_12_0)

	return
end

function var_0_0.BindFaceBook()
	local var_13_0 = var_0_1

	var_0.BindFaceBook(var_13_0)

	return
end

function var_0_0.BindGoogle()
	local var_14_0 = var_0_1

	var_0.BindGoogle(var_14_0)

	return
end

function var_0_0.BindPhone()
	local var_15_0 = var_0_1

	var_0.BindPhone(var_15_0)

	return
end

function var_0_0.UnBindPhone()
	local var_16_0 = var_0_1

	var_0.UnBindPhone(var_16_0)

	return
end

function var_0_0.UnBindApple()
	local var_17_0 = var_0_1

	var_0.UnBindApple(var_17_0)

	return
end

function var_0_0.UnBindFaceBook()
	local var_18_0 = var_0_1

	var_0.UnBindFaceBook(var_18_0)

	return
end

function var_0_0.UnBindGoogle()
	local var_19_0 = var_0_1

	var_0.UnBindGoogle(var_19_0)

	return
end

function var_0_0.CanTriggerDeepLinking()
	local var_20_0 = var_0_1

	return var_0.CanTriggerDeepLinking(var_20_0)
end

function var_0_0.TriggerDeepLinking()
	local var_21_0 = var_0_1

	var_0.TriggerDeepLinking(var_21_0)

	return
end

function var_0_0.SdkPay(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8, arg_22_9)
	getProxy = var_1_10010
	UserProxy = var_1_10012

	local var_22_0 = var_1_10010(var_1_10012)
	local var_22_1 = var_10.getData(var_22_0).uid

	getProxy = var_22_0
	ServerProxy = var_1_10015

	local var_22_2 = var_22_0(var_1_10015)
	local var_22_3 = var_13.getLastServer(var_22_2, var_22_1).id
	local var_22_4 = var_14.name

	getProxy = var_17
	PlayerProxy = var_1_10019

	local var_22_5 = var_17(var_1_10019)
	local var_22_6 = var_17.getRawData(var_22_5).id
	local var_22_7 = var_17.name
	local var_22_8 = var_17.level
	local var_22_9 = var_0_1

	var_21.Pay(var_22_9, arg_22_0, arg_22_2, arg_22_5, arg_22_1, "1", arg_22_3, "1", var_22_3, var_22_4, var_22_3, var_22_6, var_22_7, var_22_8, arg_22_8, "1", arg_22_4, arg_22_6, arg_22_9)

	return
end

function var_0_0.UserEventUpload(arg_23_0)
	local var_23_0 = var_0_1

	var_1.UserEventUpload(var_23_0, arg_23_0)

	return
end

function var_0_0.LogoutSDK()
	local var_24_0 = var_0_1

	var_0.LocalLogout(var_24_0)

	return
end

function var_0_0.BindCPU()
	local var_25_0 = var_0_1

	var_0.callSdkApi(var_25_0, "bindCpu", nil)

	return
end

function var_0_0.DeleteAccount()
	local var_26_0 = var_0_1

	var_0.Delete(var_26_0)

	return
end

function var_0_0.OnAndoridBackPress()
	PressBack = var_1_10000

	var_1_10000()

	return
end

function var_0_0.ShareImg(arg_28_0, arg_28_1)
	local var_28_0 = var_0_1

	var_2.Share(var_28_0, arg_28_0)

	return
end

function var_0_0.GetBiliServerId()
	local var_29_0 = var_0_1.serverId

	originalPrint = var_1_10001

	var_1_10001("serverId : " .. var_29_0)

	return var_29_0
end

function var_0_0.GetChannelUID()
	local var_30_0 = var_0_1.channelUID

	originalPrint = var_1_10001

	var_1_10001("channelUID : " .. var_30_0)

	return var_30_0
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GetPackageCode(arg_33_0)
	if arg_33_0 == var_0_2 then
		return "2"
	elseif arg_33_0 == var_0_3 then
		return "1"
	elseif arg_33_0 == var_0_4 then
		return "3"
	end

	return "0"
end

function var_0_0.QueryWithProduct()
	local var_34_0 = var_0_2

	Application = var_1_10001

	if var_34_0 == var_1_10001.identifier then
		return
	end

	local var_34_1 = {}

	pg = var_1

	local var_34_2 = var_1.pay_data_display

	pairs = var_1_10002

	for iter_34_0, iter_34_1 in var_1_10002(var_34_2.all) do
		local var_34_3 = var_34_2[iter_34_1]

		table = var_1_10008

		var_1_10008.insert(var_34_1, var_34_3.id_str)
	end

	local var_34_4 = var_0_1

	var_2.Query(var_34_4, var_34_1)

	return
end

function var_0_0.GetProduct(arg_35_0)
	local var_35_0 = var_0_1

	return var_1.GetProduct(var_35_0, arg_35_0)
end

local function var_0_5()
	Timer = var_1_10000

	local var_36_0 = var_1_10000.New(function()
		local var_37_0 = var_0_1

		var_0.OnLoginTimeOut(var_37_0)

		return
	end, 30, 1)

	var_0.Start(var_36_0)

	return
end

local var_0_6 = StartSdkLogin

local function var_0_7()
	pg = var_1_10000

	if not var_1_10000.m02 then
		originalPrint = var_0

		var_0("game is not start")

		return
	end

	pg = var_0

	local var_38_0 = var_0.m02
	local var_38_1 = var_0.sendNotification

	GAME = var_1_10003

	local var_38_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_38_1(var_38_0, var_38_2, var_1_10004.LOGIN)

	gcAll = var_38_1

	var_38_1()

	return
end

local var_0_8 = GoLoginScene

local function var_0_9(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	pg = var_1_10004

	if not var_1_10004.m02 then
		originalPrint = var_4

		var_4("game is not start")

		return
	end

	User = var_4

	local var_39_0 = var_4.New({
		type = 1,
		arg1 = arg_39_0,
		arg2 = arg_39_1,
		arg3 = arg_39_2,
		arg4 = arg_39_3
	})

	pg = var_1_10005

	local var_39_1 = var_1_10005.SdkMgr.GetInstance()

	var_39_1.airi_uid = arg_39_1 or "test"
	pg = var_39_1

	local var_39_2 = var_39_1.m02
	local var_39_3 = var_5.sendNotification

	GAME = var_1_10008

	var_39_3(var_39_2, var_1_10008.PLATFORM_LOGIN_DONE, {
		user = var_39_0
	})

	return
end

local var_0_10 = SDKLogined

local function var_0_11(arg_40_0)
	pg = var_1_10001

	if not var_1_10001.m02 then
		originalPrint = var_1

		var_1("game is not start")

		return
	end

	pg = var_1

	local var_40_0 = var_1.m02
	local var_40_1 = var_1.sendNotification

	GAME = var_1_10004

	var_40_1(var_40_0, var_1_10004.LOGOUT, {
		code = arg_40_0
	})

	return
end

local var_0_12 = SDKLogouted

local function var_0_13(arg_41_0, arg_41_1)
	pg = var_1_10002

	if not var_1_10002.m02 then
		originalPrint = var_2

		var_2("game is not start")

		return
	end

	getProxy = var_2
	ShopsProxy = var_1_10004

	local var_41_0 = var_2(var_1_10004)

	var_2.removeWaitTimer(var_41_0)

	originalPrint = var_2

	var_2(arg_41_0 + " - " + arg_41_1)

	pg = var_2

	local var_41_1 = var_2.m02
	local var_41_2 = var_2.sendNotification

	GAME = var_1_10005

	var_41_2(var_41_1, var_1_10005.CHARGE_CONFIRM, {
		payId = arg_41_0,
		bsId = arg_41_1
	})

	return
end

local var_0_14 = PaySuccess

local function var_0_15(arg_42_0, arg_42_1)
	pg = var_1_10002

	if not var_1_10002.m02 then
		originalPrint = var_2

		var_2("game is not start")

		return
	end

	getProxy = var_2
	ShopsProxy = var_1_10004

	local var_42_0 = var_2(var_1_10004)

	var_2.removeWaitTimer(var_42_0)

	tonumber = var_2

	if not var_2(arg_42_1) then
		return
	end

	PLATFORM_CODE = var_2
	PLATFORM_CHT = var_1_10003

	if var_2 == var_1_10003 and var_0_0.GetChannelUID() == "2" then
		return
	end

	pg = var_2

	local var_42_1 = var_2.m02
	local var_42_2 = var_2.sendNotification

	GAME = var_1_10005

	var_42_2(var_42_1, var_1_10005.CHARGE_FAILED, {
		payId = arg_42_0,
		code = arg_42_1
	})

	return
end

local var_0_16 = PayFailed

local function var_0_17()
	return
end

local var_0_18 = GetUserInfoSuccess

local function var_0_19()
	return
end

local var_0_20 = GetUserInfoFailed

local function var_0_21(arg_45_0, arg_45_1, arg_45_2)
	YongshiSdkUserBindInfo = var_1_10003

	if arg_45_0 == var_1_10003.FACEBOOK then
		pg = var_3

		local var_45_0 = var_3.TipsMgr.GetInstance()

		var_3.ShowTips(var_45_0, arg_45_1 .. "facebook" .. arg_45_2)
	else
		YongshiSdkUserBindInfo = var_3

		if arg_45_0 == var_3.APPLE then
			pg = var_3

			local var_45_1 = var_3.TipsMgr.GetInstance()

			var_3.ShowTips(var_45_1, arg_45_1 .. "Apple Id" .. arg_45_2)
		else
			YongshiSdkUserBindInfo = var_3

			if arg_45_0 == var_3.GOOGLE then
				pg = var_3

				local var_45_2 = var_3.TipsMgr.GetInstance()

				var_3.ShowTips(var_45_2, arg_45_1 .. "google" .. arg_45_2)
			else
				YongshiSdkUserBindInfo = var_3

				if arg_45_0 == var_3.PHONE then
					if arg_45_1 == "解綁" then
						arg_45_1 = "换绑"
					end

					pg = var_3

					local var_45_3 = var_3.TipsMgr.GetInstance()

					var_3.ShowTips(var_45_3, arg_45_1 .. "手機" .. arg_45_2)
				else
					print = var_3

					var_3("this platform is not supported")
				end
			end
		end
	end

	return
end

local function var_0_22(arg_46_0)
	var_0_21(arg_46_0, "綁定", "成功")

	pg = var_1

	local var_46_0 = var_1.m02
	local var_46_1 = var_1.sendNotification

	GAME = var_4

	var_46_1(var_46_0, var_4.CHT_SOCIAL_LINK_STATE_CHANGE, arg_46_0)

	return
end

local var_0_23 = BindSuccess

local function var_0_24(arg_47_0, arg_47_1)
	if arg_47_1 and arg_47_1 ~= "" then
		pg = var_1_10002

		local var_47_0 = var_1_10002.TipsMgr.GetInstance()

		var_2.ShowTips(var_47_0, arg_47_1)
	else
		var_0_21(arg_47_0, "綁定", "失敗")
	end

	return
end

local var_0_25 = BindFailed

local function var_0_26(arg_48_0)
	var_0_21(arg_48_0, "解綁", "成功")

	pg = var_1

	local var_48_0 = var_1.m02
	local var_48_1 = var_1.sendNotification

	GAME = var_4

	var_48_1(var_48_0, var_4.CHT_SOCIAL_LINK_STATE_CHANGE)

	return
end

local var_0_27 = UnBindSuccess

local function var_0_28(arg_49_0, arg_49_1)
	if arg_49_1 and arg_49_1 ~= "" then
		pg = var_1_10002

		local var_49_0 = var_1_10002.TipsMgr.GetInstance()

		var_2.ShowTips(var_49_0, arg_49_1)
	else
		var_0_21(arg_49_0, "解綁", "失敗")
	end

	return
end

local var_0_29 = UnBindFailed

local function var_0_30(arg_50_0)
	pg = var_1_10001

	local var_50_0 = var_1_10001.YongshiDeepLinkingMgr.GetInstance()

	var_1.SetData(var_50_0, arg_50_0)

	return
end

local var_0_31 = OnDeepLinking

return var_0_0

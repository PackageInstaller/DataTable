local var_0_0 = {}

TxwyKrSdkMgr = var_0_10001

local var_0_1 = var_0_10001.inst

function var_0_0.CheckPretest()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_HOST == "bl-kr-test.xdg.com" then
		NetConst = var_1_0

		local var_1_0

		if var_1_0.GATEWAY_PORT ~= 30001 then
			IsUnityEditor = var_1_0

			if false then
				var_1_0 = false
			end
		else
			var_1_0 = true
		end

		return var_1_0
	end
end

function var_0_0.GetPNInfo()
	local var_2_0 = "null"
	local var_2_1 = "null"
	local var_2_2 = "not logged in"

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	if var_1_10003(var_1_10005) then
		var_2_0 = var_3:getData().id
		var_2_1 = var_3:getData().level
		var_2_2 = var_3:getData().name
	end

	local var_2_3 = "none"

	getProxy = var_1_10005
	UserProxy = var_1_10007

	local var_2_4 = var_1_10005(var_1_10007)

	if var_5.getData(var_2_4) then
		getProxy = var_1_10007
		ServerProxy = var_1_10009

		local var_2_5 = var_1_10007(var_1_10009)

		var_2_3 = var_1_10007.getLastServer(var_2_5, var_6.uid).id
	end

	PNInfo = var_1_10007

	local var_2_6 = var_1_10007.New(var_2_0, var_2_1)
	local var_2_7 = {}

	PNInfo = var_9
	var_2_7.info = var_9.New(var_2_0, var_2_1)
	var_2_7.playerID = var_2_0
	var_2_7.playerName = var_2_2
	var_2_7.playerLevel = var_2_1
	var_2_7.serverID = var_2_3

	return var_2_7
end

function var_0_0.GetClientVer()
	BundleWizard = var_1_10000

	local var_3_0 = var_1_10000.Inst
	local var_3_1 = var_0.GetGroupMgr

	GroupMainHelper = var_1_10003

	local var_3_2 = var_3_1(var_3_0, var_1_10003.DefaultGroupName).CurrentVersion

	return (var_1.ToString(var_3_2))
end

function var_0_0.GetSDKServerID()
	local var_4_0 = {
		[0] = "1",
		"2001",
		"1001",
		"not_define"
	}

	NetConst = var_1_10001

	local var_4_1 = var_4_0[var_1_10001.getwayType]

	originalPrint = var_1_10002

	local var_4_2 = "SDK ServerID:"

	tostring = var_1_10005

	var_1_10002(var_4_2 .. var_1_10005(var_4_1))

	return var_4_1
end

function var_0_0.GoSDkLoginScene()
	local var_5_0 = var_0_1

	var_0.GoLoginScene(var_5_0)

	return
end

function var_0_0.LoginSdk(arg_6_0)
	local var_6_0 = var_0_1

	var_1.Login(var_6_0)

	return
end

function var_0_0.SdkGateWayLogined()
	local var_7_0 = var_0_1

	var_0.OnGatewayLogined(var_7_0)

	return
end

function var_0_0.SdkLoginGetaWayFailed()
	local var_8_0 = var_0_1

	var_0.OnLoginGatewayFailed(var_8_0)

	return
end

function var_0_0.LogoutSDK()
	local var_9_0 = var_0_1

	var_0.LocalLogout(var_9_0)

	return
end

function var_0_0.EnterServer(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	return
end

function var_0_0.SdkLevelUp(arg_11_0, arg_11_1)
	return
end

function var_0_0.UserCenter()
	local var_12_0 = var_0_0.GetPNInfo()
	local var_12_1 = var_0_0.GetClientVer()
	local var_12_2 = var_0_1

	var_2.UserCenter(var_12_2, var_12_0.playerName, var_12_1, var_12_0.serverID, var_12_0.info)

	return
end

function var_0_0.BugReport()
	local var_13_0 = var_0_0.GetPNInfo()
	local var_13_1 = var_0_0.GetClientVer()
	local var_13_2 = var_0_1

	var_2.BugReport(var_13_2, var_13_0.playerName, var_13_1, var_13_0.serverID, var_13_0.info)

	return
end

function var_0_0.StoreReview()
	if var_0_0.GetIsPlatform() then
		local var_14_0 = var_0_0.GetPNInfo()
		local var_14_1 = var_0_0.GetClientVer()
		local var_14_2 = var_0_1

		var_2.StoreReview(var_14_2, var_14_0.playerName, var_14_1, var_14_0.serverID, var_14_0.info)
	end

	return
end

function var_0_0.ShareImg(arg_15_0)
	local var_15_0 = var_0_1

	var_1.ShareImg(var_15_0, arg_15_0, "")

	return
end

function var_0_0.CompletedTutorial()
	return
end

function var_0_0.UnlockAchievement()
	return
end

function var_0_0.OnAndoridBackPress()
	PressBack = var_1_10000

	var_1_10000()

	return
end

function var_0_0.QueryWithProduct()
	return
end

function var_0_0.QueryPendingTransaction()
	if var_0_0.GetIsPlatform() then
		local var_20_0 = var_0_1

		var_0.SDK_QueryPendingTransaction(var_20_0)
	end

	return
end

function var_0_0.SdkPay(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8, arg_21_9)
	local var_21_0 = var_0_0.GetPNInfo().serverID .. "-" .. var_10.playerID .. "-" .. arg_21_4

	originalPrint = var_12

	local var_21_1 = "SdkPay nonce"

	tostring = var_15

	var_12(var_21_1, var_15(var_21_0))

	local var_21_2 = var_0_0.GetSDKServerID()
	local var_21_3 = var_0_1
	local var_21_4 = var_13.SDK_PayWithProductID
	local var_21_5 = arg_21_0
	local var_21_6 = var_21_2
	local var_21_7 = var_21_0
	local var_21_8 = var_10.info

	var_21_4(var_21_3, var_21_5, var_21_6, var_21_7, var_19.GetJson(var_21_8))

	return
end

function var_0_0.BindCPU()
	local var_22_0 = var_0_1

	var_0.callSdkApi(var_22_0, "bindCpu", nil)

	return
end

function var_0_0.SwitchAccount()
	local var_23_0 = var_0_1

	var_0.LocalLogout(var_23_0)

	onDelayTick = var_0

	var_0(function()
		local var_24_0 = var_0_1

		var_0.Login(var_24_0)

		return
	end, 0.1)

	return
end

function var_0_0.EventTrack(arg_25_0)
	local var_25_0 = var_0_1

	var_1.SDK_EvtTrack(var_25_0, arg_25_0)

	return
end

function var_0_0.GetBiliServerId()
	local var_26_0 = var_0_1.serverId

	originalPrint = var_1_10001

	var_1_10001("serverId : " .. var_26_0)

	return var_26_0
end

function var_0_0.GetChannelUID()
	local var_27_0 = var_0_1.channelUID

	originalPrint = var_1_10001

	var_1_10001("channelUID : " .. var_27_0)

	return var_27_0
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GetDeviceModel()
	local var_30_0 = var_0_1

	return var_0.GetDeviceModel(var_30_0)
end

function var_0_0.OnAndoridBackPress()
	PressBack = var_1_10000

	var_1_10000()

	return
end

local function var_0_2()
	pg = var_1_10000

	if not var_1_10000.m02 then
		originalPrint = var_0

		var_0("game is not start")

		return
	end

	pg = var_0

	local var_32_0 = var_0.m02
	local var_32_1 = var_0.sendNotification

	GAME = var_1_10003

	local var_32_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_32_1(var_32_0, var_32_2, var_1_10004.LOGIN)

	gcAll = var_32_1

	var_32_1()

	return
end

local var_0_3 = GoLoginScene

local function var_0_4(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	pg = var_1_10004

	if not var_1_10004.m02 then
		originalPrint = var_4

		var_4("game is not start")

		return
	end

	User = var_4

	local var_33_0 = var_4.New({
		type = 1,
		arg1 = arg_33_0,
		arg2 = arg_33_1,
		arg3 = arg_33_2,
		arg4 = arg_33_3
	})

	pg = var_1_10005

	local var_33_1 = var_1_10005.m02
	local var_33_2 = var_5.sendNotification

	GAME = var_1_10008

	var_33_2(var_33_1, var_1_10008.PLATFORM_LOGIN_DONE, {
		user = var_33_0
	})

	return
end

local var_0_5 = SDKLogined

local function var_0_6(arg_34_0)
	pg = var_1_10001

	if not var_1_10001.m02 then
		originalPrint = var_1

		var_1("game is not start")

		return
	end

	pg = var_1

	local var_34_0 = var_1.m02
	local var_34_1 = var_1.sendNotification

	GAME = var_1_10004

	var_34_1(var_34_0, var_1_10004.LOGOUT, {
		code = arg_34_0
	})

	return
end

local var_0_7 = SDKLogouted

local function var_0_8(arg_35_0, arg_35_1)
	pg = var_1_10002

	if not var_1_10002.m02 then
		originalPrint = var_2

		var_2("game is not start")

		return
	end

	getProxy = var_2
	ShopsProxy = var_1_10004

	local var_35_0 = var_2(var_1_10004)

	var_2.removeWaitTimer(var_35_0)

	return
end

local var_0_9 = PaySuccess

local function var_0_10(arg_36_0, arg_36_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10004

	local var_36_0 = var_1_10002(var_1_10004)

	var_2.removeWaitTimer(var_36_0)

	tonumber = var_2

	if not var_2(arg_36_1) then
		return
	end

	pg = var_2

	local var_36_1 = var_2.m02
	local var_36_2 = var_2.sendNotification

	GAME = var_1_10005

	var_36_2(var_36_1, var_1_10005.CHARGE_FAILED, {
		payId = arg_36_0,
		code = arg_36_1
	})

	if arg_36_1 == -202 then
		pg = var_36_2

		local var_36_3 = var_36_2.TipsMgr.GetInstance()
		local var_36_4 = var_2.ShowTips

		i18n = var_5

		var_36_4(var_36_3, var_5("pay_cancel") .. arg_36_1)
	end

	return
end

local var_0_11 = PayFailed

function var_0_0.Survey(arg_37_0)
	Application = var_1_10001

	var_1_10001.OpenURL(arg_37_0)

	return
end

local function var_0_12(arg_38_0)
	local function var_38_0(arg_39_0, arg_39_1)
		ipairs = var_2_10002
		pg = var_2_10004

		for iter_39_0, iter_39_1 in var_2_10002(var_2_10004.pay_data_display.all) do
			pg = var_2_10007

			if var_2_10007.pay_data_display[iter_39_1].id_str == arg_39_0 and var_2_10007.money ~= arg_39_1 then
				-- block empty
			end
		end

		return
	end

	local var_38_1 = arg_38_0.Count

	for iter_38_0 = 0, var_38_1 - 1 do
		local var_38_2 = arg_38_0[iter_38_0].ProductID
		local var_38_3 = var_7.Price

		var_38_0(var_38_2, var_38_3)
	end

	return
end

local var_0_13 = OnQueryProductsSucess

local function var_0_14(arg_40_0)
	return
end

local var_0_15 = OnAdRewards

local function var_0_16(arg_41_0)
	return
end

local var_0_17 = OnQuerySubscriptionSuccess

local function var_0_18(arg_42_0)
	local var_42_0 = var_0_0.GetPNInfo()
	local var_42_1 = ""

	originalPrint = var_1_10003

	var_1_10003("SdkPay OnRequestPayment")

	local var_42_2 = var_0_0.GetSDKServerID()
	local var_42_3 = var_0_1
	local var_42_4 = var_4.SDK_PayWithProductID
	local var_42_5 = arg_42_0
	local var_42_6 = var_42_2
	local var_42_7 = var_42_1
	local var_42_8 = var_42_0.info

	var_42_4(var_42_3, var_42_5, var_42_6, var_42_7, var_10.GetJson(var_42_8))

	return
end

local var_0_19 = OnRequestPayment

local function var_0_20(arg_43_0, arg_43_1)
	return
end

local var_0_21 = OnQuerySuccess

return var_0_0

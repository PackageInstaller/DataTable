local var_0_0 = {}

BilibiliSdkMgr = var_0_10001

local var_0_1 = var_0_10001.inst
local var_0_2 = "BLHX24V20210713"
local var_0_3 = "FTBLHX20190524WW"
local var_0_4 = 1
local var_0_5 = PACKAGE_TYPE_BILI
local var_0_6 = 2
local var_0_7 = PACKAGE_TYPE_SHAJOY
local var_0_8 = 3
local var_0_9 = PACKAGE_TYPE_UNION
local var_0_10 = 4
local var_0_11 = PACKAGE_TYPE_YYX

function var_0_0.CheckPretest()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_HOST == "line1-test-login-ios-blhx.bilibiligame.net" then
		NetConst = var_1_0

		if var_1_0.GATEWAY_PORT ~= 80 then
			NetConst = var_1_0

			if var_1_0.GATEWAY_PORT ~= 10080 then
				NetConst = var_1_0

				if var_1_0.GATEWAY_HOST == "line1-test-login-bili-blhx.bilibiligame.net" then
					NetConst = var_1_0

					local var_1_0

					if var_1_0.GATEWAY_PORT ~= 80 then
						NetConst = var_1_0

						if var_1_0.GATEWAY_PORT ~= 10080 then
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
		end
	end
end

function var_0_0.CheckWorldTest()
	NetConst = var_1_10000

	if var_1_10000.GATEWAY_PORT == 10080 then
		NetConst = var_0

		local var_2_0

		if var_0.GATEWAY_HOST ~= "blhx-test-world-ios-game.bilibiligame.net" then
			var_2_0 = false
		else
			var_2_0 = true
		end

		return var_2_0
	end
end

function var_0_0.InitSDK()
	PLATFORM_CHT = var_1_10000
	PLATFORM_CODE = var_1_10001

	if var_1_10000 == var_1_10001 then
		var_0_1.sandboxKey = var_0_3
	end

	local var_3_0 = var_0_1

	var_0.Init(var_3_0)

	return
end

function var_0_0.GoSDkLoginScene()
	local var_4_0 = var_0_1

	var_0.GoLoginScene(var_4_0)

	return
end

function var_0_0.LoginQQ()
	local var_5_0 = var_0_1

	var_0.Login(var_5_0, 1)

	return
end

function var_0_0.LoginWX()
	local var_6_0 = var_0_1

	var_0.Login(var_6_0, 2)

	return
end

function var_0_0.LoginSdk(arg_7_0)
	if arg_7_0 == 1 then
		var_0_0.LoginQQ()
	elseif arg_7_0 == 2 then
		var_0_0.LoginWX()
	else
		local var_7_0 = var_0_1

		var_1.Login(var_7_0, 0)
	end

	return
end

function var_0_0.TryLoginSdk()
	local var_8_0 = var_0_1

	var_0.TryLogin(var_8_0)

	return
end

function var_0_0.CreateRole(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0_1

	var_5.CreateRole(var_9_0, arg_9_0, arg_9_1, arg_9_2, 1000 * arg_9_3, "vip0", arg_9_4)

	return
end

function var_0_0.EnterServer(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	local var_10_0 = var_0_1

	var_7.EnterServer(var_10_0, arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4 * 1000, arg_10_5, "vip0", arg_10_6)

	return
end

function var_0_0.ChooseServer(arg_11_0, arg_11_1)
	local var_11_0 = var_0_1

	var_2.ChooseServer(var_11_0, arg_11_0, arg_11_1)

	return
end

function var_0_0.SdkGateWayLogined()
	local var_12_0 = var_0_1

	var_0.OnGatewayLogined(var_12_0)

	return
end

function var_0_0.SdkLoginGetaWayFailed()
	local var_13_0 = var_0_1

	var_0.OnLoginGatewayFailed(var_13_0)

	return
end

function var_0_0.SdkLevelUp()
	local var_14_0 = var_0_1

	var_0.LevelUp(var_14_0)

	return
end

function var_0_0.SdkPay(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9)
	local var_15_0 = var_0_1

	var_10.Pay(var_15_0, arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9)

	return
end

function var_0_0.LogoutSDK(arg_16_0)
	if arg_16_0 ~= 0 then
		CSharpVersion = var_1_10001

		if var_1_10001 >= 44 then
			local var_16_0 = var_0_1

			var_1.ClearLoginData(var_16_0)

			goto label_16_0
		end
	end

	do
		local var_16_1 = var_0_1

		var_1.LocalLogout(var_16_1)
	end

	::label_16_0::

	return
end

function var_0_0.BindCPU()
	return
end

function var_0_0.DeleteAccount()
	LuaHelper = var_1_10000

	local var_18_0 = var_1_10000.GetCHPackageType()

	PACKAGE_TYPE_UNION = var_1_10001

	if var_18_0 == var_1_10001 then
		getProxy = var_1_10001
		UserProxy = var_1_10003

		local var_18_1 = var_1_10001(var_1_10003)
		local var_18_2 = var_1.getRawData(var_18_1)

		getProxy = var_1_10002
		ServerProxy = var_1_10004

		local var_18_3 = var_1_10002(var_1_10004)
		local var_18_4 = var_2.getRawData(var_18_3)
		local var_18_5

		if not var_18_2 or not var_18_2.server then
			var_18_5 = 0
		end

		local var_18_6

		if not var_18_4[var_18_5] or not var_2.name then
			var_18_6 = ""
		end

		getProxy = var_18_3
		PlayerProxy = var_1_10006

		local var_18_7 = var_18_3(var_1_10006)
		local var_18_8

		if not var_4.getRawData(var_18_7) or not var_4:GetName() then
			var_18_8 = ""
		end

		if var_4 then
			tostring = var_18_7

			local var_18_9

			if not var_18_7(var_4.level) then
				var_18_9 = "0"
			end

			local var_18_10

			if not var_4 or not var_4:GetRegisterTime() then
				var_18_10 = 0
			end

			pg = var_1_10008

			local var_18_11 = var_1_10008.TimeMgr.GetInstance()
			local var_18_12 = var_8.STimeDescS(var_18_11, var_18_10, "%Y/%m/%d")
			local var_18_13 = var_0_1

			var_9.DeleteAccountForUO(var_18_13, var_18_8, var_18_6, var_18_9, var_18_12)

			if false then
				local var_18_14 = var_0_1

				var_1.DeleteAccount(var_18_14)
			end

			return
		end
	end
end

function var_0_0.OnAndoridBackPress()
	LuaHelper = var_1_10000

	local var_19_0 = var_1_10000.GetCHPackageType()

	PACKAGE_TYPE_BILI = var_1_10001

	if var_19_0 ~= var_1_10001 then
		PACKAGE_TYPE_SHAJOY = var_1_10001

		if var_19_0 == var_1_10001 then
			IsNil = var_1_10001
			pg = var_1_10003

			if not var_1_10001(var_1_10003.MsgboxMgr.GetInstance()._go) then
				pg = var_1

				local var_19_1 = var_1.MsgboxMgr.GetInstance()
				local var_19_2 = var_1.ShowMsgBox
				local var_19_3 = {}

				i18n = var_1_10005
				var_19_3.content = var_1_10005("confirm_app_exit")

				function var_19_3.onYes()
					local var_20_0 = var_0_1

					var_0.onBackPressed(var_20_0)

					return
				end

				var_19_2(var_19_1, var_19_3)
			else
				local var_19_4 = var_0_1

				var_1.onBackPressed(var_19_4)
			end
		else
			local var_19_5 = var_0_1

			var_1.onBackPressed(var_19_5)
		end

		return
	end
end

function var_0_0.ShowPrivate()
	LuaHelper = var_1_10000

	local var_21_0 = var_1_10000.GetCHPackageType()

	PACKAGE_TYPE_UNION = var_1_10001

	if var_21_0 ~= var_1_10001 then
		IsUnityEditor = var_1_10001

		if var_1_10001 then
			pg = var_1_10001

			local var_21_1 = var_1_10001.UserAgreementMgr.GetInstance()

			var_1_10001.ShowForBiliPrivate(var_21_1)
		else
			PACKAGE_TYPE_SHAJOY = var_1_10001

			if var_21_0 == var_1_10001 then
				Application = var_1_10001

				var_1_10001.OpenURL("https://game.bilibili.com/uosdk_privacy/h5?game_id=209&privacyProtocol=1")
			else
				PACKAGE_TYPE_YYX = var_1_10001

				if var_21_0 == var_1_10001 then
					-- block empty
				else
					local var_21_2 = var_0_1

					var_1.ShowPrivate(var_21_2)
				end
			end
		end

		return
	end
end

function var_0_0.ShowLicence()
	LuaHelper = var_1_10000

	local var_22_0 = var_1_10000.GetCHPackageType()

	PACKAGE_TYPE_UNION = var_1_10001

	if var_22_0 ~= var_1_10001 then
		IsUnityEditor = var_1_10001

		if var_1_10001 then
			pg = var_1_10001

			local var_22_1 = var_1_10001.UserAgreementMgr.GetInstance()

			var_1_10001.ShowForBiliLicence(var_22_1)
		else
			PACKAGE_TYPE_SHAJOY = var_1_10001

			if var_22_0 == var_1_10001 then
				Application = var_1_10001

				var_1_10001.OpenURL("https://game.bilibili.com/uosdk_privacy/h5?game_id=209&userProtocol=1")
			else
				PACKAGE_TYPE_YYX = var_1_10001

				if var_22_0 == var_1_10001 then
					-- block empty
				else
					local var_22_2 = var_0_1

					var_1.ShowLicence(var_22_2)
				end
			end
		end

		return
	end
end

function var_0_0.OpenMiniProgram()
	LuaHelper = var_1_10000

	local var_23_0 = var_1_10000.GetCHPackageType()

	PACKAGE_TYPE_BILI = var_1_10001

	if var_23_0 == var_1_10001 then
		IsUnityEditor = var_1_10001

		if not var_1_10001 then
			local var_23_1 = var_0_1

			var_1.OpenMiniProgram(var_23_1, "gh_dae6f3c76e13", "pages/home/index")
		end
	end

	return
end

function var_0_0.GetBiliServerId()
	local var_24_0 = var_0_1.serverId

	originalPrint = var_1_10001

	var_1_10001("serverId : " .. var_24_0)

	return var_24_0
end

function var_0_0.GetChannelUID()
	local var_25_0 = var_0_1.channelUID

	originalPrint = var_1_10001

	var_1_10001("channelUID : " .. var_25_0)

	return var_25_0
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GameShare(arg_28_0, arg_28_1)
	local var_28_0 = var_0_1

	var_2.ShareWithImage(var_28_0, "Azur Lane", arg_28_0, arg_28_1)

	return
end

function var_0_0.Service()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	if not var_1_10000(var_1_10002) then
		return
	end

	local var_29_0 = var_0:getRawData().id
	local var_29_1 = var_1:GetName()
	local var_29_2 = ""
	local var_29_3 = ""

	PLATFORM = var_1_10006
	PLATFORM_IPHONEPLAYER = var_1_10007

	local var_29_4 = var_1_10006 == var_1_10007 and "portrai" or "portrait"
	local var_29_5 = var_0_1

	var_6.Service(var_29_5, var_29_0, var_29_1, var_29_2, var_29_4)

	return
end

function var_0_0.Survey(arg_30_0)
	local var_30_0 = var_0_1

	var_1.OpenWeb(var_30_0, arg_30_0)

	return
end

function var_0_0.IsHuaweiPackage()
	local var_31_0 = var_0_1

	return var_0.isHuawei(var_31_0)
end

local function var_0_12()
	Timer = var_1_10000

	local var_32_0 = var_1_10000.New(function()
		local var_33_0 = var_0_1

		var_0.OnLoginTimeOut(var_33_0)

		return
	end, 30, 1)

	var_0.Start(var_32_0)

	return
end

local var_0_13 = StartSdkLogin

local function var_0_14()
	pg = var_1_10000

	if not var_1_10000.m02 then
		originalPrint = var_0

		var_0("game is not start")

		return
	end

	pg = var_0

	local var_34_0 = var_0.m02
	local var_34_1 = var_0.sendNotification

	GAME = var_1_10003

	local var_34_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_34_1(var_34_0, var_34_2, var_1_10004.LOGIN)

	return
end

local var_0_15 = GoLoginScene

local function var_0_16(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	pg = var_1_10004

	if not var_1_10004.m02 then
		originalPrint = var_4

		var_4("game is not start")

		return
	end

	User = var_4

	local var_35_0 = var_4.New({
		type = 1,
		arg1 = arg_35_0,
		arg2 = arg_35_1,
		arg3 = arg_35_2,
		arg4 = arg_35_3
	})

	LuaHelper = var_1_10005

	local var_35_1 = var_1_10005.GetCHPackageType()

	PACKAGE_TYPE_UNION = var_35_3

	local var_35_3

	if var_35_1 == var_35_3 then
		pg = var_35_3

		local var_35_2 = var_35_3.m02

		var_35_3 = var_35_3.sendNotification
		GAME = var_1_10009

		var_35_3(var_35_2, var_1_10009.PLATFORM_LOGIN_DONE, {
			user = var_35_0
		})
	else
		pg = var_35_3

		local var_35_4 = var_35_3.m02
		local var_35_5 = var_6.sendNotification

		GAME = var_1_10009

		var_35_5(var_35_4, var_1_10009.SERVER_INTERCOMMECTION, {
			user = var_35_0
		})
	end

	return
end

local var_0_17 = SDKLogined

local function var_0_18(arg_36_0)
	pg = var_1_10001

	if not var_1_10001.m02 then
		originalPrint = var_1

		var_1("game is not start")

		return
	end

	pg = var_1

	local var_36_0 = var_1.m02
	local var_36_1 = var_1.sendNotification

	GAME = var_1_10004

	var_36_1(var_36_0, var_1_10004.LOGOUT, {
		code = arg_36_0
	})

	return
end

local var_0_19 = SDKLogouted

local function var_0_20(arg_37_0, arg_37_1)
	pg = var_1_10002

	if not var_1_10002.m02 then
		originalPrint = var_2

		var_2("game is not start")

		return
	end

	getProxy = var_2
	ShopsProxy = var_1_10004

	local var_37_0 = var_2(var_1_10004)

	var_2.removeWaitTimer(var_37_0)

	pg = var_2

	local var_37_1 = var_2.m02
	local var_37_2 = var_2.sendNotification

	GAME = var_1_10005

	var_37_2(var_37_1, var_1_10005.CHARGE_CONFIRM, {
		payId = arg_37_0,
		bsId = arg_37_1
	})

	return
end

local var_0_21 = PaySuccess

local function var_0_22(arg_38_0, arg_38_1)
	pg = var_1_10002

	if not var_1_10002.m02 then
		originalPrint = var_2

		var_2("game is not start")

		return
	end

	getProxy = var_2
	ShopsProxy = var_1_10004

	local var_38_0 = var_2(var_1_10004)

	var_2.removeWaitTimer(var_38_0)

	tonumber = var_2

	if not var_2(arg_38_1) then
		return
	end

	if var_0_0.GetChannelUID() == "21" then
		return
	end

	pg = var_2

	local var_38_1 = var_2.m02
	local var_38_2 = var_2.sendNotification

	GAME = var_1_10005

	var_38_2(var_38_1, var_1_10005.CHARGE_FAILED, {
		payId = arg_38_0,
		code = arg_38_1
	})

	PLATFORM = var_38_2
	PLATFORM_IPHONEPLAYER = var_1_10003

	if var_38_2 == var_1_10003 then
		pg = var_38_2

		local var_38_3 = var_38_2.TipsMgr.GetInstance()

		var_38_2 = var_38_2.ShowTips
		i18n1 = var_5

		var_38_2(var_38_3, var_5("支付失败" .. arg_38_1))
	elseif arg_38_1 == -5 then
		pg = var_38_2

		local var_38_4 = var_38_2.TipsMgr.GetInstance()
		local var_38_5 = var_2.ShowTips

		i18n1 = var_5

		var_38_5(var_38_4, var_5("订单签名异常" .. arg_38_1))
	else
		local var_38_7

		if 0 < arg_38_1 then
			if 1000 < arg_38_1 and arg_38_1 < 2000 then
				pg = var_38_7

				local var_38_6 = var_38_7.TipsMgr.GetInstance()

				var_38_7 = var_38_7.ShowTips
				i18n1 = var_5

				var_38_7(var_38_6, var_5("数据格式验证错误" .. arg_38_1))
			elseif 2000 <= arg_38_1 and arg_38_1 < 3000 then
				pg = var_38_7

				local var_38_8 = var_38_7.TipsMgr.GetInstance()

				var_38_7 = var_38_7.ShowTips
				i18n1 = var_5

				var_38_7(var_38_8, var_5("服务器返回异常" .. arg_38_1))
			elseif 3000 <= arg_38_1 and arg_38_1 < 4000 then
				pg = var_38_7

				local var_38_9 = var_38_7.TipsMgr.GetInstance()

				var_38_7 = var_38_7.ShowTips
				i18n1 = var_5

				var_38_7(var_38_9, var_5("未登录或者会话已超时" .. arg_38_1))
			elseif arg_38_1 == 4000 then
				pg = var_38_7

				local var_38_10 = var_38_7.TipsMgr.GetInstance()

				var_38_7 = var_38_7.ShowTips
				i18n1 = var_5

				var_38_7(var_38_10, var_5("系统错误" .. arg_38_1))
			elseif arg_38_1 == 6001 then
				pg = var_38_7

				local var_38_11 = var_38_7.TipsMgr.GetInstance()

				var_38_7 = var_38_7.ShowTips
				i18n1 = var_5

				var_38_7(var_38_11, var_5("用户中途取消" .. arg_38_1))
			elseif arg_38_1 == 7005 then
				pg = var_38_7

				local var_38_12 = var_38_7.TipsMgr.GetInstance()

				var_38_7 = var_38_7.ShowTips
				i18n1 = var_5

				var_38_7(var_38_12, var_5("支付失败" .. arg_38_1))
			elseif arg_38_1 == 7004 then
				pg = var_38_7

				local var_38_13 = var_38_7.TipsMgr.GetInstance()

				var_38_7 = var_38_7.ShowTips
				i18n1 = var_5

				var_38_7(var_38_13, var_5("支付失败" .. arg_38_1))
			end
		elseif arg_38_1 == -201 then
			pg = var_38_7

			local var_38_14 = var_38_7.TipsMgr.GetInstance()

			var_38_7 = var_38_7.ShowTips
			i18n1 = var_5

			var_38_7(var_38_14, var_5("生成订单失败" .. arg_38_1))
		elseif arg_38_1 == -202 then
			pg = var_38_7

			local var_38_15 = var_38_7.TipsMgr.GetInstance()

			var_38_7 = var_38_7.ShowTips
			i18n1 = var_5

			var_38_7(var_38_15, var_5("支付取消" .. arg_38_1))
		elseif arg_38_1 == -203 then
			pg = var_38_7

			local var_38_16 = var_38_7.TipsMgr.GetInstance()
			local var_38_17 = var_2.ShowTips

			i18n1 = var_5

			var_38_17(var_38_16, var_5("支付失败" .. arg_38_1))
		end
	end

	return
end

local var_0_23 = PayFailed

local function var_0_24(arg_39_0)
	pg = var_1_10001

	if not var_1_10001.m02 then
		originalPrint = var_1

		var_1("game is not start")

		return
	end

	pg = var_1

	local var_39_0 = var_1.MsgboxMgr.GetInstance()

	var_1.ShowMsgBox(var_39_0, {
		hideNo = true,
		content = arg_39_0,
		onYes = var_0_0.InitSDK
	})

	return
end

local var_0_25 = OnSDKInitFailed

local function var_0_26(arg_40_0)
	pg = var_1_10001

	if not var_1_10001.m02 then
		originalPrint = var_1

		var_1("game is not start")

		return
	end

	pg = var_1

	local var_40_0 = var_1.MsgboxMgr.GetInstance()

	var_1.ShowMsgBox(var_40_0, {
		hideNo = true,
		content = arg_40_0
	})

	return
end

local var_0_27 = ShowMsgBox

local function var_0_28()
	return
end

local var_0_29 = OnShowLicenceFailed

local function var_0_30()
	return
end

local var_0_31 = OnShowPrivateFailed

local function var_0_32()
	return
end

local var_0_33 = OnShareSuccess

local function var_0_34()
	return
end

local var_0_35 = OnShareFailed

local function var_0_36()
	return
end

local var_0_37 = CloseAgreementView

local function var_0_38()
	pg = var_1_10000

	local var_46_0 = var_1_10000.m02
	local var_46_1 = var_0.sendNotification

	GAME = var_1_10003

	var_46_1(var_46_0, var_1_10003.LOGOUT, {
		code = 0
	})

	return
end

local var_0_39 = OnDeleteAccountSuccess

local function var_0_40()
	pg = var_1_10000

	local var_47_0 = var_1_10000.TipsMgr.GetInstance()

	var_0.ShowTips(var_47_0, "功能未开启")

	return
end

local var_0_41 = OnDeleteAccountDisable

local function var_0_42()
	pg = var_1_10000

	local var_48_0 = var_1_10000.TipsMgr.GetInstance()

	var_0.ShowTips(var_48_0, "注销失败")

	return
end

local var_0_43 = OnDeleteAccountFailed

return var_0_0

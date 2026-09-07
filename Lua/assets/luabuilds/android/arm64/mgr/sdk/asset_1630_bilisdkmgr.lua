local var_0_0 = {}
local var_0_1 = BilibiliSdkMgr.inst
local var_0_3 = "FTBLHX20190524WW"

PACKAGE_TYPE_BILI = 1
PACKAGE_TYPE_SHAJOY = 2
PACKAGE_TYPE_UNION = 3
PACKAGE_TYPE_YYX = 4

function var_0_0.CheckPretest()
	return NetConst.GATEWAY_HOST == "line1-test-login-ios-blhx.bilibiligame.net" and (NetConst.GATEWAY_PORT == 80 or NetConst.GATEWAY_PORT == 10080) or NetConst.GATEWAY_HOST == "line1-test-login-bili-blhx.bilibiligame.net" and (NetConst.GATEWAY_PORT == 80 or NetConst.GATEWAY_PORT == 10080) or IsUnityEditor
end

function var_0_0.CheckWorldTest()
	return NetConst.GATEWAY_PORT == 10080 and NetConst.GATEWAY_HOST == "blhx-test-world-ios-game.bilibiligame.net"
end

function var_0_0.InitSDK()
	if PLATFORM_CHT == PLATFORM_CODE then
		var_0_1.sandboxKey = var_0_3
	end

	var_0_1:Init()

	return
end

function var_0_0.GoSDkLoginScene()
	var_0_1:GoLoginScene()

	return
end

function var_0_0.LoginQQ()
	var_0_1:Login(1)

	return
end

function var_0_0.LoginWX()
	var_0_1:Login(2)

	return
end

function var_0_0.LoginSdk(arg_7_0)
	if arg_7_0 == 1 then
		var_0_0.LoginQQ()
	elseif arg_7_0 == 2 then
		var_0_0.LoginWX()
	else
		var_0_1:Login(0)
	end

	return
end

function var_0_0.TryLoginSdk()
	var_0_1:TryLogin()

	return
end

function var_0_0.CreateRole(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_1:CreateRole(arg_9_0, arg_9_1, arg_9_2, 1000 * arg_9_3, "vip0", arg_9_4)

	return
end

function var_0_0.EnterServer(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	var_0_1:EnterServer(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4 * 1000, arg_10_5, "vip0", arg_10_6)

	return
end

function var_0_0.ChooseServer(arg_11_0, arg_11_1)
	var_0_1:ChooseServer(arg_11_0, arg_11_1)

	return
end

function var_0_0.SdkGateWayLogined()
	var_0_1:OnGatewayLogined()

	return
end

function var_0_0.SdkLoginGetaWayFailed()
	var_0_1:OnLoginGatewayFailed()

	return
end

function var_0_0.SdkLevelUp()
	var_0_1:LevelUp()

	return
end

function var_0_0.SdkPay(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9)
	var_0_1:Pay(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9)

	return
end

function var_0_0.LogoutSDK(arg_16_0)
	if arg_16_0 ~= 0 and CSharpVersion >= 44 then
		var_0_1:ClearLoginData()
	else
		var_0_1:LocalLogout()
	end

	return
end

function var_0_0.BindCPU()
	return
end

function var_0_0.DeleteAccount()
	if LuaHelper.GetCHPackageType() == PACKAGE_TYPE_UNION then
		local var_18_0 = getProxy(UserProxy):getRawData()
		local var_18_1

		if getProxy(ServerProxy):getRawData()[(var_18_0 or nil) and (var_18_0.server or 0)] then
			var_18_1 = getProxy(ServerProxy):getRawData()[(var_18_0 or nil) and (var_18_0.server or 0)].name or ""
		end

		local var_18_2 = getProxy(PlayerProxy)
		local var_18_3 = var_18_2:getRawData()
		local var_18_4 = var_18_3 and var_18_3:GetName() or ""
		local var_18_5 = var_18_3 and tostring(var_18_3.level) or "0"

		var_0_1:DeleteAccountForUO(var_18_4, var_18_1, var_18_2, (pg.TimeMgr.GetInstance():STimeDescS(var_18_3 and var_18_3:GetRegisterTime() or 0, "%Y/%m/%d")))
	else
		var_0_1:DeleteAccount()
	end

	return
end

function var_0_0.OnAndoridBackPress()
	local var_19_0 = LuaHelper.GetCHPackageType()

	if var_19_0 == PACKAGE_TYPE_BILI or var_19_0 == PACKAGE_TYPE_SHAJOY then
		if not IsNil(pg.MsgboxMgr.GetInstance()._go) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("confirm_app_exit"),
				onYes = function()
					var_0_1:onBackPressed()

					return
				end
			})
		else
			var_0_1:onBackPressed()
		end
	else
		var_0_1:onBackPressed()
	end

	return
end

function var_0_0.ShowPrivate()
	local var_21_0 = LuaHelper.GetCHPackageType()

	if var_21_0 == PACKAGE_TYPE_UNION or IsUnityEditor then
		pg.UserAgreementMgr.GetInstance():ShowForBiliPrivate()
	elseif var_21_0 == PACKAGE_TYPE_SHAJOY then
		Application.OpenURL("https://game.bilibili.com/uosdk_privacy/h5?game_id=209&privacyProtocol=1")
	elseif var_21_0 == PACKAGE_TYPE_YYX then
		-- block empty
	else
		var_0_1:ShowPrivate()
	end

	return
end

function var_0_0.ShowLicence()
	local var_22_0 = LuaHelper.GetCHPackageType()

	if var_22_0 == PACKAGE_TYPE_UNION or IsUnityEditor then
		pg.UserAgreementMgr.GetInstance():ShowForBiliLicence()
	elseif var_22_0 == PACKAGE_TYPE_SHAJOY then
		Application.OpenURL("https://game.bilibili.com/uosdk_privacy/h5?game_id=209&userProtocol=1")
	elseif var_22_0 == PACKAGE_TYPE_YYX then
		-- block empty
	else
		var_0_1:ShowLicence()
	end

	return
end

function var_0_0.OpenMiniProgram()
	if LuaHelper.GetCHPackageType() == PACKAGE_TYPE_BILI and not IsUnityEditor then
		var_0_1:OpenMiniProgram("gh_dae6f3c76e13", "pages/home/index")
	end

	return
end

function var_0_0.GetBiliServerId()
	originalPrint("serverId : " .. var_0_1.serverId)

	return var_0_1.serverId
end

function var_0_0.GetChannelUID()
	originalPrint("channelUID : " .. var_0_1.channelUID)

	return var_0_1.channelUID
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GameShare(arg_28_0, arg_28_1)
	var_0_1:ShareWithImage("Azur Lane", arg_28_0, arg_28_1)

	return
end

function var_0_0.Service()
	local var_29_0 = getProxy(PlayerProxy)

	if not var_29_0 then
		return
	end

	local var_29_1 = var_29_0:getRawData()

	var_0_1:Service(var_29_1.id, var_29_1:GetName(), "", PLATFORM == PLATFORM_IPHONEPLAYER and "portrai" or "portrait")

	return
end

function var_0_0.Survey(arg_30_0)
	var_0_1:OpenWeb(arg_30_0)

	return
end

function var_0_0.IsHuaweiPackage()
	return var_0_1:isHuawei()
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

	return
end

function SDKLogined(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	local var_35_0 = User.New({
		type = 1,
		arg1 = arg_35_0,
		arg2 = arg_35_1,
		arg3 = arg_35_2,
		arg4 = arg_35_3
	})

	if LuaHelper.GetCHPackageType() == PACKAGE_TYPE_UNION then
		pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {
			user = var_35_0
		})
	else
		pg.m02:sendNotification(GAME.SERVER_INTERCOMMECTION, {
			user = var_35_0
		})
	end

	return
end

function SDKLogouted(arg_36_0)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	pg.m02:sendNotification(GAME.LOGOUT, {
		code = arg_36_0
	})

	return
end

function PaySuccess(arg_37_0, arg_37_1)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	getProxy(ShopsProxy):removeWaitTimer()
	pg.m02:sendNotification(GAME.CHARGE_CONFIRM, {
		payId = arg_37_0,
		bsId = arg_37_1
	})

	return
end

function PayFailed(arg_38_0, arg_38_1)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	getProxy(ShopsProxy):removeWaitTimer()

	arg_38_1 = tonumber(arg_38_1)

	if not arg_38_1 then
		return
	end

	if var_0_0.GetChannelUID() == "21" then
		return
	end

	pg.m02:sendNotification(GAME.CHARGE_FAILED, {
		payId = arg_38_0,
		code = arg_38_1
	})

	if PLATFORM == PLATFORM_IPHONEPLAYER then
		pg.TipsMgr.GetInstance():ShowTips(i18n1("支付失败" .. arg_38_1))
	elseif arg_38_1 == -5 then
		pg.TipsMgr.GetInstance():ShowTips(i18n1("订单签名异常" .. arg_38_1))
	elseif arg_38_1 > 0 then
		if arg_38_1 > 1000 and arg_38_1 < 2000 then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("数据格式验证错误" .. arg_38_1))
		elseif arg_38_1 >= 2000 and arg_38_1 < 3000 then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("服务器返回异常" .. arg_38_1))
		elseif arg_38_1 >= 3000 and arg_38_1 < 4000 then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("未登录或者会话已超时" .. arg_38_1))
		elseif arg_38_1 == 4000 then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("系统错误" .. arg_38_1))
		elseif arg_38_1 == 6001 then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("用户中途取消" .. arg_38_1))
		elseif arg_38_1 == 7005 then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("支付失败" .. arg_38_1))
		elseif arg_38_1 == 7004 then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("支付失败" .. arg_38_1))
		end
	elseif arg_38_1 == -201 then
		pg.TipsMgr.GetInstance():ShowTips(i18n1("生成订单失败" .. arg_38_1))
	elseif arg_38_1 == -202 then
		pg.TipsMgr.GetInstance():ShowTips(i18n1("支付取消" .. arg_38_1))
	elseif arg_38_1 == -203 then
		pg.TipsMgr.GetInstance():ShowTips(i18n1("支付失败" .. arg_38_1))
	end

	return
end

function OnSDKInitFailed(arg_39_0)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		content = arg_39_0,
		onYes = var_0_0.InitSDK
	})

	return
end

function ShowMsgBox(arg_40_0)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		content = arg_40_0
	})

	return
end

function OnShowLicenceFailed()
	return
end

function OnShowPrivateFailed()
	return
end

function OnShareSuccess()
	return
end

function OnShareFailed()
	return
end

function CloseAgreementView()
	return
end

function OnDeleteAccountSuccess()
	pg.m02:sendNotification(GAME.LOGOUT, {
		code = 0
	})

	return
end

function OnDeleteAccountDisable()
	pg.TipsMgr.GetInstance():ShowTips("功能未开启")

	return
end

function OnDeleteAccountFailed()
	pg.TipsMgr.GetInstance():ShowTips("注销失败")

	return
end

return var_0_0

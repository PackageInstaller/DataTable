local var_0_0 = {}
local var_0_1 = TxwyKrSdkMgr.inst

;({}).CheckPretest = function()
	return NetConst.GATEWAY_HOST == "bl-kr-test.xdg.com" and NetConst.GATEWAY_PORT == 30001 or IsUnityEditor
end
;({}).GetPNInfo = function()
	local var_2_0 = "null"
	local var_2_1 = "null"
	local var_2_2 = "not logged in"
	local var_2_3 = getProxy(PlayerProxy)

	if var_2_3 then
		var_2_0 = var_2_3:getData().id
		var_2_1 = var_2_3:getData().level
		var_2_2 = var_2_3:getData().name
	end

	local var_2_4 = "none"
	local var_2_5 = getProxy(UserProxy):getData()

	if var_2_5 then
		var_2_4 = getProxy(ServerProxy):getLastServer(var_2_5.uid).id
	end

	local var_2_6 = PNInfo.New(var_2_0, var_2_1)

	return {
		info = PNInfo.New(var_2_0, var_2_1),
		playerID = var_2_0,
		playerName = var_2_2,
		playerLevel = var_2_1,
		serverID = var_2_4
	}
end
;({}).GetClientVer = function()
	return (BundleWizard.Inst:GetGroupMgr(GroupMainHelper.DefaultGroupName).CurrentVersion:ToString())
end
;({}).GetSDKServerID = function()
	originalPrint("SDK ServerID:" .. tostring(({
		[0] = "1",
		"2001",
		"1001",
		"not_define"
	})[NetConst.getwayType]))

	return ({
		[0] = "1",
		"2001",
		"1001",
		"not_define"
	})[NetConst.getwayType]
end
;({}).GoSDkLoginScene = function()
	var_0_1:GoLoginScene()

	return
end
;({}).LoginSdk = function(arg_6_0)
	var_0_1:Login()

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
;({}).LogoutSDK = function()
	var_0_1:LocalLogout()

	return
end
;({}).EnterServer = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	return
end
;({}).SdkLevelUp = function(arg_11_0, arg_11_1)
	return
end
;({}).UserCenter = function()
	local var_12_0 = var_0_0.GetPNInfo()

	var_0_1:UserCenter(var_12_0.playerName, var_0_0.GetClientVer(), var_12_0.serverID, var_12_0.info)

	return
end
;({}).BugReport = function()
	local var_13_0 = var_0_0.GetPNInfo()

	var_0_1:BugReport(var_13_0.playerName, var_0_0.GetClientVer(), var_13_0.serverID, var_13_0.info)

	return
end
;({}).StoreReview = function()
	if var_0_0.GetIsPlatform() then
		local var_14_0 = var_0_0.GetPNInfo()

		var_0_1:StoreReview(var_14_0.playerName, var_0_0.GetClientVer(), var_14_0.serverID, var_14_0.info)
	end

	return
end
;({}).ShareImg = function(arg_15_0)
	var_0_1:ShareImg(arg_15_0, "")

	return
end
;({}).CompletedTutorial = function()
	return
end
;({}).UnlockAchievement = function()
	return
end
;({}).OnAndoridBackPress = function()
	PressBack()

	return
end
;({}).QueryWithProduct = function()
	return
end
;({}).QueryPendingTransaction = function()
	if var_0_0.GetIsPlatform() then
		var_0_1:SDK_QueryPendingTransaction()
	end

	return
end
;({}).SdkPay = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8, arg_21_9)
	local var_21_0 = var_0_0.GetPNInfo()

	originalPrint("SdkPay nonce", tostring(var_21_0.serverID .. "-" .. var_21_0.playerID .. "-" .. arg_21_4))
	var_0_1:SDK_PayWithProductID(arg_21_0, var_0_0.GetSDKServerID(), var_21_0.serverID .. "-" .. var_21_0.playerID .. "-" .. arg_21_4, var_21_0.info:GetJson())

	return
end
;({}).BindCPU = function()
	var_0_1:callSdkApi("bindCpu", nil)

	return
end
;({}).SwitchAccount = function()
	var_0_1:LocalLogout()
	onDelayTick(function()
		var_0_1:Login()

		return
	end, 0.1)

	return
end
;({}).EventTrack = function(arg_25_0)
	var_0_1:SDK_EvtTrack(arg_25_0)

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
;({}).GetDeviceModel = function()
	return var_0_1:GetDeviceModel()
end
;({}).OnAndoridBackPress = function()
	PressBack()

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

function SDKLogined(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	;({}).user = User.New({
		type = 1,
		arg1 = arg_33_0,
		arg2 = arg_33_1,
		arg3 = arg_33_2,
		arg4 = arg_33_3
	})

	pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {})

	return
end

function SDKLogouted(arg_34_0)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	pg.m02:sendNotification(GAME.LOGOUT, {
		code = arg_34_0
	})

	return
end

function PaySuccess(arg_35_0, arg_35_1)
	if not pg.m02 then
		originalPrint("game is not start")

		return
	end

	getProxy(ShopsProxy):removeWaitTimer()

	return
end

function PayFailed(arg_36_0, arg_36_1)
	getProxy(ShopsProxy):removeWaitTimer()

	arg_36_1 = tonumber(arg_36_1)

	if not arg_36_1 then
		return
	end

	pg.m02:sendNotification(GAME.CHARGE_FAILED, {
		payId = arg_36_0,
		code = arg_36_1
	})

	if arg_36_1 == -202 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("pay_cancel") .. arg_36_1)
	end

	return
end

;({}).Survey = function(arg_37_0)
	Application.OpenURL(arg_37_0)

	return
end

function OnQueryProductsSucess(arg_38_0)
	for iter_38_0 = 0, arg_38_0.Count - 1 do
		(function(arg_39_0, arg_39_1)
			for iter_39_0, iter_39_1 in ipairs(pg.pay_data_display.all) do
				if pg.pay_data_display[iter_39_1].id_str == arg_39_0 and pg.pay_data_display[iter_39_1].money ~= arg_39_1 then
					-- block empty
				end
			end

			return
		end)(arg_38_0[iter_38_0].ProductID, arg_38_0[iter_38_0].Price)
	end

	return
end

function OnAdRewards(arg_40_0)
	return
end

function OnQuerySubscriptionSuccess(arg_41_0)
	return
end

function OnRequestPayment(arg_42_0)
	originalPrint("SdkPay OnRequestPayment")
	var_0_1:SDK_PayWithProductID(arg_42_0, var_0_0.GetSDKServerID(), "", var_0_0.GetPNInfo().info:GetJson())

	return
end

function OnQuerySuccess(arg_43_0, arg_43_1)
	return
end

return {}

local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		HuaweiSDK.registerEventHandler(HuaweiSDK.EventType.INIT, arg_1_0)
	end,
	registerExitHandler = function(arg_2_0)
		HuaweiSDK.registerEventHandler(HuaweiSDK.EventType.EXIT, arg_2_0)
	end,
	registerLoginHandler = function(arg_3_0)
		HuaweiSDK.registerEventHandler(HuaweiSDK.EventType.LOGIN, arg_3_0)
	end,
	registerPushInfoHandler = function(arg_4_0)
		HuaweiSDK.registerEventHandler(HuaweiSDK.EventType.PUSH_INFO, arg_4_0)
	end,
	registerCheckRechargeHandler = function(arg_5_0)
		HuaweiSDK.registerEventHandler(HuaweiSDK.EventType.CHECK_RECHARGE, arg_5_0)
	end,
	registerGetProdutIdListHandler = function(arg_6_0)
		HuaweiSDK.registerEventHandler(HuaweiSDK.EventType.GET_PRODUCT_ID_LIST, arg_6_0)
	end,
	registerPayHandler = function(arg_7_0)
		HuaweiSDK.registerEventHandler(HuaweiSDK.EventType.PAY, arg_7_0)
	end
}

function var_0_0.initSdk(arg_8_0)
	var_0_0.registerInitHandler(function(arg_9_0)
		if arg_9_0 == 0 then
			print("huawei sdk init success")
			var_0_0.checkUpdate()

			if arg_8_0 then
				arg_8_0(0)
			end
		else
			print("huawei sdk init error, error code: ", arg_9_0)
		end
	end)
	var_0_0.registerExitHandler(function(arg_10_0)
		if arg_10_0 == 0 then
			cc.Director:getInstance():endToLua()
		end
	end)
	HuaweiSDK.initSDK()
end

function var_0_0.checkUpdate()
	HuaweiSDK.checkUpdate()
end

function var_0_0.login()
	HuaweiSDK.login()
end

function var_0_0.pushPlayerInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	HuaweiSDK.pushPlayerInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
end

function var_0_0.isRechargeReady()
	HuaweiSDK.isRechargeReady()
end

function var_0_0.queryLocalProducts(arg_15_0)
	HuaweiSDK.queryLocalProducts(arg_15_0)
end

function var_0_0.pay(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	HuaweiSDK.pay(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
end

function var_0_0.ownedPurchasesReqHuawei()
	HuaweiSDK.ownedPurchasesReqHuawei()
end

function var_0_0.getplatform()
	return "android"
end

function var_0_0.getchannelid()
	return "270054"
end

local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_21_0)
	var_0_1 = arg_21_0 and arg_21_0 > 0
end

function var_0_0.initShare(arg_22_0)
	return false
end

return var_0_0

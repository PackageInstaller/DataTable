return {
	initSdk = function()
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs((require("data.recharge_data"))) do
			table.insert(var_1_0, iter_1_1.productid)
		end

		print("init aoki sdk")
		AokiSDK.init(var_1_0)
	end,
	login = function()
		AokiSDK.login()
	end,
	switchAccount = function()
		AokiSDK.switchAccount()
	end,
	logout = function()
		AokiSDK.login()
	end,
	isLogin = function()
		return AokiSDK.isLogin()
	end,
	doPay = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		AokiSDK.pay(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	end,
	registerInitHandler = function(arg_7_0)
		AokiSDK.registerEventHandler(AokiSDK.EventType.INIT, arg_7_0)
	end,
	registerLoginHandler = function(arg_8_0)
		AokiSDK.registerEventHandler(AokiSDK.EventType.LOGIN, arg_8_0)
	end,
	registerSwitchAccountHandler = function(arg_9_0)
		AokiSDK.registerEventHandler(AokiSDK.EventType.SWITCH_ACCOUNT, arg_9_0)
	end,
	registerLogoutHandler = function(arg_10_0)
		AokiSDK.registerEventHandler(AokiSDK.EventType.LOGOUT, arg_10_0)
	end,
	registerPayHandler = function(arg_11_0)
		AokiSDK.registerEventHandler(AokiSDK.EventType.PAY, arg_11_0)
	end,
	registerAntiAddictionHandler = function(arg_12_0)
		AokiSDK.registerEventHandler(AokiSDK.EventType.ANTI_ADDICTION, arg_12_0)
	end,
	showUserCenter = function()
		AokiSDK.showUserCenter()
	end,
	setOnSwitchAccountListener = function()
		AokiSDK.setOnSwitchAccountListener()
	end,
	getDeviceId = function()
		return AokiSDK.getDeviceId()
	end,
	pushAokiEvent = function(arg_16_0)
		if AokiSDK.pushAokiEvent then
			return AokiSDK.pushAokiEvent(arg_16_0)
		end
	end,
	getchannelid = function()
		if DeviceManager.platform == "ios" then
			return "270001"
		end

		if AokiSDK.getCurGameChannel then
			if AokiSDK.getCurGameChannel() == "h_college" then
				return "270100"
			elseif AokiSDK.getCurGameChannel() == "taptap" then
				return "270049"
			elseif AokiSDK.getCurGameChannel() == "haoyoukuaibao" then
				return "270050"
			end
		end

		return "270100"
	end,
	getplatform = function()
		return "android"
	end,
	isMoegirlChannel = function()
		if AokiSDK.isMoegirlChannel then
			print("sdkbridge.isMoegirlChannel")
			print(AokiSDK.isMoegirlChannel())

			return AokiSDK.isMoegirlChannel()
		end
	end
}

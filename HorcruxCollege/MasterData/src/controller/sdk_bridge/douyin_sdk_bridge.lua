return {
	initSdk = function()
		DouyinSDK.init()
	end,
	login = function()
		DouyinSDK.login()
	end,
	switchAccount = function()
		DouyinSDK.switchAccount()
	end,
	logout = function()
		DouyinSDK.logout()
	end,
	isLogin = function()
		return DouyinSDK.isLogin()
	end,
	getRiskControlInfo = function()
		return DouyinSDK.getRiskControlInfo()
	end,
	pay = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		DouyinSDK.pay(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	end,
	registerInitHandler = function(arg_8_0)
		DouyinSDK.registerEventHandler(DouyinSDK.EventType.INIT, arg_8_0)
	end,
	registerLoginHandler = function(arg_9_0)
		DouyinSDK.registerEventHandler(DouyinSDK.EventType.LOGIN, arg_9_0)
	end,
	registerSwitchAccountHandler = function(arg_10_0)
		DouyinSDK.registerEventHandler(DouyinSDK.EventType.SWITCHACCOUNT, arg_10_0)
	end,
	registerLogoutHandler = function(arg_11_0)
		DouyinSDK.registerEventHandler(DouyinSDK.EventType.LOGOUT, arg_11_0)
	end,
	registerPayHandler = function(arg_12_0)
		DouyinSDK.registerEventHandler(DouyinSDK.EventType.PAY, arg_12_0)
	end,
	getchannelid = function()
		return "999"
	end,
	getplatform = function()
		return "android"
	end
}

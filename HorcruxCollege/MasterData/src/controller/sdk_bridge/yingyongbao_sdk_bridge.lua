local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		if arg_1_0 then
			arg_1_0()
		end
	end,
	registerLoginHandler = function(arg_2_0)
		YingyongbaoSDK.registerEventHandler(YingyongbaoSDK.EventType.LOGIN, arg_2_0)
	end,
	registerPayHandler = function(arg_3_0)
		YingyongbaoSDK.registerEventHandler(YingyongbaoSDK.EventType.DOPAY, arg_3_0)
	end,
	registerLogoutHandler = function(arg_4_0)
		YingyongbaoSDK.registerEventHandler(YingyongbaoSDK.EventType.LOGOUT, arg_4_0)
	end,
	initSdk = function(arg_5_0)
		if arg_5_0 then
			arg_5_0(0)
		end
	end,
	login = function()
		YingyongbaoSDK.login()
	end,
	doPay = function(arg_7_0, arg_7_1)
		YingyongbaoSDK.pay(arg_7_0, arg_7_1)
	end,
	getLoginType = function(arg_8_0)
		return YingyongbaoSDK.getLoginType()
	end,
	getOpenKey = function(arg_9_0)
		return YingyongbaoSDK.getOpenKey()
	end,
	getPfkey = function(arg_10_0)
		return YingyongbaoSDK.getPfkey()
	end,
	getOpenid = function(arg_11_0)
		return YingyongbaoSDK.getOpenid()
	end,
	getPf = function(arg_12_0)
		return YingyongbaoSDK.getPf()
	end,
	getyingyongbaoplatform = function()
		return YingyongbaoSDK.getPlatform()
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270060"
	end
}
local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_17_0)
	var_0_1 = arg_17_0 and arg_17_0 > 0
end

function var_0_0.initShare(arg_18_0)
	return false
end

return var_0_0

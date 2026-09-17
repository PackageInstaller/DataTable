local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		if arg_1_0 then
			arg_1_0()
		end
	end,
	registerLoginHandler = function(arg_2_0)
		XiaomiSDK.registerEventHandler(XiaomiSDK.EventType.LOGIN, arg_2_0)
	end,
	registerPayHandler = function(arg_3_0)
		XiaomiSDK.registerEventHandler(XiaomiSDK.EventType.DOPAY, arg_3_0)
	end,
	registerExitGameHandler = function(arg_4_0)
		return
	end,
	registerLogoutHandler = function(arg_5_0)
		return
	end,
	initSdk = function(arg_6_0)
		if arg_6_0 then
			arg_6_0(0)
		end
	end,
	login = function()
		XiaomiSDK.login()
	end,
	doPay = function(arg_8_0, arg_8_1, arg_8_2)
		XiaomiSDK.doPay(arg_8_0, arg_8_1, arg_8_2)
	end,
	exit = function()
		XiaomiSDK.doExit()
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270057"
	end
}
local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_13_0)
	var_0_1 = arg_13_0 and arg_13_0 > 0
end

function var_0_0.initShare(arg_14_0)
	return false
end

return var_0_0

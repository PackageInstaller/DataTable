local var_0_0 = {
	registerLoginHandler = function(arg_1_0)
		MumuSDK.registerEventHandler(MumuSDK.EventType.LOGIN, arg_1_0)
	end,
	registerPayHandler = function(arg_2_0)
		MumuSDK.registerEventHandler(MumuSDK.EventType.PAY, arg_2_0)
	end,
	registerExitGameHandler = function(arg_3_0)
		MumuSDK.registerEventHandler(MumuSDK.EventType.QUIT, arg_3_0)
	end,
	registerLogoutHandler = function(arg_4_0)
		MumuSDK.registerEventHandler(MumuSDK.EventType.LOGOUT, arg_4_0)
	end,
	initSdk = function(arg_5_0)
		if arg_5_0 then
			arg_5_0(0)
		end
	end,
	login = function()
		MumuSDK.login()
	end,
	exit = function()
		MumuSDK.quit()
	end,
	uploadGameEventInfo = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		MumuSDK.uploadGameEventInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	end,
	doPay = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
		MumuSDK.pay(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270063"
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

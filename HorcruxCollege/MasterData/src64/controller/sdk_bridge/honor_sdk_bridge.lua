local var_0_0 = {
	registerLoginHandler = function(arg_1_0)
		HonorSDK.registerEventHandler(HonorSDK.EventType.LOGIN, arg_1_0)
	end,
	registerPayHandler = function(arg_2_0)
		HonorSDK.registerEventHandler(HonorSDK.EventType.PAY, arg_2_0)
	end,
	registerExitGameHandler = function(arg_3_0)
		HonorSDK.registerEventHandler(HonorSDK.EventType.EXIT, arg_3_0)
	end,
	initSdk = function(arg_4_0)
		if arg_4_0 then
			arg_4_0(0)
		end
	end,
	login = function()
		HonorSDK.login()
	end,
	exit = function()
		HonorSDK.exit()
	end,
	pushUserInfo = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
		HonorSDK.pushUserInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	end,
	doPay = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
		HonorSDK.pay(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270111"
	end
}
local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_12_0)
	var_0_1 = arg_12_0 and arg_12_0 > 0
end

function var_0_0.initShare(arg_13_0)
	return false
end

return var_0_0

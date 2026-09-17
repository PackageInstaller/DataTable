local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		Qoo.registerEventHandler(Qoo.EventType.INIT, arg_1_0)
	end,
	registerLoginHandler = function(arg_2_0)
		Qoo.registerEventHandler(Qoo.EventType.LOGIN, arg_2_0)
	end,
	registerPayHandler = function(arg_3_0)
		Qoo.registerEventHandler(Qoo.EventType.PURCHASE, arg_3_0)
	end,
	registerLogoutHandler = function(arg_4_0)
		Qoo.registerEventHandler(Qoo.EventType.LOGOUT, arg_4_0)
	end,
	registerQueryProdutsGameHandler = function(arg_5_0)
		Qoo.registerEventHandler(Qoo.EventType.QUERYPRODUCTS, arg_5_0)
	end,
	registerRestorePurchasesGameHandler = function(arg_6_0)
		Qoo.registerEventHandler(Qoo.EventType.RESTOREPURCHASES, arg_6_0)
	end,
	registerConsumeGameHandler = function(arg_7_0)
		Qoo.registerEventHandler(Qoo.EventType.CONSUME, arg_7_0)
	end
}

function var_0_0.initSdk(arg_8_0)
	var_0_0.registerInitHandler(function(arg_9_0)
		if json.decode(arg_9_0).code == 200 then
			arg_8_0(0)
		end
	end)
	Qoo.doInit()
end

function var_0_0.login()
	Qoo.login()
end

function var_0_0.logout()
	Qoo.logout()
end

function var_0_0.restorePurchases()
	Qoo.restorePurchases()
end

function var_0_0.pay(arg_13_0, arg_13_1, arg_13_2)
	Qoo.purchase(arg_13_0, arg_13_1, arg_13_2)
end

function var_0_0.queryProducts()
	var_0_0.registerQueryProdutsGameHandler(function(arg_15_0)
		print("setSDKProductList: ", arg_15_0)
		require("controller.recharge_manager"):setSDKProductList(json.decode(arg_15_0).data)
	end)
	Qoo.queryProducts()
end

function var_0_0.getplatform()
	return "android"
end

function var_0_0.getchannelid()
	return "270112"
end

local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_19_0)
	var_0_1 = arg_19_0 and arg_19_0 > 0
end

function var_0_0.initShare(arg_20_0)
	return false
end

return var_0_0

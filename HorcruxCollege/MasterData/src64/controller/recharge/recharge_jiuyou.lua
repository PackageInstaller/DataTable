local var_0_0 = {}

local function var_0_1(arg_1_0)
	if arg_1_0 == 0 then
		var_0_0.payRequestingHandler(arg_1_0)
	end
end

function var_0_0.init(arg_2_0)
	SDKManager.registerPayHandler(var_0_1)
end

function var_0_0.doPayment(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = require("data.recharge_data")[arg_3_1]
	local playermodel = require("model.playermodel")

	function arg_3_0.payRequestingHandler(arg_4_0)
		TrackingManager.pay(arg_3_2, DeviceManager.platform, "CNY", var_3_0.rmb)
		addWaitingLayer()
	end

	TrackingManager.order(arg_3_2, "CNY", var_3_0.rmb)

	local account_manager = require("controller.account_manager")

	print("PayInfo: ", arg_3_5, arg_3_3, tostring(var_3_0.rmb), arg_3_2, account_manager:getChannelUid(), arg_3_4)
	SDKManager.doPay(arg_3_5, arg_3_3, string.format("%.2f", var_3_0.rmb), arg_3_2, account_manager:getChannelUid(), arg_3_4)
end

return var_0_0

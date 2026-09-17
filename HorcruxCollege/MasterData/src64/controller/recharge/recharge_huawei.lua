local var_0_0 = {}

local function var_0_1(arg_1_0)
	if arg_1_0 == 0 then
		var_0_0.payRequestingHandler(arg_1_0)
	end
end

function var_0_0.init(arg_2_0)
	SDKManager.registerPayHandler(var_0_1)
	SDKManager.registerCheckRechargeHandler(function(arg_3_0)
		if arg_3_0 == 0 then
			arg_2_0._can_huawei_recharge = true
		else
			print("huawei can not recharge error code: ", arg_3_0)
		end
	end)
	SDKManager.isRechargeReady()
end

function var_0_0.doPayment(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = require("data.recharge_data")[arg_4_1]

	function arg_4_0.payRequestingHandler(arg_5_0)
		if arg_5_0 == 0 then
			TrackingManager.pay(arg_4_2, DeviceManager.platform, "CNY", var_4_0.rmb)
			addWaitingLayer()
		end
	end

	local var_4_1 = {
		productid = var_4_0.productid,
		playerid = require("model.playermodel").playerid
	}

	TrackingManager.order(arg_4_2, "CNY", var_4_0.rmb)
	print("PayInfo: ", var_4_0.productid, json.encode(var_4_1))
	SDKManager.pay(var_4_0.productid, json.encode(var_4_1), var_4_0.name, string.format("%.2f", var_4_0.rmb))
end

return var_0_0

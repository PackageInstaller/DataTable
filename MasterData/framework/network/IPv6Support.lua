module("framework.network.IPv6Support", package.seeall)

local var_0_0 = {}
local var_0_1 = "com.baitian.wrap.IPv6SupportWrap"
local var_0_2 = "onReceiveAvailableIP"

var_0_0.STATUS_OK = 0
var_0_0.STATUS_FAILURE = -1

function var_0_0.adaptIPv6(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_1 == nil then
		arg_1_1 = 80
	end

	NativeBridge.instance:registerListener(var_0_2, function(arg_2_0)
		if arg_2_0.statusCode == var_0_0.STATUS_OK then
			arg_1_2(arg_2_0.address)
		else
			arg_1_3()
		end

		NativeBridge.instance:unregisterListener(var_0_2)
	end)

	local var_1_0 = {
		address = arg_1_0,
		port = arg_1_1
	}

	NativeBridge.instance:invoke(var_0_1, "adaptIPv6", var_1_0)
end

return var_0_0

Layer = var_0_10000
rawget = var_0_10001
setmetatable = var_0_10002

local var_0_0 = {}

function var_0_0.__index(arg_1_0, arg_1_1)
	return var_0_10001(var_0_0, arg_1_1)
end

function var_0_0.__call(arg_2_0, arg_2_1)
	return var_0_10002({
		value = arg_2_1 or 0
	}, var_0_0)
end

function var_0_0.New(arg_3_0)
	return var_0_10002({
		value = arg_3_0 or 0
	}, var_0_0)
end

function var_0_0.Get(arg_4_0)
	return arg_4_0.value
end

function var_0_0.NameToLayer(arg_5_0)
	return var_0_10000[arg_5_0]
end

function var_0_0.GetMask(...)
	local var_6_0 = {
		...
	}
	local var_6_1 = 0

	for iter_6_0 = 1, #var_6_0 do
		if var_0_0.NameToLayer(var_6_0[iter_6_0]) ~= nil then
			var_6_1 = var_6_1 + 2^var_6
		end
	end

	return var_6_1
end

UnityEngine = var_4
var_4.LayerMask = var_0_0

var_0_10002(var_0_0, var_0_0)

return var_0_0

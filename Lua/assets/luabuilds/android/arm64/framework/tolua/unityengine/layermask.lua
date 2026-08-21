local var_0_0 = Layer
local var_0_1 = rawget
local var_0_2 = setmetatable
local var_0_3 = {}

;({}).__index = function(arg_1_0, arg_1_1)
	return var_0_1(var_0_3, arg_1_1)
end
;({}).__call = function(arg_2_0, arg_2_1)
	return var_0_2({
		value = arg_2_1 or 0
	}, var_0_3)
end
;({}).New = function(arg_3_0)
	return var_0_2({
		value = arg_3_0 or 0
	}, var_0_3)
end
;({}).Get = function(arg_4_0)
	return arg_4_0.value
end
;({}).NameToLayer = function(arg_5_0)
	return var_0_0[arg_5_0]
end
;({}).GetMask = function(...)
	local var_6_0 = {
		...
	}
	local var_6_1 = 0

	for iter_6_0 = 1, #var_6_0 do
		local var_6_2 = var_0_3.NameToLayer(var_6_0[iter_6_0])

		if var_6_2 ~= nil then
			var_6_1 = var_6_1 + 2^var_6_2
		end
	end

	return var_6_1
end
UnityEngine.LayerMask = {}

setmetatable({}, {})

return {}

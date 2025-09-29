module("framework.datastruct.ObscuredNumber", package.seeall)

local var_0_0 = {}
local var_0_1 = "value"
local var_0_2 = {
	__add = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_0.value + arg_1_1.value

		return var_0_0.New(var_1_0)
	end,
	__sub = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0.value - arg_2_1.value

		return var_0_0.New(var_2_0)
	end,
	__mul = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0.value * arg_3_1.value

		return var_0_0.New(var_3_0)
	end,
	__div = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.value / arg_4_1.value

		return var_0_0.New(var_4_0)
	end,
	__unm = function(arg_5_0)
		return var_0_0.New(-arg_5_0.value)
	end,
	__eq = function(arg_6_0, arg_6_1)
		return arg_6_0.value == arg_6_1.value
	end,
	__lt = function(arg_7_0, arg_7_1)
		return arg_7_0.value < arg_7_1.value
	end,
	__le = function(arg_8_0, arg_8_1)
		return arg_8_0.value <= arg_8_1.value
	end,
	__index = function(arg_9_0, arg_9_1)
		if arg_9_1 == var_0_1 then
			return arg_9_0._value - arg_9_0._randomValue
		end

		return nil
	end,
	__newindex = function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_1 == var_0_1 then
			arg_10_0._value = arg_10_2 + arg_10_0._randomValue
		end
	end,
	__tostring = function(arg_11_0)
		return tostring(arg_11_0._value - arg_11_0._randomValue)
	end
}

function var_0_0.New(arg_12_0)
	local var_12_0 = {
		_randomValue = math.random() * 12345
	}

	var_12_0._value = var_12_0._randomValue + (arg_12_0 or 0)

	setmetatable(var_12_0, var_0_2)

	var_12_0.clone = var_0_0.Clone

	return var_12_0
end

function var_0_0.Clone(arg_13_0)
	return var_0_0.New(arg_13_0.value)
end

return var_0_0

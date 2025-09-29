local var_0_0 = setmetatable
local var_0_1 = table
local var_0_2 = rawset
local var_0_3 = error

module("protobuf.containers")

local var_0_4 = {
	add = function(arg_1_0)
		local var_1_0 = arg_1_0._message_descriptor._concrete_class()
		local var_1_1 = arg_1_0._listener

		var_0_2(arg_1_0, #arg_1_0 + 1, var_1_0)
		var_1_0:_SetListener(var_1_1)

		if var_1_1.dirty == false then
			var_1_1:Modified()
		end

		return var_1_0
	end,
	remove = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0._listener

		var_0_1.remove(arg_2_0, arg_2_1)
		var_2_0:Modified()
	end,
	__newindex = function(arg_3_0, arg_3_1, arg_3_2)
		var_0_3("RepeatedCompositeFieldContainer Can't set value directly")
	end
}

var_0_4.__index = var_0_4

function RepeatedCompositeFieldContainer(arg_4_0, arg_4_1)
	local var_4_0 = {
		_listener = arg_4_0,
		_message_descriptor = arg_4_1
	}

	return var_0_0(var_4_0, var_0_4)
end

local var_0_5 = {
	append = function(arg_5_0, arg_5_1)
		arg_5_0._type_checker(arg_5_1)
		var_0_2(arg_5_0, #arg_5_0 + 1, arg_5_1)
		arg_5_0._listener:Modified()
	end,
	remove = function(arg_6_0, arg_6_1)
		var_0_1.remove(arg_6_0, arg_6_1)
		arg_6_0._listener:Modified()
	end,
	__newindex = function(arg_7_0, arg_7_1, arg_7_2)
		var_0_3("RepeatedCompositeFieldContainer Can't set value directly")
	end
}

var_0_5.__index = var_0_5

function RepeatedScalarFieldContainer(arg_8_0, arg_8_1)
	local var_8_0 = {
		_listener = arg_8_0,
		_type_checker = arg_8_1
	}

	return var_0_0(var_8_0, var_0_5)
end

local var_0_0 = setmetatable
local var_0_1 = table
local var_0_2 = rawset
local var_0_3 = error

module("protobuf.containers")

local var_0_4 = {
	add = function(self)
		local var_1_0 = self._message_descriptor._concrete_class()

		var_0_2(self, #self + 1, var_1_0)
		var_1_0:_SetListener(self._listener)

		if self._listener.dirty == false then
			self._listener:Modified()
		end

		return var_1_0
	end,
	remove = function(self, arg_2_1)
		var_0_1.remove(self, arg_2_1)
		self._listener:Modified()

		return
	end,
	__newindex = function(arg_3_0, arg_3_1, arg_3_2)
		var_0_3("RepeatedCompositeFieldContainer Can't set value directly")

		return
	end
}

var_0_4.__index = var_0_4

function RepeatedCompositeFieldContainer(arg_4_0, arg_4_1)
	return var_0_0({
		_listener = arg_4_0,
		_message_descriptor = arg_4_1
	}, var_0_4)
end

local var_0_5 = {
	append = function(self, arg_5_1)
		self._type_checker(arg_5_1)
		var_0_2(self, #self + 1, arg_5_1)
		self._listener:Modified()

		return
	end,
	remove = function(self, arg_6_1)
		var_0_1.remove(self, arg_6_1)
		self._listener:Modified()

		return
	end,
	__newindex = function(arg_7_0, arg_7_1, arg_7_2)
		var_0_3("RepeatedCompositeFieldContainer Can't set value directly")

		return
	end
}

var_0_5.__index = var_0_5

function RepeatedScalarFieldContainer(arg_8_0, arg_8_1)
	return var_0_0({
		_listener = arg_8_0,
		_type_checker = arg_8_1
	}, var_0_5)
end

return

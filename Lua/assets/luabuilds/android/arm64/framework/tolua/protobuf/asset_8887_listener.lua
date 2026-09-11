local var_0_0 = setmetatable

module("protobuf.listener")

local var_0_1 = {
	Modified = function()
		return
	end
}

function NullMessageListener()
	return var_0_1
end

local var_0_2 = {
	Modified = function(self)
		if self.dirty then
			return
		end

		if self._parent_message then
			self._parent_message:_Modified()
		end

		return
	end
}

var_0_2.__index = var_0_2

function Listener(arg_4_0)
	local var_4_0 = {}

	var_4_0.__mode = "v"
	var_4_0._parent_message = arg_4_0
	var_4_0.dirty = false

	return var_0_0(var_4_0, var_0_2)
end

return

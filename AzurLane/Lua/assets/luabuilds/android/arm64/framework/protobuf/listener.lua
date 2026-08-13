setmetatable = var_0_10000
module = var_0_10001

var_0_10001("listener")

local var_0_0 = {
	Modified = function()
		return
	end
}

local function var_0_1()
	return var_0_0
end

local var_0_2 = NullMessageListener

var_2.__index = {
	Modified = function(arg_3_0)
		if arg_3_0.dirty then
			return
		end

		if arg_3_0._parent_message then
			local var_3_0 = arg_3_0._parent_message

			var_1._Modified(var_3_0)
		end

		return
	end
}

local function var_0_3(arg_4_0)
	local var_4_0 = {}

	var_4_0.__mode = "v"
	var_4_0._parent_message = arg_4_0
	var_4_0.dirty = false

	return var_0_10000(var_4_0, var_0)
end

local var_0_4 = Listener

return

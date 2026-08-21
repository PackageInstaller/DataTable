local var_0_0 = setmetatable
local var_0_1 = {
	__index = {}
}

;({}).New = function()
	return var_0_0({
		first = 1,
		last = 0,
		data = {},
		data_position = {}
	}, var_0_1)
end

local function var_0_2(arg_2_0)
	while arg_2_0.first <= arg_2_0.last do
		if arg_2_0.data[arg_2_0.first] then
			return true
		end

		arg_2_0.first = arg_2_0.first + 1
	end

	return
end

;({}).is_empty = function(arg_3_0)
	return arg_3_0.first > arg_3_0.last
end
;({}).push_front = function(arg_4_0, arg_4_1)
	if arg_4_0.data_position[arg_4_1] then
		return
	end

	arg_4_0.first = arg_4_0.first - 1
	arg_4_0.data[arg_4_0.first] = arg_4_1
	arg_4_0.data_position[arg_4_1] = arg_4_0.first

	return
end
;({}).push_back = function(arg_5_0, arg_5_1)
	if arg_5_0.data_position[arg_5_1] then
		return
	end

	arg_5_0.last = arg_5_0.last + 1
	arg_5_0.data[arg_5_0.last] = arg_5_1
	arg_5_0.data_position[arg_5_1] = arg_5_0.last

	return
end
;({}).get_iterator = function(arg_6_0)
	local var_6_0 = arg_6_0.first

	return function()
		while var_6_0 <= arg_6_0.last do
			var_6_0 = var_6_0 + 1

			if arg_6_0.data[var_6_0] then
				return arg_6_0.data[var_6_0]
			end
		end

		return
	end
end
;({}).remove = function(arg_8_0, arg_8_1)
	if not arg_8_0.data_position[arg_8_1] then
		return
	end

	arg_8_0.data[arg_8_0.data_position[arg_8_1]] = nil
	arg_8_0.data_position[arg_8_1] = nil

	var_0_2(arg_8_0)

	return
end

return {}

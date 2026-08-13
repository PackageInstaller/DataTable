setmetatable = var_0_10000

local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {
	__index = var_0_1
}

function var_0_0.New()
	return var_0_10000({
		first = 1,
		last = 0,
		data = {},
		data_position = {}
	}, var_0_2)
end

local function var_0_3(arg_2_0)
	while arg_2_0.first <= arg_2_0.last do
		if arg_2_0.data[arg_2_0.first] then
			return true
		end

		arg_2_0.first = arg_2_0.first + 1
	end

	return
end

function var_0_1.is_empty(arg_3_0)
	return arg_3_0.first > arg_3_0.last
end

function var_0_1.push_front(arg_4_0, arg_4_1)
	if arg_4_0.data_position[arg_4_1] then
		return
	end

	arg_4_0.first = arg_4_0.first - 1
	arg_4_0.data[arg_4_0.first] = arg_4_1
	arg_4_0.data_position[arg_4_1] = arg_4_0.first

	return
end

function var_0_1.push_back(arg_5_0, arg_5_1)
	if arg_5_0.data_position[arg_5_1] then
		return
	end

	arg_5_0.last = arg_5_0.last + 1
	arg_5_0.data[arg_5_0.last] = arg_5_1
	arg_5_0.data_position[arg_5_1] = arg_5_0.last

	return
end

function var_0_1.get_iterator(arg_6_0)
	local var_6_0 = arg_6_0.first

	return function()
		while var_6_0 <= arg_6_0.last do
			local var_7_0 = arg_6_0.data[var_6_0]

			var_6_0 = var_6_0 + 1

			if var_7_0 then
				return var_7_0
			end
		end

		return
	end
end

function var_0_1.remove(arg_8_0, arg_8_1)
	if not arg_8_0.data_position[arg_8_1] then
		return
	end

	arg_8_0.data[arg_8_0.data_position[arg_8_1]] = nil
	arg_8_0.data_position[arg_8_1] = nil

	var_0_3(arg_8_0)

	return
end

return var_0_0

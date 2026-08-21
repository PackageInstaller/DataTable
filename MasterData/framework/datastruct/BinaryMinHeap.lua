module("framework.datastruct.BinaryMinHeap", package.seeall)

function ternary(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0 then
		return arg_1_1
	end

	return arg_1_2
end

local var_0_0 = {
	new = function(arg_2_0)
		local var_2_0 = {}

		arg_2_0.__index = arg_2_0
		arg_2_0._data = {}
		arg_2_0._size = 0

		return setmetatable(var_2_0, arg_2_0)
	end,
	get_minimum = function(arg_3_0)
		if arg_3_0._size == 1 then
			return nil
		end

		return arg_3_0._data[1]
	end,
	add = function(arg_4_0, arg_4_1)
		arg_4_0._size = arg_4_0._size + 1
		arg_4_0._data[arg_4_0._size] = arg_4_1

		arg_4_0:_sift_up(arg_4_0._size)

		return true
	end,
	_sift_up = function(arg_5_0, arg_5_1)
		if arg_5_1 == 1 then
			return
		end

		local var_5_0 = math.floor(arg_5_1 / 2)

		if arg_5_0._data[var_5_0] < arg_5_0._data[arg_5_1] then
			return
		end

		arg_5_0._data[var_5_0], arg_5_0._data[arg_5_1] = arg_5_0._data[arg_5_1], arg_5_0._data[var_5_0]

		arg_5_0:_sift_up(var_5_0)
	end,
	remove_min = function(arg_6_0)
		if arg_6_0._size == 0 then
			return false
		end

		arg_6_0._data[1] = arg_6_0._data[arg_6_0._size]
		arg_6_0._data[arg_6_0._size] = nil
		arg_6_0._size = arg_6_0._size - 1

		if arg_6_0._size > 1 then
			arg_6_0:_sift_down(1)
		end

		return true
	end,
	_sift_down = function(arg_7_0, arg_7_1)
		local var_7_0 = ternary(arg_7_1 == 1, 2, arg_7_1 + 2)
		local var_7_1 = ternary(arg_7_1 == 1, 3, arg_7_1 + 3)
		local var_7_2

		if var_7_1 > arg_7_0._size then
			if var_7_0 > arg_7_0._size then
				return
			end

			var_7_2 = var_7_0
		elseif arg_7_0._data[var_7_0] < arg_7_0._data[var_7_1] then
			var_7_2 = var_7_0
		else
			var_7_2 = var_7_1
		end

		if arg_7_0._data[arg_7_1] < arg_7_0._data[var_7_2] then
			return
		end

		arg_7_0._data[var_7_2], arg_7_0._data[arg_7_1] = arg_7_0._data[arg_7_1], arg_7_0._data[var_7_2]

		arg_7_0:_sift_down(var_7_2)
	end,
	size = function(arg_8_0)
		return arg_8_0._size
	end
}

function var_0_0.create()
	return var_0_0:new()
end

return var_0_0

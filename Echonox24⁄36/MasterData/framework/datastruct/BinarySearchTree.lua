module("framework.datastruct.BinarySearchTree", package.seeall)

local function var_0_0(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0 then
		return arg_1_1
	end

	return arg_1_2
end

local var_0_1 = {
	new = function(arg_2_0)
		local var_2_0 = {}

		arg_2_0.__index = arg_2_0
		arg_2_0._root = nil

		return setmetatable(var_2_0, arg_2_0)
	end,
	is_root = function(arg_3_0, arg_3_1)
		return arg_3_0._root.value == arg_3_1
	end,
	is_leaf = function(arg_4_0, arg_4_1)
		local var_4_0 = false
		local var_4_1 = arg_4_0._root

		while var_4_0 == false and var_4_1 ~= nil do
			if arg_4_1 < var_4_1.value then
				var_4_1 = var_4_1.left
			elseif arg_4_1 > var_4_1.value then
				var_4_1 = var_4_1.right
			else
				var_4_0 = true
			end
		end

		return var_4_0 and var_4_1.left == nil and var_4_1.right == nil
	end,
	_create_node = function(arg_5_0, arg_5_1)
		return {
			value = arg_5_1
		}
	end,
	add = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:_create_node(arg_6_1)

		if arg_6_0._root == nil then
			arg_6_0._root = var_6_0

			return true
		end

		local var_6_1 = arg_6_0._root

		while true do
			if arg_6_1 < var_6_1.value then
				if var_6_1.left == nil then
					var_6_1.left = var_6_0

					return true
				else
					var_6_1 = var_6_1.left
				end
			elseif arg_6_1 > var_6_1.value then
				if var_6_1.right == nil then
					var_6_1.right = var_6_0

					return true
				else
					var_6_1 = var_6_1.right
				end
			else
				return false
			end
		end
	end,
	contains = function(arg_7_0, arg_7_1)
		local var_7_0 = false
		local var_7_1 = arg_7_0._root

		while not var_7_0 and var_7_1 do
			if arg_7_1 < var_7_1.value then
				var_7_1 = var_7_1.left
			elseif arg_7_1 > var_7_1.value then
				var_7_1 = var_7_1.right
			else
				var_7_0 = true
			end
		end

		return var_7_0
	end,
	remove = function(arg_8_0, arg_8_1)
		local var_8_0 = false
		local var_8_1 = arg_8_0._root
		local var_8_2

		while not var_8_0 and var_8_1 do
			if arg_8_1 < var_8_1.value then
				var_8_2 = var_8_1
				var_8_1 = var_8_1.left
			elseif arg_8_1 > var_8_1.value then
				var_8_2 = var_8_1
				var_8_1 = var_8_1.right
			else
				var_8_0 = true
			end
		end

		if not var_8_0 then
			return false
		end

		local var_8_3 = var_0_0(var_8_1.left ~= nil, 1, 0) + var_0_0(var_8_1.right ~= nil, 1, 0)

		if var_8_1 == arg_8_0._root then
			if var_8_3 == 0 then
				arg_8_0._root = nil

				return true
			end

			if var_8_3 == 1 then
				arg_8_0._root = var_0_0(var_8_1.right == nil, var_8_1.left, var_8_1.right)

				return true
			end

			if var_8_3 == 2 then
				local var_8_4 = arg_8_0._root.left
				local var_8_5

				while var_8_4.right ~= nil do
					var_8_5 = var_8_4
					var_8_4 = var_8_4.right
				end

				if var_8_5 ~= nil then
					var_8_5.right = var_8_4.left
					var_8_4.right = arg_8_0._root.right
					var_8_4.left = arg_8_0._root.left
				else
					var_8_4.right = arg_8_0._root.right
				end

				arg_8_0._root = var_8_4

				return true
			end
		else
			if var_8_3 == 0 then
				if var_8_1.value < var_8_2.value then
					var_8_2.left = nil
				else
					var_8_2.right = nil
				end

				return true
			end

			if var_8_3 == 1 then
				if var_8_1.value < var_8_2.value then
					var_8_2.left = var_0_0(var_8_1.left == nil, var_8_1.right, var_8_1.left)
				else
					var_8_2.right = var_0_0(var_8_1.left == nil, var_8_1.right, var_8_1.left)
				end

				return true
			end

			if var_8_3 == 2 then
				replacement = var_8_1.left
				replacement_parent = var_8_1

				while replacement.right ~= nil do
					replacement_parent = replacement
					replacement = replacement.right
				end

				replacement_parent.right = replacement.left
				replacement.right = var_8_1.right
				replacement.left = var_8_1.left

				if var_8_1.value < var_8_2.value then
					var_8_2.left = replacement
				else
					var_8_2.right = replacement
				end
			end

			return true
		end
	end,
	size = function(arg_9_0)
		local var_9_0 = 0

		arg_9_0:traverse(function()
			var_9_0 = var_9_0 + 1
		end)

		return var_9_0
	end,
	destroy = function(arg_11_0)
		arg_11_0:traverse(function(arg_12_0)
			arg_11_0:remove(arg_12_0.value)
		end)

		return true
	end,
	get_smallest = function(arg_13_0)
		function _find(arg_14_0)
			local var_14_0 = arg_14_0

			while var_14_0.left ~= nil do
				var_14_0 = var_14_0.left
			end

			return var_14_0.value
		end

		return _find(arg_13_0._root, 0)
	end,
	get_biggest = function(arg_15_0)
		function _find(arg_16_0)
			local var_16_0 = arg_16_0

			while var_16_0.right ~= nil do
				var_16_0 = var_16_0.right
			end

			return var_16_0.value
		end

		return _find(arg_15_0._root, 0)
	end,
	_max_depth = function(arg_17_0, arg_17_1)
		if arg_17_1 == nil then
			return 0
		end

		return 1 + math.max(arg_17_0:_max_depth(arg_17_1.left), arg_17_0:_max_depth(arg_17_1.right))
	end,
	_min_depth = function(arg_18_0, arg_18_1)
		if arg_18_1 == nil then
			return 0
		end

		return 1 + math.min(arg_18_0:_min_depth(arg_18_1.left), arg_18_0:_min_depth(arg_18_1.right))
	end,
	is_balanced = function(arg_19_0)
		return arg_19_0:_max_depth(arg_19_0._root) - arg_19_0:_min_depth(arg_19_0._root) <= 1
	end,
	in_order = function(arg_20_0, arg_20_1)
		function _in_order(arg_21_0)
			if arg_21_0 == nil then
				return
			end

			_in_order(arg_21_0.left)
			arg_20_1(arg_21_0)
			_in_order(arg_21_0.right)
		end

		_in_order(arg_20_0._root)
	end,
	pre_order = function(arg_22_0, arg_22_1)
		function _pre_order(arg_23_0)
			if arg_23_0 == nil then
				return
			end

			arg_22_1(arg_23_0)
			_pre_order(arg_23_0.left)
			_pre_order(arg_23_0.right)
		end

		_pre_order(arg_22_0._root)
	end,
	post_order = function(arg_24_0, arg_24_1)
		function _post_order(arg_25_0)
			if arg_25_0 == nil then
				return
			end

			_post_order(arg_25_0.left)
			_post_order(arg_25_0.right)
			arg_24_1(arg_25_0)
		end

		_post_order(arg_24_0._root)
	end,
	traverse = function(arg_26_0, arg_26_1)
		arg_26_0:in_order(arg_26_1)
	end
}

function var_0_1.create()
	return var_0_1:new()
end

return var_0_1

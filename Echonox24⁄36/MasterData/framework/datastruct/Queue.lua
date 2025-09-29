module("framework.datastruct.Queue", package.seeall)

local var_0_0 = {
	new = function(arg_1_0)
		local var_1_0 = {}

		arg_1_0.__index = arg_1_0
		arg_1_0._head = nil
		arg_1_0._tail = nil
		arg_1_0._size = 0

		return setmetatable(var_1_0, arg_1_0)
	end,
	_create_node = function(arg_2_0, arg_2_1)
		return {
			item = arg_2_1
		}
	end,
	enqueue = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:_create_node(arg_3_1)

		if arg_3_0._head == nil then
			arg_3_0._head = var_3_0
		else
			arg_3_0._tail.node_next = var_3_0
		end

		arg_3_0._tail = var_3_0
		arg_3_0._size = arg_3_0._size + 1
	end,
	dequeue = function(arg_4_0)
		if arg_4_0:is_empty() then
			return nil
		end

		arg_4_0._size = arg_4_0._size - 1

		local var_4_0 = arg_4_0._head.item

		arg_4_0._head = arg_4_0._head.node_next

		if arg_4_0:is_empty() then
			arg_4_0._tail = nil
		end

		return var_4_0
	end,
	is_empty = function(arg_5_0)
		return arg_5_0._size == 0
	end,
	size = function(arg_6_0)
		return arg_6_0._size
	end,
	clear = function(arg_7_0)
		arg_7_0._head = nil
		arg_7_0._tail = nil
		arg_7_0._size = 0
	end
}

function var_0_0.create()
	return var_0_0:new()
end

return var_0_0

module("framework.datastruct.DoublyLinkedList", package.seeall)

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
			data = arg_2_1
		}
	end,
	add_last = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:_create_node(arg_3_1)

		if arg_3_0._head == nil then
			arg_3_0._head = var_3_0
		else
			arg_3_0._tail.node_next = var_3_0
			var_3_0.node_prev = arg_3_0._tail
		end

		arg_3_0._tail = var_3_0
		arg_3_0._size = arg_3_0._size + 1
	end,
	add_first = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0:_create_node(arg_4_1)

		if arg_4_0._head == nil then
			arg_4_0._tail = var_4_0
		else
			var_4_0.node_next = arg_4_0._head
			arg_4_0._head.node_prev = var_4_0
		end

		arg_4_0._head = var_4_0
		arg_4_0._size = arg_4_0._size + 1
	end,
	item = function(arg_5_0, arg_5_1)
		if arg_5_1 > -1 and arg_5_1 < arg_5_0._size then
			local var_5_0 = arg_5_0._head
			local var_5_1 = 0

			while var_5_1 < arg_5_1 do
				var_5_0 = var_5_0.node_next
				var_5_1 = var_5_1 + 1
			end

			return var_5_0.data
		else
			return nil
		end
	end,
	remove_first = function(arg_6_0)
		return arg_6_0:remove(0)
	end,
	remove_last = function(arg_7_0)
		return arg_7_0:remove(arg_7_0._size - 1)
	end,
	remove = function(arg_8_0, arg_8_1)
		if arg_8_1 > -1 and arg_8_1 < arg_8_0._size then
			local var_8_0 = arg_8_0._head
			local var_8_1 = 0

			if arg_8_1 == 0 then
				arg_8_0._head = var_8_0.node_next

				if arg_8_0._head == nil then
					arg_8_0.tail = nil
				else
					arg_8_0._head.node_prev = nil
				end
			elseif arg_8_1 == arg_8_0._size - 1 then
				var_8_0 = arg_8_0._tail
				arg_8_0._tail = var_8_0.node_prev
				var_8_0.node_next = nil
			else
				while var_8_1 < arg_8_1 do
					var_8_0 = var_8_0.node_next
					var_8_1 = var_8_1 + 1
				end

				var_8_0.node_prev.node_next = var_8_0.node_next
				var_8_0.node_next.node_prev = var_8_0.node_prev
			end

			arg_8_0._size = arg_8_0._size - 1

			return var_8_0.data
		else
			return nil
		end
	end,
	remove_by_data = function(arg_9_0, arg_9_1)
		if arg_9_0._head == nil then
			return
		end

		if arg_9_0._head.data == arg_9_1 then
			arg_9_0._head = arg_9_0._head.node_next
			arg_9_0._size = arg_9_0._size - 1

			return
		end

		local var_9_0 = arg_9_0._head

		while var_9_0.node_next do
			if var_9_0.node_next.data == arg_9_1 then
				local var_9_1 = var_9_0.node_next.node_prev

				if var_9_0.node_next.node_next == nil then
					var_9_1.node_next = nil
				else
					var_9_0.node_next = var_9_0.node_next.node_next
					var_9_0.node_next.node_prev = var_9_1
					var_9_1.node_next = var_9_0.node_next
				end

				arg_9_0._size = arg_9_0._size - 1

				return
			end

			var_9_0 = var_9_0.node_next
		end
	end,
	size = function(arg_10_0)
		return arg_10_0._size
	end
}

function var_0_0.create()
	return var_0_0:new()
end

return var_0_0

local var_0_0 = setmetatable
local var_0_1 = {}

var_0_1.__index = var_0_1

function var_0_1.new(arg_1_0)
	local var_1_0 = {
		_next = 0,
		length = 0,
		_prev = 0
	}

	var_1_0._prev = var_1_0
	var_1_0._next = var_1_0

	return var_0_0(var_1_0, var_0_1)
end

function var_0_1.clear(arg_2_0)
	arg_2_0._next = arg_2_0
	arg_2_0._prev = arg_2_0
	arg_2_0.length = 0
end

function var_0_1.push(arg_3_0, arg_3_1)
	local var_3_0 = {
		_next = 0,
		removed = false,
		_prev = 0,
		value = arg_3_1
	}

	arg_3_0._prev._next = var_3_0
	var_3_0._next = arg_3_0
	var_3_0._prev = arg_3_0._prev
	arg_3_0._prev = var_3_0
	arg_3_0.length = arg_3_0.length + 1

	return var_3_0
end

function var_0_1.pushnode(arg_4_0, arg_4_1)
	if not arg_4_1.removed then
		return
	end

	arg_4_0._prev._next = arg_4_1
	arg_4_1._next = arg_4_0
	arg_4_1._prev = arg_4_0._prev
	arg_4_0._prev = arg_4_1
	arg_4_1.removed = false
	arg_4_0.length = arg_4_0.length + 1
end

function var_0_1.pop(arg_5_0)
	local var_5_0 = arg_5_0._prev

	arg_5_0:remove(var_5_0)

	return var_5_0.value
end

function var_0_1.unshift(arg_6_0, arg_6_1)
	local var_6_0 = {
		_next = 0,
		removed = false,
		_prev = 0,
		value = arg_6_1
	}

	arg_6_0._next._prev = var_6_0
	var_6_0._prev = arg_6_0
	var_6_0._next = arg_6_0._next
	arg_6_0._next = var_6_0
	arg_6_0.length = arg_6_0.length + 1

	return var_6_0
end

function var_0_1.shift(arg_7_0)
	local var_7_0 = arg_7_0._next

	arg_7_0:remove(var_7_0)

	return var_7_0.value
end

function var_0_1.remove(arg_8_0, arg_8_1)
	if arg_8_1.removed then
		return
	end

	local var_8_0 = arg_8_1._prev
	local var_8_1 = arg_8_1._next

	var_8_1._prev = var_8_0
	var_8_0._next = var_8_1
	arg_8_0.length = math.max(0, arg_8_0.length - 1)
	arg_8_1.removed = true
end

function var_0_1.find(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or arg_9_0

	repeat
		if arg_9_1 == arg_9_2.value then
			return arg_9_2
		else
			arg_9_2 = arg_9_2._next
		end
	until arg_9_2 == arg_9_0

	return nil
end

function var_0_1.findlast(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or arg_10_0

	repeat
		if arg_10_1 == arg_10_2.value then
			return arg_10_2
		end

		arg_10_2 = arg_10_2._prev
	until arg_10_2 == arg_10_0

	return nil
end

function var_0_1.next(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1._next

	if var_11_0 ~= arg_11_0 then
		return var_11_0, var_11_0.value
	end

	return nil
end

function var_0_1.prev(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1._prev

	if var_12_0 ~= arg_12_0 then
		return var_12_0, var_12_0.value
	end

	return nil
end

function var_0_1.erase(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:find(arg_13_1)

	if var_13_0 then
		arg_13_0:remove(var_13_0)
	end
end

function var_0_1.insert(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_2 then
		return arg_14_0:push(arg_14_1)
	end

	local var_14_0 = {
		_next = 0,
		removed = false,
		_prev = 0,
		value = arg_14_1
	}

	if arg_14_2._next then
		arg_14_2._next._prev = var_14_0
		var_14_0._next = arg_14_2._next
	else
		arg_14_0.last = var_14_0
	end

	var_14_0._prev = arg_14_2
	arg_14_2._next = var_14_0
	arg_14_0.length = arg_14_0.length + 1

	return var_14_0
end

function var_0_1.head(arg_15_0)
	return arg_15_0._next.value
end

function var_0_1.tail(arg_16_0)
	return arg_16_0._prev.value
end

function var_0_1.clone(arg_17_0)
	local var_17_0 = var_0_1:new()

	for iter_17_0, iter_17_1 in var_0_1.next, arg_17_0, arg_17_0 do
		var_17_0:push(iter_17_1)
	end

	return var_17_0
end

function ilist(arg_18_0)
	return var_0_1.next, arg_18_0, arg_18_0
end

function rilist(arg_19_0)
	return var_0_1.prev, arg_19_0, arg_19_0
end

var_0_0(var_0_1, {
	__call = var_0_1.new
})

return var_0_1

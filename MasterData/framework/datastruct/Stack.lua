module("framework.datastruct.Stack", package.seeall)

local var_0_0 = class("Stack")

function var_0_0.ctor(arg_1_0)
	arg_1_0._stack = {}
end

function var_0_0.push(arg_2_0, arg_2_1)
	table.insert(arg_2_0._stack, arg_2_1)
end

function var_0_0.peek(arg_3_0)
	if #arg_3_0._stack == 0 then
		return nil
	end

	return arg_3_0._stack[#arg_3_0._stack]
end

function var_0_0.pop(arg_4_0)
	if #arg_4_0._stack == 0 then
		return nil
	end

	return table.remove(arg_4_0._stack, #arg_4_0._stack)
end

function var_0_0.isEmpty(arg_5_0)
	return #arg_5_0._stack == 0
end

function var_0_0.clear(arg_6_0)
	for iter_6_0 = arg_6_0:getSize(), 1, -1 do
		table.remove(arg_6_0._stack, iter_6_0)
	end
end

function var_0_0.getSize(arg_7_0)
	return #arg_7_0._stack
end

return var_0_0

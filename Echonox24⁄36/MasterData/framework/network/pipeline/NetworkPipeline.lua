module("framework.network.pipeline.NetworkPipeline", package.seeall)

local var_0_0 = class("NetworkPipeline")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._netMgr = arg_1_1
	arg_1_0._map = {}
	arg_1_0._count = 0
	arg_1_0._head = NetworkHeadHandler.New(arg_1_1, false, true)
	arg_1_0._tail = NetworkTailHandler.New(arg_1_1, true, false)
	arg_1_0._head._next = arg_1_0._tail
	arg_1_0._tail._pre = arg_1_0._head
	arg_1_0._head._pipeline = arg_1_0
	arg_1_0._tail._pipeline = arg_1_0

	arg_1_0._head:onAdded()
	arg_1_0._tail:onAdded()
end

function var_0_0.getManager(arg_2_0)
	return arg_2_0._netMgr
end

function var_0_0.getCount(arg_3_0)
	return arg_3_0._count
end

function var_0_0.contains(arg_4_0, arg_4_1)
	if arg_4_1 == arg_4_0._head or arg_4_1 == arg_4_0._tail then
		return true
	end

	if arg_4_0._map[arg_4_1] then
		return true
	end

	return false
end

function var_0_0.addFilter(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	(arg_5_1 and arg_5_0._head or arg_5_0._tail):addFilter(arg_5_3, arg_5_4, arg_5_2)
end

function var_0_0.getHandler(arg_6_0, arg_6_1)
	return arg_6_0._map[arg_6_1]
end

function var_0_0.addFirst(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0:_doAdd(var_0_1, nil, arg_7_1, arg_7_2)
end

function var_0_0.addLast(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0:_doAdd(var_0_2, nil, arg_8_1, arg_8_2)
end

function var_0_0.addBefore(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	return arg_9_0:_doAdd(var_0_3, arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.addBeforeName(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getHandler(arg_10_1)

	if not var_10_0 then
		return false
	end

	return arg_10_0:_doAdd(var_0_3, var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.addAfter(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return arg_11_0:_doAdd(var_0_4, arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0.addAfterName(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getHandler(arg_12_1)

	if not var_12_0 then
		return false
	end

	return arg_12_0:_doAdd(var_0_4, var_12_0, arg_12_2, arg_12_3)
end

function var_0_0._doAdd(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_0:contains(arg_13_3) then
		return false
	end

	if arg_13_4 and arg_13_0:contains(arg_13_4) then
		return false
	end

	local var_13_0
	local var_13_1

	if arg_13_1 == var_0_1 then
		var_13_0 = arg_13_0._head
		var_13_1 = arg_13_0._head._next
	elseif arg_13_1 == var_0_2 then
		var_13_0 = arg_13_0._tail._pre
		var_13_1 = arg_13_0._tail
	elseif arg_13_1 == var_0_3 then
		var_13_1 = arg_13_2
		var_13_0 = arg_13_2._pre
	elseif arg_13_1 == var_0_4 then
		var_13_0 = arg_13_2
		var_13_1 = arg_13_2._next
	else
		printError("M:_doAdd -> not supported:", arg_13_1)

		return false
	end

	arg_13_3._pre = var_13_0
	arg_13_3._next = var_13_1

	if var_13_0 then
		var_13_0._next = arg_13_3
	end

	if var_13_1 then
		var_13_1._pre = arg_13_3
	end

	arg_13_3._pipeline = arg_13_0
	arg_13_0._map[arg_13_3] = arg_13_4 or true

	if arg_13_4 then
		arg_13_0._map[arg_13_4] = arg_13_3
	end

	arg_13_0._count = arg_13_0._count + 1

	arg_13_3:onAdded()

	return true
end

function var_0_0.removeByName(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getHandler(arg_14_1)

	if not var_14_0 then
		return false
	end

	return arg_14_0:remove(var_14_0)
end

function var_0_0.remove(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0._head or arg_15_1 == arg_15_0._tail then
		return false
	end

	if not arg_15_0:contains(arg_15_1) then
		return false
	end

	local var_15_0 = arg_15_1._pre
	local var_15_1 = arg_15_1._next
	local var_15_2 = arg_15_0._map[arg_15_1]

	if var_15_2 and var_15_2 ~= true then
		arg_15_0._map[var_15_2] = nil
	end

	arg_15_0._map[arg_15_1] = nil
	arg_15_1._pipeline = nil
	arg_15_0._count = arg_15_0._count - 1

	arg_15_1:onRemoved()
end

function var_0_0.clear(arg_16_0)
	while true do
		local var_16_0 = arg_16_0._head._next

		if var_16_0 and var_16_0 ~= arg_16_0._tail then
			arg_16_0:remove(var_16_0)
		else
			break
		end
	end

	arg_16_0._count = 0
end

function var_0_0.send(arg_17_0, ...)
	local var_17_0 = NetworkHandler.findNextOutboundHandler(arg_17_0._tail)

	if not var_17_0 then
		return
	end

	var_17_0:onSend(...)
end

function var_0_0.onReceive(arg_18_0, ...)
	local var_18_0 = NetworkHandler.findNextInboundHandler(arg_18_0._head)

	if not var_18_0 then
		return
	end

	var_18_0:onReceive(...)
end

return var_0_0

module("framework.objectpool.ObjectPool", package.seeall)

local var_0_0 = class("ObjectPool")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._capacity = arg_1_1 or 0
	arg_1_0._objects = {}
	arg_1_0._createFunc = arg_1_2
	arg_1_0._reuseFunc = arg_1_5
	arg_1_0._disposeFunc = arg_1_3
	arg_1_0._resetFunc = arg_1_4
	arg_1_0._createdCount = 0
	arg_1_0._disposedCount = 0
end

function var_0_0.setCapacity(arg_2_0, arg_2_1)
	arg_2_0._capacity = arg_2_1
end

function var_0_0.getObjectCount(arg_3_0)
	return #arg_3_0._objects
end

function var_0_0.getCreatedCount(arg_4_0)
	return arg_4_0._createdCount
end

function var_0_0.getDisposedCount(arg_5_0)
	return arg_5_0._disposedCount
end

function var_0_0.preparePool(arg_6_0, arg_6_1, ...)
	local var_6_0 = math.floor((arg_6_1 or 0.5) * arg_6_0._capacity)
	local var_6_1 = math.max(var_6_0, 1)

	arg_6_0:_preparePool(var_6_1, ...)
end

function var_0_0.fetchObject(arg_7_0, ...)
	local var_7_0 = #arg_7_0._objects
	local var_7_1

	if var_7_0 < 1 then
		var_7_1 = arg_7_0:_createNewObject(...)
	else
		var_7_1 = table.remove(arg_7_0._objects)
	end

	if arg_7_0._reuseFunc then
		arg_7_0._reuseFunc(var_7_1, ...)
	end

	return var_7_1
end

function var_0_0.returnObject(arg_8_0, arg_8_1)
	local var_8_0 = #arg_8_0._objects

	arg_8_0:_resetObject(arg_8_1)

	if var_8_0 >= arg_8_0._capacity then
		arg_8_0:_disposeObject(arg_8_1)
	else
		table.insert(arg_8_0._objects, arg_8_1)
	end
end

function var_0_0._createNewObject(arg_9_0, ...)
	local var_9_0

	if arg_9_0._createFunc ~= nil then
		arg_9_0._createdCount = arg_9_0._createdCount + 1

		arg_9_0:_checkCapacity()

		var_9_0 = arg_9_0._createFunc(...)
	end

	return var_9_0
end

function var_0_0._disposeObject(arg_10_0, arg_10_1)
	if arg_10_0._disposeFunc ~= nil then
		arg_10_0._disposeFunc(arg_10_1)
	end

	arg_10_0._disposedCount = arg_10_0._disposedCount + 1
end

function var_0_0._resetObject(arg_11_0, arg_11_1)
	if arg_11_0._resetFunc ~= nil then
		arg_11_0._resetFunc(arg_11_1)
	end
end

function var_0_0.clear(arg_12_0)
	local var_12_0 = #arg_12_0._objects

	if var_12_0 > 0 then
		local var_12_1

		for iter_12_0 = 1, var_12_0 do
			local var_12_2 = arg_12_0._objects[iter_12_0]

			arg_12_0:_disposeObject(var_12_2)

			arg_12_0._objects[iter_12_0] = nil
		end
	end
end

function var_0_0._preparePool(arg_13_0, arg_13_1, ...)
	for iter_13_0 = #arg_13_0._objects + 1, arg_13_1 do
		arg_13_0:_createNewObject(...)
	end
end

function var_0_0._checkCapacity(arg_14_0)
	if arg_14_0._createdCount >= arg_14_0._capacity and isInEditorMode then
		printWarn("Capacity of the pool is not adequate,capacity,instanceCount", arg_14_0._capacity, arg_14_0._createdCount)
	end
end

return var_0_0

module("framework.notify.DispatcherManager", package.seeall)

local var_0_0 = require("framework.notify.EventDispatcher")
local var_0_1 = {}

function clear()
	for iter_1_0, iter_1_1 in pairs(var_0_1) do
		iter_1_1:clear()
	end

	var_0_1 = {}
end

function getNewId()
	local var_2_0 = UIDUtil.getDispatcherUID()

	var_0_1[var_2_0] = var_0_0.New()

	return var_2_0
end

function clearDispatcher(arg_3_0)
	var_0_1[arg_3_0] = nil
end

function getDispatcher(arg_4_0)
	if not var_0_1[arg_4_0] then
		assert(false, "The Dispatcher id:" .. arg_4_0 .. " is nil, you can create a new instance without params!")

		return nil
	end

	return var_0_1[arg_4_0]
end

function addEventListener(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = getDispatcher(arg_5_0)

	if var_5_0 then
		var_5_0:addEventListener(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	end
end

function removeEventListener(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = getDispatcher(arg_6_0)

	if var_6_0 then
		var_6_0:removeEventListener(arg_6_1, arg_6_2, arg_6_3)
	end
end

function dispatchEvent(arg_7_0, arg_7_1, ...)
	local var_7_0 = getDispatcher(arg_7_0)

	if var_7_0 then
		var_7_0:dispatchEvent(arg_7_1, ...)
	end
end

function hasEventListener(arg_8_0, arg_8_1)
	local var_8_0 = getDispatcher(arg_8_0)

	if var_8_0 then
		return var_8_0:hasEventListener(arg_8_1)
	end

	return false
end

function registDispatcher(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0 or {}) do
		setglobal(iter_9_1, getDispatcher(DispatcherManager.getNewId()))
	end
end

function getSize()
	return table.nums(var_0_1)
end

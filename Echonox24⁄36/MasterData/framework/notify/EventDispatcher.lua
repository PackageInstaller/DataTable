local var_0_0 = class("EventDispatcher")
local var_0_1 = ipairs
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_4 = table.sort

local function var_0_5(arg_1_0, arg_1_1)
	if arg_1_0.priority == arg_1_1.priority then
		return arg_1_0.index < arg_1_1.index
	else
		return arg_1_0.priority > arg_1_1.priority
	end
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.__eventMap__ = {}
end

function var_0_0.clear(arg_3_0)
	arg_3_0.__eventMap__ = {}
end

function var_0_0.addEventListener(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	assert(type(arg_4_1) == "string" or type(arg_4_1) == "number", "Invalid event name of argument 1, need a string or number!")
	assert(type(arg_4_2) == "function", "Invalid listener function!")

	arg_4_4 = arg_4_4 or 0

	assert(type(arg_4_4) == "number", "Invalid priority value, need a int!")

	local var_4_0 = arg_4_0.__eventMap__[arg_4_1]

	if var_4_0 == nil then
		var_4_0 = {
			__isLocked__ = false,
			__index__ = 0,
			__listeners__ = {}
		}
		arg_4_0.__eventMap__[arg_4_1] = var_4_0
	end

	if var_4_0.__isLocked__ then
		if not var_4_0.__operations__ then
			var_4_0.__operations__ = {}
		end

		var_0_2(var_4_0.__operations__, {
			type = 1,
			name = arg_4_1,
			listener = arg_4_2,
			listenerCaller = arg_4_3,
			priority = arg_4_4
		})

		return
	end

	local var_4_1 = false
	local var_4_2 = false

	for iter_4_0, iter_4_1 in var_0_1(var_4_0) do
		if iter_4_1.listener == arg_4_2 and iter_4_1.listenerCaller == arg_4_3 then
			var_4_1 = true

			if iter_4_1.priority ~= arg_4_4 then
				iter_4_1.priority = arg_4_4
				var_4_2 = true
			end

			break
		end
	end

	if not var_4_1 then
		var_4_0.__index__ = var_4_0.__index__ + 1
		var_4_0.__listeners__[arg_4_2] = var_4_0.__listeners__[arg_4_2] or {}

		local var_4_3 = arg_4_3 or 0

		var_4_0.__listeners__[arg_4_2][var_4_3] = (var_4_0.__listeners__[arg_4_2][var_4_3] or 0) + 1

		var_0_2(var_4_0, {
			listener = arg_4_2,
			listenerCaller = arg_4_3,
			priority = arg_4_4,
			index = var_4_0.__index__
		})

		var_4_2 = true
	end

	if var_4_2 and #var_4_0 > 1 then
		var_0_4(var_4_0, var_0_5)
	end
end

function var_0_0.removeEventListener(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	assert(type(arg_5_1) == "string" or type(arg_5_1) == "number", "Invalid event name of argument 1, need a string or number!")
	assert(type(arg_5_2) == "function", "Invalid listener function!")

	local var_5_0 = arg_5_0.__eventMap__[arg_5_1]

	if var_5_0 ~= nil then
		if var_5_0.__isLocked__ then
			if not var_5_0.__operations__ then
				var_5_0.__operations__ = {}
			end

			var_0_2(var_5_0.__operations__, {
				type = 2,
				name = arg_5_1,
				listener = arg_5_2,
				listenerCaller = arg_5_3
			})

			return
		end

		local var_5_1 = arg_5_3 or 0

		var_5_0.__listeners__[arg_5_2] = var_5_0.__listeners__[arg_5_2] or {}

		local var_5_2 = (var_5_0.__listeners__[arg_5_2][var_5_1] or 0) - 1

		var_5_0.__listeners__[arg_5_2][var_5_1] = var_5_2 > 0 and var_5_2 or 0

		local var_5_3 = false

		for iter_5_0 = #var_5_0, 1, -1 do
			local var_5_4 = var_5_0[iter_5_0]

			if var_5_4.listener == arg_5_2 and var_5_4.listenerCaller == arg_5_3 then
				var_0_3(var_5_0, iter_5_0)
			end
		end
	end
end

function var_0_0._isListenerExist(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.__eventMap__[arg_6_1]
	local var_6_1 = arg_6_3 or 0
	local var_6_2 = var_6_0.__listeners__[arg_6_2]

	if var_6_0 and var_6_2 and (var_6_2[var_6_1] or 0) > 0 then
		return true
	end

	return false
end

function var_0_0.dispatchEvent(arg_7_0, arg_7_1, ...)
	assert(type(arg_7_1) == "string" or type(arg_7_1) == "number", "Invalid event name of argument 1, need a string or number!")

	local var_7_0 = arg_7_0.__eventMap__[arg_7_1]

	if var_7_0 ~= nil then
		var_7_0.__isLocked__ = true

		for iter_7_0, iter_7_1 in var_0_1(var_7_0) do
			if arg_7_0:_isListenerExist(arg_7_1, iter_7_1.listener, iter_7_1.listenerCaller) then
				iter_7_1.listener(iter_7_1.listenerCaller, arg_7_1, ...)
			end
		end

		var_7_0.__isLocked__ = false

		if var_7_0.__operations__ then
			for iter_7_2, iter_7_3 in var_0_1(var_7_0.__operations__) do
				if iter_7_3.type == 1 then
					arg_7_0:addEventListener(iter_7_3.name, iter_7_3.listener, iter_7_3.listenerCaller, iter_7_3.priority)
				elseif iter_7_3.type == 2 then
					arg_7_0:removeEventListener(iter_7_3.name, iter_7_3.listener, iter_7_3.listenerCaller, true)
				end
			end

			var_7_0.__operations__ = nil
		end
	end
end

function var_0_0.hasEventListener(arg_8_0, arg_8_1)
	assert(type(arg_8_1) == "string" or type(arg_8_1) == "number", "Invalid event name of argument 1, need a string or number!")

	return arg_8_0.__eventMap__[arg_8_1] ~= nil
end

return var_0_0

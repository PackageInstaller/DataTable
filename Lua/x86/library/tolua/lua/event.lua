local var_0_0 = setmetatable
local var_0_1 = xpcall
local var_0_2 = pcall
local var_0_3 = assert
local var_0_4 = rawget
local var_0_5 = error
local var_0_6 = print
local var_0_7 = table.maxn
local var_0_8 = tolua.traceback
local var_0_9 = ilist
local var_0_10 = {
	__call = function(arg_1_0, ...)
		if jit then
			if arg_1_0.obj == nil then
				return var_0_1(arg_1_0.func, var_0_8, ...)
			else
				return var_0_1(arg_1_0.func, var_0_8, arg_1_0.obj, ...)
			end
		else
			local var_1_0 = {
				...
			}

			if arg_1_0.obj == nil then
				local function var_1_1()
					arg_1_0.func(unpack(var_1_0, 1, var_0_7(var_1_0)))
				end

				return var_0_1(var_1_1, var_0_8)
			else
				local function var_1_2()
					arg_1_0.func(arg_1_0.obj, unpack(var_1_0, 1, var_0_7(var_1_0)))
				end

				return var_0_1(var_1_2, var_0_8)
			end
		end
	end,
	__eq = function(arg_4_0, arg_4_1)
		return arg_4_0.func == arg_4_1.func and arg_4_0.obj == arg_4_1.obj
	end
}

local function var_0_11(arg_5_0, arg_5_1)
	return var_0_0({
		func = arg_5_0,
		obj = arg_5_1
	}, var_0_10)
end

local var_0_12 = {
	__call = function(arg_6_0, ...)
		if arg_6_0.obj == nil then
			return var_0_2(arg_6_0.func, ...)
		else
			return var_0_2(arg_6_0.func, arg_6_0.obj, ...)
		end
	end,
	__eq = function(arg_7_0, arg_7_1)
		return arg_7_0.func == arg_7_1.func and arg_7_0.obj == arg_7_1.obj
	end
}

local function var_0_13(arg_8_0, arg_8_1)
	return var_0_0({
		func = arg_8_0,
		obj = arg_8_1
	}, var_0_12)
end

local var_0_14 = {}

var_0_14.__index = var_0_14

function var_0_14.Add(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.keepSafe then
		arg_9_1 = var_0_11(arg_9_1, arg_9_2)
	else
		arg_9_1 = var_0_13(arg_9_1, arg_9_2)
	end

	if arg_9_0.lock then
		local var_9_0 = {
			_next = 0,
			removed = true,
			_prev = 0,
			value = arg_9_1
		}

		table.insert(arg_9_0.opList, function()
			arg_9_0.list:pushnode(var_9_0)
		end)

		return var_9_0
	else
		return arg_9_0.list:push(arg_9_1)
	end
end

function var_0_14.Remove(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in var_0_9(arg_11_0.list) do
		if iter_11_1.func == arg_11_1 and iter_11_1.obj == arg_11_2 then
			if arg_11_0.lock then
				table.insert(arg_11_0.opList, function()
					arg_11_0.list:remove(iter_11_0)
				end)
			else
				arg_11_0.list:remove(iter_11_0)
			end

			break
		end
	end
end

function var_0_14.CreateListener(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.keepSafe then
		arg_13_1 = var_0_11(arg_13_1, arg_13_2)
	else
		arg_13_1 = var_0_13(arg_13_1, arg_13_2)
	end

	return {
		_next = 0,
		removed = true,
		_prev = 0,
		value = arg_13_1
	}
end

function var_0_14.AddListener(arg_14_0, arg_14_1)
	if arg_14_0.lock then
		table.insert(arg_14_0.opList, function()
			arg_14_0.list:pushnode(arg_14_1)
		end)
	else
		arg_14_0.list:pushnode(arg_14_1)
	end
end

function var_0_14.RemoveListener(arg_16_0, arg_16_1)
	if arg_16_0.lock then
		table.insert(arg_16_0.opList, function()
			arg_16_0.list:remove(arg_16_1)
		end)
	else
		arg_16_0.list:remove(arg_16_1)
	end
end

function var_0_14.Count(arg_18_0)
	return arg_18_0.list.length
end

function var_0_14.Clear(arg_19_0)
	arg_19_0.list:clear()

	arg_19_0.opList = {}
	arg_19_0.lock = false
	arg_19_0.keepSafe = false
	arg_19_0.current = nil
end

function var_0_14.Dump(arg_20_0)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in var_0_9(arg_20_0.list) do
		if iter_20_1.obj then
			var_0_6("update function:", iter_20_1.func, "object name:", iter_20_1.obj.name)
		else
			var_0_6("update function: ", iter_20_1.func)
		end

		var_20_0 = var_20_0 + 1
	end

	var_0_6("all function is:", var_20_0)
end

function var_0_14.__call(arg_21_0, ...)
	local var_21_0 = arg_21_0.list

	arg_21_0.lock = true

	for iter_21_0, iter_21_1 in var_0_9(var_21_0) do
		arg_21_0.current = iter_21_0

		local var_21_1, var_21_2 = iter_21_1(...)

		if not var_21_1 then
			var_21_0:remove(iter_21_0)

			arg_21_0.lock = false

			var_0_5(var_21_2)
		end
	end

	local var_21_3 = arg_21_0.opList

	arg_21_0.lock = false

	for iter_21_2, iter_21_3 in ipairs(var_21_3) do
		iter_21_3()

		var_21_3[iter_21_2] = nil
	end
end

function event(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or false

	return var_0_0({
		lock = false,
		name = arg_22_0,
		keepSafe = arg_22_1,
		opList = {},
		list = list:new()
	}, var_0_14)
end

UpdateBeat = event("Update", true)
LateUpdateBeat = event("LateUpdate", true)
FixedUpdateBeat = event("FixedUpdate", true)
CoUpdateBeat = event("CoUpdate")

local var_0_15 = Time
local var_0_16 = UpdateBeat
local var_0_17 = LateUpdateBeat
local var_0_18 = FixedUpdateBeat
local var_0_19 = CoUpdateBeat

function Update(arg_23_0, arg_23_1)
	var_0_15:SetDeltaTime(arg_23_0, arg_23_1)
	var_0_16()
end

function LateUpdate()
	var_0_17()
	var_0_19()
	var_0_15:SetFrameCount()
end

function FixedUpdate(arg_25_0)
	var_0_15:SetFixedDelta(arg_25_0)
	var_0_18()
end

function PrintEvents()
	var_0_16:Dump()
	var_0_18:Dump()
end

setmetatable = var_0_10000
xpcall = var_0_10001
pcall = var_0_10002
assert = var_0_10003
rawget = var_0_10004
error = var_0_10005
print = var_0_10006
tolua = var_0_10007

local var_0_0 = var_0_10007.traceback

ilist = var_0_10008

local var_0_1 = {
	__call = function(arg_1_0, ...)
		jit = var_1_10001

		if var_1_10001 then
			if arg_1_0.obj == nil then
				return var_0_10001(arg_1_0.func, var_0_0, ...)
			else
				return var_0_10001(arg_1_0.func, var_0_0, arg_1_0.obj, ...)
			end
		else
			packEx = var_1_10001

			local var_1_0 = var_1_10001(...)

			if arg_1_0.obj == nil then
				local function var_1_1()
					local var_2_0 = arg_1_0.func

					unpackEx = var_2_10002

					var_2_0(var_2_10002(var_1_0))

					return
				end

				return var_0_10001(var_1_1, var_0_0)
			else
				local function var_1_2()
					local var_3_0 = arg_1_0.func
					local var_3_1 = arg_1_0.obj

					unpackEx = var_2_10003

					var_3_0(var_3_1, var_2_10003(var_1_0))

					return
				end

				return var_0_10001(var_1_2, var_0_0)
			end
		end

		return
	end,
	__eq = function(arg_4_0, arg_4_1)
		return arg_4_0.func == arg_4_1.func and arg_4_0.obj == arg_4_1.obj
	end
}

local function var_0_2(arg_5_0, arg_5_1)
	return var_0_10000({
		func = arg_5_0,
		obj = arg_5_1
	}, var_0_1)
end

local var_0_3 = {
	__call = function(arg_6_0, ...)
		if arg_6_0.obj == nil then
			return var_0_10002(arg_6_0.func, ...)
		else
			return var_0_10002(arg_6_0.func, arg_6_0.obj, ...)
		end

		return
	end,
	__eq = function(arg_7_0, arg_7_1)
		return arg_7_0.func == arg_7_1.func and arg_7_0.obj == arg_7_1.obj
	end
}

local function var_0_4(arg_8_0, arg_8_1)
	return var_0_10000({
		func = arg_8_0,
		obj = arg_8_1
	}, var_0_3)
end

var_13.__index = {}

function var_13.Add(arg_9_0, arg_9_1, arg_9_2)
	var_0_10003(arg_9_1)

	if arg_9_0.keepSafe then
		arg_9_1 = var_0_2(arg_9_1, arg_9_2)
	else
		arg_9_1 = var_0_4(arg_9_1, arg_9_2)
	end

	if arg_9_0.lock then
		local var_9_0 = {
			_next = 0,
			removed = true,
			_prev = 0,
			value = arg_9_1
		}

		table = var_1_10004

		var_1_10004.insert(arg_9_0.opList, function()
			local var_10_0 = arg_9_0.list

			var_0.pushnode(var_10_0, var_9_0)

			return
		end)

		return var_9_0
	else
		local var_9_1 = arg_9_0.list

		return var_3.push(var_9_1, arg_9_1)
	end

	return
end

function var_13.Remove(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in var_0_10008(arg_11_0.list) do
		if iter_11_1.func == arg_11_1 and iter_11_1.obj == arg_11_2 then
			if arg_11_0.lock then
				table = var_8

				var_8.insert(arg_11_0.opList, function()
					local var_12_0 = arg_11_0.list

					var_0.remove(var_12_0, iter_11_0)

					return
				end)
			else
				local var_11_0 = arg_11_0.list

				var_8.remove(var_11_0, iter_11_0)
			end

			break
		end
	end

	return
end

function var_13.CreateListener(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.keepSafe then
		arg_13_1 = var_0_2(arg_13_1, arg_13_2)
	else
		arg_13_1 = var_0_4(arg_13_1, arg_13_2)
	end

	return {
		_next = 0,
		removed = true,
		_prev = 0,
		value = arg_13_1
	}
end

function var_13.AddListener(arg_14_0, arg_14_1)
	var_0_10003(arg_14_1)

	if arg_14_0.lock then
		table = var_2

		var_2.insert(arg_14_0.opList, function()
			local var_15_0 = arg_14_0.list

			var_0.pushnode(var_15_0, arg_14_1)

			return
		end)
	else
		local var_14_0 = arg_14_0.list

		var_2.pushnode(var_14_0, arg_14_1)
	end

	return
end

function var_13.RemoveListener(arg_16_0, arg_16_1)
	var_0_10003(arg_16_1)

	if arg_16_0.lock then
		table = var_2

		var_2.insert(arg_16_0.opList, function()
			local var_17_0 = arg_16_0.list

			var_0.remove(var_17_0, arg_16_1)

			return
		end)
	else
		local var_16_0 = arg_16_0.list

		var_2.remove(var_16_0, arg_16_1)
	end

	return
end

function var_13.Count(arg_18_0)
	return arg_18_0.list.length
end

function var_13.Clear(arg_19_0)
	local var_19_0 = arg_19_0.list

	var_1.clear(var_19_0)

	arg_19_0.opList = {}
	arg_19_0.lock = false
	arg_19_0.keepSafe = false
	arg_19_0.current = nil

	return
end

function var_13.Dump(arg_20_0)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in var_0_10008(arg_20_0.list) do
		if iter_20_1.obj then
			var_0_10006("update function:", iter_20_1.func, "object name:", iter_20_1.obj.name)
		else
			var_0_10006("update function: ", iter_20_1.func)
		end

		var_20_0 = var_20_0 + 1
	end

	var_0_10006("all function is:", var_20_0)

	return
end

function var_13.__call(arg_21_0, ...)
	local var_21_0 = arg_21_0.list

	arg_21_0.lock = true

	for iter_21_0, iter_21_1 in var_0_10008(var_21_0) do
		arg_21_0.current = iter_21_0

		local var_21_1, var_21_2 = iter_21_1(...)

		if not var_21_1 then
			var_21_0:remove(iter_21_0)

			arg_21_0.lock = false

			var_0_10005(var_21_2)
		end
	end

	local var_21_3 = arg_21_0.opList

	arg_21_0.lock = false
	ipairs = var_4

	for iter_21_2, iter_21_3 in var_4(var_21_3) do
		iter_21_3()

		var_21_3[iter_21_2] = nil
	end

	return
end

local function var_0_5(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or false

	local var_22_0 = var_0_10000
	local var_22_1 = {
		lock = false,
		name = arg_22_0,
		keepSafe = arg_22_1,
		opList = {}
	}

	list = var_5
	var_22_1.list = var_5:new()

	return var_22_0(var_22_1, var_0)
end

event = event

local var_0_6 = var_14("Update", true)

event = UpdateBeat

local var_0_7 = var_14("LateUpdate", true)

event = LateUpdateBeat

local var_0_8 = var_14("FixedUpdate", true)

event = FixedUpdateBeat

local var_0_9 = var_14("CoUpdate")

Time = CoUpdateBeat
UpdateBeat = var_0_10015
LateUpdateBeat = var_16
FixedUpdateBeat = var_17
CoUpdateBeat = var_0_10018

local function var_0_10(arg_23_0, arg_23_1)
	local var_23_0 = var_0

	var_2.SetDeltaTime(var_23_0, arg_23_0, arg_23_1)
	var_0_10015()

	return
end

local var_0_11 = Update

local function var_0_12()
	var_0()
	var_0_10018()

	local var_24_0 = var_0

	var_0.SetFrameCount(var_24_0)

	return
end

local var_0_13 = LateUpdate

local function var_0_14(arg_25_0)
	local var_25_0 = var_0

	var_1.SetFixedDelta(var_25_0, arg_25_0)
	var_0()

	return
end

local var_0_15 = FixedUpdate

local function var_0_16()
	local var_26_0 = var_0_10015

	var_0.Dump(var_26_0)

	local var_26_1 = var_0

	var_0.Dump(var_26_1)

	return
end

local var_0_17 = PrintEvents

return

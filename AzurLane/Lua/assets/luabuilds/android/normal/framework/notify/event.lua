require = var_0_10000
setmetatable = var_0_10001
string = var_0_10002
error = var_0_10003
unpack = var_0_10004

local var_0_0 = var_0_10000("Framework.notify.double-queue")
local var_0_1 = ":"
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {
	__index = var_0_3
}

local function var_0_5()
	return {
		handlers = var_0_0.New(),
		pre_emits = var_0_0.New(),
		post_emits = var_0_0.New(),
		blocked_handlers = {},
		subevents = {}
	}
end

local function var_0_6(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 in var_0_10002.gmatch(arg_2_0, "[^" .. var_0_1 .. "]+") do
		var_2_0[#var_2_0 + 1] = iter_2_0
	end

	return var_2_0
end

local function var_0_7(arg_3_0, arg_3_1)
	local var_3_0 = var_0_6(arg_3_1)
	local var_3_1

	if not arg_3_0.events[var_3_0[1]] then
		var_3_1 = var_0_5()
	end

	arg_3_0.events[var_3_0[1]] = var_3_1

	for iter_3_0 = 2, #var_3_0 do
		local var_3_2

		if not var_3_1.subevents[var_3_0[iter_3_0]] then
			var_3_2 = var_0_5()
		end

		var_3_1.subevents[var_3_0[iter_3_0]] = var_3_2
		var_3_1 = var_3_2
	end

	return var_3_1
end

local function var_0_8(arg_4_0, arg_4_1)
	local var_4_0 = var_0_6(arg_4_1)

	if not arg_4_0.events[var_4_0[1]] then
		return true
	end

	for iter_4_0 = 2, #var_4_0 do
		if not var_4_1.subevents[var_4_0[iter_4_0]] then
			return true
		end

		local var_4_1 = var_8
	end

	return false
end

local function var_0_9(arg_5_0, arg_5_1)
	local var_5_0 = var_0_6(arg_5_1)
	local var_5_1 = 2
	local var_5_2 = arg_5_0.events[var_5_0[1]]

	return function()
		if not var_5_2 then
			return
		end

		local var_6_0 = var_5_2

		if var_5_0[var_5_1] then
			var_5_2 = var_5_2.subevents[var_5_0[var_5_1]]
			var_5_1 = var_5_1 + 1
		else
			var_5_2 = nil
		end

		return var_6_0
	end
end

local function var_0_10(arg_7_0, arg_7_1)
	local var_7_0 = var_0_0.New()
	local var_7_1 = var_0_0.New()

	for iter_7_0 in var_0_9(arg_7_0, arg_7_1) do
		local var_7_2 = iter_7_0.pre_emits

		for iter_7_1 in var_8.get_iterator(var_7_2) do
			iter_7_1(arg_7_1)
		end

		var_7_0:push_back(iter_7_0)
		var_7_1:push_front(iter_7_0)
	end

	return var_7_0, var_7_1
end

local function var_0_11(arg_8_0, arg_8_1)
	for iter_8_0 in arg_8_1:get_iterator() do
		local var_8_0 = iter_8_0.post_emits

		for iter_8_1 in var_6.get_iterator(var_8_0) do
			iter_8_1(arg_8_0)
		end
	end

	return
end

local function var_0_12(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.nodes

	for iter_9_0 in var_2.get_iterator(var_9_0) do
		local var_9_1 = iter_9_0.handlers

		for iter_9_1 in var_6.get_iterator(var_9_1) do
			if arg_9_0.stopped then
				return
			end

			if iter_9_0.blocked_handlers[iter_9_1] == 0 then
				if arg_9_1.accumulator then
					local var_9_2 = arg_9_1.accumulator
					local var_9_3 = iter_9_1

					var_1_10012 = arg_9_1.event_name
					unpackEx = var_1_10013

					var_9_2(var_9_3(var_1_10012, var_1_10013(arg_9_1.args)))
				else
					local var_9_4 = iter_9_1
					local var_9_5 = arg_9_1.event_name

					unpackEx = var_1_10012

					var_9_4(var_9_5, var_1_10012(arg_9_1.args))
				end
			end
		end
	end

	return
end

function var_0_2.New()
	return var_0_10001({
		stopped = false,
		events = {}
	}, var_0_4)
end

function var_0_3.connect(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_7(arg_11_0, arg_11_1).handlers

	var_4.push_back(var_11_0, arg_11_2)

	if not var_3.blocked_handlers[arg_11_2] then
		var_3.blocked_handlers[arg_11_2] = 0
	end

	return
end

function var_0_3.disconnect(arg_12_0, arg_12_1, arg_12_2)
	if var_0_8(arg_12_0, arg_12_1) then
		return
	end

	local var_12_0 = var_0_7(arg_12_0, arg_12_1).handlers

	var_4.remove(var_12_0, arg_12_2)

	var_3.blocked_handlers[arg_12_2] = nil

	return
end

function var_0_3.chectConnect(arg_13_0, arg_13_1)
	return not var_0_8(arg_13_0, arg_13_1)
end

function var_0_3.block(arg_14_0, arg_14_1, arg_14_2)
	if var_0_8(arg_14_0, arg_14_1) then
		return
	end

	if var_0_7(arg_14_0, arg_14_1).blocked_handlers[arg_14_2] then
		var_3.blocked_handlers[arg_14_2] = var_4 + 1
	end

	return
end

function var_0_3.unblock(arg_15_0, arg_15_1, arg_15_2)
	if var_0_8(arg_15_0, arg_15_1) then
		return
	end

	if var_0_7(arg_15_0, arg_15_1).blocked_handlers[arg_15_2] and var_3.blocked_handlers[arg_15_2] > 0 then
		var_3.blocked_handlers[arg_15_2] = var_3.blocked_handlers[arg_15_2] - 1
	end

	return
end

function var_0_3.emit(arg_16_0, arg_16_1, ...)
	arg_16_0.stopped = false

	local var_16_0, var_16_1 = var_0_10(arg_16_0, arg_16_1)
	local var_16_2 = var_0_12
	local var_16_3 = arg_16_0
	local var_16_4 = {
		event_name = arg_16_1,
		nodes = var_16_0
	}

	packEx = var_1_10007
	var_16_4.args = var_1_10007(...)

	var_16_2(var_16_3, var_16_4)
	var_0_11(arg_16_1, var_16_1)

	return
end

function var_0_3.emit_with_accumulator(arg_17_0, arg_17_1, arg_17_2, ...)
	arg_17_0.stopped = false

	local var_17_0, var_17_1 = var_0_10(arg_17_0, arg_17_1)
	local var_17_2 = var_0_12
	local var_17_3 = arg_17_0
	local var_17_4 = {
		event_name = arg_17_1,
		nodes = var_17_0,
		accumulator = arg_17_2
	}

	packEx = var_1_10008
	var_17_4.args = var_1_10008(...)

	var_17_2(var_17_3, var_17_4)
	var_0_11(arg_17_1, var_17_1)

	return
end

function var_0_3.add_pre_emit(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = var_0_7(arg_18_0, arg_18_1).pre_emits

	var_3.push_back(var_18_0, arg_18_2)

	return
end

function var_0_3.remove_pre_emit(arg_19_0, arg_19_1, arg_19_2)
	if var_0_8(arg_19_0, arg_19_1) then
		return
	end

	local var_19_0 = var_0_7(arg_19_0, arg_19_1).pre_emits

	var_3.remove(var_19_0, arg_19_2)

	return
end

function var_0_3.add_post_emit(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_7(arg_20_0, arg_20_1).post_emits

	var_3.push_front(var_20_0, arg_20_2)

	return
end

function var_0_3.remove_post_emit(arg_21_0, arg_21_1, arg_21_2)
	if var_0_8(arg_21_0, arg_21_1) then
		return
	end

	local var_21_0 = var_0_7(arg_21_0, arg_21_1).post_emits

	var_3.remove(var_21_0, arg_21_2)

	return
end

function var_0_3.stop(arg_22_0)
	arg_22_0.stopped = true

	return
end

function var_0_3.clear(arg_23_0, arg_23_1)
	if not arg_23_1 then
		arg_23_0.events = {}

		return
	end

	return
end

local var_0_13 = var_0_2.New()

function var_0_2.get_global_event()
	return var_0_13
end

return var_0_2

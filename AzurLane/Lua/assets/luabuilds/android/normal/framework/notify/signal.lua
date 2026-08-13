require = var_0_10000
setmetatable = var_0_10001

local var_0_0 = var_0_10000("Framework.notify.double-queue")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {
	__index = var_0_2
}

function var_0_2.disconnect(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.handlers

	var_2.remove(var_1_0, arg_1_1)

	arg_1_0.handlers_block[arg_1_1] = nil

	return
end

function var_0_2.connect(arg_2_0, arg_2_1)
	if not arg_2_0.handlers_block[arg_2_1] then
		arg_2_0.handlers_block[arg_2_1] = 0

		local var_2_0 = arg_2_0.handlers

		var_2.push_back(var_2_0, arg_2_1)
	end

	return
end

function var_0_2.block(arg_3_0, arg_3_1)
	if arg_3_0.handlers_block[arg_3_1] then
		arg_3_0.handlers_block[arg_3_1] = arg_3_0.handlers_block[arg_3_1] + 1
	end

	return
end

function var_0_2.unblock(arg_4_0, arg_4_1)
	if arg_4_0.handlers_block[arg_4_1] and arg_4_0.handlers_block[arg_4_1] > 0 then
		arg_4_0.handlers_block[arg_4_1] = arg_4_0.handlers_block[arg_4_1] - 1
	end

	return
end

function var_0_2.emit(arg_5_0, ...)
	arg_5_0.signal_stopped = false

	local var_5_0 = arg_5_0.pre_emit_funcs

	for iter_5_0 in var_1.get_iterator(var_5_0) do
		iter_5_0()
	end

	local var_5_1 = arg_5_0.handlers

	for iter_5_1 in var_1.get_iterator(var_5_1) do
		if arg_5_0.signal_stopped then
			break
		end

		if arg_5_0.handlers_block[iter_5_1] == 0 then
			iter_5_1(...)
		end
	end

	local var_5_2 = arg_5_0.post_emit_funcs

	for iter_5_2 in var_1.get_iterator(var_5_2) do
		iter_5_2()
	end

	return
end

function var_0_2.emit_with_accumulator(arg_6_0, arg_6_1, ...)
	arg_6_0.signal_stopped = false

	local var_6_0 = arg_6_0.pre_emit_funcs

	for iter_6_0 in var_2.get_iterator(var_6_0) do
		iter_6_0()
	end

	local var_6_1 = arg_6_0.handlers

	for iter_6_1 in var_2.get_iterator(var_6_1) do
		if arg_6_0.signal_stopped then
			break
		end

		if arg_6_0.handlers_block[iter_6_1] == 0 then
			arg_6_1(iter_6_1(...))
		end
	end

	local var_6_2 = arg_6_0.post_emit_funcs

	for iter_6_2 in var_2.get_iterator(var_6_2) do
		iter_6_2()
	end

	return
end

function var_0_2.add_pre_emit(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.pre_emit_funcs

	var_2.push_back(var_7_0, arg_7_1)

	return
end

function var_0_2.remove_pre_emit(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.pre_emit_funcs

	var_2.remove(var_8_0, arg_8_1)

	return
end

function var_0_2.add_post_emit(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.post_emit_funcs

	var_2.push_front(var_9_0, arg_9_1)

	return
end

function var_0_2.remove_post_emit(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.post_emit_funcs

	var_2.remove(var_10_0, arg_10_1)

	return
end

function var_0_2.stop(arg_11_0)
	arg_11_0.signal_stopped = true

	return
end

function var_0_1.New()
	local var_12_0 = {}

	var_0_10001(var_12_0, var_0_3)

	var_12_0.handlers_block = {}
	var_12_0.handlers = var_0_0.New()
	var_12_0.pre_emit_funcs = var_0_0.New()
	var_12_0.post_emit_funcs = var_0_0.New()
	var_12_0.signal_stopped = false

	return var_12_0
end

return var_0_1

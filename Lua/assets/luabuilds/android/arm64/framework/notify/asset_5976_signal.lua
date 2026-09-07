local var_0_0 = setmetatable
local var_0_1 = require("Framework.notify.double-queue")
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {
	__index = var_0_3
}

function var_0_3:disconnect(arg_1_1)
	self.handlers:remove(arg_1_1)

	self.handlers_block[arg_1_1] = nil

	return
end

function var_0_3:connect(arg_2_1)
	if not self.handlers_block[arg_2_1] then
		self.handlers_block[arg_2_1] = 0

		self.handlers:push_back(arg_2_1)
	end

	return
end

function var_0_3:block(arg_3_1)
	if self.handlers_block[arg_3_1] then
		self.handlers_block[arg_3_1] = self.handlers_block[arg_3_1] + 1
	end

	return
end

function var_0_3:unblock(arg_4_1)
	if self.handlers_block[arg_4_1] and self.handlers_block[arg_4_1] > 0 then
		self.handlers_block[arg_4_1] = self.handlers_block[arg_4_1] - 1
	end

	return
end

function var_0_3:emit(...)
	self.signal_stopped = false

	for iter_5_0 in self.pre_emit_funcs:get_iterator() do
		iter_5_0()
	end

	for iter_5_1 in self.handlers:get_iterator() do
		if self.signal_stopped then
			break
		end

		if self.handlers_block[iter_5_1] == 0 then
			iter_5_1(...)
		end
	end

	for iter_5_2 in self.post_emit_funcs:get_iterator() do
		iter_5_2()
	end

	return
end

function var_0_3:emit_with_accumulator(arg_6_1, ...)
	self.signal_stopped = false

	for iter_6_0 in self.pre_emit_funcs:get_iterator() do
		iter_6_0()
	end

	for iter_6_1 in self.handlers:get_iterator() do
		if self.signal_stopped then
			break
		end

		if self.handlers_block[iter_6_1] == 0 then
			arg_6_1(iter_6_1(...))
		end
	end

	for iter_6_2 in self.post_emit_funcs:get_iterator() do
		iter_6_2()
	end

	return
end

function var_0_3:add_pre_emit(arg_7_1)
	self.pre_emit_funcs:push_back(arg_7_1)

	return
end

function var_0_3:remove_pre_emit(arg_8_1)
	self.pre_emit_funcs:remove(arg_8_1)

	return
end

function var_0_3:add_post_emit(arg_9_1)
	self.post_emit_funcs:push_front(arg_9_1)

	return
end

function var_0_3:remove_post_emit(arg_10_1)
	self.post_emit_funcs:remove(arg_10_1)

	return
end

function var_0_3.stop(arg_11_0)
	arg_11_0.signal_stopped = true

	return
end

function var_0_2.New()
	local var_12_0 = {}

	var_0_0(var_12_0, var_0_4)

	var_12_0.handlers_block = {}
	var_12_0.handlers = var_0_1.New()
	var_12_0.pre_emit_funcs = var_0_1.New()
	var_12_0.post_emit_funcs = var_0_1.New()
	var_12_0.signal_stopped = false

	return var_12_0
end

return var_0_2

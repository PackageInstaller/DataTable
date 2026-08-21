local var_0_0 = setmetatable
local var_0_1 = require("Framework.notify.double-queue")
local var_0_2 = {
	__index = {}
}

;({}).disconnect = function(arg_1_0, arg_1_1)
	arg_1_0.handlers:remove(arg_1_1)

	arg_1_0.handlers_block[arg_1_1] = nil

	return
end
;({}).connect = function(arg_2_0, arg_2_1)
	if not arg_2_0.handlers_block[arg_2_1] then
		arg_2_0.handlers_block[arg_2_1] = 0

		arg_2_0.handlers:push_back(arg_2_1)
	end

	return
end
;({}).block = function(arg_3_0, arg_3_1)
	if arg_3_0.handlers_block[arg_3_1] then
		arg_3_0.handlers_block[arg_3_1] = arg_3_0.handlers_block[arg_3_1] + 1
	end

	return
end
;({}).unblock = function(arg_4_0, arg_4_1)
	if arg_4_0.handlers_block[arg_4_1] and arg_4_0.handlers_block[arg_4_1] > 0 then
		arg_4_0.handlers_block[arg_4_1] = arg_4_0.handlers_block[arg_4_1] - 1
	end

	return
end
;({}).emit = function(arg_5_0, ...)
	arg_5_0.signal_stopped = false

	for iter_5_0 in arg_5_0.pre_emit_funcs:get_iterator() do
		iter_5_0()
	end

	for iter_5_1 in arg_5_0.handlers:get_iterator() do
		if arg_5_0.signal_stopped then
			break
		end

		if arg_5_0.handlers_block[iter_5_1] == 0 then
			iter_5_1(...)
		end
	end

	for iter_5_2 in arg_5_0.post_emit_funcs:get_iterator() do
		iter_5_2()
	end

	return
end
;({}).emit_with_accumulator = function(arg_6_0, arg_6_1, ...)
	arg_6_0.signal_stopped = false

	for iter_6_0 in arg_6_0.pre_emit_funcs:get_iterator() do
		iter_6_0()
	end

	for iter_6_1 in arg_6_0.handlers:get_iterator() do
		if arg_6_0.signal_stopped then
			break
		end

		if arg_6_0.handlers_block[iter_6_1] == 0 then
			arg_6_1(iter_6_1(...))
		end
	end

	for iter_6_2 in arg_6_0.post_emit_funcs:get_iterator() do
		iter_6_2()
	end

	return
end
;({}).add_pre_emit = function(arg_7_0, arg_7_1)
	arg_7_0.pre_emit_funcs:push_back(arg_7_1)

	return
end
;({}).remove_pre_emit = function(arg_8_0, arg_8_1)
	arg_8_0.pre_emit_funcs:remove(arg_8_1)

	return
end
;({}).add_post_emit = function(arg_9_0, arg_9_1)
	arg_9_0.post_emit_funcs:push_front(arg_9_1)

	return
end
;({}).remove_post_emit = function(arg_10_0, arg_10_1)
	arg_10_0.post_emit_funcs:remove(arg_10_1)

	return
end
;({}).stop = function(arg_11_0)
	arg_11_0.signal_stopped = true

	return
end
;({}).New = function()
	var_0_0({}, var_0_2)

	;({}).handlers_block = {}
	;({}).handlers = var_0_1.New()
	;({}).pre_emit_funcs = var_0_1.New()
	;({}).post_emit_funcs = var_0_1.New()
	;({}).signal_stopped = false

	return {}
end

return {}

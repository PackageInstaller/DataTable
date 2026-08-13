class = var_0_10000

local var_0_0 = var_0_10000("FuncBuffer")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.buffers = {}
	arg_1_0.notifier = false

	return
end

function var_0_0.SetNotifier(arg_2_0, arg_2_1)
	defaultValue = var_1_10002
	arg_2_0.notifier = var_1_10002(arg_2_1, false)

	return
end

function var_0_0.IsEmpty(arg_3_0)
	return #arg_3_0.buffers <= 0
end

function var_0_0.Pop(arg_4_0)
	table = var_1_10001

	return var_1_10001.remove(arg_4_0.buffers, 1)
end

function var_0_0.Push(arg_5_0, arg_5_1, ...)
	table = var_1_10002

	local var_5_0 = var_1_10002.insert
	local var_5_1 = arg_5_0.buffers
	local var_5_2 = {
		funcName = arg_5_1,
		params = {
			...
		}
	}

	select = var_6
	var_5_2.paramLength = var_6("#", ...)

	var_5_0(var_5_1, var_5_2)
	arg_5_0:ExcuteAll()

	return
end

function var_0_0.ExcuteAll(arg_6_0)
	if arg_6_0.notifier then
		while not arg_6_0:IsEmpty() do
			local var_6_0 = arg_6_0:Pop()
			local var_6_1 = arg_6_0.notifier[var_6_0.funcName]
			local var_6_2 = arg_6_0.notifier

			unpack = var_1_10005

			var_6_1(var_6_2, var_1_10005(var_6_0.params, 1, var_6_0.paramLength))
		end
	end

	return
end

function var_0_0.Clear(arg_7_0)
	table = var_1_10001

	var_1_10001.clear(arg_7_0.buffers)

	return
end

function var_0_0.__index(arg_8_0, arg_8_1)
	rawget = var_1_10002

	local var_8_0

	if not var_1_10002(arg_8_0, arg_8_1) and not var_0_0[arg_8_1] then
		function var_8_0(arg_9_0, ...)
			local var_9_0 = arg_8_0

			var_1.Push(var_9_0, arg_8_1, ...)

			return
		end
	end

	return var_8_0
end

return var_0_0

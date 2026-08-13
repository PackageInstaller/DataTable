class = var_0_10000

local var_0_0 = "CourtYardEffectPool"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardPool"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.recycleTime = arg_1_5 or 2
	pg = var_6

	local var_1_0 = var_6.ViewUtils.SetLayer

	tf = var_1_10007

	local var_1_1 = var_1_10007(arg_1_2)

	Layer = var_8

	var_1_0(var_1_1, var_8.UI)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0.timers = {}

	return
end

function var_0_1.Dequeue(arg_2_0)
	local var_2_0 = var_0_1.super.Dequeue(arg_2_0)
	local var_2_1 = arg_2_0.timers

	Timer = var_1_10003
	var_2_1[var_2_0] = var_1_10003.New(function()
		local var_3_0 = arg_2_0

		var_0.Enqueue(var_3_0, var_2_0)

		return
	end, arg_2_0.recycleTime, 1)

	local var_2_2 = arg_2_0.timers[var_2_0]

	var_2.Start(var_2_2)

	return var_2_0
end

function var_0_1.Dispose(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.timers) do
		arg_4_0:Enqueue(iter_4_0)
		iter_4_1:Stop()
	end

	arg_4_0.timers = nil

	var_0_1.super.Dispose(arg_4_0)

	return
end

return var_0_1

local var_0_0 = class("CourtYardEffectPool", import(".CourtYardPool"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.recycleTime = arg_1_5 or 2

	pg.ViewUtils.SetLayer(tf(arg_1_2), Layer.UI)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0.timers = {}

	return
end

function var_0_0.Dequeue(arg_2_0)
	local var_2_0 = var_0_0.super.Dequeue(arg_2_0)

	arg_2_0.timers[var_2_0] = Timer.New(function()
		arg_2_0:Enqueue(var_2_0)

		return
	end, arg_2_0.recycleTime, 1)

	arg_2_0.timers[var_2_0]:Start()

	return var_2_0
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.timers) do
		arg_4_0:Enqueue(iter_4_0)
		iter_4_1:Stop()
	end

	arg_4_0.timers = nil

	var_0_0.super.Dispose(arg_4_0)

	return
end

return var_0_0

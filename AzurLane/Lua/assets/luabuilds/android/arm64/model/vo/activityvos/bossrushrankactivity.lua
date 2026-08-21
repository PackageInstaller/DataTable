local var_0_0 = class("BossRushRankActivity", import("model.vo.Activity"))

function var_0_0.GetScore(arg_1_0)
	return arg_1_0.data1
end

function var_0_0.Record(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):GetBossRushRuntime(arg_2_0.id).record + arg_2_1

	getProxy(ActivityProxy):GetBossRushRuntime(arg_2_0.id).record = var_2_0
	arg_2_0.data1 = math.max(arg_2_0.data1, var_2_0)

	return
end

function var_0_0.ResetLast(arg_3_0)
	getProxy(ActivityProxy):GetBossRushRuntime(arg_3_0.id).record = 0

	return
end

return var_0_0

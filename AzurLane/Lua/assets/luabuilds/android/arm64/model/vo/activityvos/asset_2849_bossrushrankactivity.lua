class = var_0_10000

local var_0_0 = "BossRushRankActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.GetScore(arg_1_0)
	return arg_1_0.data1
end

function var_0_1.Record(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.GetBossRushRuntime(var_2_0, arg_2_0.id).record + arg_2_1

	getProxy = var_1_10003
	ActivityProxy = var_5

	local var_2_2 = var_1_10003(var_5)
	local var_2_3 = var_3.GetBossRushRuntime(var_2_2, arg_2_0.id)

	var_2_3.record = var_2_1
	math = var_2_3
	arg_2_0.data1 = var_2_3.max(arg_2_0.data1, var_2_1)

	return
end

function var_0_1.ResetLast(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	var_1.GetBossRushRuntime(var_3_0, arg_3_0.id).record = 0

	return
end

return var_0_1

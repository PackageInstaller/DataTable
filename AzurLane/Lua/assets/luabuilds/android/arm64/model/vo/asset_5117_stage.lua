class = var_0_10000

local var_0_0 = "Stage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.SubmarinStage = 15

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_0.configId
	arg_1_0.score = arg_1_1.score

	local var_1_0

	if not arg_1_1.out_time then
		var_1_0 = 0
	end

	arg_1_0.out_time = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.expedition_data_template
end

function var_0_1.isFinish(arg_3_0)
	local var_3_0

	if arg_3_0.score then
		var_3_0 = arg_3_0.score > 1
	end

	return var_3_0
end

return var_0_1

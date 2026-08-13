class = var_0_10000

local var_0_0 = "EducatePolaroid"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.time then
		var_1_0 = {
			week = 1,
			month = 3,
			day = 7
		}
	end

	arg_1_0.time = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_polaroid
end

function var_0_1.GetTimeWeight(arg_3_0)
	return arg_3_0.time.month * 28 + arg_3_0.time.week * 7 + arg_3_0.time.day
end

return var_0_1

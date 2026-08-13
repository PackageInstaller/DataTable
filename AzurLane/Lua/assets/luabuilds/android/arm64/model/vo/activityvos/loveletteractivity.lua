class = var_0_10000

local var_0_0 = "LoveLetterActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.GetDailyProgress(arg_2_0)
	return arg_2_0.data2, arg_2_0:getConfig("config_data")[2] * arg_2_0:getNDay()
end

function var_0_1.AddDailyProgress(arg_3_0, arg_3_1)
	arg_3_0.data2 = arg_3_0.data2 + arg_3_1
	assert = var_2

	var_2(arg_3_0.data2 <= arg_3_0:getConfig("config_data")[2] * arg_3_0:getNDay())

	return
end

function var_0_1.DayReset(arg_4_0)
	return
end

function var_0_1.SetTargetGroupId(arg_5_0, arg_5_1)
	arg_5_0.data1 = arg_5_1

	return
end

function var_0_1.GetTargetGroupId(arg_6_0)
	return arg_6_0.data1
end

function var_0_1.AddChangeCount(arg_7_0)
	arg_7_0.data3 = arg_7_0.data3 + 1

	return
end

function var_0_1.GetChangeCount(arg_8_0)
	return arg_8_0.data3, arg_8_0:getConfig("config_data")[3]
end

function var_0_1.IsLimitExpItem(arg_9_0, arg_9_1)
	return arg_9_1 == arg_9_0:getConfig("config_data")[1]
end

function var_0_1.FilterExp(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0
	local var_10_1, var_10_2 = arg_10_0.GetDailyProgress(var_10_0)

	math = var_10_0

	return var_10_0.min(arg_10_1, var_10_2 - var_10_1)
end

return var_0_1

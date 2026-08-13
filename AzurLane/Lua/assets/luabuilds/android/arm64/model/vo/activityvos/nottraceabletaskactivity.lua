class = var_0_10000

local var_0_0 = "NotTraceableTaskActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.ActivityVOs.ITaskActivity"))

function var_0_1.GetTaskIdsByDay(arg_1_0)
	return arg_1_0:getConfig("config_data")
end

function var_0_1.GetCurrentDay(arg_2_0, arg_2_1)
	local var_2_0 = 0

	pg = var_1_10003

	local var_2_1 = var_1_10003.TimeMgr.GetInstance()
	local var_2_2 = var_3.GetServerTime(var_2_1)
	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.getConfig(var_2_3, "time")

	pg = var_2_1

	local var_2_5 = var_2_1.TimeMgr.GetInstance()
	local var_2_6 = var_5.parseTimeFromConfig(var_2_5, var_2_4[2])

	math = var_2_3

	local var_2_7

	if var_2_3.ceil((var_2_2 - var_2_6) / var_2_0) > #arg_2_0:getConfig("config_data") then
		var_2_7 = #var_7
	end

	return var_2_7
end

return var_0_1

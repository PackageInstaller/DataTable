class = var_0_10000

local var_0_0 = "ActivityTaskActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.ActivityVOs.ITaskActivity"))

function var_0_1.GetFinishedTaskIds(arg_1_0)
	return arg_1_0:getData1List()
end

function var_0_1.GetTaskIdsByDay(arg_2_0)
	return arg_2_0:getConfig("config_data")
end

return var_0_1

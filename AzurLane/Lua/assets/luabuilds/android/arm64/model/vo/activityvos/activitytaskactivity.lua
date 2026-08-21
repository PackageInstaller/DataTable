local var_0_0 = class("ActivityTaskActivity", import("model.vo.ActivityVOs.ITaskActivity"))

function var_0_0.GetFinishedTaskIds(arg_1_0)
	return arg_1_0:getData1List()
end

function var_0_0.GetTaskIdsByDay(arg_2_0)
	return arg_2_0:getConfig("config_data")
end

return var_0_0

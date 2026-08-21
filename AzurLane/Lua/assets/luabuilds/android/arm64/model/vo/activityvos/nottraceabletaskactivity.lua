local var_0_0 = class("NotTraceableTaskActivity", import("model.vo.ActivityVOs.ITaskActivity"))

function var_0_0.GetTaskIdsByDay(arg_1_0)
	return arg_1_0:getConfig("config_data")
end

function var_0_0.GetCurrentDay(arg_2_0, arg_2_1)
	local var_2_9000
	local var_2_0 = math.ceil((pg.TimeMgr.GetInstance().GetServerTime(var_2_9000) - pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_2_0:getConfig("time")[2])) / 0)
	local var_2_1 = arg_2_0:getConfig("config_data")

	if var_2_0 > #var_2_1 then
		var_2_0 = #var_2_1
	end

	return var_2_0
end

return var_0_0

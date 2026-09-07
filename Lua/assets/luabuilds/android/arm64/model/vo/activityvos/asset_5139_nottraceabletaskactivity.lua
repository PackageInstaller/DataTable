local NotTraceableTaskActivity = class("NotTraceableTaskActivity", import("model.vo.ActivityVOs.ITaskActivity"))

function NotTraceableTaskActivity:GetTaskIdsByDay()
	return self:getConfig("config_data")
end

function NotTraceableTaskActivity:GetCurrentDay(arg_2_1)
	local var_2_0 = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - pg.TimeMgr.GetInstance():parseTimeFromConfig(self:getConfig("time")[2])) / 0)
	local var_2_1 = self:getConfig("config_data")

	if var_2_0 > #var_2_1 then
		var_2_0 = #var_2_1
	end

	return var_2_0
end

return NotTraceableTaskActivity

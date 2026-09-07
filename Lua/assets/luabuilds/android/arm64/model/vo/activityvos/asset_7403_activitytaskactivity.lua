local ActivityTaskActivity = class("ActivityTaskActivity", import("model.vo.ActivityVOs.ITaskActivity"))

function ActivityTaskActivity:GetFinishedTaskIds()
	return self:getData1List()
end

function ActivityTaskActivity:GetTaskIdsByDay()
	return self:getConfig("config_data")
end

return ActivityTaskActivity

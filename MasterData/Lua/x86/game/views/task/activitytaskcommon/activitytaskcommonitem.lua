local ActivityTaskCommonItem = class("ActivityTaskCommonItem", (import("game.views.task.common.CommonActivityTaskItem")))

function ActivityTaskCommonItem:SetData(arg_1_1, arg_1_2)
	if not arg_1_1 then
		return
	end

	self.taskID_ = arg_1_1
	self.taskProgress = TaskData2:GetTaskProgress(arg_1_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_1_1)

	self:RefreshProgress()
	self:RefreshUI()
	self:SetIndex(arg_1_2)

	self.isShow_ = true
end

function ActivityTaskCommonItem:SetIndex(arg_2_1)
	self.indexText_.text = string.format("%02d", arg_2_1)
end

return ActivityTaskCommonItem

ActivityTaskBaseItem = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseItem")

local ActivityTaskFactoryItem = class("ActivityTaskFactoryItem", ActivityTaskBaseItem)

function ActivityTaskFactoryItem:RefreshUI()
	self.textContent_.text = GetI18NText(AssignmentCfg[self.taskID_].name)
	self.textDesc_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_1_0 = TaskData2:GetTask(self.taskID_).progress or 0
	local var_1_1 = AssignmentCfg[self.taskID_].need

	if AssignmentCfg[self.taskID_].need < var_1_0 then
		var_1_0 = var_1_1
	end

	self.finishCntText_.text = var_1_0
	self.targetCntText_.text = var_1_1

	if AssignmentCfg[self.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeController_:SetSelectedState("daily")
	else
		self.typeController_:SetSelectedState("challenge")
	end
end

function ActivityTaskFactoryItem:GetRewardItem(arg_2_1)
	return RewardPoolFactoryItem.New(self.goItemParent_, arg_2_1, true)
end

return ActivityTaskFactoryItem

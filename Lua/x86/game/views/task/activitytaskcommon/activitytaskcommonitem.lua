local var_0_0 = import("game.views.task.common.CommonActivityTaskItem")
local var_0_1 = class("ActivityTaskCommonItem", var_0_0)

function var_0_1.SetData(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_1 then
		return
	end

	arg_1_0.taskID_ = arg_1_1
	arg_1_0.taskProgress = TaskData2:GetTaskProgress(arg_1_1)
	arg_1_0.taskComplete_ = TaskData2:GetTaskComplete(arg_1_1)

	arg_1_0:RefreshProgress()
	arg_1_0:RefreshUI()
	arg_1_0:SetIndex(arg_1_2)

	arg_1_0.isShow_ = true
end

function var_0_1.SetIndex(arg_2_0, arg_2_1)
	arg_2_0.indexText_.text = string.format("%02d", arg_2_1)
end

return var_0_1

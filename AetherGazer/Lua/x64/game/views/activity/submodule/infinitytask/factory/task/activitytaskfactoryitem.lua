ActivityTaskBaseItem = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseItem")

local var_0_0 = class("ActivityTaskFactoryItem", ActivityTaskBaseItem)

function var_0_0.RefreshUI(arg_1_0)
	local var_1_0 = arg_1_0.taskID_
	local var_1_1 = AssignmentCfg[var_1_0]

	arg_1_0.textContent_.text = GetI18NText(var_1_1.name)
	arg_1_0.textDesc_.text = GetI18NText(var_1_1.desc)

	local var_1_2 = TaskData2:GetTask(var_1_0).progress or 0
	local var_1_3 = var_1_1.need

	if var_1_3 < var_1_2 then
		var_1_2 = var_1_3
	end

	arg_1_0.finishCntText_.text = var_1_2
	arg_1_0.targetCntText_.text = var_1_3

	if var_1_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_1_0.typeController_:SetSelectedState("daily")
	else
		arg_1_0.typeController_:SetSelectedState("challenge")
	end
end

function var_0_0.GetRewardItem(arg_2_0, arg_2_1)
	return RewardPoolFactoryItem.New(arg_2_0.goItemParent_, arg_2_1, true)
end

return var_0_0

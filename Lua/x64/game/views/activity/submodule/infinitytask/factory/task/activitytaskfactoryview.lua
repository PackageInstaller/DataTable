ActivityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseView")

local var_0_0 = class("ActivityTaskFactoryView", ActivityTaskBaseView)

function var_0_0.GetAssetName(arg_1_0)
	return "UI/MardukUI/catMatch/MardukTaskContent"
end

function var_0_0.GetTaskClass(arg_2_0)
	return ActivityTaskFactoryItem
end

return var_0_0

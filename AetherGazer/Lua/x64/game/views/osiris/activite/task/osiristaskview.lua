ActivityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseView")

local var_0_0 = class("OsirisTaskView", ActivityTaskBaseView)

function var_0_0.GetAssetName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisTaskContent"
end

function var_0_0.GetTaskClass(arg_2_0)
	return OsirisTaskItem
end

return var_0_0

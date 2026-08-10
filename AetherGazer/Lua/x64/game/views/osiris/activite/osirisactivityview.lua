InfinityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.InfinityTaskBaseView")

local var_0_0 = class("OsirisActivityView", InfinityTaskBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisUITaskUI"
end

function var_0_0.GetTaskViewClass(arg_2_0)
	return OsirisTaskView
end

function var_0_0.GetInfinityPoolViewClass(arg_3_0)
	return OsirisLotteryView
end

return var_0_0

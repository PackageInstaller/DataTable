InfinityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.InfinityTaskBaseView")

local OsirisActivityView = class("OsirisActivityView", InfinityTaskBaseView)

function OsirisActivityView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisUITaskUI"
end

function OsirisActivityView:GetTaskViewClass()
	return OsirisTaskView
end

function OsirisActivityView:GetInfinityPoolViewClass()
	return OsirisLotteryView
end

return OsirisActivityView

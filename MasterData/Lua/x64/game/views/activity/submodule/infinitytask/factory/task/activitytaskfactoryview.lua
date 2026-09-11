ActivityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseView")

local ActivityTaskFactoryView = class("ActivityTaskFactoryView", ActivityTaskBaseView)

function ActivityTaskFactoryView:GetAssetName()
	return "UI/MardukUI/catMatch/MardukTaskContent"
end

function ActivityTaskFactoryView:GetTaskClass()
	return ActivityTaskFactoryItem
end

return ActivityTaskFactoryView

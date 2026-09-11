ActivityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseView")

local OsirisTaskView = class("OsirisTaskView", ActivityTaskBaseView)

function OsirisTaskView:GetAssetName()
	return "UI/VersionUI/OsirisUI/OsirisTaskContent"
end

function OsirisTaskView:GetTaskClass()
	return OsirisTaskItem
end

return OsirisTaskView

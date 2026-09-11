ActivityStoryStageBaseView = import("game.views.activity.Submodule.storyStage.base.ActivityStoryStageBaseView")

local ActivityAthenaStoryView = class("ActivityAthenaStoryView", ActivityStoryStageBaseView)

function ActivityAthenaStoryView:UIName()
	return "UI/VolumeIIIDownUI/SubPlot/VolumeIIIDownSubPlotUI"
end

function ActivityAthenaStoryView:GetItemClass()
	return ActivityAthenaStoryItem
end

return ActivityAthenaStoryView

ActivityStoryStageBaseView = import("game.views.activity.Submodule.storyStage.base.ActivityStoryStageBaseView")

local var_0_0 = class("ActivityAthenaStoryView", ActivityStoryStageBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/SubPlot/VolumeIIIDownSubPlotUI"
end

function var_0_0.GetItemClass(arg_2_0)
	return ActivityAthenaStoryItem
end

return var_0_0

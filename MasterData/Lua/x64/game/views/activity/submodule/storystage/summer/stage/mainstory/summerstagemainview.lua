SummerStageBaseView = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseView")

local SummerStageMainView = class("SummerStageMainView", SummerStageBaseView)

function SummerStageMainView:UIName()
	return "UI/BranchlineUI/SummerUI/SummerMainStoryUI"
end

function SummerStageMainView:GetStageItemClass()
	return SummerStageMainItem
end

function SummerStageMainView:GetActivityID()
	return ActivityConst.SUMMER_STORY_ISLAND
end

return SummerStageMainView

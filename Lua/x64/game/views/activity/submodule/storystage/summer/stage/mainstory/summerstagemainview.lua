SummerStageBaseView = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseView")

local var_0_0 = class("SummerStageMainView", SummerStageBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/SummerUI/SummerMainStoryUI"
end

function var_0_0.GetStageItemClass(arg_2_0)
	return SummerStageMainItem
end

function var_0_0.GetActivityID(arg_3_0)
	return ActivityConst.SUMMER_STORY_ISLAND
end

return var_0_0

SummerStageBaseView = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseView")

local var_0_0 = class("SummerStageSeabedView", SummerStageBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/SummerUI/SummerSeafloorStoryUI"
end

function var_0_0.GetStageItemClass(arg_2_0)
	return SummerStageSeabedItem
end

function var_0_0.GetActivityID(arg_3_0)
	return ActivityConst.SUMMER_STORY_SEABED
end

function var_0_0.AddListeners(arg_4_0)
	var_0_0.super.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		local var_5_0 = ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1]

		arg_4_0:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = var_5_0
		})
	end)
end

return var_0_0

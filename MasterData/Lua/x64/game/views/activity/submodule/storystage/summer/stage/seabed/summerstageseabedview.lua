SummerStageBaseView = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseView")

local SummerStageSeabedView = class("SummerStageSeabedView", SummerStageBaseView)

function SummerStageSeabedView:UIName()
	return "UI/BranchlineUI/SummerUI/SummerSeafloorStoryUI"
end

function SummerStageSeabedView:GetStageItemClass()
	return SummerStageSeabedItem
end

function SummerStageSeabedView:GetActivityID()
	return ActivityConst.SUMMER_STORY_SEABED
end

function SummerStageSeabedView:AddListeners()
	SummerStageSeabedView.super.AddListeners(self)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1]
		})
	end)
end

return SummerStageSeabedView

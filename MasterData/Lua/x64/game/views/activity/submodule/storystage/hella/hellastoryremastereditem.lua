local HellaStoryRemasteredItem = class("HellaStoryRemasteredItem", (import("game.views.activity.Submodule.storyStage.StoryStageItemView")))

function HellaStoryRemasteredItem:RefreshLockData(arg_1_1, arg_1_2)
	self.selectChapterID_ = arg_1_2
end

function HellaStoryRemasteredItem:RefreshClearData(arg_2_1, arg_2_2)
	local var_2_0 = BattleStageData:GetStageData()[arg_2_1]

	self.isClear_ = not not (var_2_0 and var_2_0.clear_times > 0)
end

function HellaStoryRemasteredItem:OnClick()
	BattleFieldData:SetCacheStage(self.selectChapterID_, self.stageID_)
	self:Go("subPlotSectionInfo", {
		chapterID = self.selectChapterID_,
		section = self.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function HellaStoryRemasteredItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

return HellaStoryRemasteredItem

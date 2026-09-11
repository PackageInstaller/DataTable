local SummerStoryRemasteredItem = class("SummerStoryRemasteredItem", (import("game.views.activity.Submodule.storyStage.summer.stage.mainStory.SummerStageMainItem")))

function SummerStoryRemasteredItem:RefreshLockData()
	self.isLock_ = false
end

function SummerStoryRemasteredItem:RefreshData()
	local var_2_0 = BattleStageData:GetStageData()[self.stageID_]

	self.clearTimes_ = var_2_0 and var_2_0.clear_times or 0
	self.isLock_ = StageTools.IsLockSubChapterStage(self.chapterID_, self.stageID_)
end

function SummerStoryRemasteredItem:OnClick()
	if self.isLock_ then
		ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
	else
		BattleFieldData:SetCacheStage(self.chapterID_, self.stageID_)
		self:Go("subPlotSectionInfo", {
			section = self.stageID_,
			chapterID = self.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		})
	end
end

function SummerStoryRemasteredItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function SummerStoryRemasteredItem:RefreshText()
	local var_5_0 = table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_)

	self.text_.text = string.format("%d", var_5_0)

	if var_5_0 - 1 == 0 then
		self.lineController_:SetSelectedState("-1")
	elseif (var_5_0 - 1) % 2 == 0 then
		self.lineController_:SetSelectedState(tostring((var_5_0 - 1) % 2))
	else
		self.lineController_:SetSelectedState(tostring((var_5_0 - 1) % 4))
	end
end

return SummerStoryRemasteredItem

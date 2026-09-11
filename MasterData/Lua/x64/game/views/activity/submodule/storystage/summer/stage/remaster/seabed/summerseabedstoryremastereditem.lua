local SummerSeabedStoryRemasteredItem = class("SummerSeabedStoryRemasteredItem", (import("game.views.activity.Submodule.storyStage.summer.stage.seabed.SummerStageSeabedItem")))

function SummerSeabedStoryRemasteredItem:RefreshLockData()
	self.isLock_ = false
end

function SummerSeabedStoryRemasteredItem:RefreshData()
	local var_2_0 = BattleStageData:GetStageData()[self.stageID_]

	self.clearTimes_ = var_2_0 and var_2_0.clear_times or 0
end

function SummerSeabedStoryRemasteredItem:OnClick()
	BattleFieldData:SetCacheStage(self.chapterID_, self.stageID_)
	self:Go("subPlotSectionInfo", {
		section = self.stageID_,
		chapterID = self.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function SummerSeabedStoryRemasteredItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function SummerSeabedStoryRemasteredItem:RefreshText()
	local var_5_0 = table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_)

	self.text_.text = string.format("%d", var_5_0)

	if var_5_0 - 1 == 0 then
		self.lineController_:SetSelectedState("3-1")
	elseif var_5_0 - 1 == 1 then
		self.lineController_:SetSelectedState("0-1")
	else
		self.lineController_:SetSelectedState(tostring((var_5_0 - 1 - 1) % 4))
	end
end

return SummerSeabedStoryRemasteredItem

local SubPlotSectionItem = class("SubPlotSectionItem", (import("game.views.sectionSelect.SectionBaseItem")))

function SubPlotSectionItem:InitCustom()
	SetActive(self.collectGo_, false)
	self.showStarController_:SetSelectedState("false")
end

function SubPlotSectionItem:GetTag()
	return (BattleActivityStoryStageCfg[self.stageID_] or nil) and (BattleActivityStoryStageCfg[self.stageID_].tag or 0)
end

function SubPlotSectionItem:GetPosition()
	return (BattleActivityStoryStageCfg[self.stageID_] or nil) and (BattleActivityStoryStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function SubPlotSectionItem:RefreshData()
	local var_4_0 = BattleStageData:GetStageData()[self.stageID_]
	local var_4_1 = ChapterCfg[self.chapterID_]

	if var_4_0 then
		self.isLock_ = false
		self.clearTimes_ = var_4_0.clear_times
	elseif table.keyof(var_4_1.section_id_list, self.stageID_) == 1 then
		self.isLock_ = false
		self.clearTimes_ = 0
	else
		self.isLock_ = true
		self.clearTimes_ = -1
	end

	self.enoughLevel_ = ActivityData:GetActivityIsOpen(var_4_1.activity_id) and true or BattleActivityStoryStageCfg[self.stageID_].level <= PlayerData:GetPlayerInfo().userLevel
end

function SubPlotSectionItem:OnClick()
	if self.isLock_ then
		-- block empty
	else
		self:Go("subPlotSectionInfo", {
			section = self.stageID_,
			chapterID = self.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		})
	end
end

function SubPlotSectionItem:RefreshText()
	self.text_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)
end

function SubPlotSectionItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

return SubPlotSectionItem

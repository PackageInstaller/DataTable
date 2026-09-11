local OsirisStoryStageRemasteredItem = class("OsirisStoryStageRemasteredItem", (import("game.views.osiris.storyStage.section.OsirisStoryStageItem")))

function OsirisStoryStageRemasteredItem:SetData(arg_1_1, arg_1_2)
	self.stageID_ = arg_1_1
	self.chapterID_ = arg_1_2

	self:RefreshData()
	self:RefreshUI()
end

function OsirisStoryStageRemasteredItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function OsirisStoryStageRemasteredItem:RefreshData()
	local var_3_0 = BattleStageData:GetStageData()[self.stageID_]

	self.isClear_ = not not (var_3_0 and var_3_0.clear_times > 0)
end

function OsirisStoryStageRemasteredItem:OnClick()
	BattleFieldData:SetCacheStage(self.chapterID_, self.stageID_)
	self:Go("subPlotSectionInfo", {
		section = self.stageID_,
		chapterID = self.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function OsirisStoryStageRemasteredItem:RefreshUI()
	local var_5_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_5_0[1], var_5_0[2], 0)

	local var_5_1 = table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_)

	self.textIndex_.text = string.format("%02d", var_5_1)
	self.textName_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)
	self.imageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleActivityStoryStageCfg[self.stageID_].background_1))

	if var_5_1 == 1 or BattleStageData:GetStageData()[self.stageID_] then
		self:Show(true)
	else
		self:Show(false)
	end

	self:RefreshClear()
end

return OsirisStoryStageRemasteredItem

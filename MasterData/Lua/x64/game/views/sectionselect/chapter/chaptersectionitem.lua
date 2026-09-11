local ChapterSectionItem = class("ChapterSectionItem", (import("game.views.sectionSelect.SectionBaseItem")))

function ChapterSectionItem:InitUI()
	ChapterSectionItem.super.InitUI(self)

	self.hasTipsController_ = self.controllerEx_:GetController("hasTipsText")
end

function ChapterSectionItem:RefreshStar()
	if #BattleChapterStageCfg[self.stageID_].three_star_need == 1 then
		for iter_2_0 = 1, 3 do
			self.threeStarBarList_[iter_2_0]:SetData(self.starCnt_ >= 1)
		end
	else
		for iter_2_1 = 1, 3 do
			self.threeStarBarList_[iter_2_1]:SetData(iter_2_1 <= self.starCnt_)
		end
	end
end

function ChapterSectionItem:GetTag()
	return (BattleChapterStageCfg[self.stageID_] or nil) and (BattleChapterStageCfg[self.stageID_].tag or 0)
end

function ChapterSectionItem:GetPosition()
	return (BattleChapterStageCfg[self.stageID_] and BattleChapterStageCfg[self.stageID_].position ~= "" or nil) and (BattleChapterStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function ChapterSectionItem:RefreshData()
	local var_5_0 = BattleStageData:GetStageData()[self.stageID_]
	local var_5_1 = ChapterCfg[self.chapterID_]

	self.enoughLevel_ = ActivityData:GetActivityIsOpen(ChapterCfg[self.chapterID_].activity_id) and true or BattleChapterStageCfg[self.stageID_].level <= PlayerData:GetPlayerInfo().userLevel

	if var_5_0 then
		self.isLock_ = false
		self.clearTimes_ = var_5_0.clear_times

		local var_5_4 = 0

		for iter_5_0, iter_5_1 in ipairs(var_5_0.stars) do
			if iter_5_1 > 0 then
				var_5_4 = var_5_4 + 1
			end
		end

		self.starCnt_ = var_5_4
		self.isFinishAllPre = true
	else
		if table.keyof(var_5_1.section_id_list, self.stageID_) == 1 then
			self.isLock_ = false
			self.clearTimes_ = 0
			self.starCnt_ = 0
		elseif self:IsUnlockPreStage() then
			self.isLock_ = false
			self.enoughLevel_ = false
			self.clearTimes_ = 0
			self.starCnt_ = 0
		else
			self.isLock_ = true
			self.clearTimes_ = -1
			self.starCnt_ = 0
		end

		self.isFinishAllPre = self:IsFinishAllPreUnlockStage()
	end

	if self.stageID_ == GameSetting.travel_skuld_new_ending_stage_id.value[1] and self.clearTimes_ < 1 then
		self.isLock_ = true
	end
end

function ChapterSectionItem:IsUnlockPreStage()
	local var_6_0 = BattleStageData:GetStageData()

	if BattleChapterStageCfg[self.stageID_].pre_show_id_list == nil then
		print(string.format("关卡 %s 未配置前置关卡", self.stageID_))

		return true
	end

	for iter_6_0, iter_6_1 in pairs(BattleChapterStageCfg[self.stageID_].pre_show_id_list) do
		if var_6_0[iter_6_1] and var_6_0[iter_6_1].clear_times > 0 then
			return true
		end
	end

	return false
end

function ChapterSectionItem:IsFinishAllPreUnlockStage()
	if not BattleStageData:IsFinishAllPreUnlockStage(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_, true) then
		return false
	end

	return true
end

function ChapterSectionItem:OnClick()
	if self.isLock_ then
		-- block empty
	elseif self.isFinishAllPre then
		self:Go("chapterSectionInfo", {
			section = self.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
		})
	else
		BattleStageData:IsFinishAllPreUnlockStage(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_)
	end
end

function ChapterSectionItem:RefreshText()
	local var_9_0, var_9_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.stageID_)

	self.text_.text = string.format("%s-%s", GetI18NText(var_9_0), GetI18NText(var_9_1))

	if BattleChapterStageCfg[self.stageID_].line_text == "" then
		self.hasTipsController_:SetSelectedState("false")
	else
		self.lineText_.text = GetI18NText(BattleChapterStageCfg[self.stageID_].line_text)

		self.hasTipsController_:SetSelectedState("true")
	end
end

function ChapterSectionItem:IsOpenSectionInfo()
	return self:IsOpenRoute("chapterSectionInfo")
end

return ChapterSectionItem

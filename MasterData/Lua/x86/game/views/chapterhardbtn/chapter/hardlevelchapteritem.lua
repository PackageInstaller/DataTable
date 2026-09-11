local HardLevelChapterItem = class("HardLevelChapterItem", import("..HardLevelBaseItem"))

function HardLevelChapterItem:OnEnter()
	HardLevelChapterItem.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, self.hardLevel_))
end

function HardLevelChapterItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, self.hardLevel_))
	HardLevelChapterItem.super.OnExit(self)
end

function HardLevelChapterItem:IsLock()
	self.isLock_ = not ChapterTools.IsFinishPreChapter(getChapterNumList((self.hardLevel_ ~= 1 or nil) and 2)[self.hardLevel_][1])
end

function HardLevelChapterItem:LockTips()
	local var_4_0 = BattleFieldData:GetCacheChapter((BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)))
	local var_4_1 = getChapterNumList(1)[self.hardLevel_][1]
	local var_4_2, var_4_3 = ChapterTools.IsFinishPreChapter(var_4_1)

	if not var_4_2 then
		ShowTips(ChapterTools.GetChapterLockText(var_4_1, var_4_3, true))

		return
	end

	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function HardLevelChapterItem:ClickBtn()
	if self.hardLevel_ == BattleFieldData:GetPlotHardLevel() then
		return
	end

	BattleFieldAction.ChangePlotHardLevel(self.hardLevel_)

	if not self.isLock_ then
		BattleFieldAction.ChangeSelectChapterID(self:GetOpenMaxChapter())
	end
end

function HardLevelChapterItem:GetOpenMaxChapter()
	local var_6_0 = BattleFieldData:GetCacheChapter((BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)))
	local var_6_1 = getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, ChapterCfg[var_6_0].difficulty)
	local var_6_2 = getChapterList()
	local var_6_3 = table.keyof(var_6_1, var_6_0)

	for iter_6_0 = var_6_3, 1, -1 do
		if var_6_2[ChapterCfg[var_6_1[iter_6_0]].sub_type][self.hardLevel_] then
			if ChapterCfg[var_6_2[ChapterCfg[var_6_1[iter_6_0]].sub_type][self.hardLevel_][1]].section_id_list[1] and BattleStageData:GetStageData()[ChapterCfg[var_6_2[ChapterCfg[var_6_1[iter_6_0]].sub_type][self.hardLevel_][1]].section_id_list[1]] then
				return var_6_2[ChapterCfg[var_6_1[iter_6_0]].sub_type][self.hardLevel_][1]
			end
		end
	end

	if self.hardLevel_ ~= 1 and var_6_3 <= 1 then
		var_6_3 = 2
	end

	return getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.hardLevel_)[var_6_3]
end

return HardLevelChapterItem

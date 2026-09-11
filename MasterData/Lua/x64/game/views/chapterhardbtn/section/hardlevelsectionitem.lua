local HardLevelSectionItem = class("HardLevelSectionItem", import("..HardLevelBaseItem"))

function HardLevelSectionItem:IsLock()
	local var_1_0 = ChapterCfg[BattleFieldData:GetCacheChapter((BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)))].sub_type

	if self.hardLevel_ ~= 1 and var_1_0 <= 1 then
		var_1_0 = 2
	end

	self.isLock_ = getChapterNumList(var_1_0)[self.hardLevel_] and not ChapterTools.IsFinishPreChapter(getChapterNumList(var_1_0)[self.hardLevel_][1]) or false
end

function HardLevelSectionItem:LockTips()
	local var_2_0 = BattleFieldData:GetCacheChapter(getChapterClientCfgByChapterID(getChapterNumList(ChapterCfg[BattleFieldData:GetCacheChapter((BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)))].sub_type)[self.hardLevel_][1]).id)
	local var_2_1, var_2_2 = ChapterTools.IsFinishPreChapter(var_2_0)

	if not var_2_1 then
		ShowTips(ChapterTools.GetChapterLockText(var_2_0, var_2_2, true))

		return
	end

	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function HardLevelSectionItem:ClickBtn()
	local var_3_0 = BattleFieldData:GetCacheChapter((BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)))
	local var_3_1 = BattleFieldData:GetCacheChapter(getChapterClientCfgByChapterID(getChapterNumList(ChapterCfg[var_3_0].sub_type)[self.hardLevel_][1]).id)

	if var_3_0 ~= var_3_1 then
		self:Go("/chapterSection", {
			chapterID = var_3_1
		})
	end
end

function HardLevelSectionItem:RefreshItem()
	HardLevelSectionItem.super.RefreshItem(self)

	local var_4_0 = ChapterCfg[BattleFieldData:GetCacheChapter((BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)))].sub_type

	if self.hardLevel_ ~= 1 and var_4_0 <= 1 then
		var_4_0 = 2
	end

	self.percentageText_.text = getChapterNumList(var_4_0)[self.hardLevel_] and string.format("%s%%", math.floor(ChapterTools.GetChapterStarPercentage(getChapterNumList(var_4_0)[self.hardLevel_][1]) * 100)) or "0%"
end

return HardLevelSectionItem

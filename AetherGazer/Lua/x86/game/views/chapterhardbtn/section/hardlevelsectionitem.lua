local var_0_0 = class("HardLevelSectionItem", import("..HardLevelBaseItem"))

function var_0_0.IsLock(arg_1_0)
	local var_1_0 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	local var_1_1 = BattleFieldData:GetCacheChapter(var_1_0)
	local var_1_2 = ChapterCfg[var_1_1].sub_type

	if arg_1_0.hardLevel_ ~= 1 and var_1_2 <= 1 then
		var_1_2 = 2
	end

	if getChapterNumList(var_1_2)[arg_1_0.hardLevel_] then
		local var_1_3 = getChapterNumList(var_1_2)[arg_1_0.hardLevel_][1]

		arg_1_0.isLock_ = not ChapterTools.IsFinishPreChapter(var_1_3)
	else
		arg_1_0.isLock_ = false
	end
end

function var_0_0.LockTips(arg_2_0)
	local var_2_0 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	local var_2_1 = BattleFieldData:GetCacheChapter(var_2_0)
	local var_2_2 = ChapterCfg[var_2_1].sub_type
	local var_2_3 = getChapterClientCfgByChapterID(getChapterNumList(var_2_2)[arg_2_0.hardLevel_][1]).id
	local var_2_4 = BattleFieldData:GetCacheChapter(var_2_3)
	local var_2_5, var_2_6 = ChapterTools.IsFinishPreChapter(var_2_4)

	if not var_2_5 then
		ShowTips(ChapterTools.GetChapterLockText(var_2_4, var_2_6, true))

		return
	end

	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function var_0_0.ClickBtn(arg_3_0)
	local var_3_0 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	local var_3_1 = BattleFieldData:GetCacheChapter(var_3_0)
	local var_3_2 = ChapterCfg[var_3_1].sub_type
	local var_3_3 = getChapterClientCfgByChapterID(getChapterNumList(var_3_2)[arg_3_0.hardLevel_][1]).id
	local var_3_4 = BattleFieldData:GetCacheChapter(var_3_3)

	if var_3_1 ~= var_3_4 then
		arg_3_0:Go("/chapterSection", {
			chapterID = var_3_4
		})
	end
end

function var_0_0.RefreshItem(arg_4_0)
	var_0_0.super.RefreshItem(arg_4_0)

	local var_4_0 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	local var_4_1 = BattleFieldData:GetCacheChapter(var_4_0)
	local var_4_2 = ChapterCfg[var_4_1].sub_type

	if arg_4_0.hardLevel_ ~= 1 and var_4_2 <= 1 then
		var_4_2 = 2
	end

	if getChapterNumList(var_4_2)[arg_4_0.hardLevel_] then
		local var_4_3 = getChapterNumList(var_4_2)[arg_4_0.hardLevel_][1]

		arg_4_0.percentageText_.text = string.format("%s%%", math.floor(ChapterTools.GetChapterStarPercentage(var_4_3) * 100))
	else
		arg_4_0.percentageText_.text = "0%"
	end
end

return var_0_0

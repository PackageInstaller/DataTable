local var_0_0 = class("HardLevelChapterItem", import("..HardLevelBaseItem"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, arg_1_0.hardLevel_))
end

function var_0_0.OnExit(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, arg_2_0.hardLevel_))
	var_0_0.super.OnExit(arg_2_0)
end

function var_0_0.IsLock(arg_3_0)
	local var_3_0 = 1

	if arg_3_0.hardLevel_ ~= 1 then
		var_3_0 = 2
	end

	local var_3_1 = getChapterNumList(var_3_0)[arg_3_0.hardLevel_][1]

	arg_3_0.isLock_ = not ChapterTools.IsFinishPreChapter(var_3_1)
end

function var_0_0.LockTips(arg_4_0)
	local var_4_0 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	local var_4_1 = BattleFieldData:GetCacheChapter(var_4_0)
	local var_4_2 = 1
	local var_4_3 = getChapterNumList(var_4_2)[arg_4_0.hardLevel_][1]
	local var_4_4, var_4_5 = ChapterTools.IsFinishPreChapter(var_4_3)

	if not var_4_4 then
		ShowTips(ChapterTools.GetChapterLockText(var_4_3, var_4_5, true))

		return
	end

	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function var_0_0.ClickBtn(arg_5_0)
	if arg_5_0.hardLevel_ == BattleFieldData:GetPlotHardLevel() then
		return
	end

	BattleFieldAction.ChangePlotHardLevel(arg_5_0.hardLevel_)

	if not arg_5_0.isLock_ then
		BattleFieldAction.ChangeSelectChapterID(arg_5_0:GetOpenMaxChapter())
	end
end

function var_0_0.GetOpenMaxChapter(arg_6_0)
	local var_6_0 = arg_6_0.hardLevel_
	local var_6_1 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	local var_6_2 = BattleFieldData:GetCacheChapter(var_6_1)
	local var_6_3 = ChapterCfg[var_6_2].difficulty
	local var_6_4 = getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_6_3)
	local var_6_5 = getChapterList()
	local var_6_6 = table.keyof(var_6_4, var_6_2)

	for iter_6_0 = var_6_6, 1, -1 do
		local var_6_7 = ChapterCfg[var_6_4[iter_6_0]].sub_type

		if var_6_5[var_6_7][var_6_0] then
			local var_6_8 = var_6_5[var_6_7][var_6_0][1]
			local var_6_9 = ChapterCfg[var_6_8].section_id_list[1]

			if var_6_9 and BattleStageData:GetStageData()[var_6_9] then
				return var_6_8
			end
		end
	end

	if arg_6_0.hardLevel_ ~= 1 and var_6_6 <= 1 then
		var_6_6 = 2
	end

	return getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_6_0)[var_6_6]
end

return var_0_0

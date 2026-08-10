local var_0_0 = {}
local var_0_1 = 130
local var_0_2 = 420
local var_0_3 = 115.8307
local var_0_4 = -317.8307

function var_0_0.GetAddPos(arg_1_0)
	if arg_1_0 % 2 == 1 then
		return 662 + (arg_1_0 - 1) / 2 * var_0_2, 0
	else
		return 662 + (var_0_1 + (arg_1_0 - 2) / 2 * var_0_2), var_0_4
	end
end

function var_0_0.GetAllCfgIDsByChapterID(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(ActivityRhythmGameCfg) do
		if iter_2_1 and iter_2_1.chapter_id == arg_2_0 then
			table.insert(var_2_0, iter_2_1.id)
		end
	end

	return var_2_0
end

function var_0_0.GetChapterIDByStageID(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(ActivityRhythmGameCfg) do
		if iter_3_1 and iter_3_1.stage_id == arg_3_0 then
			return iter_3_1.chapter_id or ActivityRhythmGameConst.Chapter_ID.ONE
		end
	end

	for iter_3_2, iter_3_3 in ipairs(ActivityRhythmGameCommandCfg) do
		if iter_3_3 and iter_3_3.stage_id == arg_3_0 then
			return iter_3_3.chapter_id
		end
	end

	return 1
end

function var_0_0.GetCfgIDByStageID(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(ActivityRhythmGameCfg) do
		if iter_4_1 and iter_4_1.stage_id == arg_4_0 then
			return iter_4_1.id or -1
		end
	end
end

function var_0_0.GetSubActivityID(arg_5_0)
	return ActivityCfg[arg_5_0] and ActivityCfg[arg_5_0].sub_activity_list or nil
end

function var_0_0.StartBattle(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = ActivityRhythmGameTools.GetStageData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)

	var_6_0:SetMultiple(false)
	var_6_0:Init()
	BattleController.GetInstance():LaunchBattle(var_6_0)
end

function var_0_0.GetStageData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME, arg_7_1, {
		activityID = arg_7_2,
		cfgID = arg_7_0,
		notActivity = arg_7_3
	})
end

function var_0_0.GetSessionIsLock(arg_8_0, arg_8_1)
	local var_8_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_8_0]

	if var_8_0 then
		local var_8_1 = var_8_0[arg_8_1]

		return var_0_0.GetSessionIsLockByID(var_8_1)
	end

	return false
end

function var_0_0.GetSessionIsLockByID(arg_9_0)
	local var_9_0 = ActivitySummerChessConditionCfg[arg_9_0]

	return not IsConditionAchieved(var_9_0 and var_9_0.condition or 0)
end

function var_0_0.GetStageIsCommand(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(ActivityRhythmGameCommandCfg) do
		if iter_10_1 and iter_10_1.stage_id == arg_10_0 then
			return true
		end
	end

	return false
end

return var_0_0

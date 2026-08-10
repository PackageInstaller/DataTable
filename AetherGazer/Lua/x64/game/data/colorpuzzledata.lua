local var_0_0 = singletonClass("ColorPuzzleData")

function var_0_0.Init(arg_1_0)
	arg_1_0.levelClear = {}
	arg_1_0.clearedLevelCnt = 0
end

function var_0_0.SetFinishedLevels(arg_2_0, arg_2_1)
	arg_2_0.levelClear = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.levelClear[iter_2_1] = true
	end

	arg_2_0.clearedLevelCnt = #arg_2_1
end

function var_0_0.GetClearedLevelCount(arg_3_0)
	return arg_3_0.clearedLevelCnt
end

function var_0_0.IsLevelCleared(arg_4_0, arg_4_1)
	return arg_4_0.levelClear[arg_4_1] ~= nil
end

function var_0_0.IsLevelUnlocked(arg_5_0, arg_5_1)
	local var_5_0 = ActivityHeroChallengeColor[arg_5_1].pre_stage
	local var_5_1

	if var_5_0 ~= 0 and not arg_5_0:IsLevelCleared(var_5_0) then
		local var_5_2 = "ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK"

		return false, var_5_2
	end

	return true
end

function var_0_0.IsLevelCanNotChallenge(arg_6_0, arg_6_1)
	if arg_6_0:IsLevelCleared(arg_6_1) then
		return false
	end

	local var_6_0
	local var_6_1, var_6_2 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(SpHeroChallengeConst.ScheduleSubType.decode)

	if var_6_1 <= var_6_2 then
		local var_6_3 = GetTips("ACTIVITY_HERO_CHALLENGE_TIME_NULL")

		return true, var_6_3
	end
end

function var_0_0.GetLevelClearTime(arg_7_0, arg_7_1)
	return getData("colorPuzzleLevel", tostring(arg_7_1))
end

function var_0_0.UpdateLevelClearTime(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = true

	if not arg_8_3 then
		var_8_0 = arg_8_2 < (arg_8_0:GetLevelClearTime(arg_8_1) or math.huge)
	end

	if var_8_0 then
		saveData("colorPuzzleLevel", tostring(arg_8_1), arg_8_2)
	end
end

function var_0_0.GetNextStage(arg_9_0)
	local var_9_0 = ActivityHeroChallengeColor.all[1]

	if not next(arg_9_0.levelClear) then
		return var_9_0
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.levelClear) do
		var_9_0 = math.max(var_9_0, iter_9_0)
	end

	local var_9_1 = ActivityHeroChallengeColor.all[#ActivityHeroChallengeColor.all]

	for iter_9_2, iter_9_3 in ipairs(ActivityHeroChallengeColor.all) do
		if ActivityHeroChallengeColor[iter_9_3].pre_stage == var_9_0 then
			var_9_1 = iter_9_3

			break
		end
	end

	return var_9_1
end

function var_0_0.GetNextStageName(arg_10_0)
	local var_10_0 = #arg_10_0.levelClear + 1
	local var_10_1 = ActivityHeroChallengeColor.all[var_10_0]

	if var_10_1 then
		return ActivityHeroChallengeColor[var_10_1].name
	end
end

return var_0_0

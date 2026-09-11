local var_0_0 = singletonClass("ColorPuzzleData")

function var_0_0.Init(arg_1_0)
	arg_1_0.levelClear = {}
	arg_1_0.clearedLevelCnt = 0
end

function var_0_0:SetFinishedLevels(arg_2_1)
	self.levelClear = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.levelClear[iter_2_1] = true
	end

	self.clearedLevelCnt = #arg_2_1
end

function var_0_0:GetClearedLevelCount()
	return self.clearedLevelCnt
end

function var_0_0:IsLevelCleared(arg_4_1)
	return self.levelClear[arg_4_1] ~= nil
end

function var_0_0:IsLevelUnlocked(arg_5_1)
	if ActivityHeroChallengeColor[arg_5_1].pre_stage ~= 0 and not self:IsLevelCleared(ActivityHeroChallengeColor[arg_5_1].pre_stage) then
		return false, "ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK"
	end

	return true
end

function var_0_0:IsLevelCanNotChallenge(arg_6_1)
	if self:IsLevelCleared(arg_6_1) then
		return false
	end

	local var_6_1, var_6_2 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(SpHeroChallengeConst.ScheduleSubType.decode)

	if var_6_1 <= var_6_2 then
		return true, (GetTips("ACTIVITY_HERO_CHALLENGE_TIME_NULL"))
	end
end

function var_0_0.GetLevelClearTime(arg_7_0, arg_7_1)
	return getData("colorPuzzleLevel", tostring(arg_7_1))
end

function var_0_0:UpdateLevelClearTime(arg_8_1, arg_8_2, arg_8_3)
	if (not arg_8_3 or nil) and arg_8_2 < (self:GetLevelClearTime(arg_8_1) or math.huge) then
		saveData("colorPuzzleLevel", tostring(arg_8_1), arg_8_2)
	end
end

function var_0_0:GetNextStage()
	local var_9_0 = ActivityHeroChallengeColor.all[1]

	if not next(self.levelClear) then
		return var_9_0
	end

	for iter_9_0, iter_9_1 in pairs(self.levelClear) do
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

function var_0_0:GetNextStageName()
	if ActivityHeroChallengeColor.all[#self.levelClear + 1] then
		return ActivityHeroChallengeColor[ActivityHeroChallengeColor.all[#self.levelClear + 1]].name
	end
end

return var_0_0

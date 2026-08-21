local var_0_0 = singletonClass("SoloHeartDemonData")
local var_0_1 = {}
local var_0_2 = 999999999

function var_0_0.Init(arg_1_0)
	var_0_1:Init()
end

function var_0_0.InitSoloHeartDemonData(arg_2_0, arg_2_1)
	var_0_1:InitSoloHeartDemonData(arg_2_1)
end

function var_0_0.UpdateRewardList(arg_3_0, arg_3_1)
	var_0_1:UpdateRewardList(arg_3_1)
	var_0_1:TaskSort()
end

function var_0_0.GetDataByPara(arg_4_0, arg_4_1)
	return var_0_1[arg_4_1]
end

function var_0_0.ResetSelectDifficulty(arg_5_0)
	var_0_1:ResetSelectDifficulty()
end

function var_0_0.UpdateBattleFinishData(arg_6_0, ...)
	local var_6_0 = {
		...
	}

	var_0_1:UpdateBattleFinishData(var_6_0)
end

function var_0_0.UpdateBattleFinishScore(arg_7_0, arg_7_1)
	var_0_1:UpdateBattleFinishScore(arg_7_1)
end

function var_0_1.Init(arg_8_0)
	arg_8_0.taskData = {}
	arg_8_0.maxExtremelyDodgeTimes = 0
	arg_8_0.shortestBattleTime = var_0_2
	arg_8_0.maxScore = 0
	arg_8_0.minInjure = var_0_2
	arg_8_0.rewardList = {}
	arg_8_0.stageToDifficulty = {}

	for iter_8_0, iter_8_1 in ipairs(SoloHeartDemonCfg.all) do
		local var_8_0 = SoloHeartDemonCfg[iter_8_1]

		for iter_8_2, iter_8_3 in ipairs(var_8_0.stage_id) do
			arg_8_0.stageToDifficulty[iter_8_3[2]] = iter_8_3[1]
		end
	end

	arg_8_0.normalTaskList = {}
	arg_8_0.rankTaskList = {}
	arg_8_0.maxCompleteDifficulty = 0

	for iter_8_4, iter_8_5 in ipairs(SoloHeartDemonRewardCfg.get_id_list_by_reward_type[1]) do
		table.insert(arg_8_0.normalTaskList, iter_8_5)
	end

	for iter_8_6, iter_8_7 in ipairs(SoloHeartDemonRewardCfg.get_id_list_by_reward_type[0]) do
		table.insert(arg_8_0.rankTaskList, iter_8_7)
	end
end

function var_0_1.InitSoloHeartDemonData(arg_9_0, arg_9_1)
	arg_9_0.maxExtremelyDodgeTimes = 0
	arg_9_0.shortestBattleTime = var_0_2
	arg_9_0.maxScore = 0
	arg_9_0.maxCompleteDifficulty = 0
	arg_9_0.minInjure = var_0_2
	arg_9_0.rewardList = {}
	arg_9_0.openEditor = SoloHeartDemonCfg.get_id_list_by_activity_id[arg_9_1.open_edition]

	if arg_9_0.openEditor ~= nil then
		arg_9_0.openEditor = arg_9_0.openEditor[1]
	end

	arg_9_0.difficultyData = arg_9_0:ParseDifficultyData(arg_9_1.info_list)
	arg_9_0.challengeStage = arg_9_1.challenge_stage

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.obtained_reward_list) do
		arg_9_0.rewardList[iter_9_1] = 1
	end

	arg_9_0:UpdateData()
	arg_9_0:TaskSort()
	SoloHeartDemonAction.UpdateRewardRedPoint()
end

function var_0_1.UpdateData(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.difficultyData) do
		arg_10_0.maxExtremelyDodgeTimes = math.max(arg_10_0.maxExtremelyDodgeTimes, iter_10_1.maxExtremelyDodgeTimes)
		arg_10_0.shortestBattleTime = math.min(arg_10_0.shortestBattleTime, iter_10_1.shortestBattleTime)
		arg_10_0.maxScore = math.max(arg_10_0.maxScore, iter_10_1.maxScore)
		arg_10_0.maxCompleteDifficulty = iter_10_1.challengeState == 2 and iter_10_0 or arg_10_0.maxCompleteDifficulty
		arg_10_0.minInjure = math.min(arg_10_0.minInjure, iter_10_1.minInjure)
	end
end

function var_0_1.UpdateRewardList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.reward_list) do
		arg_11_0.rewardList[iter_11_1] = 1
	end
end

function var_0_1.ResetSelectDifficulty(arg_12_0)
	arg_12_0.selectDifficulty = nil
end

function var_0_1.UpdateBattleFinishData(arg_13_0, arg_13_1)
	if arg_13_0.challengeStage ~= 0 then
		ShowTips("SOLO_HEART_DEMON_COMBAT_TIME_OUT")

		return
	end

	local var_13_0 = arg_13_1[2] or var_0_2
	local var_13_1 = arg_13_1[3] or 0
	local var_13_2 = arg_13_1[4] or var_0_2
	local var_13_3 = arg_13_1[5] or 0
	local var_13_4 = arg_13_1[6] or var_0_2
	local var_13_5 = arg_13_1[7]
	local var_13_6 = arg_13_0.stageToDifficulty[var_13_5]
	local var_13_7 = arg_13_0.difficultyData[var_13_6]

	var_13_7.challengeState = var_13_7.challengeState == 2 and 2 or arg_13_1[1]
	var_13_7.maxExtremelyDodgeTimes = var_13_3 + var_13_7.maxExtremelyDodgeTimes
	var_13_7.hitTime = math.min(var_13_4, var_13_7.hitTime)
	var_13_7.shortestBattleTime = math.min(var_13_0, var_13_7.shortestBattleTime)
	var_13_7.maxScore = math.max(var_13_1, var_13_7.maxScore)
	var_13_7.minInjure = math.min(var_13_2, var_13_7.minInjure)
	arg_13_0.selectDifficulty = var_13_6

	arg_13_0:UpdateData()
	arg_13_0:TaskSort()
	SoloHeartDemonAction.UpdateRewardRedPoint()
end

function var_0_1.ParseDifficultyData(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0 = 1, 3 do
		var_14_0[iter_14_0] = arg_14_0:DefaultData()
	end

	for iter_14_1, iter_14_2 in ipairs(arg_14_1) do
		local var_14_1 = iter_14_2.difficulty

		var_14_0[var_14_1].difficulty = iter_14_2.difficulty
		var_14_0[var_14_1].challengeState = iter_14_2.challenge_state
		var_14_0[var_14_1].maxExtremelyDodgeTimes = iter_14_2.max_extremely_dodge_times

		if iter_14_2.challenge_state == 2 then
			var_14_0[var_14_1].shortestBattleTime = iter_14_2.shortest_battle_clear_time
			var_14_0[var_14_1].maxScore = iter_14_2.max_score
			var_14_0[var_14_1].minInjure = iter_14_2.least_injure_num
			var_14_0[var_14_1].hitTime = iter_14_2.least_hit_num
		end
	end

	return var_14_0
end

function var_0_1.DefaultData(arg_15_0)
	return {
		difficulty = 0,
		maxScore = 0,
		challengeState = 0,
		maxExtremelyDodgeTimes = 0,
		shortestBattleTime = var_0_2,
		minInjure = var_0_2,
		hitTime = var_0_2
	}
end

function var_0_1.GetTaskStatus(arg_16_0, arg_16_1)
	local var_16_0 = SoloHeartDemonRewardCfg[arg_16_1].condition
	local var_16_1 = ConditionCfg[var_16_0]
	local var_16_2 = 0

	if var_16_1.type == 11001 then
		var_16_2 = arg_16_0.maxCompleteDifficulty >= var_16_1.params[1] and 1 or 0
		arg_16_0.taskData[arg_16_1] = {
			arg_16_0.maxCompleteDifficulty >= var_16_1.params[1] and 1 or 0,
			1
		}
	elseif var_16_1.type == 11002 then
		var_16_2 = arg_16_0.difficultyData[var_16_1.params[1]].challengeState > 0 and 1 or 0
		arg_16_0.taskData[arg_16_1] = {
			arg_16_0.difficultyData[var_16_1.params[1]].challengeState > 0 and 1 or 0,
			1
		}
	elseif var_16_1.type == 11003 then
		var_16_2 = arg_16_0.shortestBattleTime < var_16_1.params[1] and 1 or 0
		arg_16_0.taskData[arg_16_1] = {
			arg_16_0.shortestBattleTime < var_16_1.params[1] and 1 or 0,
			1
		}
	elseif var_16_1.type == 11004 then
		var_16_2 = arg_16_0.maxExtremelyDodgeTimes > var_16_1.params[1] and 1 or 0
		arg_16_0.taskData[arg_16_1] = {
			arg_16_0.maxExtremelyDodgeTimes >= var_16_1.params[1] and var_16_1.params[1] or arg_16_0.maxExtremelyDodgeTimes,
			var_16_1.params[1]
		}
	elseif var_16_1.type == 11005 then
		var_16_2 = arg_16_0.maxScore > var_16_1.params[1] and 1 or 0
		arg_16_0.taskData[arg_16_1] = {
			arg_16_0.maxScore > var_16_1.params[1] and 1 or 0,
			1
		}
	end

	var_16_2 = arg_16_0.rewardList[arg_16_1] and 0 or 1 + var_16_2

	return var_16_2
end

function var_0_1.UpdateBattleFinishScore(arg_17_0, arg_17_1)
	arg_17_0.battleScore = arg_17_1
end

function var_0_1.TaskSort(arg_18_0)
	table.sort(arg_18_0.normalTaskList, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_18_0:GetTaskStatus(arg_19_0)
		local var_19_1 = arg_18_0:GetTaskStatus(arg_19_1)

		if var_19_0 ~= var_19_1 then
			return var_19_1 < var_19_0
		end

		return arg_19_1 < arg_19_0
	end)
end

return var_0_0

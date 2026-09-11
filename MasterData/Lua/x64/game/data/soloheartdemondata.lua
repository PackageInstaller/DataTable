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
	var_0_1:UpdateBattleFinishData({
		...
	})
end

function var_0_0.UpdateBattleFinishScore(arg_7_0, arg_7_1)
	var_0_1:UpdateBattleFinishScore(arg_7_1)
end

function var_0_1:Init()
	self.taskData = {}
	self.maxExtremelyDodgeTimes = 0
	self.shortestBattleTime = var_0_2
	self.maxScore = 0
	self.minInjure = var_0_2
	self.rewardList = {}
	self.stageToDifficulty = {}

	for iter_8_0, iter_8_1 in ipairs(SoloHeartDemonCfg.all) do
		for iter_8_2, iter_8_3 in ipairs(SoloHeartDemonCfg[iter_8_1].stage_id) do
			self.stageToDifficulty[iter_8_3[2]] = iter_8_3[1]
		end
	end

	self.normalTaskList = {}
	self.rankTaskList = {}
	self.maxCompleteDifficulty = 0

	for iter_8_4, iter_8_5 in ipairs(SoloHeartDemonRewardCfg.get_id_list_by_reward_type[1]) do
		table.insert(self.normalTaskList, iter_8_5)
	end

	for iter_8_6, iter_8_7 in ipairs(SoloHeartDemonRewardCfg.get_id_list_by_reward_type[0]) do
		table.insert(self.rankTaskList, iter_8_7)
	end
end

function var_0_1:InitSoloHeartDemonData(arg_9_1)
	self.maxExtremelyDodgeTimes = 0
	self.shortestBattleTime = var_0_2
	self.maxScore = 0
	self.maxCompleteDifficulty = 0
	self.minInjure = var_0_2
	self.rewardList = {}
	self.openEditor = SoloHeartDemonCfg.get_id_list_by_activity_id[arg_9_1.open_edition]

	if self.openEditor ~= nil then
		self.openEditor = self.openEditor[1]
	end

	self.difficultyData = self:ParseDifficultyData(arg_9_1.info_list)
	self.challengeStage = arg_9_1.challenge_stage

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.obtained_reward_list) do
		self.rewardList[iter_9_1] = 1
	end

	self:UpdateData()
	self:TaskSort()
	SoloHeartDemonAction.UpdateRewardRedPoint()
end

function var_0_1:UpdateData()
	for iter_10_0, iter_10_1 in pairs(self.difficultyData) do
		self.maxExtremelyDodgeTimes = math.max(self.maxExtremelyDodgeTimes, iter_10_1.maxExtremelyDodgeTimes)
		self.shortestBattleTime = math.min(self.shortestBattleTime, iter_10_1.shortestBattleTime)
		self.maxScore = math.max(self.maxScore, iter_10_1.maxScore)
		self.maxCompleteDifficulty = iter_10_1.challengeState == 2 and iter_10_0 or self.maxCompleteDifficulty
		self.minInjure = math.min(self.minInjure, iter_10_1.minInjure)
	end
end

function var_0_1:UpdateRewardList(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.reward_list) do
		self.rewardList[iter_11_1] = 1
	end
end

function var_0_1.ResetSelectDifficulty(arg_12_0)
	arg_12_0.selectDifficulty = nil
end

function var_0_1:UpdateBattleFinishData(arg_13_1)
	if self.challengeStage ~= 0 then
		ShowTips("SOLO_HEART_DEMON_COMBAT_TIME_OUT")

		return
	end

	local var_13_0 = arg_13_1[2] or var_0_2
	local var_13_1 = arg_13_1[3] or 0
	local var_13_2 = arg_13_1[4] or var_0_2
	local var_13_3 = self.stageToDifficulty[arg_13_1[7]]
	local var_13_4 = self.difficultyData[self.stageToDifficulty[arg_13_1[7]]]

	var_13_4.challengeState = self.difficultyData[self.stageToDifficulty[arg_13_1[7]]].challengeState == 2 and 2 or arg_13_1[1]
	var_13_4.maxExtremelyDodgeTimes = (arg_13_1[5] or 0) + var_13_4.maxExtremelyDodgeTimes
	var_13_4.hitTime = math.min(arg_13_1[6] or var_0_2, var_13_4.hitTime)
	var_13_4.shortestBattleTime = math.min(var_13_0, var_13_4.shortestBattleTime)
	var_13_4.maxScore = math.max(var_13_1, var_13_4.maxScore)
	var_13_4.minInjure = math.min(var_13_2, var_13_4.minInjure)
	self.selectDifficulty = var_13_3

	self:UpdateData()
	self:TaskSort()
	SoloHeartDemonAction.UpdateRewardRedPoint()
end

function var_0_1:ParseDifficultyData(arg_14_1)
	local var_14_0 = {}

	for iter_14_0 = 1, 3 do
		var_14_0[iter_14_0] = self:DefaultData()
	end

	for iter_14_1, iter_14_2 in ipairs(arg_14_1) do
		var_14_0[iter_14_2.difficulty].difficulty = iter_14_2.difficulty
		var_14_0[iter_14_2.difficulty].challengeState = iter_14_2.challenge_state
		var_14_0[iter_14_2.difficulty].maxExtremelyDodgeTimes = iter_14_2.max_extremely_dodge_times

		if iter_14_2.challenge_state == 2 then
			var_14_0[iter_14_2.difficulty].shortestBattleTime = iter_14_2.shortest_battle_clear_time
			var_14_0[iter_14_2.difficulty].maxScore = iter_14_2.max_score
			var_14_0[iter_14_2.difficulty].minInjure = iter_14_2.least_injure_num
			var_14_0[iter_14_2.difficulty].hitTime = iter_14_2.least_hit_num
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

function var_0_1:GetTaskStatus(arg_16_1)
	local var_16_0 = ConditionCfg[SoloHeartDemonRewardCfg[arg_16_1].condition]
	local var_16_1 = 0

	if ConditionCfg[SoloHeartDemonRewardCfg[arg_16_1].condition].type == 11001 then
		var_16_1 = self.maxCompleteDifficulty >= var_16_0.params[1] and 1 or 0
		self.taskData[arg_16_1] = {
			self.maxCompleteDifficulty >= var_16_0.params[1] and 1 or 0,
			1
		}
	elseif var_16_0.type == 11002 then
		var_16_1 = self.difficultyData[var_16_0.params[1]].challengeState > 0 and 1 or 0
		self.taskData[arg_16_1] = {
			self.difficultyData[var_16_0.params[1]].challengeState > 0 and 1 or 0,
			1
		}
	elseif var_16_0.type == 11003 then
		var_16_1 = self.shortestBattleTime < var_16_0.params[1] and 1 or 0
		self.taskData[arg_16_1] = {
			self.shortestBattleTime < var_16_0.params[1] and 1 or 0,
			1
		}
	elseif var_16_0.type == 11004 then
		var_16_1 = self.maxExtremelyDodgeTimes > var_16_0.params[1] and 1 or 0

		local var_16_2 = {}

		if self.maxExtremelyDodgeTimes >= var_16_0.params[1] then
			var_16_2[1] = var_16_0.params[1] or self.maxExtremelyDodgeTimes
		end

		var_16_2[2] = var_16_0.params[1]
		self.taskData[arg_16_1] = var_16_2
	elseif var_16_0.type == 11005 then
		var_16_1 = self.maxScore > var_16_0.params[1] and 1 or 0
		self.taskData[arg_16_1] = {
			self.maxScore > var_16_0.params[1] and 1 or 0,
			1
		}
	end

	var_16_1 = self.rewardList[arg_16_1] and 0 or 1 + var_16_1

	return var_16_1
end

function var_0_1.UpdateBattleFinishScore(arg_17_0, arg_17_1)
	arg_17_0.battleScore = arg_17_1
end

function var_0_1:TaskSort()
	table.sort(self.normalTaskList, function(arg_19_0, arg_19_1)
		local var_19_0 = self:GetTaskStatus(arg_19_0)
		local var_19_1 = self:GetTaskStatus(arg_19_1)

		if var_19_0 ~= var_19_1 then
			return var_19_1 < var_19_0
		end

		return arg_19_1 < arg_19_0
	end)
end

return var_0_0

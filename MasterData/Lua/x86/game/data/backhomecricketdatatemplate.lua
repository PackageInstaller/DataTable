BackHomeCricketBattleResult = class("BackHomeCricketBattleResult")

function BackHomeCricketBattleResult:InitRoundList(arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_1 = {
			roundIndex = iter_1_1.round_index,
			myAction = self:InitActionOrder(iter_1_1.attack_user_action),
			enemyAction = self:InitActionOrder(iter_1_1.defend_user_action),
			myScore = self:InitScoreData(iter_1_1.attack_user_score),
			enemyScore = self:InitScoreData(iter_1_1.defend_user_score)
		}

		if var_1_0[iter_1_1.round_index] then
			Debugger.LogError("有重复数据初始化，回合数为" .. iter_1_1.round_index)

			return
		end

		var_1_0[iter_1_1.round_index] = var_1_1
	end

	return var_1_0, #var_1_0
end

local function var_0_0(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		table.insert(var_2_0, tonumber(iter_2_1))
	end

	return var_2_0
end

function BackHomeCricketBattleResult.InitPrepareInfo(arg_3_0, arg_3_1)
	return {
		myActiveBuffList = var_0_0(arg_3_1.attacker_active_buff_list),
		enemyActiveBuffList = var_0_0(arg_3_1.defender_active_buff_list)
	}
end

function BackHomeCricketBattleResult:Ctor(arg_4_1, arg_4_2, arg_4_3)
	self.settleType = arg_4_3
	self.mySkinID = arg_4_1.attacker_skin_id
	self.enemySkinID = arg_4_1.defender_skin_id
	self.prepareInfo = self:InitPrepareInfo(arg_4_1.prepare_info)
	self.roundList, self.lastRound = self:InitRoundList(arg_4_1.round_list)

	if arg_4_3 == BackHomeCricketConst.ROOM_TYPE.Video then
		self.stageID = arg_4_1.stage_id
		self.battle_result = arg_4_1.battle_result
		self.attacker_data = arg_4_1.attacker_data
		self.defender_data = arg_4_1.defender_data
		self.battleID = arg_4_2.battle_id
		self.battleType = IdolTraineeData:GetHistoryBattleData()[self.battleID].friendType
	else
		self.stageID = arg_4_2.stage_id
		self.battleType = arg_4_2.battle_type
		self.enemyID = arg_4_2.defender_uid
	end
end

function BackHomeCricketBattleResult.AddCompleteInfo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.attacker_data = arg_5_2.attacker_data
	arg_5_0.defender_data = arg_5_2.defender_data
	arg_5_0.battle_result = arg_5_2.battle_result
end

function BackHomeCricketBattleResult.InitActionOrder(arg_6_0, arg_6_1)
	local var_6_0 = {
		actionID = arg_6_1.atk_style_id,
		skillID = arg_6_1.skill_id
	}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.index_list) do
		table.insert(var_6_1, iter_6_1)
	end

	var_6_0.effectList = var_6_1

	return var_6_0
end

function BackHomeCricketBattleResult.InitScoreData(arg_7_0, arg_7_1)
	return {
		type = arg_7_1.peculiarity_score,
		actionScore = arg_7_1.skill_score,
		isHit = arg_7_1.sum_score
	}
end

function BackHomeCricketBattleResult:GetBattleDataByRound(arg_8_1)
	if self.roundList and self.roundList[arg_8_1] then
		return self.roundList[arg_8_1]
	else
		Debugger.LogError("未获取对应回合数据" .. arg_8_1)
	end
end

function BackHomeCricketBattleResult.Dispose(arg_9_0)
	return
end

local var_0_0 = class("BattleMultHeartDemonTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.levelID_ = 1
	arg_1_0.cfg = BattleMultiHeartDemonCfg[arg_1_1]
	arg_1_0.heroID = arg_1_2.heroID
	arg_1_0.difficult = arg_1_2.difficult
	arg_1_0.data = MultHeartDemonData:GetDataByPara("difficultyData")

	if arg_1_0.data then
		arg_1_0.data = arg_1_0.data[arg_1_0.difficult] or {}
	end

	arg_1_0.heroHPList = arg_1_0.data.heroHPList or {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.InitChipData(arg_3_0)
	arg_3_0.chipList_ = {}
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg.ai_level
end

function var_0_0.GetDifficult(arg_9_0)
	return arg_9_0.difficult
end

function var_0_0.GetEnemyLevel(arg_10_0)
	return arg_10_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_11_0)
	arg_11_0.heroList_ = {
		arg_11_0.heroID,
		[2] = 0,
		[3] = 0
	}

	if arg_11_0.heroID >= 10000 then
		arg_11_0.heroTrialList_ = {
			arg_11_0.heroID,
			[2] = 0,
			[3] = 0
		}
	end

	return arg_11_0.heroList_, arg_11_0.heroTrialList_
end

function var_0_0.GetLevelID(arg_12_0)
	return arg_12_0.cfg.level
end

function var_0_0.GetMainActivityID(arg_13_0)
	return arg_13_0.activityID_
end

function var_0_0.UpdateRoleDatas(arg_14_0, arg_14_1)
	arg_14_0.serverTeamPlayer = arg_14_1
	arg_14_0.roleDataInLua = {}

	local var_14_0 = arg_14_0:GetSystemHeroTeam()

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.heroList) do
		local var_14_1 = iter_14_1.trialID ~= 0 and iter_14_1.trialID or var_14_0[iter_14_0] or 0
		local var_14_2 = BattleController.GetInstance():MultiHeartDemonSetHeroData(iter_14_1, var_14_1, arg_14_1.playerID, arg_14_1.level, (arg_14_0.heroHPList[arg_14_0.heroList_[1]] or 100) / 100)

		table.insert(arg_14_0.roleDataInLua, var_14_2)
	end

	arg_14_0:SetMaxRaceData()
end

function var_0_0.GetAttributeFactor(arg_15_0)
	local var_15_0 = MultHeartDemonData:GetDataByPara("difficultyData")

	var_15_0 = var_15_0 and (var_15_0[arg_15_0.difficult] or {})

	local var_15_1 = var_15_0.heroHPList or {}
	local var_15_2 = MultHeartDemonData:GetBossIdByStageId(arg_15_0.id)
	local var_15_3 = var_15_1[var_15_2] and var_15_1[var_15_2] / 100 or 1

	return Vector3.New(arg_15_0.cfg.attribute_factor[1] / 1000, arg_15_0.cfg.attribute_factor[2] / 1000, arg_15_0.cfg.attribute_factor[3] / 1000 * var_15_3)
end

return var_0_0

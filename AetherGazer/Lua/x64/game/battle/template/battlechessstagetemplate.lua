local var_0_0 = class("BattleChessStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleChessStageCfg[arg_1_1]
	arg_1_0.nextBattleStage_ = nil
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.UpdateRoleDatas(arg_10_0, arg_10_1)
	arg_10_0.serverTeamPlayer = arg_10_1
	arg_10_0.roleDataInLua = {}

	local var_10_0 = arg_10_0:GetSystemHeroTeam()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.heroList) do
		local var_10_1 = iter_10_1.trialID ~= 0 and iter_10_1.trialID or var_10_0[iter_10_0] or 0
		local var_10_2 = BattleController.GetInstance():SetChessHeroData(iter_10_1, var_10_1, arg_10_1.playerID, arg_10_1.level)

		table.insert(arg_10_0.roleDataInLua, var_10_2)
	end

	arg_10_0:SetMaxRaceData()
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = WarChessData:GetArtifactData()

	for iter_11_0, iter_11_1 in pairs(var_11_3) do
		local var_11_4 = WarchessItemCfg[iter_11_0]

		if not var_11_4 then
			CustomLog.Log("不存在的战棋神器:" .. iter_11_0)
		end

		for iter_11_2, iter_11_3 in ipairs(var_11_4.params) do
			table.insert(var_11_0, iter_11_3[1])
			table.insert(var_11_1, iter_11_3[2])
			table.insert(var_11_2, var_11_4.sub_affix_type)
		end
	end

	local var_11_5 = ActivityTools.GetActivityTheme(arg_11_0.activityID_)
	local var_11_6 = TalentTreeData:GetTalentListByTheme(var_11_5)

	for iter_11_4, iter_11_5 in ipairs(var_11_6) do
		table.insert(var_11_0, iter_11_5[1])
		table.insert(var_11_1, iter_11_5[2])
		table.insert(var_11_2, iter_11_5[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function var_0_0.GetServerExtant(arg_12_0)
	return WarChessData:GetBattleIndex()
end

function var_0_0.GetNextStage(arg_13_0)
	return arg_13_0.nextBattleStage_
end

function var_0_0.SetNextStage(arg_14_0, arg_14_1)
	arg_14_0.nextBattleStage_ = arg_14_1
end

return var_0_0

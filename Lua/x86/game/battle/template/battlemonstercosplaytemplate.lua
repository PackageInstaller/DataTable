local var_0_0 = class("BattleMonsterCosplayTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.levelID_ = arg_1_2.levelID
	arg_1_0.cfg = BattleActivityMonsterCosplayCfg[arg_1_1]
	arg_1_0.monsterID = arg_1_2.monsterID
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
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[arg_11_0.monsterID]
	local var_11_1 = MonsterCosplayData:GetDataByPara("monsterData")[arg_11_0.monsterID].enhancedSkill
	local var_11_2 = {}
	local var_11_3 = {}
	local var_11_4 = {}

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		local var_11_5 = TalentTreeCfg[iter_11_0]

		table.insert(var_11_2, var_11_5.affix_id)
		table.insert(var_11_3, 1)
		table.insert(var_11_4, var_11_5.affix_user)
	end

	for iter_11_2, iter_11_3 in pairs(var_11_0) do
		if iter_11_3 then
			local var_11_6 = TalentTreeCfg[iter_11_2]

			table.insert(var_11_2, var_11_6.affix_id)
			table.insert(var_11_3, 1)
			table.insert(var_11_4, var_11_6.affix_user)
		end
	end

	return var_11_2, var_11_3, var_11_4
end

function var_0_0.GetLevelID(arg_12_0)
	return arg_12_0.cfg.level
end

function var_0_0.GetMainActivityID(arg_13_0)
	return arg_13_0.activityID_
end

function var_0_0.GetRevive(arg_14_0)
	if type(arg_14_0.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_14_0 = arg_14_0.cfg.is_revive
	local var_14_1 = var_14_0[1] and true or false
	local var_14_2 = var_14_0[1] or 0
	local var_14_3 = var_14_0[1] and ItemTools.getItemNum(var_14_0[1]) or 0
	local var_14_4 = var_14_0[2] or 0

	return var_14_1, var_14_2, var_14_3, var_14_4
end

return var_0_0

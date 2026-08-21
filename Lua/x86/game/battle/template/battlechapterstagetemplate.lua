local var_0_0 = class("BattleChapterStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
end

function var_0_0.Init(arg_2_0)
	arg_2_0.cfg = BattleChapterStageCfg[arg_2_0:GetStageId()]

	if BattleConst.BATTLE_TAG.STORY == arg_2_0.cfg.tag then
		arg_2_0.heroList_ = {}
		arg_2_0.heroTrialList_ = {}
	else
		arg_2_0:InitHeroList()
	end

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
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
end

function var_0_0.GetMap(arg_6_0)
	local var_6_0 = arg_6_0.cfg.id
	local var_6_1 = GameSetting.guide_map.value2[var_6_0]
	local var_6_2 = BattleStageData:GetStageData()[var_6_0]

	if var_6_2 == nil then
		if var_6_1 then
			return var_6_1, true
		else
			return arg_6_0.cfg.map, false
		end
	end

	if (not var_6_2.clear_times or var_6_2.clear_times <= 0) and var_6_1 then
		return var_6_1, true
	end

	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
end

function var_0_0.GetRevive(arg_9_0)
	if type(arg_9_0.cfg.is_revive) ~= "table" or BattleConst.BATTLE_TAG.STORY == arg_9_0.cfg.tag then
		return false, 0, 0, 0
	end

	local var_9_0 = arg_9_0.cfg.is_revive
	local var_9_1 = var_9_0[1] and true or false
	local var_9_2 = var_9_0[1] or 0
	local var_9_3 = var_9_0[1] and ItemTools.getItemNum(var_9_0[1]) or 0
	local var_9_4 = var_9_0[2] or 0

	return var_9_1, var_9_2, var_9_3, var_9_4
end

function var_0_0.GetClearTime(arg_10_0)
	local var_10_0 = BattleStageData:GetStageData()[arg_10_0.id]

	if var_10_0 and var_10_0.clear_times then
		return var_10_0.clear_times
	else
		return 0
	end
end

function var_0_0.GetHeroTeam(arg_11_0)
	return arg_11_0.heroList_, arg_11_0.heroTrialList_
end

function var_0_0.GetThreeStar(arg_12_0)
	if arg_12_0.cfg.three_star_need == "" then
		return {}
	end

	return arg_12_0.cfg.three_star_need
end

function var_0_0.GetAddUserExp(arg_13_0)
	return arg_13_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_14_0)
	return arg_14_0.cfg.hero_exp or 0
end

function var_0_0.GetCost(arg_15_0)
	return arg_15_0.cfg.cost or 0
end

return var_0_0

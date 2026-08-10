local var_0_0 = class("BattleSummerPubTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattleSummerPubStageCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
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
	return SummerPubData:GetLevelIDByStageID(arg_3_0.id)
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.SUMMER_PUB
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetActivityID(arg_7_0)
	return ActivityConst.ACTIVITY_NYA_SUMMER_PUB
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

function var_0_0.GetRevive(arg_11_0)
	if type(arg_11_0.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_11_0 = arg_11_0.cfg.is_revive
	local var_11_1 = var_11_0[1] and true or false
	local var_11_2 = var_11_0[1] or 0
	local var_11_3 = var_11_0[1] and ItemTools.getItemNum(var_11_0[1]) or 0
	local var_11_4 = var_11_0[2] or 0

	return var_11_1, var_11_2, var_11_3, var_11_4
end

return var_0_0

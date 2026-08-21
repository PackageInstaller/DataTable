local var_0_0 = class("BattleOsirisStoryStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleActivityStoryStageCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	if BattleConst.BATTLE_TAG.STORY == arg_2_0.cfg.tag then
		arg_2_0.heroList = {}
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
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY
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
	return arg_9_0.heroList, arg_9_0.heroTrialList_
end

function var_0_0.GetAddUserExp(arg_10_0)
	return arg_10_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_11_0)
	return arg_11_0.cfg.hero_exp or 0
end

function var_0_0.GetCost(arg_12_0)
	return arg_12_0.cfg.cost or 0
end

function var_0_0.GetRevive(arg_13_0)
	if type(arg_13_0.cfg.is_revive) ~= "table" or BattleConst.BATTLE_TAG.STORY == arg_13_0.cfg.tag then
		return false, 0, 0, 0
	end

	local var_13_0 = arg_13_0.cfg.is_revive
	local var_13_1 = var_13_0[1] and true or false
	local var_13_2 = var_13_0[1] or 0
	local var_13_3 = var_13_0[1] and ItemTools.getItemNum(var_13_0[1]) or 0
	local var_13_4 = var_13_0[2] or 0

	return var_13_1, var_13_2, var_13_3, var_13_4
end

function var_0_0.GetClearTime(arg_14_0)
	local var_14_0 = arg_14_0.activityID_
	local var_14_1 = StoryStageActivityData:GetHistoryChapter(var_14_0)

	if var_14_1 == nil then
		return 0
	end

	local var_14_2 = StoryStageActivityData:GetStageData(var_14_1)[arg_14_0.id]

	if var_14_2 and var_14_2.clear_times then
		return var_14_2.clear_times
	else
		return 0
	end
end

return var_0_0

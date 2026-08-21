local var_0_0 = class("BattleGodEaterTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.data = arg_1_2
	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattleGodEaterDailyMonsterCfg[arg_1_1]
	arg_1_0.viewType = arg_1_2.viewType
	arg_1_0.activityID_ = arg_1_2.activityId
end

function var_0_0.Init(arg_2_0)
	arg_2_0.heroList_ = arg_2_0.data.heroList
	arg_2_0.heroTrialList_ = arg_2_0.data.heroTrialList
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0:GetStageId()
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_6_0)
	return arg_6_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_8_0)
	return arg_8_0.heroList_, arg_8_0.heroTrialList_
end

function var_0_0.GetAddUserExp(arg_9_0)
	return arg_9_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_10_0)
	return arg_10_0.cfg.hero_exp or 0
end

function var_0_0.GetCost(arg_11_0)
	return arg_11_0.cfg.cost or 0
end

function var_0_0.GetStageAffix(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = WeekBossData:GetSelectTalent(arg_12_0.heroTrialList_[1])

	for iter_12_0, iter_12_1 in pairs(var_12_3) do
		if iter_12_1 ~= 0 then
			table.insert(var_12_0, TalentTreeCfg[iter_12_1].affix_id)
			table.insert(var_12_1, 1)
			table.insert(var_12_2, TalentTreeCfg[iter_12_1].affix_user)
		end
	end

	return var_12_0, var_12_1, var_12_2
end

function var_0_0.GetViewType(arg_13_0)
	return arg_13_0.viewType
end

function var_0_0.GetAttributeFactor(arg_14_0)
	if arg_14_0.cfg.attribute_factor and arg_14_0.cfg.attribute_factor[3] then
		local var_14_0 = arg_14_0.cfg.attribute_factor[1] / 1000
		local var_14_1 = arg_14_0.cfg.attribute_factor[2] / 1000
		local var_14_2 = arg_14_0.cfg.attribute_factor[3] / 1000

		return Vector3.New(var_14_0, var_14_1, var_14_2)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.GetType(arg_15_0)
	return BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE
end

function var_0_0.GetActivityID(arg_16_0)
	return arg_16_0.activityID_
end

return var_0_0

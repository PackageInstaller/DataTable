local var_0_0 = class("BattleActivityWorldBossTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleActivityWorldBossCfg[arg_1_1]
	arg_1_0.roleDataInLua = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetHeroTeam(arg_3_0)
	return arg_3_0.heroList_, arg_3_0.heroTrialList_
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.activityID_
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS
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

function var_0_0.GetAttributeFactor(arg_10_0)
	local var_10_0 = arg_10_0.cfg

	if var_10_0.attribute_factor and var_10_0.attribute_factor[3] then
		local var_10_1 = var_10_0.attribute_factor[1] / 1000
		local var_10_2 = var_10_0.attribute_factor[2] / 1000
		local var_10_3 = var_10_0.attribute_factor[3] / 1000

		return Vector3.New(var_10_1, var_10_2, var_10_3)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = ActivityWorldBossData:GetAffix(arg_11_0.activityID_)
	local var_11_4 = {
		var_11_3
	}

	for iter_11_0, iter_11_1 in pairs(var_11_4 or {}) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	return var_11_0, var_11_1, var_11_2
end

return var_0_0

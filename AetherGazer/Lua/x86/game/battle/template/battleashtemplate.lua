local var_0_0 = class("BattleAshTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityId = AshShootStageCfg[arg_1_2.stageId].activity_id
	arg_1_0.data = arg_1_2
	arg_1_0.cfg = BattleAshShootStageCfg[arg_1_1]
	arg_1_0.roleDataInLua = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.InitHeroList(arg_3_0)
	arg_3_0.heroList_, arg_3_0.heroTrialList_ = {}, {}

	table.insert(arg_3_0.heroList_, 6142)
	table.insert(arg_3_0.heroTrialList_, 614201)
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetActivityID(arg_6_0)
	return arg_6_0.activityId
end

function var_0_0.GetType(arg_7_0)
	return BattleConst.STAGE_TYPE_NEW.ASH_BATTLE
end

function var_0_0.GetMap(arg_8_0)
	return arg_8_0.cfg.map, false
end

function var_0_0.GetName(arg_9_0)
	return arg_9_0.cfg.name
end

function var_0_0.GetAILevel(arg_10_0)
	return arg_10_0.cfg.ai_level or 0
end

function var_0_0.GetEnemyLevel(arg_11_0)
	return arg_11_0.cfg.monster_level
end

function var_0_0.GetStageAffix(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.data.skill) do
		local var_12_3 = AshShootEffectCfg[iter_12_1]

		if var_12_3 and var_12_3.affix_id and var_12_3.affix_id ~= "" then
			table.insert(var_12_0, var_12_3.affix_id[1])
			table.insert(var_12_1, var_12_3.affix_id[2])
			table.insert(var_12_2, var_12_3.affix_id[3])
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.data.item) do
		local var_12_4 = AshShootEffectCfg[iter_12_3.id]

		if var_12_4 and var_12_4.affix_id and var_12_4.affix_id ~= "" then
			table.insert(var_12_0, var_12_4.affix_id[1])
			table.insert(var_12_1, var_12_4.affix_id[2])
			table.insert(var_12_2, var_12_4.affix_id[3])
		end
	end

	for iter_12_4, iter_12_5 in ipairs(arg_12_0.data.weapon) do
		local var_12_5 = AshShootWeaponCfg[iter_12_5.id]

		if var_12_5 and var_12_5.affix_id and var_12_5.affix_id ~= "" then
			table.insert(var_12_0, var_12_5.affix_id[1])
			table.insert(var_12_1, var_12_5.affix_id[2])
			table.insert(var_12_2, var_12_5.affix_id[3])
		end
	end

	return var_12_0, var_12_1, var_12_2
end

function var_0_0.GetChooseSkill(arg_13_0)
	return arg_13_0.data.skill or {}
end

function var_0_0.GetHeroTeam(arg_14_0)
	return arg_14_0.heroList_, arg_14_0.heroTrialList_
end

function var_0_0.GetOpts(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {
		key = 1,
		value = arg_15_0:GetChooseSkill()
	}

	table.insert(var_15_0, var_15_1)

	return var_15_0
end

return var_0_0

local var_0_0 = class("BattleAreaBattleTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleAreaBattleCfg[arg_1_1]
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
	return BattleConst.STAGE_TYPE_NEW.AREA_BATTLE
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

function var_0_0.GetAddUserExp(arg_10_0)
	return arg_10_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_11_0)
	return arg_11_0.cfg.hero_exp or 0
end

function var_0_0.GetCost(arg_12_0)
	return arg_12_0.cfg.cost or 0
end

function var_0_0.GetStageAffix(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = ActivityAreaBattleCfg[arg_13_0.activityID_]

	for iter_13_0, iter_13_1 in ipairs(var_13_3.debuff_list) do
		local var_13_4 = TalentTreeCfg[iter_13_1]

		table.insert(var_13_0, var_13_4.affix_id)
		table.insert(var_13_1, var_13_4.max_level)
		table.insert(var_13_2, var_13_4.affix_user)
	end

	local var_13_5 = getData("AreaBattle", tostring(arg_13_0.id)) or ""

	if var_13_5 ~= "" then
		local var_13_6 = string.split(var_13_5, ".")

		for iter_13_2, iter_13_3 in pairs(var_13_6) do
			if iter_13_3 ~= "" then
				local var_13_7 = TalentTreeCfg[tonumber(string.split(iter_13_3, ",")[1])]

				table.insert(var_13_0, var_13_7.affix_id)
				table.insert(var_13_1, var_13_7.max_level)
				table.insert(var_13_2, var_13_7.affix_user)
			end
		end
	end

	return var_13_0, var_13_1, var_13_2
end

function var_0_0.SetReserveParams(arg_14_0, arg_14_1)
	arg_14_0.reserveParams_ = var_0_0.GetCustomReserveParams(arg_14_0:GetType(), arg_14_0:GetStageId(), arg_14_0:GetActivityID())
	arg_14_0.contID_ = arg_14_0.reserveParams_.contID
	arg_14_0.teamIndex_ = arg_14_0.reserveParams_.teamIndex
	arg_14_0.customReserveParams_ = arg_14_0.reserveParams_.customData
end

function var_0_0.GetReserveParams(arg_15_0)
	if not arg_15_0.reserveParams_ then
		arg_15_0.reserveParams_ = var_0_0.GetCustomReserveParams(arg_15_0:GetType(), arg_15_0:GetStageId(), arg_15_0:GetActivityID())
	end

	return arg_15_0.reserveParams_
end

function var_0_0.GetCustomReserveParams(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ReserveTools.GetReserveType(arg_16_0, arg_16_1)
	local var_16_1 = ReserveTools.GetContID(arg_16_0, arg_16_1)
	local var_16_2 = ActivityCfg.get_id_list_by_sub_activity_list[arg_16_2][1]
	local var_16_3 = ActivityAreaBattleData:GetDataByActivityID(var_16_2)[arg_16_2]
	local var_16_4 = 1

	for iter_16_0, iter_16_1 in pairs(ActivityAreaBattleCfg[arg_16_2].stage_id) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			if iter_16_3 == arg_16_1 then
				var_16_4 = iter_16_0
			end
		end
	end

	local var_16_5 = {
		stageType = arg_16_0,
		stageID = arg_16_1,
		activityID = arg_16_2 or 0,
		data = var_16_3,
		difficult = var_16_4
	}

	return ReserveParams.New(var_16_0, var_16_1, nil, var_16_5)
end

return var_0_0

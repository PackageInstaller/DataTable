local var_0_0 = class("BattleIndiaNianStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.cfg = BattleStageTools.GetStageCfg(arg_1_0:GetType(), arg_1_1)
	arg_1_0.destID_ = IndiaNianData:GetSelectedDestID()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.destID_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.stageID_
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetHeroTeam(arg_7_0)
	return arg_7_0.heroList_, arg_7_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_8_0)
	return arg_8_0.activityID_
end

function var_0_0.GetThreeStar(arg_9_0)
	return {}
end

function var_0_0.GetCost(arg_10_0)
	return IndiaNianData:GetSelectedStageCost()
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = IndiaNianData:GetClearedBossIDList()

	if IndiaNianCfg[IndiaNianData:GetSelectedDestID()].group_id == 100 then
		for iter_11_0, iter_11_1 in ipairs(var_11_3) do
			local var_11_4 = IndiaNianCfg[iter_11_1].affix_reward

			for iter_11_2, iter_11_3 in ipairs(var_11_4) do
				table.insert(var_11_0, iter_11_3[1])
				table.insert(var_11_1, iter_11_3[2])
				table.insert(var_11_2, iter_11_3[3])
			end
		end
	end

	return var_11_0, var_11_1, var_11_2
end

function var_0_0.GetAILevel(arg_12_0)
	return arg_12_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_13_0)
	return arg_13_0.cfg.monster_level
end

return var_0_0

local var_0_0 = class("BattleSeaWarfareStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.cfg_ = BattleSeaWarfareStageCfg[arg_1_0.stageID_]
	arg_1_0.destID_ = arg_1_1

	arg_1_0:InitHeroList()
end

function var_0_0.SetSeaWarfareStageID(arg_2_0, arg_2_1)
	arg_2_0.seaWarfareStageID_ = arg_2_1
end

function var_0_0.GetSeaWarfareStageID(arg_3_0)
	return arg_3_0.seaWarfareStageID_
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitHeroList()
end

function var_0_0.GetDest(arg_5_0)
	return arg_5_0.seaWarfareStageID_
end

function var_0_0.GetStageId(arg_6_0)
	return arg_6_0.stageID_
end

function var_0_0.GetType(arg_7_0)
	return BattleConst.STAGE_TYPE_NEW.SEA_WARFARE
end

function var_0_0.GetMap(arg_8_0)
	return arg_8_0.cfg_.map, false
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.cfg_.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_11_0)
	return arg_11_0.activityId_
end

function var_0_0.SetMarinerIDList(arg_12_0, arg_12_1)
	arg_12_0.marinerIDList_ = arg_12_1
end

function var_0_0.SetSkillID(arg_13_0, arg_13_1)
	arg_13_0.skillID_ = arg_13_1
end

function var_0_0.GetStageAffix(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}

	if arg_14_0.marinerIDList_ then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.marinerIDList_) do
			local var_14_3 = SeaWarfareSkillCfg[iter_14_1].affix_list

			var_14_0[#var_14_0 + 1] = var_14_3[1]
			var_14_1[#var_14_1 + 1] = var_14_3[2]
			var_14_2[#var_14_2 + 1] = var_14_3[3]
		end
	end

	if arg_14_0.skillID_ then
		local var_14_4 = SeaWarfareSkillCfg[arg_14_0.skillID_].affix_list

		var_14_0[#var_14_0 + 1] = var_14_4[1]
		var_14_1[#var_14_1 + 1] = var_14_4[2]
		var_14_2[#var_14_2 + 1] = var_14_4[3]
	end

	return var_14_0, var_14_1, var_14_2
end

function var_0_0.GetServerExtant(arg_15_0)
	return arg_15_0.skillID_
end

return var_0_0

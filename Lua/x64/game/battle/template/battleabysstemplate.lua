local var_0_0 = class("BattleAbyssTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.cfg = BattleAbyssCfg[arg_1_1]
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.curActivityID_ = arg_1_2.curActivityID

	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.SetStageData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.stageIndex_ = arg_3_2
	arg_3_0.layerCfg_ = AbyssData:GetAbyssCfg(arg_3_1)
	arg_3_0.layer_ = arg_3_0.layerCfg_.level
	arg_3_0.stageCfg_ = arg_3_0.layerCfg_.stage_list[arg_3_2]
end

function var_0_0.SetCurActivityID(arg_4_0, arg_4_1)
	arg_4_0.curActivityID_ = arg_4_1
end

function var_0_0.GetActivityID(arg_5_0)
	return arg_5_0.curActivityID_
end

function var_0_0.GetLayerId(arg_6_0)
	return arg_6_0.layer_
end

function var_0_0.GetLayer(arg_7_0)
	return arg_7_0.layer_
end

function var_0_0.GetStageIndex(arg_8_0)
	return arg_8_0.stageIndex_
end

function var_0_0.IsBoss(arg_9_0)
	return arg_9_0.stageCfg_[1] == 3
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetDest(arg_11_0)
	return arg_11_0.id
end

function var_0_0.GetStageId(arg_12_0)
	return arg_12_0.id
end

function var_0_0.GetType(arg_13_0)
	return BattleConst.STAGE_TYPE_NEW.ABYSS
end

function var_0_0.GetMap(arg_14_0)
	return arg_14_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_15_0)
	return arg_15_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_16_0)
	return arg_16_0.cfg.monster_level
end

function var_0_0.GetAttributeFactor(arg_17_0)
	local var_17_0 = arg_17_0.cfg

	if var_17_0.attribute_factor and var_17_0.attribute_factor[3] then
		local var_17_1 = var_17_0.attribute_factor[1] / 1000
		local var_17_2 = var_17_0.attribute_factor[2] / 1000
		local var_17_3 = var_17_0.attribute_factor[3] / 1000
		local var_17_4 = arg_17_0.layerCfg_.stage_list[arg_17_0.stageIndex_]

		if var_17_4[1] == 3 then
			local var_17_5 = AbyssData:GetStageData(arg_17_0.layer_, arg_17_0.stageIndex_)
			local var_17_6 = AbyssBossHpCfg[var_17_4[2]].boss_hp[var_17_5.phase]

			var_17_3 = math.ceil(var_17_6 * var_17_5.boss_hp_rate / 1000) / var_17_6
		end

		return Vector3.New(var_17_1, var_17_2, var_17_3)
	end

	return Vector3.New(1, 1, 1)
end

return var_0_0

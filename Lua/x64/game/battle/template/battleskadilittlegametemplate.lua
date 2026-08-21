local var_0_0 = class("BattleSkadiLittleGameTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.stageID_ = ActivityCrossWaveCfg[arg_1_1].stage_id
	arg_1_0.cfg = BattleCrosswaveCfg[arg_1_0.stageID_]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.id_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.stageID_
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.SKADI_GAME
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg.monster_level
end

function var_0_0.GetStageAffix(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	return var_8_0, var_8_1, var_8_2
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_10_0)
	return arg_10_0.activityID_
end

function var_0_0.GetThreeStar(arg_11_0)
	return arg_11_0.cfg.three_star_need
end

function var_0_0.SetMaxRaceData(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = 0
	local var_12_2 = false

	for iter_12_0, iter_12_1 in pairs(arg_12_0.roleDataInLua) do
		local var_12_3 = iter_12_1.ID

		if var_12_3 ~= 0 then
			local var_12_4 = HeroCfg[var_12_3].race

			var_12_0[var_12_4] = (var_12_0[var_12_4] or 0) + 1

			if var_12_0[var_12_4] == 2 then
				var_12_1 = var_12_4
			elseif var_12_0[var_12_4] == 3 then
				local var_12_5 = true
			end
		end
	end

	arg_12_0.maxRaceID_ = var_12_1
	arg_12_0.maxRacePlayerCount_ = var_12_0[var_12_1] or 1
end

return var_0_0

local var_0_0 = class("BattleLeviathanLittleGameTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.stageID_ = ActivityBubblesCfg[arg_1_1].stage_id
	arg_1_0.cfg = BattleLeviathanGamesCfg[arg_1_0.stageID_]
	arg_1_0.heroList_, _, _, arg_1_0.heroTrialList_ = GetLocalHeroTeam(arg_1_0:GetType(), arg_1_0.stageID_, arg_1_2)

	arg_1_0:InitComboSkillID()
	arg_1_0:InitChipData()
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.id_
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.stageID_
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_6_0)
	return arg_6_0.cfg.monster_level
end

function var_0_0.GetStageAffix(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}

	return var_7_0, var_7_1, var_7_2
end

function var_0_0.GetHeroTeam(arg_8_0)
	return arg_8_0.heroList_, arg_8_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_9_0)
	return arg_9_0.activityID_
end

function var_0_0.SetMaxRaceData(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = 0
	local var_10_2 = false

	for iter_10_0, iter_10_1 in pairs(arg_10_0.roleDataInLua) do
		local var_10_3 = iter_10_1.ID

		if var_10_3 ~= 0 then
			local var_10_4 = HeroCfg[var_10_3].race

			var_10_0[var_10_4] = (var_10_0[var_10_4] or 0) + 1

			if var_10_0[var_10_4] == 2 then
				var_10_1 = var_10_4
			elseif var_10_0[var_10_4] == 3 then
				local var_10_5 = true
			end
		end
	end

	arg_10_0.maxRaceID_ = var_10_1
	arg_10_0.maxRacePlayerCount_ = var_10_0[var_10_1] or 1
end

return var_0_0

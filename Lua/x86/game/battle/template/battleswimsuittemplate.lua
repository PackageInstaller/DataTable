local var_0_0 = class("BattleSwimsuitTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleSwimsuitCfg[arg_1_0.id]
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
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE
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

function var_0_0.UpdateRoleDatas(arg_10_0, arg_10_1)
	arg_10_0.serverTeamPlayer = arg_10_1
	arg_10_0.roleDataInLua = {}

	local var_10_0 = arg_10_0:GetSystemHeroTeam()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.heroList) do
		local var_10_1 = iter_10_1.trialID ~= 0 and iter_10_1.trialID or var_10_0[iter_10_0] or 0
		local var_10_2 = SwimsuitBattleData:GetSkinByHeroID(iter_10_1.id)

		if var_10_2 then
			iter_10_1.skin = var_10_2
		end

		local var_10_3 = BattleController.GetInstance():SetHeroData(iter_10_1, var_10_1, arg_10_1.playerID, arg_10_1.level)

		table.insert(arg_10_0.roleDataInLua, var_10_3)
	end

	arg_10_0:SetMaxRaceData()
end

return var_0_0

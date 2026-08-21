local var_0_0 = class("BattleOsirisPlayGameStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleOsirisGameStageCfg[arg_1_0.id]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.InitHeroList(arg_3_0)
	arg_3_0.heroList_ = {}
	arg_3_0.heroTrialList_ = {}

	local var_3_0, var_3_1, var_3_2, var_3_3 = ReserveTools.GetHeroList(arg_3_0:GetReserveParams())

	arg_3_0.heroList_ = clone(var_3_0)
	arg_3_0.heroTrialList_ = clone(var_3_3)

	for iter_3_0 = #var_3_0, 1, -1 do
		if var_3_0[iter_3_0] == 0 then
			table.remove(arg_3_0.heroList_, iter_3_0)
			table.remove(arg_3_0.heroTrialList_, iter_3_0)
		end
	end
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
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
		local var_10_2 = BattleController.GetInstance():SetOsirisPlayGameHeroData(iter_10_1, var_10_1, arg_10_1.playerID, arg_10_1.level)

		table.insert(arg_10_0.roleDataInLua, var_10_2)
	end

	arg_10_0:SetMaxRaceData()
end

return var_0_0

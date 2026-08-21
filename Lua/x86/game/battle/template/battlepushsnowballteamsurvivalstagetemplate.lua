local var_0_0 = class("BattlePushSnowBallTeamSurvivalStageTemplate", BattleBaseCooperationTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.dest = arg_1_2.dest
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.cfg = BattlePushSnowBallTeamSurvivalStageCfg[arg_1_0.id]
	arg_1_0.heroList = {
		0,
		0,
		0
	}
	arg_1_0.heroTrialList = {
		PushSnowBallData:GetSelectedBattleModelID(),
		0,
		0
	}
end

function var_0_0.GetActivityID(arg_2_0)
	return arg_2_0.activityID_
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.dest
end

function var_0_0.GetRoleDatas(arg_4_0)
	return arg_4_0.roleDataInLua
end

function var_0_0.GetEnemyLevel(arg_5_0)
	return arg_5_0.cfg.monster_level
end

function var_0_0.GetAILevel(arg_6_0)
	return arg_6_0.cfg.ai_level
end

function var_0_0.GetStageId(arg_7_0)
	return arg_7_0.id
end

function var_0_0.GetMap(arg_8_0)
	return arg_8_0.cfg.map, false
end

function var_0_0.GetType(arg_9_0)
	return BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList, arg_10_0.heroTrialList
end

function var_0_0.UpdateRoleDatas(arg_11_0)
	arg_11_0.roleDataInLua = {}
	arg_11_0.heroList = {}
	arg_11_0.heroTrialList = {}
	arg_11_0.heroInfoList = {}
	arg_11_0.playerList = PushSnowBallData:GetPlayerList()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.playerList) do
		local var_11_0 = RoleDataForExchange.New()

		var_11_0.UID = iter_11_1.uid
		var_11_0.ID = HeroStandardSystemCfg[iter_11_1.heroID].skin_id
		var_11_0.attributeID = {
			1,
			2,
			3
		}
		var_11_0.attributeValue = {
			1000,
			1000,
			1000
		}
		var_11_0.skillLevel = {
			1,
			1,
			1,
			1,
			1,
			1
		}

		table.insert(arg_11_0.roleDataInLua, var_11_0)
		table.insert(arg_11_0.heroTrialList, var_11_0.ID)
	end
end

function var_0_0.GetMaxRaceData(arg_12_0)
	return 0, 0
end

function var_0_0.GetSystemHeroTeam(arg_13_0)
	return arg_13_0.heroTrialList
end

function var_0_0.GetHeroDataByPos(arg_14_0, arg_14_1)
	return nil
end

function var_0_0.GetIsCooperation(arg_15_0)
	return true, arg_15_0.playerList
end

function var_0_0.GetChipList(arg_16_0)
	return {}
end

function var_0_0.GetComboSkillID(arg_17_0)
	return 0
end

function var_0_0.GetComboSkillLevel(arg_18_0)
	return 0
end

function var_0_0.GetResurrectImmediately(arg_19_0)
	return true
end

function var_0_0.GetName(arg_20_0)
	return arg_20_0.cfg.name
end

return var_0_0

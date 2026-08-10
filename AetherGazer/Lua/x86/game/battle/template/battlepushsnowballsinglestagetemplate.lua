local var_0_0 = class("BattlePushSnowBallSingleStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID = arg_1_2.activityID
	arg_1_0.activityCfg = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[arg_1_0.activityID][1]]
	arg_1_0.cfg = BattlePushSnowBallSingleStageCfg[arg_1_0.id]
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
	return arg_2_0.activityID
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.cfg.id
end

function var_0_0.GetRoleDatas(arg_4_0)
	return arg_4_0.roleDataInLua
end

function var_0_0.UpdateRoleDatas(arg_5_0, arg_5_1)
	arg_5_0.roleDataInLua = {}

	local var_5_0 = RoleDataForExchange.New()

	var_5_0.UID = arg_5_1.playerID
	var_5_0.playerLevel = arg_5_1.level
	var_5_0.ID = HeroStandardSystemCfg[PushSnowBallData:GetSelectedBattleModelID()].skin_id
	var_5_0.attributeID = {
		1,
		2,
		3
	}
	var_5_0.attributeValue = {
		1000,
		1000,
		1000
	}
	var_5_0.skillLevel = {
		1,
		1,
		1,
		1,
		1,
		1
	}

	table.insert(arg_5_0.roleDataInLua, var_5_0)
end

function var_0_0.GetEnemyLevel(arg_6_0)
	return arg_6_0.cfg.monster_level
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetStageId(arg_8_0)
	return arg_8_0.id
end

function var_0_0.GetMap(arg_9_0)
	return arg_9_0.cfg.map, false
end

function var_0_0.GetName(arg_10_0)
	return arg_10_0.cfg.name
end

function var_0_0.GetSystemHeroTeam(arg_11_0)
	return arg_11_0.heroTrialList
end

function var_0_0.GetType(arg_12_0)
	return BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE
end

function var_0_0.GetHeroTeam(arg_13_0)
	return arg_13_0.heroList, arg_13_0.heroTrialList
end

function var_0_0.GetStageAffix(arg_14_0)
	local var_14_0 = PushSnowBallDeviceCfg[PushSnowBallData:GetSelectedDeviceID()]
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}

	if var_14_0 then
		local var_14_4 = type(var_14_0.affixs) == "table" and var_14_0.affixs or {}

		for iter_14_0, iter_14_1 in pairs(var_14_4 or {}) do
			table.insert(var_14_1, iter_14_1[1])
			table.insert(var_14_2, iter_14_1[2])
			table.insert(var_14_3, iter_14_1[3])
		end
	end

	return var_14_1, var_14_2, var_14_3
end

return var_0_0

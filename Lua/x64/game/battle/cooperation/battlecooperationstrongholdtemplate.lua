local var_0_0 = class("BattleCooperationStrongholdTemplate", BattleBaseCooperationTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityID_ = arg_1_1

	local var_1_0 = ActivityStrongholdCfg[arg_1_1].stage_id

	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.id_ = var_1_0
	arg_1_0.cfg = BattleStrongholdStageCfg[var_1_0]
	arg_1_0.roomSkill = StrongholdData:GetSelfRoomSkillType(arg_1_0.roomId)
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.activityID_
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.id_
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.STRONGHOLD, arg_4_0.roomSkill
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_6_0)
	return arg_6_0.cfg.monster_level
end

function var_0_0.GetRevive(arg_7_0)
	local var_7_0 = StrongholdData:GetRoomPlayerIncreaseRevive(arg_7_0.roomId)
	local var_7_1 = ActivityStrongholdCfg[arg_7_0.activityID_].initial_revive or 0

	return true, 0, var_7_0 + var_7_1, 1, var_7_0 + var_7_1
end

function var_0_0.GetStageAffix(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = StrongholdData:GetRoomAffixList(arg_8_0.roomId, arg_8_0.playerList)

	for iter_8_0, iter_8_1 in pairs(var_8_3 or {}) do
		table.insert(var_8_0, iter_8_1[1])
		table.insert(var_8_1, iter_8_1[2])
		table.insert(var_8_2, iter_8_1[3])
	end

	return var_8_0, var_8_1, var_8_2
end

return var_0_0

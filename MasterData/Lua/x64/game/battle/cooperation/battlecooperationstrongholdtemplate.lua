local BattleCooperationStrongholdTemplate = class("BattleCooperationStrongholdTemplate", BattleBaseCooperationTemplate)

function BattleCooperationStrongholdTemplate:Ctor(arg_1_1)
	self.activityID_ = arg_1_1

	BattleCooperationStrongholdTemplate.super.Ctor(self)

	self.id_ = ActivityStrongholdCfg[arg_1_1].stage_id
	self.cfg = BattleStrongholdStageCfg[ActivityStrongholdCfg[arg_1_1].stage_id]
	self.roomSkill = StrongholdData:GetSelfRoomSkillType(self.roomId)
end

function BattleCooperationStrongholdTemplate:GetDest()
	return self.activityID_
end

function BattleCooperationStrongholdTemplate:GetStageId()
	return self.id_
end

function BattleCooperationStrongholdTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STRONGHOLD, self.roomSkill
end

function BattleCooperationStrongholdTemplate:GetMap()
	return self.cfg.map, false
end

function BattleCooperationStrongholdTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleCooperationStrongholdTemplate:GetRevive()
	local var_7_0 = StrongholdData:GetRoomPlayerIncreaseRevive(self.roomId)
	local var_7_1 = ActivityStrongholdCfg[self.activityID_].initial_revive or 0

	return true, 0, var_7_0 + var_7_1, 1, var_7_0 + var_7_1
end

function BattleCooperationStrongholdTemplate:GetStageAffix()
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in pairs(StrongholdData:GetRoomAffixList(self.roomId, self.playerList) or {}) do
		table.insert(var_8_0, iter_8_1[1])
		table.insert(var_8_1, iter_8_1[2])
		table.insert(var_8_2, iter_8_1[3])
	end

	return var_8_0, var_8_1, var_8_2
end

return BattleCooperationStrongholdTemplate

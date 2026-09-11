local BattleMythicFinalTemplate = class("BattleMythicFinalTemplate", BattleBaseStageTemplate)

function BattleMythicFinalTemplate:Ctor(arg_1_1, arg_1_2)
	BattleMythicFinalTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleMythicFinalCfg[arg_1_1]
	self.levelcfg = MythicFinalCfg[MythicData:GetCurHotLevelId()]
	self.nextBattleStage_ = nil
end

function BattleMythicFinalTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleMythicFinalTemplate:GetDest()
	return self:GetTeamIndex()
end

function BattleMythicFinalTemplate:GetStageId()
	return self.id
end

function BattleMythicFinalTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
end

function BattleMythicFinalTemplate:GetMap()
	return self.cfg.map, false
end

function BattleMythicFinalTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleMythicFinalTemplate:GetAttributeFactor()
	local var_8_0 = MythicFinalCfg[MythicData:GetCurHotLevelId()]

	if var_8_0.attribute_factor and var_8_0.attribute_factor[3] then
		return Vector3.New(var_8_0.attribute_factor[1] / 1000, var_8_0.attribute_factor[2] / 1000, var_8_0.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleMythicFinalTemplate:GetStageAffix()
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(MythicData:GetFinalMonsterAffix() or {}) do
		table.insert(var_9_0, iter_9_1[1])
		table.insert(var_9_1, iter_9_1[2])
		table.insert(var_9_2, iter_9_1[3])
	end

	return var_9_0, var_9_1, var_9_2
end

function BattleMythicFinalTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleMythicFinalTemplate:GetEnemyLevel()
	return self.levelcfg.monster_level
end

function BattleMythicFinalTemplate:GetNextStage()
	return self.nextBattleStage_
end

function BattleMythicFinalTemplate:SetNextStage(arg_13_1)
	self.nextBattleStage_ = arg_13_1
end

function BattleMythicFinalTemplate:GetBattleTime()
	return MythicData:GetBattleRemainTime(self:GetDest())
end

return BattleMythicFinalTemplate

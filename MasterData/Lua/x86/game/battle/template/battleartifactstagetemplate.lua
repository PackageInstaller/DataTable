local BattleArtifactStageTemplate = class("BattleArtifactStageTemplate", BattleBaseStageTemplate)

function BattleArtifactStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleArtifactStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleArtifactCfg[arg_1_1]
end

function BattleArtifactStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleArtifactStageTemplate:GetDest()
	return ArtifactLevelData:GetLevelIdByStageId(self.id)
end

function BattleArtifactStageTemplate:GetStageId()
	return self.id
end

function BattleArtifactStageTemplate:GetActivityID()
	return self.activityID_
end

function BattleArtifactStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ARTIFACT
end

function BattleArtifactStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleArtifactStageTemplate:GetName()
	return self.cfg.name
end

function BattleArtifactStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleArtifactStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleArtifactStageTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(ActivityArtifactLevelCfg[ArtifactLevelData:GetLevelIdByStageId(self.id)].affix_list) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleArtifactStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleArtifactStageTemplate

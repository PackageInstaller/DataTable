local BattleSlayerStageTemplate = class("BattleSlayerStageTemplate", BattleBaseStageTemplate)

function BattleSlayerStageTemplate:Ctor(arg_1_1, arg_1_2)
	self.region_activity_id = arg_1_1

	self.super.Ctor(self, ActivitySlayerCfg[arg_1_1].stage_id)

	self.id_ = ActivitySlayerCfg[arg_1_1].stage_id
	self.activityID_ = arg_1_2
	self.cfg = BattleSlayerStageCfg[ActivitySlayerCfg[arg_1_1].stage_id]
end

function BattleSlayerStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSlayerStageTemplate:GetDest()
	return self.region_activity_id
end

function BattleSlayerStageTemplate:GetStageId()
	return self.id_
end

function BattleSlayerStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SLAYER
end

function BattleSlayerStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSlayerStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSlayerStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSlayerStageTemplate:GetStageAffix()
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs((TalentTreeData:GetTalentListByTheme((ActivityTools.GetActivityTheme(self.region_activity_id))))) do
		table.insert(var_9_0, iter_9_1[1])
		table.insert(var_9_1, iter_9_1[2])
		table.insert(var_9_2, iter_9_1[3])
	end

	return var_9_0, var_9_1, var_9_2
end

function BattleSlayerStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleSlayerStageTemplate

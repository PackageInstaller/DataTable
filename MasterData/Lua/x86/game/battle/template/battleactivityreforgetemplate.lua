local BattleActivityReforgeTemplate = class("BattleActivityReforgeTemplate", BattleBaseStageTemplate)

function BattleActivityReforgeTemplate:Ctor(arg_1_1, arg_1_2)
	BattleActivityReforgeTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2.activityID
	self.chapterActivityID_ = arg_1_2.chapterActivityID
	self.levelID_ = arg_1_2.levelID
	self.waveID_ = arg_1_2.waveID
	self.skillList_ = arg_1_2.skillList
	self.battleParams_ = arg_1_2.battleParams

	local var_1_0 = ActivityReforgeData:GetWaveTeamInfo(self.waveID_)

	self.teamID = var_1_0.teamID
	self.level = var_1_0.level
	self.teamCfg = ActivityReforgeTeamCfg[self.teamID]
	self.cfg = BattleActivityReforgeCfg[arg_1_1]
end

function BattleActivityReforgeTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityReforgeTemplate:InitHeroList()
	self.heroList_, self.heroTrialList_ = {}, {}

	for iter_3_0, iter_3_1 in pairs(self.teamCfg.team_info[self.level]) do
		table.insert(self.heroList_, HeroStandardSystemCfg[iter_3_1].hero_id)
		table.insert(self.heroTrialList_, iter_3_1)
	end
end

function BattleActivityReforgeTemplate:InitComboSkillID()
	self.comboSkillID_ = self.teamCfg.combo_skill_id
end

function BattleActivityReforgeTemplate:InitChipData()
	self.chipList_ = {}
end

function BattleActivityReforgeTemplate:GetComboSkillLevel()
	return 3
end

function BattleActivityReforgeTemplate:GetDest()
	return self.waveID_
end

function BattleActivityReforgeTemplate:GetStageId()
	return self.id
end

function BattleActivityReforgeTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE
end

function BattleActivityReforgeTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityReforgeTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityReforgeTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityReforgeTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityReforgeTemplate:GetChapterActivityID()
	return self.chapterActivityID_
end

function BattleActivityReforgeTemplate:GetLevelID()
	return self.levelID_
end

function BattleActivityReforgeTemplate:GetActivityID()
	return self.chapterActivityID_
end

function BattleActivityReforgeTemplate:GetMainActivityID()
	return self.activityID_
end

function BattleActivityReforgeTemplate:GetWaveID()
	return self.waveID_
end

function BattleActivityReforgeTemplate:GetActivityReforgeSkillList()
	return self.skillList_
end

function BattleActivityReforgeTemplate:GetBattleParams()
	return self.battleParams_
end

return BattleActivityReforgeTemplate

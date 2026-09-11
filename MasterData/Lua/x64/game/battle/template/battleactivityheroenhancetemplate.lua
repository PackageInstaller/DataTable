local BattleActivityHeroEnhanceTemplate = class("BattleActivityHeroEnhanceTemplate", BattleBaseStageTemplate)

function BattleActivityHeroEnhanceTemplate:Ctor(arg_1_1, arg_1_2, arg_1_3)
	BattleActivityHeroEnhanceTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleHeroEnhanceCfg[arg_1_1]
	self.heroEnhanceCfgId_ = arg_1_3
end

function BattleActivityHeroEnhanceTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityHeroEnhanceTemplate:GetDest()
	return self:GetStageId()
end

function BattleActivityHeroEnhanceTemplate:GetStageId()
	return self.id
end

function BattleActivityHeroEnhanceTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE
end

function BattleActivityHeroEnhanceTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityHeroEnhanceTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityHeroEnhanceTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityHeroEnhanceTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityHeroEnhanceTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleActivityHeroEnhanceTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleActivityHeroEnhanceTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleActivityHeroEnhanceTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs((self:GetTalentIdList())) do
		table.insert(var_13_0, TalentTreeCfg[iter_13_1].affix_id)
		table.insert(var_13_1, 1)
		table.insert(var_13_2, TalentTreeCfg[iter_13_1].affix_user)
	end

	return var_13_0, var_13_1, var_13_2
end

function BattleActivityHeroEnhanceTemplate:GetHeroEnhanceCfgId()
	return self.heroEnhanceCfgId_
end

function BattleActivityHeroEnhanceTemplate:GetTalentIdList()
	return (ActivityHeroEnhanceTools.GetUnlockTalentList(self.activityID_, ActivityHeroEnhanceCfg[self.heroEnhanceCfgId_]))
end

return BattleActivityHeroEnhanceTemplate

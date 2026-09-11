local BattleActivityPtGameTemplate = class("BattleActivityPtGameTemplate", BattleBaseStageTemplate)

function BattleActivityPtGameTemplate:Ctor(arg_1_1, arg_1_2)
	BattleActivityPtGameTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.stageID_ = arg_1_1
	self.cfg = BattleStageTools.GetStageCfg(self:GetType(), arg_1_1)
end

function BattleActivityPtGameTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityPtGameTemplate:GetDest()
	return ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[self.activityID_][self.stageID_].id
end

function BattleActivityPtGameTemplate:GetStageId()
	return self.stageID_
end

function BattleActivityPtGameTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME
end

function BattleActivityPtGameTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityPtGameTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityPtGameTemplate:GetActivityID()
	return self.activityID_
end

function BattleActivityPtGameTemplate:GetThreeStar()
	return {}
end

function BattleActivityPtGameTemplate:GetCost()
	return self.cfg.cost
end

function BattleActivityPtGameTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs((type(self.cfg.affix_type) == "table" or nil) and (self.cfg.affix_type or {}) or {}) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleActivityPtGameTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleActivityPtGameTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleActivityPtGameTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityPtGameTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

return BattleActivityPtGameTemplate

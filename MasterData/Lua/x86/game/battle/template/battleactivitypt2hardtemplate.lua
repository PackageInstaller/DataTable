local BattleActivityPt2HardTemplate = class("BattleActivityPt2HardTemplate", BattleBaseStageTemplate)

function BattleActivityPt2HardTemplate:Ctor(arg_1_1, arg_1_2)
	BattleActivityPt2HardTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.stageID_ = arg_1_1
	self.cfg = BattleStageTools.GetStageCfg(self:GetType(), arg_1_1)
end

function BattleActivityPt2HardTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityPt2HardTemplate:GetDest()
	return ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[self.activityID_][self.stageID_].id
end

function BattleActivityPt2HardTemplate:GetStageId()
	return self.stageID_
end

function BattleActivityPt2HardTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD
end

function BattleActivityPt2HardTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityPt2HardTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityPt2HardTemplate:GetActivityID()
	return self.activityID_
end

function BattleActivityPt2HardTemplate:GetThreeStar()
	return {}
end

function BattleActivityPt2HardTemplate:GetCost()
	return ActivityPt2Cfg[self:GetDest()].cost[1][2] or 0
end

function BattleActivityPt2HardTemplate:GetStageAffix()
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

function BattleActivityPt2HardTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleActivityPt2HardTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleActivityPt2HardTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityPt2HardTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

return BattleActivityPt2HardTemplate

local BattleActivityPushBoxTemplate = class("BattleActivityPushBoxTemplate", BattleBaseStageTemplate)

function BattleActivityPushBoxTemplate:Ctor(arg_1_1, arg_1_2, arg_1_3)
	BattleActivityPushBoxTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.destID_ = arg_1_3
	self.activityID_ = arg_1_2
	self.stageID_ = arg_1_1
	self.cfg = BattleStageTools.GetStageCfg(self:GetType(), self:GetStageId())
	self.heroList_, _, _, self.heroTrialList_ = GetLocalHeroTeam(self:GetType(), self.stageID_, arg_1_2)

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityPushBoxTemplate:GetDest()
	return self.destID_
end

function BattleActivityPushBoxTemplate:GetStageId()
	return self.stageID_
end

function BattleActivityPushBoxTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE
end

function BattleActivityPushBoxTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityPushBoxTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityPushBoxTemplate:GetActivityID()
	return self.activityID_
end

function BattleActivityPushBoxTemplate:GetThreeStar()
	return {}
end

function BattleActivityPushBoxTemplate:GetCost()
	return ActivityCelebrationOrderCfg[self:GetDest()].cost or 0
end

function BattleActivityPushBoxTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in pairs(ActivityCelebrationOrderCfg[self:GetDest()].affix_list or {}) do
		table.insert(var_10_0, iter_10_1[1])
		table.insert(var_10_1, iter_10_1[2])
		table.insert(var_10_2, iter_10_1[3])
	end

	return var_10_0, var_10_1, var_10_2
end

function BattleActivityPushBoxTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleActivityPushBoxTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleActivityPushBoxTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityPushBoxTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

return BattleActivityPushBoxTemplate

local BattleGodEaterTemplate = class("BattleGodEaterTemplate", BattleBaseStageTemplate)

function BattleGodEaterTemplate:Ctor(arg_1_1, arg_1_2)
	BattleGodEaterTemplate.super.Ctor(self, arg_1_1)

	self.data = arg_1_2
	self.id = arg_1_1
	self.cfg = BattleGodEaterDailyMonsterCfg[arg_1_1]
	self.viewType = arg_1_2.viewType
	self.activityID_ = arg_1_2.activityId
end

function BattleGodEaterTemplate:Init()
	self.heroList_ = self.data.heroList
	self.heroTrialList_ = self.data.heroTrialList
end

function BattleGodEaterTemplate:GetDest()
	return self:GetStageId()
end

function BattleGodEaterTemplate:GetStageId()
	return self.id
end

function BattleGodEaterTemplate:GetMap()
	return self.cfg.map, false
end

function BattleGodEaterTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleGodEaterTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleGodEaterTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleGodEaterTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleGodEaterTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleGodEaterTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleGodEaterTemplate:GetStageAffix()
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs((WeekBossData:GetSelectTalent(self.heroTrialList_[1]))) do
		if iter_12_1 ~= 0 then
			table.insert(var_12_0, TalentTreeCfg[iter_12_1].affix_id)
			table.insert(var_12_1, 1)
			table.insert(var_12_2, TalentTreeCfg[iter_12_1].affix_user)
		end
	end

	return var_12_0, var_12_1, var_12_2
end

function BattleGodEaterTemplate:GetViewType()
	return self.viewType
end

function BattleGodEaterTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleGodEaterTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE
end

function BattleGodEaterTemplate:GetActivityID()
	return self.activityID_
end

return BattleGodEaterTemplate

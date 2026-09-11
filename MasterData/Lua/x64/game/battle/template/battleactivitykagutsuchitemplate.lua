local BattleActivityKagutsuchiTemplate = class("BattleActivityKagutsuchiTemplate", BattleBaseStageTemplate)

function BattleActivityKagutsuchiTemplate:Ctor(arg_1_1, arg_1_2)
	BattleActivityKagutsuchiTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleKagutsuchiStageCfg[arg_1_1]
	self.day = KagutsuchiWorkData:GetDay()
	self.cost = KagutsuchiWorkData:GetPlayGridData((KagutsuchiWorkData:GetIndexByStageId(arg_1_1))):GetCost()
end

function BattleActivityKagutsuchiTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityKagutsuchiTemplate:GetDest()
	return self:GetStageId()
end

function BattleActivityKagutsuchiTemplate:GetStageId()
	return self.id
end

function BattleActivityKagutsuchiTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME
end

function BattleActivityKagutsuchiTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityKagutsuchiTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityKagutsuchiTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityKagutsuchiTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityKagutsuchiTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleActivityKagutsuchiTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleActivityKagutsuchiTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleActivityKagutsuchiTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs((KagutsuchiTalentData:GetUnlockTalentIdList())) do
		table.insert(var_13_0, TalentTreeCfg[iter_13_1].affix_id)
		table.insert(var_13_1, KagutsuchiTalentData:GetTalentLevel(iter_13_1))
		table.insert(var_13_2, TalentTreeCfg[iter_13_1].affix_user)
	end

	return var_13_0, var_13_1, var_13_2
end

function BattleActivityKagutsuchiTemplate:GetAttributeFactor()
	return KagutsuchiWorkData:GetAttributeFactor()
end

function BattleActivityKagutsuchiTemplate:GetDay()
	return self.day
end

function BattleActivityKagutsuchiTemplate:GetGridCost()
	return self.cost or 0
end

return BattleActivityKagutsuchiTemplate

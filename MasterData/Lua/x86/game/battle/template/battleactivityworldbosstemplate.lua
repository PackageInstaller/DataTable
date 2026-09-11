local BattleActivityWorldBossTemplate = class("BattleActivityWorldBossTemplate", BattleBaseStageTemplate)

function BattleActivityWorldBossTemplate:Ctor(arg_1_1, arg_1_2)
	BattleActivityWorldBossTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleActivityWorldBossCfg[arg_1_1]
	self.roleDataInLua = {}
end

function BattleActivityWorldBossTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityWorldBossTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityWorldBossTemplate:GetDest()
	return self.activityID_
end

function BattleActivityWorldBossTemplate:GetStageId()
	return self.id
end

function BattleActivityWorldBossTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS
end

function BattleActivityWorldBossTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityWorldBossTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityWorldBossTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityWorldBossTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleActivityWorldBossTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs({
		(ActivityWorldBossData:GetAffix(self.activityID_))
	} or {}) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	return var_11_0, var_11_1, var_11_2
end

return BattleActivityWorldBossTemplate

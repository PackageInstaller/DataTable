local BattleMythicStageTemplate = class("BattleMythicStageTemplate", BattleBaseStageTemplate)

function BattleMythicStageTemplate:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.dest = arg_1_2

	BattleMythicStageTemplate.super.Ctor(self, self.id)

	self.cfg = BattleMythicStageCfg[self.id]
end

function BattleMythicStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleMythicStageTemplate:GetDest()
	return self.dest
end

function BattleMythicStageTemplate:GetStageId()
	return self.id
end

function BattleMythicStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC
end

function BattleMythicStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleMythicStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleMythicStageTemplate:GetAttributeFactor()
	return MythicData:GetAttributeFactor(self.dest)
end

function BattleMythicStageTemplate:GetEnemyLevel()
	return MythicData:GetMonsterLevel(self.dest)
end

function BattleMythicStageTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in pairs(MythicData:GetMonsterAffix() or {}) do
		table.insert(var_10_0, iter_10_1[1])
		table.insert(var_10_1, iter_10_1[2])
		table.insert(var_10_2, iter_10_1[3])
	end

	for iter_10_2, iter_10_3 in pairs(MythicData:GetHeroAffix() or {}) do
		table.insert(var_10_0, iter_10_3[1])
		table.insert(var_10_1, iter_10_3[2])
		table.insert(var_10_2, iter_10_3[3])
	end

	return var_10_0, var_10_1, var_10_2
end

function BattleMythicStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleMythicStageTemplate:GetThreeStar()
	if self.cfg.three_star_need == "" then
		return {}
	end

	return self.cfg.three_star_need
end

return BattleMythicStageTemplate

local BattleBossStageTemplate = class("BattleBossStageTemplate", BattleBaseStageTemplate)

function BattleBossStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleBossStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleBossStageCfg[self.id]
	self.bossIndex_ = arg_1_2
end

function BattleBossStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleBossStageTemplate:GetDest()
	return self.id
end

function BattleBossStageTemplate:GetStageId()
	return self.id
end

function BattleBossStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE
end

function BattleBossStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleBossStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleBossStageTemplate:GetEnemyLevel()
	return BattleBossChallengeNormalData:GetBossChallengeCfg().level[1]
end

function BattleBossStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleBossStageTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in pairs((type(self.cfg.affix_type) == "table" or nil) and (self.cfg.affix_type or {}) or {}) do
		table.insert(var_10_0, iter_10_1[1])
		table.insert(var_10_1, iter_10_1[2])
		table.insert(var_10_2, iter_10_1[3])
	end

	return var_10_0, var_10_1, var_10_2
end

function BattleBossStageTemplate:GetThreeStar()
	if self.cfg.three_star_need == "" then
		return {}
	end

	return self.cfg.three_star_need
end

function BattleBossStageTemplate:GetAttributeFactor()
	local var_12_0 = BattleBossChallengeNormalData:GetBossChallengeCfg().monster_value[BattleBossChallengeNormalData:GetSelectDifficult(self.bossIndex_)]

	return Vector3.New(var_12_0[1] / 1000, var_12_0[2] / 1000, var_12_0[3] / 1000)
end

return BattleBossStageTemplate

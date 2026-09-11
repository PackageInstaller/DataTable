local BattleSPHeroChallengeTemplate = class("BattleSPHeroChallengeTemplate", BattleBaseStageTemplate)

function BattleSPHeroChallengeTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSPHeroChallengeTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleVerthandiExclusiveCfg[arg_1_1]
end

function BattleSPHeroChallengeTemplate:Init()
	self.heroList_ = self.cfg.hero_list
	self.systemHeroList = {}

	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSPHeroChallengeTemplate:GetDest()
	return self.id
end

function BattleSPHeroChallengeTemplate:GetStageId()
	return self.id
end

function BattleSPHeroChallengeTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1
end

function BattleSPHeroChallengeTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSPHeroChallengeTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleSPHeroChallengeTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleSPHeroChallengeTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSPHeroChallengeTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleSPHeroChallengeTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleSPHeroChallengeTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleSPHeroChallengeTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleSPHeroChallengeTemplate:GetStageAffix()
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}
	local var_14_4 = SPHeroChallengeData:GetCurActivityInfo()
	local var_14_5 = SPHeroChallengeData:GetActivityID()

	for iter_14_0, iter_14_1 in pairs(SPHeroChallengeTools:GetUnlockChapterAffix() or {}) do
		table.insert(var_14_1, iter_14_1[1])
		table.insert(var_14_2, iter_14_1[2])
		table.insert(var_14_3, iter_14_1[3])
	end

	for iter_14_2, iter_14_3 in pairs(SPHeroChallengeTools:GetUnlockAffix() or {}) do
		if ActivityAffixPoolCfg[iter_14_3] then
			table.insert(var_14_1, ActivityAffixPoolCfg[iter_14_3].affix[1])
			table.insert(var_14_2, ActivityAffixPoolCfg[iter_14_3].affix[2])
			table.insert(var_14_3, ActivityAffixPoolCfg[iter_14_3].affix[3])
		end
	end

	if self.cfg.sub_type == SpHeroChallengeConst.BattleSubType.boss and var_14_4 then
		if ActivityHeroChallengeCfg[var_14_5].affix_defense then
			table.insert(var_14_1, ActivityHeroChallengeCfg[var_14_5].affix_defense[1])
			table.insert(var_14_2, var_14_4:GetBossErosiveness() + 1)
			table.insert(var_14_3, ActivityHeroChallengeCfg[var_14_5].affix_defense[3])
		end
	end

	return var_14_1, var_14_2, var_14_3
end

return BattleSPHeroChallengeTemplate

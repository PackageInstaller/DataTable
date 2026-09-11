local BattleSoloChallengeStageTemplate = class("BattleSoloChallengeStageTemplate", BattleBaseStageTemplate)

function BattleSoloChallengeStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSoloChallengeStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleSoloChallengeStageCfg[arg_1_1]
end

function BattleSoloChallengeStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
end

function BattleSoloChallengeStageTemplate:GetDest()
	return table.keyof(ActivitySoloChallengeCfg[self.activityID_].stage_id[SoloChallengeData:GetSelectedDifficultyIndex(self.activityID_)][2], self.id)
end

function BattleSoloChallengeStageTemplate:GetStageId()
	return self.id
end

function BattleSoloChallengeStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE
end

function BattleSoloChallengeStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSoloChallengeStageTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleSoloChallengeStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleSoloChallengeStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSoloChallengeStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleSoloChallengeStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleSoloChallengeStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleSoloChallengeStageTemplate:GetStageAffix()
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}

	for iter_13_0, iter_13_1 in pairs((ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(self:GetContID()):GetAffixList(self:GetTeamIndex()))) do
		if iter_13_1 ~= 0 then
			table.insert(var_13_1, ActivityAffixPoolCfg[iter_13_1].affix[1])
			table.insert(var_13_2, ActivityAffixPoolCfg[iter_13_1].affix[2])
			table.insert(var_13_3, ActivityAffixPoolCfg[iter_13_1].affix[3])
		end
	end

	return var_13_1, var_13_2, var_13_3
end

function BattleSoloChallengeStageTemplate:GetChipList()
	return {}
end

return BattleSoloChallengeStageTemplate

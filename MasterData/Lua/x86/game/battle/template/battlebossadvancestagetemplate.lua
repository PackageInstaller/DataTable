local BattleBossAdvanceStageTemplate = class("BattleBossAdvanceStageTemplate", BattleBaseStageTemplate)

function BattleBossAdvanceStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleBossAdvanceStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleBossStageCfg[self.id]
	self.bossIndex_ = arg_1_2
end

function BattleBossAdvanceStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleBossAdvanceStageTemplate:GetDest()
	return self.id
end

function BattleBossAdvanceStageTemplate:GetStageId()
	return self.id
end

function BattleBossAdvanceStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE
end

function BattleBossAdvanceStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleBossAdvanceStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleBossAdvanceStageTemplate:GetEnemyLevel()
	return BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].monster_level
end

function BattleBossAdvanceStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleBossAdvanceStageTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in pairs((BattleBossChallengeAdvanceData:GetBossAffixList(self.bossIndex_, BossConst.TYPE_AFFIX))) do
		table.insert(var_10_0, ActivityAffixPoolCfg[iter_10_1].affix[1])
		table.insert(var_10_1, ActivityAffixPoolCfg[iter_10_1].affix[2])
		table.insert(var_10_2, ActivityAffixPoolCfg[iter_10_1].affix[3])
	end

	local var_10_3 = BossChallengeUICfg[BossTools.GetBossID(self:GetType(), self.bossIndex_)]

	table.insert(var_10_0, var_10_3.custom_affix[1])
	table.insert(var_10_1, var_10_3.custom_affix[2])
	table.insert(var_10_2, var_10_3.custom_affix[3])

	return var_10_0, var_10_1, var_10_2
end

function BattleBossAdvanceStageTemplate:GetAttributeFactor()
	local var_11_0 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].monster_value[BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].multipleIndex]

	return Vector3.New(var_11_0[1] / 1000, var_11_0[2] / 1000, var_11_0[3] / 1000)
end

function BattleBossAdvanceStageTemplate:GetServerExtant()
	return BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].id
end

function BattleBossAdvanceStageTemplate:GetBossIndex()
	return self.bossIndex_
end

return BattleBossAdvanceStageTemplate

local BattleKaliChallengeTemplate = class("BattleKaliChallengeTemplate", BattleBaseStageTemplate)

function BattleKaliChallengeTemplate:Ctor(arg_1_1, arg_1_2)
	BattleKaliChallengeTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleCoreKaliCfg[arg_1_1]
end

function BattleKaliChallengeTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleKaliChallengeTemplate:InitChipData()
	self.chipList_ = {}
end

function BattleKaliChallengeTemplate:GetDest()
	return self.id
end

function BattleKaliChallengeTemplate:GetStageId()
	return self.id
end

function BattleKaliChallengeTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE
end

function BattleKaliChallengeTemplate:GetStageAffix()
	local var_7_0 = ActivityTools.GetMainActivityId(self.activityID_)
	local var_7_1 = SPKaliChallengeData:GetSPChallengeData(var_7_0)
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = {}

	for iter_7_0, iter_7_1 in pairs((var_7_1 or nil) and (var_7_1.showAffix or {})) do
		if ActivityAffixPoolCfg[iter_7_1] then
			local var_7_5 = table.indexof(var_7_2, ActivityAffixPoolCfg[iter_7_1].affix[1])

			if not var_7_5 then
				table.insert(var_7_2, ActivityAffixPoolCfg[iter_7_1].affix[1])
				table.insert(var_7_3, ActivityAffixPoolCfg[iter_7_1].affix[2])
				table.insert(var_7_4, ActivityAffixPoolCfg[iter_7_1].affix[3])
			else
				var_7_3[var_7_5] = var_7_3[var_7_5] + ActivityAffixPoolCfg[iter_7_1].affix[2]
			end
		end
	end

	local var_7_6 = SPKaliChallengeData:GetNowAffixEffect(var_7_0)

	if var_7_6 then
		local var_7_7 = ActivityAffixPoolCfg[(ActivitykaliaffixCfg[var_7_6] or nil) and (ActivitykaliaffixCfg[var_7_6].affix_id or 0)]

		if ActivityAffixPoolCfg[(ActivitykaliaffixCfg[var_7_6] or nil) and (ActivitykaliaffixCfg[var_7_6].affix_id or 0)] then
			local var_7_8 = table.indexof(var_7_2, var_7_7.affix[1])

			if not var_7_8 then
				table.insert(var_7_2, var_7_7.affix[1])
				table.insert(var_7_3, var_7_7.affix[2])
				table.insert(var_7_4, var_7_7.affix[3])
			else
				var_7_3[var_7_8] = var_7_3[var_7_8] + var_7_7.affix[2]
			end
		end
	end

	return var_7_2, var_7_3, var_7_4
end

function BattleKaliChallengeTemplate:GetMap()
	return self.cfg.map, false
end

function BattleKaliChallengeTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleKaliChallengeTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleKaliChallengeTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleKaliChallengeTemplate:GetLevelID()
	return self.cfg.level
end

function BattleKaliChallengeTemplate:GetMainActivityID()
	return self.activityID_
end

return BattleKaliChallengeTemplate

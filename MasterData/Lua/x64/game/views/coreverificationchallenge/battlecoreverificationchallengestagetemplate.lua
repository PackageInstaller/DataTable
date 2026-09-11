BattleBaseStageTemplate = import("game.battle.template.BattleBaseStageTemplate")

local BattleCoreVerificationChallengeStageTemplate = class("BattleCoreVerificationChallengeStageTemplate", BattleBaseStageTemplate)

function BattleCoreVerificationChallengeStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleCoreVerificationChallengeStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = nullable(CoreVerificationChallengeTools.GetBattleClCfg(arg_1_2), self.id)
end

function BattleCoreVerificationChallengeStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleCoreVerificationChallengeStageTemplate:GetDest()
	return self.id
end

function BattleCoreVerificationChallengeStageTemplate:GetStageId()
	return self.id
end

function BattleCoreVerificationChallengeStageTemplate:GetType()
	return CoreVerificationChallengeTools.GetBattleStageType(self.activityID_)
end

function BattleCoreVerificationChallengeStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleCoreVerificationChallengeStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleCoreVerificationChallengeStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleCoreVerificationChallengeStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleCoreVerificationChallengeStageTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}
	local var_10_4 = CoreVerificationChallengeTools.GetModeCfg()
	local var_10_5 = CoreVerificationChallengeTools.GetModeIndex()

	for iter_10_0, iter_10_1 in pairs(var_10_4[self.id].stage_com_affix or {}) do
		table.insert(var_10_3, ActivityAffixPoolCfg[iter_10_1].affix)
	end

	for iter_10_2, iter_10_3 in pairs(var_10_4[self.id].stage_affix or {}) do
		table.insert(var_10_3, ActivityAffixPoolCfg[iter_10_3].affix)
	end

	if var_10_5 == 1 then
		if var_10_4[self.id].stage_type == 1 then
			for iter_10_4, iter_10_5 in pairs(var_10_4[self.id].stage_buff or {}) do
				ActivityAffixPoolCfg[iter_10_5[1]].affix[2] = CoreVerificationChallengeData:GetBuffLevelById(affixId)

				table.insert(var_10_3, ActivityAffixPoolCfg[iter_10_5[1]].affix)
			end

			for iter_10_6, iter_10_7 in pairs(var_10_4[self.id].stage_debuff or {}) do
				local var_10_6 = ActivityAffixPoolCfg[iter_10_7[1]].affix

				var_10_6[2] = ActivityAffixPoolCfg[iter_10_7[1]].affix[2] == 50 and 1 or var_10_6[2]

				table.insert(var_10_3, var_10_6)
			end
		else
			for iter_10_8, iter_10_9 in pairs(CoreVerificationChallengeData:GetSelectAffixs() or {}) do
				ActivityAffixPoolCfg[iter_10_9.buff_id].affix[2] = CoreVerificationChallengeData:GetBuffLevelById(iter_10_9.buff_id)

				table.insert(var_10_3, ActivityAffixPoolCfg[iter_10_9.buff_id].affix)
			end
		end
	elseif var_10_5 == 2 then
		if var_10_4[self.id].stage_type == 1 then
			for iter_10_10, iter_10_11 in pairs(var_10_4[self.id].stage_buff or {}) do
				table.insert(var_10_3, ActivityAffixPoolCfg[iter_10_11].affix)
			end
		else
			for iter_10_12, iter_10_13 in pairs(CoreVerificationChallengeMode2Data:GetSelectAffixs() or {}) do
				table.insert(var_10_3, ActivityAffixPoolCfg[iter_10_13.buff_id].affix)
			end
		end
	else
		for iter_10_14, iter_10_15 in pairs(var_10_4[self.id].type_affix or {}) do
			table.insert(var_10_3, ActivityAffixPoolCfg[iter_10_15].affix)
		end
	end

	for iter_10_16, iter_10_17 in pairs(var_10_3 or {}) do
		table.insert(var_10_0, iter_10_17[1])
		table.insert(var_10_1, iter_10_17[2] == 50 and 1 or iter_10_17[2])
		table.insert(var_10_2, iter_10_17[3])
	end

	return var_10_0, var_10_1, var_10_2
end

function BattleCoreVerificationChallengeStageTemplate:GetOpts()
	local var_11_0 = {}
	local var_11_1 = CoreVerificationChallengeTools.GetModeIndex()
	local var_11_2 = {}

	if var_11_1 == 1 then
		var_11_2 = CoreVerificationChallengeData:GetSelectAffixs()
	elseif var_11_1 == 2 then
		var_11_2 = CoreVerificationChallengeMode2Data:GetSelectAffixs()
	end

	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_2 or {}) do
		table.insert(var_11_3, iter_11_1.buff_id)
	end

	table.insert(var_11_0, {
		key = 1,
		value = var_11_3
	})
	table.insert(var_11_0, {
		key = 2,
		value = {
			self:GetTeamIndex()
		}
	})

	return var_11_0
end

return BattleCoreVerificationChallengeStageTemplate

local BattleCoreVerificationTemplate = class("BattleCoreVerificationTemplate", BattleBaseStageTemplate)

function BattleCoreVerificationTemplate:Ctor(arg_1_1, arg_1_2)
	BattleCoreVerificationTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.infoID = arg_1_2
	self.cfg = BattleCoreVerificationCfg[self.id]
end

function BattleCoreVerificationTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleCoreVerificationTemplate:GetDest()
	return self.infoID
end

function BattleCoreVerificationTemplate:GetStageId()
	return self.id
end

function BattleCoreVerificationTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION
end

function BattleCoreVerificationTemplate:GetMap()
	return self.cfg.map, false
end

function BattleCoreVerificationTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleCoreVerificationTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleCoreVerificationTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleCoreVerificationTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in pairs(CoreVerificationInfoCfg[self.infoID].affix_type or {}) do
		table.insert(var_10_0, iter_10_1[1])
		table.insert(var_10_1, iter_10_1[2])
		table.insert(var_10_2, iter_10_1[3])
	end

	if CoreVerificationData:IsChallengeType(self.infoID) then
		for iter_10_2, iter_10_3 in ipairs((CoreVerificationData:GetSelectSuffix())) do
			if ActivityAffixPoolCfg[iter_10_3] then
				table.insert(var_10_0, ActivityAffixPoolCfg[iter_10_3].affix[1])
				table.insert(var_10_1, ActivityAffixPoolCfg[iter_10_3].affix[2])
				table.insert(var_10_2, ActivityAffixPoolCfg[iter_10_3].affix[3])
			end
		end
	end

	return var_10_0, var_10_1, var_10_2
end

function BattleCoreVerificationTemplate:GetAttributeFactor()
	return Vector3.New(CoreVerificationInfoCfg[self.infoID].attribute_factor[1] / 1000, CoreVerificationInfoCfg[self.infoID].attribute_factor[2] / 1000, CoreVerificationInfoCfg[self.infoID].attribute_factor[3] / 1000)
end

return BattleCoreVerificationTemplate

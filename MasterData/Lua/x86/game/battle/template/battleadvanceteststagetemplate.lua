local BattleAdvanceTestStageTemplate = class("BattleAdvanceTestStageTemplate", BattleBaseStageTemplate)

function BattleAdvanceTestStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleAdvanceTestStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.dest = arg_1_2.dest
	self.activityID_ = arg_1_2.activityID
	self.cfg = BattleAdvanceTestStageCfg[arg_1_1]
end

function BattleAdvanceTestStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleAdvanceTestStageTemplate:GetActivityID()
	return self.activityID_
end

function BattleAdvanceTestStageTemplate:GetDest()
	return self.dest
end

function BattleAdvanceTestStageTemplate:GetRoleDatas()
	return self.roleDataInLua
end

function BattleAdvanceTestStageTemplate:UpdateRoleDatas(arg_6_1)
	self.serverTeamPlayer = arg_6_1
	self.roleDataInLua = {}

	local var_6_0 = self:GetSystemHeroTeam()

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetAdvanceTestHeroData(iter_6_1, (iter_6_1.trialID ~= 0 or nil) and (iter_6_1.trialID or var_6_0[iter_6_0] or 0), arg_6_1.playerID, arg_6_1.level)))
	end

	self:SetMaxRaceData()
end

function BattleAdvanceTestStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleAdvanceTestStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleAdvanceTestStageTemplate:GetStageId()
	return self.id
end

function BattleAdvanceTestStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleAdvanceTestStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST
end

function BattleAdvanceTestStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleAdvanceTestStageTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = AdvanceTestData:GetAffixList()

	if var_13_3 and #var_13_3 > 0 then
		for iter_13_0, iter_13_1 in pairs(var_13_3) do
			table.insert(var_13_0, ActivityAffixPoolCfg[iter_13_1].affix[1])
			table.insert(var_13_1, ActivityAffixPoolCfg[iter_13_1].affix[2])
			table.insert(var_13_2, ActivityAffixPoolCfg[iter_13_1].affix[3])
		end
	end

	for iter_13_2, iter_13_3 in pairs((AdvanceTestData:GetSelectBuffList((self:GetDest())))) do
		table.insert(var_13_0, ActivityAffixPoolCfg[iter_13_3].affix[1])
		table.insert(var_13_1, ActivityAffixPoolCfg[iter_13_3].affix[2])
		table.insert(var_13_2, ActivityAffixPoolCfg[iter_13_3].affix[3])
	end

	return var_13_0, var_13_1, var_13_2
end

function BattleAdvanceTestStageTemplate:GetOpts()
	local var_14_0 = {}
	local var_14_1 = self:GetDest()

	table.insert(var_14_0, {
		key = 1,
		value = AdvanceTestData:GetSelectBuffList(var_14_1)
	})

	return var_14_0
end

return BattleAdvanceTestStageTemplate

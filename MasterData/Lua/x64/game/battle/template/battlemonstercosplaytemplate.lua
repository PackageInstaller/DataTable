local BattleMonsterCosplayTemplate = class("BattleMonsterCosplayTemplate", BattleBaseStageTemplate)

function BattleMonsterCosplayTemplate:Ctor(arg_1_1, arg_1_2)
	BattleMonsterCosplayTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2.activityID
	self.levelID_ = arg_1_2.levelID
	self.cfg = BattleActivityMonsterCosplayCfg[arg_1_1]
	self.monsterID = arg_1_2.monsterID
end

function BattleMonsterCosplayTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleMonsterCosplayTemplate:InitChipData()
	self.chipList_ = {}
end

function BattleMonsterCosplayTemplate:GetDest()
	return self.id
end

function BattleMonsterCosplayTemplate:GetStageId()
	return self.id
end

function BattleMonsterCosplayTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY
end

function BattleMonsterCosplayTemplate:GetMap()
	return self.cfg.map, false
end

function BattleMonsterCosplayTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleMonsterCosplayTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleMonsterCosplayTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleMonsterCosplayTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs(MonsterCosplayData:GetDataByPara("monsterData")[self.monsterID].enhancedSkill) do
		table.insert(var_11_0, TalentTreeCfg[iter_11_0].affix_id)
		table.insert(var_11_1, 1)
		table.insert(var_11_2, TalentTreeCfg[iter_11_0].affix_user)
	end

	for iter_11_2, iter_11_3 in pairs(MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[self.monsterID]) do
		if iter_11_3 then
			table.insert(var_11_0, TalentTreeCfg[iter_11_2].affix_id)
			table.insert(var_11_1, 1)
			table.insert(var_11_2, TalentTreeCfg[iter_11_2].affix_user)
		end
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleMonsterCosplayTemplate:GetLevelID()
	return self.cfg.level
end

function BattleMonsterCosplayTemplate:GetMainActivityID()
	return self.activityID_
end

function BattleMonsterCosplayTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_14_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_14_0[1] and ItemTools.getItemNum(var_14_0[1]) or 0, var_14_0[2] or 0
end

return BattleMonsterCosplayTemplate

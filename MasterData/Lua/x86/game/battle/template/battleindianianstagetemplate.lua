local BattleIndiaNianStageTemplate = class("BattleIndiaNianStageTemplate", BattleBaseStageTemplate)

function BattleIndiaNianStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleIndiaNianStageTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.stageID_ = arg_1_1
	self.cfg = BattleStageTools.GetStageCfg(self:GetType(), arg_1_1)
	self.destID_ = IndiaNianData:GetSelectedDestID()
end

function BattleIndiaNianStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleIndiaNianStageTemplate:GetDest()
	return self.destID_
end

function BattleIndiaNianStageTemplate:GetStageId()
	return self.stageID_
end

function BattleIndiaNianStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN
end

function BattleIndiaNianStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleIndiaNianStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleIndiaNianStageTemplate:GetActivityID()
	return self.activityID_
end

function BattleIndiaNianStageTemplate:GetThreeStar()
	return {}
end

function BattleIndiaNianStageTemplate:GetCost()
	return IndiaNianData:GetSelectedStageCost()
end

function BattleIndiaNianStageTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	if IndiaNianCfg[IndiaNianData:GetSelectedDestID()].group_id == 100 then
		for iter_11_0, iter_11_1 in ipairs((IndiaNianData:GetClearedBossIDList())) do
			for iter_11_2, iter_11_3 in ipairs(IndiaNianCfg[iter_11_1].affix_reward) do
				table.insert(var_11_0, iter_11_3[1])
				table.insert(var_11_1, iter_11_3[2])
				table.insert(var_11_2, iter_11_3[3])
			end
		end
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleIndiaNianStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleIndiaNianStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

return BattleIndiaNianStageTemplate

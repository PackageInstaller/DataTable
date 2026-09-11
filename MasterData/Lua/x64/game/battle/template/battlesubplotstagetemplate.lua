local BattleSubPlotStageTemplate = class("BattleSubPlotStageTemplate", BattleBaseStageTemplate)

function BattleSubPlotStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSubPlotStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
end

function BattleSubPlotStageTemplate:Init()
	self.cfg = BattleActivityStoryStageCfg[self:GetStageId()]

	if BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		self.heroList_ = {}
		self.heroTrialList_ = {}
	else
		self:InitHeroList()
	end

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSubPlotStageTemplate:GetClearTime()
	local var_3_0 = BattleStageData:GetStageData()[self.id]

	if var_3_0 and var_3_0.clear_times then
		return var_3_0.clear_times
	else
		return 0
	end
end

function BattleSubPlotStageTemplate:GetDest()
	return self.id
end

function BattleSubPlotStageTemplate:GetStageId()
	return self.id
end

function BattleSubPlotStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
end

function BattleSubPlotStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSubPlotStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSubPlotStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSubPlotStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSubPlotStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleSubPlotStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleSubPlotStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleSubPlotStageTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" or BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		return false, 0, 0, 0
	end

	local var_14_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_14_0[1] and ItemTools.getItemNum(var_14_0[1]) or 0, var_14_0[2] or 0
end

return BattleSubPlotStageTemplate

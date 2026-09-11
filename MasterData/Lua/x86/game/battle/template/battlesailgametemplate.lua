local BattleSailGameTemplate = class("BattleSailGameTemplate", BattleBaseStageTemplate)

function BattleSailGameTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSailGameTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleSailGameStageCfg[arg_1_1]
end

function BattleSailGameTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSailGameTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SAIL_GAME
end

function BattleSailGameTemplate:GetStageId()
	return self.id_
end

function BattleSailGameTemplate:GetDest()
	local var_5_0 = SailGameData:GetCurGameData(self.activityID_)

	return var_5_0.eventList[var_5_0.curStageIndex].order
end

function BattleSailGameTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSailGameTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleSailGameTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleSailGameTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSailGameTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleSailGameTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleSailGameTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleSailGameTemplate

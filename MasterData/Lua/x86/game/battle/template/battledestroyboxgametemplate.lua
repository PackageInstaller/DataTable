local BattleDestroyBoxGameTemplate = class("BattleDestroyBoxGameTemplate", BattleBaseStageTemplate)

function BattleDestroyBoxGameTemplate:Ctor(arg_1_1, arg_1_2)
	BattleDestroyBoxGameTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleStageTools.GetStageCfg(self:GetType(), arg_1_1)
end

function BattleDestroyBoxGameTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleDestroyBoxGameTemplate:GetDest()
	return DestroyBoxGameData:GetSelectID(DestroyBoxGameCfg[DestroyBoxGameCfg.get_id_list_by_activity_id[self:GetActivityID()][1]].main_activity_id)
end

function BattleDestroyBoxGameTemplate:GetStageId()
	return self.id
end

function BattleDestroyBoxGameTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME
end

function BattleDestroyBoxGameTemplate:GetMap()
	return self.cfg.map, false
end

function BattleDestroyBoxGameTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleDestroyBoxGameTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleDestroyBoxGameTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleDestroyBoxGameTemplate:GetActivityID()
	return self.activityID_
end

return BattleDestroyBoxGameTemplate

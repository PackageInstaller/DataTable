local BattleSandPlayStageTemplate = class("BattleSandPlayStageTemplate", BattleBaseStageTemplate)

function BattleSandPlayStageTemplate:Ctor(arg_1_1)
	BattleSandPlayStageTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.stageID_ = arg_1_1
	self.cfg_ = BattleSandPlayStageCfg[self.stageID_]
	self.destID_ = arg_1_1
	self.activityId_ = 323841

	self:InitHeroList()
end

function BattleSandPlayStageTemplate:InitHeroList()
	self.heroList_ = {}
	self.heroTrialList_ = {}

	for iter_2_0, iter_2_1 in ipairs(self.cfg_.hero_list) do
		table.insert(self.heroList_, iter_2_1[1])
		table.insert(self.heroTrialList_, iter_2_1[2])
	end
end

function BattleSandPlayStageTemplate:GetDest()
	return self.stageID_
end

function BattleSandPlayStageTemplate:GetComboSkillID()
	return 67
end

function BattleSandPlayStageTemplate:GetStageId()
	return self.stageID_
end

function BattleSandPlayStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SAND_PLAY
end

function BattleSandPlayStageTemplate:GetMap()
	return self.cfg_.map, false
end

function BattleSandPlayStageTemplate:GetEnemyLevel()
	return self.cfg_.monster_level
end

function BattleSandPlayStageTemplate:GetAILevel()
	return self.cfg_.ai_level
end

function BattleSandPlayStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSandPlayStageTemplate:GetActivityID()
	return self.activityId_
end

return BattleSandPlayStageTemplate

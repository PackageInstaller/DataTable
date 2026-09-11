local BattleOsirisStoryStageTemplate = class("BattleOsirisStoryStageTemplate", BattleBaseStageTemplate)

function BattleOsirisStoryStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleOsirisStoryStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleActivityStoryStageCfg[arg_1_1]
end

function BattleOsirisStoryStageTemplate:Init()
	if BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		self.heroList = {}
		self.heroTrialList_ = {}
	else
		self:InitHeroList()
	end

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleOsirisStoryStageTemplate:GetDest()
	return self.id
end

function BattleOsirisStoryStageTemplate:GetStageId()
	return self.id
end

function BattleOsirisStoryStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY
end

function BattleOsirisStoryStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleOsirisStoryStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleOsirisStoryStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleOsirisStoryStageTemplate:GetHeroTeam()
	return self.heroList, self.heroTrialList_
end

function BattleOsirisStoryStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleOsirisStoryStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleOsirisStoryStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleOsirisStoryStageTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" or BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		return false, 0, 0, 0
	end

	local var_13_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_13_0[1] and ItemTools.getItemNum(var_13_0[1]) or 0, var_13_0[2] or 0
end

function BattleOsirisStoryStageTemplate:GetClearTime()
	local var_14_0 = StoryStageActivityData:GetHistoryChapter(self.activityID_)

	if var_14_0 == nil then
		return 0
	end

	local var_14_1 = StoryStageActivityData:GetStageData(var_14_0)[self.id]

	if var_14_1 and var_14_1.clear_times then
		return var_14_1.clear_times
	else
		return 0
	end
end

return BattleOsirisStoryStageTemplate

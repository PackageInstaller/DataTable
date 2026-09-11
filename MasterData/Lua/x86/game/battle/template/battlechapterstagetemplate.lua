local BattleChapterStageTemplate = class("BattleChapterStageTemplate", BattleBaseStageTemplate)

function BattleChapterStageTemplate:Ctor(arg_1_1)
	BattleChapterStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
end

function BattleChapterStageTemplate:Init()
	self.cfg = BattleChapterStageCfg[self:GetStageId()]

	if BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		self.heroList_ = {}
		self.heroTrialList_ = {}
	else
		self:InitHeroList()
	end

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleChapterStageTemplate:GetDest()
	return self.id
end

function BattleChapterStageTemplate:GetStageId()
	return self.id
end

function BattleChapterStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
end

function BattleChapterStageTemplate:GetMap()
	local var_6_0 = BattleStageData:GetStageData()[self.cfg.id]

	if var_6_0 == nil then
		if GameSetting.guide_map.value2[self.cfg.id] then
			return GameSetting.guide_map.value2[self.cfg.id], true
		else
			return self.cfg.map, false
		end
	end

	if (not var_6_0.clear_times or var_6_0.clear_times <= 0) and GameSetting.guide_map.value2[self.cfg.id] then
		return GameSetting.guide_map.value2[self.cfg.id], true
	end

	return self.cfg.map, false
end

function BattleChapterStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleChapterStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleChapterStageTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" or BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		return false, 0, 0, 0
	end

	local var_9_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_9_0[1] and ItemTools.getItemNum(var_9_0[1]) or 0, var_9_0[2] or 0
end

function BattleChapterStageTemplate:GetClearTime()
	local var_10_0 = BattleStageData:GetStageData()[self.id]

	if var_10_0 and var_10_0.clear_times then
		return var_10_0.clear_times
	else
		return 0
	end
end

function BattleChapterStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleChapterStageTemplate:GetThreeStar()
	if self.cfg.three_star_need == "" then
		return {}
	end

	return self.cfg.three_star_need
end

function BattleChapterStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleChapterStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleChapterStageTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleChapterStageTemplate

local BattleActivityPtScrollTemplate = class("BattleActivityPtScrollTemplate", BattleBaseStageTemplate)

function BattleActivityPtScrollTemplate:Ctor(arg_1_1, arg_1_2)
	BattleActivityPtScrollTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.stageID_ = arg_1_1
	self.cfg = BattleStageTools.GetStageCfg(self:GetType(), arg_1_1)
	self.destID_ = 0

	for iter_1_0, iter_1_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.activityID_]) do
		if ActivityPtRouletteStageCfg[iter_1_1].stage_id == self.stageID_ then
			self.destID_ = iter_1_1
		end
	end
end

function BattleActivityPtScrollTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityPtScrollTemplate:GetDest()
	return self.destID_
end

function BattleActivityPtScrollTemplate:GetStageId()
	return self.stageID_
end

function BattleActivityPtScrollTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL
end

function BattleActivityPtScrollTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityPtScrollTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityPtScrollTemplate:GetActivityID()
	return self.activityID_
end

function BattleActivityPtScrollTemplate:GetThreeStar()
	return {}
end

function BattleActivityPtScrollTemplate:GetCost()
	return ActivityPtRouletteStageCfg[self:GetDest()].cost[2] or 0
end

function BattleActivityPtScrollTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = manager.time:GetGameServerWeek()

	for iter_11_0, iter_11_1 in ipairs(ActivityPtRouletteStageCfg[self:GetDest()].roulette_id) do
		if ActivityPtRouletteRandomCfg[iter_11_1].time == var_11_3 then
			for iter_11_2, iter_11_3 in ipairs(ActivityPtRouletteRandomCfg[iter_11_1].affix_list) do
				table.insert(var_11_0, ActivityPtRouletteAffixCfg[iter_11_3].affix_list[1])
				table.insert(var_11_1, ActivityPtRouletteAffixCfg[iter_11_3].affix_list[2])
				table.insert(var_11_2, ActivityPtRouletteAffixCfg[iter_11_3].affix_list[3])
			end

			local var_11_4 = ActivityPtScrollData:GetChooseAffixID(self.activityID_)
			local var_11_5 = ActivityPtScrollData:GetAffixInfo(self.activityID_, var_11_4)

			if not table.indexof(var_11_0, var_11_5.affix) then
				table.insert(var_11_0, var_11_5.affix)
				table.insert(var_11_1, var_11_5.level)
				table.insert(var_11_2, var_11_5.target)
			end

			for iter_11_4, iter_11_5 in ipairs(ActivityPtRouletteAffixCfg[var_11_4].affix_list2) do
				table.insert(var_11_0, iter_11_5[1])
				table.insert(var_11_1, iter_11_5[2])
				table.insert(var_11_2, iter_11_5[3])
			end

			break
		end
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleActivityPtScrollTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleActivityPtScrollTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleActivityPtScrollTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityPtScrollTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

return BattleActivityPtScrollTemplate

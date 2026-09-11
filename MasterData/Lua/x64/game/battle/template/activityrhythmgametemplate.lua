local ActivityRhythmGameTemplate = class("ActivityRhythmGameTemplate", BattleBaseStageTemplate)

function ActivityRhythmGameTemplate:Ctor(arg_1_1, arg_1_2)
	ActivityRhythmGameTemplate.super.Ctor(self, arg_1_1)

	self.stageID_ = arg_1_1
	self.activityID_ = arg_1_2.activityID
	self.notActivity_ = arg_1_2.notActivity
	self.battleCfg_ = BattleRhythmGameStageCfg[arg_1_1]

	if arg_1_2.cfgID ~= arg_1_1 then
		self.cfgID_ = arg_1_2.cfgID
		self.activityCfg_ = ActivityRhythmGameCfg[self.cfgID_]
		self.stars = self.activityCfg_ and self.activityCfg_.three_star_need or {}
	end
end

function ActivityRhythmGameTemplate:Init()
	self:InitHeroList()
end

function ActivityRhythmGameTemplate:InitHeroList()
	self.heroList_ = {}

	for iter_3_0 = 1, 3 do
		if self.battleCfg_.hero_list[iter_3_0][1] ~= 0 then
			table.insert(self.heroList_, self.battleCfg_.hero_list[iter_3_0][2])
		else
			table.insert(self.heroList_, 0)
		end
	end

	self.heroTrialList_ = {}
end

function ActivityRhythmGameTemplate:GetDest()
	if self.notActivity_ then
		return 0
	else
		return self.stageID_
	end
end

function ActivityRhythmGameTemplate:GetStageId()
	return self.stageID_
end

function ActivityRhythmGameTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME
end

function ActivityRhythmGameTemplate:GetMap()
	return self.battleCfg_.map, false
end

function ActivityRhythmGameTemplate:GetAILevel()
	return self.battleCfg_.ai_level
end

function ActivityRhythmGameTemplate:GetEnemyLevel()
	return self.battleCfg_.monster_level
end

function ActivityRhythmGameTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function ActivityRhythmGameTemplate:GetSystemHeroTeam()
	return self.heroList_
end

function ActivityRhythmGameTemplate:GetAddUserExp()
	return self.battleCfg_.user_exp or 0
end

function ActivityRhythmGameTemplate:GetAddHeroExp()
	return self.battleCfg_.hero_exp or 0
end

function ActivityRhythmGameTemplate:GetCost()
	return self.battleCfg_.cost or 0
end

function ActivityRhythmGameTemplate:GetThreeStar()
	if self.stars == "" or self.stars == nil then
		return {}
	end

	return self.stars
end

function ActivityRhythmGameTemplate:GetStageAffix()
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = {}

	for iter_16_0, iter_16_1 in pairs((ActivityRhythmGameData:GetCommandListByStageID(self.stageID_))) do
		table.insert(var_16_0, TalentTreeCfg[iter_16_1].affix_id)
		table.insert(var_16_1, 1)
		table.insert(var_16_2, TalentTreeCfg[iter_16_1].affix_user)
	end

	return var_16_0, var_16_1, var_16_2
end

return ActivityRhythmGameTemplate

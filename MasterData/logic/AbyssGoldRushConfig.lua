-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/config/AbyssGoldRushConfig.lua

module("logic.extensions.abyssgoldrush.config.AbyssGoldRushConfig", package.seeall)

local AbyssGoldRushConfig = class("AbyssGoldRushConfig", BaseConfig)

function AbyssGoldRushConfig:onInit()
	return
end

function AbyssGoldRushConfig:getNames()
	return {
		"abyss_gold_rush_round",
		"abyss_gold_rush_holy_stripe",
		"abyss_gold_rush_creeps",
		"abyss_gold_rush_step",
		"abyss_gold_rush_robot_form",
		"abyss_gold_rush_pet_box_plan",
		"abyss_gold_rush_score_level",
		"abyss_gold_rush_rank_prize",
		"abyss_gold_rush_streak_score",
		"abyss_gold_rush_creeps_master",
		"abyss_gold_rush_support_pet",
		"abyss_gold_rush_holy_stripe_drop",
		"abyss_gold_rush_activity",
		"abyss_gold_rush_score_rank_prize"
	}
end

function AbyssGoldRushConfig:handleConfig(name, content)
	if name == "abyss_gold_rush_round" then
		self._abyss_gold_rush_round = content
	elseif name == "abyss_gold_rush_holy_stripe" then
		self._abyss_gold_rush_holy_stripe = content
	elseif name == "abyss_gold_rush_creeps" then
		self._abyss_gold_rush_creeps = content
	elseif name == "abyss_gold_rush_step" then
		self._abyss_gold_rush_step = content
	elseif name == "abyss_gold_rush_robot_form" then
		self._abyss_gold_rush_robot_form = content
	elseif name == "abyss_gold_rush_pet_box_plan" then
		self._abyss_gold_rush_pet_box_plan = content
	elseif name == "abyss_gold_rush_score_level" then
		self._abyss_gold_rush_score_level = content
	elseif name == "abyss_gold_rush_rank_prize" then
		self._abyss_gold_rush_rank_prize = content
	elseif name == "abyss_gold_rush_streak_score" then
		self._abyss_gold_rush_streak_score = content
	elseif name == "abyss_gold_rush_creeps_master" then
		self._abyss_gold_rush_creeps_master = content
	elseif name == "abyss_gold_rush_support_pet" then
		self._abyss_gold_rush_support_pet = content
	elseif name == "abyss_gold_rush_holy_stripe_drop" then
		self._abyss_gold_rush_holy_stripe_drop = content
	elseif name == "abyss_gold_rush_activity" then
		self._abyss_gold_rush_activity = content
	elseif name == "abyss_gold_rush_score_rank_prize" then
		self._abyss_gold_rush_score_rank_prize = content
	end
end

function AbyssGoldRushConfig:getSupportPet(creepsId)
	return self._abyss_gold_rush_support_pet and self._abyss_gold_rush_support_pet[creepsId]
end

function AbyssGoldRushConfig:getCreepsCfg(creepsMasterId)
	return self._abyss_gold_rush_creeps and self._abyss_gold_rush_creeps[creepsMasterId]
end

function AbyssGoldRushConfig:getTeamCfg(creepsMasterId)
	return self._abyss_gold_rush_creeps_master and self._abyss_gold_rush_creeps_master[creepsMasterId]
end

function AbyssGoldRushConfig:getActivityCfg(activityId)
	return self._abyss_gold_rush_activity and self._abyss_gold_rush_activity[activityId]
end

function AbyssGoldRushConfig:getHolyStripeCfg(holyStripeId)
	return self._abyss_gold_rush_holy_stripe and self._abyss_gold_rush_holy_stripe[holyStripeId]
end

function AbyssGoldRushConfig:getGoldRankPrizeCfgs(activityId)
	if self._abyss_gold_rush_rank_prize[activityId] then
		return self._abyss_gold_rush_rank_prize[activityId]
	end
end

function AbyssGoldRushConfig:getScoreRankPrizeCfgs(activityId)
	if self._abyss_gold_rush_score_rank_prize[activityId] then
		return self._abyss_gold_rush_score_rank_prize[activityId]
	end
end

function AbyssGoldRushConfig:getPetCfg(creepsId)
	creepsId = checknumber(creepsId)

	if creepsId <= 0 then
		return nil
	end

	local supportPet = self:getSupportPet(creepsId)

	if supportPet then
		return supportPet
	end

	for _, creepsList in pairs(self._abyss_gold_rush_creeps or {}) do
		for _, cfg in pairs(creepsList) do
			if checknumber(cfg.creepsId) == creepsId then
				return cfg
			end
		end
	end
end

function AbyssGoldRushConfig:getStepCfgs(activityId)
	return self._abyss_gold_rush_step[activityId]
end

function AbyssGoldRushConfig:getStepCfg(activityId, stepId)
	if self._abyss_gold_rush_step[activityId] then
		return self._abyss_gold_rush_step[activityId][stepId]
	end
end

function AbyssGoldRushConfig:getRoundCfg(activityId, roundId)
	if self._abyss_gold_rush_round[activityId] then
		return self._abyss_gold_rush_round[activityId][roundId]
	end
end

function AbyssGoldRushConfig:getRobotCfg(robotId, formId)
	if self._abyss_gold_rush_robot_form[robotId] then
		return self._abyss_gold_rush_robot_form[robotId][formId]
	end
end

function AbyssGoldRushConfig:getHolyStripeCfg(holyStripeId)
	return self._abyss_gold_rush_holy_stripe[holyStripeId]
end

function AbyssGoldRushConfig:getStreakCfgs(activityId)
	return self._abyss_gold_rush_streak_score[activityId]
end

function AbyssGoldRushConfig:getScoreLevelCfgs(activityId)
	return self._abyss_gold_rush_score_level[activityId]
end

function AbyssGoldRushConfig:getScoreLevelCfg(activityId, id)
	if self._abyss_gold_rush_score_level[activityId] then
		return self._abyss_gold_rush_score_level[activityId][id]
	end
end

AbyssGoldRushConfig.instance = AbyssGoldRushConfig.New()

return AbyssGoldRushConfig

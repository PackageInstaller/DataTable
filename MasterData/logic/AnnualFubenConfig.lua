-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/config/AnnualFubenConfig.lua

module("logic.extensions.annualfuben.config.AnnualFubenConfig", package.seeall)

local AnnualFubenConfig = class("AnnualFubenConfig", BaseConfig)

function AnnualFubenConfig:getNames()
	return {
		"annual_fuben_clue",
		"annual_fuben_activity",
		"annual_fuben_stage_rank_prize",
		"annual_fuben_creeps",
		"annual_fuben_creeps_team",
		"annual_fuben_clue_prize",
		"annual_fuben_support_pet",
		"annual_fuben_simple_stage",
		"annual_fuben_boss_prize",
		"annual_fuben_clue_formula",
		"annual_fuben_boss_rank_prize",
		"annual_fuben_stage",
		"annual_fuben_world"
	}
end

function AnnualFubenConfig:handleConfig(name, content)
	if name == "annual_fuben_clue" then
		self._annual_fuben_clue = content
	elseif name == "annual_fuben_activity" then
		self._annual_fuben_activity = content
	elseif name == "annual_fuben_stage_rank_prize" then
		self._annual_fuben_stage_rank_prize = content
	elseif name == "annual_fuben_creeps" then
		self._annual_fuben_creeps = content
	elseif name == "annual_fuben_creeps_team" then
		self._annual_fuben_creeps_team = content
	elseif name == "annual_fuben_clue_prize" then
		self._annual_fuben_clue_prize = content
	elseif name == "annual_fuben_support_pet" then
		self._annual_fuben_support_pet = content
	elseif name == "annual_fuben_simple_stage" then
		self._annual_fuben_simple_stage = content
	elseif name == "annual_fuben_boss_prize" then
		self._annual_fuben_boss_prize = content
	elseif name == "annual_fuben_clue_formula" then
		self._annual_fuben_clue_formula = content
	elseif name == "annual_fuben_boss_rank_prize" then
		self._annual_fuben_boss_rank_prize = content
	elseif name == "annual_fuben_stage" then
		self._annual_fuben_stage = content
	elseif name == "annual_fuben_world" then
		self._annual_fuben_world = content
	end
end

function AnnualFubenConfig:getActivityCfg(activityId)
	return self._annual_fuben_activity[activityId]
end

function AnnualFubenConfig:getWorldCfgs(progressPlanId)
	return self._annual_fuben_world[progressPlanId]
end

function AnnualFubenConfig:getWorldCfg(progressPlanId, progressId)
	if self._annual_fuben_world[progressPlanId] then
		return self._annual_fuben_world[progressPlanId][progressId]
	end
end

function AnnualFubenConfig:getClueCfgs(activityId)
	return self._annual_fuben_clue[activityId]
end

function AnnualFubenConfig:getClueCfg(activityId, clueId)
	if self._annual_fuben_clue[activityId] then
		return self._annual_fuben_clue[activityId][clueId]
	end
end

function AnnualFubenConfig:getHoldStageCfgs(activityId)
	return self._annual_fuben_simple_stage[activityId]
end

function AnnualFubenConfig:getHoldStageCfg(activityId, stageId)
	if self._annual_fuben_simple_stage[activityId] then
		return self._annual_fuben_simple_stage[activityId][stageId]
	end
end

function AnnualFubenConfig:getTeamCfg(creepsMasterId)
	return self._annual_fuben_creeps_team[creepsMasterId]
end

function AnnualFubenConfig:getCreepsCfg(creepsMasterId)
	return self._annual_fuben_creeps[creepsMasterId]
end

function AnnualFubenConfig:getBrokenStageCfgs(activityId)
	return self._annual_fuben_stage[activityId]
end

function AnnualFubenConfig:getBrokenStageCfg(activityId, stageId)
	if self._annual_fuben_stage[activityId] then
		return self._annual_fuben_stage[activityId][stageId]
	end
end

function AnnualFubenConfig:getBossPrizeCfgs(activityId)
	return self._annual_fuben_boss_prize[activityId]
end

function AnnualFubenConfig:getCluePrizeCfgs(activityId)
	return self._annual_fuben_clue_prize[activityId]
end

function AnnualFubenConfig:getSupportPetCfgs(activityId)
	return self._annual_fuben_support_pet[activityId]
end

function AnnualFubenConfig:getSupportPetCfg(activityId, shopPosId)
	if self._annual_fuben_support_pet[activityId] then
		return self._annual_fuben_support_pet[activityId][shopPosId]
	end
end

function AnnualFubenConfig:getBrokenStageRankPrizeCfgs(activityId)
	return self._annual_fuben_stage_rank_prize[activityId]
end

function AnnualFubenConfig:getBossRankPrizeCfgs(activityId)
	return self._annual_fuben_boss_rank_prize[activityId]
end

AnnualFubenConfig.instance = AnnualFubenConfig.New()

return AnnualFubenConfig

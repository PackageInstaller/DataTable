-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/config/BreachFormMasterConfig.lua

module("logic.extensions.breachformmaster.config.BreachFormMasterConfig", package.seeall)

local BreachFormMasterConfig = class("BreachFormMasterConfig", BaseConfig)

function BreachFormMasterConfig:onInit()
	BreachFormMasterConfig.super.onInit(self)
end

function BreachFormMasterConfig:getNames()
	return {
		"breach_form_master_specify_race_score",
		"breach_form_master_defense_rank_prize",
		"breach_form_master_attack_rank_prize",
		"breach_form_master_step",
		"breach_form_master_circle_score",
		"breach_form_master_activity",
		"breach_form_master_stage",
		"breach_form_master_creeps_master",
		"breach_form_master_creeps"
	}
end

function BreachFormMasterConfig:handleConfig(name, content)
	if name == "breach_form_master_specify_race_score" then
		self._breach_form_master_specify_race_score = content
	elseif name == "breach_form_master_defense_rank_prize" then
		self._breach_form_master_defense_rank_prize = content
	elseif name == "breach_form_master_attack_rank_prize" then
		self._breach_form_master_attack_rank_prize = content
	elseif name == "breach_form_master_step" then
		self._breach_form_master_step = content
	elseif name == "breach_form_master_circle_score" then
		self._breach_form_master_circle_score = content
	elseif name == "breach_form_master_activity" then
		self._breach_form_master_activity = content
	elseif name == "breach_form_master_creeps_master" then
		self._breach_form_master_creeps_master = content
	elseif name == "breach_form_master_creeps" then
		self._breach_form_master_creeps = content
	elseif name == "breach_form_master_stage" then
		self._breach_form_master_stage = content
	end
end

function BreachFormMasterConfig:getActivityCfg(activityId)
	return self._breach_form_master_activity[activityId]
end

function BreachFormMasterConfig:getStepCfg(activityId, stepId)
	if self._breach_form_master_step[activityId] then
		return self._breach_form_master_step[activityId][stepId]
	end
end

function BreachFormMasterConfig:getStageCfgs(activityId, stepId)
	if self._breach_form_master_stage[activityId] then
		return self._breach_form_master_stage[activityId][stepId]
	end
end

function BreachFormMasterConfig:getStageCfg(activityId, stepId, stageId)
	if self._breach_form_master_stage[activityId] and self._breach_form_master_stage[activityId][stepId] then
		return self._breach_form_master_stage[activityId][stepId][stageId]
	end
end

function BreachFormMasterConfig:getRaceScorePlanCfg(raceScorePlanId)
	return self._breach_form_master_specify_race_score[raceScorePlanId]
end

function BreachFormMasterConfig:getTeamCfg(creepsMasterId)
	return self._breach_form_master_creeps_master[creepsMasterId]
end

function BreachFormMasterConfig:getCreepsCfg(creepsMasterId)
	return self._breach_form_master_creeps[creepsMasterId]
end

function BreachFormMasterConfig:getRankCfgByRank(activityId, type, stepId, rank)
	local cfgs = {}

	if type == 1 then
		cfgs = self._breach_form_master_attack_rank_prize[activityId][stepId]
	elseif type == 2 then
		cfgs = self._breach_form_master_defense_rank_prize[activityId][stepId]
	end

	for i, cfg in ipairs(cfgs) do
		if rank >= cfg.rank[1] and rank <= cfg.rank[2] then
			return cfg
		end
	end
end

function BreachFormMasterConfig:getAttackPrizeCfgs(activityId, stepId)
	if self._breach_form_master_attack_rank_prize[activityId] then
		return self._breach_form_master_attack_rank_prize[activityId][stepId]
	end
end

function BreachFormMasterConfig:getDefenscPrizeCfgs(activityId, stepId)
	if self._breach_form_master_defense_rank_prize[activityId] then
		return self._breach_form_master_defense_rank_prize[activityId][stepId]
	end
end

BreachFormMasterConfig.instance = BreachFormMasterConfig.New()

return BreachFormMasterConfig

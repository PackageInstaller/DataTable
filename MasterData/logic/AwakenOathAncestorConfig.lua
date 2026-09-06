-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/config/AwakenOathAncestorConfig.lua

module("logic.extensions.awakenoathancestor.config.AwakenOathAncestorConfig", package.seeall)

local AwakenOathAncestorConfig = class("AwakenOathAncestorConfig", BaseConfig)

function AwakenOathAncestorConfig:getNames()
	return {
		"awaken_oath_ancestor_activity",
		"awaken_oath_ancestor_point",
		"awaken_oath_ancestor_stage",
		"awaken_oath_ancestor_support_pet",
		"awaken_oath_ancestor_master",
		"awaken_oath_ancestor_creeps",
		"awaken_oath_ancestor_progress_prize"
	}
end

function AwakenOathAncestorConfig:handleConfig(name, content)
	if name == "awaken_oath_ancestor_activity" then
		self._awaken_oath_ancestor_activity = content
	elseif name == "awaken_oath_ancestor_point" then
		self._awaken_oath_ancestor_point = content
	elseif name == "awaken_oath_ancestor_stage" then
		self._awaken_oath_ancestor_stage = content
	elseif name == "awaken_oath_ancestor_support_pet" then
		self._awaken_oath_ancestor_support_pet = content
	elseif name == "awaken_oath_ancestor_master" then
		self._awaken_oath_ancestor_master = content
	elseif name == "awaken_oath_ancestor_creeps" then
		self._awaken_oath_ancestor_creeps = content
	elseif name == "awaken_oath_ancestor_progress_prize" then
		self._awaken_oath_ancestor_progress_prize = content
	end
end

function AwakenOathAncestorConfig:getActData(activityId)
	return self._awaken_oath_ancestor_activity[activityId]
end

function AwakenOathAncestorConfig:getPointCfg(activityId)
	return self._awaken_oath_ancestor_point[activityId]
end

function AwakenOathAncestorConfig:getPointData(activityId, pointId)
	if self._awaken_oath_ancestor_point[activityId] then
		return self._awaken_oath_ancestor_point[activityId][pointId]
	end
end

function AwakenOathAncestorConfig:getStageCfg(activityId)
	return self._awaken_oath_ancestor_stage[activityId]
end

function AwakenOathAncestorConfig:getStageData(activityId, stageId)
	if self._awaken_oath_ancestor_stage[activityId] then
		return self._awaken_oath_ancestor_stage[activityId][stageId]
	end
end

function AwakenOathAncestorConfig:getSupportCfg(activityId)
	return self._awaken_oath_ancestor_support_pet[activityId]
end

function AwakenOathAncestorConfig:getMasterData(creepsMasterId)
	return self._awaken_oath_ancestor_master[creepsMasterId]
end

function AwakenOathAncestorConfig:getCreepsCfg(activityId)
	return self._awaken_oath_ancestor_creeps[activityId]
end

function AwakenOathAncestorConfig:getProgressPrizeCfg(activityId)
	return self._awaken_oath_ancestor_progress_prize[activityId]
end

function AwakenOathAncestorConfig:getProgressPrizeData(activityId, progressId)
	if self._awaken_oath_ancestor_progress_prize[activityId] then
		return self._awaken_oath_ancestor_progress_prize[activityId][progressId]
	end
end

AwakenOathAncestorConfig.instance = AwakenOathAncestorConfig.New()

return AwakenOathAncestorConfig

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/config/AshlessLongYanConfig.lua

module("logic.extensions.ashlesslongyan.config.AshlessLongYanConfig", package.seeall)

local AshlessLongYanConfig = class("AshlessLongYanConfig", BaseConfig)

function AshlessLongYanConfig:onInit()
	AshlessLongYanConfig.super.onInit(self)
end

function AshlessLongYanConfig:getNames()
	return {
		"ashless_long_yan_activity",
		"ashless_long_yan_phase",
		"ashless_long_yan_stage",
		"ashless_long_yan_pass_cond",
		"ashless_long_yan_score_rule",
		"ashless_long_yan_buff",
		"ashless_long_yan_monster",
		"ashless_long_yan_creeps"
	}
end

function AshlessLongYanConfig:handleConfig(name, content)
	if name == "ashless_long_yan_activity" then
		self._ashless_long_yan_activity = content
	elseif name == "ashless_long_yan_phase" then
		self._ashless_long_yan_phase = content
	elseif name == "ashless_long_yan_stage" then
		self._ashless_long_yan_stage = content

		local groups = {}

		for _, data in ipairs(content.dataList) do
			groups[data.stagePlanId] = groups[data.stagePlanId] or {}
			groups[data.stagePlanId][data.group] = groups[data.stagePlanId][data.group] or {}
			groups[data.stagePlanId][data.group][data.layerId] = groups[data.stagePlanId][data.group][data.layerId] or {}
			groups[data.stagePlanId][data.group][data.layerId][data.stageId] = data
		end

		self._ashless_long_yan_stageGroups = groups
	elseif name == "ashless_long_yan_pass_cond" then
		self._ashless_long_yan_pass_cond = content
	elseif name == "ashless_long_yan_score_rule" then
		self._ashless_long_yan_score_rule = content
	elseif name == "ashless_long_yan_buff" then
		self._ashless_long_yan_buff = content
	elseif name == "ashless_long_yan_monster" then
		self._ashless_long_yan_monster = content
	elseif name == "ashless_long_yan_creeps" then
		self._ashless_long_yan_creeps = content
	end
end

function AshlessLongYanConfig:getActData(activityId)
	return self._ashless_long_yan_activity[activityId]
end

function AshlessLongYanConfig:getGoldMat(activityId)
	local data = self:getActData(activityId)

	return data and data.goldMat
end

function AshlessLongYanConfig:getPhaseCfg(activityId)
	return self._ashless_long_yan_phase[activityId]
end

function AshlessLongYanConfig:getPhaseData(activityId, phaseId)
	if self._ashless_long_yan_phase[activityId] then
		return self._ashless_long_yan_phase[activityId][phaseId]
	end
end

function AshlessLongYanConfig:getStashCount(activityId, phaseId)
	local data = self:getPhaseData(activityId, phaseId)

	return (data or nil) and (data.stashCount or 0)
end

function AshlessLongYanConfig:getStageDataList(activityId, phaseId)
	local phaseData = self:getPhaseData(activityId, phaseId)

	if phaseData then
		if not phaseData.stagePlanId then
			local stagePlanId = 0

			return self._ashless_long_yan_stage[stagePlanId]
		end
	end
end

function AshlessLongYanConfig:getStageData(activityId, phaseId, stageId)
	local phaseData = self:getPhaseData(activityId, phaseId)

	if phaseData then
		if not phaseData.stagePlanId then
			local stagePlanId = 0

			if self._ashless_long_yan_stage[stagePlanId] then
				return self._ashless_long_yan_stage[stagePlanId][stageId]
			end
		end
	end
end

function AshlessLongYanConfig:getStageType(activityId, phaseId, stageId)
	local data = self:getStageData(activityId, phaseId, stageId)

	return data and data.type
end

function AshlessLongYanConfig:getStageGroups(activityId, phaseId)
	local phaseData = self:getPhaseData(activityId, phaseId)

	if phaseData then
		if not phaseData.stagePlanId then
			local stagePlanId = 0

			return self._ashless_long_yan_stageGroups[stagePlanId]
		end
	end
end

function AshlessLongYanConfig:getStageLayers(activityId, phaseId, group)
	local groups = self:getStageGroups(activityId, phaseId)

	if groups then
		return groups[group]
	end
end

function AshlessLongYanConfig:getStageGroupCount(activityId, phaseId)
	local groups = self:getStageGroups(activityId, phaseId)

	return (groups or nil) and (#groups or 0)
end

function AshlessLongYanConfig:getStageLayersCount(activityId, phaseId, group)
	local layers = self:getStageLayers(activityId, phaseId, group)

	return (layers or nil) and (#layers or 0)
end

function AshlessLongYanConfig:getPassCondData(condKey)
	return self._ashless_long_yan_pass_cond[condKey]
end

function AshlessLongYanConfig:getScoreRuleCfg(ruleId)
	return self._ashless_long_yan_score_rule[ruleId]
end

function AshlessLongYanConfig:getBuffCfg(activityId, phaseId)
	local data = self:getPhaseData(activityId, phaseId)

	if data then
		if not data.buffPlanId then
			local buffPlanId = 0

			return self._ashless_long_yan_buff[buffPlanId]
		end
	end
end

function AshlessLongYanConfig:getBuffData(activityId, phaseId, fireCount)
	local data
	local cfg = self:getBuffCfg(activityId, phaseId)

	if cfg then
		for i, v in ipairs(cfg) do
			if fireCount >= v.fireCount then
				data = v
			else
				break
			end
		end
	end

	return data
end

function AshlessLongYanConfig:getMonsterData(creepsMasterId)
	return self._ashless_long_yan_monster[creepsMasterId]
end

function AshlessLongYanConfig:getCreepsCfg(creepsMasterId)
	return self._ashless_long_yan_creeps[creepsMasterId]
end

function AshlessLongYanConfig:getCreepsData(creepsMasterId, creepsId)
	if self._ashless_long_yan_creeps[creepsMasterId] then
		return self._ashless_long_yan_creeps[creepsMasterId][creepsId]
	end
end

AshlessLongYanConfig.instance = AshlessLongYanConfig.New()

return AshlessLongYanConfig

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/config/ASheConfig.lua

module("logic.extensions.ashechallenge.config.ASheConfig", package.seeall)

local ASheConfig = class("ASheConfig", BaseConfig)

function ASheConfig:onInit()
	ASheConfig.super.onInit(self)

	self.ashe_challenge_activity = nil
	self.ashe_challenge_common = nil
	self.ashe_challenge_difficulty = nil
	self.ashe_challenge_daily_buff = nil
	self.ashe_challenge_select_buff = nil
	self.ashe_challenge_stage = nil
	self.ashe_challenge_creeps_team = nil
	self.ashe_challenge_creeps = nil
end

function ASheConfig:getNames()
	return {
		"ashe_challenge_activity",
		"ashe_challenge_client_common",
		"ashe_challenge_common",
		"ashe_challenge_difficulty",
		"ashe_challenge_daily_buff",
		"ashe_challenge_select_buff",
		"ashe_challenge_stage",
		"ashe_challenge_creeps_team",
		"ashe_challenge_creeps"
	}
end

function ASheConfig:handleConfig(name, content)
	if name == "ashe_challenge_activity" then
		self.ashe_challenge_activity = content
	elseif name == "ashe_challenge_client_common" then
		self.ashe_challenge_client_common = content
	elseif name == "ashe_challenge_common" then
		self.ashe_challenge_common = content
	elseif name == "ashe_challenge_difficulty" then
		self.ashe_challenge_difficulty = content
	elseif name == "ashe_challenge_daily_buff" then
		self.ashe_challenge_daily_buff = content
	elseif name == "ashe_challenge_select_buff" then
		self.ashe_challenge_select_buff = content
	elseif name == "ashe_challenge_stage" then
		self.ashe_challenge_stage = content
	elseif name == "ashe_challenge_creeps_team" then
		self.ashe_challenge_creeps_team = content
	elseif name == "ashe_challenge_creeps" then
		self.ashe_challenge_creeps = content
	end
end

function ASheConfig:getActivityCfg(id)
	return self.ashe_challenge_activity[id]
end

function ASheConfig:getCommonValue(key)
	if self.ashe_challenge_common[key] then
		return self.ashe_challenge_common[key].value
	end
end

function ASheConfig:getClientCommonValue(activityId, key, isToNumber)
	local comPlanId = self:getActivityCfg(activityId).comPlanId
	local value = self.ashe_challenge_client_common[comPlanId][key].value

	if isToNumber then
		value = checknumber(value)
	end

	return value
end

function ASheConfig:getDifficultyCfgList(difficultyPlanId)
	return self.ashe_challenge_difficulty[difficultyPlanId]
end

function ASheConfig:getDifficultyCfg(difficultyPlanId, id)
	if self.ashe_challenge_difficulty[difficultyPlanId] then
		return self.ashe_challenge_difficulty[difficultyPlanId][id]
	end
end

function ASheConfig:getDailyBuffList(dailyBuffPlanId)
	return self.ashe_challenge_daily_buff[dailyBuffPlanId]
end

function ASheConfig:getDailyBuff(dailyBuffPlanId, day)
	if self.ashe_challenge_daily_buff[dailyBuffPlanId] then
		return self.ashe_challenge_daily_buff[dailyBuffPlanId][day]
	end
end

function ASheConfig:getSelectBuffList(selectBuffPlanId)
	return self.ashe_challenge_select_buff[selectBuffPlanId]
end

function ASheConfig:getSelectBuff(selectBuffPlanId, buffId)
	if self.ashe_challenge_select_buff[selectBuffPlanId] then
		return self.ashe_challenge_select_buff[selectBuffPlanId][buffId]
	end
end

function ASheConfig:getStageList(challengePlanId)
	return self.ashe_challenge_stage[challengePlanId]
end

function ASheConfig:getStage(challengePlanId, id)
	if self.ashe_challenge_stage[challengePlanId] then
		return self.ashe_challenge_stage[challengePlanId][id]
	end
end

function ASheConfig:getTeam(creepsMasterId)
	return self.ashe_challenge_creeps_team[creepsMasterId]
end

function ASheConfig:getCreepsList(creepsMasterId)
	return self.ashe_challenge_creeps[creepsMasterId] or {}
end

function ASheConfig:getCreep(creepsMasterId, creepsId)
	if self.ashe_challenge_creeps[creepsMasterId] then
		return self.ashe_challenge_creeps[creepsMasterId][creepsId]
	end
end

ASheConfig.instance = ASheConfig.New()

return ASheConfig

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/config/BoccaccioclgConfig.lua

module("logic.extensions.boccaccioclg.config.BoccaccioclgConfig", package.seeall)

local BoccaccioclgConfig = class("BoccaccioclgConfig", BaseConfig)

function BoccaccioclgConfig:onInit()
	return
end

function BoccaccioclgConfig:getNames()
	return {
		"boccaccio_clg_creeps",
		"boccaccio_clg_stage",
		"boccaccio_clg_activity",
		"boccaccio_clg_sign_buff",
		"boccaccio_clg_creeps_master"
	}
end

function BoccaccioclgConfig:handleConfig(name, content)
	if name == "boccaccio_clg_creeps" then
		self._boccaccio_clg_creeps = content
	elseif name == "boccaccio_clg_stage" then
		self._boccaccio_clg_stage = content
	elseif name == "boccaccio_clg_activity" then
		self._boccaccio_clg_activity = content
	elseif name == "boccaccio_clg_sign_buff" then
		self._boccaccio_clg_sign_buff = content
	elseif name == "boccaccio_clg_creeps_master" then
		self._boccaccio_clg_creeps_master = content
	end
end

function BoccaccioclgConfig:getActCfg(activityId)
	return self._boccaccio_clg_activity[activityId]
end

function BoccaccioclgConfig:getStageCfgs(activityId)
	return self._boccaccio_clg_stage[activityId]
end

function BoccaccioclgConfig:getStageCfg(activityId, stageId)
	return self._boccaccio_clg_stage[activityId][stageId]
end

function BoccaccioclgConfig:getCreepsCfgs(creepsMasterId)
	return self._boccaccio_clg_creeps[creepsMasterId]
end

function BoccaccioclgConfig:getCreepsCfg(creepsMasterId, creepsId)
	return self._boccaccio_clg_creeps[creepsMasterId][creepsId]
end

function BoccaccioclgConfig:getSignBuffCfgs(activityId)
	return self._boccaccio_clg_sign_buff[activityId]
end

function BoccaccioclgConfig:getSignBuffCfg(activityId, buffType)
	return self._boccaccio_clg_sign_buff[activityId][buffType]
end

function BoccaccioclgConfig:getCreepsMasterCfg(creepsMasterId)
	return self._boccaccio_clg_creeps_master[creepsMasterId]
end

BoccaccioclgConfig.instance = BoccaccioclgConfig.New()

return BoccaccioclgConfig

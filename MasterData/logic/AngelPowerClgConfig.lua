-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/config/AngelPowerClgConfig.lua

module("logic.extensions.angelpowerclg.config.AngelPowerClgConfig", package.seeall)

local AngelPowerClgConfig = class("AngelPowerClgConfig", BaseConfig)

function AngelPowerClgConfig:onInit()
	AngelPowerClgConfig.super.onInit(self)
end

function AngelPowerClgConfig:getNames()
	return {
		"angel_power_activity",
		"angel_power_transfer_plan",
		"angel_power_transfer_pet_plan",
		"angel_power_stage",
		"angel_power_monster",
		"angel_power_creeps"
	}
end

function AngelPowerClgConfig:handleConfig(name, content)
	if name == "angel_power_activity" then
		self._angel_power_activity = content
	elseif name == "angel_power_transfer_plan" then
		self._angel_power_transfer_plan = content
	elseif name == "angel_power_transfer_pet_plan" then
		self._angel_power_transfer_pet_plan = content
	elseif name == "angel_power_stage" then
		self._angel_power_stage = content
	elseif name == "angel_power_monster" then
		self._angel_power_monster = content
	elseif name == "angel_power_creeps" then
		self._angel_power_creeps = content
	end
end

function AngelPowerClgConfig:getActivityCfg(activityId)
	return self._angel_power_activity[activityId]
end

function AngelPowerClgConfig:getStageCfgs(activityId)
	return self._angel_power_stage[activityId]
end

function AngelPowerClgConfig:getStageCfg(activityId, stageId)
	return self._angel_power_stage[activityId][stageId]
end

function AngelPowerClgConfig:getTransferPetCfg(transferPetPlanId)
	return self._angel_power_transfer_pet_plan[transferPetPlanId]
end

function AngelPowerClgConfig:getTeamCfg(creepsMasterId)
	return self._angel_power_monster[creepsMasterId]
end

function AngelPowerClgConfig:getCreepsCfg(creepsMasterId)
	return self._angel_power_creeps[creepsMasterId]
end

AngelPowerClgConfig.instance = AngelPowerClgConfig.New()

return AngelPowerClgConfig

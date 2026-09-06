-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/config/BabybusConfig.lua

module("logic.extensions.babybus.config.BabybusConfig", package.seeall)

local BabybusConfig = class("BabybusConfig", BaseConfig)

function BabybusConfig:onInit()
	return
end

function BabybusConfig:getNames()
	return {
		"baby_bus",
		"baby_bus_prize",
		"baby_bus_common"
	}
end

function BabybusConfig:handleConfig(name, content)
	if name == "baby_bus" then
		self._baby_bus = content
	elseif name == "baby_bus_prize" then
		self._baby_bus_prize = content
	elseif name == "baby_bus_common" then
		self._baby_bus_common = content
	end
end

function BabybusConfig:getPrizeCfgs(prizePlanId)
	return self._baby_bus_prize[prizePlanId]
end

function BabybusConfig:getBaseCfg(activityId)
	return self._baby_bus[activityId]
end

function BabybusConfig:getCommonVelue(key)
	return self._baby_bus_common[key].value
end

BabybusConfig.instance = BabybusConfig.New()

return BabybusConfig

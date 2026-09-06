-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aolaishilink/config/AoLaiShiConfig.lua

module("logic.extensions.aolaishilink.config.AoLaiShiConfig", package.seeall)

local AoLaiShiConfig = class("AoLaiShiConfig", BaseConfig)

function AoLaiShiConfig:onInit()
	AoLaiShiConfig.super.onInit(self)
end

function AoLaiShiConfig:getNames()
	return {
		"activity_aolaishi_linkstrategy",
		"activity_summary_start_up",
		"activity_define",
		"activity_summary_task_items"
	}
end

function AoLaiShiConfig:handleConfig(name, content)
	if name == "activity_aolaishi_linkstrategy" then
		self._activity_aolaishi_linkstrategy = content
	elseif name == "activity_summary_start_up" then
		self._activity_summary_start_up = content
	elseif name == "activity_define" then
		self._activity_define = content
	end
end

function AoLaiShiConfig:getStrategyCfgs()
	return self._activity_aolaishi_linkstrategy.dataList
end

function AoLaiShiConfig:getResRoad(strategycellid)
	return self._activity_aolaishi_linkstrategy[strategycellid]
end

function AoLaiShiConfig:getActivityCfg(viewname)
	return self._activity_summary_start_up[viewname]
end

AoLaiShiConfig.instance = AoLaiShiConfig.New()

return AoLaiShiConfig

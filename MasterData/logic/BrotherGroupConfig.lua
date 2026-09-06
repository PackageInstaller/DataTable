-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/config/BrotherGroupConfig.lua

module("logic.extensions.brothergroup.config.BrotherGroupConfig", package.seeall)

local BrotherGroupConfig = class("BrotherGroupConfig", BaseConfig)

function BrotherGroupConfig:onInit()
	BrotherGroupConfig.super.onInit(self)
end

function BrotherGroupConfig:getNames()
	return {
		"brother_group_activity",
		"brother_group_hud",
		"brother_group_person_prize",
		"brother_group_position",
		"brother_group_task",
		"brother_group_common"
	}
end

function BrotherGroupConfig:handleConfig(name, content)
	if name == "brother_group_activity" then
		self._actCfg = content
	elseif name == "brother_group_hud" then
		self._hudCfg = content
	elseif name == "brother_group_person_prize" then
		self._personPrizeCfg = content
	elseif name == "brother_group_position" then
		self._posSettingCfg = content
	elseif name == "brother_group_task" then
		self._taskCfgs = content
	elseif name == "brother_group_common" then
		self._commonCfg = content
	end
end

function BrotherGroupConfig:getActCfg(actId)
	return self._actCfg[actId]
end

function BrotherGroupConfig:getHudCfgs(planId)
	return self._hudCfg[planId]
end

function BrotherGroupConfig:getPersonPrizeCfgs(planId)
	return self._personPrizeCfg[planId]
end

function BrotherGroupConfig:getPosSettingCfgs()
	return self._posSettingCfg
end

function BrotherGroupConfig:getTaskCfgs(actId)
	return self._taskCfgs[actId]
end

function BrotherGroupConfig:getCommomValue(key)
	return checknumber(self._commonCfg[key].value)
end

BrotherGroupConfig.instance = BrotherGroupConfig.New()

return BrotherGroupConfig

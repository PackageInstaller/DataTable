-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/config/ActivityDefineConfig.lua

module("logic.extensions.scratch.config.ActivityDefineConfig", package.seeall)

local ActivityDefineConfig = class("ActivityDefineConfig", BaseConfig)

function ActivityDefineConfig:onInit()
	ActivityDefineConfig.super.onInit(self)

	self._activityDefineCfg = nil
	self._sortActivityDefineCfg = nil
end

function ActivityDefineConfig:getNames()
	return {
		"activity_define"
	}
end

function ActivityDefineConfig:handleConfig(name, content)
	if name == "activity_define" then
		self._activityDefineCfg = content
		self._sortActivityDefineCfg = self:_getSortActivityDefineFunc(content)
	end
end

function ActivityDefineConfig:_getSortActivityDefineFunc(content)
	local result = {}
	local dataList = content.dataList

	for i, v in ipairs(dataList) do
		result[v.activityType] = result[v.activityType] or {}

		table.insert(result[v.activityType], v)
	end

	return result
end

function ActivityDefineConfig:getCfgByActivityTypeId(activityType)
	return self._sortActivityDefineCfg[activityType] or {}
end

function ActivityDefineConfig:getCfgById(activityType, activityId)
	activityId = checknumber(activityId)
	activityType = checknumber(activityType)

	if self._activityDefineCfg[activityType] then
		return self._activityDefineCfg[activityType][activityId]
	end

	return nil
end

function ActivityDefineConfig:getCfgByActivitYId(activityId)
	activityId = checknumber(activityId)

	local activityType = math.floor(activityId / 1000)

	if self._activityDefineCfg[activityType] then
		return self._activityDefineCfg[activityType][activityId]
	end

	return nil
end

ActivityDefineConfig.instance = ActivityDefineConfig.New()

return ActivityDefineConfig

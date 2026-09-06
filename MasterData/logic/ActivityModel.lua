-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/model/ActivityModel.lua

module("logic.extensions.role.model.ActivityModel", package.seeall)

local ActivityModel = class("ActivityModel")

function ActivityModel:ctor()
	return
end

function ActivityModel:setActivityInfo(msg)
	for k, v in ipairs(msg.cds) do
		self._time = v
	end

	printInfo("time = " .. self._time)
end

function ActivityModel:getActivityCd()
	if self._time then
		return self._time / 1000
	else
		return -1
	end
end

ActivityModel.instance = ActivityModel.New()

return ActivityModel

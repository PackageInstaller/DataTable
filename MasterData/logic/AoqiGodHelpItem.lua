-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/data/AoqiGodHelpItem.lua

module("logic.extensions.aoqigod.data.AoqiGodHelpItem", package.seeall)

local AoqiGodHelpItem = class("AoqiGodHelpItem")

function AoqiGodHelpItem:ctor(activityId)
	self._activityId = activityId

	local actData = AoqiGodConfig.instance:getActData(self._activityId)
	local helpTimeHour = actData.helpTimeHour

	self._helpTimeMillis = helpTimeHour * 60 * 60 * 1000
	self._helperLimit = actData.helperLimit

	self:onReset()
end

function AoqiGodHelpItem:onReset()
	self._id = ""
	self._userId = ""
	self._challengeId = 0
	self._startTimeMillis = 0
	self._endTimeMillis = 0
	self._helperNum = 0
	self._headInfo = nil
	self._name = "0-名字未知"
	self._charmValue = 0
end

function AoqiGodHelpItem:dispose()
	self._activityId = 0
end

function AoqiGodHelpItem:updateData(value)
	self._id = value.id
	self._userId = value.userId
	self._challengeId = value.challengeId
	self._helperNum = value.helperNum
	self._charmValue = checknumber(value.charmValue)
	self._startTimeMillis = checknumber(value.startTimeMillis)
	self._endTimeMillis = self._startTimeMillis + self._helpTimeMillis
	self._headInfo = value:HasField("caller") and value.caller or RoleModel.instance:getHeadInfo()
	self._name = string.format("S%s-%s", self._headInfo.areaId, self._headInfo.userName)
end

function AoqiGodHelpItem:isEmpty()
	return string.nilorempty(self._id)
end

function AoqiGodHelpItem:getHeadInfo()
	return self._headInfo
end

function AoqiGodHelpItem:getId()
	return self._id
end

function AoqiGodHelpItem:getUserId()
	return self._userId
end

function AoqiGodHelpItem:getChallengeId()
	return self._challengeId
end

function AoqiGodHelpItem:getStartTimeMillis()
	return self._startTimeMillis
end

function AoqiGodHelpItem:getEndTimeMillis()
	return self._endTimeMillis
end

function AoqiGodHelpItem:getLeftTimeSec(nowMillis)
	return Mathf.Max(self._endTimeMillis - nowMillis, 0) / 1000
end

function AoqiGodHelpItem:isInTime()
	local nowMs = ServerTime.nowMs()

	return nowMs >= self._startTimeMillis and nowMs < self._endTimeMillis
end

function AoqiGodHelpItem:getHelperNum()
	return self._helperNum
end

function AoqiGodHelpItem:setHelperNum(value)
	self._helperNum = value
end

function AoqiGodHelpItem:getHelperLimit()
	return self._helperLimit
end

function AoqiGodHelpItem:isExcHelperNumLimit()
	return self._helperNum >= self._helperLimit
end

function AoqiGodHelpItem:getPlayerName()
	return self._name
end

function AoqiGodHelpItem:getCharmValue()
	return self._charmValue
end

return AoqiGodHelpItem

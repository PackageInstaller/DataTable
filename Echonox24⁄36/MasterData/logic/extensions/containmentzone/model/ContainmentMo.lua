-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/model/ContainmentMo.lua

module("logic.extensions.containmentzone.model.ContainmentMo", package.seeall)

local M = class("ContainmentMo")

function M:ctor()
	return
end

function M:updateFromServer(roomInfo)
	self._roomId = roomInfo.roomId
	self._heroCount = 0
	self._hero = {}

	for key, value in ipairs(roomInfo.hero or {}) do
		table.insert(self._hero, value)

		self._heroCount = self._heroCount + 1
	end

	local protomer = roomInfo.protomer
	local realProtomerId = protomer and protomer.protomerId or 0

	if self._protomerId and self._protomerId ~= 0 and self._protomerId ~= realProtomerId then
		local protomerInfo = ProtomerModel.instance:getProtomerInfo(self._protomerId)

		protomerInfo:setRoomId(0)
	end

	self._protomerId = realProtomerId

	if self._protomerId > 0 then
		ProtomerModel.instance:updateProtomer(protomer, true)
	end

	self._hasProtomer = self._protomerId > 0
	self._report = roomInfo.report or 0
	self._failReport = roomInfo.failReport or 0
	self._scheduleTime = roomInfo.scheduleTime or 0
	self._productHero = roomInfo.productHero or 0
	self._productHouseRatio = roomInfo.productHouseRatio or 0
	self._productSpeed = roomInfo.productSpeed or 0
	self._updateTimeStamp = ServerTime.now()
end

function M:onAllReportReceive()
	self._report = 0
	self._failReport = 0

	local info = ServerTime.nowDateServerLook()
	local offsetSec = 60 - info.sec

	self._scheduleTime = offsetSec
end

function M:removeProtomer()
	self._protomerId = 0
	self._hasProtomer = self._protomerId > 0
end

function M:getUpdateTimeStamp()
	return self._updateTimeStamp or 0
end

function M:getRoomId()
	return self._roomId
end

function M:getProtomerId()
	return self._protomerId
end

function M:hasProtomer()
	return self._hasProtomer
end

function M:getTotalReportCount()
	return self._report + self._failReport
end

function M:getReportCount()
	return self._report
end

function M:getFailReportCount()
	return self._failReport
end

function M:getScheduleTime()
	return self._scheduleTime
end

function M:getProductHero()
	return self._productHero
end

function M:getProductHouseRatio()
	return self._productHouseRatio
end

function M:getHeroCount()
	return self._heroCount
end

function M:getHeroLst()
	return self._hero
end

function M:getHeroIdByIndex(index)
	if self._hero and #self._hero > 0 and self._hero[index] then
		return self._hero[index]
	else
		return 0
	end
end

function M:getHeroId()
	return self:getHeroIdByIndex(1)
end

function M:getRoomIDName()
	local showUpRoomId = self._roomId > 1100 and self._roomId - 1100 or self._roomId

	return string.format(lang("tip_house_holdroom_idname"), showUpRoomId)
end

function M:getRoomName()
	if self._protomerId > 0 then
		local cfgProtomerInfo = ContainmentConfig.instance:getProtomerInfoById(self._protomerId)

		return cfgProtomerInfo.roomname
	else
		return self:getRoomIDName()
	end
end

function M:getRoomLv()
	if self._protomerId > 0 then
		return ProtomerModel.instance:getProtomerLv(self._protomerId)
	else
		return 0
	end
end

function M:getProductSpeed()
	return self._productSpeed
end

return M

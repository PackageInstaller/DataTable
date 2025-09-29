-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/MainUIActBannerMo.lua

module("logic.extensions.mainui.model.MainUIActBannerMo", package.seeall)

local M = class("MainUIActBannerMo")

function M:ctor()
	self._id = nil
	self._priority = nil
	self._startTime = nil
	self._endTime = nil
	self._logic = nil
	self._config = nil
	self._jumpId = nil
	self._level = nil
	self._image = nil
end

function M:setBannerMo(mo)
	if mo ~= nil then
		self._id = mo.bannerId or 0
		self._priority = mo.priority or 0
		self._startTime = mo.startTime or ""
		self._endTime = mo.endTime or ""
		self._logic = mo.logic or -1
		self._config = mo.config or -1
		self._jumpId = mo.jumpId or ""
		self._jumpId = string.nilorempty(self._jumpId) and 0 or tonumber(self._jumpId)
		self._level = mo.level or 0
		self._image = mo.Image or ""
	end
end

function M:getId()
	return self._id
end

function M:getJumpId()
	return self._jumpId
end

function M:getImage()
	return self._image
end

function M:getPriority()
	return self._priority
end

function M:_isTimeCorrect()
	local startTimeStrSplit = string.split(self._startTime, "-")
	local endTimeStrSplit = string.split(self._endTime, "-")

	if startTimeStrSplit[1] ~= "" and #startTimeStrSplit == 4 and endTimeStrSplit[1] ~= "" and #endTimeStrSplit == 4 then
		self._startTimeSceond = self:_setStringdateToSecond(startTimeStrSplit)
		self._endTimeScond = self:_setStringdateToSecond(endTimeStrSplit)

		if self._endTimeScond > self._startTimeSceond then
			return true
		end
	end

	return false
end

function M:_setStringdateToSecond(splitList)
	local year = string.nilorempty(splitList[1]) and 1970 or tonumber(splitList[1])
	local month = string.nilorempty(splitList[2]) and 1 or tonumber(splitList[2])
	local day = string.nilorempty(splitList[3]) and 1 or tonumber(splitList[3])
	local hour = string.nilorempty(splitList[4]) and 0 or tonumber(splitList[4])
	local second = os.time({
		second = 0,
		minute = 0,
		day = day,
		month = month,
		year = year,
		hour = hour
	})

	return second
end

function M:_isOpenBannerByTime()
	if self:_isTimeCorrect() then
		local currentTime = ServerTime.now()

		if currentTime >= self._startTimeSceond and currentTime < self._endTimeScond then
			return true
		end
	end

	return false
end

function M:_isActivityConfigCorrect()
	if self._config ~= -1 and self._logic ~= -1 then
		local act = ActivityConfig.instance:getActExchangeCfg(self._logic, self._config)

		if act then
			return true
		end
	end

	return false
end

function M:_isOpenBannerByConfig()
	if self:_isActivityConfigCorrect() then
		local actData = ActivityController.instance:getActivityByLogicTypeAndCode(self._logic, self._config)

		if actData then
			return true
		end
	end

	return false
end

function M:_isLevel()
	local curLevel = PlayerModel.instance:getLevel()

	if curLevel >= self._level then
		return true
	end

	return false
end

function M:isOpenBanner()
	if self:_isLevel() then
		if self:_isTimeCorrect() then
			return self:_isOpenBannerByTime()
		elseif self:_isActivityConfigCorrect() then
			return self:_isOpenBannerByConfig()
		end
	end

	return false
end

return M

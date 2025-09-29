-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/data/ActivityBaseData.lua

module("logic.extensions.activity.data.ActivityBaseData", package.seeall)

local M = class("ActivityBaseData")
local json = require("cjson")

function M:ctor(ActivityNO)
	self._id = ActivityNO.id
	self._type = ActivityNO.logic
	self._configId = ActivityNO.config
	self._configCO = false

	self:initConfig()

	self._dynConfig = false

	self:refreshDynData(ActivityNO.data)

	self._startedTime = tonumber(ActivityNO.startedTime)
	self._endedTime = tonumber(ActivityNO.endedTime)
	self._isOpen = false
end

function M:initConfig()
	return
end

function M:getConditionOpen()
	return true
end

function M:refreshDynData(data)
	self:decode(data)
end

function M:decode(jsonConfig)
	if jsonConfig and jsonConfig ~= "" then
		self._dynConfig = json.decode(jsonConfig)
	end
end

function M:refreshData(ActivityNO)
	self:refreshDynData(ActivityNO.data)

	self._startedTime = tonumber(ActivityNO.startedTime)
	self._endedTime = tonumber(ActivityNO.endedTime)
end

function M:getId()
	return self._id
end

function M:getType()
	return self._type
end

function M:getConfigId()
	return self._configId
end

function M:getIsActivityEnable()
	return self:getIsActivityOpen() or self:getIsActivityExchange()
end

function M:getIsActivityOpen()
	local currentTime = ServerTime.now()

	if currentTime >= self._startedTime and currentTime <= self._endedTime then
		return self._isOpen
	else
		return false
	end
end

function M:getIsActivityExchange()
	if not self:isHaveExchangeTime() then
		return false
	end

	local endExchangeTime = self._endedTime + ActivityConfig.instance:getActExchangeSeconds(self._type, self._configId)
	local currentTime = ServerTime.now()

	if currentTime > self._endedTime and currentTime <= endExchangeTime then
		return self._isOpen
	end

	return false
end

function M:isHaveExchangeTime()
	local secondTime = ActivityConfig.instance:getActExchangeSeconds(self._type, self._configId)

	return secondTime > 0
end

function M:getLeftTime()
	local currentTime = ServerTime.now()
	local leftTime = self._endedTime - currentTime

	return math.ceil(leftTime / 86400)
end

function M:getLeftSeconds()
	local currentTime = ServerTime.now()

	return self._endedTime - currentTime
end

function M:getLeftExchangeSeconds()
	if not self:getIsActivityExchange() then
		printError(string.format("活动类型：%s,活动方案id：%s并不处于活动兑换阶段", self._type, self._configId))

		return
	end

	local endExchangeTime = self._endedTime + ActivityConfig.instance:getActExchangeSeconds(self._type, self._configId)
	local currentTime = ServerTime.now()

	return endExchangeTime - currentTime
end

function M:getIsOpen()
	return self:getIsActivityEnable() and self:getConditionOpen()
end

function M:getDynDataClass()
	return self._dynData
end

function M:setIsOpen(status)
	self._isOpen = status
end

return M

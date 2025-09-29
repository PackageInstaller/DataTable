-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/control/AirtightRoomController.lua

module("logic.extensions.airtightroom.control.AirtightRoomController", package.seeall)

local M = class("AirtightRoomController", BaseController)
local KEY_AIRTIGHT_STORE = "AIRTIGHT_TIME_STATE"

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onReset()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN_INIT, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN_INIT, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	end
end

function M:_handleOnSystemOpen()
	local systemOpen = AirtightRoomUtil.isSystemOpen(false)

	if systemOpen then
		AirtightRoomAgent.instance:sendGetAirtightRoomInfoRequest()
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	if isInAirtightTime and ViewMgr.instance:isOpen(ViewName.MainUIView) then
		AirtightRoomAgent.instance:sendExperienceAirtightRoomRequest()
	end

	self:setLastAirtightState(isInAirtightTime)
end

function M:setPreviewState(state)
	AirtightRoomModel.instance:setPreviewState(state)
end

function M:getPreviewState()
	return AirtightRoomModel.instance:getPreviewState()
end

function M:setLastAirtightState(inAirtight, timeStamp)
	timeStamp = timeStamp or AirtightRoomModel.instance:getServerTime()

	local key = string.format("%s#%s", KEY_AIRTIGHT_STORE, PlayerModel.instance:getId())
	local airtightNum = inAirtight and 1 or 0
	local str = string.format("%s#%s", timeStamp, airtightNum)

	Astral.LocalStorage.Instance:SetString(key, str)
end

function M:getLastAirtightState()
	local key = string.format("%s#%s", KEY_AIRTIGHT_STORE, PlayerModel.instance:getId())
	local dataStr = Astral.LocalStorage.Instance:GetString(key, "")
	local _airtightNum = 0
	local _time = 0

	if not string.nilorempty(dataStr) then
		local arrStep = string.split(dataStr, "#")

		_time = tonumber(arrStep[1])
		_airtightNum = tonumber(arrStep[2])
	end

	return _airtightNum > 0, _time
end

function M:getAirtightEndTime(nowTime, checkSysOpen, checkSp)
	nowTime = nowTime or AirtightRoomModel.instance:getServerTime()

	if checkSysOpen == nil then
		checkSysOpen = true
	end

	if checkSp == nil then
		checkSp = true
	end

	local dayStep = 129600
	local startTime = AirtightRoomModel.instance:getAirtightStartTimeStamp()
	local airtightExitTime = AirtightRoomModel.instance:getExitTime()
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

	if checkSysOpen and not AirtightRoomUtil.isSystemOpen(false) then
		return nil
	elseif checkSp and inSpTime then
		return nil
	elseif airtightExitTime > 0 and nowTime < airtightExitTime then
		local offsetTimeStamp = airtightExitTime - startTime
		local hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct(offsetTimeStamp % dayStep)

		if hour >= 24 then
			return airtightExitTime + (dayStep - hour * 60 * 60 - minute * 60 - second)
		else
			return airtightExitTime
		end
	elseif nowTime <= startTime then
		return nil
	else
		local offsetTimeStamp = nowTime - startTime
		local hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct(offsetTimeStamp % dayStep)

		if hour >= 24 then
			return nowTime + (dayStep - hour * 60 * 60 - minute * 60 - second)
		else
			return nil
		end
	end
end

function M:getAirtightTime(nowTime, checkSysOpen, checkSp)
	nowTime = nowTime or AirtightRoomModel.instance:getServerTime()

	if checkSysOpen == nil then
		checkSysOpen = true
	end

	if checkSp == nil then
		checkSp = true
	end

	local startTime = AirtightRoomModel.instance:getAirtightStartTimeStamp()
	local useRealTime = nowTime <= startTime

	if checkSysOpen and not AirtightRoomUtil.isSystemOpen(false) then
		useRealTime = true
	end

	if checkSp then
		local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

		if inSpTime and inSpNormal then
			useRealTime = true
		elseif inSpTime and inSpAirtight then
			useRealTime = false
		end
	end

	if useRealTime then
		local info = os.date("*t", nowTime)

		return tonumber(info.hour) * 60 * 60 + tonumber(info.min) * 60 + tonumber(info.sec)
	else
		return (nowTime - startTime) % 129600
	end
end

function M:getAirtightTimeInfo(nowTime, checkSysOpen, checkSp, ignorePreview)
	nowTime = nowTime or AirtightRoomModel.instance:getServerTime()

	if checkSysOpen == nil then
		checkSysOpen = true
	end

	if checkSp == nil then
		checkSp = true
	end

	if ignorePreview == nil then
		ignorePreview = true
	end

	local ts = self:getAirtightTime(nowTime, checkSysOpen, checkSp)
	local hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct(ts)
	local inAirtightTime = hour >= 24

	if checkSysOpen and not AirtightRoomUtil.isSystemOpen(false) then
		inAirtightTime = false
	end

	if checkSp then
		local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

		if inSpTime and inSpNormal then
			inAirtightTime = false
		elseif inSpTime and inSpAirtight then
			inAirtightTime = true
		end
	end

	local inTimeByItem = false
	local airtightExitTime = AirtightRoomModel.instance:getExitTime()

	if airtightExitTime > 0 and nowTime < airtightExitTime then
		inAirtightTime = true
		inTimeByItem = true
	end

	local airtightEndTime = self:getAirtightEndTime(nowTime, checkSysOpen, checkSp)

	if not ignorePreview then
		local previewState = AirtightRoomModel.instance:getPreviewState()

		if previewState ~= nil then
			inAirtightTime = previewState
		end
	end

	return inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTime
end

function M:getIsInAirtightTime(nowTime, checkSysOpen, checkSp, ignorePreview)
	if ignorePreview == nil then
		ignorePreview = true
	end

	if not ignorePreview then
		local previewState = AirtightRoomModel.instance:getPreviewState()

		if previewState ~= nil then
			return previewState
		end
	end

	if checkSp == nil then
		checkSp = true
	end

	if checkSp then
		local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

		if inSpTime and inSpNormal then
			return false
		elseif inSpTime and inSpAirtight then
			return true
		end
	end

	nowTime = nowTime or AirtightRoomModel.instance:getServerTime()

	if checkSysOpen == nil then
		checkSysOpen = true
	end

	local startTime = AirtightRoomModel.instance:getAirtightStartTimeStamp()
	local airtightExitTime = AirtightRoomModel.instance:getExitTime()

	if checkSysOpen and not AirtightRoomUtil.isSystemOpen(false) then
		return false
	elseif airtightExitTime > 0 and nowTime < airtightExitTime then
		return true
	elseif nowTime <= startTime then
		return false
	else
		local offsetTimeStamp = nowTime - startTime
		local hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct(offsetTimeStamp % 129600)

		return hour >= 24
	end
end

function M:onAirtightRoomExitTimeChange(exitTime)
	AirtightRoomModel.instance:setExitTime(exitTime)
	GlobalDispatcher:dispatchEvent(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, tonumber(exitTime))
end

function M:getNextAirtightBeginTimeStamp(nowTime, checkSysOpen, checkSp)
	local nextBeginTimeStamp = 0

	nowTime = nowTime or AirtightRoomModel.instance:getServerTime()

	if checkSysOpen == nil then
		checkSysOpen = true
	end

	if checkSp == nil then
		checkSp = true
	end

	if checkSp then
		local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

		if inSpTime then
			return nextBeginTimeStamp
		end
	end

	local startTime = AirtightRoomModel.instance:getAirtightStartTimeStamp()
	local useRealTime = nowTime <= startTime

	if checkSysOpen and not AirtightRoomUtil.isSystemOpen(false) then
		useRealTime = true
	end

	if useRealTime then
		local info = os.date("*t", nowTime)

		return nextBeginTimeStamp
	else
		local endTimeStamp = self:getAirtightEndTime(nowTime, checkSysOpen, checkSp)

		if endTimeStamp then
			nextBeginTimeStamp = endTimeStamp + 86400
		else
			local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = self:getAirtightTimeInfo(nowTime)
			local offsetTimeStamp = 86400 - (hour * 60 * 60 + minute * 60 + second)

			nextBeginTimeStamp = nowTime + offsetTimeStamp
		end
	end

	return nextBeginTimeStamp
end

M.instance = M.New()

return M

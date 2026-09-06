-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/time/ClockMgr.lua

module("framework.time.ClockMgr", package.seeall)

local ClockMgr = class("ClockMgr")

ClockMgr.TickHour = 1
ClockMgr.TickDay = 2
ClockMgr.TickWeek = 3
ClockMgr.TickDailyRefresh = 4
ClockMgr.CheckInterval = 30

function ClockMgr:ctor()
	NotifyDispatcher.extend(self)

	self._lastCheckYear = 0
	self._lastCheckYDay = 0
	self._lastCheckHour = 0
	self._lastCheckWDay = 0
	self._lastCheckStamp = 0
	self._year = 0
	self._yday = 0
	self._wday = 0
	self._hour = 0
	self._stamp = 0
	self._refreshTime = 0
end

function ClockMgr:startTick()
	self._stamp = 0

	Scheduler.addListener(ClockMgr.CheckInterval, self._check, self, true)
end

function ClockMgr:stopTick()
	Scheduler.removeListener(self._check, self)
end

function ClockMgr:setRefreshTime(refreshTime)
	self._refreshTime = refreshTime
end

function ClockMgr:_check()
	local isValid = self._stamp ~= 0

	self._stamp = ServerTime.nowServerLook()

	local dTable = os.date("*t", self._stamp)

	self._year = dTable.year
	self._wday = dTable.wday

	if self._wday == 0 then
		self._wday = 7
	end

	self._yday = dTable.yday
	self._hour = dTable.hour

	local isNewHour = self:_checkHour()

	if isValid and isNewHour then
		self:dispatch(ClockMgr.TickHour, self._hour)

		local isNewRefreshTime = self:_checkRefreshTime()

		if isNewRefreshTime then
			self:dispatch(ClockMgr.TickDailyRefresh)
		end

		local isNewDay = self:_checkDay()

		if isNewDay then
			self:dispatch(ClockMgr.TickDay)

			local isNewWeek = self:_checkWeek()

			if isNewWeek then
				self:dispatch(ClockMgr.TickWeek)
			end
		end
	end

	self._lastCheckYear = self._year
	self._lastCheckYDay = self._yday
	self._lastCheckHour = self._hour
	self._lastCheckWDay = self._wday
	self._lastCheckStamp = self._stamp
end

function ClockMgr:_checkHour()
	return (self._lastCheckYear == self._year and self._lastCheckYDay == self._yday and self._lastCheckHour == self._hour or nil) and false
end

function ClockMgr:_checkRefreshTime()
	return self._hour == self._refreshTime
end

function ClockMgr:_checkDay()
	return (self._lastCheckYear == self._year and self._lastCheckYDay == self._yday or nil) and false
end

function ClockMgr:_checkWeek()
	return (self._stamp - self._lastCheckStamp < 604800 and self._wday >= self._lastCheckWDay or nil) and false
end

ClockMgr.instance = ClockMgr.New()

return ClockMgr

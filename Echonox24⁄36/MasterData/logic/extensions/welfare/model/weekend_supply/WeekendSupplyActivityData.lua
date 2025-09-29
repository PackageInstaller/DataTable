-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/weekend_supply/WeekendSupplyActivityData.lua

module("logic.extensions.welfare.model.weekend_supply.WeekendSupplyActivityData", package.seeall)

local M = class("WeekendSupplyActivityData", ActivityWelfareData)

function M:ctor(ActivityNO)
	self._strfinish = ActivityNO.data

	M.super.ctor(self, ActivityNO)
end

function M:initConfig()
	local mondayTable = {
		time = 0,
		status = 1,
		id = ActivityExtension_pb.Day.MONDAY,
		cfgId = self._configId
	}
	local saturdayTable = {
		time = 0,
		status = 1,
		id = ActivityExtension_pb.Day.SATURDAY,
		cfgId = self._configId
	}
	local sundayTable = {
		time = 0,
		status = 1,
		id = ActivityExtension_pb.Day.SUNDAY,
		cfgId = self._configId
	}
	local extraTable = {
		time = 0,
		status = 1,
		id = ActivityExtension_pb.Day.EXTRA,
		cfgId = self._configId
	}

	self._monday = WeekendSupplyItemMo.New()

	self._monday:setGifgItemMo(mondayTable)

	self._saturday = WeekendSupplyItemMo.New()

	self._saturday:setGifgItemMo(saturdayTable)

	self._sunday = WeekendSupplyItemMo.New()

	self._sunday:setGifgItemMo(sundayTable)

	self._extraday = WeekendSupplyItemMo.New()

	self._extraday:setGifgItemMo(extraTable)

	self._finishList = {}

	for i = 1, 4 do
		self._finishList[i] = false
	end

	self:setFinishList(tonumber(self._strfinish))
	self:refreshDatas()

	self._isNeedRequest = false
end

function M:setIsOpen(status)
	M.super.setIsOpen(self, status)

	if status == false then
		self._isNeedRequest = true
	end
end

function M:getConditionOpen()
	local inTable = self:isInOneday(2, 5)

	return not inTable.isr
end

function M:setFinishList(num)
	self._finishList = {}

	for i = 1, 4 do
		self._finishList[i] = false
	end

	for i = 1, 4 do
		if i == 1 then
			if num % 2 == 1 then
				self._finishList[i] = true
			end
		elseif num % 2^i >= 2^(i - 1) then
			self._finishList[i] = true
		end
	end
end

function M:refreshDatas()
	local saturdayTable = self:isInOneday(6, 7)
	local sundayTable = self:isInSunday()
	local mondayTable = self:isInOneday(1, 2)

	if saturdayTable.isr then
		if self._finishList[1] then
			self._saturday:setRwardStatus(4)
		else
			self._saturday:setRwardStatus(3)
		end

		self._monday:setRwardStatus(1)
		self._sunday:setRwardStatus(2)
		self._extraday:setRwardStatus(2)
	elseif sundayTable.isr then
		if self._finishList[1] then
			self._saturday:setRwardStatus(4)
		else
			self._saturday:setRwardStatus(5)
		end

		if self._finishList[2] then
			self._sunday:setRwardStatus(4)
		else
			self._sunday:setRwardStatus(3)
		end

		self._monday:setRwardStatus(2)
		self._extraday:setRwardStatus(2)
	elseif mondayTable.isr then
		if self._finishList[1] then
			self._saturday:setRwardStatus(4)
		else
			self._saturday:setRwardStatus(5)
		end

		if self._finishList[2] then
			self._sunday:setRwardStatus(4)
		else
			self._sunday:setRwardStatus(5)
		end

		if self._finishList[3] then
			self._monday:setRwardStatus(4)
		else
			self._monday:setRwardStatus(3)
		end

		if self._finishList[4] then
			self._extraday:setRwardStatus(4)
		elseif self._finishList[1] and self._finishList[2] then
			self._extraday:setRwardStatus(3)
		else
			self._extraday:setRwardStatus(2)
		end
	else
		self._monday:setRwardStatus(1)
		self._saturday:setRwardStatus(1)
		self._sunday:setRwardStatus(1)
		self._extraday:setRwardStatus(1)
	end
end

function M:setOneFinish(i)
	self._finishList[i] = true

	self:refreshDatas()
end

function M:isInOneday(startDay, endDay)
	local currentTime = ServerTime.now()
	local startFive = TimeUtil.instance:getWDayTimeStamp(currentTime, startDay, 5, 0, 0)
	local endFive = TimeUtil.instance:getWDayTimeStamp(currentTime, endDay, 5, 0, 0)
	local isst = true

	if endFive < currentTime or currentTime < startFive then
		isst = false
	end

	local temptable = {
		isr = isst,
		isT = endFive - currentTime
	}

	return temptable
end

function M:isInSunday()
	local currentTime = ServerTime.now()
	local currentDay = TimeUtil.instance:getNowWeekDay(currentTime)
	local isst = false
	local temptable = {
		isT = -2,
		isr = isst
	}

	if currentDay == 7 then
		local sunstartFive = TimeUtil.instance:getWDayTimeStamp(currentTime, 7, 5, 0, 0)
		local sunendFive = TimeUtil.instance:getWDayTimeStamp(currentTime, 7, 24, 0, 0)

		if sunstartFive < currentTime then
			isst = true
			temptable = {
				isr = isst,
				isT = sunendFive - currentTime + 18000
			}
		end
	elseif currentDay == 1 then
		local monFive = TimeUtil.instance:getWDayTimeStamp(currentTime, 1, 5, 0, 0)

		if currentTime < monFive then
			isst = true
			temptable = {
				isr = isst,
				isT = monFive - currentTime
			}
		end
	end

	return temptable
end

function M:getmondayMo()
	return self._monday
end

function M:getsaturdayMo()
	return self._saturday
end

function M:getsundayMo()
	return self._sunday
end

function M:getextraMo()
	return self._extraday
end

function M:setNeedRquest(status)
	self._isNeedRequest = status
end

function M:getNeedRquest()
	return self._isNeedRequest
end

return M

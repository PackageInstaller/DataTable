-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/hero/HeroHouseMoodRecord.lua

module("logic.extensions.house.model.hero.HeroHouseMoodRecord", package.seeall)

local M = class("HeroHouseMoodRecord")

function M:ctor()
	self._state = 0
end

function M:updateByAgent(index, NO)
	local serverLocalStamp = ServerTime.nowServerLook() - 3600 * (index - 1)
	local dt = os.date("*t", serverLocalStamp)

	self._year = dt.year
	self._month = dt.month
	self._day = dt.day
	self._hour = dt.hour
	self._mood = NO.value
	self._workCost = NO.workCost
	self._resetRecover = NO.resetRecover
	self._holdFailDeduct = NO.holdFailDeduct
	self._otherChange = NO.otherChange

	self:_refreshState()
end

function M:getMood()
	return self._mood
end

function M:getCoordXStr()
	local hour = TimeUtil.instance:numberFixPre(self._hour)

	return string.format("%s/%s\n%s:00", self._month, self._day, hour)
end

function M:getDescTime()
	local hour = TimeUtil.instance:numberFixPre(self._hour)

	return string.format("- %s/%s %s:00 -", self._month, self._day, hour)
end

function M:getDescDataList()
	local function _createData(descStr, valueStr)
		local data = {}

		data.descStr = descStr
		data.valueStr = valueStr

		return data
	end

	local function _turnToStr(num, isPlus)
		num = checknumber(num)

		if num > 0 then
			return string.format("+%s", num)
		elseif num == 0 then
			local sign = isPlus and "+" or "-"

			return string.format("%s0", sign)
		end

		return tostring(num)
	end

	local dataList = {}

	if self:hasRecord() then
		if self._state == 1 or self._state == 3 then
			table.insert(dataList, _createData(lang("tip_work_consumption"), _turnToStr(self._workCost, false)))
		end

		if self._state == 2 or self._state == 3 then
			table.insert(dataList, _createData(lang("tip_rest_to_recover"), _turnToStr(self._resetRecover, true)))
		end

		if self._holdFailDeduct ~= 0 then
			table.insert(dataList, _createData(lang("tip_invalidation_deduction"), _turnToStr(self._holdFailDeduct, false)))
		end

		if self._otherChange ~= 0 then
			table.insert(dataList, _createData(lang("tip_other_changes"), _turnToStr(self._otherChange)))
		end
	else
		table.insert(dataList, _createData(lang("tip_no_record"), ""))
	end

	return dataList
end

function M:hasRecord()
	if not self._workCost and not self._resetRecover and not self._holdFailDeduct and not self._otherChange then
		return false
	end

	return true
end

function M:_refreshState()
	if self:hasRecord() then
		local maxMood = HouseConfig.instance:getHouseConst("MoodMax").numValue

		self._state = 3

		if self._workCost == 0 and self._resetRecover == 0 then
			if self._mood <= 0 then
				self._state = 1
			elseif maxMood <= self._mood then
				self._state = 2
			end
		elseif self._workCost ~= 0 and self._resetRecover == 0 then
			self._state = 1
		elseif self._workCost == 0 and self._resetRecover ~= 0 then
			self._state = 2
		end
	end
end

return M

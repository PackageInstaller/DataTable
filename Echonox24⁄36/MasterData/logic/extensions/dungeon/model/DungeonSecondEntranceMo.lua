-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonSecondEntranceMo.lua

module("logic.extensions.dungeon.model.DungeonSecondEntranceMo", package.seeall)

local M = class("DungeonSecondEntranceMo")

function M:ctor(entranceCo)
	self.id = entranceCo.code
	self._code = entranceCo.code
	self._name = entranceCo.name
	self._isShow = entranceCo.isShow
	self._entranceType = entranceCo.entranceType
	self._sortOrder = entranceCo.sortOrder
	self._bgName = entranceCo.bgName
	self._weekDays = entranceCo.weekDays
	self._timeStr = entranceCo.entranceShowTime
	self._precondition = entranceCo.precondition
	self._jumpChapterId = entranceCo.jumpChapterId
end

function M:getCode()
	return self._code
end

function M:getName()
	return self._name
end

function M:_initTime()
	if self._timeStr and self._timeStr ~= "" then
		local timeStrArr = string.split(self._timeStr, "#")

		self._entranceStartTime = TimeUtil.instance:dateStr2TimeStamp(timeStrArr[1])
		self._entranceEndTime = TimeUtil.instance:dateStr2TimeStamp(timeStrArr[2])
		self._timeStr = nil
	end
end

function M:getIsShow()
	return self._isShow
end

function M:getSortOrder()
	return self._sortOrder
end

function M:getBgName()
	return self._bgName
end

function M:getStartTime()
	self:_initTime()

	return self._entranceStartTime
end

function M:getEndTime()
	self:_initTime()

	return self._entranceEndTime
end

function M:getPreconditon()
	return self._precondition
end

function M:getJumpChapterId()
	return self._jumpChapterId
end

function M:getWeekDays()
	return self._weekDays
end

function M:getEntranceLockReason()
	if false then
		return DungeonEnum.EntranceLockReason.DungeonProgress
	end

	if not self:getIsInShowTime() then
		return DungeonEnum.EntranceLockReason.Time
	end

	if false then
		return DungeonEnum.EntranceLockReason.Level
	end

	return false
end

function M:getIsInShowTime()
	local status = true

	if self:getStartTime() and ServerTime.now() >= self:getStartTime() and ServerTime.now() < self:getEndTime() then
		status = false
	end

	if self:getWeekDays() and not self:getIsInWeekDay() then
		status = false
	end

	return status
end

function M:getIsExpired()
	if self:getEndTime() and ServerTime.now() > self._entranceEndTime then
		return true
	end

	return false
end

function M:getIsInWeekDay()
	local today = os.date("*t", ServerTime.now()).wday
	local curWeekDay = CommEnum.WeekDayMapping[today]

	for i, v in ipairs(self._weekDays) do
		if curWeekDay == v then
			return true
		end
	end

	return false
end

return M

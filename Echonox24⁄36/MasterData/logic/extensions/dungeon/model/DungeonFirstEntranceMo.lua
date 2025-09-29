-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonFirstEntranceMo.lua

module("logic.extensions.dungeon.model.DungeonFirstEntranceMo", package.seeall)

local M = class("DungeonFirstEntranceMo")

function M:ctor(entranceCo)
	self.id = entranceCo.code
	self._code = entranceCo.code
	self._name = entranceCo.name
	self._isShow = entranceCo.isShow
	self._sortOrder = entranceCo.sortOrder
	self._timeStr = entranceCo.entranceShowTime
	self._precondition = entranceCo.precondition
	self._jumpEntranceIdList = entranceCo.jumpEntranceIdList
end

function M:getCode()
	return self._code
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

function M:getStartTime()
	self:_initTime()

	return self._entranceStartTime
end

function M:getEndTime()
	return self._entranceEndTime
end

function M:getPreconditon()
	return self._precondition
end

function M:getJumpEntranceIdList()
	return self._jumpEntranceIdList
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
	if not self:getStartTime() then
		return true
	end

	if ServerTime.now() >= self:getStartTime() and ServerTime.now() < self:getEndTime() then
		return true
	end

	return false
end

return M

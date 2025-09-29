-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/EquipExploreChapterMO.lua

module("logic.extensions.dungeon.model.EquipExploreChapterMO", package.seeall)

local M = class("EquipExploreChapterMO", DungeonChapterMO)

function M:ctor(chapterCo)
	self.super.ctor(self, chapterCo)

	self._difficulty = 1
	self._iconRes1 = chapterCo.iconRes1
	self._dropItems = chapterCo.dropItems
	self._bg = chapterCo.bg
	self._weekDays = chapterCo.weekDays
	self._desc = chapterCo.desc
	self._pos = chapterCo.pos
	self._rot = chapterCo.rot
	self._dungeonType = chapterCo.dungeonType
	self._commonDungeonIds = {}

	for i, v in ipairs(self._dungeonIds) do
		local dungeonCO = DungeonConfig.instance:getMaterialDungeonCfgByMaterialDungoenId(v)

		table.insert(self._commonDungeonIds, dungeonCO.commonDungeonId)
	end
end

function M:getDesc()
	return self._desc
end

function M:getMatDungeonIds()
	return self._dungeonIds
end

function M:getDungeonIds()
	return self._commonDungeonIds
end

function M:getChapterIconRes()
	return self._chapterCo.iconRes
end

function M:getIconRes1()
	return self._iconRes1
end

function M:getDropItems()
	return self._dropItems
end

function M:getBg()
	return self._bg
end

function M:getWeekDays()
	return self._weekDays
end

function M:getBossPos()
	return self._pos
end

function M:getBossRot()
	return self._rot
end

function M:getSystemOpenKey()
	return GameEnum.SystemEnum.MaterialDungeonChapter1 + self._chapterId - 2001
end

function M:isSystemOpen()
	return SystemOpenFacade.instance:isOpen(self:getSystemOpenKey(), false)
end

function M:getIsChapterUnlock()
	if not self:isSystemOpen() then
		return false
	end

	if not self:getIsInWeekDay() then
		return false
	end

	return true
end

function M:getIsInWeekDay()
	if not self._weekDays then
		return true
	end

	local today = os.date("*t", ServerTime.now() - 18000).wday
	local curWeekDay = CommEnum.WeekDayMapping[today]

	for i, v in ipairs(self._weekDays) do
		if curWeekDay == v then
			return true
		end
	end

	return false
end

function M:getLastPassDungeonIndex()
	for i = #self._commonDungeonIds, 1, -1 do
		local dungeonMo = DungeonModel.instance:getDungeonMoById(self._commonDungeonIds[i])

		if dungeonMo:hasPassed() then
			return i
		end
	end
end

function M:getSystemLockStr()
	local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(self:getSystemOpenKey())

	if systemOpenCO then
		return systemOpenCO:getLockTips()
	end

	return ""
end

function M:getWeekDayStr()
	local weekStr = ""
	local weekDays = self:getWeekDays()

	for _, v in ipairs(weekDays or {}) do
		weekStr = string.format("%s%s", weekStr, DungeonEnum.WeekDay[v])
	end

	return langF("week_open_tips", weekStr)
end

function M:getLockStr()
	if not self:isSystemOpen() then
		return self:getSystemLockStr()
	elseif not self:getIsInWeekDay() then
		return self:getWeekDayStr()
	end

	return ""
end

function M:getDungeonType()
	return self._dungeonType
end

return M

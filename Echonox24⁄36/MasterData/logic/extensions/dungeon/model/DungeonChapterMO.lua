-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonChapterMO.lua

module("logic.extensions.dungeon.model.DungeonChapterMO", package.seeall)

local M = class("DungeonChapterMO")

function M:ctor(chapterCo)
	self._chapterCo = chapterCo
	self._chapterId = chapterCo.chapterId
	self._name = chapterCo.name
	self._dungeonIds = chapterCo.dungeonIds
	self._canMultiplicityCost = chapterCo.canMultiplicityCost
	self._multiplicityOpenCondition = chapterCo.multiplicityOpenCondition
	self._multiplicityLimit = chapterCo.multiplicityLimit
	self._canRecord = chapterCo.canRecord
	self._consecutive = chapterCo.consecutive
end

function M:getChapterCO()
	return self._chapterCo
end

function M:getChapterId()
	return self._chapterId
end

function M:getName()
	return self._name
end

function M:getDungeonIds()
	return self._dungeonIds
end

function M:getCanOpenMulti()
	return self._canMultiplicityCost == 1
end

function M:getMultiMaxCount()
	return self._multiplicityLimit
end

function M:getMultiplicityOpenCondition()
	return self._multiplicityOpenCondition or 0
end

function M:canProxy()
	return self._canRecord and self._canRecord == 1 or false
end

function M:getConsecutiveLimit()
	return self._consecutive or 0
end

return M

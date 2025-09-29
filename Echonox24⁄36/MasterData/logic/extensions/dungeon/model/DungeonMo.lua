-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonMo.lua

module("logic.extensions.dungeon.model.DungeonMo", package.seeall)

local M = class("DungeonMo", DungeonMOBase)

function M:getIsUnlock()
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	if self._difficulty and self._chapterId and self._difficulty > 0 then
		local chapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._chapterId, self._difficulty)

		if not chapterMo:getIsChapterUnlock() then
			return false
		end
	end

	if not self._preDungeonId then
		return true
	end

	local preDungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._preDungeonId)

	return preDungeonMo:hasPassed()
end

function M:getIsShowInScene()
	return self:getIsUnlock()
end

function M:getDungeonIndex()
	local dungeonId = self:getId()
	local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self:getChapterId(), self:getDifficulty())

	return table.indexof(chapterMO:getNormalDungeonIds(), dungeonId) or table.indexof(chapterMO:getBranchlineDungeonIds(), dungeonId)
end

return M

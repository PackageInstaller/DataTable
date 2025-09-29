-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/BranchlineDungeonMO.lua

module("logic.extensions.dungeon.model.BranchlineDungeonMO", package.seeall)

local M = class("BranchlineDungeonMO", DungeonMOBase)

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

	if self._preDungeonId then
		local preDungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._preDungeonId)

		if not preDungeonMo:hasPassed() then
			return false
		end
	end

	local dungeonUnlockCO = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(self._id)

	if dungeonUnlockCO.unlockCondition then
		for i, v in ipairs(dungeonUnlockCO.unlockCondition) do
			if v.type == "dungeon" then
				local dungeonId = tonumber(v.value)
				local preDungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)

				if not preDungeonMo:hasPassed() then
					return false
				end
			elseif v.type == "plot" then
				local str = string.split(v.value, "#")

				if not GuideModel.instance:hasPlotAnswer(tonumber(str[1]), tonumber(str[2])) then
					return false
				end
			end
		end
	end

	return true
end

function M:getIsShowInScene()
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	if self._difficulty and self._chapterId and self._difficulty > 0 then
		local chapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._chapterId, self._difficulty)

		if not chapterMo:getIsChapterUnlock() then
			return false
		end
	end

	if self._preDungeonId then
		local preDungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._preDungeonId)

		if not preDungeonMo:hasPassed() then
			return false
		end
	end

	local dungeonUnlockCO = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(self._id)

	if dungeonUnlockCO.showUnlockCondition then
		for i, v in ipairs(dungeonUnlockCO.showUnlockCondition) do
			if v.type == "dungeon" then
				local dungeonId = tonumber(v.value)
				local preDungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)

				if not preDungeonMo:hasPassed() then
					return false
				end
			elseif v.type == "plot" then
				local str = string.split(v.value, "#")

				if not GuideModel.instance:hasPlotAnswer(tonumber(str[1]), tonumber(str[2])) then
					return false
				end
			end
		end
	end

	return true
end

return M

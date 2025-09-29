-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonMaterialChapterModel.lua

module("logic.extensions.dungeon.model.DungeonMaterialChapterModel", package.seeall)

local M = class("DungeonMaterialChapterModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._chapterList = {}
	self._dungeonPreDungeonIdList = {}
	self._dungeonToChapterId = {}
	self._dungeonIdToMaterialDungeonId = {}
end

function M:onInit()
	self:onReset()

	local chapterCfg = DungeonConfig.instance:getCfgMaterialChapter()

	for k, chapterCo in ipairs(chapterCfg) do
		local typ = chapterCo.type

		if typ == 1 then
			local chapterMo = MaterialChapterMO.New(chapterCo)

			self._chapterList[chapterCo.chapterId] = chapterMo

			local preDungeonId

			for i, v in ipairs(chapterMo:getDungeonIds()) do
				self._dungeonPreDungeonIdList[v] = preDungeonId
				preDungeonId = v
				self._dungeonToChapterId[v] = chapterCo.chapterId
			end
		end
	end

	local materialCfg = DungeonConfig.instance:getCfgMaterialDungeon()

	for k, v in ipairs(materialCfg) do
		self._dungeonIdToMaterialDungeonId[v.commonDungeonId] = v.dungeonCode
	end
end

function M:getChapterMoByChapterId(id)
	return self._chapterList[id]
end

function M:getAllChapter()
	return self._chapterList
end

function M:getDungeonMoById(dungeonId)
	if not self._dungeonMoList[dungeonId] then
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)

		if not dungeonCo then
			return
		end

		local dungeonMo = MaterialDungeonMo.New()

		dungeonMo:initByConfig(dungeonCo)
		dungeonMo:initByAgent(DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId))
		dungeonMo:setPreDungeonId(self._dungeonPreDungeonIdList[dungeonId])
		dungeonMo:setMaterialDungeonCode(self._dungeonIdToMaterialDungeonId[dungeonId])
		dungeonMo:setChapterIdAndDifficulty(self._dungeonToChapterId[dungeonId])

		self._dungeonMoList[dungeonId] = dungeonMo
	end

	return self._dungeonMoList[dungeonId]
end

function M:setClickChapterIdAndDungeonIndex(chapterId, index)
	self._curClickChapterId = chapterId
	self._curDungeonIndex = index
end

function M:getClickChapterIdAndDungeonIndex()
	return self._curClickChapterId, self._curDungeonIndex
end

function M:getChapterLastUnlockDungeonIndex(chapterId)
	local result = 1
	local chapterMO = self:getChapterMoByChapterId(chapterId)

	for index, dungeonId in ipairs(chapterMO:getDungeonIds()) do
		local dungeonMo = DungeonMaterialChapterModel.instance:getDungeonMoById(dungeonId)

		if not dungeonMo:getIsUnlock() then
			break
		end

		result = index
	end

	return result
end

function M:onReset()
	self._dungeonMoList = {}
end

M.instance = M.New()

return M

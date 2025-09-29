-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/TeachingDungeonMO.lua

module("logic.extensions.dungeon.model.TeachingDungeonMO", package.seeall)

local M = class("TeachingDungeonMO", DungeonMOBase)

function M:initByConfig(co)
	M.super.initByConfig(self, co)

	self._co = co
	self._id = co.id
	self._type = co.type
	self._index = co.index
	self._pointCost = co.pointCost
	self._name = co.name
	self._desc = co.desc
	self._enemyIds = co.enemyIds
	self._mainRewardShow = co.mainRewardShow
	self._firstPassReward = co.firstPassReward
	self._normalReward = co.normalReward
	self._starRequire = co.starRequire
	self._plotBeforeBattle = co.plotBeforeBattle
	self._plotAfterBattle = co.plotAfterBattle
	self._plotAfterReady = co.plotAfterReady
	self._passed = false
	self._star = {}
	self._teachingCO = DungeonConfig.instance:getTeachingDungeonCOByDungeonId(self._id)

	if self._teachingCO.difficulty ~= "" then
		if self._teachingCO.difficulty < 40 then
			self._rateTxt = string.format("<color=#282727>%d%%</color>", self._teachingCO.difficulty)
		elseif self._teachingCO.difficulty >= 80 then
			self._rateTxt = string.format("<color=#b02020>%d%%</color>", self._teachingCO.difficulty)
		else
			self._rateTxt = string.format("<color=#eeb948>%d%%</color>", self._teachingCO.difficulty)
		end
	end
end

function M:setChapterIdAndDifficulty(chapterId)
	self._chapterId = chapterId
	self._difficulty = 1
end

function M:getRateTxt()
	return self._rateTxt
end

function M:getRate()
	return self._teachingCO.difficulty
end

function M:geteachingDungeonCO()
	return self._teachingCO
end

function M:getIsUnlock()
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	if DungeonTeachingChapterModel.instance:getIsInUnlockedDungeonList(self._id) then
		return true
	end

	if not self._preDungeonId then
		local chapterMo = DungeonTeachingChapterModel.instance:getChapterMoByChapterId(self._chapterId)

		if chapterMo and chapterMo:getIsPreChapterFinished() then
			return true
		end
	else
		local preDungeonMo = DungeonTeachingChapterModel.instance:getDungeonMoById(self._preDungeonId)

		return preDungeonMo:hasPassed()
	end

	return false
end

return M

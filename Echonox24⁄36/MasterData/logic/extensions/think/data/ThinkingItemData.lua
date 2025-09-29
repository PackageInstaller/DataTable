-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/think/data/ThinkingItemData.lua

module("logic.extensions.think.data.ThinkingItemData", package.seeall)

local M = class("ThinkingItemData")

function M:ctor()
	self._thinkingMo = nil
	self._wearingSkillId = nil
	self._unlockedList = {}
	self._lockedList = {}
end

function M:setThinkingMo(thinkingMo)
	self._thinkingMo = thinkingMo
end

function M:getThinkingMoId()
	local mo = self:getThinkingMo()

	if mo then
		return mo:getId()
	end

	return nil
end

function M:getThinkingMo()
	return self._thinkingMo
end

function M:setWearingSkillId(skillId)
	self._wearingSkillId = skillId
end

function M:getWearingSkillId()
	return self._wearingSkillId
end

function M:setUnLockList(list)
	table.clear(self._unlockedList)
	table.insertto(self._unlockedList, list)
end

function M:setLockList(list)
	table.clear(self._lockedList)
	table.insertto(self._lockedList, list)
end

function M:isThinkingUnlocked(thinkId)
	local list = self._unlockedList

	for _, v in ipairs(list) do
		if v:getId() == thinkId then
			return true
		end
	end

	return false
end

function M:getMoByIndex(index)
	if not self._thinkIdMap then
		self._thinkIdMap = {}

		if self._thinkingMo then
			self._thinkIdMap[self._thinkingMo:getCfgId()] = self._thinkingMo
		end

		for _, v in ipairs(self._unlockedList) do
			self._thinkIdMap[v:getCfgId()] = v
		end

		for _, v in ipairs(self._lockedList) do
			self._thinkIdMap[v:getCfgId()] = v
		end
	end

	return self._thinkIdMap[index]
end

function M:getUnlockCount()
	return #self._unlockedList
end

return M

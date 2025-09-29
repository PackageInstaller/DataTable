-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/tools/GameObjectsEnableByPriority.lua

module("logic.extensions.battle.tools.GameObjectsEnableByPriority", package.seeall)

local M = class("GameObjectsEnableByPriority")

function M:ctor()
	self._curActiveIndex = 0
	self._gameObjectList = {}
	self._priorityList = {}
	self._enableStatusList = {}
end

function M:addGameObject(go, priority)
	table.insert(self._gameObjectList, go)
	table.insert(self._priorityList, priority)
	table.insert(self._enableStatusList, go.activeSelf)
	goutil.setActive(go, false)
	self:setGameObjectEnable()
end

function M:setGameObjectEnable(go, status)
	local maxPriority = 0
	local maxPriorityIdx = 0
	local isInList = false

	for i, v in ipairs(self._gameObjectList) do
		if go == v then
			if self._enableStatusList[i] == status then
				return
			end

			self._enableStatusList[i] = status
			isInList = true
		end

		if self._enableStatusList[i] and maxPriority < self._priorityList[i] then
			maxPriority = self._priorityList[i]
			maxPriorityIdx = i
		end
	end

	if go and not isInList then
		goutil.setActive(go, status)

		return
	end

	if self._curActiveIndex ~= maxPriorityIdx then
		goutil.setActive(self._gameObjectList[self._curActiveIndex], false)
		goutil.setActive(self._gameObjectList[maxPriorityIdx], true)

		self._curActiveIndex = maxPriorityIdx
	end
end

function M:clear()
	BattleTableUtil.clearTable(self._gameObjectList)
	BattleTableUtil.clearTable(self._priorityList)
	BattleTableUtil.clearTable(self._enableStatusList)

	self._curActiveIndex = 0
end

function M:disableAllGameObject()
	self._curActiveIndex = 0

	BattleTableUtil.clearTable(self._enableStatusList)

	for i, gameObject in ipairs(self._gameObjectList) do
		goutil.setActive(gameObject, false)
	end
end

return M

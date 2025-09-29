-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/tools/GameObjectVisibleState.lua

module("logic.extensions.battle.tools.GameObjectVisibleState", package.seeall)

local GameObjectVisibleState = class("GameObjectVisibleState")
local kDefaultKey = "GameObjectVisibleState"

function GameObjectVisibleState:ctor()
	self._invisibleAmount = SignalAmount.New()
end

function GameObjectVisibleState:setEnable(key, active)
	if active then
		self._invisibleAmount:remove(key or kDefaultKey)
	else
		self._invisibleAmount:addUnique(key or kDefaultKey)
	end
end

function GameObjectVisibleState:enable(key)
	self:setEnable(key, true)
end

function GameObjectVisibleState:disable(key)
	self:setEnable(key, false)
end

function GameObjectVisibleState:clear()
	self._invisibleAmount:clear()
end

function GameObjectVisibleState:isEnable()
	return self._invisibleAmount:isUnactive()
end

function GameObjectVisibleState:hasKey(key)
	return self._invisibleAmount:hasKey(key)
end

function GameObjectVisibleState:getCount()
	return self._invisibleAmount:getCount()
end

return GameObjectVisibleState

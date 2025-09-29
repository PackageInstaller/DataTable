-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/tools/GameObjectEnableState.lua

module("logic.extensions.battle.tools.GameObjectEnableState", package.seeall)

local GameObjectEnableState = class("GameObjectEnableState")
local kDefaultKey = "GameObjectEnableState"

function GameObjectEnableState:ctor(mainGO)
	self.mainGO = mainGO
	self._invisibleAmount = SignalAmount.New()
end

function GameObjectEnableState:setEnable(key, active)
	if active then
		self._invisibleAmount:remove(key or kDefaultKey)
		self:_updateVisibleState()
	else
		self._invisibleAmount:addUnique(key or kDefaultKey)
		self:_updateVisibleState()
	end
end

function GameObjectEnableState:enable(key)
	self:setEnable(key, true)
end

function GameObjectEnableState:disable(key)
	self:setEnable(key, false)
end

function GameObjectEnableState:clear()
	self._invisibleAmount:clear()
	self:_updateVisibleState()
end

function GameObjectEnableState:isEnable()
	return self._invisibleAmount:isUnactive()
end

function GameObjectEnableState:_updateVisibleState()
	goutil.setActive(self.mainGO, self._invisibleAmount:isUnactive())
end

return GameObjectEnableState

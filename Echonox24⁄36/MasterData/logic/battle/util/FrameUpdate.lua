-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/FrameUpdate.lua

module("logic.battle.util.FrameUpdate", package.seeall)

local FrameUpdate = class("FrameUpdate")

function FrameUpdate:init()
	self._listeners = {}

	UpdateBeat:Add(self._update, self)
end

function FrameUpdate:_update()
	local deltaTime = Time.deltaTime
	local listeners = self._listeners
	local anyRemoved = false

	for _, listener in ipairs(listeners) do
		if listener then
			listener:luaUpdate(deltaTime)
		else
			anyRemoved = true
		end
	end

	if anyRemoved then
		for i, listener in ipairs(listeners) do
			if not listener then
				table.remove(listeners, i)
			end
		end
	end
end

function FrameUpdate:addListener(listener)
	if self:hasListener(listener) then
		return
	end

	table.insert(self._listeners, listener)
end

function FrameUpdate:removeListener(listener)
	local listeners = self._listeners

	for i, v in pairs(listeners) do
		if v == listener then
			listeners[i] = false

			return
		end
	end
end

function FrameUpdate:hasListener(listener)
	local listeners = self._listeners

	for _, v in pairs(listeners) do
		if v == listener then
			return true
		end
	end

	return false
end

FrameUpdate:init()

return FrameUpdate

-- chunkname: @framework/core/eventsystem/DispatchItem.lua

module("framework.core.eventsystem.DispatchItem", package.seeall)

local DispatchItem = class("DispatchItem")

function DispatchItem.createPool()
	DispatchItem._pool = LuaObjPool.New(32, DispatchItem._poolNew, DispatchItem._poolRelease, DispatchItem._poolReset)
end

function DispatchItem.getPool()
	if DispatchItem._pool == nil then
		DispatchItem.createPool()
	end

	return DispatchItem._pool
end

function DispatchItem._poolNew()
	return DispatchItem.New()
end

function DispatchItem._poolRelease(luaObj)
	luaObj:release()
end

function DispatchItem._poolReset(luaObj)
	luaObj:reset()
end

function DispatchItem:ctor()
	self:reset()
end

function DispatchItem:release()
	self:reset()
end

function DispatchItem:reset()
	self.eventName = nil
	self.eventArgs = nil
end

return DispatchItem

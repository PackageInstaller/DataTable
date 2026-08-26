-- chunkname: @framework/core/eventsystem/EventItem.lua

module("framework.core.eventsystem.EventItem", package.seeall)

local EventItem = class("EventItem")

EventItem.IsIOSPlayer = SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer

local callWithCatch = _G.callWithCatch
local _xpcall = xpcall

function EventItem.getPool()
	if EventItem._pool == nil then
		EventItem._pool = LuaObjPool.New(32, EventItem._poolNew, EventItem._poolRelease, EventItem._poolReset)
	end

	return EventItem._pool
end

function EventItem._poolNew()
	return EventItem.New()
end

function EventItem._poolRelease(luaObj)
	luaObj:release()
end

function EventItem._poolReset(luaObj)
	luaObj:reset()
end

function EventItem:ctor()
	self:reset()
end

function EventItem:release()
	self:reset()
end

function EventItem:ctor()
	self.cbObjContainer = {}

	setmetatable(self.cbObjContainer, {
		__mode = "v"
	})
	self:reset()
end

function EventItem:reset()
	self.eventName = nil
	self.callback = nil
	self.cbObjContainer.value = nil
	self.hasCbObj = false
	self.status = LuaEventSystem.Idle
	self.priority = LuaEventSystem.Low
	self.removeAll = nil
end

function EventItem:setCbObj(cbObj)
	self.hasCbObj = cbObj ~= nil

	if self.hasCbObj then
		self.cbObjContainer.value = cbObj
	end
end

function EventItem:getCbObj()
	if self.hasCbObj then
		return self.cbObjContainer.value
	end

	return nil
end

function EventItem:dispatch(...)
	if self.hasCbObj and not self.cbObjContainer.value then
		return false
	end

	if not self.hasCbObj then
		callWithCatch(self.callback, ...)
	else
		local args = ...
		local len = args ~= nil and select("#", ...) or 0

		if len > 0 then
			_xpcall(self.callback, __G__TRACKBACK__, self.cbObjContainer.value, select(1, ...))
		else
			_xpcall(self.callback, __G__TRACKBACK__, self.cbObjContainer.value)
		end
	end

	return true
end

return EventItem

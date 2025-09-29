-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/handler/Handler.lua

module("logic.common.handler.Handler", package.seeall)

local M = class("Handler")

local function executeCallback(callback, handler, ...)
	if not callback then
		return false, ...
	end

	if handler then
		return callback(handler, ...)
	else
		return callback(...)
	end
end

function M:executeCallback(callback, handler, ...)
	executeCallback(callback, handler, ...)
end

M._callback = false
M._handler = false

function M:ctor(callback, handler)
	self:setListener(callback, handler)
end

function M:call(...)
	return executeCallback(self._callback, self._handler, ...)
end

function M:callAndClear(...)
	local callback = self._callback
	local handler = self._handler

	self:clear()

	return executeCallback(callback, handler, ...)
end

function M:setListener(callback, handler)
	self._callback = callback or false
	self._handler = handler or false
end

function M:hadCallback()
	return self._callback ~= nil and self._callback ~= false
end

function M:getCallBack()
	return self._callback
end

function M:getCallObj()
	return self._handler
end

function M:clear()
	self._callback = false
	self._handler = false
end

return M

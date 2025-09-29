-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkListenCustomEvent.lua

module("logic.scene.work.WorkListenCustomEvent", package.seeall)

local M = class("WorkListenCustomEvent", WorkBase)

function M:ctor(customEventType)
	M.super.ctor(self)

	self._customEventType = customEventType
end

function M:onEnter(context)
	GlobalDispatcher:addEventListener(self._customEventType, self._onCustomEvent, self)
end

function M:onExit(isInterrupt)
	GlobalDispatcher:removeEventListener(self._customEventType, self._onCustomEvent, self)
end

function M:_onCustomEvent(e, ...)
	GlobalDispatcher:removeEventListener(self._customEventType, self._onCustomEvent, self)
	self:onDone(WorkResult.Succeed)
end

return M

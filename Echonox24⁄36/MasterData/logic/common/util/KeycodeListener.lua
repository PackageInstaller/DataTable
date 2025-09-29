-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/KeycodeListener.lua

module("logic.common.util.KeycodeListener", package.seeall)

local M = class("KeycodeListener")

function M.Get(go)
	if UnityEngine.Application.isMobilePlatform then
		M.instance = M.New()
		M.instance.enabled = false
	else
		M.instance = Astral.SimpleLuaComponentContainer.Add(go, M)
		M.instance.enabled = true
	end

	return M.instance
end

function M:ctor(container)
	self._allListeners = {}
	self._downCodes = {}
	self._keycodeDispatcherId = false
end

function M:start()
	if not UnityEngine.Application.isMobilePlatform then
		if not self._keycodeDispatcherId then
			self._keycodeDispatcherId = DispatcherManager.getNewId()
		end

		Scheduler.addListener(0.05, self._update, self, true)
	end
end

function M:isOn(key)
	return Astral.ToLuaFramework.AsInputSystem.InputSystemToLua.GetKey(key)
end

function M:addEventListener(key, listener, listenerCaller, priority)
	self._allListeners[key] = (self._allListeners[key] or 0) + 1

	if self._keycodeDispatcherId then
		DispatcherManager.addEventListener(self._keycodeDispatcherId, tostring(key), listener, listenerCaller, priority)
	end
end

function M:removeEventListener(key, listener, listenerCaller)
	local num = (self._allListeners[key] or 1) - 1

	self._allListeners[key] = num > 0 and num or 0

	if self._keycodeDispatcherId then
		DispatcherManager.removeEventListener(self._keycodeDispatcherId, tostring(key), listener, listenerCaller, priority)
	end
end

function M:_update()
	for k, v in pairs(self._allListeners) do
		if v > 0 then
			if self:isOn(k) then
				if not self._downCodes[k] then
					DispatcherManager.dispatchEvent(self._keycodeDispatcherId, tostring(k), true)

					self._downCodes[k] = true
				end
			elseif self._downCodes[k] then
				DispatcherManager.dispatchEvent(self._keycodeDispatcherId, tostring(k), false)

				self._downCodes[k] = nil
			end
		end
	end
end

function M:clear()
	self._downCodes = nil
	self._allListeners = nil

	DispatcherManager.clearDispatcher(self._keycodeDispatcherId)
	Scheduler.removeListener(self._update, self)
end

M.instance = M.New()

return M

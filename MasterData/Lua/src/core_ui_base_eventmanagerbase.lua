local this = class("eventManagerBase")

function this:ctor()
  self._event = require("core.event").new()
end

function this:sendEvent(eventName, ...)
  self._event:send(eventName, ...)
end

function this:addListener(eventName, func, register, obj, priority)
  self._event:register(eventName, func, register, obj, priority)
end

function this:removeListener(eventName, func, register)
  self._event:unRegister(eventName, func, register)
end

function this:initialize()
end

function this:dispose()
end

return this

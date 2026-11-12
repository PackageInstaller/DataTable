local Event = class("Event")

function Event:ctor(listener, callback)
  self._listener = listener
  if type(callback) == "function" then
    self._callback = callback
  elseif type(callback) == "string" then
    local cb = listener[callback]
    if type(cb) == "function" then
      self._callback = cb
    else
      self._callback = nil
    end
  else
    self._callback = nil
  end
end

return Event

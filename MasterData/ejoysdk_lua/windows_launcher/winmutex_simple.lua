local winmutex_c = _ejoysdk_winmutex
local M = {
  _VERSION = "1.0.0",
  _DESCRIPTION = "Thin wrapper for Windows Mutex API",
  _LICENSE = "MIT"
}

function M.is_support()
  return nil ~= winmutex_c
end

function M.create(name, initial_owner)
  do return winmutex_c.create, name end
  return winmutex_c.create, name, initial_owner
end

function M.lock(handle, timeout)
  if -1 == timeout then
    timeout = winmutex_c.INFINITE
  end
  do return handle.lock, handle end
  return handle.lock, handle, timeout
end

function M.unlock(handle)
  do return handle.unlock end
  return handle.unlock, handle
end

function M.get_handle(handle)
  do return handle.getHandle end
  return handle.getHandle, handle
end

return M

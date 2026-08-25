local E = require("ejoysdk_lua.ejoysdk")
local PREDOWNLOAD_CONFIG = E.LazyKeyStore:New("EJOYSDK_QZ_PREDOWNLOAD_CONFIG", false, true, false)
local _config = PREDOWNLOAD_CONFIG:get()
local M = {}
M.KEY = {
  START_TIME = "st",
  AUTH = "auth",
  GROUPS = "groups"
}

local function _init()
  if not _config then
    _config = PREDOWNLOAD_CONFIG:get() or {}
    M.save()
  end
end

function M.update(key, value)
  _init()
  if key and value then
    _config[key] = value
    PREDOWNLOAD_CONFIG:set(_config)
  end
end

function M.get(key)
  _init()
  if key then
    return _config[key]
  end
end

function M.delete(key)
  _init()
  if key then
    _config[key] = nil
    M.save()
  end
end

function M.clean()
  _config = {}
  M.save()
end

function M.save()
  PREDOWNLOAD_CONFIG:set(_config or {})
end

return M

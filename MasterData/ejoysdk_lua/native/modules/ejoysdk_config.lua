local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local TAG = "ejoysdk_config"
local M = {}

function M.set_config(key, value)
  E.LOG.debug(TAG, "set_config key:" .. tostring(key) .. ", value >>")
  E.LOG.debug(TAG, type(value))
  E.LOG.debug(TAG, value)
  E.CONFIG.set_config(key, value)
end

function M.get_config(key, cb)
  local val = E.CONFIG.get_config(key)
  E.LOG.debug(TAG, "get_config key:" .. tostring(key) .. ", value >>")
  E.LOG.debug(TAG, type(val))
  E.LOG.debug(TAG, val)
  if type(val) == "table" then
    cb(JSON.encode(val))
  else
    cb(tostring(val))
  end
end

function M.get_config_orig_type(key, cb)
  local val = E.CONFIG.get_config(key)
  E.LOG.debug(TAG, "get_config key:" .. tostring(key) .. ", value >>")
  E.LOG.debug(TAG, type(val))
  E.LOG.debug(TAG, val)
  cb(val)
end

return M

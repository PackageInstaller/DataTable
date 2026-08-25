local E = require("ejoysdk_lua.ejoysdk")
local EL = require("ejoysdk_lua.ejoysdk_log")
local M = {}
M.LOG = {}
local TAG_EJOY_RES = "STARTUP#ejoy_res#"

function M.LOG.debug(tag, message)
  if not M.is_log_open() then
    return
  end
  E.LOG.debug(TAG_EJOY_RES, tostring(tag) .. "#" .. tostring(message))
end

function M.LOG.warn(tag, message)
  if not M.is_log_open() then
    return
  end
  E.LOG.warn(TAG_EJOY_RES, tostring(tag) .. "#" .. tostring(message))
end

function M.LOG.error(tag, message)
  if not M.is_log_open() then
    return
  end
  E.LOG.error(TAG_EJOY_RES, tostring(tag) .. "#" .. tostring(message))
end

function M.is_log_open()
  do return end
  return EL.is_log_open, nil
end

return M

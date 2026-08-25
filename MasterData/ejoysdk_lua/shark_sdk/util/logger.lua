local ejoysdk = require("ejoysdk_lua.ejoysdk")
local M = {}
local LOG_TAG = "[SharkSDK]"

function M.debug(format, ...)
  local msg = string.format(format, ...)
  ejoysdk.LOG.debug(LOG_TAG, msg)
end

function M.info(format, ...)
  local msg = string.format(format, ...)
  ejoysdk.LOG.info(LOG_TAG, msg)
end

function M.warn(format, ...)
  local msg = string.format(format, ...)
  ejoysdk.LOG.warn(LOG_TAG, msg)
end

function M.error(format, ...)
  local msg = string.format(format, ...)
  ejoysdk.LOG.error(LOG_TAG, msg)
end

return M

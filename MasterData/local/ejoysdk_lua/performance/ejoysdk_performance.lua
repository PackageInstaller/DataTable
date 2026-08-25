local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local sdk_init_invoke_timestamp = 0

function M.mark_sdk_init_invoke()
  sdk_init_invoke_timestamp = E.system_ms()
end

function M.get_sdk_init_invoke_timestamp()
  return sdk_init_invoke_timestamp
end

function M.clear_sdk_init_timestamp()
  sdk_init_invoke_timestamp = 0
end

return M

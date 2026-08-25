local client_config = require("ejoysdk_lua.shark_sdk.config.client_config")
local table = require("ejoysdk_lua.shark_sdk.util.table_util")
local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local apus = require("ejoysdk_lua.apm-sdk-lua.apus")
local M = {}

function M.report(event_name, labels, msg, state)
  if not client_config.is_report_enabled() then
    return
  end
  logger.debug("上报事件: %s", event_name)
  local default_labels = {
    pcode = client_config.get_pcode()
  }
  local report_labels = table.merge(default_labels, labels)
  apus.event_post(event_name, report_labels, nil, msg, state)
end

return M

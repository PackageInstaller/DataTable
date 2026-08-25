local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local E = require("ejoysdk_lua.ejoysdk")
local M = {}
M.__index = M

local function is_in_blacklist(blacklist, event_name)
  if type(blacklist) ~= "table" or type(event_name) ~= "string" then
    return false
  end
  for _, item in ipairs(blacklist) do
    if item == event_name then
      E.LOG.debug("apm_collect_filter", event_name .. " is_in_blacklist,ignored")
      return true
    end
  end
  return false
end

function M.is_in_log_blacklist(event_name)
  local blacklist = Cfg.get_log_blacklist()
  do return is_in_blacklist, blacklist end
  return is_in_blacklist, blacklist, event_name
end

function M.is_in_event_blacklist(event_name)
  local blacklist = Cfg.get_event_blacklist()
  do return is_in_blacklist, blacklist end
  return is_in_blacklist, blacklist, event_name
end

return M

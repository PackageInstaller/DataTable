local E = require("ejoysdk_lua.ejoysdk")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local LOGGER = "apm_tb_utils"
local M = {}
M.__index = M

local function get_traceback_info()
  if Global.disable_debug_stack() then
    E.LOG.debug(LOGGER, "disable_debug_stack ...")
    return ""
  end
  local lines = {}
  local stack = debug.traceback()
  for line in stack:gmatch("[^\r\n]+") do
    if line:find("in upvalue ") then
      table.insert(lines, line)
    end
  end
  do return table.concat, lines end
  return table.concat, lines, "\n", stack:gmatch("[^\r\n]+")
end

M.get_traceback_info = get_traceback_info
return M

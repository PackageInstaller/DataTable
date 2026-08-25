local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "foreign_call"
local M = {}

local function get_func(module_name, function_name)
  module_name = "ejoysdk_lua." .. module_name
  local module_obj = require(module_name)
  local invoke_fun = module_obj
  string.gsub(function_name, "[^\\.]+", function(w)
    invoke_fun = invoke_fun[w]
  end)
  if invoke_fun and type(invoke_fun) == "function" then
    return invoke_fun
  end
  return nil
end

local function call(module, function_name, ...)
  local func = get_func(module, function_name)
  local E = require("ejoysdk_lua.ejoysdk")
  local errorMsg = "module=" .. tostring(module) .. ",function=" .. tostring(function_name)
  if func then
    local succ, msg = pcall(func, ...)
    if not succ then
      E.LOG.debug(TAG, "call function failed," .. tostring(errorMsg) .. ", msg >>")
      E.LOG.debug(TAG, msg)
    end
  else
    E.LOG.debug(TAG, "not has this function," .. tostring(errorMsg))
  end
end

M.input = call
return M

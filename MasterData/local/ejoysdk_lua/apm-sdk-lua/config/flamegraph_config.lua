local E = require("ejoysdk_lua.ejoysdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local CfgHelper = require("ejoysdk_lua.apm-sdk-lua.config.helper")
local ErrUtils = require("ejoysdk_lua.apm-sdk-lua.common.err_utils")
local M = {
  CATEGORY_FRAMRGRAPH_TASKS = "flamegraph_tasks"
}
M.__index = M
local LOGGER = "apm_flamegraph_config"
local namespace = "apus_flamegraph"
local conf = {
  flamegraph_tasks = {
    ttl = 300000,
    max_duration = 300,
    max_concurrent_tasks = 10,
    enabled = true,
    tasks = {},
    retry_budget = 3,
    retry_code_list = {}
  }
}
local update_callbacks = {}

local function get_from_config_center()
  local data = ECC.get_config(namespace)
  if nil ~= data then
    return data.config
  end
end

function M.init()
  local cfg_from_cc = get_from_config_center()
  E.LOG.debug(LOGGER, "retrieve config from config center:")
  E.LOG.debug(LOGGER, cfg_from_cc or {})
  conf = Utils.merge_table(conf, cfg_from_cc, true)
  E.LOG.debug(LOGGER, "generated apus_flamegraph config:")
  E.LOG.debug(LOGGER, conf)
  
  local function safely_handle_update(new_cfg)
    local function handle_update()
      do return M.handle_update end
      
      return M.handle_update, new_cfg
    end
    
    xpcall(handle_update, ErrUtils.handle_err)
  end
  
  ECC.subscribe(namespace, safely_handle_update)
end

function M.set_update_callback(category, func)
  update_callbacks[category] = func
end

function M.get(category, key, default_value)
  do return CfgHelper.get, conf, category, key end
  return CfgHelper.get, conf, category, key, default_value
end

function M.handle_update(new_cfg)
  E.LOG.info(LOGGER, "got update from config center:")
  E.LOG.info(LOGGER, new_cfg)
  if new_cfg.config == nil then
    E.LOG.error(LOGGER, "invalid new config")
    return
  end
  for cat, cat_cfg in pairs(new_cfg.config) do
    if type(cat_cfg) == "table" and nil ~= conf[cat] then
      CfgHelper.handle_cat_update(conf, update_callbacks, cat, cat_cfg)
    else
      E.LOG.debug(LOGGER, "invalid new config: " .. cat)
    end
  end
end

return M

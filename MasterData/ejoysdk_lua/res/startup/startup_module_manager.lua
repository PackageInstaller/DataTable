local E = require("ejoysdk_lua.ejoysdk")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local M = {}
local TAG = "startup_module_manager"
local module_cache = {}

function M.get_module_cache_by_name(module_name)
  if not module_name then
    E.LOG.warn("get_module_by_name skip for name is nil")
    return
  end
  local module = module_cache[module_name]
  if module then
    return module
  end
  return nil
end

function M.get_module_by_name(module_name, res_mgr)
  local module = M.get_module_cache_by_name(module_name)
  if module then
    return module
  end
  E.LOG.debug(TAG, "get_module_by_name:" .. tostring(module_name))
  if module_name == SC.STARTUP_CORE_MODULE_NAME.INIT_FLOW then
    module = require("ejoysdk_lua.res.startup.modules.startup_init")
  elseif module_name == SC.STARTUP_CORE_MODULE_NAME.SELF_UPDATE_FLOW then
    module = require("ejoysdk_lua.res.startup.modules.self_update")
  elseif module_name == SC.STARTUP_CORE_MODULE_NAME.RES_UPDATE_PREPARE then
    module = require("ejoysdk_lua.res.startup.modules.update_prepare")
  elseif module_name == SC.STARTUP_CORE_MODULE_NAME.RES_UPDATE_CHECK then
    module = require("ejoysdk_lua.res.startup.modules.update_check")
  elseif module_name == SC.STARTUP_CORE_MODULE_NAME.RES_INTEGRITY_CHECK then
    module = require("ejoysdk_lua.res.startup.modules.integrity_check")
  elseif module_name == SC.STARTUP_CORE_MODULE_NAME.RES_READY then
    module = require("ejoysdk_lua.res.startup.modules.res_ready")
  end
  if module then
    module_cache[module_name] = module
    module:_init(res_mgr)
  end
  return module
end

function M.reload()
  package.loaded["ejoysdk_lua.res.startup.modules.startup_init"] = nil
  package.loaded["ejoysdk_lua.res.startup.modules.self_update"] = nil
  package.loaded["ejoysdk_lua.res.startup.modules.update_prepare"] = nil
  package.loaded["ejoysdk_lua.res.startup.modules.update_check"] = nil
  package.loaded["ejoysdk_lua.res.startup.modules.res_ready"] = nil
  module_cache = {}
end

return M

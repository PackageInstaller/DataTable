local E = require("ejoysdk_lua.ejoysdk")
local FLOW_TASK = require("ejoysdk_lua.libs.flow_task")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local STAT = require("ejoysdk_lua.res.res_stat")
local MODULE_NAME = SC.STARTUP_CORE_MODULE_NAME.RES_UPDATE_PREPARE
local TAG = MODULE_NAME
local M = FLOW_TASK:new(MODULE_NAME)
local state_update_prepare = false

function M:_init(_module_mgr_instance)
  self._data = {module_instance = _module_mgr_instance}
end

function M:run()
  E.LOG.d(TAG, "begin run")
  STAT.stat_update_prepare_begin()
  local cur_product_code = SC.get_current_product_code()
  local public_startup_config = SC.get_public_startup_config()
  local review_startup_config = SC.get_review_startup_config()
  local public_product_code = SC.get_public_product_code()
  local review_product_code = SC.get_review_product_code()
  local _is_review = SC.get_review_state()
  E.LOG.debug(TAG, "common startup_config, pcode:" .. tostring(public_product_code) .. ", cur_pcode:" .. tostring(cur_product_code) .. ", config >>")
  E.log(public_startup_config)
  E.LOG.debug(TAG, "review_startup_config , pcode:" .. tostring(review_product_code) .. ", config >>")
  E.log(review_startup_config)
  local _pubilc_startup_data = {
    [END.STARTUP_CONFIG_KEY.PRODUCT_CODE] = public_product_code,
    [END.STARTUP_CONFIG_KEY.CONFIG] = public_startup_config
  }
  local _review_startup_data
  if _is_review then
    _review_startup_data = {product_code = review_product_code, config = review_startup_config}
  end
  
  local function on_startup_prepare_complete()
    state_update_prepare = true
    local publish_data = {
      [END.STARTUP_CONFIG_KEY.CURRENT_PRODUCT_CODE] = cur_product_code,
      [END.STARTUP_CONFIG_KEY.IS_REVIEW] = _is_review,
      [END.STARTUP_CONFIG_KEY.COMMON_STARTUP_DATA] = _pubilc_startup_data,
      [END.STARTUP_CONFIG_KEY.REVIEW_STARTUP_DATA] = _review_startup_data
    }
    END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_UPDATE_PREPARE_SUCC, publish_data)
    STAT.stat_update_prepare_end(true)
    self:run_next()
  end
  
  local is_force_check_update = SC.is_force_check_update()
  if state_update_prepare and not is_force_check_update then
    EL.LOG.debug(TAG, "update_prepare already succ, now return true")
    on_startup_prepare_complete()
    return
  end
  STAT.stat_startup_config_changed_begin()
  END.notify_startup_config_changed(cur_product_code, _is_review, _pubilc_startup_data, _review_startup_data, function(_succ, ...)
    if _succ then
      EL.LOG.debug(TAG, "notify_startup_config_changed succ")
    else
      local code, msg = ...
      EL.LOG.debug(TAG, "notify_startup_config_changed failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    STAT.stat_startup_config_changed_end(true)
    on_startup_prepare_complete()
  end)
end

return M

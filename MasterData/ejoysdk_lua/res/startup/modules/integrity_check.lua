local E = require("ejoysdk_lua.ejoysdk")
local FLOW_TASK = require("ejoysdk_lua.libs.flow_task")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local RES_CHECK = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_check")
local STAT = require("ejoysdk_lua.res.res_stat")
local MODULE_NAME = SC.STARTUP_CORE_MODULE_NAME.RES_INTEGRITY_CHECK
local TAG = MODULE_NAME
local M = FLOW_TASK:new(MODULE_NAME)

function M:_init(_module_mgr_instance)
  self._data = {module_instance = _module_mgr_instance}
end

function M:run()
  E.LOG.d(TAG, "begin run")
  local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
  local _, startup_opts = SC.get_game_startup_params()
  local _check_updates_opts = startup_opts[END.NAMESPACE_UPDATE_OPTIONS.INTEGRITY_CHECK_UPDATES] or {}
  if _check_updates_opts.enable == true then
    local startup_local_res_info = SC.get_startup_game_origin_params() or {}
    local res_info = {
      namespace = startup_local_res_info.namespace,
      res_key = startup_local_res_info.res_key,
      pkg_res_list_dir = startup_local_res_info.pkg_res_path
    }
    local update_file_list = SC.get_startup_update_file_list() or {}
    if #update_file_list > 0 then
      STAT.stat_integrity_check_begin()
      local _start_time = E.system_ms()
      RES_CHECK.integrity_check(res_info, {file_list = update_file_list}, _check_updates_opts, function(check_succ, data)
        local _cost = E.system_ms() - _start_time
        if check_succ then
          STAT.stat_integrity_check_end(true, _cost)
          self:run_next()
        else
          local code = data.code
          local msg = data.msg
          STAT.stat_integrity_check_end(false, code, msg)
          self._data.module_instance.on_global_failed(code, msg)
        end
        SC.set_startup_update_file_list(nil)
      end)
      return
    end
  end
  self:run_next()
end

return M

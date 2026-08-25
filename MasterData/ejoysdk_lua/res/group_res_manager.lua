local E = require("ejoysdk_lua.ejoysdk")
local UIM = require("ejoysdk_lua.res.update_info_manager")
local UT = require("ejoysdk_lua.res.startup.modules.update_task")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = "GROUP#" .. EM.MODULE.RES .. "group_res_manager"
local QZ_GROUP_PREFIX = RTM.RES_GROUP_INFO_KEY.PREFIX
local updating_tasks = {}

function M.get_task_key(res_key, group_name)
  return QZ_GROUP_PREFIX .. tostring(res_key) .. "-" .. tostring(group_name)
end

function M.get_real_res_key(task_key)
  if not E.Utils.start_with(task_key, QZ_GROUP_PREFIX) then
    return task_key
  end
  local split_arr = E.Utils.split_string(task_key, "-")
  if split_arr and #split_arr > 2 then
    E.LOG.debug(TAG, string.format("get_real_res_key, task_key is %s, real_key is %s", tostring(task_key), tostring(split_arr[2])))
    return split_arr[2]
  else
    E.LOG.error(TAG, "get_real_res_key fail, task_key is " .. tostring(task_key))
  end
end

function M.is_group(task_key)
  if E.Utils.start_with(task_key, QZ_GROUP_PREFIX) then
    return true
  end
  return false
end

function M.get_group_name_by_task_key(task_key)
  if not E.Utils.start_with(task_key, QZ_GROUP_PREFIX) then
    return nil
  end
  local real_res_key = M.get_real_res_key(task_key)
  local group_key_prefix = QZ_GROUP_PREFIX .. tostring(real_res_key)
  local group_name = string.sub(task_key, #group_key_prefix + 2)
  return group_name
end

function M.get_group_res_state(namespace, res_key, group_name)
  local task_key = M.get_task_key(res_key, group_name)
  local local_res_group_state = RTM.static_get_local_res_state(namespace, task_key) or {}
  return local_res_group_state
end

function M.group_res_update(namespace, res_key, group_name, group_res_info, opts, listeners)
  local task_key = M.get_task_key(res_key, group_name)
  opts = opts or {}
  if opts.foreground_notification_enabled == nil then
    E.LOG.debug(TAG, "foreground_notification_enabled is nil, default disable")
    opts.foreground_notification_enabled = false
  else
    E.LOG.debug(TAG, "group res update, foreground_notification_enabled")
  end
  local DEFAULT_GROUP_ENGINE_HANDLER = require("ejoysdk_lua.res.ejoysdk_default_group_engine_handler")
  local engine_handler_cache = group_res_info.engine_handler or DEFAULT_GROUP_ENGINE_HANDLER
  END.register_res_update_namespace(namespace, task_key, listeners, opts, engine_handler_cache)
  local update_info, using_version = UIM.get_res_update_info_with_opts(namespace, res_key, group_name, opts)
  E.LOG.debug(TAG, "group update info >>>")
  E.LOG.debug(TAG, update_info)
  if nil == update_info or nil == next(update_info) then
    END.notify_group_res_update_complete(namespace, task_key, false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_UPDATE_INFO_EMPTY, "update info is empty, should call default group update function first")
    return
  end
  local local_res_group_state = M.get_group_res_state(namespace, res_key, group_name)
  local using_res_info = local_res_group_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  using_res_info.version = using_version
  local namespace_ext = group_res_info.namespace_ext
  local current_group_params = {}
  current_group_params[namespace] = {}
  current_group_params[namespace][task_key] = {
    version = using_version,
    res_save_base_path = group_res_info.res_save_base_path,
    res_save_storage_type = group_res_info.res_save_storage_type
  }
  E.LOG.debug(TAG, "group params is >>>>")
  E.LOG.debug(TAG, current_group_params)
  local update_task = updating_tasks[task_key]
  if not update_task then
    local function update_state_listener(_ns, _task_key, _state, _state_obj, ...)
      E.log(_state_obj)
      
      _state_obj = _state_obj or {}
      if _state == UT.PUB_STATES.FINISH then
        EL.LOG.debug(TAG, "state complete")
        END.notify_group_res_update_complete(_ns, _task_key, true)
        updating_tasks[task_key] = nil
      elseif _state == UT.PUB_STATES.APPLY_FAILED or _state == UT.PUB_STATES.DOWNLOAD_FAILED or _state == UT.PUB_STATES.IDLE then
        local err_code = _state_obj.err_code
        local err_msg = _state_obj.err_msg
        EL.LOG.warn(TAG, "resource process failed, ns:" .. tostring(_ns) .. ", task_key:" .. tostring(_task_key) .. ", state:" .. tostring(_state) .. ", code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
        END.notify_group_res_update_complete(_ns, _task_key, false, err_code, err_msg)
        updating_tasks[task_key] = nil
      end
    end
    
    update_task = UT:New(namespace, task_key, update_info, using_res_info, namespace_ext, current_group_params, opts, update_state_listener)
    updating_tasks[task_key] = update_task
  end
  update_task:reset(update_info, using_res_info)
end

function M.clean(namespace, res_key)
  local ERMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
  local ER = require("ejoysdk_lua.res.ejoysdk_res")
  local all_ns_resources = ER.get_all_cached_namespace_resources()
  for _ns, res_map in pairs(all_ns_resources) do
    if _ns == namespace then
      for _res_key, _res_info in pairs(res_map) do
        E.LOG.d(TAG, "clean group key:" .. _res_key)
        if M.is_group(_res_key) then
          local __real_res_key = M.get_real_res_key(_res_key)
          if __real_res_key == res_key then
            ER.repair(_ns, _res_key)
            RTM.static_clear_cached_res_info(_ns, _res_key)
            ERMF.clear_ejoy_res_source_model(_ns, _res_key)
          end
        end
      end
    end
  end
end

function M.get_update_task(res_key, group_name)
  local task_key = M.get_task_key(res_key, group_name)
  return updating_tasks[task_key]
end

return M

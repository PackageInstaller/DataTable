local E = require("ejoysdk_lua.ejoysdk")
local UIM = require("ejoysdk_lua.res.update_info_manager")
local UT = require("ejoysdk_lua.res.startup.modules.update_task")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local SU = require("ejoysdk_lua.res.startup.startup_utils")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local DEFAULT_GROUP_ENGINE_HANDLER = require("ejoysdk_lua.res.ejoysdk_default_group_engine_handler")
local START_UP_GROUP_INFO = E.LazyKeyStore:New("START_UP_GROUP_INFO", false, true, false)
local M = {}
local TAG = "GROUP#" .. EM.MODULE.RES .. "group_res_manager"
local QZ_GROUP_PREFIX = RTM.RES_GROUP_INFO_KEY.PREFIX
local updating_tasks = {}
local update_groups_in_startup = {}

function M.get_task_key(res_key, group_name)
  return QZ_GROUP_PREFIX .. tostring(res_key) .. "-" .. tostring(group_name)
end

function M.get_real_res_key(task_key)
  if not E.Utils.start_with(task_key, QZ_GROUP_PREFIX) then
    return task_key
  end
  local split_arr = E.Utils.split_string(task_key, "-")
  if split_arr and #split_arr > 2 then
    E.LOG.debug(TAG, "get_real_res_key, task_key is " .. tostring(task_key) .. ", real_key is " .. tostring(split_arr[2]))
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

local function check_group_update_in_startup_process(namespace, res_key, group_name)
  local STARTUP_MGR = require("ejoysdk_lua.res.startup_res_manager")
  if STARTUP_MGR.is_startup_res_update_in_progress() then
    update_groups_in_startup[namespace] = update_groups_in_startup[namespace] or {}
    update_groups_in_startup[namespace][res_key] = update_groups_in_startup[namespace][res_key] or {}
    update_groups_in_startup[namespace][res_key][group_name] = true
    E.LOG.debug(TAG, "check_group_update_in_startup_process, group update in startup process, namespace: " .. tostring(namespace) .. ", res_key: " .. tostring(res_key) .. ", group_name: " .. tostring(group_name))
    START_UP_GROUP_INFO:set(update_groups_in_startup)
  else
    E.LOG.debug(TAG, "check_group_update_in_startup_process, group update not in startup process, namespace: " .. tostring(namespace) .. ", res_key: " .. tostring(res_key) .. ", group_name: " .. tostring(group_name))
  end
end

function M.get_startup_group_infos()
  return START_UP_GROUP_INFO:get() or {}
end

function M.group_res_update(namespace, res_key, group_name, group_res_info, opts, listeners)
  check_group_update_in_startup_process(namespace, res_key, group_name)
  local task_key = M.get_task_key(res_key, group_name)
  opts = opts or {}
  if opts.foreground_notification_enabled == nil then
    E.LOG.debug(TAG, "foreground_notification_enabled is nil, default disable")
    opts.foreground_notification_enabled = false
  else
    E.LOG.debug(TAG, "group res update, foreground_notification_enabled")
  end
  local engine_handler_cache = group_res_info.engine_handler or DEFAULT_GROUP_ENGINE_HANDLER
  END.register_res_update_namespace(namespace, task_key, listeners, opts, engine_handler_cache)
  local update_info = UIM.get_res_update_info(namespace, res_key, group_name, opts.version)
  E.LOG.debug(TAG, "group update info >>>")
  E.LOG.debug(TAG, update_info)
  if nil == update_info or nil == next(update_info) then
    END.notify_group_res_update_complete(namespace, task_key, false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_UPDATE_INFO_EMPTY, "update info is empty, should call default group update function first")
    return
  end
  local local_res_group_state = M.get_group_res_state(namespace, res_key, group_name)
  local using_res_info = local_res_group_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  if opts.version and not UTILS.STR.is_empty(opts.version) then
    using_res_info = {
      version = opts.version
    }
  end
  if SU.can_reuse_res() and update_info[RTM.UPDATE_INFO_KEY.PATCHES] and next(update_info[RTM.UPDATE_INFO_KEY.PATCHES]) then
    update_info = UTILS.deepcopy(update_info)
    local patches = update_info[RTM.UPDATE_INFO_KEY.PATCHES] or {}
    for _, patch in ipairs(patches) do
      if patch.targetVersion == using_res_info.version then
        update_info[RTM.UPDATE_INFO_KEY.PATCH] = patch
        break
      end
    end
  end
  local namespace_ext = group_res_info.namespace_ext
  local current_group_params = {}
  current_group_params[namespace] = {}
  current_group_params[namespace][task_key] = {
    version = using_res_info.version,
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
      elseif _state == UT.PUB_STATES.APPLY_FAILED or _state == UT.PUB_STATES.DOWNLOAD_FAILED or _state == UT.PUB_STATES.IDLE then
        local err_code = _state_obj.err_code
        local err_msg = _state_obj.err_msg
        EL.LOG.warn(TAG, "resource process failed, ns:" .. tostring(_ns) .. ", task_key:" .. tostring(_task_key) .. ", state:" .. tostring(_state) .. ", code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
        END.notify_group_res_update_complete(_ns, _task_key, false, err_code, err_msg)
      end
    end
    
    update_task = UT:New(namespace, task_key, update_info, using_res_info, namespace_ext, current_group_params, opts, update_state_listener)
    updating_tasks[task_key] = update_task
  end
  update_task:reset(update_info, using_res_info)
end

return M

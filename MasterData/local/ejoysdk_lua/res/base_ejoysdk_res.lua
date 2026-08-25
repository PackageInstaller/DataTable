local M = {}
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local E = require("ejoysdk_lua.ejoysdk")
local TAG = "ejoysdk_res_base_facade"
local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local RS = require("ejoysdk_lua.res.res_stat")
local UT = require("ejoysdk_lua.res.startup.modules.update_task")
local DGH = require("ejoysdk_lua.res.ejoysdk_default_group_engine_handler")
local DEH = require("ejoysdk_lua.res.ejoysdk_default_engine_handler")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local custom_update_infos_cache = E.LazyKeyStore:New("EJOYSDK_CUSTOM_UPDATE_INFOS", false, true, false)
local custom_keystore_cache = {}
local res_info_cache = {}
local namespace_ext_cache = {}
M.RES_INFO_KEY = RTM.USING_RES_INFO_PARAM_KEY
M.DOWNLOAD_STATE = RTM.PUBLIC_DOWNLOAD_STATE
M.RES_DOWNLOAD_STATE_KEY = RTM.RES_STATE_INFO_KEY
M.PROGRESS_INFO_KEY = RTM.PROGRESS_INFO_KEY
M.RES_STATE_INFOS = RTM.INFO_TYPE_KEY
M.UPDATE_INFO_KEY = RTM.UPDATE_INFO_KEY
M.USING_RES_INFO_KEY = RTM.USING_RES_STATE_INFO_KEY
M.FILE_LIST_ITEM_KEY = RTM.FILE_LIST_ITEM_KEY
M.NAMESPACE_UPDATE_OPTIONS = END.NAMESPACE_UPDATE_OPTIONS
M.STORAGE_TYPE = RTM.STORAGE_TYPE

function M.check_namespace_res_update(namespace, res_key, params, opts, update_cb)
  _ejoysdk.log("check_namespace_res_update")
  ER.check_namespace_res_update(namespace, res_key, params, opts, update_cb)
end

function M.confirm_update_namespace_res(namespace, res_key, res_ver, params, opts, complete_cb, on_res_state_change_listener, on_res_progress_change_listener)
  ER.confirm_update_namespace_res(namespace, res_key, res_ver, params, opts, complete_cb, on_res_state_change_listener, on_res_progress_change_listener)
end

local function get_check_update_res_info_keystore(namespace, res_key)
  custom_keystore_cache[namespace] = custom_keystore_cache[namespace] or {}
  if not custom_keystore_cache[namespace][res_key] then
    custom_keystore_cache[namespace][res_key] = E.LazyKeyStore:New("UPDATE_RES_INFO_" .. tostring(namespace) .. "_" .. tostring(res_key), false, true, false)
  end
  return custom_keystore_cache[namespace][res_key]
end

function M.get_check_update_res_info_cache(namespace, res_key)
  local ks = get_check_update_res_info_keystore(namespace, res_key)
  do return ks.get end
  return ks.get, ks
end

function M.check_and_update(namespace, res_info, opts, listeners)
  local res_key = res_info.res_key
  local engine_handler = res_info.engine_handler or {}
  listeners = listeners or {}
  opts = opts or {}
  local local_res_state = RTM.static_get_local_res_state(namespace, res_key) or {}
  local using_res_info = local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  local local_res_version = res_info.version or using_res_info.version
  E.LOG.debug(TAG, "check_and_update local_res_version is >>> " .. tostring(local_res_version))
  local params = {
    using_res_info = {version = local_res_version}
  }
  local on_confirm_res_update = listeners.on_confirm_res_update
  local on_confirm_res_apply = listeners.on_confirm_res_apply
  local on_res_download_progress_change_listener = listeners.on_res_download_progress_change_listener or function()
  end
  local on_res_update_complete = listeners.on_res_update_complete or function()
  end
  local on_res_apply_progress_change_listener = listeners.on_res_apply_progress_change_listener or function()
  end
  local on_res_apply = engine_handler.on_res_apply
  local on_request_file_list = engine_handler.on_request_file_list
  local on_process_file_list
  opts.is_v2_facade = false
  local apply_dest_path = ERB.get_target_res_save_full_path(res_info.res_save_base_path, res_info.res_save_storage_type)
  if nil == on_res_apply then
    E.LOG.debug(TAG, "check_and_update, custom engine_handler is nil, NOT set res_save_base_path and res_save_storage_type")
    
    function on_res_apply(_engine_context, _res_location, apply_cb, _progress_cb)
      E.LOG.debug(TAG, "check_and_update default group engine handler on_res_apply begin, res_location:" .. tostring(_res_location) .. ", apply_dest_path:" .. tostring(apply_dest_path))
      DGH.on_res_apply(_engine_context, _res_location, apply_dest_path, apply_cb, _progress_cb)
    end
    
    on_process_file_list = DGH.on_process_file_list
    opts.engine_handler = DGH
    opts.is_v2_facade = true
  elseif engine_handler == DGH or engine_handler == DEH then
    E.LOG.debug(TAG, "check_and_update, engine_handler is sdk default, NOT set res_save_base_path and res_save_storage_type")
    
    function on_res_apply(_engine_context, _res_location, apply_cb, _progress_cb)
      E.LOG.debug(TAG, "check_and_update game custom use sdk default engine handler on_res_apply begin, res_location:" .. tostring(_res_location) .. ", apply_dest_path:" .. tostring(apply_dest_path))
      engine_handler.on_res_apply(_engine_context, _res_location, apply_dest_path, apply_cb, _progress_cb)
    end
    
    on_process_file_list = engine_handler.on_process_file_list
    opts.engine_handler = engine_handler
    opts.is_v2_facade = true
  else
    E.LOG.debug(TAG, "check_and_update, has custom engine_handler, need set res_save_base_path and res_save_storage_type")
    opts[M.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_BASE_PATH] = res_info.res_save_base_path
    opts[M.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_STORAGE_TYPE] = res_info.res_save_storage_type
    opts.listeners = {on_request_file_list = on_request_file_list}
  end
  res_info_cache[res_key] = res_info
  res_info_cache[res_key].engine_handler = {
    on_request_file_list = on_request_file_list,
    on_process_file_list = on_process_file_list,
    on_res_apply = function(engine_context, res_location, _apply_dest_path, apply_cb, progress_cb)
      on_res_apply(engine_context, res_location, apply_cb, progress_cb)
    end
  }
  local _cache_res_info = {
    res_key = res_key,
    pkg_res_path = res_info.pkg_res_path,
    res_save_base_path = res_info.res_save_base_path,
    res_save_storage_type = res_info.res_save_storage_type
  }
  local ks = get_check_update_res_info_keystore(namespace, res_key)
  ks:set(_cache_res_info)
  _ejoysdk.log("check_and_update opts>>")
  E.log(opts)
  opts.update_update_infos = true
  local force_check_update = opts.force_check_update or false
  if nil == on_confirm_res_update then
    function on_confirm_res_update(_res_info, confirm_cb)
      confirm_cb(true)
    end
  end
  local download_state = RTM.PUBLIC_DOWNLOAD_STATE.UNKNOWN
  local download_progress_info = {
    [RTM.PROGRESS_INFO_KEY.PERCENT] = 0,
    [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = 0,
    [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = 0,
    [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = 0,
    [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = 0,
    [RTM.PROGRESS_INFO_KEY.SPEED] = 0
  }
  local res_src_model = EMF.get_ejoy_res_source_model(namespace, res_key, opts)
  ER.check_namespace_res_update(namespace, res_key, params, opts, function(succ, ...)
    if succ then
      local is_update_info_exists, has_update, update_res_info, namespace_ext = ...
      namespace_ext_cache = namespace_ext
      E.LOG.debug(TAG, "check_and_update check_namespace_res_update>>>>")
      E.LOG.debug(TAG, update_res_info)
      update_res_info = update_res_info or {}
      local res_update_info = update_res_info[M.RES_STATE_INFOS.TYPE_RES_UPDATE_STATE] or {}
      local server_update_info = res_update_info.update_body or {}
      local custom_update_infos = custom_update_infos_cache:get() or {}
      local ns_custom_update_infos = custom_update_infos[namespace] or {}
      custom_update_infos[namespace] = ns_custom_update_infos
      ns_custom_update_infos[res_key] = server_update_info
      custom_update_infos_cache:set(custom_update_infos)
      if is_update_info_exists and (has_update or force_check_update) then
        local simple_res_state_info = ER.get_simple_res_state(update_res_info)
        E.LOG.debug(TAG, "check_and_update has update info simple_res_state_info>>>")
        E.log(simple_res_state_info)
        on_confirm_res_update(simple_res_state_info, function(confirm_download)
          E.LOG.debug(TAG, "check_and_update on_confirm_res_update result:" .. tostring(confirm_download) .. ", res_key:" .. tostring(res_key))
          update_res_info = update_res_info or {}
          local update_info = update_res_info[M.RES_STATE_INFOS.TYPE_RES_UPDATE_STATE] or {}
          if confirm_download then
            local update_ver = update_info[M.UPDATE_INFO_KEY.VERSION_NAME]
            RS.stat_update_wait_confirm(namespace, res_key, update_ver, local_res_version or "", opts.stat_is_upload_now)
            RS.stat_on_res_update_downloading(namespace, res_key, local_res_version or "", opts.stat_is_upload_now)
            E.LOG.debug(TAG, "check_and_update confirm update version:" .. tostring(update_ver))
            local opt_ext = opts.ext or {}
            local ext = {
              p1 = server_update_info.packKey or "",
              p2 = local_res_version,
              p3 = update_ver or ""
            }
            local utils = require("ejoysdk_lua.ejoysdk_utils")
            ext = utils.merge_table(ext, opt_ext)
            opts.ext = ext
            M.confirm_update_namespace_res(namespace, res_key, update_ver, params, opts, function(confirm_succ, ...)
              E.LOG.debug(TAG, "check_and_update confirm_update_namespace_res result:" .. tostring(confirm_succ) .. ", res_key:" .. tostring(res_key))
              if confirm_succ then
                RS.stat_on_res_update_download_complete(namespace, res_key, local_res_version, opts.stat_is_upload_now)
                local res_state_infos = (...)
                local res_location = res_state_infos.res_downloading_info.res_location
                local engine_context = {
                  download_res_files = function(file_path_list, _opts, complete_cb, state_listener, progress_listener)
                    ER.download_res_files(namespace, res_key, update_ver, file_path_list, _opts, complete_cb, state_listener, progress_listener)
                  end,
                  is_group = false,
                  get_res_info = function()
                    return namespace, res_key, res_info
                  end
                }
                RS.stat_on_res_update_applying(namespace, res_key, local_res_version, opts.stat_is_upload_now)
                E.LOG.debug(TAG, "check_and_update on_res_apply begin, res_location:" .. tostring(res_location))
                
                local function on_res_apply_call()
                  E.LOG.debug(TAG, "check_and_update on_res_apply begin, res_key:" .. tostring(res_key))
                  on_res_apply(engine_context, res_location, function(apply_result, ...)
                    E.LOG.debug(TAG, "check_and_update on_res_apply result:" .. tostring(apply_result) .. ", res_key:" .. tostring(res_key))
                    if apply_result then
                      ER.publish_using_res_version(namespace, res_key, update_ver)
                      RS.stat_on_res_update_complete(namespace, res_key, local_res_version, opts.stat_is_upload_now)
                      on_res_update_complete(true, true)
                      local remove_downloading_dir = (...)
                      if remove_downloading_dir then
                        E.LOG.debug(TAG, "remove_downloading_dir: ns: " .. tostring(namespace) .. ", rk: " .. tostring(res_key))
                        res_src_model:remove_res(update_ver)
                      end
                    else
                      local code, msg = ...
                      RS.stat_on_res_update_fail(namespace, res_key, code, msg, UT.PUB_STATES.APPLY_FAILED, local_res_version, opts.stat_is_upload_now)
                      on_res_update_complete(false, code, msg)
                    end
                  end, function(state, progress_info)
                    on_res_apply_progress_change_listener(state, progress_info)
                  end)
                end
                
                if on_confirm_res_apply then
                  E.LOG.debug(TAG, "check_and_update wait on_confirm_res_apply result, res_key:" .. tostring(res_key))
                  on_confirm_res_apply(function()
                    E.LOG.debug(TAG, "check_and_update on_confirm_res_apply result confirmed, res_key:" .. tostring(res_key))
                    on_res_apply_call()
                  end)
                else
                  on_res_apply_call()
                end
              else
                local confirm_res_update_err_code, confirm_res_update_err_msg = ...
                RS.stat_on_res_update_fail(namespace, res_key, confirm_res_update_err_code, confirm_res_update_err_msg, UT.PUB_STATES.DOWNLOAD_FAILED, local_res_version, opts.stat_is_upload_now)
                on_res_update_complete(false, confirm_res_update_err_code, confirm_res_update_err_msg)
              end
            end, function(_ns, _rk, state, _state_obj)
              download_state = state
              on_res_download_progress_change_listener(download_state, download_progress_info)
            end, function(_ns, _rk, progress_info)
              download_progress_info = progress_info
              on_res_download_progress_change_listener(download_state, download_progress_info)
            end)
          else
            on_res_update_complete(true, false)
          end
        end)
      else
        on_confirm_res_update(ER.get_simple_res_state(update_res_info), function()
        end)
        on_res_update_complete(true, false)
      end
    else
      local check_res_update_err_code, check_res_update_err_msg = ...
      RS.stat_on_res_update_fail(namespace, res_key, check_res_update_err_code, check_res_update_err_msg, UT.PUB_STATES.IDLE, local_res_version, opts.stat_is_upload_now)
      on_res_update_complete(false, check_res_update_err_code, check_res_update_err_msg)
    end
  end)
end

function M.group_res_update(namespace, res_key, group_name, opts, listeners)
  local custom_update_infos = custom_update_infos_cache:get() or {}
  local ns_custom_update_infos = custom_update_infos[namespace] or {}
  local rk_custom_update_info = ns_custom_update_infos[res_key] or {}
  local UIM = require("ejoysdk_lua.res.update_info_manager")
  UIM.add_update_info(namespace, res_key, rk_custom_update_info)
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  opts = opts or {}
  local rk_info_cache = res_info_cache[res_key] or {}
  local engine_handler = rk_info_cache.engine_handler or {}
  local group_res_info = {
    engine_handler = engine_handler,
    res_save_base_path = rk_info_cache.res_save_base_path,
    res_save_storage_type = rk_info_cache.res_save_storage_type,
    namespace_ext = namespace_ext_cache
  }
  opts.is_v2_facade = true
  GRM.group_res_update(namespace, res_key, group_name, group_res_info, opts, listeners)
end

function M.get_res_state(_namespace, _res_key, info_flags)
  do return ER.get_res_state, _namespace, _res_key end
  return ER.get_res_state, _namespace, _res_key, info_flags
end

function M.get_simple_res_state(_namespace, _res_key)
  local res_state_info = ER.get_res_state(_namespace, _res_key)
  local simple_res_state_info = ER.get_simple_res_state(res_state_info)
  return simple_res_state_info
end

return M

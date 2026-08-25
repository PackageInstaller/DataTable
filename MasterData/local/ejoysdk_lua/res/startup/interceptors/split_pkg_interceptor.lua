local E = require("ejoysdk_lua.ejoysdk")
local BASE_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.base_interceptor")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local RC = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_check")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ER_FILE_INFO_CACHE = require("ejoysdk_lua.res.ejoysdk_res_file_list_cache")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local SPV = require("ejoysdk_lua.vendors.splitpkg")
local TA = require("ejoysdk_lua.res.model.task_download_agent")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local SPLIT_PKG_INTERCEPTOR = "SPLIT_PKG_INTERCEPTOR"
local M = BASE_INTERCEPTOR:New(SPLIT_PKG_INTERCEPTOR)
local TAG = SPLIT_PKG_INTERCEPTOR
local QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED = E.LazyKeyStore:New("QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED", false, false, false)
local QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE = E.LazyKeyStore:New("QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE", false, false, false)
local RES_BUILTIN_PATH = "ejoysdk_split_pkg_res"
local SPLIT_PKG_KEY = {
  SPLIT_PKG_CONFIG = "ej_qz_split_pkg_config.json",
  SPLIT_PKG_FILE_LIST = "ejoy_qz_local_resource_file_list.json",
  SPLIT_PKG_REMOVED_LIST = "ejoy_qz_removed_resource_file_list.json"
}
local split_pkg_update_result = true
local split_pkg_update_err_code, split_pkg_update_err_msg
local split_pkg_running = false
local m_split_pkg_config, local_res_config_cache, m_is_split_pkg
local game_res_info_cache = {}
local m_game_apply_dest_path, m_game_apply_dest_path_rela
local m_last_progress_info = {
  downloading_size = 0,
  finish_count = 0,
  version = ""
}
local m_last_save_progress_time = 0
local m_progress_keystore_cache = {}

function M.is_split_pkg()
  if type(m_is_split_pkg) == "boolean" then
    return m_is_split_pkg
  end
  local sub_pkg_config_file = RES_BUILTIN_PATH .. "/" .. SPLIT_PKG_KEY.SPLIT_PKG_CONFIG
  local sub_pkg_config_content = _ejoysdk.lread(sub_pkg_config_file)
  local has_small_pkg_config = nil ~= sub_pkg_config_content
  local sdk_infos = UNI.get_sdk_infos()
  local has_splitpkg_plugin = nil ~= sdk_infos.SPLITPKG
  m_is_split_pkg = has_small_pkg_config and has_splitpkg_plugin
  E.LOG.debug(TAG, "qz split pkg: " .. tostring(m_is_split_pkg) .. ", has_small_pkg_config: " .. tostring(has_small_pkg_config) .. ", has_splitpkg_plugin: " .. tostring(has_splitpkg_plugin))
  return m_is_split_pkg
end

local function is_split_res_downloaded()
  local _is_peel_res_downloaded = QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED:get()
  E.LOG.debug(TAG, "is_peel_res_downloaded is " .. tostring(_is_peel_res_downloaded))
  if nil == _is_peel_res_downloaded then
    QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED:set("false")
    return false
  end
  return "true" == _is_peel_res_downloaded
end

local function init_split_pkg_config()
  if nil == m_split_pkg_config then
    local split_pkg_config_file = RES_BUILTIN_PATH .. "/" .. SPLIT_PKG_KEY.SPLIT_PKG_CONFIG
    local sub_pkg_config_content = _ejoysdk.lread(split_pkg_config_file)
    m_split_pkg_config = JSON.decode(sub_pkg_config_content) or {}
  end
  E.LOG.debug(TAG, "split_pkg_config is:")
  E.log(m_split_pkg_config)
  return m_split_pkg_config
end

local function set_peel_res_downloaded_flag(flag)
  QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED:set(tostring(flag))
end

local function set_override_install_handle_complete(flag)
  QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE:set(tostring(flag))
end

local function is_override_handle_complete()
  local _is_override_handle_complete = QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE:get()
  E.LOG.debug(TAG, "is_override_handle_complete is " .. tostring(_is_override_handle_complete))
  if nil == _is_override_handle_complete then
    return true
  end
  return "true" == _is_override_handle_complete
end

local function get_res_local_params(res_key)
  local local_res_params = SC.get_startup_local_res_infos_cache()
  local ns_local_res_params = local_res_params[ECC.NAMESPACE.QZ_PATCH] or {}
  local rk_local_res_params = ns_local_res_params[res_key] or {}
  return rk_local_res_params
end

local function escape_pattern(pattern)
  do return string.gsub, pattern, "([%-%.%+%*%?%[%]%^%$%(%)%#%%])" end
  return string.gsub, pattern, "([%-%.%+%*%?%[%]%^%$%(%)%#%%])", "%%%1"
end

local function get_game_apply_dest_path(res_key)
  if m_game_apply_dest_path then
    return m_game_apply_dest_path, m_game_apply_dest_path_rela
  end
  local rk_local_res_params = get_res_local_params(res_key)
  m_game_apply_dest_path = ER_UTILS.get_apply_dest_path(rk_local_res_params.res_save_storage_type, rk_local_res_params.res_save_base_path)
  local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
  local raw_storage_type = ER_UTILS.try_get_storage_type(rk_local_res_params.res_save_storage_type, rk_local_res_params.res_save_base_path)
  local save_storage_root_path = ERB.static_get_storage_path_by_type(raw_storage_type)
  m_game_apply_dest_path_rela = rk_local_res_params.res_save_base_path
  if rk_local_res_params.res_save_storage_type == RTM.STORAGE_TYPE.EXTERNAL_OTHER and raw_storage_type ~= RTM.STORAGE_TYPE.EXTERNAL_OTHER then
    m_game_apply_dest_path_rela = m_game_apply_dest_path:gsub(escape_pattern(save_storage_root_path), "", 1)
    m_game_apply_dest_path_rela = E.Path.trim_begin_separator(m_game_apply_dest_path_rela)
  end
  E.LOG.debug(TAG, "get_game_apply_dest_path storage_type:" .. tostring(rk_local_res_params.res_save_storage_type) .. ", save_base_path:" .. tostring(rk_local_res_params.res_save_base_path) .. ", game_apply_dest_path:" .. tostring(m_game_apply_dest_path) .. ", save rela:" .. tostring(m_game_apply_dest_path_rela) .. ", param storage_type:" .. tostring(rk_local_res_params.res_save_storage_type) .. ", raw storage_type:" .. tostring(raw_storage_type) .. ", storage_path:" .. tostring(save_storage_root_path))
  return m_game_apply_dest_path, m_game_apply_dest_path_rela
end

local function get_local_res_config(res_key)
  if local_res_config_cache then
    return local_res_config_cache
  end
  local _game_apply_dest_path = get_game_apply_dest_path(res_key)
  local cache_file_name = RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_CONFIG
  local local_res_config_file_path = E.Path.join(_game_apply_dest_path, cache_file_name)
  local res_config = JSON.decode(E.File.readfile_fullpath(local_res_config_file_path)) or {}
  E.LOG.debug(TAG, "game_apply_dest_path is " .. tostring(_game_apply_dest_path) .. ", local_res_config is ")
  E.LOG.debug(TAG, res_config)
  local_res_config_cache = res_config
  return res_config
end

local function enable_missing_file_hook(enable)
  E.LOG.debug(TAG, "enable_missing_file_hook enable:" .. tostring(enable))
  SPV.enable_missing_res_hook(enable)
end

local function get_splitpkg_last_progress_keystore(res_key)
  local cache_key = "QZ_EJ_SPLIT_PKG_LAST_PROGRESS_INFO_" .. tostring(res_key)
  local keystore = m_progress_keystore_cache[cache_key]
  if not keystore then
    keystore = E.LazyKeyStore:New(cache_key, false, true, false)
    m_progress_keystore_cache[cache_key] = keystore
  end
  return keystore
end

local function on_download_progress_changed(res_key, res_version, progress_info)
  m_last_progress_info.downloading_size = progress_info[RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE]
  m_last_progress_info.finish_count = progress_info[RTM.PROGRESS_INFO_KEY.FINISH_COUNT]
  m_last_progress_info.version = res_version
  local current_time = E.system_clock()
  if current_time - m_last_save_progress_time > 5000 then
    m_last_save_progress_time = current_time
    E.LOG.debug(TAG, "on_download_progress_changed save progress>")
    E.log(m_last_progress_info)
    local keystore = get_splitpkg_last_progress_keystore(res_key)
    keystore:set(m_last_progress_info)
  end
end

local function get_last_download_progress_cache(res_key, res_version)
  if m_last_progress_info.downloading_size > 0 and m_last_progress_info.finish_count > 0 then
    return m_last_progress_info
  else
    local keystore = get_splitpkg_last_progress_keystore(res_key)
    local cache_info = keystore:get() or {}
    if next(cache_info) ~= nil then
      if cache_info.version ~= res_version then
        keystore:delete()
      else
        m_last_progress_info.downloading_size = cache_info.downloading_size or 0
        m_last_progress_info.finish_count = cache_info.finish_count or 0
        E.LOG.debug(TAG, "get_last_download_progress_cache for res_key:" .. tostring(res_key) .. ", res_version:" .. tostring(res_version) .. ", downloading_size:" .. tostring(m_last_progress_info.downloading_size) .. ", finish_count:" .. tostring(m_last_progress_info.finish_count))
      end
    end
    return m_last_progress_info
  end
end

local function check_res_complete()
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  init_split_pkg_config()
  local res_key = m_split_pkg_config.res_key
  local local_res_startup_params = get_res_local_params(res_key)
  local res_info = {
    namespace = ECC.NAMESPACE.QZ_PATCH,
    res_key = res_key,
    pkg_res_list_dir = local_res_startup_params.pkg_res_path or m_split_pkg_config.pkg_res_path
  }
  E.LOG.debug(TAG, "check_res_complete pkg_res_list_dir, startup:" .. tostring(local_res_startup_params.pkg_res_path) .. ", pkg_config:" .. tostring(m_split_pkg_config.pkg_res_path) .. ", final:" .. tostring(res_info.pkg_res_list_dir))
  local local_res_config = get_local_res_config(res_key)
  local res_current_version = local_res_config.version
  if not res_current_version then
    local local_res_state = RTM.static_get_local_res_state(ECC.NAMESPACE.QZ_PATCH, res_key) or {}
    local using_res_info = local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
    res_current_version = using_res_info.version
  end
  E.LOG.debug(TAG, "current res version is " .. tostring(res_current_version))
  local startup_requested_groups = {"default"}
  local GM = require("ejoysdk_lua.res.group_res_manager")
  local group_infos = GM.get_startup_group_infos()
  if next(group_infos) ~= nil then
    for ns, res_map in pairs(group_infos) do
      if ns == ECC.NAMESPACE.QZ_PATCH then
        for rk, ginfo in pairs(res_map) do
          if rk == res_key then
            for gn, _ in pairs(ginfo) do
              table.insert(startup_requested_groups, gn)
            end
          end
        end
      end
    end
  end
  E.LOG.debug(TAG, "startup_requested_groups is " .. tostring(table.concat(startup_requested_groups, ",")))
  ER.get_res_origin_file_list(ECC.NAMESPACE.QZ_PATCH, res_key, startup_requested_groups, function(target_file_list, ...)
    if target_file_list then
      local ext_info = (...)
      local origin_file_info = {
        base_path = ext_info.base_path,
        folder = ext_info.folder,
        index_file_md5 = ext_info.index_file_md5,
        file_list = target_file_list
      }
      E.LOG.debug(TAG, "check_res_complete get_res_origin_file_list file_list count:" .. tostring(#target_file_list))
      RC.hotfix_res_download_check(res_info, origin_file_info, {}, {}, nil, function(_succ, ...)
        local game_res_update_info = game_res_info_cache.update_info
        local multi_res_update_info = UTILS.deepcopy(game_res_update_info)
        multi_res_update_info.has_new_update = false
        if _succ then
          local down_origin, _ = ...
          local download_file_list = down_origin and down_origin.file_list or {}
          local list_count = #download_file_list
          E.LOG.debug(TAG, "hotfix_res_download_check, download_file_list count: " .. tostring(list_count))
          if list_count > 0 then
            local list_total_size = 0
            for _, item in ipairs(down_origin.file_list) do
              local item_size = item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] or 0
              list_total_size = list_total_size + item_size
            end
            local last_progress_info = get_last_download_progress_cache(res_key, res_current_version)
            local last_downloading_size = last_progress_info.downloading_size or 0
            local last_finish_count = last_progress_info.finish_count or 0
            E.log("local_res_state last_downloading_size:" .. tostring(last_downloading_size) .. ", last_finish_count:" .. tostring(last_finish_count))
            multi_res_update_info.total_size = list_total_size
            multi_res_update_info.total_count = list_count
            multi_res_update_info.remain_size = list_total_size - last_downloading_size
            multi_res_update_info.remain_count = list_count - last_finish_count
            multi_res_update_info.has_new_update = true
            
            local function confirm_cb_wrapper(confirm_result)
              if confirm_result then
                local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
                local multi_model = EMF.get_http_res_multi_model("splitpkg_" .. tostring(res_key))
                local game_res_state = ER.get_res_state(ECC.NAMESPACE.QZ_PATCH, res_key)
                local game_res_server_update_info = game_res_state.res_update_info or {}
                local game_res_update_body = game_res_server_update_info.update_body or {}
                local base_url = game_res_update_body.baseUrl
                local url_info = E.HTTP.parse(base_url)
                local url_prefix = url_info.scheme .. "://" .. url_info.host
                local folder = ext_info.folder
                local base_path = ext_info.base_path
                local _game_apply_dest_path, _game_apply_rela_path = get_game_apply_dest_path(res_key)
                local temp_dir_path, _relative_temp_dir_path = ER_UTILS.get_temp_dir_path(ECC.NAMESPACE.QZ_PATCH, res_key, _game_apply_dest_path, "splitpkg")
                local temp_dir_exist = E.File.exists(temp_dir_path, true)
                if not temp_dir_exist then
                  local mkdir_succ = E.File.make_dirs(temp_dir_path)
                  if not mkdir_succ then
                    E.LOG.warn(TAG, "download temp dir not exists, and create failed, download failed and return:" .. tostring(temp_dir_path))
                    split_pkg_update_result = false
                    split_pkg_update_err_code = EC.PATCH_ERROR.CODE_MAKE_TEMP_DIR_ERROR
                    split_pkg_update_err_msg = "make temp dir error, temp dir path is " .. tostring(temp_dir_path)
                    game_res_info_cache.confirm_cb(false)
                    return
                  else
                    E.LOG.debug(TAG, "download temp dir not exists, and create succ:" .. tostring(temp_dir_path))
                  end
                else
                  E.LOG.debug(TAG, "download temp dir already exists, continue download: " .. tostring(temp_dir_path))
                end
                E.LOG.debug(TAG, "download file dest path is " .. tostring(temp_dir_path))
                local download_list = ER_UTILS.to_model_download_list_format(download_file_list, folder, base_path, temp_dir_path)
                local file_ext = {
                  base_url = url_prefix,
                  total_size = list_total_size,
                  dest_parent_path = temp_dir_path
                }
                local opts = {
                  storage_type = RTM.STORAGE_TYPE.EXTERNAL_OTHER
                }
                local check_res_download_state = "idle"
                local task, code, msg = multi_model:create_task(download_list, file_ext, opts, function(_state, _state_obj)
                end, function(progress_info)
                  if progress_info and progress_info.downloading_size then
                    on_download_progress_changed(res_key, res_current_version, progress_info)
                    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_download_progress_change_listener, check_res_download_state, progress_info)
                  end
                end)
                if task then
                  local download_strategy = ER.get_download_strategy(ECC.NAMESPACE.QZ_PATCH, res_key)
                  E.LOG.debug(TAG, "before download agent, download_strategy:" .. tostring(download_strategy))
                  local task_agent = TA:New(task, download_strategy, function(agent_state, agent_state_info)
                    if agent_state == TA.AGENT_STATE.COMPLETE then
                      E.LOG.debug(TAG, "download complete")
                      check_res_download_state = agent_state
                      local move_map = {}
                      local move_info_map = {}
                      for _, item in ipairs(download_file_list) do
                        local source_path = E.Path.join(temp_dir_path, item.to)
                        local target_path = E.Path.join(_game_apply_dest_path, item.to)
                        move_map[source_path] = target_path
                        move_info_map[item.to] = item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5]
                      end
                      END.dispatch_confirm_res_apply(ECC.NAMESPACE.QZ_PATCH, res_key, function()
                        ER_UTILS.batch_move_res_file(_game_apply_dest_path, move_map, move_info_map, function(move_succ, ...)
                          if move_succ then
                            ER_FILE_INFO_CACHE.update_using_file_list_cache(ECC.NAMESPACE.QZ_PATCH, res_key, nil, res_current_version, _game_apply_dest_path, {}, function()
                              ER_FILE_INFO_CACHE.update_using_res_config(_game_apply_dest_path, res_current_version, ext_info.base_path, ext_info.folder)
                              set_override_install_handle_complete(true)
                              set_peel_res_downloaded_flag(true)
                              game_res_info_cache.confirm_cb(false)
                            end)
                            E.LOG.debug(TAG, "download and move succ, now disable missing file hook")
                            enable_missing_file_hook(false)
                          else
                            split_pkg_update_result = false
                            local err_code, err_msg = ...
                            split_pkg_update_err_code = err_code
                            split_pkg_update_err_msg = err_msg
                            game_res_info_cache.confirm_cb(false)
                          end
                        end)
                      end)
                    elseif agent_state == TA.AGENT_STATE.FAILED then
                      local _code = agent_state_info[EMM.STATE_KEY.ERR_CODE] or 0
                      local _msg = agent_state_info[EMM.STATE_KEY.ERR_MSG]
                      E.LOG.warn(TAG, "download failed, code:" .. tostring(_code) .. ", msg：" .. tostring(_msg))
                      check_res_download_state = agent_state
                      split_pkg_update_err_code = _code
                      split_pkg_update_err_msg = _msg
                      split_pkg_update_result = false
                      game_res_info_cache.confirm_cb(false)
                    elseif agent_state then
                      E.LOG.debug(TAG, "download state:" .. tostring(agent_state))
                      check_res_download_state = agent_state
                    end
                  end)
                  task_agent:open()
                  local missing_hook_list_info = {
                    list = {},
                    game_save_base_dir = _game_apply_dest_path,
                    game_save_base_dir_rela = _game_apply_rela_path
                  }
                  local missing_res_list = missing_hook_list_info.list
                  for _, down_item in ipairs(download_list) do
                    local _item_to = down_item[RTM.FILE_LIST_ITEM_KEY.KEY_TO]
                    missing_res_list[_item_to] = {
                      dest = down_item[RTM.MULTI_TASK_INFO_KEY.KEY_DEST_PATH] .. down_item[RTM.MULTI_TASK_INFO_KEY.KEY_NAME]
                    }
                  end
                  SPV.set_res_update_infos(missing_hook_list_info)
                else
                  E.LOG.debug(TAG, "create_task failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
                  split_pkg_update_err_code = code
                  split_pkg_update_err_msg = msg
                  split_pkg_update_result = false
                  game_res_info_cache.confirm_cb(false)
                end
              else
                game_res_info_cache.confirm_cb(false)
              end
            end
            
            _ejoysdk.log("split_pkg_interceptor, download file list count: " .. tostring(list_count) .. ", total size: " .. tostring(multi_res_update_info.total_size / 1024 / 1024) .. " MB")
            E.log(multi_res_update_info)
            M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_confirm_res_update, multi_res_update_info, confirm_cb_wrapper)
          else
            local function confirm_cb_wrapper(confirm_result)
              game_res_info_cache.confirm_cb(confirm_result)
            end
            
            M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_confirm_res_update, multi_res_update_info, confirm_cb_wrapper)
          end
        else
          local err_code, err_msg = ...
          END.notify_startup_update_complete(false, err_code, err_msg)
        end
      end)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "get origin file list failed, code: " .. tostring(code) .. ", msg: " .. tostring(msg))
      END.notify_startup_update_complete(false, code, msg)
    end
  end)
end

local function check_split_pkg_update(res_update_info, confirm_cb)
  E.LOG.debug(TAG, "check_split_pkg_update, received")
  game_res_info_cache.update_info = res_update_info
  E.LOG.debug(TAG, "game res update info is ")
  E.LOG.debug(TAG, res_update_info)
  game_res_info_cache.confirm_cb = confirm_cb
  check_res_complete()
end

function M.on_splitpkg_res_update_complete(update_result, ...)
  if not split_pkg_update_result then
    E.LOG.error(TAG, "on_splitpkg_res_update_complete split_pkg_update_result is false, split_pkg_update_err_code: " .. tostring(split_pkg_update_err_code) .. ", split_pkg_update_err_msg: " .. tostring(split_pkg_update_err_msg))
    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_splitpkg_res_update_complete, split_pkg_update_result, split_pkg_update_err_code, split_pkg_update_err_msg)
  else
    E.LOG.error(TAG, "on_splitpkg_res_update_complete split_pkg_update_result is true")
    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_splitpkg_res_update_complete, update_result, ...)
  end
end

function M.on_confirm_res_update(res_update_info, confirm_cb)
  E.LOG.debug(TAG, "on_confirm_res_update received, reset update result first")
  split_pkg_update_result = true
  split_pkg_update_err_code = 0
  split_pkg_update_err_msg = nil
  check_split_pkg_update(res_update_info, confirm_cb)
end

function M.on_res_repair(_save_storage_type, _apply_dest_path)
  E.LOG.debug(TAG, "call split pkg on_res_repair >>>>>")
  QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED:set("false")
  QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE:set("false")
end

function M.enable_interceptor()
  local SU = require("ejoysdk_lua.res.startup.startup_utils")
  if SU.is_override_install_startup() then
    set_override_install_handle_complete(false)
  end
  if not split_pkg_running then
    E.LOG.debug(TAG, "enable_interceptor: false, splitpkg not running")
    return false
  end
  local enable = false
  if M.is_split_pkg() then
    if not is_split_res_downloaded() then
      enable = true
    elseif SU.is_override_install_startup() then
      set_override_install_handle_complete(false)
      enable = true
    elseif not is_override_handle_complete() then
      enable = true
    end
  end
  E.LOG.debug(TAG, "sub_pkg_interceptor enable: " .. tostring(enable))
  return enable
end

function M.set_splitpkg_update_running()
  E.LOG.debug(TAG, "set_splitpkg_update_running true")
  split_pkg_running = true
end

function M.is_split_running()
  return split_pkg_running
end

function M.is_split_pkg_downloaded()
  do return end
  return is_split_res_downloaded, nil
end

function M.set_override_install_handle_complete(enable)
  E.LOG.debug(TAG, "set_override_install_handle_complete received:" .. tostring(enable))
  set_override_install_handle_complete(enable)
end

function M.get_removed_res_list()
  if not M.is_split_pkg() then
    E.LOG.debug(TAG, "get_removed_res_list, not is split pkg, just return empty list")
    return {}
  end
  init_split_pkg_config()
  local pkg_res_path = m_split_pkg_config.pkg_res_path
  local pkg_res_file_path = E.Path.join(pkg_res_path, SPLIT_PKG_KEY.SPLIT_PKG_REMOVED_LIST)
  E.LOG.d(TAG, "pkg_res_file_path=" .. pkg_res_file_path)
  local removed_list = JSON.decode(E.File.readfile(pkg_res_file_path, true)) or {}
  E.LOG.debug(TAG, "get_removed_res_list received, pkg_res_path:" .. tostring(pkg_res_path) .. ", pkg_res_file_path:" .. tostring(pkg_res_file_path))
  return removed_list
end

function M.get_pkg_res_path(_res_key)
  init_split_pkg_config()
  local res_key = _res_key or m_split_pkg_config.res_key
  local local_res_startup_params = get_res_local_params(res_key)
  return local_res_startup_params.pkg_res_path or m_split_pkg_config.pkg_res_path
end

function M.check_pkg_res_path()
  init_split_pkg_config()
  local res_key = m_split_pkg_config.res_key
  local local_res_startup_params = get_res_local_params(res_key)
  local startup_pkg_res_path = local_res_startup_params.pkg_res_path
  startup_pkg_res_path = E.Path.trim_end_separator(startup_pkg_res_path)
  local config_pkg_res_path = m_split_pkg_config.pkg_res_path
  config_pkg_res_path = E.Path.trim_end_separator(config_pkg_res_path)
  local path_valid = not startup_pkg_res_path and config_pkg_res_path or startup_pkg_res_path and config_pkg_res_path and startup_pkg_res_path == config_pkg_res_path
  return path_valid, startup_pkg_res_path, config_pkg_res_path
end

function M.get_split_pkg_config()
  local split_cfg = init_split_pkg_config() or {}
  return split_cfg
end

function M._test_mock_builtin_path(path)
  RES_BUILTIN_PATH = path
end

return M

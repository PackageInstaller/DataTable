local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local RC = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_check")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local SPV = require("ejoysdk_lua.vendors.splitpkg")
local TA = require("ejoysdk_lua.res.model.task_download_agent")
local DPTM = require("ejoysdk_lua.res.model.strategies.ejoy_download_priority_task_manager")
local UIM = require("ejoysdk_lua.res.update_info_manager")
local RES_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
local FLOATER = require("ejoysdk_lua.res.splitpkg.presenters.ejoy_res_splitpkg_presenter")
local ST = require("ejoysdk_lua.res.model.strategies.network_strategy")
local M = {}
local TAG = "SPLITPKG#" .. EM.MODULE.RES .. "splitpkg_res_manager"
local QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED = E.LazyKeyStore:New("QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED", false, false, false)
local QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE = E.LazyKeyStore:New("QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE", false, false, false)
local QZ_EJ_SPLIT_PKG_NETWORK_STRATEGY = E.LazyKeyStore:New("QZ_EJ_SPLIT_PKG_NETWORK_STRATEGY", false, false, false)
local RES_BUILTIN_PATH = "ejoysdk_split_pkg_res"
local SPLIT_PKG_KEY = {
  SPLIT_PKG_CONFIG = "ej_qz_split_pkg_config.json",
  SPLIT_PKG_FILE_LIST = "ejoy_qz_local_resource_file_list.json",
  SPLIT_PKG_REMOVED_LIST = "ejoy_qz_removed_resource_file_list.json"
}
local m_is_split_pkg, m_split_pkg_config, m_split_removed_res, m_task_agent

local function set_peel_res_downloaded_flag(flag)
  QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED:set(tostring(flag))
end

local function set_override_install_handle_complete(flag)
  QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE:set(tostring(flag))
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

local function is_override_handle_complete()
  local _is_override_handle_complete = QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE:get()
  E.LOG.debug(TAG, "is_override_handle_complete is " .. tostring(_is_override_handle_complete))
  if nil == _is_override_handle_complete then
    return true
  end
  return "true" == _is_override_handle_complete
end

local function start_download()
  if m_task_agent and m_task_agent:get_state() ~= TA.AGENT_STATE.COMPLETE then
    E.LOG.d(TAG, "start_downoad")
    m_task_agent:open()
  end
end

local function on_strategy_changed(download_strategy)
  if download_strategy then
    E.LOG.d(TAG, "update strategy:" .. download_strategy)
    if m_task_agent then
      m_task_agent:update_strategy(download_strategy)
      local _strategy = m_task_agent:get_strategy()
      if UTIL.is_text_empty(_strategy) then
        QZ_EJ_SPLIT_PKG_NETWORK_STRATEGY:delete()
      else
        QZ_EJ_SPLIT_PKG_NETWORK_STRATEGY:set(_strategy)
      end
    end
  end
end

function M.check_split_res_status()
  local SU = require("ejoysdk_lua.res.startup.startup_utils")
  if SU.is_override_install_startup() then
    set_override_install_handle_complete(false)
  end
end

function M.can_split_res_update()
  return not is_split_res_downloaded() or not is_override_handle_complete()
end

local _splitpkg_res_update

function M.spitpkg_res_update(namespace, res_key, _res_info, opts, listeners)
  E.LOG.debug(TAG, "splitpkg_res_update namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
  local _complete_cb = listeners.on_splitpkg_res_update_complete or function()
  end
  if not M.can_split_res_update() then
    E.LOG.debug(TAG, "no need to update")
    _complete_cb(true)
    return
  end
  if m_task_agent and m_task_agent:get_state() == TA.AGENT_STATE.DOWNLOADING then
    _complete_cb(false, EC.SPLIT_PKG_CODE.RES_SPLITPKG_DOWNLOADING, "downloading")
    return
  end
  local path_valid, startup_pkg_res_path, config_pkg_res_path = M.check_pkg_res_path()
  if not path_valid then
    E.LOG.warn(TAG, "spitpkg_res_update failed, startup pkg_res_path not equals with config pkg_res_path, startup_pkg_res_path:" .. tostring(startup_pkg_res_path) .. ", config_pkg_res_path:" .. tostring(config_pkg_res_path))
    _complete_cb(false, EC.SPLIT_PKG_CODE.PKG_RES_PATH_INVALID, "split pkg pkg res path not valid")
    return
  end
  local emf = require("ejoysdk_lua.res.ejoy_res_model_factory")
  emf.clear_ejoy_res_source_model(namespace, res_key)
  local sl = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
  sl.reset_file_list_cache()
  local EI = require("ejoysdk_lua.ejoysdk_init")
  local public_product_code = EI.get_public_product_code()
  SC.update_public_product_code(public_product_code)
  local qz_product_code = opts.qz_product_code or public_product_code
  SC.update_qz_product_code(qz_product_code)
  m_task_agent = nil
  FLOATER.destroy()
  _splitpkg_res_update(listeners)
end

function M.is_local_res_complete()
  local is_complete = true
  local is_split_pkg = M.is_split_pkg()
  local is_res_downloaded
  if is_split_pkg then
    is_res_downloaded = is_split_res_downloaded()
    is_complete = is_res_downloaded
  end
  E.LOG.debug(TAG, string.format("is_local_res_complete:%s,is_split_pkg:%s,is_res_download:%s", tostring(is_complete), tostring(is_split_pkg), tostring(is_res_downloaded)))
  return is_complete
end

function M.get_split_pkg_config()
  if nil == m_split_pkg_config then
    local split_pkg_config_file = RES_BUILTIN_PATH .. "/" .. SPLIT_PKG_KEY.SPLIT_PKG_CONFIG
    local sub_pkg_config_content = _ejoysdk.lread(split_pkg_config_file)
    m_split_pkg_config = JSON.decode(sub_pkg_config_content) or {}
  end
  E.LOG.debug(TAG, {
    split_pkg_config = m_split_pkg_config or "nil"
  })
  return m_split_pkg_config
end

function M.is_split_pkg()
  if type(m_is_split_pkg) == "boolean" then
    return m_is_split_pkg
  end
  local sdk_infos = UNI.get_sdk_infos()
  local support_splitpkg = sdk_infos.SPLITPKG ~= nil
  local has_pkg_config = false
  if support_splitpkg then
    local config = M.get_split_pkg_config()
    has_pkg_config = nil ~= config and nil ~= next(config)
  end
  m_is_split_pkg = support_splitpkg and has_pkg_config
  E.LOG.debug(TAG, "qz split pkg: " .. tostring(m_is_split_pkg) .. ", has_small_pkg_config: " .. tostring(has_pkg_config) .. ", has_splitpkg_plugin: " .. tostring(support_splitpkg))
  return m_is_split_pkg
end

local function enable_missing_file_hook(enable)
  E.LOG.debug(TAG, "enable_missing_file_hook enable:" .. tostring(enable))
  SPV.enable_missing_res_hook(enable)
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

local m_game_apply_dest_path, m_game_apply_dest_path_rela, m_game_apply_storage_type

local function get_game_apply_dest_path(res_key)
  if m_game_apply_dest_path then
    return m_game_apply_dest_path, m_game_apply_dest_path_rela, m_game_apply_storage_type
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
  m_game_apply_storage_type = raw_storage_type
  return m_game_apply_dest_path, m_game_apply_dest_path_rela, raw_storage_type
end

local local_res_config_cache

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

function M.get_removed_res_list()
  if not M.is_split_pkg() then
    E.LOG.debug(TAG, "get_removed_res_list, not is split pkg, just return empty list")
    return {}
  end
  if m_split_removed_res then
    return m_split_removed_res
  end
  local pkg_config = M.get_split_pkg_config()
  local pkg_res_path = pkg_config.pkg_res_path
  local pkg_res_file_path = E.Path.join(pkg_res_path, SPLIT_PKG_KEY.SPLIT_PKG_REMOVED_LIST)
  E.LOG.d(TAG, "pkg_res_file_path=" .. pkg_res_file_path)
  m_split_removed_res = JSON.decode(E.File.readfile(pkg_res_file_path, true)) or {}
  E.LOG.debug(TAG, "get_removed_res_list received, pkg_res_path:" .. tostring(pkg_res_path) .. ", pkg_res_file_path:" .. tostring(pkg_res_file_path))
  return m_split_removed_res
end

function M.get_pkg_res_path(_res_key)
  local split_pkg_config = M.get_split_pkg_config()
  local res_key = _res_key or split_pkg_config.res_key
  local local_res_startup_params = get_res_local_params(res_key)
  return local_res_startup_params.pkg_res_path or split_pkg_config.pkg_res_path
end

function M.check_pkg_res_path()
  local split_pkg_config = M.get_split_pkg_config()
  local res_key = split_pkg_config.res_key
  local local_res_startup_params = get_res_local_params(res_key)
  local startup_pkg_res_path = local_res_startup_params.pkg_res_path
  startup_pkg_res_path = E.Path.trim_end_separator(startup_pkg_res_path)
  local config_pkg_res_path = split_pkg_config.pkg_res_path
  config_pkg_res_path = E.Path.trim_end_separator(config_pkg_res_path)
  local path_valid = not startup_pkg_res_path and config_pkg_res_path or startup_pkg_res_path and config_pkg_res_path and startup_pkg_res_path == config_pkg_res_path
  return path_valid, startup_pkg_res_path, config_pkg_res_path
end

function _splitpkg_res_update(listeners)
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  local split_pkg_config = M.get_split_pkg_config()
  local res_key = split_pkg_config.res_key
  local local_res_startup_params = get_res_local_params(res_key)
  local res_info = {
    namespace = ECC.NAMESPACE.QZ_PATCH,
    res_key = res_key,
    pkg_res_list_dir = local_res_startup_params.pkg_res_path or split_pkg_config.pkg_res_path
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
  local all_ns_resources = ER.get_all_cached_namespace_resources()
  local ns_map = all_ns_resources[ECC.NAMESPACE.QZ_PATCH] or {}
  local GMR = require("ejoysdk_lua.res.group_res_manager")
  for _res_key, _res_info in pairs(ns_map) do
    if GMR.is_group(_res_key) and GMR.get_real_res_key(_res_key) == res_key then
      UTIL.insert_array(startup_requested_groups, GMR.get_group_name_by_task_key(_res_key))
    end
  end
  E.LOG.debug(TAG, "startup_requested_groups is " .. tostring(table.concat(startup_requested_groups, ",")))
  local _checking = false
  local _check_queue = 0
  local _check_apply
  local check_res_download_state = "idle"
  
  function _check_apply(download_dir, apply_dir, download_list_index, local_file_list_handler, check_cb)
    check_cb = check_cb or function()
    end
    if _checking then
      return
    end
    _checking = true
    _check_queue = _check_queue > 0 and _check_queue - 1 or 0
    local _current_state = check_res_download_state
    local DOWNLOAD_TASK = require("ejoysdk_lua.res.model.http_download_task")
    E.File.list_directory(download_dir, true, true, function(check_result)
      local move_map = {}
      local move_info_map = {}
      for _, item in ipairs(check_result) do
        local path = item.path
        if not E.Utils.end_with(path, DOWNLOAD_TASK.DOWNLOADING_FILE_SUFFIX) then
          local download_item = download_list_index[path]
          if download_item then
            local source_path = E.Path.join(download_dir, download_item.to)
            local target_path = E.Path.join(apply_dir, download_item.to)
            move_map[source_path] = target_path
            move_info_map[target_path] = download_item
          end
          E.LOG.d(TAG, "moving res:" .. path)
        end
      end
      ER_UTILS.batch_move_res_file(apply_dir, move_map, move_info_map, function(move_succ, ...)
        if move_succ then
          for _, download_item in pairs(move_info_map) do
            local_file_list_handler:add_file(download_item.to, download_item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5], download_item[RTM.MULTI_TASK_INFO_KEY.KEY_SIZE])
          end
          local_file_list_handler:save()
          check_cb(true, _current_state)
        else
          local err_code, err_msg = ...
          check_cb(false, _current_state, err_code, err_msg)
        end
        _checking = false
        if _check_queue > 0 then
          _check_apply(download_dir, apply_dir, download_list_index, local_file_list_handler, check_cb)
        end
      end)
    end)
  end
  
  local function _check_complete_apply(...)
    _check_queue = _check_queue + 1
    _check_apply(...)
  end
  
  local function _download_splitpkg_res(download_file_list, ext_info, cb)
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
        cb(false, EC.PATCH_ERROR.CODE_MAKE_TEMP_DIR_ERROR, "make temp dir error, temp dir path is " .. tostring(temp_dir_path))
        return
      else
        E.LOG.debug(TAG, "download temp dir not exists, and create succ:" .. tostring(temp_dir_path))
      end
    else
      E.LOG.debug(TAG, "download temp dir already exists, continue download: " .. tostring(temp_dir_path))
    end
    E.LOG.debug(TAG, "download file dest path is " .. tostring(temp_dir_path))
    local download_list, download_list_index = ER_UTILS.to_model_download_list_format(download_file_list, folder, base_path, temp_dir_path)
    local apply_dir_local_file_list_mgr = RES_FILE_LIST.static_get_file_list(_game_apply_dest_path, false)
    local file_ext = {
      base_url = url_prefix,
      total_size = ext_info.total_size,
      dest_parent_path = temp_dir_path
    }
    local opts = {
      storage_type = RTM.STORAGE_TYPE.EXTERNAL_OTHER,
      priority = DPTM.DOWNLOAD_PRIORITY.IMMEDIATE
    }
    
    local function _check_apply_cb(check_succ, check_state, ...)
      if check_succ then
        if check_state == TA.AGENT_STATE.COMPLETE then
          set_override_install_handle_complete(true)
          set_peel_res_downloaded_flag(true)
          E.LOG.debug(TAG, "download and move succ, now disable missing file hook")
          enable_missing_file_hook(false)
          cb(true)
        end
      else
        if m_task_agent then
          m_task_agent:close()
        end
        local err_code, err_msg = ...
        cb(false, err_code, err_msg)
      end
    end
    
    local function _floater_progress_update(_download_state, _download_state_obj, progress_info)
      if type(FLOATER.on_res_download_progress_change_listener) == "function" then
        E.LOG.d(TAG, {progress_info = progress_info})
        E.LOG.debug(TAG, "on_res_download_progress_change_listener, state:" .. tostring(_download_state) .. ", percent:" .. tostring((progress_info or {}).percent or "nil"))
        FLOATER.on_res_download_progress_change_listener(_download_state, _download_state_obj, progress_info)
      end
    end
    
    local _progress_info = {percent = 0}
    local _check_res_download_state_obj = {}
    local task, code, msg = multi_model:create_task(download_list, file_ext, opts, function(_state, _state_obj)
      check_res_download_state = _state
      _check_res_download_state_obj = _state_obj
    end, function(progress_info)
      if progress_info and progress_info.downloading_size then
        if type(listeners.on_res_download_progress_change_listener) == "function" then
          listeners.on_res_download_progress_change_listener(check_res_download_state, progress_info)
        end
        _progress_info = progress_info
        _floater_progress_update(check_res_download_state, _check_res_download_state_obj, progress_info)
        _check_apply(temp_dir_path, _game_apply_dest_path, download_list_index, apply_dir_local_file_list_mgr, _check_apply_cb)
      end
    end)
    if task then
      local _user_strategy = QZ_EJ_SPLIT_PKG_NETWORK_STRATEGY:get()
      E.LOG.debug(TAG, "before download agent, download_strategy:" .. tostring(_user_strategy))
      m_task_agent = TA:New(task, _user_strategy or ST.STRATEGY.WIFI_ONLY, function(agent_state, agent_state_info)
        E.LOG.d(TAG, {agent_state = agent_state})
        check_res_download_state = {}
        if agent_state == TA.AGENT_STATE.COMPLETE then
          check_res_download_state = agent_state
          on_strategy_changed(ST.STRATEGY.BOTH_MOBILE_WIFI_NETWORK)
          _check_complete_apply(temp_dir_path, _game_apply_dest_path, download_list_index, apply_dir_local_file_list_mgr, _check_apply_cb)
        elseif agent_state == TA.AGENT_STATE.FAILED then
          local _code = agent_state_info[EMM.STATE_KEY.ERR_CODE] or 0
          local _msg = agent_state_info[EMM.STATE_KEY.ERR_MSG]
          E.LOG.warn(TAG, "download failed, code:" .. tostring(_code) .. ", msg：" .. tostring(_msg))
          _check_res_download_state_obj = {code = _code, msg = _msg}
          check_res_download_state = agent_state
          cb(false, _code, _msg)
        elseif agent_state then
          E.LOG.debug(TAG, "download state:" .. tostring(agent_state))
          check_res_download_state = agent_state
        end
        _floater_progress_update(check_res_download_state, _check_res_download_state_obj, _progress_info)
      end)
      FLOATER.show_view({
        download_size = ext_info.total_size,
        user_strategy = _user_strategy
      }, {start_download = start_download, change_strategy = on_strategy_changed}, function(_can_download)
        E.LOG.d(TAG, "start download")
        m_task_agent:open()
      end)
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
      cb(false, code, msg)
    end
  end
  
  local function _callback(succ, ...)
    if type(listeners.on_splitpkg_res_update_complete) == "function" then
      listeners.on_splitpkg_res_update_complete(succ, ...)
    end
  end
  
  local function _confirm_download(can_download, download_file_list, ext_info)
    if false == can_download or #download_file_list <= 0 then
      _callback(true)
    else
      _download_splitpkg_res(download_file_list, ext_info, function(succ, ...)
        _callback(succ, ...)
      end)
    end
  end
  
  local function _confirm_update(update_res_info, download_file_list, ext_info)
    if type(listeners.on_confirm_res_update) == "function" then
      listeners.on_confirm_res_update(update_res_info, function(_confirm_result)
        if true == _confirm_result then
          _confirm_download(true, download_file_list, ext_info)
        else
          _confirm_download(false)
        end
      end)
    else
      _confirm_download(true, download_file_list, ext_info)
    end
  end
  
  local function _get_origin_res_list()
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
          local multi_res_update_info = {
            has_new_update = false,
            total_size = 0,
            total_count = 0,
            remain_size = 0,
            remain_count = 0
          }
          local list_total_size = 0
          if _succ then
            local down_origin, _ = ...
            local download_file_list = down_origin and down_origin.file_list or {}
            local list_count = #download_file_list
            E.LOG.debug(TAG, "hotfix_res_download_check, download_file_list count: " .. tostring(list_count))
            if list_count > 0 then
              for _, item in ipairs(down_origin.file_list) do
                local item_size = item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] or 0
                list_total_size = list_total_size + item_size
              end
              multi_res_update_info.total_size = list_total_size
              multi_res_update_info.total_count = list_count
              multi_res_update_info.remain_size = list_total_size
              multi_res_update_info.remain_count = list_count
              multi_res_update_info.has_new_update = true
              _ejoysdk.log("split_pkg_interceptor, download file list count: " .. tostring(list_count) .. ", total size: " .. tostring(multi_res_update_info.total_size / 1024 / 1024) .. " MB")
              E.log(multi_res_update_info)
            end
            ext_info.total_size = list_total_size
            _confirm_update(multi_res_update_info, download_file_list, ext_info)
          else
            _callback(false, ...)
          end
        end)
      else
        local code, msg = ...
        E.LOG.warn(TAG, "get origin file list failed, code: " .. tostring(code) .. ", msg: " .. tostring(msg))
        _callback(false, code, msg)
      end
    end)
  end
  
  local startup_res_update_infos = SC.get_startup_update_infos()
  UIM.add_update_infos(startup_res_update_infos)
  local update_info = UIM.get_res_update_info(res_info.namespace, res_info.res_key)
  local local_res_group_state = RTM.static_get_local_res_state(res_info.namespace, res_info.res_key) or {}
  local using_res_info = local_res_group_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  local apply_dest_path, _, save_storage_type = get_game_apply_dest_path(res_info.res_key)
  ER.check_namespace_res_update_with_update_info(res_info.namespace, res_info.res_key, update_info, using_res_info, {}, {
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH] = apply_dest_path,
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = save_storage_type
  }, function(_check_succ, ...)
    if _check_succ then
      _get_origin_res_list()
    else
      _callback(false, ...)
    end
  end)
end

function M.on_res_repair(_save_storage_type, _apply_dest_path)
  E.LOG.debug(TAG, "call split pkg on_res_repair >>>>>")
  QZ_EJ_SPLIT_PKG_PEEL_RES_DOWNLOADED:set("false")
  QZ_EJ_SPLIT_PKG_OVERRIDE_HANDLE_COMPLETE:set("false")
  SPV.clear_asset_missing_state()
end

function M._test_mock_builtin_path(path)
  RES_BUILTIN_PATH = path
end

return M

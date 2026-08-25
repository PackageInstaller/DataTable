local BASE_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.base_interceptor")
local E = require("ejoysdk_lua.ejoysdk")
local GEF = require("ejoysdk_lua.res.game_sub_pkg_facade")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local ER_FILE_INFO_CACHE = require("ejoysdk_lua.res.ejoysdk_res_file_list_cache")
local Lang = require("ejoysdk_lua.lang.util")
local SUB_PKG_INTERCEPTOR = "SUB_PKG_INTERCEPTOR"
local M = BASE_INTERCEPTOR:New(SUB_PKG_INTERCEPTOR)
local TAG = SUB_PKG_INTERCEPTOR
local RES_BUILTIN_PATH = "ejoysdk_sub_pkg_res"
local SUB_PKG_KEY = {
  SUB_PKG_CONFIG = "ej_qz_sub_pkg_config.json",
  SUB_PKG_FILE_LIST = "ej_qz_sub_pkg_file_list.json"
}
local sub_pkg_namespace = "QZ_SUB_PACKAGE"
local game_res_info_cache = {}
local sub_pkg_update_result = true
local sub_pkg_update_err_code, sub_pkg_update_err_msg, sub_pkg_config, sub_pkg_res_update_info, sub_pkg_origin_redownload_res_path, sub_pkg_engine_context, sub_pkg_download_res_path
local sub_pkg_patch_file_list = {}
local sub_pkg_patch_file_md5_list = {}
local sub_pkg_patch_diff_file_list = {}
local sub_pkg_origin_file_list = {}
local download_sub_pkg_origin_file_list = {}
local re_download_sub_pkg_origin_file_list = {}
local need_re_download_sub_pkg_origin_file_list = {}
local local_res_config_cache, multi_res_update_info_cache, startup_res_key_params, game_apply_dest_path, sub_pkg_download_dest_path, sub_pkg_download_state, sub_pkg_download_progress_info, download_state, download_progress_info
local QZ_EJ_SUB_PKG_PEEL_RES_DOWNLOADED = E.LazyKeyStore:New("QZ_EJ_SUB_PKG_PEEL_RES_DOWNLOADED", false, false, false)
local QZ_EJ_SUB_PKG_OVERRIDE_HANDLE_COMPLETE = E.LazyKeyStore:New("QZ_EJ_SUB_PKG_OVERRIDE_HANDLE_COMPLETE", false, false, false)
local QZ_EJ_SUB_PKG_RES_KEY = E.LazyKeyStore:New("QZ_EJ_SUB_PKG_RES_KEY", false, false, false)

function M.is_sub_pkg()
  local sub_pkg_config_file = RES_BUILTIN_PATH .. "/" .. SUB_PKG_KEY.SUB_PKG_CONFIG
  local sub_pkg_config_content = _ejoysdk.lread(sub_pkg_config_file)
  if sub_pkg_config_content then
    E.LOG.debug(TAG, "qz sub pkg: true")
    return true
  end
  E.LOG.debug(TAG, "qz sub pkg: false")
  return false
end

local function init_sub_pkg_config()
  if nil == sub_pkg_config then
    local sub_pkg_config_file = RES_BUILTIN_PATH .. "/" .. SUB_PKG_KEY.SUB_PKG_CONFIG
    local sub_pkg_config_content = _ejoysdk.lread(sub_pkg_config_file)
    sub_pkg_config = JSON.decode(sub_pkg_config_content) or {}
  end
  return sub_pkg_config
end

local function get_local_res_config()
  if local_res_config_cache then
    return local_res_config_cache
  end
  local cache_file_name = RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_CONFIG
  local local_res_config_file_path = E.Path.join(game_apply_dest_path, cache_file_name)
  local res_config = JSON.decode(E.File.readfile_fullpath(local_res_config_file_path)) or {}
  local_res_config_cache = res_config
  return res_config
end

local function is_peel_res_downloaded()
  local _is_peel_res_downloaded = QZ_EJ_SUB_PKG_PEEL_RES_DOWNLOADED:get()
  E.LOG.debug(TAG, "is_peel_res_downloaded is " .. tostring(_is_peel_res_downloaded))
  if nil == _is_peel_res_downloaded then
    QZ_EJ_SUB_PKG_PEEL_RES_DOWNLOADED:set("false")
    return false
  end
  return "true" == _is_peel_res_downloaded
end

local function set_peel_res_downloaded_flag(flag)
  QZ_EJ_SUB_PKG_PEEL_RES_DOWNLOADED:set(tostring(flag))
end

local function set_override_install_handle_complete(flag)
  QZ_EJ_SUB_PKG_OVERRIDE_HANDLE_COMPLETE:set(tostring(flag))
end

local function is_override_handle_complete()
  local _is_override_handle_complete = QZ_EJ_SUB_PKG_OVERRIDE_HANDLE_COMPLETE:get()
  E.LOG.debug(TAG, "is_override_handle_complete is " .. tostring(_is_override_handle_complete))
  if nil == _is_override_handle_complete then
    return true
  end
  return "true" == _is_override_handle_complete
end

local function check_reuse_files(reuse_dir, cb)
  local is_dir_exist = E.File.exists_fullpath(reuse_dir)
  if is_dir_exist then
    E.File.list_directory(reuse_dir, true, true, function(result)
      local file_list = {}
      if result and next(result) then
        for _, file_info in ipairs(result) do
          if not file_info.is_dir then
            local path = file_info.path
            file_list[path] = true
          end
        end
        cb(file_list)
      else
        cb({})
      end
    end)
  else
    cb({})
  end
end

local function _get_sub_pkg_work_path(storage_type, sub_pkg_res_key, sub_pkg_res_version)
  local base_path = E.Path.join(RES_BUILTIN_PATH, sub_pkg_res_key)
  if sub_pkg_res_version then
    base_path = E.Path.join(base_path, sub_pkg_res_version)
  end
  if E.Sysinfo.os() == "ios" then
    base_path = E.Path.join("Documents", base_path)
  end
  local full_path = ER_UTILS.get_apply_dest_path(storage_type, base_path)
  return base_path, full_path
end

local function pre_download_on_request_file_list(_ns, _res_key, cb, ext_info)
  check_reuse_files(sub_pkg_download_dest_path, function(reuse_file_list)
    sub_pkg_origin_file_list = ext_info.origin_file_list
    local sub_pkg_file_list = ext_info.file_list
    local sub_pkg_down_origin_file_list = ext_info.down_origin_file_list
    local file_list = {}
    local game_res_update_info = game_res_info_cache.update_info
    local multi_res_update_info = UTILS.deepcopy(game_res_update_info)
    if not multi_res_update_info.has_new_update then
      multi_res_update_info.total_size = 0
      multi_res_update_info.total_count = 0
    end
    local current_file_list_info = RTM.static_get_using_res_file_list(game_apply_dest_path) or {}
    if sub_pkg_res_update_info.file_list_type == "origin" then
      E.LOG.debug(TAG, "sub pkg res type is origin")
      local sub_pkg_origin_download_total_size = 0
      local sub_pkg_origin_download_total_count = 0
      local reuse_origin_file_array = {}
      for _, _sub_pkg_file_list in ipairs({sub_pkg_file_list, sub_pkg_down_origin_file_list}) do
        for _, file_info in ipairs(_sub_pkg_file_list) do
          local file_path = file_info.to
          if reuse_file_list[file_path] then
            E.LOG.debug(TAG, "reuse file: " .. tostring(file_path))
            table.insert(reuse_origin_file_array, file_path)
          else
            local expect_file_md5 = file_info.md5
            local local_file_info = current_file_list_info[file_path] or {}
            local local_file_md5 = local_file_info.md5
            if expect_file_md5 ~= local_file_md5 then
              E.LOG.debug(TAG, string.format("file_path is %s, expect_md5 is %s, local_file_md5 is %s ", tostring(file_path), tostring(expect_file_md5), tostring(local_file_md5)))
              table.insert(file_list, file_info)
              sub_pkg_origin_download_total_count = sub_pkg_origin_download_total_count + 1
              sub_pkg_origin_download_total_size = sub_pkg_origin_download_total_size + file_info.size
            end
          end
        end
      end
      if sub_pkg_res_update_info.total_size then
        multi_res_update_info.total_size = multi_res_update_info.total_size or 0
        multi_res_update_info.total_size = multi_res_update_info.total_size + sub_pkg_origin_download_total_size
      end
      if sub_pkg_res_update_info.total_count then
        multi_res_update_info.total_count = multi_res_update_info.total_count or 0
        multi_res_update_info.total_count = multi_res_update_info.total_count + sub_pkg_origin_download_total_count
      end
      for _, file_item in ipairs(file_list) do
        table.insert(download_sub_pkg_origin_file_list, file_item.to)
      end
      for _, reuse_file_item in ipairs(reuse_origin_file_array) do
        table.insert(download_sub_pkg_origin_file_list, reuse_file_item)
      end
      if next(file_list) or next(reuse_origin_file_array) then
        multi_res_update_info.has_new_update = true
      end
    else
      E.LOG.debug(TAG, "sub pkg res type is patch")
      local origin_file_map = {}
      for _, origin_file_info in ipairs(sub_pkg_origin_file_list) do
        origin_file_map[origin_file_info.to] = origin_file_info
      end
      file_list = {}
      local sub_pkg_download_total_size = 0
      local sub_pkg_download_total_count = #sub_pkg_file_list + #sub_pkg_down_origin_file_list
      local has_reuse_file = false
      for _, _sub_pkg_file_list in ipairs({sub_pkg_file_list, sub_pkg_down_origin_file_list}) do
        for _, file_info in ipairs(_sub_pkg_file_list) do
          local file_path = file_info.to
          if E.Utils.end_with(file_path, ".diff") then
            local origin_file_path = E.Utils.trim_end(file_path, ".diff")
            E.LOG.debug(TAG, "file_path is " .. tostring(file_path) .. ", origin file path is " .. tostring(origin_file_path))
            if current_file_list_info[origin_file_path] then
              if reuse_file_list[file_path] then
                E.LOG.debug(TAG, "reuse file: " .. tostring(file_path))
                has_reuse_file = true
              else
                table.insert(file_list, file_info)
                sub_pkg_download_total_size = sub_pkg_download_total_size + file_info.size
              end
              local origin_file_md5 = origin_file_map[origin_file_path].md5
              table.insert(sub_pkg_patch_file_list, origin_file_path)
              table.insert(sub_pkg_patch_file_md5_list, origin_file_md5)
              table.insert(sub_pkg_patch_diff_file_list, file_path)
            else
              if reuse_file_list[origin_file_path] then
                E.LOG.debug(TAG, "reuse file: " .. tostring(file_path))
                has_reuse_file = true
              else
                sub_pkg_download_total_size = sub_pkg_download_total_size + origin_file_map[origin_file_path].size
                table.insert(need_re_download_sub_pkg_origin_file_list, origin_file_path)
              end
              table.insert(re_download_sub_pkg_origin_file_list, origin_file_path)
            end
          else
            if reuse_file_list[file_path] then
              E.LOG.debug(TAG, "reuse file: " .. tostring(file_path))
              has_reuse_file = true
            else
              table.insert(file_list, file_info)
              sub_pkg_download_total_size = sub_pkg_download_total_size + file_info.size
            end
            table.insert(download_sub_pkg_origin_file_list, file_path)
          end
        end
      end
      if has_reuse_file then
        multi_res_update_info.has_new_update = true
      end
      if sub_pkg_download_total_size > 0 then
        multi_res_update_info.total_size = multi_res_update_info.total_size + sub_pkg_download_total_size
        multi_res_update_info.total_count = multi_res_update_info.total_count + sub_pkg_download_total_count
        multi_res_update_info.has_new_update = true
      end
    end
    
    local function confirm_cb_wrapper(confirm_result)
      if confirm_result then
        E.LOG.debug(TAG, "game res confirm callback is " .. tostring(confirm_result))
        cb(true, file_list, nil, nil == sub_pkg_file_list or nil == next(sub_pkg_file_list))
      else
        game_res_info_cache.confirm_cb(confirm_result)
      end
    end
    
    multi_res_update_info_cache = multi_res_update_info
    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_confirm_res_update, multi_res_update_info, confirm_cb_wrapper)
  end)
end

local function pre_download_confirm_res_update(_sub_pkg_res_update_info, confirm_cb)
  _ejoysdk.log("call pre_download_confirm_res_update >>>>>")
  E.log(_sub_pkg_res_update_info)
  sub_pkg_res_update_info = _sub_pkg_res_update_info
  confirm_cb(true)
end

local function merge_download_progress_info(sub_pkg_state, sub_pkg_progress_info, state, progress_info, is_sub_pkg_progress_update)
  sub_pkg_progress_info = sub_pkg_progress_info or {}
  progress_info = progress_info or {}
  local total_count = multi_res_update_info_cache.total_count
  local total_size = multi_res_update_info_cache.total_size
  local multi_res_download_progress_info
  if is_sub_pkg_progress_update then
    multi_res_download_progress_info = UTILS.deepcopy(sub_pkg_progress_info)
  else
    multi_res_download_progress_info = UTILS.deepcopy(progress_info)
  end
  multi_res_download_progress_info.total_count = total_count
  multi_res_download_progress_info.total_size = total_size
  multi_res_download_progress_info.finish_count = (sub_pkg_progress_info.finish_count or 0) + (progress_info.finish_count or 0)
  multi_res_download_progress_info.downloading_size = (sub_pkg_progress_info.downloading_size or 0) + (progress_info.downloading_size or 0)
  multi_res_download_progress_info.percent = total_size and type(total_size) == "number" and total_size > 0 and math.floor((multi_res_download_progress_info.downloading_size or 0) / total_size * 100) or 0
  local multi_res_download_state
  if is_sub_pkg_progress_update then
    multi_res_download_state = sub_pkg_state
  else
    multi_res_download_state = state
  end
  return multi_res_download_state, multi_res_download_progress_info
end

local function on_sub_pkg_res_download_progress_change_listener(state, progress_info)
  sub_pkg_download_state = "sub_pkg_" .. tostring(state)
  sub_pkg_download_progress_info = progress_info
  local multi_res_download_state, multi_res_download_progress_info = merge_download_progress_info(sub_pkg_download_state, sub_pkg_download_progress_info, download_state, download_progress_info, true)
  M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_download_progress_change_listener, multi_res_download_state, multi_res_download_progress_info)
end

function M.on_res_download_progress_change_listener(state, progress_info)
  download_state = state
  download_progress_info = progress_info
  local multi_res_download_state, multi_res_download_progress_info = merge_download_progress_info(sub_pkg_download_state, sub_pkg_download_progress_info, download_state, download_progress_info, false)
  M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_download_progress_change_listener, multi_res_download_state, multi_res_download_progress_info)
end

local function on_sub_pkg_res_update_complete_handler(update_result, ...)
  E.LOG.debug(TAG, "on_pre_download_res_update_complete_handler>>>> " .. tostring(update_result))
  if not update_result then
    sub_pkg_update_result = false
    sub_pkg_update_err_code, sub_pkg_update_err_msg = ...
    game_res_info_cache.confirm_cb(false)
  else
    set_peel_res_downloaded_flag(true)
    if not is_override_handle_complete() then
      set_override_install_handle_complete(true)
    end
    game_res_info_cache.confirm_cb(true)
  end
end

local function check_res_complete(res_key, res_current_version, res_save_storage_type)
  E.LOG.debug(TAG, "check_res_complete res_key is " .. tostring(res_key) .. ", version is " .. tostring(res_current_version))
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
  local index_file_path = E.Path.join(ERS.static_get_index_file_cache_path(ECC.NAMESPACE.QZ_PATCH, res_key, res_current_version, nil, {
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = res_save_storage_type
  }), ERS.RES_FILE_LIST_CACHE_KEY.FILE_NAME_LIST_JSON)
  E.LOG.debug(TAG, "check_res_complete, index_file_path is " .. tostring(index_file_path))
  local index_file_content = CJSON.safe_decode(E.File.readfile_fullpath(index_file_path))
  local FP = require("ejoysdk_lua.res.qz_file_list_parser")
  FP.parse_file_list(ECC.NAMESPACE.QZ_PATCH, res_key, nil, res_current_version, index_file_content)
  local file_list = FP.get_file_list(ECC.NAMESPACE.QZ_PATCH, res_key, nil, res_current_version) or {}
  local sub_pkg_file_list_file_path = E.Path.join(RES_BUILTIN_PATH, SUB_PKG_KEY.SUB_PKG_FILE_LIST)
  local sub_pkg_file_list_content = _ejoysdk.lread(sub_pkg_file_list_file_path)
  local sub_pkg_file_list = JSON.decode(sub_pkg_file_list_content) or {}
  local sub_pkg_file_map = {}
  for path, sub_pkg_file_info in pairs(sub_pkg_file_list) do
    local md5 = sub_pkg_file_info.md5
    sub_pkg_file_map[path] = md5
  end
  local local_file_list = RTM.static_get_using_res_file_list(game_apply_dest_path)
  local local_file_map = {}
  for path, local_file_info in pairs(local_file_list) do
    local md5 = local_file_info.md5
    local_file_map[path] = md5
  end
  local download_file_list = {}
  local download_total_size = 0
  local download_total_count = 0
  for _, file_item in ipairs(file_list) do
    local path = file_item.to
    local target_md5 = file_item.md5
    if local_file_map[path] ~= target_md5 then
      local delete_file_path = E.Path.join(game_apply_dest_path, path)
      E.File.remove_fullpath(delete_file_path)
    end
    if local_file_map[path] ~= target_md5 and sub_pkg_file_map[path] ~= target_md5 then
      table.insert(download_file_list, file_item)
      E.LOG.debug(TAG, "check_res_complete, download file: " .. tostring(file_item.to) .. ", local_file_md5 is " .. tostring(local_file_map[path]) .. ", pkg file md5 is " .. tostring(sub_pkg_file_map[path]))
      download_total_size = download_total_size + file_item.size
      download_total_count = download_total_count + 1
    end
  end
  local game_res_update_info = game_res_info_cache.update_info
  local multi_res_update_info = UTILS.deepcopy(game_res_update_info)
  if not multi_res_update_info.has_new_update then
    multi_res_update_info.total_size = 0
    multi_res_update_info.total_count = 0
  end
  if download_total_size > 0 then
    multi_res_update_info.total_size = multi_res_update_info.total_size + download_total_size
    multi_res_update_info.total_count = multi_res_update_info.total_count + download_total_count
    multi_res_update_info.has_new_update = true
    
    local function confirm_cb_wrapper(confirm_result)
      if confirm_result then
        local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
        local multi_model = EMF.get_http_res_multi_model(sub_pkg_config.sub_pkg_res_key)
        local ER = require("ejoysdk_lua.res.ejoysdk_res")
        local game_res_state = ER.get_res_state(ECC.NAMESPACE.QZ_PATCH, res_key)
        local game_res_server_update_info = game_res_state.res_update_info or {}
        local game_res_update_body = game_res_server_update_info.update_body or {}
        local base_url = game_res_update_body.baseUrl
        local url_info = E.HTTP.parse(base_url)
        local url_prefix = url_info.scheme .. "://" .. url_info.host
        local local_res_config = get_local_res_config(game_apply_dest_path)
        local folder = local_res_config.folder
        local base_path = local_res_config.base_path
        local temp_dir_path, _relative_temp_dir_path = ER_UTILS.get_temp_dir_path(sub_pkg_namespace, sub_pkg_config.sub_pkg_res_key, game_apply_dest_path)
        local temp_dir_exist = E.File.exists(temp_dir_path, true)
        if temp_dir_exist then
          E.File.remove_fullpath(temp_dir_path)
        end
        local mkdir_succ = E.File.make_dirs(temp_dir_path)
        if not mkdir_succ then
          sub_pkg_update_result = false
          sub_pkg_update_err_msg = EC.PATCH_ERROR.CODE_MAKE_TEMP_DIR_ERROR
          sub_pkg_update_err_msg = "make temp dir error, temp dir path is " .. tostring(temp_dir_path)
          game_res_info_cache.confirm_cb(false)
          return
        end
        E.LOG.debug(TAG, "download file dest path is " .. tostring(temp_dir_path))
        local download_list = ER_UTILS.to_model_download_list_format(download_file_list, folder, base_path, temp_dir_path)
        local file_ext = {base_url = url_prefix, total_size = download_total_size}
        local opts = {
          storage_type = RTM.STORAGE_TYPE.EXTERNAL_OTHER
        }
        local check_res_download_state = "idle"
        local task, code, msg = multi_model:create_task(download_list, file_ext, opts, function(_state, _state_obj)
          if _state == EMM.DOWNLOAD_STATE.COMPLETE then
            check_res_download_state = _state
            local move_map = {}
            for _, item in ipairs(download_file_list) do
              local source_path = E.Path.join(temp_dir_path, item.to)
              local target_path = E.Path.join(game_apply_dest_path, item.to)
              move_map[source_path] = target_path
            end
            ER_UTILS.batch_move_file(move_map, function(move_succ, ...)
              if move_succ then
                ER_FILE_INFO_CACHE.update_using_file_list_cache(ECC.NAMESPACE.QZ_PATCH, res_key, nil, res_current_version, game_apply_dest_path, {}, function()
                  set_override_install_handle_complete(true)
                  game_res_info_cache.confirm_cb(true)
                end)
              else
                sub_pkg_update_result = false
                local err_code, err_msg = ...
                sub_pkg_update_err_code = err_code
                sub_pkg_update_err_msg = err_msg
                game_res_info_cache.confirm_cb(false)
              end
            end)
          elseif _state == EMM.DOWNLOAD_STATE.FAILED then
            check_res_download_state = _state
            sub_pkg_update_err_code = _state_obj[EMM.STATE_KEY.ERR_CODE] or 0
            sub_pkg_update_err_msg = _state_obj[EMM.STATE_KEY.ERR_MSG]
            sub_pkg_update_result = false
            game_res_info_cache.confirm_cb(false)
          elseif _state then
            check_res_download_state = _state
          end
        end, function(progress_info)
          if progress_info and progress_info.downloading_size then
            sub_pkg_download_state = check_res_download_state
            sub_pkg_download_progress_info = progress_info
            local multi_res_download_state, multi_res_download_progress_info = merge_download_progress_info(sub_pkg_download_state, sub_pkg_download_progress_info, download_state, download_progress_info, true)
            M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_download_progress_change_listener, multi_res_download_state, multi_res_download_progress_info)
          end
        end)
        if task then
          task:start_download()
        else
          E.LOG.debug(TAG, "create_task failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
          sub_pkg_update_err_code = code
          sub_pkg_update_err_msg = msg
          sub_pkg_update_result = false
          game_res_info_cache.confirm_cb(false)
        end
      else
        game_res_info_cache.confirm_cb(false)
      end
    end
    
    multi_res_update_info_cache = multi_res_update_info
    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_confirm_res_update, multi_res_update_info, confirm_cb_wrapper)
  else
    local function confirm_cb_wrapper(confirm_result)
      game_res_info_cache.confirm_cb(confirm_result)
    end
    
    multi_res_update_info_cache = multi_res_update_info
    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_confirm_res_update, multi_res_update_info, confirm_cb_wrapper)
  end
end

local function batch_delete_files(delete_file_array, cb)
  if next(delete_file_array) ~= nil then
    E.File.batch_remove(delete_file_array, function(batch_remove_succ, ...)
      cb(batch_remove_succ, ...)
    end, {is_fullpath = true})
  else
    cb(true)
  end
end

local function handle_sub_pkg_apply(pkg_res_path, apply_dest_path, _cb, sub_pkg_total_percent)
  E.LOG.debug(TAG, "handle_sub_pkg_apply >>>>")
  local sub_pkg_ejoy_patch_info_file_path
  
  local function cb(...)
    local sub_pkg_apply_succ = (...)
    if sub_pkg_apply_succ then
      local delete_files_array = {}
      if sub_pkg_ejoy_patch_info_file_path then
        local diff_info_file_content = E.File.readfile_fullpath(sub_pkg_ejoy_patch_info_file_path)
        local sub_pkg_ejoy_patch_info_obj = JSON.safe_decode(diff_info_file_content) or {}
        local delete_files_json_array = sub_pkg_ejoy_patch_info_obj.delete_files or {}
        for _, file_info in ipairs(delete_files_json_array) do
          local target_path = E.Path.join(apply_dest_path, file_info.to)
          table.insert(delete_files_array, target_path)
        end
      end
      batch_delete_files(delete_files_array, function(batch_delete_succ, ...)
        if not batch_delete_succ then
          local batch_delete_err_code, batch_delete_err_msg = ...
          E.LOG.debug(TAG, "batch delete file fail, code is " .. tostring(batch_delete_err_code) .. ", msg is " .. tostring(batch_delete_err_msg))
        end
        local local_file_list = {}
        for _, file_info in ipairs(sub_pkg_origin_file_list) do
          local path = file_info.to
          local info = {
            md5 = file_info.md5
          }
          local_file_list[path] = info
        end
        ER_FILE_INFO_CACHE.sub_pkg_update_using_file_list_cache(apply_dest_path, local_file_list)
        ER_FILE_INFO_CACHE.update_using_res_config(apply_dest_path, sub_pkg_config.version)
        local ER = require("ejoysdk_lua.res.ejoysdk_res")
        ER.remove_res_version(ECC.NAMESPACE.QZ_SUB_PACKAGE, sub_pkg_config.sub_pkg_res_key, nil, {
          res_save_storage_type = sub_pkg_config.res_save_storage_type
        })
        local _sub_pkg_base_path, sub_pkg_temp_dir = _get_sub_pkg_work_path(sub_pkg_config.res_save_storage_type, sub_pkg_config.sub_pkg_res_key)
        E.LOG.debug(TAG, "delete sub_pkg_temp_dir, path is " .. tostring(sub_pkg_temp_dir))
        E.File.remove_fullpath(sub_pkg_temp_dir)
        _cb(true)
      end)
    else
      _cb(...)
    end
  end
  
  local temp_dir_path, _relative_temp_dir_path = ER_UTILS.get_temp_dir_path(sub_pkg_namespace, sub_pkg_config.sub_pkg_res_key, game_apply_dest_path)
  local temp_dir_exist = E.File.exists(temp_dir_path, true)
  if temp_dir_exist then
    E.File.remove_fullpath(temp_dir_path)
  end
  local mkdir_succ = E.File.make_dirs(temp_dir_path)
  if not mkdir_succ then
    cb(false, EC.PATCH_ERROR.CODE_MAKE_TEMP_DIR_ERROR, "make temp dir error, temp dir path is " .. tostring(temp_dir_path))
    return
  end
  local copy_map = {}
  for _, origin_file_rela_path in ipairs(download_sub_pkg_origin_file_list) do
    local source_path = E.Path.join(sub_pkg_download_res_path, origin_file_rela_path)
    local target_path = E.Path.join(apply_dest_path, origin_file_rela_path)
    if E.Utils.end_with(origin_file_rela_path, "ejoy_patch_info.json") then
      sub_pkg_ejoy_patch_info_file_path = source_path
    else
      copy_map[source_path] = target_path
    end
  end
  for _, origin_file_rela_path in ipairs(re_download_sub_pkg_origin_file_list) do
    local source_path = E.Path.join(sub_pkg_origin_redownload_res_path, origin_file_rela_path)
    local target_path = E.Path.join(apply_dest_path, origin_file_rela_path)
    copy_map[source_path] = target_path
  end
  if sub_pkg_patch_diff_file_list and next(sub_pkg_patch_diff_file_list) then
    local options = {
      resPkgDirPath = pkg_res_path,
      oldDirPath = apply_dest_path,
      patchDirPath = sub_pkg_download_res_path,
      newDirPath = temp_dir_path
    }
    local patch_files_params = {
      options = options,
      oldFilePaths = sub_pkg_patch_file_list,
      patchFilePaths = sub_pkg_patch_diff_file_list,
      newFilePaths = sub_pkg_patch_file_list,
      newFileMd5Array = sub_pkg_patch_file_md5_list
    }
    E.LOG.debug(TAG, "patch files params is >>>>")
    E.LOG.debug(TAG, patch_files_params)
    E.patch_files(patch_files_params, function(succ, code, ...)
      if not succ then
        if 1 == code then
          E.LOG.debug(TAG, "patch files fail, now start move files, patch files is >>>>")
          local patch_succ_files, patch_fail_files = ...
          if not patch_fail_files then
            E.log("patch files error.")
            cb(false, EC.PATCH_ERROR.CODE_PATCH_PART_ERROR, "patch files error, patch_fail_files invalid")
            return
          end
          E.LOG.debug(TAG, "patch files fail, now start move files, patch files is >>>>")
          E.LOG.debug(TAG, patch_fail_files)
          if patch_succ_files then
            for _, file_path in ipairs(patch_succ_files) do
              local source_path = E.Path.join(temp_dir_path, file_path)
              local target_path = E.Path.join(apply_dest_path, file_path)
              copy_map[source_path] = target_path
            end
          end
          sub_pkg_engine_context.download_res_files(patch_fail_files, {
            res_save_storage_type = sub_pkg_config.res_save_storage_type
          }, function(download_succ, ...)
            if download_succ then
              E.log("sub_pkg patch fail files, re download succ, now start move file")
              local _, ext_obj = ...
              local ejoy_temp_dest_abs_dir = ext_obj.ejoy_temp_dest_abs_dir
              for _, file_path in ipairs(patch_fail_files) do
                local source_path = E.Path.join(ejoy_temp_dest_abs_dir, file_path)
                local target_path = E.Path.join(apply_dest_path, file_path)
                copy_map[source_path] = target_path
              end
              ER_UTILS.batch_move_file(copy_map, function(batch_move_succ, ...)
                cb(batch_move_succ, ...)
              end)
            else
              local err_code, err_msg = ...
              cb(false, err_code, err_msg)
              E.log("sub_pkg patch fail files, re download fail, code is " .. tostring(err_code) .. ", msg is " .. tostring(err_msg))
            end
          end, function(_state, _state_obj)
          end, function(_sub_pkg_download_progress_info)
            local percent = _sub_pkg_download_progress_info.percent
            M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_apply_progress_change_listener, "sub_pkg_re_download", {percent = percent})
          end)
        else
          cb(false, code, "patch files error")
        end
      else
        E.LOG.debug(TAG, "patch files all succ, now start move files")
        for _, file_path in ipairs(sub_pkg_patch_file_list) do
          local source_path = E.Path.join(temp_dir_path, file_path)
          local target_path = E.Path.join(apply_dest_path, file_path)
          copy_map[source_path] = target_path
        end
        ER_UTILS.batch_move_file(copy_map, function(batch_move_succ, ...)
          cb(batch_move_succ, ...)
        end)
      end
    end, function(patch_complete_count, patch_total_count)
      local percent = math.floor(patch_complete_count / patch_total_count * sub_pkg_total_percent)
      M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_apply_progress_change_listener, "apply_sub_pkg_res", {percent = percent})
    end)
  else
    ER_UTILS.batch_move_file(copy_map, function(batch_move_succ, ...)
      cb(batch_move_succ, ...)
    end)
  end
end

local function on_sub_pkg_res_apply(engine_context, res_location, _apply_cb, _progress_cb)
  E.LOG.debug(TAG, "call on_sub_pkg_res_apply")
  
  local function apply_cb(apply_succ, ...)
    local pkg_res_path = startup_res_key_params.pkg_res_path
    local game_has_new_update = game_res_info_cache.update_info.has_new_update
    if game_has_new_update then
      _apply_cb(apply_succ, ...)
    else
      handle_sub_pkg_apply(pkg_res_path, game_apply_dest_path, function(sub_pkg_apply_succ, ...)
        _apply_cb(sub_pkg_apply_succ, ...)
      end, 100)
    end
  end
  
  _ejoysdk.log("call pre_download_on_res_apply >>>>>>" .. tostring(res_location))
  sub_pkg_engine_context = engine_context
  sub_pkg_download_res_path = res_location
  if next(need_re_download_sub_pkg_origin_file_list) then
    E.LOG.debug(TAG, "re_download_sub_pkg_origin_file_list is not empty, now start download")
    local sub_pkg_download_progress_info_cache = sub_pkg_download_progress_info
    local re_download_state
    engine_context.download_res_files(need_re_download_sub_pkg_origin_file_list, {
      res_save_storage_type = sub_pkg_config.res_save_storage_type
    }, function(download_succ, ...)
      if download_succ then
        E.LOG.debug(TAG, "sub pkg re download origin res, download succ")
        local _, ext_obj = ...
        sub_pkg_origin_redownload_res_path = ext_obj.ejoy_temp_dest_abs_dir
        E.log(ext_obj.ejoy_temp_dest_abs_dir)
        apply_cb(true)
      else
        local err_code, err_msg = ...
        apply_cb(false, err_code, err_msg)
        E.LOG.debug(TAG, "sub pkg re download origin res, download fail, code is " .. tostring(err_code) .. ", msg is " .. tostring(err_msg))
      end
    end, function(_state, _state_obj)
      if _state then
        re_download_state = _state
      end
    end, function(_download_progress_info)
      E.LOG.debug(TAG, "sub pkg download_progress_info >>>>")
      E.LOG.debug(TAG, _download_progress_info)
      if _download_progress_info and _download_progress_info.downloading_size then
        if sub_pkg_download_progress_info_cache then
          sub_pkg_download_state = "sub_pkg_" .. tostring(re_download_state)
          sub_pkg_download_progress_info = _download_progress_info
          local sub_pkg_download_finish_count = sub_pkg_download_progress_info_cache.finish_count or 0
          local sub_pkg_download_downloading_size = sub_pkg_download_progress_info_cache.downloading_size or 0
          sub_pkg_download_progress_info.downloading_size = _download_progress_info.downloading_size + sub_pkg_download_downloading_size
          sub_pkg_download_progress_info.finish_count = _download_progress_info.finish_count + sub_pkg_download_finish_count
        else
          sub_pkg_download_state = "sub_pkg_" .. tostring(re_download_state)
          sub_pkg_download_progress_info = _download_progress_info
        end
        local multi_res_download_state, multi_res_download_progress_info = merge_download_progress_info(sub_pkg_download_state, sub_pkg_download_progress_info, download_state, _download_progress_info, true)
        M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_download_progress_change_listener, multi_res_download_state, multi_res_download_progress_info)
      end
    end)
  else
    E.LOG.debug(TAG, "sub pkg all res download succ")
    apply_cb(true)
  end
end

local sub_pkg_total_percent = 0

function M.on_res_pre_apply(engine_context, res_location, apply_dest_path, res_state_infos, cb)
  E.LOG.debug(TAG, "sub_pkg receive qz on_res_apply event")
  local sub_pkg_diff_file_list = sub_pkg_patch_diff_file_list or {}
  local sub_pkg_diff_file_count = #sub_pkg_diff_file_list
  if sub_pkg_diff_file_count > 0 then
    sub_pkg_total_percent = 40
  end
  local ejoy_patch_info_file_path = E.Path.join(res_location, "ejoy_patch_info.json")
  local is_ejoy_patch = E.File.exists_fullpath(ejoy_patch_info_file_path)
  if is_ejoy_patch then
    local ejoy_patch_info = JSON.decode(E.File.readfile(ejoy_patch_info_file_path)) or {}
    local diff_files = ejoy_patch_info.diff_files or {}
    local qz_diff_file_count = #diff_files
    local total_diff_file_count = qz_diff_file_count + sub_pkg_diff_file_count
    if total_diff_file_count > 0 then
      sub_pkg_total_percent = math.floor(sub_pkg_diff_file_count / total_diff_file_count * 100)
    end
  end
  local _, _, res_info = engine_context.get_res_info()
  local pkg_res_path = res_info.pkg_res_path
  handle_sub_pkg_apply(pkg_res_path, apply_dest_path, function(sub_pkg_apply_succ, ...)
    if sub_pkg_apply_succ then
      M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_pre_apply, engine_context, res_location, apply_dest_path, res_state_infos, cb)
    else
      E.LOG.debug(TAG, "sub pkg apply res fail")
      cb(false, ...)
    end
  end, sub_pkg_total_percent)
end

function M.on_res_apply_progress_change_listener(state, progress_info)
  local percent = sub_pkg_total_percent + math.floor(progress_info.percent / 100 * (100 - sub_pkg_total_percent))
  progress_info.percent = percent
  M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_res_apply_progress_change_listener, state, progress_info)
end

function M.on_startup_update_complete(update_result, ...)
  if not sub_pkg_update_result then
    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_startup_update_complete, sub_pkg_update_result, sub_pkg_update_err_code, sub_pkg_update_err_msg)
  else
    M:proceed_next_intercept(BASE_INTERCEPTOR.INTERFACES.on_startup_update_complete, update_result, ...)
  end
end

local function check_res_key_incompatible()
  local cache_sub_pkg_res_key = QZ_EJ_SUB_PKG_RES_KEY:get()
  local current_sub_pkg_res_key = sub_pkg_config.sub_pkg_res_key
  if cache_sub_pkg_res_key and cache_sub_pkg_res_key ~= current_sub_pkg_res_key then
    E.LOG.debug(TAG, "sub_pkg_res_key incompatible, remove old sub_pkg_key cache")
    local ER = require("ejoysdk_lua.res.ejoysdk_res")
    ER.remove_res_version(ECC.NAMESPACE.QZ_SUB_PACKAGE, cache_sub_pkg_res_key, nil, {
      res_save_storage_type = sub_pkg_config.res_save_storage_type
    })
    local _sub_pkg_base_path, sub_pkg_temp_dir = _get_sub_pkg_work_path(sub_pkg_config.res_save_storage_type, cache_sub_pkg_res_key)
    E.File.remove_fullpath(sub_pkg_temp_dir)
  end
  QZ_EJ_SUB_PKG_RES_KEY:set(current_sub_pkg_res_key)
end

local function check_small_pkg_update(res_update_info, confirm_cb, is_override_install)
  E.LOG.debug(TAG, "check_small_pkg_update, is_override_install: " .. tostring(is_override_install))
  game_res_info_cache.update_info = res_update_info
  E.LOG.debug(TAG, "game res update info is ")
  E.LOG.debug(TAG, res_update_info)
  game_res_info_cache.confirm_cb = confirm_cb
  init_sub_pkg_config()
  local res_key = sub_pkg_config.res_key
  local startup_params, gm_params_update_opts = SC.get_game_startup_params()
  gm_params_update_opts[RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG] = {
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.COMPLETE_TITLE] = Lang.getString("noti_download_finish_title", "游戏资源下载完成"),
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.COMPLETE_LEFT_TXT] = Lang.getString("noti_download_finish_desc", "请点击切换游戏完整版本体验~"),
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.COMPLETE_RIGHT_TXT] = "",
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.DOWNLOADING_TITLE] = Lang.getString("noti_downloading_static_title", "游戏资源下载中"),
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.DOWNLOADING_LEFT_TXT] = "",
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.DOWNLOADING_RIGHT_TXT] = "",
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.IS_PROGRESS_VISIBLE] = false,
    [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.IS_STATUS_ICON_VISIBLE] = false
  }
  SC.update_game_startup_params(startup_params, gm_params_update_opts)
  startup_res_key_params = startup_params[ECC.NAMESPACE.QZ_PATCH][res_key] or {}
  game_apply_dest_path = ER_UTILS.get_apply_dest_path(startup_res_key_params.res_save_storage_type, startup_res_key_params.res_save_base_path)
  local res_save_storage_type = ER_UTILS.try_get_storage_type(startup_res_key_params.res_save_storage_type, startup_res_key_params.res_save_base_path)
  E.LOG.debug(TAG, "res_save_storage_type is " .. tostring(res_save_storage_type))
  sub_pkg_config.res_save_storage_type = res_save_storage_type
  check_res_key_incompatible()
  local res_pkg_path = startup_res_key_params.res_pkg_path
  local res_save_base_path
  res_save_base_path, sub_pkg_download_dest_path = _get_sub_pkg_work_path(res_save_storage_type, sub_pkg_config.sub_pkg_res_key, sub_pkg_config.version)
  E.LOG.debug(TAG, "sub_pkg_download_dest_path is " .. tostring(sub_pkg_download_dest_path))
  local sub_pkg_res_info = {
    res_key = sub_pkg_config.sub_pkg_res_key,
    res_save_base_path = res_save_base_path,
    res_pkg_path = res_pkg_path,
    res_save_storage_type = res_save_storage_type,
    engine_handler = {on_request_file_list = pre_download_on_request_file_list, on_res_apply = on_sub_pkg_res_apply}
  }
  local sub_pkg_download_listeners = {
    on_confirm_res_update = pre_download_confirm_res_update,
    on_res_download_progress_change_listener = on_sub_pkg_res_download_progress_change_listener,
    on_res_update_complete = on_sub_pkg_res_update_complete_handler
  }
  local sub_pkg_download_complete_title = Lang.getString("noti_downloading_static_title", "游戏资源下载中")
  if not game_res_info_cache.update_info.has_new_update then
    sub_pkg_download_complete_title = Lang.getString("noti_download_finish_title", "游戏资源下载完成")
  end
  local opts = {
    [RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG] = {
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.COMPLETE_TITLE] = sub_pkg_download_complete_title,
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.COMPLETE_LEFT_TXT] = "",
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.COMPLETE_RIGHT_TXT] = "",
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.DOWNLOADING_TITLE] = Lang.getString("noti_downloading_static_title", "游戏资源下载中"),
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.DOWNLOADING_LEFT_TXT] = "",
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.DOWNLOADING_RIGHT_TXT] = "",
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.IS_PROGRESS_VISIBLE] = false,
      [RTM.NOTIFICATION_CUSTOM_CONFIG_OPTIONS.IS_STATUS_ICON_VISIBLE] = false
    },
    stat_is_upload_now = true,
    ext = {
      apus_options = {is_upload_now = true}
    }
  }
  if not is_override_install then
    GEF.check_and_update(sub_pkg_res_info, opts, sub_pkg_download_listeners)
  else
    local pkg_res_version = sub_pkg_config.version
    local local_res_config = get_local_res_config()
    E.LOG.debug(TAG, "game_apply_dest_path is " .. tostring(game_apply_dest_path) .. ", local_res_config is ")
    E.LOG.debug(TAG, local_res_config)
    local res_current_version = local_res_config.version
    E.LOG.debug(TAG, "current res version is " .. tostring(res_current_version))
    if VER_CHECK.compare_versions(pkg_res_version, res_current_version) >= 0 then
      E.LOG.debug(TAG, "pkg_res_version is bigger then res_current_version, pkg_res_version is " .. tostring(pkg_res_version) .. ", res_current_version is " .. tostring(res_current_version))
      sub_pkg_res_info.version = res_current_version
      opts.force_check_update = true
      GEF.check_and_update(sub_pkg_res_info, opts, sub_pkg_download_listeners)
    else
      check_res_complete(res_key, res_current_version, res_save_storage_type)
    end
  end
end

function M.on_confirm_res_update(res_update_info, confirm_cb)
  E.LOG.debug(TAG, "call sub pkg on_confirm_res_update >>>>>")
  local _is_peel_res_downloaded = is_peel_res_downloaded()
  if not _is_peel_res_downloaded then
    E.LOG.debug(TAG, "is_peel_res_downloaded: false, now check small pkg update")
    check_small_pkg_update(res_update_info, confirm_cb, false)
  else
    E.LOG.debug(TAG, "is_peel_res_downloaded: true, now check override_install")
    check_small_pkg_update(res_update_info, confirm_cb, true)
  end
end

function M.on_res_repair(_save_storage_type, _apply_dest_path)
  E.LOG.debug(TAG, "call sub pkg on_res_repair >>>>>")
  QZ_EJ_SUB_PKG_PEEL_RES_DOWNLOADED:set("false")
  QZ_EJ_SUB_PKG_OVERRIDE_HANDLE_COMPLETE:set("false")
  local ER = require("ejoysdk_lua.res.ejoysdk_res")
  if M.is_sub_pkg() then
    init_sub_pkg_config()
    ER.repair(ECC.NAMESPACE.QZ_SUB_PACKAGE, sub_pkg_config.sub_pkg_res_key)
  else
    local cache_sub_pkg_res_key = QZ_EJ_SUB_PKG_RES_KEY:get()
    if not UTILS.is_text_empty(cache_sub_pkg_res_key) then
      ER.repair(ECC.NAMESPACE.QZ_SUB_PACKAGE, cache_sub_pkg_res_key)
      if not UTILS.is_text_empty(_save_storage_type) then
        ER.remove_res_version(ECC.NAMESPACE.QZ_SUB_PACKAGE, cache_sub_pkg_res_key, nil, {res_save_storage_type = _save_storage_type})
      end
      QZ_EJ_SUB_PKG_RES_KEY:set(nil)
    end
  end
end

function M.on_res_valid_check(check_cb)
  check_cb(true)
end

function M.enable_interceptor()
  local enable = false
  local SU = require("ejoysdk_lua.res.startup.startup_utils")
  if M.is_sub_pkg() and SU.can_reuse_res() == false then
    if not is_peel_res_downloaded() then
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

function M.mark_complete()
  set_peel_res_downloaded_flag(true)
end

function M._test_mock_builtin_path(path)
  RES_BUILTIN_PATH = path
end

return M

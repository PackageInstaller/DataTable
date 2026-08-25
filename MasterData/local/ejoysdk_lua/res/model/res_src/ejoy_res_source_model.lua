local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
local E = require("ejoysdk_lua.ejoysdk")
local ERU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local CC = require("ejoysdk_lua.ejoysdk_constants")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local EHU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local RSTAT = require("ejoysdk_lua.res.res_stat")
local TA = require("ejoysdk_lua.res.model.task_download_agent")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local MODEL_NAME = "EjoyResSourceModel"
local TAG = MODEL_NAME
local RES_UPDATE_MULTI_MODEL_NAME = "ResUpdate"
local RES_PATCH_FIX_MODEL_NAME = "ResUpdatePatchFix"
local M = RTM:Inherit(MODEL_NAME)
M.FILE_LIST_ITEM_KEY = RTM.FILE_LIST_ITEM_KEY
M.DOWNLOAD_STATE = RTM.PUBLIC_DOWNLOAD_STATE
local QZ_ORIGIN_TEMP_FILES_DIR = "qz_origin_temp_files"
local DEFAULT_SUBMIT_ALL_COST_MS_PER_SEC = 100

function M:get_log_output_level()
  return RTM.INNER_LOG_LEVEL.INFO
end

function M:_init(_model_name, _namespace, _res_key, _opts)
  _opts = _opts or {}
  self._data = {
    model_name = _model_name,
    namespace = _namespace,
    res_key = _res_key,
    has_checked_local_res = false,
    using_res_state_info = nil,
    pending_file_list_info = nil,
    state_listeners = {},
    progress_listeners = {},
    local_res_downloading_info = {
      [RTM.RES_STATE_INFO_KEY.STATE] = M.DOWNLOAD_STATE.UNKNOWN,
      [RTM.RES_STATE_INFO_KEY.VERSION_NAME] = nil,
      [RTM.RES_STATE_INFO_KEY.FILE_LIST_TYPE] = RTM.FILE_LIST_TYPE.UNKNOWN,
      [RTM.RES_STATE_INFO_KEY.LOCAL_VERSION] = nil
    },
    res_update_info = {
      [RTM.UPDATE_INFO_KEY.HAS_NEW_UPDATE] = false,
      [RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0,
      [RTM.UPDATE_INFO_KEY.VERSION_NAME] = nil
    },
    current_down_progress_info = {
      [RTM.PROGRESS_INFO_KEY.PERCENT] = 0,
      [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = 0,
      [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = 0,
      [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = 0,
      [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = 0,
      [RTM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = nil,
      [RTM.PROGRESS_INFO_KEY.SPEED] = 0
    },
    download_address_list = {},
    multi_download_model_name = nil,
    task_agent = nil,
    custom_res_save_base_path = _opts[RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH],
    custom_res_save_storage_type = _opts[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] or RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE,
    foreground_notification_enabled = _opts[RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED],
    force_check_update = false,
    res_src_instance = nil,
    opts = _opts,
    qz_update_server_config = nil,
    submit_all_task_cost_per_sec = DEFAULT_SUBMIT_ALL_COST_MS_PER_SEC,
    download_strategy_type = NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK,
    confirmed_download_versions = {}
  }
  self:log_debug("_init begin:")
  E.log(_opts)
  if not self._data.qz_update_server_config then
    local ecc = require("ejoysdk_lua.ejoysdk_config_center")
    local biz_config = ecc.get_config(ecc.NAMESPACE.EJOYSDK_BIZ)
    if biz_config and biz_config.config and biz_config.config.qz_update_configs then
      self._data.qz_update_server_config = biz_config.config.qz_update_configs
      self:log_debug("get qz_update_configs in init>>")
      E.log(self._data.qz_update_server_config)
      local config_cost_ms = self._data.qz_update_server_config.submit_all_task_cost_per_sec or 0
      self._data.submit_all_task_cost_per_sec = config_cost_ms > 0 and config_cost_ms or DEFAULT_SUBMIT_ALL_COST_MS_PER_SEC
      self:log_debug("submit_all_task_count_per_sec:" .. tostring(self._data.submit_all_task_cost_per_sec))
    end
  end
  local res_src_instance = ERS:New(_model_name, _namespace, _res_key, _opts)
  self._data.res_src_instance = res_src_instance
  self._data.multi_download_model_name = RES_UPDATE_MULTI_MODEL_NAME .. "_" .. tostring(_namespace) .. "_" .. tostring(_res_key)
  self._data.model_name_patch_fix = RES_PATCH_FIX_MODEL_NAME .. "_" .. tostring(_namespace) .. "_" .. tostring(_res_key)
end

function M:get_module_log_prefix()
  return "STARTUP#" .. MODEL_NAME .. "#" .. tostring(self._data.namespace) .. "#" .. tostring(self._data.res_key)
end

function M:prepare_res_list_for_download(_cb)
end

function M:update_config(config)
  if not config then
    return
  end
  if type(config[RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH]) == "string" then
    self._data.custom_res_save_base_path = config[RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH]
    self:log_debug("update_config res_save_base_path:" .. tostring(self._data.custom_res_save_base_path))
  end
  if "string" == type(config[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE]) then
    self._data.custom_res_save_storage_type = config[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE]
    self:log_debug("update_config storage type:" .. tostring(self._data.custom_res_save_storage_type))
  end
  local foreground_notification_enable = config[RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED]
  if type(foreground_notification_enable) == "boolean" then
    self._data.foreground_notification_enabled = foreground_notification_enable
  end
  local foreground_notification_custom_config = config[RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG]
  if type(foreground_notification_custom_config) == "table" then
    self._data.foreground_notification_custom_config = foreground_notification_custom_config
  end
  local force_check_update = config[RTM.RES_UPDATES_OPTIONS.FORCE_CHECK_UPDATE]
  if type(force_check_update) == "boolean" then
    self._data.force_check_update = force_check_update
  end
  self._data.res_src_instance:update_config(config)
end

function M:update_opts(opts)
  if not opts then
    return
  end
  self._data.opts = opts
end

function M:update_cached_res_info()
  self:log_debug("update_cached_res_info begin")
  RTM.static_update_cached_res_info(self._data.namespace, self._data.res_key, self._data.using_res_state_info, self._data.local_res_downloading_info, self._data.current_down_progress_info)
end

function M:check_res_update(_cb, update_info, _using_res_info, _namespace_ext)
  self:_do_check_local_res_state()
  local res_using_version = _using_res_info[RTM.USING_RES_INFO_PARAM_KEY.VERSION]
  local pkg_project_name = _using_res_info.pkg_project_name
  local res_type = _using_res_info.res_type
  self:update_using_res_version(res_using_version, pkg_project_name, res_type)
  _namespace_ext = _namespace_ext or {}
  local _res_ext = update_info.ext or {}
  self._data.download_address_list = _namespace_ext[RTM.RES_CONFIG_KEY.KEY_ADDRESS_LIST] or {}
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  ERS:check_res_update(function(succ, ...)
    if succ then
      local _update_info = (...)
      _update_info = _update_info or {}
      _update_info.ext = _namespace_ext
      _update_info.res_ext = _res_ext
      self:log_debug("check_res_update complete, update_info>>")
      E.log(_update_info)
      self._data.res_update_info = _update_info
      local update_body = _update_info.update_body or {}
      local rk_address_list = update_body[RTM.RES_CONFIG_KEY.KEY_ADDRESS_LIST]
      if rk_address_list and next(rk_address_list) then
        self:log_debug("check_res_update , update download_address_list")
        self._data.download_address_list = rk_address_list
      end
      local update_info_version = update_body[RTM.RES_CONFIG_KEY.KEY_VERSION]
      local ret = utils.version_compare(res_using_version, update_info_version)
      if ret < 0 then
        self:log_debug("check_res_update, has newest update info, new version:" .. tostring(update_info_version) .. ", local version:" .. tostring(res_using_version))
        self._data.res_update_info[RTM.UPDATE_INFO_KEY.HAS_NEW_UPDATE] = true
      else
        self:log_debug("check_res_update, local is already update, server version:" .. tostring(update_info_version) .. ", local version:" .. tostring(res_using_version))
        self._data.res_update_info[RTM.UPDATE_INFO_KEY.HAS_NEW_UPDATE] = false
      end
      _cb(true, self._data.res_update_info)
    else
      local code, msg = ...
      self:log_warn("check res update fail, code is " .. tostring(code) .. ", msg is " .. tostring(msg))
      _cb(false, ...)
    end
  end, update_info, self._data.download_address_list, namespace, res_key, {
    res_save_storage_type = self._data.custom_res_save_storage_type
  })
end

function M:_on_update_using_res_info(_using_res_info)
  if not _using_res_info or next(_using_res_info) == nil then
    self:log_debug("skip update using res ver, for its empty")
    return
  end
  local last_using_res_version = self._data.using_res_state_info and self._data.using_res_state_info[RTM.USING_RES_STATE_INFO_KEY.VERSION_NAME] or nil
  self._data.using_res_state_info = utils.deepcopy(_using_res_info)
  local using_res_version = self._data.using_res_state_info and self._data.using_res_state_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME]
  if utils.version_compare(last_using_res_version, using_res_version) < 0 then
    self:log_debug("last using res version smaller than using res version, last:" .. tostring(last_using_res_version) .. ", cur:" .. tostring(using_res_version))
    if last_using_res_version then
      self:remove_res(last_using_res_version)
    else
      self:log_debug("last using res version is nil, skip remove last res version")
    end
  end
  local downloading_res_version = self._data.local_res_downloading_info and self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME]
  self:log_debug("_on_update_using_res_info using_res_version:" .. tostring(using_res_version) .. ", downloading_res_version:" .. tostring(downloading_res_version))
  
  local function remove_download_state()
    self:remove_res(downloading_res_version)
  end
  
  local using_res_version_compare_result = utils.version_compare(using_res_version, downloading_res_version)
  if using_res_version_compare_result > 0 then
    self:log_warn("has downloading version and using res version larger than downloading version:" .. tostring(downloading_res_version) .. ", need remove downloading res version")
    local downloading_state = self._data.local_res_downloading_info and self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.STATE]
    if downloading_state == M.DOWNLOAD_STATE.DOWNLOADING then
      self:pause_download(function(_succ)
        remove_download_state()
      end)
    elseif downloading_state == M.DOWNLOAD_STATE.FAILED or downloading_state == M.DOWNLOAD_STATE.STOPPED then
      remove_download_state()
    elseif downloading_state == M.DOWNLOAD_STATE.COMPLETE then
      remove_download_state()
    end
  elseif 0 == using_res_version_compare_result then
    self:log_warn("has downloading version and using res version equals downloading version:" .. tostring(downloading_res_version) .. ", need stop and remove downloading version, but keep complete version until explicit remove it")
    local downloading_state = self._data.local_res_downloading_info and self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.STATE]
    if downloading_state == M.DOWNLOAD_STATE.DOWNLOADING then
      self:pause_download(function(_succ)
        remove_download_state()
      end)
    elseif downloading_state == M.DOWNLOAD_STATE.FAILED or downloading_state == M.DOWNLOAD_STATE.STOPPED then
      remove_download_state()
    elseif downloading_state == M.DOWNLOAD_STATE.COMPLETE then
      self:log_debug("using res version equals with local complete res version, keep local res in location")
    end
  end
  local update_info_version = self._data.res_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
  local compare_result = utils.version_compare(update_info_version, using_res_version)
  if compare_result < 0 then
    self:log_warn("current update_info version is lower than using_res_version, now no need keep update_info, update_version:" .. tostring(update_info_version))
    self._data.res_update_info = {
      [RTM.UPDATE_INFO_KEY.HAS_NEW_UPDATE] = false
    }
  elseif 0 == compare_result then
    self:log_warn("current update_info version is equals with using_res_version, now keep update_info, update_version:" .. tostring(update_info_version))
    self._data.res_update_info[RTM.UPDATE_INFO_KEY.HAS_NEW_UPDATE] = false
  end
  self:update_cached_res_info()
end

function M:_do_check_local_res_state()
  if self._data.has_checked_local_res then
    return true
  end
  local local_res_obj = RTM.static_get_local_res_state(self._data.namespace, self._data.res_key) or {}
  local local_cached_progress_info = local_res_obj[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOAD_PROGRESS_INFO]
  if local_cached_progress_info then
    self._data.current_down_progress_info = local_cached_progress_info
  end
  local local_cached_downloading_info = local_res_obj[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOADING_INFO]
  if local_cached_downloading_info then
    local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
    self._data.local_res_downloading_info = local_cached_downloading_info
    local downloading_state = local_cached_downloading_info[EMM.STATE_KEY.STATE]
    if downloading_state == M.DOWNLOAD_STATE.DOWNLOADING or downloading_state == M.DOWNLOAD_STATE.FAILED then
      self:log_debug("_do_check_local_res_state last is downloading or failed, so we set init state is stopped")
      self._data.local_res_downloading_info[EMM.STATE_KEY.STATE] = M.DOWNLOAD_STATE.STOPPED
      self._data.local_res_downloading_info[EMM.STATE_KEY.ERR_CODE] = 0
      self._data.local_res_downloading_info[EMM.STATE_KEY.ERR_MSG] = nil
    elseif downloading_state == M.DOWNLOAD_STATE.COMPLETE then
      local res_location = local_cached_downloading_info[RTM.RES_STATE_INFO_KEY.RES_LOCATION]
      if res_location then
        local res_exists = ERS.is_res_exists(res_location)
        self:log_debug("_do_check_local_res_state, downloading state is complete, and reslocation exists:" .. tostring(res_exists) .. ", loc:" .. tostring(res_location))
        if not res_exists then
          self:_reset_downloading_info()
        end
        QL.commit_action_main("res_check_local_res_state_complete", nil, res_exists)
      end
    end
  end
  if not self._data.using_res_state_info then
    self:_on_update_using_res_info(local_res_obj[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO])
  end
  self._data.has_checked_local_res = true
  self:update_cached_res_info()
  return true
end

function M:check_local_res_state(_cb)
  self:_do_check_local_res_state()
  if _cb then
    local res_state_info = self:get_res_state()
    _cb(res_state_info)
  end
end

function M:_on_download_progress_changed()
  self:log_debug("_on_download_progress_changed")
  for _, lis in ipairs(self._data.progress_listeners) do
    lis(self._data.namespace, self._data.res_key, self._data.current_down_progress_info)
  end
end

function M:_on_update_download_progress(downloading_size, total_size, progress_info)
  if self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.STATE] == M.DOWNLOAD_STATE.UNKNOWN then
    self:log_debug("skip update progress, for download state is unkonwn state")
    return
  end
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  progress_info = progress_info or {}
  if downloading_size < 0 then
    downloading_size = progress_info[EMM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] or 0
  end
  if total_size < 0 then
    total_size = progress_info[EMM.PROGRESS_INFO_KEY.TOTAL_SIZE] or 0
  end
  local percent = 0
  if total_size > 0 then
    percent = math.floor(downloading_size / total_size * 100)
  end
  local last_percent = self._data.current_down_progress_info[EMM.PROGRESS_INFO_KEY.PERCENT] or 0
  self._data.current_down_progress_info = progress_info
  self._data.current_down_progress_info[EMM.PROGRESS_INFO_KEY.PERCENT] = percent
  _ejoysdk.log("request_file: download_progress_changed_listener changed, percent:" .. tostring(progress_info[EMM.PROGRESS_INFO_KEY.PERCENT]) .. ", total_size:" .. tostring(total_size) .. ", downloading_size:" .. tostring(downloading_size) .. ", downloadig M:" .. tostring(downloading_size / 1024 / 1024) .. ", last_item:" .. tostring(progress_info[EMM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM]))
  self:_on_download_progress_changed()
  if percent - last_percent > 2 or 100 == percent then
    self:log_debug("save progress info，percent:" .. tostring(percent))
    self:update_cached_res_info()
  end
end

function M:_get_target_res_save_full_path(save_base_path, save_storage_type)
  self:log_debug("_get_target_res_save_full_path save_base_path:" .. tostring(save_base_path) .. ", save_storage_type:" .. tostring(save_storage_type))
  local full_path
  if save_base_path and "" ~= save_base_path then
    local root_path
    if save_storage_type == RTM.STORAGE_TYPE.EXTERNAL_APP_PRIVATE then
      root_path = ERB.static_get_storage_path_by_type(RTM.STORAGE_TYPE.EXTERNAL_APP_PRIVATE)
    elseif save_storage_type == RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE then
      root_path = ERB.static_get_storage_path_by_type(RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE)
    else
      root_path = nil
    end
    if not root_path then
      full_path = save_base_path
    else
      root_path = E.Utils.trim_end(root_path, "/")
      save_base_path = E.Utils.trim_start(save_base_path, "/")
      full_path = root_path .. "/" .. save_base_path
    end
  end
  self:log_debug("_get_target_res_save_full_path:" .. tostring(full_path))
  return full_path
end

function M:_get_custom_res_save_full_path()
  local full_path = self:_get_target_res_save_full_path(self._data.custom_res_save_base_path, self._data.custom_res_save_storage_type)
  self:log_debug("_get_custom_res_save_full_path:" .. tostring(full_path))
  return full_path
end

function M:move_res_to_path(origin_res_location, save_base_path, save_storage_type, update_location, cb)
  local custom_full_path = self:_get_target_res_save_full_path(save_base_path, save_storage_type)
  self:log_debug("custom_full_path is " .. tostring(custom_full_path))
  self:log_debug("origin_res_location is " .. tostring(origin_res_location))
  local skip_rename = false
  local stat_params = {}
  
  local function cb_wrapper(_rename_result, _res_location, _rename_msg)
    if _rename_result and custom_full_path and "" ~= custom_full_path then
      _res_location = custom_full_path
      self:log_debug("callback custom_full_path is " .. tostring(custom_full_path))
      self:log_debug("save to dir succ:" .. tostring(_res_location))
      RSTAT.stat("res_check_mv_rs_result", custom_full_path, true, stat_params)
    else
      RSTAT.stat_err("res_check_mv_rs_result", custom_full_path, CC.RESOURCE_UPDATE_ERROR_CODES.RES_RENAME_PATH_FAILED, _rename_msg, stat_params)
    end
    if update_location then
      self:log_debug("update res location:" .. tostring(_res_location))
      self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.RES_LOCATION] = _res_location
      self:update_cached_res_info()
    end
    self:log_debug(skip_rename and "custom_full_path is nil, skip move" or "move_res_to_path result " .. tostring(_rename_result))
    cb(_rename_result, _res_location)
  end
  
  local res_location = origin_res_location
  local rename_result, msg
  if custom_full_path and "" ~= custom_full_path then
    self:log_debug("res download complete, and custom_full_path not nil, try move it there:" .. tostring(custom_full_path) .. ", loc:" .. tostring(res_location))
    local custom_parent_dir = ERU.get_parent_folder(custom_full_path)
    if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
      local mk_result = E.File.make_dirs(custom_parent_dir)
      self:log_debug("make dirs result:" .. tostring(mk_result) .. ", dir:" .. tostring(custom_parent_dir))
    end
    rename_result, msg = ERU.os_rename(res_location, custom_full_path)
    stat_params.stat_state = "all_rename_fail"
    if not rename_result then
      local ECC = require("ejoysdk_lua.ejoysdk_constants")
      local is_support_batch_operation = E.is_support_function(ECC.NATIVE_SUPPORT_FUNCTION_NAMES.BATCH_FILE_OPERATION)
      if is_support_batch_operation and res_location then
        E.File.list_directory(res_location, true, true, function(result)
          if result and next(result) then
            local rename_map = {}
            for _, file in ipairs(result) do
              if not file.is_dir then
                local key = E.Utils.trim_end(res_location, "/") .. "/" .. file.path
                local value = E.Utils.trim_end(custom_full_path, "/") .. "/" .. file.path
                rename_map[key] = value
              end
            end
            E.File.batch_rename(rename_map, function(rename_succ, ...)
              if rename_succ then
                stat_params.stat_state = "second_batch_rename_succ"
                rename_result = true
                E.File.remove_fullpath(res_location)
                cb_wrapper(rename_result, res_location)
              else
                stat_params.stat_state = "second_batch_rename_fail"
                rename_result = false
                local batch_rename_code, batch_rename_msg, batch_rename_ext = ...
                self:log_warn("res download complete, batch rename fail, code is " .. tostring(batch_rename_code) .. ", msg is " .. tostring(batch_rename_msg))
                if batch_rename_ext and next(batch_rename_ext) then
                  local retry_copy_map = {}
                  for rename_fail_file_path, _ in pairs(batch_rename_ext) do
                    retry_copy_map[rename_fail_file_path] = rename_map[rename_fail_file_path]
                  end
                  self:log_debug("batch rename fail, now try batch copy")
                  E.File.batch_copy(retry_copy_map, function(batch_copy_result, ...)
                    rename_result = batch_copy_result
                    if not batch_copy_result then
                      stat_params.stat_state = "thrid_batch_copy_fail"
                      local retry_copy_code, retry_copy_msg, retry_batch_copy_ext = ...
                      self:log_warn("res download complete, retry batch copy fail, code is " .. tostring(retry_copy_code) .. ", msg is " .. tostring(retry_copy_msg))
                      self:log_warn(retry_batch_copy_ext)
                      cb_wrapper(rename_result, res_location, retry_copy_msg)
                    else
                      stat_params.stat_state = "thrid_batch_copy_succ"
                      E.File.remove_fullpath(res_location)
                      cb_wrapper(rename_result, res_location)
                    end
                  end, {is_fullpath = true, override = true})
                else
                  cb_wrapper(rename_result, res_location, "batch rename fail, but batch_rename_ext is empty")
                end
              end
            end, {is_fullpath = true})
          elseif result then
            cb_wrapper(true, res_location, "res_location is empty")
          end
        end)
      else
        self:log_warn("res download complete, rename1 result:" .. tostring(rename_result) .. ", msg:" .. tostring(msg) .. ", to:" .. tostring(custom_full_path))
        E.File.remove_fullpath(custom_full_path)
        rename_result, msg = ERU.os_rename(res_location, custom_full_path)
        self:log_warn("res download complete, rename2 result:" .. tostring(rename_result) .. ", msg:" .. tostring(msg) .. ", to:" .. tostring(custom_full_path))
        if rename_result then
          stat_params.stat_state = "second_rename_succ"
        end
        cb_wrapper(rename_result, res_location, msg)
      end
    else
      stat_params.stat_state = "first_rename_succ"
      cb_wrapper(rename_result, res_location, msg)
    end
  else
    self:log_debug("res download complete, but custom_full_path is nil or empty string, skip move, wait for next engine handler move, loc:" .. tostring(res_location))
    skip_rename = true
    rename_result = true
    cb_wrapper(rename_result, res_location)
  end
end

function M:_on_process_res_download_complete(cb)
  local res_version = self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME]
  local res_location = self._data.res_src_instance:get_res_version_path(res_version)
  self:move_res_to_path(res_location, self._data.custom_res_save_base_path, self._data.custom_res_save_storage_type, nil, function(_rename_result, _res_location)
    self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.RES_LOCATION] = _res_location
    self:log_debug("download complete state, now update res location:" .. tostring(res_location) .. ", to:" .. tostring(_res_location))
    if not _rename_result then
      cb(false, CC.RESOURCE_UPDATE_ERROR_CODES.RES_RENAME_PATH_FAILED, "rename res path failed")
    else
      cb(true)
    end
  end)
end

function M:_on_notify_res_state_changed(_state, _state_obj)
  self:log_debug("_on_notify_res_state_changed:" .. tostring(_state))
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.STATE] = _state
  self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.ERR_CODE] = _state_obj[EMM.STATE_KEY.ERR_CODE]
  self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.ERR_MSG] = _state_obj[EMM.STATE_KEY.ERR_MSG]
  if _state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
    self:_on_process_res_download_complete(function(process_result, _code, _msg)
      if not process_result then
        self:log_warn("_on_notify_res_state_changed complete, but process download complete failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
        self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.STATE] = RTM.PUBLIC_DOWNLOAD_STATE.FAILED
        self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.ERR_CODE] = _code
        self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.ERR_MSG] = _msg
      end
      local state_copy = utils.deepcopy(self._data.local_res_downloading_info)
      for _, lis in ipairs(self._data.state_listeners) do
        lis(self._data.namespace, self._data.res_key, _state, state_copy)
      end
      self:update_cached_res_info()
    end)
  else
    local state_copy = utils.deepcopy(self._data.local_res_downloading_info)
    for _, lis in ipairs(self._data.state_listeners) do
      lis(self._data.namespace, self._data.res_key, _state, state_copy)
    end
    self:update_cached_res_info()
  end
end

function M:get_res_state(info_flags)
  self:_do_check_local_res_state()
  local res_state = {
    [RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] = self._data.res_update_info,
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO] = self._data.local_res_downloading_info,
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] = self._data.current_down_progress_info,
    [RTM.INFO_TYPE_KEY.TYPE_USING_RES_INFO] = self._data.using_res_state_info
  }
  info_flags = info_flags or {}
  if info_flags.pending_file_list then
    self:log_debug("get_res_state with pending_file_list on, add pending_file_list info")
    res_state[RTM.INFO_TYPE_KEY.TYPE_PENDING_FILE_LIST_INFO] = self._data.pending_file_list_info
  end
  local copy_state = utils.deepcopy(res_state)
  return copy_state
end

function M:get_res_location()
end

function M:_reset_downloading_info()
  self:log_debug("_reset_downloading_info begin")
  self._data.local_res_downloading_info = {
    [RTM.RES_STATE_INFO_KEY.STATE] = M.DOWNLOAD_STATE.UNKNOWN,
    [RTM.RES_STATE_INFO_KEY.VERSION_NAME] = nil,
    [RTM.RES_STATE_INFO_KEY.FILE_LIST_TYPE] = RTM.FILE_LIST_TYPE.UNKNOWN,
    [RTM.RES_STATE_INFO_KEY.RES_LOCATION] = nil,
    [RTM.RES_STATE_INFO_KEY.ERR_CODE] = 0,
    [RTM.RES_STATE_INFO_KEY.ERR_MSG] = nil,
    [RTM.RES_STATE_INFO_KEY.LOCAL_VERSION] = nil
  }
  self._data.current_down_progress_info = {
    [RTM.PROGRESS_INFO_KEY.PERCENT] = 0,
    [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = 0,
    [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = 0,
    [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = 0,
    [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = 0,
    [RTM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = nil,
    [RTM.PROGRESS_INFO_KEY.SPEED] = 0
  }
end

function M:_reset_downloading_state()
  self:log_debug("_reset_downloading_state begin")
  self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.STATE] = M.DOWNLOAD_STATE.UNKNOWN
  self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.ERR_CODE] = 0
  self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.ERR_MSG] = nil
end

function M:remove_res(res_version)
  self:log_debug("remove_res begin, ns:" .. tostring(self._data.namespace) .. ", res_key:" .. tostring(self._data.res_key) .. ", ver:" .. tostring(res_version))
  self:_do_check_local_res_state()
  local cur_download_res_version = self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME]
  if 0 == utils.version_compare(cur_download_res_version, res_version) then
    self:log_debug("remove_res targetver:" .. tostring(res_version) .. ", cur:" .. tostring(cur_download_res_version))
    self:_reset_downloading_info()
    self:update_cached_res_info()
  end
  ERS.static_remove_downloading_version(self._data.namespace, self._data.res_key, res_version, self._data.opts)
end

function M:_do_start_download(res_file_list_info, last_finish_downloading_size, total_size, last_finish_count, file_count)
  local file_list = res_file_list_info.file_list or {}
  local file_ext = res_file_list_info.file_ext or {}
  file_ext.backup_urls = self._data.download_address_list
  file_ext.tag = self._data.namespace .. "-" .. self._data.res_key
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  self:log_debug("start download, downloading_size:" .. tostring(last_finish_downloading_size) .. ", total_size:" .. tostring(total_size) .. ", cnt:" .. tostring(file_count))
  local total_need_download_size = file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_TOTAL_SIZE]
  local is_available, available_size = RTM.check_storage_available(total_need_download_size)
  local check_avaiable_cost_time = RTM.get_available_storage_cost_time()
  local stat_params = {p1 = available_size}
  if not is_available then
    local state_obj = {
      [EMM.STATE_KEY.STATE] = EMM.DOWNLOAD_STATE.FAILED,
      [EMM.STATE_KEY.ERR_CODE] = EC.DOWNLOAD_ERROR_CODES.DOWNLOAD_DISK_NOT_ENOUGH,
      [EMM.STATE_KEY.ERR_MSG] = "not enough disk to download, available:" .. tostring(available_size)
    }
    self:_on_notify_res_state_changed(EMM.DOWNLOAD_STATE.FAILED, state_obj)
    self:log_warn("check available storage not enough, check cost:" .. tostring(check_avaiable_cost_time))
    RSTAT.stat("res_check_storage_enough", RTM.get_available_storage_cost_time(), false, stat_params)
    return
  else
    RSTAT.stat("res_check_storage_enough", RTM.get_available_storage_cost_time(), true, stat_params)
    self:log_debug("check available storage succ:" .. tostring(available_size) .. ", check_cost:" .. tostring(check_avaiable_cost_time))
  end
  local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
  local multi_model = EMF.get_http_res_multi_model(self._data.multi_download_model_name)
  local _opts_foreground_notification_enabled = true
  if self._data.foreground_notification_enabled ~= nil then
    _opts_foreground_notification_enabled = self._data.foreground_notification_enabled
  end
  local _opts = {
    enable_download_range = true,
    storage_type = EMM.STORAGE_TYPE.EXTERNAL_OTHER,
    foreground_notification_enabled = _opts_foreground_notification_enabled,
    submit_all_gametime_max_cost_ms = self._data.submit_all_task_cost_per_sec,
    notification_present_ext = {
      base_finish_downloading_size = last_finish_downloading_size,
      base_finish_count = last_finish_count,
      base_total_size = total_size,
      custom_config = self._data.foreground_notification_custom_config
    },
    progress_notify_interval_millis = self._data.opts.progress_update_interval_sec and self._data.opts.progress_update_interval_sec * 1000 or nil,
    all_files_in_list_incomplete = true,
    ext = (self._data.opts or {}).ext
  }
  E.log("opts >")
  E.log(_opts)
  local task, code, msg
  task, code, msg = multi_model:create_task(file_list, file_ext, _opts, function(_state, _state_obj)
  end, function(progress_info)
    progress_info.downloading_size = progress_info.downloading_size or 0
    local cur_downloading_size = last_finish_downloading_size + progress_info[EMM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE]
    local cur_finish_count = last_finish_count + progress_info[EMM.PROGRESS_INFO_KEY.FINISH_COUNT]
    local cur_speed = progress_info[EMM.PROGRESS_INFO_KEY.SPEED]
    local last_finish_file = progress_info[EMM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] or {}
    local last_to_biz_file_item = {
      [M.FILE_LIST_ITEM_KEY.KEY_TO] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_DEST_PATH],
      [M.FILE_LIST_ITEM_KEY.KEY_FROM] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_PATH],
      [M.FILE_LIST_ITEM_KEY.KEY_SIZE] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_SIZE],
      [M.FILE_LIST_ITEM_KEY.KEY_MD5] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_MD5]
    }
    local pinfo = {
      [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = file_count,
      [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = cur_finish_count,
      [RTM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = last_to_biz_file_item,
      [RTM.PROGRESS_INFO_KEY.PERCENT] = 0,
      [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = total_size,
      [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = cur_downloading_size,
      [RTM.PROGRESS_INFO_KEY.SPEED] = cur_speed
    }
    self:log_debug("progress_info, cur_downloading_size:" .. tostring(cur_downloading_size) .. ", progress_info.downloading_size:" .. tostring(progress_info.downloading_size) .. ", total_size:" .. tostring(total_size) .. ", last_downloading_size:" .. tostring(last_finish_downloading_size) .. ", cur_finish_count:" .. tostring(cur_finish_count) .. ", file_count:" .. tostring(file_count) .. ", tid:" .. tostring(task:task_id()))
    self:_on_update_download_progress(cur_downloading_size, total_size, pinfo)
  end)
  if task then
    local task_agent = TA:New(task, self._data.download_strategy_type, function(agent_state, agent_state_info)
      if agent_state == TA.AGENT_STATE.COMPLETE then
        self:log_debug("download complete")
        local pi_complete = {
          [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = file_count,
          [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = file_count,
          [RTM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = nil,
          [RTM.PROGRESS_INFO_KEY.PERCENT] = 100,
          [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = total_size,
          [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = total_size,
          [RTM.PROGRESS_INFO_KEY.SPEED] = 0
        }
        self:_on_update_download_progress(total_size, total_size, pi_complete)
      elseif agent_state == TA.AGENT_STATE.FAILED then
        local _code = agent_state_info[EMM.STATE_KEY.ERR_CODE] or 0
        local _msg = agent_state_info[EMM.STATE_KEY.ERR_MSG]
        self:log_warn("download failed, code:" .. tostring(_code) .. ", msg：" .. tostring(_msg))
      end
      self:_on_notify_res_state_changed(agent_state, agent_state_info)
    end)
    self._data.task_agent = task_agent
    task_agent:open()
  else
    self:log_warn("create_task failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    local state_obj = {
      [EMM.STATE_KEY.STATE] = EMM.DOWNLOAD_STATE.FAILED,
      [EMM.STATE_KEY.ERR_CODE] = code,
      [EMM.STATE_KEY.ERR_MSG] = msg
    }
    self:_on_notify_res_state_changed(EMM.DOWNLOAD_STATE.FAILED, state_obj)
  end
end

function M:_start_check_download(confirm_cb)
  self:_reset_downloading_state()
  local last_downloading_info = self._data.local_res_downloading_info
  local _last_progress_info = self._data.current_down_progress_info
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_LOCAL_RES_CHECKING, self._data.namespace, self._data.res_key)
  local _before = E.system_clock()
  self._data.res_src_instance:check_update_file_list(last_downloading_info, self._data.download_address_list, self._data.res_update_info, function(succ, ...)
    local _after = E.system_clock()
    self:log_debug("check_update_file_list end, succ:" .. tostring(succ) .. ", cost:" .. tostring(_after - _before))
    if succ then
      local res_file_list_info, last_finish_downloading_size, total_size, last_finish_count, file_count = ...
      local file_list = res_file_list_info.file_list or {}
      local pending_list_count = #file_list
      self:_do_check_local_res_state()
      local cur_downloading_version = last_downloading_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME]
      local new_update_version = self._data.res_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
      local file_list_type = self._data.res_update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE]
      RTM.static_update_cached_res_info_by_type(self._data.namespace, self._data.res_key, RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE, self._data.res_update_info)
      local ret = utils.version_compare(cur_downloading_version, new_update_version)
      self:log_debug("check_update_file_list, cur_downloading_version:" .. tostring(cur_downloading_version) .. ", new_update_version:" .. tostring(new_update_version))
      if ret < 0 then
        self:log_debug("has newer update info, need remove current downloading one")
        self:_reset_downloading_info()
      else
        self:log_debug("current downloading is the newest, continue current downloading")
      end
      self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME] = new_update_version
      self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.FILE_LIST_TYPE] = file_list_type
      self._data.pending_file_list_info = file_list
      self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.LOCAL_VERSION] = self._data.using_res_state_info[RTM.USING_RES_STATE_INFO_KEY.VERSION_NAME]
      local pi = {
        [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = file_count,
        [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = last_finish_count,
        [RTM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = nil,
        [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = total_size,
        [RTM.PROGRESS_INFO_KEY.PERCENT] = 0,
        [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = last_finish_downloading_size,
        [RTM.PROGRESS_INFO_KEY.SPEED] = 0
      }
      
      local function download_handler()
        self:_on_update_download_progress(-1, -1, pi)
        self:update_cached_res_info()
        self:log_debug("create task begin, pending_list_count:" .. tostring(pending_list_count) .. ", last_finish_downloading_size:" .. tostring(last_finish_downloading_size))
        if 0 == pending_list_count then
          self:log_debug("check_update_file_list empty, directly return complete")
          local _state_obj = {
            [EMM.STATE_KEY.STATE] = EMM.DOWNLOAD_STATE.COMPLETE,
            [EMM.STATE_KEY.STATE_CHANGED] = true
          }
          self:_on_notify_res_state_changed(EMM.DOWNLOAD_STATE.COMPLETE, _state_obj)
          return
        end
        self:_do_start_download(res_file_list_info, last_finish_downloading_size, total_size, last_finish_count, file_count)
        RSTAT.stat_startup_res_download_list_check(self._data.namespace, self._data.res_key, res_file_list_info)
      end
      
      if not self._data.confirmed_download_versions[new_update_version] then
        self:log_debug("update version download not confirm:" .. tostring(new_update_version))
        local ER = require("ejoysdk_lua.res.ejoysdk_res")
        local res_state_info = utils.deepcopy(ER.get_res_state(self._data.namespace, self._data.res_key) or {})
        res_state_info[RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE][RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = total_size
        res_state_info[RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE][RTM.UPDATE_INFO_KEY.TOTAL_COUNT] = file_count
        res_state_info[RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] = pi
        END.dispatch_res_update_confirm(self._data.namespace, self._data.res_key, res_state_info, function(confirm_download)
          local simple_res_state = ER.get_simple_res_state(res_state_info)
          local has_new_update = simple_res_state.has_new_update or false
          if true == has_new_update and true == confirm_download then
            self:log_debug("update version download confirmed:" .. tostring(new_update_version))
            self._data.confirmed_download_versions[new_update_version] = true
            download_handler()
          else
            confirm_cb(false, RTM.PUBLIC_DOWNLOAD_STATE.SKIP, "no any updates")
          end
        end)
      else
        self:log_debug("update version download already confirmed:" .. tostring(new_update_version))
        download_handler()
      end
    else
      local code, msg = ...
      self:log_warn("check_update_file_list failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      local state_obj = {
        [EMM.STATE_KEY.STATE] = EMM.DOWNLOAD_STATE.FAILED,
        [EMM.STATE_KEY.ERR_CODE] = code,
        [EMM.STATE_KEY.ERR_MSG] = msg
      }
      self:_on_notify_res_state_changed(EMM.DOWNLOAD_STATE.FAILED, state_obj)
    end
  end)
end

function M:start_download(confirm_cb)
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  if not self._data.res_update_info[RTM.UPDATE_INFO_KEY.HAS_NEW_UPDATE] and not self._data.force_check_update then
    self:log_debug("start_download received, not has update, skip")
    local _state_obj = {
      [EMM.STATE_KEY.STATE] = EMM.DOWNLOAD_STATE.COMPLETE,
      [EMM.STATE_KEY.STATE_CHANGED] = true
    }
    self:_on_notify_res_state_changed(EMM.DOWNLOAD_STATE.COMPLETE, _state_obj)
    return
  end
  
  local function __start_check_download()
    local ER = require("ejoysdk_lua.res.ejoysdk_res")
    local SU = require("ejoysdk_lua.res.startup.startup_utils")
    local res_state_info = ER.get_res_state(self._data.namespace, self._data.res_key) or {}
    local cur_update_version = (res_state_info[RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] or {}).version
    if not SU.can_reuse_res() and self._data.confirmed_download_versions[cur_update_version] ~= true then
      local res_download_info = res_state_info[RTM.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO] or {}
      local downloading_version = res_download_info.version
      
      local function __res_update_confirm(confirm_download)
        if confirm_download then
          self:log_debug("update version download confirmed:" .. tostring(cur_update_version))
          self._data.confirmed_download_versions[cur_update_version] = true
          self:_start_check_download(confirm_cb)
        else
          self:log_warn("user reject download, now return download failed")
          confirm_cb(false, RTM.PUBLIC_DOWNLOAD_STATE.SKIP, "reject to download, confirm false")
        end
      end
      
      if downloading_version and cur_update_version and 0 == EU.version_compare(downloading_version, cur_update_version) then
        local copy_res_state_info = res_state_info
        END.dispatch_res_update_confirm(self._data.namespace, self._data.res_key, copy_res_state_info, __res_update_confirm)
      else
        END.dispatch_res_update_confirm(self._data.namespace, self._data.res_key, res_state_info, __res_update_confirm)
      end
    else
      self:_start_check_download(confirm_cb)
    end
  end
  
  if self:current_download_state() == M.DOWNLOAD_STATE.DOWNLOADING then
    self:log_debug("start_download current is downloading")
    local update_ver = self._data.res_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
    local downloading_ver = self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME]
    if update_ver == downloading_ver then
      self:log_debug("start_download current downloading ver equals newest update, so return")
      return
    else
      self:log_debug("start_download, current downloading, now pause first")
      self:pause_download(function(_succ)
        self:log_debug("start_download, current pause finish, now download begin")
        __start_check_download()
      end)
    end
  else
    self:log_debug("start_download, current not downloading, now download begin")
    __start_check_download()
  end
  return true
end

function M:pause_download(_cb)
  if not self._data.task_agent then
    self:log_warn("pause_download skip, for no current download task")
    _cb(true)
    return
  end
  self._data.task_agent:close(function(succ, ...)
    if succ then
      self:log_debug("stop_download succ")
    else
      local code, msg = ...
      self:log_warn("stop_download failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    _cb(succ, ...)
  end)
end

function M:cancel_download(cb)
  self:pause_download(function(succ, ...)
    if succ then
      self:log_debug("cancel downloading succ")
      local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
      local state_obj = {
        [EMM.STATE_KEY.STATE] = EMM.DOWNLOAD_STATE.FAILED,
        [EMM.STATE_KEY.ERR_CODE] = EC.DOWNLOAD_ERROR_CODES.CANCELLED,
        [EMM.STATE_KEY.ERR_MSG] = "cancel update"
      }
      self:_on_notify_res_state_changed(EMM.DOWNLOAD_STATE.FAILED, state_obj)
    else
      self:log_debug("cancel downloading failed")
    end
    cb(succ, ...)
  end)
end

function M:resume_download()
  assert(false, "resume_download not implements")
end

function M:is_download_paused()
  assert(false, "is_download_paused not implements")
end

function M:set_download_speed()
  assert(false, "set_download_speed not implements")
end

function M:register_res_state_listener(_listener)
  for _, listener in ipairs(self._data.state_listeners) do
    if listener == _listener then
      return
    end
  end
  local len = #self._data.state_listeners
  self._data.state_listeners[len + 1] = _listener
end

function M:unregister_res_state_listener(_listener)
  local new = {}
  for _, listener in ipairs(self._data.state_listeners) do
    if _listener ~= listener then
      new[#new + 1] = listener
    end
  end
  self._data.state_listeners = new
end

function M:register_progress_listener(_listener)
  for _, listener in ipairs(self._data.progress_listeners) do
    if listener == _listener then
      return
    end
  end
  local len = #self._data.progress_listeners
  self._data.progress_listeners[len + 1] = _listener
end

function M:unregister_progress_listener(_listener)
  local new = {}
  for _, listener in ipairs(self._data.progress_listeners) do
    if _listener ~= listener then
      new[#new + 1] = listener
    end
  end
  self._data.progress_listeners = new
end

function M:current_download_state()
  return self._data.local_res_downloading_info and self._data.local_res_downloading_info[RTM.RES_STATE_INFO_KEY.STATE]
end

function M:update_using_res_version(res_version, res_project_name, res_type)
  self:log_debug("update_using_res_version:" .. tostring(res_version) .. ", project name is " .. tostring(res_project_name) .. ", res_type is " .. tostring(res_type))
  local using_res_info = {
    [RTM.USING_RES_INFO_PARAM_KEY.VERSION] = res_version,
    [RTM.USING_RES_INFO_PARAM_KEY.RES_TYPE] = res_type,
    [RTM.USING_RES_INFO_PARAM_KEY.PROJECT_NAME] = res_project_name or ""
  }
  self:_on_update_using_res_info(using_res_info)
end

function M:get_model_name()
  return self._data.model_name
end

function M:update_res_download_strategy(strategy)
  if not strategy then
    self:log_warn("update_res_download_strategy skip, for strategy is nil")
    return
  end
  self:log_debug("model update_res_download_strategy:" .. tostring(strategy))
  self._data.download_strategy_type = strategy
end

function M:download_res_files(file_path_list, opts, state_listener, progress_listener)
  local EMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
  opts = opts or {}
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local current_update_info_ver = self._data.res_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
  local ns_res_key_path_base = RTM.static_get_res_storage_rela_path(namespace, res_key)
  local res_ver_path = ns_res_key_path_base .. tostring(current_update_info_ver)
  local _temp_base_dir = res_ver_path .. "/" .. QZ_ORIGIN_TEMP_FILES_DIR
  local storage_type = opts.storage_type or RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  local storage_path = ERB.static_get_storage_path_by_type(storage_type)
  storage_path = E.Utils.trim_end(storage_path, "/")
  local _temp_dest_dir = _temp_base_dir
  if storage_path then
    _temp_dest_dir = storage_path .. "/" .. _temp_base_dir
  end
  self:log_debug("download_res_files ns:" .. tostring(namespace) .. ", rk:" .. tostring(res_key) .. ", uv:" .. tostring(current_update_info_ver) .. ", tbr:" .. tostring(_temp_base_dir) .. ", tdr:" .. tostring(_temp_dest_dir))
  local ext_info = {ejoy_temp_base_dir = _temp_base_dir, ejoy_temp_dest_abs_dir = _temp_dest_dir}
  
  local function on_state_result_handler(succ, ...)
    if succ then
      local _state, _state_obj = ...
      self:log_debug("download_res_files succ, _state:" .. tostring(_state))
      E.log(_state_obj)
      E.log(ext_info)
      if state_listener then
        state_listener(_state, _state_obj, ext_info)
      end
    else
      local code, msg = ...
      self:log_warn("download_res_files failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      local state_obj = {
        [EMM.STATE_KEY.STATE] = EMM.DOWNLOAD_STATE.FAILED,
        [EMM.STATE_KEY.ERR_CODE] = code,
        [EMM.STATE_KEY.ERR_MSG] = msg
      }
      if state_listener then
        state_listener(EMM.DOWNLOAD_STATE.FAILED, state_obj)
      end
    end
  end
  
  local list_size = file_path_list and #file_path_list or 0
  if 0 == list_size then
    self:log_warn("download_res_files skip, for file list is empty")
    on_state_result_handler(false, CC.RESOURCE_UPDATE_ERROR_CODES.RES_FILE_LIST_EMPTY, "file list empty")
    return
  end
  if not current_update_info_ver or "" == current_update_info_ver then
    self:log_warn("download_res_files failed, current_update_info_ver is empty")
    on_state_result_handler(false, CC.RESOURCE_UPDATE_ERROR_CODES.RES_VERSION_NOT_EXISTS, "version not exists")
    return
  end
  local update_body = self._data.res_update_info[RTM.UPDATE_INFO_KEY.UPDATE_BODY]
  local origin_obj = update_body[RTM.RES_CONFIG_KEY.KEY_ORIGIN] or {}
  local folder = origin_obj[RTM.RES_CONFIG_KEY.KEY_FOLDER] or ""
  local base_url = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_URL]
  local base_path = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_PATH]
  if folder and "" ~= folder then
    folder = E.Utils.trim_chars(folder, "/")
  end
  if base_path and "" ~= base_path then
    base_path = E.Utils.trim_chars(base_path, "/")
  end
  local url_info = E.HTTP.parse(base_url)
  local url_prefix = url_info.scheme .. "://" .. url_info.host
  local file_ext = {}
  file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_BASE_URL] = url_prefix
  file_ext.backup_urls = self._data.download_address_list
  local total_size = 0
  local pending_download_list = {}
  
  local function prepare_origin_list_handler(_file_list)
    self:log_debug("download_res_files, file item is table, now parse item path, size, md5, list_size:" .. tostring(#_file_list))
    for _, f_item in ipairs(_file_list) do
      f_item.path = E.Utils.trim(f_item.path)
      f_item.size = f_item.size or 0
      total_size = total_size + f_item.size
      local remote_path
      if not EU.is_text_empty(folder) then
        remote_path = folder .. "/" .. tostring(f_item.path)
      else
        remote_path = f_item.path
      end
      if not EU.is_text_empty(base_path) then
        remote_path = base_path .. "/" .. remote_path
      end
      local file_name = f_item.name
      file_name = file_name or EHU.guess_url_filename(remote_path)
      local dest_path = f_item.dest_path
      if not dest_path then
        self:log_debug("download_res_files no dest_path, now download to local cache")
        local path_parent_folder = ""
        if f_item.path then
          path_parent_folder = EHU.get_parent_folder(f_item.path)
        end
        if path_parent_folder and "" ~= path_parent_folder then
          dest_path = _temp_base_dir .. "/" .. tostring(path_parent_folder)
        else
          dest_path = _temp_base_dir
        end
      end
      dest_path = E.Utils.trim_end(dest_path, "/")
      local down_item = {
        [RTM.MULTI_TASK_INFO_KEY.KEY_PATH] = remote_path,
        [RTM.MULTI_TASK_INFO_KEY.KEY_DEST_PATH] = dest_path,
        [RTM.MULTI_TASK_INFO_KEY.KEY_MD5] = f_item.md5,
        [RTM.MULTI_TASK_INFO_KEY.KEY_SIZE] = f_item.size,
        [RTM.MULTI_TASK_INFO_KEY.KEY_NAME] = file_name
      }
      table.insert(pending_download_list, down_item)
    end
    file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_TOTAL_SIZE] = total_size
    local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
    local multi_model = EMF.get_http_res_multi_model(self._data.model_name_patch_fix)
    local total_download_count = #pending_download_list
    self:log_debug("download_res_files begin, size:" .. tostring(total_download_count))
    E.log(file_ext)
    E.log(opts)
    local task, code, msg = multi_model:create_task(pending_download_list, file_ext, opts, function(_state, _state_obj)
      if _state == EMM.DOWNLOAD_STATE.COMPLETE then
        self:log_debug("download_res_files complete")
        local pi_complete = {
          [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = total_download_count,
          [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = total_download_count,
          [RTM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = nil,
          [RTM.PROGRESS_INFO_KEY.PERCENT] = 100,
          [RTM.PROGRESS_INFO_KEY.SPEED] = 0
        }
        if progress_listener then
          progress_listener(pi_complete)
        end
        self:log_debug("download_res_files succ, state:" .. tostring(_state) .. " >>")
        E.log(_state_obj)
        on_state_result_handler(true, _state, _state_obj)
      elseif _state == EMM.DOWNLOAD_STATE.FAILED then
        local code = _state_obj[EMM.STATE_KEY.ERR_CODE] or 0
        local msg = _state_obj[EMM.STATE_KEY.ERR_MSG]
        self:log_warn("download_res_files download failed, code:" .. tostring(code) .. ", msg：" .. tostring(msg))
        on_state_result_handler(false, code, msg)
      else
        on_state_result_handler(true, _state, _state_obj)
      end
    end, function(progress_info)
      progress_info.downloading_size = progress_info.downloading_size or 0
      local cur_downloading_size = progress_info[EMM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE]
      local cur_finish_count = progress_info[EMM.PROGRESS_INFO_KEY.FINISH_COUNT]
      local cur_speed = progress_info[EMM.PROGRESS_INFO_KEY.SPEED]
      local last_finish_file = progress_info[EMM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] or {}
      local _total_size = progress_info[EMM.PROGRESS_INFO_KEY.TOTAL_SIZE] or 0
      local _percent = progress_info[EMM.PROGRESS_INFO_KEY.PERCENT] or 0
      local last_to_biz_file_item = {
        [M.FILE_LIST_ITEM_KEY.KEY_TO] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_DEST_PATH],
        [M.FILE_LIST_ITEM_KEY.KEY_FROM] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_PATH],
        [M.FILE_LIST_ITEM_KEY.KEY_SIZE] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_SIZE],
        [M.FILE_LIST_ITEM_KEY.KEY_MD5] = last_finish_file[RTM.MULTI_TASK_INFO_KEY.KEY_MD5]
      }
      local pinfo = {
        [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = total_download_count,
        [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = cur_finish_count,
        [RTM.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = last_to_biz_file_item,
        [RTM.PROGRESS_INFO_KEY.PERCENT] = _percent,
        [RTM.PROGRESS_INFO_KEY.SPEED] = cur_speed,
        [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = cur_downloading_size,
        [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = _total_size
      }
      self:log_debug("progress_info, cur_downloading_size:" .. tostring(cur_downloading_size) .. ", progress_info.downloading_size:" .. tostring(progress_info.downloading_size) .. ", cur_finish_count:" .. tostring(cur_finish_count) .. ", file_count:" .. tostring(list_size))
      if progress_listener then
        progress_listener(pinfo)
      end
    end)
    if task then
      task:start_download()
    else
      self:log_warn("create_task failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      on_state_result_handler(false, code, msg)
    end
  end
  
  local file_item_type = type(file_path_list[1])
  if "string" == file_item_type then
    self:log_debug("download_res_files, file item is string, now parse item as path")
    local file_list = {}
    self._data.res_src_instance:get_origin_file_list_info(current_update_info_ver, self._data.res_update_info, self._data.download_address_list, function(_succ, ...)
      if _succ then
        local origin_list_info = (...)
        if not origin_list_info or 0 == #origin_list_info then
          local _code = CC.RESOURCE_UPDATE_ERROR_CODES.RES_FILE_LIST_EMPTY
          local _msg = "origin file list empty"
          self:log_warn("download_res_files get_origin_file_list_info empty, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
          on_state_result_handler(false, _code, _msg)
          return
        end
        local origin_file_map = {}
        for _, origin_list_item in ipairs(origin_list_info) do
          local item_key = E.Utils.trim_chars(origin_list_item[RTM.FILE_LIST_ITEM_KEY.KEY_TO], "/")
          origin_file_map[item_key] = origin_list_item
        end
        for _, _path in ipairs(file_path_list) do
          local item_key = E.Utils.trim_chars(_path, "/")
          local origin_item = origin_file_map[item_key]
          if not origin_item then
            self:log_warn("file not exist, file is " .. tostring(item_key))
            break
          end
          local item_to = origin_item[RTM.FILE_LIST_ITEM_KEY.KEY_TO]
          local item_from = origin_item[RTM.FILE_LIST_ITEM_KEY.KEY_FROM]
          local file_name
          if item_to and "" ~= item_to then
            file_name = EHU.guess_url_filename(item_to)
          else
            file_name = EHU.guess_url_filename(item_from)
          end
          local _dest_path
          if nil == item_to then
            _dest_path = _temp_base_dir .. "/" .. item_from
            _dest_path = EHU.get_parent_folder(_dest_path)
          elseif "" == item_to then
            _dest_path = _temp_base_dir
          else
            _dest_path = _temp_base_dir .. "/" .. item_to
            _dest_path = EHU.get_parent_folder(_dest_path)
          end
          local f_item = {
            name = file_name,
            path = origin_item[RTM.FILE_LIST_ITEM_KEY.KEY_FROM],
            md5 = origin_item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5],
            size = origin_item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE],
            dest_path = _dest_path
          }
          table.insert(file_list, f_item)
        end
        prepare_origin_list_handler(file_list)
      else
        local _code, _msg = ...
        self:log_warn("create_task failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
        on_state_result_handler(false, _code, _msg)
      end
    end, true)
  else
    self:log_debug("download_res_files, file item is table, now directly prepare_origin_list_handler")
    prepare_origin_list_handler(file_path_list)
  end
end

function M:get_res_origin_file_list(groups, cb)
  local current_update_info_ver = self._data.res_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
  E.LOG.debug(TAG, "get_res_origin_file_list, current_update_info_ver:" .. tostring(current_update_info_ver))
  self._data.res_update_info = self._data.res_update_info
  current_update_info_ver = self._data.res_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
  self._data.res_src_instance:get_origin_file_list_for_groups(current_update_info_ver, self._data.res_update_info, self._data.download_address_list, groups, function(origin_list_info, ...)
    cb(origin_list_info, ...)
  end)
end

function M:get_download_strategy()
  E.LOG.debug(TAG, "get_download_strategy:" .. tostring(self._data.download_strategy_type))
  return self._data.download_strategy_type
end

return M

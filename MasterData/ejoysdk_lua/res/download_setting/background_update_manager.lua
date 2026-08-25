local E = require("ejoysdk_lua.ejoysdk")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local VC = require("ejoysdk_lua.ejoysdk_version_check")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local BACKGROUND_DOWNLOAD_ERROR_CODES = CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local AUU = require("ejoysdk_lua.res.download_url_utils")
local ES = require("ejoysdk_lua.ejoysdk_stat")
local TAG = "DOWNLOAD_SETTING#background_update_manager"
local EU = require("ejoysdk_lua.ejoysdk_utils")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local M = {}
local background_download_tasks = {}
local background_download_task_states = {}
local background_download_new_update_flags = {}
local background_download_card_configs = {}
M.REGISTERED_TASK_TYPES = {}
M.MODAL_TYPE = nil
M.BACKGROUND_UPDATE_TYPE = {
  PRE_DOWNLOAD = "pre_download",
  APP_UPDATE = "app_update",
  GROUPS_UPDATE = "groups_update"
}
M.REDDOT_TYPE = {
  NEW_DOWNLOAD = "new_download",
  NEW_UPDATE = "new_update"
}
M.REDDOT_BTN_TYPE = {
  DONWLOAD_RED_DOT = "download_red_dot",
  INSTALL_RED_DOT = "install_red_dot"
}
M.ERROR_TYPE = {
  NETWORK_ERROR = "network_error",
  OTHER_ERROR = "other_error"
}
M.TASK_UPDATE_STATE = {
  DOWNLOAD_NOT_STARTED = "download_not_started",
  DOWNLOADING = "downloading",
  DOWNLOAD_FAILED = "download_failed",
  DOWNLOAD_STOPPED = "download_stopped",
  DOWNLOAD_COMPLETE = "download_complete",
  DOWNLOAD_WAITING = "download_waiting",
  APPLYING = "applying",
  INSTALLING = "installing",
  INSTALL_FAILED = "install_failed",
  PKG_AUTO_REMOVED = "pkg_auto_removed",
  INSTALL_SUCCESS = "install_success"
}
M.BACK_UPDATE_RECORD = {}
M.network_state_listener = nil
local background_download_switch_key_store = E.LazyKeyStore:New("background_download_switch", false, false, false)
local background_download_user_close_key_store = E.LazyKeyStore:New("background_download_user_close", false, false, false)
local network_strategy_key_store = E.LazyKeyStore:New("background_download_network_strategy", false, false, false)
local new_version_modal_visible_key_store = E.LazyKeyStore:New("new_version_modal_visible", false, false, false)
local unlogin_reward_version_key_store = E.LazyKeyStore:New("unlogin_reward_version", false, true, false)
local task_progress_cache_key_store = E.LazyKeyStore:New("background_update_task_progress_cache", false, true, false)
local new_version_popup_key_store = E.LazyKeyStore:New("new_version_popup", false, true, false)
local CACHE_UPDATE_INTERVAL = 3000
local task_card_retention_period = 604800000
local background_download_guide_count_key_store = E.LazyKeyStore:New("background_download_guide_count")
local background_download_guide_last_time_key_store = E.LazyKeyStore:New("background_download_guide_last_time")
local background_download_guide_interval_time = 86400000
local MODAL_PAGEID_REGION_MAP = {
  cn = "69317c87ca826113888298dd",
  hk = "69493e98da51101151dd44bd",
  us = "69493eab800abb1de30fbf4d"
}
M.PRE_DOWNLOAD_REWARDS_DATA = {}

function M.get_new_version_modal_visible()
  local value = new_version_modal_visible_key_store:get()
  E.LOG.debug(TAG, "app_update: get new version modal visible: " .. tostring(value))
  if type(value) == "boolean" then
    return value
  elseif type(value) == "string" then
    return value:lower() == "true"
  else
    return false
  end
end

function M.set_new_version_modal_visible(value)
  new_version_modal_visible_key_store:set(tostring(value))
  E.LOG.debug(TAG, "app_update: after set new version modal visible: " .. new_version_modal_visible_key_store:get())
end

local function cache_task_info()
  local task_detail_cache = task_progress_cache_key_store:get() or {}
  M.get_tasks_detail({}, function(tasks_detail)
    for _, _task in ipairs(tasks_detail) do
      E.LOG.debug("register", "app_update: cache task info: " .. _task.taskId)
      E.log(_task)
      task_detail_cache[_task.taskId] = _task
    end
    task_progress_cache_key_store:set(task_detail_cache)
  end)
end

function M.get_task_info_from_cache()
  local task_detail_cache = task_progress_cache_key_store:get() or {}
  do return EU.deepcopy end
  return EU.deepcopy, task_detail_cache
end

function M.serialize_task_id(task_type, card_id)
  if card_id then
    return task_type .. "-" .. card_id
  else
    return task_type
  end
end

function M.deserialize_task_id(task_id)
  local separator_index = string.find(task_id, "-")
  if separator_index then
    local task_type = string.sub(task_id, 1, separator_index - 1)
    local card_id = string.sub(task_id, separator_index + 1)
    return {task_type = task_type, card_id = card_id}
  else
    return {task_type = task_id, card_id = nil}
  end
end

local function _wrapper_background_download_tasks(params, cb)
  E.LOG.debug(TAG, "_wrapper_background_download_tasks params: ")
  E.log(params)
  local task_type = params.task_type
  local task_instance = params.task_instance
  local task_id = params.task_id
  if not task_type then
    if cb then
      cb(false, "background update type is nil")
    end
    return
  end
  local type_supported = false
  for _, supported_type in pairs(M.BACKGROUND_UPDATE_TYPE) do
    if supported_type == task_type then
      type_supported = true
      break
    end
  end
  if not type_supported then
    if cb then
      cb(false, "unsupported background update type: " .. tostring(task_type))
    end
    return
  end
  local required_methods = {
    "start_task",
    "stop_task",
    "remove_task",
    "get_task_state",
    "get_task_info"
  }
  for _, method in ipairs(required_methods) do
    if type(task_instance[method]) ~= "function" then
      if cb then
        cb(false, "task_instance missing method: " .. method)
      end
      return
    end
  end
  if task_type == M.BACKGROUND_UPDATE_TYPE.APP_UPDATE and "function" ~= type(task_instance.install_task) then
    if cb then
      cb(false, "task_instance missing install method")
    end
    return
  end
  background_download_tasks[task_id] = task_instance
  E.LOG.debug(TAG, "wrapper all_background_download_tasks: ")
  E.log(background_download_tasks)
  cache_task_info()
  if cb then
    cb(true)
  end
end

function M.get_background_download_tasks()
  return background_download_tasks
end

function M.get_background_download_task_states()
  return background_download_task_states
end

local user_trigger_tasks_key_store = E.LazyKeyStore:New("user_trigger_tasks", false, true, false)

function M.add_user_trigger_task(task_id, version_name)
  if not task_id or not version_name then
    E.LOG.warn("add_user_trigger_task: task_id or version_name is nil")
    return
  end
  local user_trigger_tasks = user_trigger_tasks_key_store:get() or {}
  if not user_trigger_tasks[task_id] then
    user_trigger_tasks[task_id] = {}
  end
  local version_exists = false
  for _, existing_version in ipairs(user_trigger_tasks[task_id]) do
    if existing_version == version_name then
      version_exists = true
      break
    end
  end
  if not version_exists then
    table.insert(user_trigger_tasks[task_id], version_name)
    user_trigger_tasks_key_store:set(user_trigger_tasks)
    E.LOG.debug("add_user_trigger_task: added task_id=" .. task_id .. ", version=" .. version_name)
  else
    E.LOG.debug("add_user_trigger_task: task_id=" .. task_id .. ", version=" .. version_name .. " already exists")
  end
end

function M.is_user_triggered_task(task_id, version_name)
  if not task_id or not version_name then
    return false
  end
  local user_trigger_tasks = user_trigger_tasks_key_store:get() or {}
  local task_versions = user_trigger_tasks[task_id]
  if not task_versions then
    return false
  end
  for _, existing_version in ipairs(task_versions) do
    if existing_version == version_name then
      return true
    end
  end
  return false
end

function M.get_user_trigger_tasks()
  return user_trigger_tasks_key_store:get() or {}
end

function M.clear_user_trigger_tasks()
  user_trigger_tasks_key_store:set({})
end

function M.get_background_network_strategy()
  return network_strategy_key_store:get() or NS.STRATEGY.WIFI_ONLY
end

function M.set_background_network_strategy(strategy)
  if strategy == NS.STRATEGY.WIFI_ONLY or strategy == NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK then
    network_strategy_key_store:set(strategy)
  else
    E.LOG.warn("set_background_network_strategy: invalid strategy")
  end
end

function M.record_current_version_and_timestamp(params)
  params.current_timestamp = E.time_ms_server_or_local()
  if not (params and params.current_version) or not params.current_timestamp then
    E.LOG.warn("record_current_version_and_timestamp: params or required fields are nil")
    return
  end
  if not M.BACK_UPDATE_RECORD then
    M.BACK_UPDATE_RECORD = {}
  elseif type(M.BACK_UPDATE_RECORD) ~= "table" then
    E.LOG.warn("record_current_version_and_timestamp: M.BACK_UPDATE_RECORD is not a table, reinitializing")
    M.BACK_UPDATE_RECORD = {}
  end
  local version_exists = false
  for _, record in ipairs(M.BACK_UPDATE_RECORD) do
    if record.current_version == params.current_version then
      version_exists = true
      break
    end
  end
  if not version_exists then
    table.insert(M.BACK_UPDATE_RECORD, {
      current_version = params.current_version,
      current_timestamp = params.current_timestamp
    })
    E.LOG.debug("record_current_version_and_timestamp: recorded version=" .. params.current_version .. ", timestamp=" .. params.current_timestamp)
  else
    E.LOG.debug("record_current_version_and_timestamp: version " .. params.current_version .. " already exists, skipping")
  end
end

function M.get_background_download_switch_state()
  local value = background_download_switch_key_store:get()
  if nil == value then
    return false
  end
  if type(value) == "boolean" then
    return value
  elseif type(value) == "string" then
    return value:lower() == "true"
  else
    return false
  end
end

function M.set_background_download_switch_state(state)
  if type(state) == "boolean" then
    E.LOG.debug(TAG, "set_background_download_switch_state: " .. tostring(state))
    background_download_switch_key_store:set(tostring(state))
    if false == state then
      M.set_new_version_modal_visible("false")
      background_download_user_close_key_store:set("true")
    else
      local new_version_modal_state = new_version_modal_visible_key_store:get()
      if not new_version_modal_state then
        E.LOG.debug(TAG, "set_background_download_switch_state: new_version_modal_state is nil, setting to true")
        new_version_modal_visible_key_store:set(tostring(state))
      end
    end
  else
    E.LOG.warn(TAG, "set_background_download_switch_state: invalid state, must be boolean")
    return
  end
end

local red_dot_key_store = E.LazyKeyStore:New("background_update_red_dot_data", false, true, false)

local function get_red_dot_data()
  return red_dot_key_store:get() or {}
end

local function save_red_dot_data(data)
  red_dot_key_store:set(data)
end

function M.get_red_dot_table(red_dot_type)
  local red_dot_data = get_red_dot_data()
  return red_dot_data[red_dot_type] or {}
end

function M.is_version_in_red_dot_table(task_id, version_name, red_dot_type)
  local red_dot_table = M.get_red_dot_table(red_dot_type)
  local task_versions = red_dot_table[task_id]
  if not task_versions then
    return false
  end
  for _, existing_version in ipairs(task_versions) do
    if existing_version == version_name then
      return true
    end
  end
  return false
end

function M.add_version_to_red_dot_table(task_id, version_name, red_dot_type)
  if not (task_id and version_name) or not red_dot_type then
    E.LOG.warn("add_version_to_red_dot_table: task_id, version_name or red_dot_type is nil")
    return
  end
  local red_dot_data = get_red_dot_data()
  if not red_dot_data[red_dot_type] then
    red_dot_data[red_dot_type] = {}
  end
  local red_dot_table = red_dot_data[red_dot_type]
  if not red_dot_table[task_id] then
    red_dot_table[task_id] = {}
  end
  local version_exists = false
  for _, existing_version in ipairs(red_dot_table[task_id]) do
    if existing_version == version_name then
      version_exists = true
      break
    end
  end
  if not version_exists then
    table.insert(red_dot_table[task_id], version_name)
    save_red_dot_data(red_dot_data)
    E.LOG.debug("add_version_to_red_dot_table: added task_id=" .. task_id .. ", version=" .. version_name .. ", red_dot_type=" .. red_dot_type)
  else
    E.LOG.debug("add_version_to_red_dot_table: task_id=" .. task_id .. ", version=" .. version_name .. " already exists, red_dot_type=" .. red_dot_type)
  end
end

function M.clear_download_btn_red_dot(task_id, version_name)
  M.add_version_to_red_dot_table(task_id, version_name, M.REDDOT_BTN_TYPE.DONWLOAD_RED_DOT)
end

function M.clear_install_btn_red_dot(task_id, version_name)
  M.add_version_to_red_dot_table(task_id, version_name, M.REDDOT_BTN_TYPE.INSTALL_RED_DOT)
end

function M.get_download_btn_red_dot_table()
  do return M.get_red_dot_table end
  return M.get_red_dot_table, M.REDDOT_BTN_TYPE.DONWLOAD_RED_DOT
end

function M.get_install_btn_red_dot_table()
  do return M.get_red_dot_table end
  return M.get_red_dot_table, M.REDDOT_BTN_TYPE.INSTALL_RED_DOT
end

function M.get_open_background_download_rewards(cb)
  cb(true, {})
end

function M.get_btn_reddot_state(params)
  if not (params and params.task_id and params.res_version) or not params.reddot_btn_type then
    E.LOG.warn(TAG, "get_btn_reddot_state params error")
    return false
  end
  local btn_red_dot_state = not M.is_version_in_red_dot_table(params.task_id, params.res_version, params.reddot_btn_type)
  E.LOG.debug("get_background_tasks_detail download_btn_red_dot", "hasUpdateNotification: " .. tostring(btn_red_dot_state))
  return btn_red_dot_state
end

local function create_task_detail(task_id)
  local task_type = M.deserialize_task_id(task_id).task_type
  local card_id = M.deserialize_task_id(task_id).card_id
  return {
    taskId = task_id,
    taskType = task_type,
    cardId = card_id,
    version = "",
    currentVersion = "",
    status = M.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED,
    progress = 0,
    totalSize = 0,
    downloadedSize = 0,
    downloadSpeed = 0,
    rewards = {},
    hasUpdateNotification = false,
    hasInstallNotification = false,
    banner = "",
    visible = true,
    errorCode = 0,
    errorMsg = "",
    errorType = ""
  }
end

local function fill_task_info(task_detail, info_result)
  if info_result and info_result.task_info then
    task_detail.version = info_result.task_info.res_version or ""
    task_detail.currentVersion = info_result.task_info.current_version or ""
    if info_result.task_info.total_size then
      task_detail.totalSize = info_result.task_info.total_size
    end
    local card_config = background_download_card_configs[task_detail.taskId] or {}
    if card_config.title then
      task_detail.cardTitle = card_config.title
    end
    if card_config.sub_title then
      task_detail.cardSubTitle = card_config.sub_title
    end
    if card_config.can_remove_resource ~= nil then
      task_detail.cardCanRemoveResource = card_config.can_remove_resource
    end
    if nil ~= card_config.can_pause_download then
      task_detail.cardCanPauseDownload = card_config.can_pause_download
    end
    if nil ~= card_config.can_download_direct then
      task_detail.canDownloadDirect = card_config.can_download_direct
    end
  end
  return task_detail
end

local function fill_task_state(task_detail, task_state)
  if task_state then
    task_detail.status = task_state.state or M.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED
    if task_state.download_info then
      local download_info = task_state.download_info
      task_detail.progress = download_info.percent or 0
      task_detail.downloadedSize = download_info.downloading_size
      task_detail.downloadSpeed = download_info.speed
    end
  end
  return task_detail
end

local function calculate_reddot_states(task_detail)
  task_detail.hasUpdateNotification = M.get_btn_reddot_state({
    task_id = task_detail.taskId,
    res_version = task_detail.version,
    reddot_btn_type = M.REDDOT_BTN_TYPE.DONWLOAD_RED_DOT
  })
  task_detail.hasInstallNotification = M.get_btn_reddot_state({
    task_id = task_detail.taskId,
    res_version = task_detail.version,
    reddot_btn_type = M.REDDOT_BTN_TYPE.INSTALL_RED_DOT
  })
  return task_detail
end

local function match_task_rewards(task_detail, info_result, reward_data)
  if not reward_data or not reward_data.items then
    return task_detail
  end
  local matched_banner = ""
  for _, item in ipairs(reward_data.items) do
    local is_match = false
    if item.download_type == "incr_download" and task_detail.taskType == M.BACKGROUND_UPDATE_TYPE.PRE_DOWNLOAD then
      if info_result and info_result.task_info and item.download_data then
        local task_res_key = info_result.task_info.res_key
        local task_res_id = info_result.task_info.res_id
        local reward_res_key = item.download_data.res_key
        local reward_res_id = item.download_data.res_id
        if task_res_key == reward_res_key and task_res_id == reward_res_id then
          E.LOG.debug("get_background_tasks_detail predownload", "res_key and res_id match")
          is_match = true
        end
      end
    elseif item.download_type == "new_download" and task_detail.taskType == M.BACKGROUND_UPDATE_TYPE.APP_UPDATE and info_result and info_result.task_info and item.download_data then
      local task_res_version = info_result.task_info.res_version
      local min_app_version = item.download_data.min_app_version
      if task_res_version and min_app_version and VC.compare_versions(task_res_version, min_app_version) >= 0 then
        is_match = true
      end
    end
    if is_match and item.banner_img then
      matched_banner = item.banner_img or ""
    end
    if is_match and item.reward and item.reward.package_items then
      task_detail.rewards = {}
      for _, package_item in ipairs(item.reward.package_items) do
        table.insert(task_detail.rewards, {
          icon = package_item.icon or "",
          count = tostring(package_item.amount or 0)
        })
      end
    end
  end
  task_detail.banner = matched_banner
  return task_detail
end

local function check_task_card_visibility(task_detail, info_result)
  local cached_task = M.get_task_info_from_cache()[task_detail.taskId]
  local complete_time = cached_task and cached_task.completeTime
  local has_new_update = info_result.task_info and info_result.task_info.has_new_update or false
  E.LOG.debug(TAG, "check_task_card_visibility, has_new_update: " .. tostring(has_new_update))
  E.LOG.debug(TAG, "check_task_card_visibility, complete_time: " .. tostring(complete_time))
  if task_detail.taskType == M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE then
    if not has_new_update then
      E.LOG.debug(TAG, "groups update task_id:" .. tostring(task_detail.taskId) .. " visible is false")
      task_detail.visible = false
      M.release_task_from_cache(task_detail.taskId)
    end
  else
    local not_complete_time = not complete_time or "" == complete_time
    local is_task_period = not_complete_time or tonumber(E.time_ms_server_or_local()) - tonumber(complete_time) > task_card_retention_period
    E.LOG.debug(TAG, "check_task_card_visibility, is_task_period:" .. tostring(is_task_period))
    if is_task_period and not has_new_update then
      E.LOG.debug(TAG, "task_id:" .. tostring(task_detail.taskId) .. " visible is false")
      task_detail.visible = false
      M.release_task_from_cache(task_detail.taskId)
    end
  end
  return task_detail
end

local function handle_download_complete_state(task_detail, info_result, cached_task_detail)
  local task_type = task_detail.taskType
  if task_type == M.BACKGROUND_UPDATE_TYPE.PRE_DOWNLOAD or task_type == M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE then
    local background_download_new_update_flag = background_download_new_update_flags[task_detail.taskId]
    E.LOG.debug(TAG, "background_download_new_update_flag: " .. tostring(background_download_new_update_flag))
    if info_result.task_info.has_new_update and false ~= background_download_new_update_flag then
      E.LOG.debug(TAG, "get_tasks_detail, info_result:")
      E.log(info_result.task_info)
      task_detail.status = M.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED
      task_detail.downloadedSize = 0
      task_detail.progress = 0
      task_detail.errorCode = 0
      task_detail.errorMsg = ""
      task_detail.errorType = ""
    else
      task_detail = cached_task_detail
    end
  end
  return task_detail
end

local function restore_task_from_cache(task_detail, info_result)
  local cached_task_detail = M.get_task_info_from_cache()[task_detail.taskId]
  if not (cached_task_detail and info_result) or not info_result.task_info then
    E.LOG.debug("restore_task_from_cache", "no cached task_detail or no info_result")
    return task_detail
  end
  if info_result.task_info.res_version ~= cached_task_detail.version then
    E.LOG.debug("restore_task_from_cache", "res_version not match")
    return task_detail
  end
  if not cached_task_detail.status or cached_task_detail.status == M.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED then
    E.LOG.debug("restore_task_from_cache", "cached task detail's status is DOWNLOAD_NOT_STARTED")
    return task_detail
  end
  E.LOG.debug("get_background_tasks_detail get_task_info", "use cached task_detail: ")
  E.log(cached_task_detail)
  task_detail.downloadedSize = cached_task_detail.downloadedSize
  task_detail.progress = cached_task_detail.progress
  task_detail.errorCode = cached_task_detail.errorCode
  task_detail.errorMsg = cached_task_detail.errorMsg
  task_detail.errorType = cached_task_detail.errorType
  if info_result.task_info.has_new_update then
    task_detail.totalSize = info_result.task_info.total_size
  else
    task_detail.totalSize = cached_task_detail.totalSize
  end
  if cached_task_detail.status == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
    task_detail = handle_download_complete_state(task_detail, info_result, cached_task_detail)
    E.LOG.debug(TAG, "after handle_download_complete_state, task_detail")
    E.log(task_detail)
  elseif task_detail.status == M.TASK_UPDATE_STATE.INSTALL_SUCCESS then
    task_detail.status = M.TASK_UPDATE_STATE.INSTALL_SUCCESS
  elseif task_detail.status == M.TASK_UPDATE_STATE.PKG_AUTO_REMOVED then
    task_detail.status = M.TASK_UPDATE_STATE.PKG_AUTO_REMOVED
  else
    task_detail.status = M.TASK_UPDATE_STATE.DOWNLOAD_STOPPED
  end
  return task_detail
end

local function remove_duplicate_tasks(task_list)
  local unique_result = {}
  local seen_task_types = {}
  for _, task_detail in ipairs(task_list) do
    if not seen_task_types[task_detail.taskId] then
      seen_task_types[task_detail.taskId] = true
      table.insert(unique_result, task_detail)
    end
  end
  return unique_result
end

local function process_single_task(task_id, task_instance, callback)
  local task_detail = create_task_detail(task_id)
  local task_type = task_detail.taskType
  task_instance.get_task_info({}, function(info_result)
    info_result = info_result or {}
    E.LOG.debug("get_background_tasks_detail get_task_info", "info_result: ")
    E.log(info_result)
    task_detail = fill_task_info(task_detail, info_result)
    task_instance.get_task_state({}, function(task_state)
      E.LOG.debug("get_background_tasks_detail get_task_state", "task_state download_info: ")
      E.log(task_state)
      task_detail = fill_task_state(task_detail, task_state)
      task_detail = calculate_reddot_states(task_detail)
      if task_type == M.BACKGROUND_UPDATE_TYPE.APP_UPDATE then
        if task_state.state == M.TASK_UPDATE_STATE.INSTALL_SUCCESS or task_state.state == M.TASK_UPDATE_STATE.PKG_AUTO_REMOVED then
          local task_progress_and_state_cache = task_progress_cache_key_store:get() or {}
          local current_task_detail = task_progress_and_state_cache[task_id] or {}
          E.LOG.debug(TAG, "save_task_complete_time task_id: " .. tostring(task_id) .. ", current_complete_time: " .. tostring(current_task_detail.completeTime or ""))
          if not current_task_detail.completeTime or current_task_detail.completeTime == "" then
            task_detail.completeTime = E.time_ms_server_or_local()
            E.LOG.debug(TAG, "save_task_complete_time task_id: " .. tostring(task_id) .. ", new_complete_time: " .. tostring(task_detail.completeTime))
          else
            task_detail.completeTime = current_task_detail.completeTime
            E.LOG.debug(TAG, "save_task_complete_time task_id: " .. tostring(task_id) .. ", use_current_complete_time: " .. tostring(current_task_detail.completeTime))
          end
        else
          task_detail.completeTime = ""
          E.LOG.debug(TAG, "reset_task_complete_time task_id: " .. tostring(task_id))
        end
      end
      M.get_open_background_download_rewards(function(succ, reward_data)
        if succ then
          task_detail = match_task_rewards(task_detail, info_result, reward_data)
        end
        task_detail = restore_task_from_cache(task_detail, info_result)
        task_detail = check_task_card_visibility(task_detail, info_result)
        E.LOG.debug("get_tasks_detail", "final task_detail:")
        E.log(task_detail)
        callback(task_detail)
      end)
    end)
  end)
end

function M.get_tasks_detail(_params, cb)
  local all_tasks = M.get_background_download_tasks()
  local task_total_count = 0
  for _ in pairs(all_tasks) do
    task_total_count = task_total_count + 1
  end
  local processed_task_count = 0
  local result = {}
  if 0 == task_total_count then
    E.LOG.debug("get_tasks_detail", "no tasks found")
    cb(result)
    return
  end
  for task_id, task_instance in pairs(all_tasks) do
    process_single_task(task_id, task_instance, function(task_detail)
      table.insert(result, task_detail)
      processed_task_count = processed_task_count + 1
      if processed_task_count == task_total_count then
        local unique_result = remove_duplicate_tasks(result)
        E.LOG.debug("get_tasks_detail", "all tasks completed")
        E.log(unique_result)
        cb(unique_result)
      end
    end)
  end
end

M.get_open_background_download_rewards(function(success, rewards_data)
  if success and rewards_data then
    E.LOG.debug("register", "pre_get background tasks rewards data")
    E.log(rewards_data.items)
    M.PRE_DOWNLOAD_REWARDS_DATA = rewards_data
  end
end)

function M.jf_commit_open_background_download_event()
  local JF = require("ejoysdk_lua.vendors.jf")
  local _acc_info = ES.acc_info()
  if _acc_info ~= {} and _acc_info.accountId ~= nil then
    E.LOG.debug("update_network_strategy", "sdk.back.download.open start:")
    JF.commit_event("sdk.back.download.open", {
      account = _acc_info.accountId
    }, {
      [JF.OPTION_KEY.IS_PRIORITY_HIGH] = true
    })
  end
end

function M.jf_commit_resource_update_success_event(params)
  local JF = require("ejoysdk_lua.vendors.jf")
  local _acc_info = ES.acc_info()
  if next(_acc_info) ~= nil and nil ~= _acc_info.accountId then
    E.LOG.debug("jf commit event", "sdk.resource.update.success start:")
    local commit_params = {
      account = _acc_info.accountId,
      res_key = params.res_key,
      res_id = params.res_id
    }
    JF.commit_event("sdk.resource.update.success", commit_params, {
      [JF.OPTION_KEY.IS_PRIORITY_HIGH] = true
    })
  else
    local cached_data = unlogin_reward_version_key_store:get() or {}
    local new_entry = {
      res_key = params.res_key,
      res_id = params.res_id
    }
    table.insert(cached_data, new_entry)
    unlogin_reward_version_key_store:set(cached_data)
  end
end

function M.jf_commit_unlogin_predownload_task()
  local all_unlogin_predownload_task = unlogin_reward_version_key_store:get() or {}
  local _acc_info = ES.acc_info()
  if 0 == #all_unlogin_predownload_task or nil == _acc_info or nil == _acc_info.accountId then
    return
  end
  for index = #all_unlogin_predownload_task, 1, -1 do
    local task_data = all_unlogin_predownload_task[index]
    E.LOG.debug("jf commit unlogin predownload task", "task_data:")
    E.log(task_data)
    M.jf_commit_resource_update_success_event(task_data)
    table.remove(all_unlogin_predownload_task, index)
  end
  unlogin_reward_version_key_store:set(all_unlogin_predownload_task)
end

local function classify_download_error_code(error_code)
  local ERROR = require("ejoysdk_lua.res.ejoysdk_error_utils")
  local is_network_error = ERROR.check_is_network_error(error_code)
  if is_network_error then
    return M.ERROR_TYPE.NETWORK_ERROR
  else
    return M.ERROR_TYPE.OTHER_ERROR
  end
end

local function save_task_progress_and_state(task_id, task_state)
  E.LOG.debug(TAG, "save_task_progress_and_state task_id: " .. task_id)
  E.log(task_state)
  local task_progress_and_state_cache = task_progress_cache_key_store:get() or {}
  local current_task_detail = task_progress_and_state_cache[task_id]
  if current_task_detail and (current_task_detail.status == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE or current_task_detail.status == M.TASK_UPDATE_STATE.INSTALL_SUCCESS) and current_task_detail.status == task_state.state then
    E.LOG.debug(TAG, "save_task_progress_and_state, no need to update cache")
    return
  end
  local new_task_detail = current_task_detail or {}
  new_task_detail.status = task_state.state
  new_task_detail.progress = task_state.download_info.percent
  new_task_detail.downloadedSize = task_state.download_info.downloading_size
  if task_state.state_info then
    if task_state.state_info.code then
      new_task_detail.errorCode = task_state.state_info.code
      new_task_detail.errorType = classify_download_error_code(task_state.state_info.code)
    end
    if task_state.state_info.msg then
      new_task_detail.errorMsg = task_state.state_info.msg
    end
  end
  if task_state.complete_time then
    E.LOG.debug(TAG, "save complete_time: " .. tostring(task_state.complete_time))
    new_task_detail.completeTime = task_state.complete_time
  end
  task_progress_and_state_cache[task_id] = new_task_detail
  E.LOG.debug(TAG, "save_task_progress_and_state task_progress_cache_key_store set:")
  E.log(task_progress_and_state_cache)
  task_progress_cache_key_store:set(task_progress_and_state_cache)
end

function M.remove_task_from_cache(task_id)
  local task_progress_and_state_cache = task_progress_cache_key_store:get() or {}
  local current_task_detail = task_progress_and_state_cache[task_id]
  if current_task_detail then
    task_progress_and_state_cache[task_id].status = M.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED
    task_progress_and_state_cache[task_id].progress = 0
    task_progress_and_state_cache[task_id].downloadedSize = 0
    task_progress_cache_key_store:set(task_progress_and_state_cache)
    E.LOG.debug(TAG, "remove_task_from_cache task_id: " .. task_id)
  end
end

function M.release_task_from_cache(task_id)
  local task_progress_and_state_cache = task_progress_cache_key_store:get() or {}
  if task_progress_and_state_cache[task_id] then
    task_progress_and_state_cache[task_id] = nil
    task_progress_cache_key_store:set(task_progress_and_state_cache)
    E.LOG.debug(TAG, "release_task_from_cache task_id: " .. task_id)
  end
end

function M.register_task_to_background_manager(params, task_instance, cb)
  local task_last_save_timestamps = {}
  local card_id = params.card_config and params.card_config.id or nil
  local task_type = params.task_type
  local task_id = M.serialize_task_id(task_type, card_id)
  params.task_id = task_id
  background_download_card_configs[task_id] = params.card_config
  local _listener = params.listener or {}
  local _on_res_update_complete = _listener.on_res_update_complete or function()
  end
  _wrapper_background_download_tasks({
    task_id = task_id,
    task_type = params.task_type,
    card_id = card_id,
    task_instance = task_instance
  }, function(is_succ, ...)
    E.LOG.debug(TAG, "register task to background_update_manager result: " .. tostring(is_succ))
    if is_succ then
      if params.task_type == M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE then
        task_instance.get_task_info({}, function(task_info_result)
          task_info_result = task_info_result or {}
          local task_info = task_info_result.task_info or {}
          if task_info.has_new_update == false then
            E.LOG.debug(TAG, "task_id: " .. tostring(task_id) .. ", on_res_update_complete has_new_update: false")
            _on_res_update_complete(true, {has_new_update = false})
          end
        end)
      end
      
      local function on_state_change(task_state)
        E.LOG.debug(TAG, "task_id: " .. tostring(task_id) .. ", on_state_change task state change: ")
        E.log(task_state)
        background_download_task_states[task_id] = task_state
        if task_state.state_info.code then
          local task_type_to_track_name = {
            [M.BACKGROUND_UPDATE_TYPE.APP_UPDATE] = "optional_update",
            [M.BACKGROUND_UPDATE_TYPE.PRE_DOWNLOAD] = "delta_resource_preload",
            [M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE] = "custom_card"
          }
          local track_name = task_type_to_track_name[params.task_type]
          if track_name then
            local is_groups = params.task_type == M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE
            local track_params = {
              is_priority_high = true,
              error_code = task_state.state_info.code
            }
            if is_groups then
              track_params.card_id = card_id
            end
            M.background_download_track(track_name, "download_fail", track_params)
            if task_state.state_info.code == CONSTANTS.DOWNLOAD_ERROR_CODES.DOWNLOAD_DISK_NOT_ENOUGH then
              local storage_params = {is_priority_high = true}
              if is_groups then
                storage_params.card_id = card_id
              end
              M.background_download_track(track_name, "download_storage_low_show", storage_params)
            end
          end
          task_state.state_info.type = classify_download_error_code(task_state.state_info.code)
        end
        local current_timestamp = E.time_ms_server_or_local()
        local last_run_save_timestamp = task_last_save_timestamps[params.task_id] or 0
        if current_timestamp - last_run_save_timestamp > CACHE_UPDATE_INTERVAL and task_state and task_state.state ~= M.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED then
          save_task_progress_and_state(params.task_id, task_state)
          task_last_save_timestamps[params.task_id] = current_timestamp
        end
        if task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_FAILED or task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE or task_state.state == M.TASK_UPDATE_STATE.PKG_AUTO_REMOVED or task_state.state == M.TASK_UPDATE_STATE.INSTALL_SUCCESS then
          E.LOG.debug(TAG, "save task progress and state right now, task state: " .. task_state.state)
          E.log(task_state)
          if (params.task_type == M.BACKGROUND_UPDATE_TYPE.PRE_DOWNLOAD or params.task_type == M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE) and task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
            task_state.complete_time = E.time_ms_server_or_local()
            background_download_new_update_flags[task_id] = false
          end
          save_task_progress_and_state(params.task_id, task_state)
        end
        if params.task_type == M.BACKGROUND_UPDATE_TYPE.PRE_DOWNLOAD and task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
          M.background_download_track("delta_resource_preload", "download_complete")
          task_instance.get_task_info({}, function(task_info_result)
            E.LOG.debug(TAG, "download complete, task_info_result: ", task_info_result)
            E.log(task_info_result)
            local commit_params = {}
            if task_info_result and task_info_result.task_info then
              commit_params.res_key = task_info_result.task_info.res_key
              commit_params.res_id = task_info_result.task_info.res_id
            end
            if commit_params.res_id then
              M.jf_commit_resource_update_success_event(commit_params)
            end
            M.BACK_UPDATE_RECORD[params.task_type .. task_info_result.task_info.res_version] = E.time_ms_server_or_local()
          end)
        end
        if params.task_type == M.BACKGROUND_UPDATE_TYPE.APP_UPDATE and task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
          M.background_download_track("optional_update", "download_complete")
        elseif params.task_type == M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE and task_state == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
          M.background_download_track("custom_card", "download_complete", JSON.safe_encode({card_id = card_id}))
        end
        if params.task_type == M.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE and (task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE or task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_FAILED) then
          local is_update_succ = task_state.state == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE
          E.LOG.debug(TAG, "task_id: " .. tostring(task_id) .. ", on_res_update_complete is_update_succ: " .. tostring(is_update_succ))
          if is_update_succ then
            _on_res_update_complete(is_update_succ, {has_new_update = true})
          else
            local _code = task_state.state_info.code
            local _msg = task_state.state_info.msg
            _on_res_update_complete(is_update_succ, _code, _msg)
          end
        end
      end
      
      if type(task_instance.set_state_change_listener) == "function" then
        task_instance.set_state_change_listener(on_state_change)
      end
      
      local function inner_cb(succ, ...)
        if succ then
          E.LOG.debug(TAG, "task start succ")
        else
          local code, msg = ...
          E.LOG.debug(TAG, "task start fail, code: " .. code .. ", msg: " .. msg)
        end
        cb(true)
      end
      
      M.submit_background_task(params, inner_cb)
    elseif cb then
      cb(false, ...)
    end
  end)
end

function M.submit_background_task(params, cb)
  local card_config = background_download_card_configs[params.task_id] or {}
  local can_download_direct = card_config.can_download_direct or false
  local is_background_download_switch_open = M.get_background_download_switch_state() == true
  local can_background_download = is_background_download_switch_open or can_download_direct
  E.LOG.debug(TAG, "submit_background_task is_background_download_switch_open: " .. tostring(is_background_download_switch_open) .. ", can_download_direct: " .. tostring(can_download_direct))
  if can_background_download then
    local all_tasks = M.get_background_download_tasks()
    local task_instance = all_tasks[params.task_id]
    task_instance.get_task_info({}, function(task_info_result)
      if task_info_result and task_info_result.task_info then
        local task_version = task_info_result.task_info.res_version
        M.clear_download_btn_red_dot(params.task_id, task_version)
      end
      
      local function inner_cb(succ, ...)
        if succ then
          cb(true)
        else
          local code, msg = ...
          cb(false, code, msg)
        end
      end
      
      if task_info_result and task_info_result.has_new_update == false then
        cb(true)
        return
      end
      if params.task_type == M.BACKGROUND_UPDATE_TYPE.APP_UPDATE then
        params.need_jump_outside_update = false
      end
      task_instance.start_task(params, inner_cb)
    end)
  else
    cb(false, BACKGROUND_DOWNLOAD_ERROR_CODES.BACKGROUND_DOWNLOAD_IS_DISABLED, "background download is disabled")
  end
end

local is_background_guide_showing = false
local background_guide_show_queue = {}

function M.show_background_download_guide(_params, close_cb)
  close_cb = close_cb or function()
  end
  if is_background_guide_showing then
    E.LOG.debug(TAG, "is_background_guide_showing insert background_guide_show_queue")
    table.insert(background_guide_show_queue, {params = _params, close_cb = close_cb})
    return
  end
  E.LOG.debug(TAG, "is_background_guide_showing is false  _do_show_background_guide")
  M._do_show_background_guide(_params, close_cb)
end

function M._do_show_background_guide(_params, close_cb)
  local background_download_state = M.get_background_download_switch_state()
  if background_download_state then
    E.LOG.debug(TAG, "background_download_state:")
    E.log(background_download_state)
    close_cb()
    M._process_next_background_guide()
    return
  end
  if background_download_user_close_key_store:get() == "true" then
    E.LOG.debug(TAG, "show_background_download_guide return; background_download_user_close_key_store: " .. tostring(background_download_user_close_key_store:get()))
    close_cb()
    M._process_next_background_guide()
    return
  end
  local current_time_ms = E.time_ms_server_or_local()
  E.LOG.debug(TAG, "current time ms:" .. tostring(current_time_ms))
  E.LOG.debug(TAG, "last background download guide time ms:" .. tostring(background_download_guide_last_time_key_store:get()))
  if background_download_guide_count_key_store:get() == nil or background_download_guide_last_time_key_store:get() == nil then
    background_download_guide_count_key_store:set(1)
    background_download_guide_last_time_key_store:set(current_time_ms)
  else
    local count = tonumber(background_download_guide_count_key_store:get())
    local last_time = tonumber(background_download_guide_last_time_key_store:get())
    local interval_time = current_time_ms - last_time
    E.LOG.debug(TAG, "interval time ms:" .. tostring(interval_time) .. ", last_time: " .. tostring(last_time))
    if count < 3 and current_time_ms - last_time > background_download_guide_interval_time then
      background_download_guide_count_key_store:set(count + 1)
      background_download_guide_last_time_key_store:set(current_time_ms)
    else
      E.LOG.debug(TAG, "show_background_guide close right now")
      close_cb()
      M._process_next_background_guide()
      return
    end
  end
  local raven_url = AUU.generate_raven_url(MODAL_PAGEID_REGION_MAP)
  local hostname = AUU.extract_hostname_from_url(raven_url)
  local injection = {
    [hostname] = {transparent = true}
  }
  local options = {
    use_cutout = false,
    hide_close_btn = true,
    compactMode = true,
    use_fragment = true
  }
  M.MODAL_TYPE = "slient_guide"
  is_background_guide_showing = true
  E.WebView.open(raven_url, injection, options, nil, function()
    is_background_guide_showing = false
    close_cb()
    M._process_next_background_guide()
  end)
end

function M._process_next_background_guide()
  if #background_guide_show_queue > 0 then
    local next_req = table.remove(background_guide_show_queue, 1)
    M._do_show_background_guide(next_req.params, next_req.close_cb)
  end
end

function M.show_new_version_popup()
  local all_task = M.get_background_download_tasks()
  local app_update_task_id = M.BACKGROUND_UPDATE_TYPE.APP_UPDATE
  local pkg_update_task = all_task[app_update_task_id]
  local cached_task_detail = M.get_task_info_from_cache()[M.BACKGROUND_UPDATE_TYPE.APP_UPDATE]
  if cached_task_detail and next(cached_task_detail) and (cached_task_detail.status == M.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE or cached_task_detail.status == M.TASK_UPDATE_STATE.DOWNLOADING or cached_task_detail.status == M.TASK_UPDATE_STATE.DOWNLOAD_FAILED or cached_task_detail.status == M.TASK_UPDATE_STATE.INSTALL_FAILED) then
    E.LOG.debug(TAG, "show_new_version_popup return; cached_task_detail: " .. tostring(cached_task_detail.status))
    return
  end
  if M.get_background_download_switch_state() == true then
    E.LOG.debug(TAG, "show_new_version_popup return show_new_version_popup: " .. tostring(M.get_background_download_switch_state()))
    return
  end
  if nil == pkg_update_task then
    E.LOG.debug(TAG, "show_new_version_popup return; pkg_update_task is nil")
    return
  end
  pkg_update_task.get_task_info({}, function(result)
    if result.task_info.res_version == "" or result.task_info.res_version == result.task_info.current_version then
      E.LOG.debug(TAG, "show_new_version_popup return; res_version version is: " .. tostring(result.task_info.res_version))
      return
    end
    local pkg_version = result.task_info.res_version
    if not M.should_show_new_version_popup(pkg_version) then
      E.LOG.debug(TAG, "show_new_version_popup return; should_show_new_version_popup: " .. pkg_version)
      return
    end
    ECC.get_configs_with_options({disable_update_cache = true}, {
      APP_UPDATE = ECC.NAMESPACE.APP_UPDATE
    }, function(is_success, ...)
      if is_success then
        local config_list = (...)
        E.LOG.debug(TAG, "get_configs_with_options success, config_list is >>>")
        E.log(config_list)
        local update_config = config_list[1] and config_list[1].config or nil
        E.LOG.debug(TAG, "get_configs_with_options success, update_config is >>>")
        E.log(update_config)
        if update_config then
          local latest_update_config = update_config.latest or {}
          if latest_update_config.showPopup == true then
            local raven_url = AUU.generate_raven_url(MODAL_PAGEID_REGION_MAP)
            local hostname = AUU.extract_hostname_from_url(raven_url)
            local injection = {
              [hostname] = {transparent = true}
            }
            local options = {
              use_cutout = false,
              hide_close_btn = true,
              compactMode = true,
              use_fragment = true
            }
            M.MODAL_TYPE = "new_version"
            E.LOG.debug("open new version popup", "raven_url: ")
            E.log(raven_url)
            
            local function on_close_webview_cb()
              E.LOG.debug("close new version popup")
              M.record_new_version_popup(pkg_version)
            end
            
            E.WebView.open(raven_url, injection, options, nil, on_close_webview_cb)
          end
        end
      else
        local code, msg = ...
        E.LOG.debug(TAG, "get_configs_with_options error, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      end
    end)
  end)
end

function M.auto_resume_download()
  local all_cached_tasks = M.get_task_info_from_cache()
  for _, task_info in pairs(all_cached_tasks) do
    E.LOG.debug(TAG, "auto_resume_download task_info:" .. tostring(task_info.taskType))
    E.log(task_info)
    local all_tasks = M.get_background_download_tasks()
    local current_task = all_tasks[task_info.taskId] or {}
    local current_task_state = background_download_task_states[task_info.taskId] or {}
    if task_info.status == M.TASK_UPDATE_STATE.DOWNLOADING and next(current_task) and next(current_task_state) and current_task_state.state ~= M.TASK_UPDATE_STATE.DOWNLOADING then
      current_task.start_task({}, function(succ, ...)
        if succ then
          E.LOG.debug(TAG, "auto_resume_download succ, taskType:" .. task_info.taskType)
        else
          E.LOG.debug(TAG, "auto_resume_download error, taskType:" .. task_info.taskType)
        end
      end)
    end
  end
end

function M.should_show_new_version_popup(pkg_version)
  local new_version_popup_record = new_version_popup_key_store:get() or {}
  if new_version_popup_record[pkg_version] then
    return false
  end
  return true
end

function M.record_new_version_popup(pkg_version)
  local new_version_popup_record = new_version_popup_key_store:get() or {}
  new_version_popup_record[pkg_version] = true
  new_version_popup_key_store:set(new_version_popup_record)
end

function M.background_download_track(function_name, action_name, params)
  if params and type(params) == "string" then
    params = JSON.safe_decode(params)
  local biz_params = params or {}
  local is_fail = "download_fail" == action_name or "clear_failed" == action_name
  ES.stat_bizid_pfcomm({
    is_priority_high = biz_params.is_priority_high or false,
    biz_group = "lq",
    biz_prod = "qz",
    biz_mod = "game_full_update",
    biz_func = function_name,
    biz_act = action_name,
    biz_st = is_fail and "fail" or "succ",
    biz_co = is_fail and tostring(biz_params.error_code or "400") or "200",
    biz_params = biz_params
  })
end

M.jf_commit_unlogin_predownload_task()
local enable_clear = false

function M.set_enable_clear(value)
  enable_clear = true == value
  E.LOG.debug(TAG, "set_enable_clear: " .. tostring(enable_clear))
end

function M.is_enable_clear()
  return enable_clear
end

return M

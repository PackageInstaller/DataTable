local E = require("ejoysdk_lua.ejoysdk")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local download_state_machine, download_manager, cloud_state_manager
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "[down]cloud_down_rules"
local DEFAULT_VAL = {
  DEF_MIN_DOWN_SPEED = 400,
  DEF_DOWN_SPEED_LMIT = 600,
  DEF_DOWN_START_TIMEOUT_SEC = 10,
  DEF_DOWN_LIMIT_FOR_WIFI = true,
  DEF_DOWN_PROGRESS_NOTIFY_INTERVAL = 100
}
local sdk_required_speed_value
local sdk_current_connect_type = "unknown"
local config_min_download_speed = DEFAULT_VAL.DEF_MIN_DOWN_SPEED
local config_download_speed_limit = DEFAULT_VAL.DEF_DOWN_SPEED_LMIT
local config_download_start_timeout = DEFAULT_VAL.DEF_DOWN_START_TIMEOUT_SEC
local config_limit_download_for_wifi = DEFAULT_VAL.DEF_DOWN_LIMIT_FOR_WIFI
local config_download_progress_notify_interval = DEFAULT_VAL.DEF_DOWN_PROGRESS_NOTIFY_INTERVAL
local has_notified_download_start = false
local CONFIG_KEY = {
  KEY_MIN_DOWN_SPEED = "min_down_speed",
  KEY_DOWNLOAD_LIMIT = "game_res_download_limit_kps",
  KEY_DOWNLOAD_START_TIMEOUT = "res_down_start_timeout_sec",
  KEY_LIMIT_DOWNLOAD_FOR_WIFI = "limit_download_for_wifi",
  KEY_AB_TEST_ENABLED = "abtest_enable",
  KEY_DOWNLOAD_PROGRESS_NOTIFY_INTERVAL = "download_progress_notify_interval"
}
local download_speed_limit_listeners = {}
local start_download_listener

local function get_cloud_state_manager()
  if not cloud_state_manager then
    cloud_state_manager = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  end
  return cloud_state_manager
end

local function get_download_statemachine()
  if not download_state_machine then
    download_state_machine = require("ejoysdk_lua.cloud_game.cloud_download_statemachine")
  end
  return download_state_machine
end

local function get_download_manager()
  if not download_manager then
    download_manager = require("ejoysdk_lua.cloud_game.cloud_download_manager")
  end
  return download_manager
end

local function start_download()
  if start_download_listener then
    start_download_listener()
  end
end

local function set_speed_limit(speed)
  get_cloud_state_manager().set_download_limit(speed)
  for _, listener in ipairs(download_speed_limit_listeners) do
    listener(speed)
  end
end

local function update_limit_for_wifi(limit_for_wifi)
  get_download_manager().update_limit_for_wifi(limit_for_wifi)
end

local function current_download_state()
  do return end
  return get_download_statemachine().current_download_state, nil
end

local function is_downloading()
  local download_state = current_download_state()
  local downloading_state = get_download_statemachine().STATES.DOWNLOADING
  E.LOG.debug(TAG, "current_download_state:" .. tostring(download_state))
  if download_state == downloading_state then
    return true
  else
    return false
  end
end

local function update_download_speed(speed_value)
  local speed_value_data = speed_value or 0
  E.LOG.debug(TAG, "update_download_speed call:" .. tostring(speed_value_data))
  if 0 == speed_value_data or "tcp" == sdk_current_connect_type or M.is_download_control_disable() then
    speed_value_data = config_download_speed_limit
    E.LOG.debug(TAG, "update_download_speed value is 0 or now is tcp, use default limit:" .. tostring(config_download_speed_limit) .. ", sdk_current_connect_type:" .. tostring(sdk_current_connect_type))
  else
    E.LOG.debug(TAG, "update_download_speed, value:" .. tostring(speed_value_data))
  end
  set_speed_limit(speed_value_data)
end

function M.update_download_speed_kbps(val_speed_kps)
  E.LOG.debug(TAG, "update_download_speed_kbps:" .. tostring(val_speed_kps))
  sdk_required_speed_value = val_speed_kps or 0
  update_download_speed(sdk_required_speed_value)
end

local function update_download_progress_notify_interval(interval)
  E.LOG.debug(TAG, "update download progress notify interval >> " .. tostring(interval))
  local config = {progress_notify_interval = interval}
  E.HTTP.update_with_config(config)
end

function M.handle_sdk_config_from_server(config)
  local server_download_rules_config = config or {}
  E.LOG.debug(TAG, "handle_sdk_config_from_server >>")
  E.LOG.debug(TAG, server_download_rules_config)
  config_min_download_speed = server_download_rules_config[CONFIG_KEY.KEY_MIN_DOWN_SPEED] or DEFAULT_VAL.DEF_MIN_DOWN_SPEED
  config_download_speed_limit = server_download_rules_config[CONFIG_KEY.KEY_DOWNLOAD_LIMIT] or DEFAULT_VAL.DEF_DOWN_SPEED_LMIT
  config_download_start_timeout = server_download_rules_config[CONFIG_KEY.KEY_DOWNLOAD_START_TIMEOUT] or DEFAULT_VAL.DEF_DOWN_START_TIMEOUT_SEC
  config_download_progress_notify_interval = server_download_rules_config[CONFIG_KEY.KEY_DOWNLOAD_PROGRESS_NOTIFY_INTERVAL] or DEFAULT_VAL.DEF_DOWN_PROGRESS_NOTIFY_INTERVAL
  if server_download_rules_config[CONFIG_KEY.KEY_LIMIT_DOWNLOAD_FOR_WIFI] ~= nil then
    config_limit_download_for_wifi = server_download_rules_config[CONFIG_KEY.KEY_LIMIT_DOWNLOAD_FOR_WIFI]
  end
  update_limit_for_wifi(config_limit_download_for_wifi)
  update_download_speed(config_min_download_speed)
  update_download_progress_notify_interval(config_download_progress_notify_interval)
end

function M.get_config_min_download_speed()
  return config_min_download_speed
end

function M.is_download_control_disable()
  return false
end

function M.handle_sdk_download_speed_limit(val_speed_kps)
  if M.is_download_control_disable() then
    E.LOG.debug(TAG, "download control disable, not limit speed")
    return
  end
  sdk_required_speed_value = val_speed_kps or 0
  E.LOG.debug(TAG, "handle_sdk_download_speed_limit:" .. tostring(sdk_required_speed_value))
  update_download_speed(sdk_required_speed_value)
  if get_download_manager().is_odr() then
    if not has_notified_download_start then
      has_notified_download_start = true
      E.LOG.debug(TAG, "handle_sdk_download_speed_limit not start download, now begin")
      start_download()
      ESTAT.stat_action("cloud_notify_speed_download", "start", sdk_required_speed_value)
    else
      E.LOG.debug(TAG, "handle_sdk_download_speed_limit is start download")
      ESTAT.stat_action("cloud_notify_speed_download", "skip", sdk_required_speed_value)
    end
  elseif not has_notified_download_start then
    has_notified_download_start = true
    E.LOG.debug(TAG, "handle_sdk_download_speed_limit not start download, now begin")
    start_download()
    ESTAT.stat_action("cloud_notify_speed_download", "start", sdk_required_speed_value)
  else
    ESTAT.stat_action("cloud_notify_speed_download", "skip", sdk_required_speed_value)
  end
end

function M.handle_sdk_connect_type_changed(conn_type_val)
  local connect_type = conn_type_val or "unknown"
  local conn_type_changed = connect_type ~= sdk_current_connect_type
  sdk_current_connect_type = connect_type
  if conn_type_changed then
    E.LOG.debug(TAG, "handle_sdk_connect_type_changed update_download_speed")
    if "rtc" == sdk_current_connect_type then
      update_download_speed(sdk_required_speed_value)
    else
      if not is_downloading() then
        E.LOG.debug(TAG, "handle_sdk_connect_type_changed，its tcp, not downloading, now start download")
        start_download()
      end
      update_download_speed(0)
    end
  end
end

function M.handle_failed_in_start_cloud()
  E.LOG.warn(TAG, "handle_failed_in_start_cloud now start download")
  start_download()
end

local function check_download_after_game_started()
  if is_downloading() then
    E.LOG.warn(TAG, "check_download_after_game_started download already start, return")
    return
  end
  if M.is_download_control_disable() then
    start_download()
    E.LOG.warn(TAG, "check_download_after_game_started download control disabled, start download and return")
    return
  end
  E.Timer.once(config_download_start_timeout, function()
    E.LOG.debug(TAG, "check_download_after_game_started timeout reached:" .. tostring(config_download_start_timeout))
    if not is_downloading() then
      E.LOG.debug(TAG, "check_download_after_game_started, not downloading now start")
      start_download()
    else
      E.LOG.debug(TAG, "check_download_after_game_started, already downloading now return")
    end
  end)
end

function M.handle_sdk_cloud_game_started()
  E.LOG.debug(TAG, "handle_sdk_cloud_game_started >>")
  check_download_after_game_started()
end

function M.register_download_speed_limit_listener(listener)
  for _, ls in ipairs(download_speed_limit_listeners) do
    if ls == listener then
      return
    end
  end
  download_speed_limit_listeners[#download_speed_limit_listeners + 1] = listener
end

function M.register_start_download_listener(listener)
  start_download_listener = listener
end

return M

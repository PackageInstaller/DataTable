local UNI = require("ejoysdk_lua.vendors.unisdk")
local E = require("ejoysdk_lua.ejoysdk")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local Class = require("ejoysdk_lua.ejoysdk_class")
local DEVICE_ID = require("ejoysdk_lua.device_id.ejoysdk_device_id")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local UCP = require("ejoysdk_lua.user_center.usercenter_protocol")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local M = Class:Inherit("CloudApi")
local VENDOR_NAME = "CLOUD_GAME"
local TAG = EM.MODULE.CLOUD_GAME .. VENDOR_NAME
local NAMESPACE_CLOUDGAME = "ejoy_cloud_game"
local NAMESPACE_CLOUDGAME_TEST = "ejoy_cloud_game_test"
do
  local method = {
    "_init_cloud_native",
    "_request_cloud_res",
    "_request_cloud_config",
    "_get_schedule_start_params"
  }
  for type_, v in pairs(method) do
    M[v] = function()
      assert(false, type_ .. "/" .. v .. " unimplemented")
    end
  end
end
M.CLOUD_SDK_NAMES = {
  ALIGAME_CLOUD_GAME = "cloudgame",
  ALIYUN_CLOUD_GAME = "alicloudgame"
}
M.LUA_KEY = {
  LUA_KEY_CLOUD_MODE = "cloud_game_mode",
  LUA_KEY_DEBUGGABLE = "debuggable",
  LUA_KEY_PLAY_CONFIG = "play_config_result",
  LUA_KEY_BIT_RATE = "bit_rate",
  LUA_KEY_NETWORK_DELAY = "network_delay",
  LUA_KEY_DIRECT_START_GAME_ACTIVITY = "direct_start_game_activity",
  LUA_KEY_SAFE_CODE = "SAFE_CODE"
}
M.START_MODE = {
  MODE_IP_PORT = "mode_ip",
  MODE_AUTO_SCHEDULE = "mode_schedule"
}
M.CLOUD_ENV = {TEST = "test", PRODUCT = "product"}
M.CLOUD_MODE = {CLOUD = "cloud", MOBILE = "mobile"}
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.SERVICE = {
  CLOUD_RES_LOCK = "cloud.resource.lock",
  ALI_CLOUD_RES_LOCK = "cloud.alicloud.resource.lock",
  CLOUD_CONFIG = "cloud.config.check"
}
M.DSP_SERVICE_MAPPING = {
  [M.SERVICE.CLOUD_RES_LOCK] = DSP.SERVICE.CLOUD_RES_LOCK,
  [M.SERVICE.ALI_CLOUD_RES_LOCK] = DSP.SERVICE.ALI_CLOUD_RES_LOCK,
  [M.SERVICE.CLOUD_CONFIG] = DSP.SERVICE.CLOUD_CONFIG
}
M.UCP_SERVICE_MAPPING = {
  [M.SERVICE.ALI_CLOUD_RES_LOCK] = UCP.SERVICE.CLOUD_RES_LOCK,
  [M.SERVICE.CLOUD_CONFIG] = UCP.SERVICE.CLOUD_CONFIG
}
M.ASYNC_INIT_CLOUD_GAME = "ASYNC_INIT_CLOUD_GAME"
M.ASYNC_START_CLOUD_GAME = "ASYNC_START_CLOUD_GAME"
M.ASYNC_STOP_CLOUD_GAME = "ASYNC_STOP_CLOUD_GAME"
M.ASYNC_SEND_MSG = "ASYNC_SEND_MSG"
M.ASYNC_SHOW_START_GAME_ACTIVITY = "ASYNC_SHOW_START_GAME_ACTIVITY"
M.SYNC_START_GAME_ACTIVITY = "SYNC_START_GAME_ACTIVITY"
M.CAST_SHOW_TIPS = "CAST_SHOW_TIPS"
M.CAST_HIDE_TIPS = "CAST_HIDE_TIPS"
M.ASYNC_GET_CGS_START_UP_PARAMS = "ASYNC_GET_CGS_START_UP_PARAMS"
local META_KEY = {
  CLOUD_GAME_MODE = "cloud_game_mode",
  CLOUD_ENV = "cloud_env",
  SDK_SERVER_ENV = "sdk_server_env",
  CLOUD_USE_LUA_MSG_CHANNEL = "use_lua_msg_channel"
}
M.RES_KEY = {
  TOKEN = "token",
  GAME_SESSION = "gameSession",
  SCHEDULE_ID = "scheduleId",
  CLOUD_RES_INFO = "resInfo",
  CLOUD_GAME_ID = "cloudGameId",
  OPEN_ID = "openId",
  RES_DOWNLOAD_URL = "resourceDownloadUrl",
  RES_SIZE_BYTES = "resourceSizeBytes",
  RES_MARK = "resourceMark",
  PKG_RECORD_ID = "packageRecordId",
  EX = "ex",
  EX_PLAY_CONFIG = "play_config",
  EX_SDK_CONFIG = "sdk_config",
  EX_RESTRICT_RULES = "restrict_rules",
  EX_MIN_DOWN_SPEED = "mini_down_speed",
  EX_GAME_RES_INFO = "game_res_info",
  EX_SKIP_TIME_BEFORE_CHECK_RESTRICT_SEC = "skip_time_before_restrict_check_sec",
  EX_DISABLE_TEST_SPEED = "disable_test_speed",
  EX_UPDATING_WITH_CONNECT_SIZE_LIMIT = "updating_with_connect_size_limit",
  EX_APP_PARAMS = "app_params",
  EX_RULE_MIN_FPS = "min_fps",
  EX_RULE_MAX_RTT_MS = "max_rtt_ms",
  EX_RULE_MAX_CHECK_TIMES = "max_check_times",
  EX_RULE_CHECK_INTERVAL_SEC = "check_interval_sec",
  EX_RULE_MAX_RTT_DELAY_PERCENT = "max_rtt_delay_percent",
  EX_RULE_RTT_PING_TIMEOUT_MS = "rtt_ping_timeout_ms",
  EX_RULE_CATEGORY = "category",
  EX_RULE_PRIORITY = "priority",
  EX_RESTRICT = "restrict",
  EX_RESTRICT_NOTIFY_TYPE = "notify_type",
  EX_RESTRICT_GAME_RES_DOWNLOAD_LIMIT_KPS = "game_res_download_limit_kps",
  EX_DOWNLOAD_RULES = "download_rules",
  EX_AB_TEST_ENABLED = "abtest_enable",
  EX_RESTRICT_NOTIFY_TYPE_DIALOG = "dialog",
  EX_RESTRICT_NOTIFY_TYPE_TIPS = "tips",
  EX_INSTANT_CONFIG = "instant_config",
  EX_IS_DOWNLOAD_PROGRESS = "is_show_download_progress",
  EX_HW_QOS_APPKEY = "hw_qos_appkey",
  EX_HW_QOS_APPSECRET = "hw_qos_appsecret",
  EX_CLOUD_SDK_CONFIG = "ex_cloud_sdk_config",
  EX_SPLASH_RULES = "splash_rules",
  EX_IS_SHOW_BTN = "is_show_btn",
  EX_RES_SIZE_BYTES = "res_size_bytes",
  EX_MOBILE_AUTH = "mobileAuth",
  EX_MOBILE_AUTH_SDK_SECRET = "authSDKSecret",
  EX_FREE_FLOW = "free_flow",
  EX_FREE_FLOW_PRODUCTID = "productId",
  EX_FREE_FLOW_XGIPAPPID = "xgipAppId",
  EX_FREE_FLOW_DATAPKG_NAME = "dataPkgName",
  EX_FREE_FLOW_OPEN = "free_flow_open",
  EX_CONTINUE_PLAY_TIME = "ex_continue_play_time",
  FLOAT_PANEL_CONFIG = "float_panel_config",
  REMAIN_TIME_TEMPLETE = "remain_time_templete"
}
M.EJOY_CONFIG_KEY = {
  TARGET_WIDTH = "cloudgame_target_width",
  TARGET_HEIGHT = "cloudgame_target_height",
  SAFE_CODE = "cloudgame_safecode",
  CG_SAVE_PATH = "cloudgame_cg_savepath",
  CG_PORT = "cloudgame_cg_port"
}
M.RES_MARK_STATE = {OFFICIAL = 0, TEST = 1}
local STATE = {
  STATE_DEFAULT = -1,
  STATE_RUNNING = 0,
  STATE_SUCC = 1
}
local current_cloud_mode
local has_load_lua_msg_channel = false
local current_use_lua_msg_channel_state = false
local is_message_channel_enabled = false
local request_cloud_config_state = STATE.STATE_DEFAULT
local request_cloud_static_config_state = STATE.STATE_DEFAULT
local start_game_state = STATE.STATE_DEFAULT
local request_cloud_config_listeners = {}
local request_cloud_static_config_listeners = {}
local start_game_listeners = {}
local is_relink = false
local server_play_configs = {}
local server_restrict_rules = {}
local server_schedule_config = {}
local sdk_config = {}
local server_config_data = {}
local server_skip_time_before_restrict_check_sec = 0
local instant_config = {}
local game_res_info = {}
local current_play_config = {}
local start_game_begin_time, current_cloud_env, current_sdk_server_env
local oversea_url_base_inited = false
local is_oversea = false
local cloud_static_config_refresh_cbs = {}

local function notify_static_config_refresh()
  for _, callback in pairs(cloud_static_config_refresh_cbs) do
    if callback then
      callback()
    end
  end
end

local CLOUD_SDK_ERR_CODE = {ALREADY_START = 20002}

local function get_cloud_config()
  do return end
  return CC.get_cloud_meta_config, nil
end

function M.get_cloud_mode()
  if current_cloud_mode then
    E.LOG.debug(TAG, "get_cloud_mode from cache:" .. tostring(current_cloud_mode))
    return current_cloud_mode
  end
  local meta_config = get_cloud_config()
  meta_config = meta_config or {}
  current_cloud_mode = meta_config[META_KEY.CLOUD_GAME_MODE]
  E.LOG.debug(TAG, "check_is_cloud_side, mode:" .. (current_cloud_mode or "nil"))
  return current_cloud_mode
end

function M.is_use_lua_msg_channel()
  if has_load_lua_msg_channel then
    E.LOG.debug(TAG, "is_use_lua_msg_channel already load msg_channel config, return current_use_lua_msg_channel_state:" .. tostring(current_use_lua_msg_channel_state))
    return current_use_lua_msg_channel_state
  end
  local meta_config = get_cloud_config()
  meta_config = meta_config or {}
  current_use_lua_msg_channel_state = meta_config[META_KEY.CLOUD_USE_LUA_MSG_CHANNEL] or false
  E.LOG.debug(TAG, "is_use_lua_msg_channel read from config is:" .. tostring(current_use_lua_msg_channel_state))
  return current_use_lua_msg_channel_state
end

local function get_cloud_env()
  local meta_config = get_cloud_config()
  meta_config = meta_config or {}
  local cloud_env = meta_config[META_KEY.CLOUD_ENV]
  cloud_env = cloud_env or M.CLOUD_ENV.PRODUCT
  E.LOG.debug(TAG, "get_cloud_env, cloud_env:" .. (cloud_env or "nil"))
  return cloud_env
end

local function get_sdk_server_env()
  local sdk_server_env = get_cloud_env()
  return sdk_server_env
end

function M.get_server_play_configs()
  return server_play_configs
end

function M.set_server_play_configs(configs)
  server_play_configs = configs
end

function M.set_server_restrict_rules(rules)
  server_restrict_rules = rules
end

function M.get_server_restrict_rules()
  return server_restrict_rules
end

function M.get_server_schedule_config()
  return server_schedule_config
end

function M.set_server_schedule_config(config)
  server_schedule_config = config
end

function M.set_server_skip_time_before_restrict_check_sec(time_sec)
  server_skip_time_before_restrict_check_sec = time_sec
end

function M.get_server_skip_time_before_restrict_check_sec()
  return server_skip_time_before_restrict_check_sec
end

function M.set_sdk_config(config)
  sdk_config = config
end

function M.set_server_config_data(data)
  server_config_data = data
end

function M.set_instant_config(config)
  instant_config = config
end

function M.set_game_res_info(info)
  game_res_info = info
end

function M.get_game_res_info()
  return game_res_info
end

function M.get_instant_config()
  return instant_config
end

function M.get_server_config_data()
  return server_config_data
end

function M.get_sdk_config()
  return sdk_config
end

function M.get_vendor_name()
  return VENDOR_NAME
end

local function set_current_play_config(config)
  current_play_config = config
  E.LOG.debug(TAG, "set_current_play_config >>")
  E.log(current_play_config)
end

local function set_debuggable(debug)
  if "true" == debug then
    E.LOG.debug(TAG, "set_debuggable true")
    E.open_log(true)
  else
    E.LOG.debug(TAG, "set_debuggable false")
  end
end

function M.get_current_play_config()
  return current_play_config
end

function M.is_oversea()
  return is_oversea
end

local function check_oversea_url_base_init()
  if oversea_url_base_inited then
    E.LOG.debug(TAG, "check_oversea_url_base_init already inited and return")
    return
  end
  E.LOG.debug(TAG, "check_oversea_url_base_init begin init")
  local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
  local current_cdn_config = EGC.get_current_cdn_config()
  if current_cdn_config then
    E.LOG.debug(TAG, "init_usercenter_url find current cdn config")
    local edge_url_base = current_cdn_config.edge_center
    UCP.set_url_base_with_type(UCP.SERVICE_TYPE.EDGE_CENTER, edge_url_base)
    oversea_url_base_inited = true
  end
end

function M.get_cloud_env()
  local env
  if not current_cloud_env then
    current_cloud_env = get_cloud_env()
  end
  if current_cloud_env == CC.CLOUD_ENV.TEST or "test_demo" == current_cloud_env then
    env = M.ENV.DEBUG
  elseif current_cloud_env == CC.CLOUD_ENV.PRE_RELEASE then
    env = M.ENV.PRE_RELEASE
  else
    env = M.ENV.RELEASE
  end
  E.LOG.debug(TAG, "init cloud env:" .. tostring(current_cloud_env))
  return env
end

function M.get_sdk_server_env()
  local env
  if not current_sdk_server_env then
    current_sdk_server_env = get_sdk_server_env()
  end
  if current_sdk_server_env == CC.CLOUD_ENV.TEST then
    env = M.ENV.DEBUG
  elseif current_sdk_server_env == CC.CLOUD_ENV.PRE_RELEASE then
    env = M.ENV.PRE_RELEASE
  else
    env = M.ENV.RELEASE
  end
  E.LOG.debug(TAG, "init sdk server env:" .. tostring(current_sdk_server_env))
  return env
end

local function post_with_protocol(service, params, cb)
  local env = M.get_sdk_server_env()
  
  local function inner_cb(succ, ...)
    if succ then
      local data = (...)
      cb(true, data)
      if is_relink then
        CSTAT.stat_action("click_relink_cloud_source_success")
      end
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request_cloud_res failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, ...)
    end
  end
  
  if true == is_oversea then
    E.LOG.debug(TAG, "post_with_protocol its oversea, now use usercenter_protocol post")
    check_oversea_url_base_init()
    local ucp_service = M.UCP_SERVICE_MAPPING[service]
    UCP.post(ucp_service, params, inner_cb)
  else
    DSP.set_env(DSP.ENV.RELEASE)
    if env == M.ENV.DEBUG then
      DSP.set_env(DSP.ENV.DEBUG)
    elseif env == M.ENV.PRE_RELEASE then
      DSP.set_env(DSP.ENV.PRE_RELEASE)
    end
    E.LOG.debug(TAG, "post_with_protocol its not oversea, now use aligames_protocol post with env:" .. tostring(env))
    local dsp_service = M.DSP_SERVICE_MAPPING[service]
    DSP.post(dsp_service, params, inner_cb)
  end
end

function M.request_cloud_service(service, params, cb)
  local function request_service_handler(res_params)
    post_with_protocol(service, res_params, cb)
  end
  
  local res_params = params or {}
  if not res_params.agst or res_params.agst == "" then
    DEVICE_ID.get_token(function(device_token)
      res_params.agst = device_token
      E.LOG.debug(TAG, "get agst from agst_token_manager, and begin request")
      request_service_handler(res_params)
    end)
  else
    E.LOG.debug(TAG, "has agst already and begin request")
    request_service_handler(res_params)
  end
end

function M.request_cloud_config(cb)
  if request_cloud_config_state == STATE.STATE_SUCC then
    E.LOG.debug(TAG, "request_cloud_config already succ, now return")
    cb(true)
    return
  end
  if request_cloud_config_state == STATE.STATE_RUNNING then
    E.LOG.debug(TAG, "request_cloud_config initting, add listener and return")
    table.insert(request_cloud_config_listeners, cb)
    return
  end
  request_cloud_config_state = STATE.STATE_RUNNING
  table.insert(request_cloud_config_listeners, cb)
  
  local function config_callback(succ, ...)
    E.LOG.debug(TAG, "request_cloud_config begin callback, listener size:" .. tostring(#request_cloud_config_listeners))
    for _, callback in ipairs(request_cloud_config_listeners) do
      callback(succ, ...)
    end
    request_cloud_config_listeners = {}
  end
  
  M._request_cloud_config(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "request_cloud_config succ")
      request_cloud_config_state = STATE.STATE_SUCC
      config_callback(true)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      request_cloud_config_state = STATE.STATE_DEFAULT
      config_callback(false, code, msg)
    end
  end)
end

local function get_current_env_namespace()
  local cloudgame_namespace
  local env = M.get_cloud_env()
  if env == M.ENV.DEBUG then
    cloudgame_namespace = NAMESPACE_CLOUDGAME_TEST
  else
    cloudgame_namespace = NAMESPACE_CLOUDGAME
  end
  E.LOG.debug(TAG, "get_current_env_name_space, env:" .. tostring(env) .. ", namespace:" .. tostring(cloudgame_namespace))
  return cloudgame_namespace
end

function M.request_cloud_static_config(cb)
  if request_cloud_static_config_state == STATE.STATE_SUCC then
    E.LOG.debug(TAG, "request_cloud_static_config already succ, now return")
    cb(true)
    return
  end
  if request_cloud_static_config_state == STATE.STATE_RUNNING then
    E.LOG.debug(TAG, "request_cloud_static_config initting, add listener and return")
    table.insert(request_cloud_static_config_listeners, cb)
    return
  end
  request_cloud_static_config_state = STATE.STATE_RUNNING
  table.insert(request_cloud_static_config_listeners, cb)
  
  local function config_callback(succ, ...)
    E.LOG.debug(TAG, "request_cloud_config begin callback, listener size:" .. tostring(#request_cloud_static_config_listeners))
    for _, callback in ipairs(request_cloud_static_config_listeners) do
      callback(succ, ...)
    end
    request_cloud_static_config_listeners = {}
  end
  
  local cloudgame_namespace = get_current_env_namespace()
  ECC.set_ex_info(cloudgame_namespace, {
    cloudGameId = CC.CloudGameId
  })
  E.LOG.debug(TAG, "current cloudgame namespace is:" .. tostring(cloudgame_namespace) .. ", CC.CloudGameId:" .. tostring(CC.CloudGameId))
  ECC.get_configs_in_whitelist({cloudgame_namespace}, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "request_cloud_static_config succ")
      local cloud_game_config = M.get_cloud_static_config()
      if cloud_game_config and next(cloud_game_config) ~= nil and nil ~= cloud_game_config.config then
        request_cloud_static_config_state = STATE.STATE_SUCC
        E.log(cloud_game_config)
        local config_data = cloud_game_config.config
        local sdk_config_info = config_data and config_data.cloud_sdk_config or nil
        E.LOG.debug(TAG, "sdk_config_info >>")
        E.log(sdk_config_info)
        M._cache_cloud_static_config(sdk_config_info)
        M._cache_free_flow_config(config_data)
        config_callback(true)
        notify_static_config_refresh()
      else
        request_cloud_static_config_state = STATE.STATE_DEFAULT
        local code = EC.CLOUD_GAME_ERROR_CODES.CLOUD_STATIC_CONFIG_INVALID
        local msg = "config is empty"
        E.LOG.warn(TAG, "request cloudgame namespace config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        config_callback(false, code, msg)
      end
    else
      request_cloud_static_config_state = STATE.STATE_DEFAULT
      local code, msg = ...
      E.LOG.warn(TAG, "request_cloud_static_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      config_callback(false, code, msg)
    end
  end)
end

function M.observer_cloud_static_config_refresh(cb)
  for _, callback in pairs(cloud_static_config_refresh_cbs) do
    if callback == cb then
      return
    end
  end
  cloud_static_config_refresh_cbs[#cloud_static_config_refresh_cbs + 1] = cb
end

function M.get_cloud_static_config()
  local cur_env_cloudgame_namespace = get_current_env_namespace()
  E.LOG.debug(TAG, "return config data for namespace:" .. tostring(cur_env_cloudgame_namespace))
  do return ECC.get_config end
  return ECC.get_config, cur_env_cloudgame_namespace, "return config data for namespace:" .. tostring(cur_env_cloudgame_namespace), tostring(cur_env_cloudgame_namespace), cur_env_cloudgame_namespace
end

local function read_params_from_command_line()
  local params = {}
  local channel_adapter = require("ejoysdk_lua.cloud_game.cloud_message.channel_adapter")
  local p = channel_adapter.parse_command_line()
  params.ip = p["-cgip"] or "127.0.0.1"
  params.port = p["-cgport"] or 5189
  params.target_width = p["-w"] or 1280
  params.target_height = p["-h"] or 720
  params.pkg_name = p["-cgpkg"] or E.get_pkg_info().pkg_name
  params.cg_safecode = p["-cg_safecode"] or ""
  params.cg_savepath = p["-cg_savepath"] or ""
  E.LOG.debug(TAG, "read_params_from_command_line >>")
  E.LOG.debug(TAG, params)
  CSTAT.stat_err_msg("read_params_from_command_line:" .. JSON.encode(params))
  return params
end

local function check_windows_private_dir(sub_dir_name, _rm_sub_dir_on_start)
  if E.Sysinfo.os() ~= "windows" then
    E.LOG.debug(TAG, "check_windows_private_dir skip, not windows")
    return
  end
  E.LOG.debug(TAG, "check_windows_private_dir begin, for windows")
  local custom_sub_dir_params = {sub_dir = sub_dir_name, rm_sub_dir_on_start = _rm_sub_dir_on_start}
  E.KeyStore.custom_sub_dir(custom_sub_dir_params)
end

function M.init(cb)
  local cloud_mode = M.get_cloud_mode()
  E.LOG.debug(TAG, "check_init_cloud begin, mode:" .. tostring(cloud_mode))
  is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  
  local function init_callback(succ, ...)
    if succ then
      local body = (...)
      E.LOG.debug(TAG, "init cloud succ >>")
      E.log(body)
      if body then
        local debuggable = body[M.LUA_KEY.LUA_KEY_DEBUGGABLE] or "false"
        set_debuggable(debuggable)
        local play_config = body[M.LUA_KEY.LUA_KEY_PLAY_CONFIG] or {}
        set_current_play_config(play_config)
      end
      cb(true, ...)
    else
      local code, msg = ...
      if type(msg) == "table" then
        local body = msg
        msg = body.msg or ""
      end
      E.LOG.warn(TAG, "yunyou init failed error code: " .. tostring(code) .. " ,msg: " .. tostring(msg))
      cb(false, code, msg)
    end
  end
  
  local cloud_env = get_cloud_env()
  if cloud_mode == CC.CLOUD_MODE.CLOUD and M.is_use_lua_msg_channel() then
    E.LOG.debug(TAG, "init cloud side use lua channel")
    local command_params = read_params_from_command_line()
    E.CONFIG.set_config(M.EJOY_CONFIG_KEY.TARGET_WIDTH, command_params.target_width)
    E.CONFIG.set_config(M.EJOY_CONFIG_KEY.TARGET_HEIGHT, command_params.target_height)
    E.CONFIG.set_config(M.EJOY_CONFIG_KEY.SAFE_CODE, command_params.cg_safecode)
    E.CONFIG.set_config(M.EJOY_CONFIG_KEY.CG_SAVE_PATH, command_params.cg_savepath)
    E.CONFIG.set_config(M.EJOY_CONFIG_KEY.CG_PORT, command_params.port)
    if command_params.cg_savepath and command_params.cg_savepath ~= "" then
      E.LOG.warn(TAG, "start up with cg_savepath:" .. command_params.cg_savepath)
      check_windows_private_dir(command_params.cg_savepath, false)
    else
      E.LOG.warn(TAG, "start up with no cg_savepath, use port instead!")
      check_windows_private_dir(tostring(command_params.port), true)
    end
    local channel_adapter = require("ejoysdk_lua.cloud_game.cloud_message.channel_adapter")
    local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
    channel_adapter.create_msg_channel(command_params.ip, command_params.port, command_params.pkg_name, function()
      is_message_channel_enabled = true
      local body = {}
      body[M.LUA_KEY.LUA_KEY_DEBUGGABLE] = "true"
      E.LOG.debug(TAG, "create_msg_channel succ")
      init_callback(true, body)
    end)
    channel_adapter.set_message_handle(CG.receive_data)
  elseif cloud_mode == CC.CLOUD_MODE.CLOUD then
    if "test_demo" == cloud_env then
      E.LOG.debug(TAG, "its test_demo or cloud side, directly init cloud native")
      M._init_cloud_native(init_callback)
    else
      UNI.async_call(VENDOR_NAME, M.ASYNC_GET_CGS_START_UP_PARAMS, {}, nil, function(succ, ...)
        if succ then
          local params = (...)
          if params and type(params) == "table" then
            local safe_code = params[M.LUA_KEY.LUA_KEY_SAFE_CODE] or ""
            E.LOG.debug(TAG, "get cgs safe code >> " .. tostring(safe_code))
            E.CONFIG.set_config(M.EJOY_CONFIG_KEY.SAFE_CODE, safe_code)
          end
        else
          E.LOG.debug(TAG, "get pc start up data failed")
        end
      end)
      M._init_cloud_native(init_callback)
    end
  else
    E.LOG.debug(TAG, "request server for resouce")
    M.request_cloud_static_config(function(succ, ...)
      if succ then
        E.LOG.warn(TAG, "request_cloud_config succ, now begin init_cloud_native")
        M._init_cloud_native(init_callback)
      else
        local code, msg = ...
        E.LOG.warn(TAG, "request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        init_callback(false, code, msg)
      end
    end)
  end
end

function M.stop_game(cb)
  UNI.async_call(VENDOR_NAME, M.ASYNC_STOP_CLOUD_GAME, {}, nil, function(succ, ...)
    E.LOG.debug(TAG, "start_game#stop cloud async_call finish")
    start_game_begin_time = nil
    cb(succ, ...)
  end)
end

local function request_cloud_game_res(start_remote_mode, remote_config, callback)
  if start_remote_mode == M.START_MODE.MODE_IP_PORT then
    E.LOG.debug(TAG, "start_game begin, start_mode is ip&port, now start game with specified ip and port")
    local params = {
      ip = remote_config.remote_ip,
      port = remote_config.remote_port
    }
    callback(true, params)
  else
    E.LOG.debug(TAG, "start_game begin, _get_schedule_start_params")
    M._get_schedule_start_params(function(succ, ...)
      if CC.DEBUG_OPTIONS.TestConnectFailed then
        callback(false, 5001004, "连接失败")
        return
      end
      if succ then
        local params = (...)
        E.LOG.debug(TAG, "_get_schedule_start_params succ, begin start params >>")
        E.log(params)
        callback(true, params)
      else
        E.LOG.warn(TAG, "_get_schedule_start_params failed")
        callback(false, ...)
      end
    end)
  end
end

function M.check_start_game(start_remote_mode, remote_config, callback, ex_params)
  local function start_with_res_fun(succ, ...)
    if succ then
      local res_params = (...)
      
      local start_params = {
        start_mode = start_remote_mode,
        params = res_params,
        sdk_ex_params = ex_params
      }
      E.LOG.debug(TAG, "start_game#start cloud game begin")
      CSTAT.stat_action("link_cloud_request")
      local begin_time = os.time()
      UNI.async_call(VENDOR_NAME, M.ASYNC_START_CLOUD_GAME, start_params, nil, function(succ2, ...)
        _ejoysdk.log("start cloudgame async callback, succ:" .. tostring(succ2))
        local start_cost_time = os.time() - begin_time
        local stat_params = {
          cost_time = tostring(start_cost_time),
          is_priority_high = true
        }
        if succ2 then
          start_game_begin_time = os.time()
          E.LOG.debug(TAG, "start_game succ")
          callback(true)
          CSTAT.stat_action("link_cloud_request_return", nil, true, stat_params)
        else
          start_game_begin_time = nil
          local code, body = ...
          if code == CLOUD_SDK_ERR_CODE.ALREADY_START then
            E.LOG.warn(TAG, "start_game succ, already start: " .. tostring(code))
            callback(true)
          else
            local err_msg = ""
            if body then
              err_msg = body.error_msg
            end
            E.LOG.warn(TAG, "start_game failed, code: " .. tostring(code) .. ", msg:" .. tostring(err_msg))
            callback(false, code, err_msg)
            stat_params.code = code
            stat_params.msg = err_msg
            CSTAT.stat_action_fail("link_cloud_request_return", nil, stat_params)
          end
        end
        server_schedule_config = {}
      end)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request_cloud_game_res failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      callback(false, ...)
    end
  end
  
  local last_game_start_begin_time = start_game_begin_time or 0
  local has_already_start = last_game_start_begin_time > 0
  if has_already_start then
    E.LOG.debug(TAG, "start_game#has_already_start true, now stop cloud game first before start")
    M.stop_game(function(_succ, ...)
      E.LOG.debug(TAG, "start_game#stop cloud finish, now start cloud game")
      request_cloud_game_res(start_remote_mode, remote_config, start_with_res_fun)
    end)
  else
    E.LOG.debug(TAG, "start_game#has_already_start false, now directly start")
    request_cloud_game_res(start_remote_mode, remote_config, start_with_res_fun)
  end
end

function M.start_game(remote_config, cb, ex_params)
  if start_game_state == STATE.STATE_RUNNING then
    E.LOG.warn(TAG, "start_game is RUNNING now wait and return")
    table.insert(start_game_listeners, cb)
    return
  end
  E.LOG.debug(TAG, "start_game begin, mark running state")
  start_game_state = STATE.STATE_RUNNING
  table.insert(start_game_listeners, cb)
  
  local function start_callback(succ, ...)
    E.LOG.debug(TAG, "start_game callback, size:" .. tostring(#start_game_listeners))
    for _, start_cb in ipairs(start_game_listeners) do
      start_cb(succ, ...)
    end
    start_game_listeners = {}
    start_game_state = STATE.STATE_DEFAULT
  end
  
  local start_remote_mode = M.START_MODE.MODE_AUTO_SCHEDULE
  if remote_config and remote_config.remote_start_mode == M.START_MODE.MODE_IP_PORT and remote_config.remote_ip and remote_config.remote_port then
    start_remote_mode = M.START_MODE.MODE_IP_PORT
  end
  E.LOG.debug(TAG, "start_game begin, start_remote_mode:" .. tostring(start_remote_mode))
  M.check_start_game(start_remote_mode, remote_config, start_callback, ex_params)
end

local function do_send_msg(message, cb, message_id)
  local params = {msg = message, msg_id = message_id}
  E.LOG.debug(TAG, "send_msg, data:" .. (message or "nil"))
  E.LOG.debug(TAG, "send_msg >> params:")
  E.LOG.debug(TAG, params)
  
  local function on_cb_wrap(succ, ...)
    if succ then
      E.LOG.debug(TAG, "send_msg succ")
      cb(true)
    else
      local code, fail_body = ...
      local _fail_body = fail_body or {}
      local err_msg = _fail_body.error_msg
      local fail_data = _fail_body.fail_data or {}
      local fail_msg_id = fail_data.msg_id
      E.LOG.warn(TAG, "send_msg failed, code: " .. tostring(code) .. ", msg:" .. tostring(err_msg) .. ", fail_msg_id:" .. tostring(fail_msg_id))
      cb(false, code, err_msg, fail_msg_id)
    end
  end
  
  if M.is_use_lua_msg_channel() and is_message_channel_enabled then
    E.LOG.debug(TAG, "send with LUA message channel")
    local channel_adapter = require("ejoysdk_lua.cloud_game.cloud_message.channel_adapter")
    channel_adapter.send_message(message, on_cb_wrap, message_id)
  else
    E.LOG.debug(TAG, "send with NATIVE message channel")
    UNI.async_call(VENDOR_NAME, M.ASYNC_SEND_MSG, params, nil, on_cb_wrap)
  end
end

function M.send_msg(message, cb, msg_id)
  if not message or "" == message then
    local err_msg = "send_msg failed, message is nil!"
    E.LOG.warn(TAG, err_msg)
    cb(false, EC.CLOUD_GAME_ERROR_CODES.PARAMETER_INVALID, err_msg)
    return
  end
  do_send_msg(message, cb, msg_id)
end

function M.set_relink()
  E.LOG.debug(TAG, "set_relink true")
  is_relink = true
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local BASE_CLOUD_API = require("ejoysdk_lua.cloud_game.base_cloud_game_api")
local DOWNLOAD_RULES = require("ejoysdk_lua.cloud_game.cloud_download_rules")
local ELU = require("ejoysdk_lua.lang.util")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EI = require("ejoysdk_lua.ejoysdk_init")
local VERSION = require("ejoysdk_lua.version")
local VENDOR_NAME = "CLOUD_GAME"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.CLOUD_GAME
local ASYNC_SHOW_START_GAME_ACTIVITY = "ASYNC_SHOW_START_GAME_ACTIVITY"
local ASYNC_SHOW_INPUT_DIALOG = "ASYNC_SHOW_INPUT_DIALOG"
local ASYNC_CLIP_PLAIN_TEXT = "ASYNC_CLIP_PLAIN_TEXT"
local ASYNC_BATCH_CHECK_FILE_VALID = "ASYNC_BATCH_CHECK_FILE_VALID"
local ASYNC_CHANGE_QUALITY_LEVEL = "ASYNC_CHANGE_QUALITY_LEVEL"
local ASYNC_CHANGE_APP_DOWNLOAD_STATE = "ASYNC_CHANGE_APP_DOWNLOAD_STATE"
local ASYNC_PULL_APPSTORE_DOWNLOAD_PAGE = "ASYNC_PULL_APPSTORE_DOWNLOAD_PAGE"
local SYNC_START_GAME_ACTIVITY = "SYNC_START_GAME_ACTIVITY"
local SYNC_EXIT_CLOUD_GAME_APP = "SYNC_EXIT_CLOUD_GAME"
local SYNC_CLOSE_CLOUD_GAME = "SYNC_CLOSE_CLOUD_GAME"
local SYNC_SET_INFO = "SYNC_SET_INFO"
local SYNC_RESUME_GAME = "SYNC_RESUME_GAME"
local SYNC_INIT_FLOATER_CONFIG = "SYNC_INIT_FLOATER_CONFIG"
local SYNC_SHOW_FLOATER = "SYNC_SHOW_FLOATER"
local SYNC_HIDE_FLOATER = "SYNC_HIDE_FLOATER"
local SYNC_SHOW_FLOATER_TIPS = "SYNC_SHOW_FLOATER_TIPS"
local SYNC_HIDE_FLOATER_TIPS = "SYNC_HIDE_FLOATER_TIPS"
local SYNC_NETWORK_QUALITY_VISIBLE = "SYNC_NETWORK_QUALITY_VISIBLE"
local CAST_SHOW_TIPS = "CAST_SHOW_TIPS"
local CAST_HIDE_TIPS = "CAST_HIDE_TIPS"
local CAST_DOWNLOAD_SPEED_CHANGED = "CAST_DOWNLOAD_SPEED_CHANGED"
local CAST_LOGIN_EVENT = "CAST_LOGIN_EVENT"
local CAST_SHOW_LOADING = "CAST_SHOW_LOADING"
local CAST_HIDE_LOADING = "CAST_HIDE_LOADING"
local LUA_KEY_BIT_RATE = "bit_rate"
local LUA_KEY_NETWORK_DELAY = "network_delay"
local LUA_KEY_NETWORK_COST = "network_cost"
local LUA_KEY_INPUT_CONTENT = "input_content"
local LUA_KEY_CONN_TYPE = "connect_type"
local LUA_KEY_SPEED_VALUE = "speed"
local LUA_KEY_QUALITY_LEVEL = "quality_level"
local LUA_KEY_APP_ID = "app_id"
local LUA_KEY_DIRECT_START_GAME_ACTIVITY = "direct_start_game_activity"
local LUA_KEY_VISIBLE = "visible"
local MAX_CLIP_TEXT_LEN = 4096
local LUA_KEY_LOGIN_EVENT = "login_event"
local LUA_KEY_LOGIN_RESULT = "login_result"
local LOGIN_EVENT = {
  LOGIN_BEGIN = "LOGIN_BEGIN",
  LOGIN_END = "LOGIN_END",
  ACQUIRE_END = "ACQUIRE_END"
}
local INTERNAL_EVENT = {
  EVT_ON_REMOTE_MSG_CALLBACK = "EVT_ON_REMOTE_MSG_CALLBACK",
  EVT_ON_CG_MSG_CALLBACK = "EVT_ON_CG_MSG_CALLBACK",
  EVT_ON_YUNYOU_EXIT_EVENT = "EVT_ON_YUNYOU_EXIT_EVENT",
  EVT_ON_CLOUD_DESTROYED = "EVT_ON_CLOUD_DESTROYED",
  EVT_ON_CGError = "EVT_ON_CGError",
  EVT_ON_CG_START_SUCCESS = "EVT_ON_CG_START_SUCCESS",
  EVT_ON_NETWORK_CHANGE = "EVT_ON_NETWORK_CHANGE",
  EVT_ON_CG_INFO_CHANGE = "EVT_ON_CG_INFO_CHANGE",
  EVT_ON_LUA_CLOSE_EVENT = "EVT_ON_LUA_CLOSE_EVENT",
  EVT_SHOW_RATIONALE_CLOSE_VIEW_EVENT = "EVT_SHOW_RATIONALE_CLOSE_VIEW_EVENT",
  EVT_ACTIVITY_STATE_CHANGED = "EVT_ACTIVITY_STATE_CHANGED",
  EVT_CONNECT_SETUP_SUCC = "EVT_CONNECT_SETUP_SUCC",
  EVT_UPDATE_CURRENT_DOWNLOAD_SPEED = "EVT_UPDATE_CURRENT_DOWNLOAD_SPEED",
  EVT_GET_CURRENT_DOWNLOAD_SPEED = "EVT_GET_CURRENT_DOWNLOAD_SPEED",
  EVT_CLOUD_GAME_VISIBILITY_CHANGE = "EVT_CLOUD_GAME_VISIBILITY_CHANGE",
  EVT_CLOUD_GAME_NETWORK_QUALITY = "EVT_CLOUD_GAME_NETWORK_QUALITY",
  EVT_CLOUD_GAME_NATIVE_STAT = "EVT_CLOUD_GAME_NATIVE_STAT"
}
local INFO_KEY = {
  INFO_KEY_DOWNLOAD_SPEED_CONTROL = "info_key_download_speed_control"
}
M.CLOUD_MODE = {
  CLOUD = BASE_CLOUD_API.CLOUD_MODE.CLOUD,
  MOBILE = BASE_CLOUD_API.CLOUD_MODE.MOBILE
}
M.START_MODE = {
  MODE_IP_PORT = "mode_ip",
  MODE_AUTO_SCHEDULE = "mode_schedule"
}
M.EVENT = {
  ON_RECEIVE_CLOUD_GAME_MESSAGE = "ON_RECEIVE_CLOUD_GAME_MESSAGE"
}
M.NETWORK_QUALITY = {
  NETWORK_QUALITY = "network_quality",
  PACKAGE_RTT = "package_rtt",
  PACKAGE_RTT_LEVEL = "package_rtt_level",
  LOSS_RATIO = "loss_ratio",
  LOSS_RATIO_LEVEL = "loss_ratio_level"
}
local RES_KEY = {
  TOKEN = "token",
  SCHEDULE_ID = "scheduleId",
  CLOUD_GAME_ID = "cloudGameId",
  EX = "ex",
  EX_PLAY_CONFIG = "play_config",
  EX_SDK_CONFIG = "sdk_config",
  EX_RESTRICT_RULES = "restrict_rules",
  EX_SKIP_TIME_BEFORE_CHECK_RESTRICT_SEC = "skip_time_before_restrict_check_sec",
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
  EX_RESTRICT_NOTIFY_TYPE_DIALOG = "dialog",
  EX_RESTRICT_NOTIFY_TYPE_TIPS = "tips"
}
local current_restrict_state = {
  state = false,
  rtt_total_count = 0,
  rtt_fine_times = 0,
  rtt_delay_first_check_time_sec = 0,
  rtt_fine_first_check_time_sec = 0
}
local INNER_ERR_CODE = {INPUT_CANCELLED = 603}
local current_cloud_mode, start_game_begin_time
local init_cloud_succ = false
local current_cloud_vendor
local download_game_res_finish_state = false
local cloud_network_quality, cloud_game_visibility_change_listener, get_current_download_speed_listener, install_page_state_listener

function M.get_remote_config(start_mode, ip, port)
  return {
    remote_start_mode = start_mode,
    remote_ip = ip,
    remote_port = port
  }
end

function M.show_start_game_activity_entrace(cb)
  UNI.async_call(VENDOR_NAME, ASYNC_SHOW_START_GAME_ACTIVITY, {}, nil, function(succ, ...)
    E.LOG.debug(TAG, "show_start_game_activity_entrace ")
    if cb then
      cb(succ, ...)
    end
  end)
  download_game_res_finish_state = true
end

function M.stop_game(cb)
  BASE_CLOUD_API.stop_game(function(succ, ...)
    E.LOG.debug(TAG, "start_game#stop cloud async_call finish, now start cloud game")
    start_game_begin_time = nil
    cb(succ, ...)
  end)
end

function M.exit_cloud_game_app()
  E.LOG.debug(TAG, "exit_cloud_game_app begin")
  UNI.sync_call(VENDOR_NAME, SYNC_EXIT_CLOUD_GAME_APP, {}, nil)
end

function M.close_cloud_game_view(params, cb)
  E.LOG.debug(TAG, "exit_cloud_game")
  UNI.sync_call(VENDOR_NAME, SYNC_CLOSE_CLOUD_GAME, params, nil)
  if cb then
    cb(true)
  end
end

local function silent_exit_game()
  M.stop_game(function(_succ)
    E.LOG.debug(TAG, "exit_app kill process begin")
    E.kill_game_process()
  end)
end

function M.exit_game()
  E.LOG.debug(TAG, "exit_game begin")
  local exit_text = ELU.getString("exit_game")
  CSTAT.stat_action("mini_client_exit_game_begin")
  E.Toast.show(exit_text)
  M.stop_game(function(_succ)
    E.Timer.once(2, function()
      E.LOG.debug(TAG, "exit_app kill process begin")
      E.Toast.hide()
      E.kill_game_process()
    end)
  end)
end

function M.get_server_config_data()
  E.LOG.debug(TAG, "get_token_data begin >>")
  local config_data = BASE_CLOUD_API.get_server_config_data()
  E.LOG.debug(TAG, config_data)
  return config_data
end

function M.get_config_game_res_info()
  E.LOG.debug(TAG, "get_config_game_res_info >>")
  local game_res_info = BASE_CLOUD_API.get_game_res_info()
  E.log(game_res_info)
  return game_res_info
end

function M.get_network_quality()
  E.LOG.debug(TAG, "get_network_quality >>")
  E.log(cloud_network_quality)
  return cloud_network_quality
end

function M.change_quality_level(level, cb)
  local params = {
    [LUA_KEY_QUALITY_LEVEL] = level
  }
  UNI.async_call(VENDOR_NAME, ASYNC_CHANGE_QUALITY_LEVEL, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "change quality level callback >> " .. tostring(succ))
    if not cb then
      return
    end
    if succ then
      cb(true, level)
    else
      local current_level = -1
      if cloud_network_quality[M.NETWORK_QUALITY.NETWORK_QUALITY] then
        current_level = cloud_network_quality[M.NETWORK_QUALITY.NETWORK_QUALITY]
      end
      cb(false, current_level)
    end
  end)
end

function M.pull_appstore_download_page(app_id)
  if not app_id then
    E.LOG.e(TAG, "app-id is nil, return")
    return
  end
  local params = {
    [LUA_KEY_APP_ID] = app_id
  }
  if install_page_state_listener then
    install_page_state_listener(true)
  end
  UNI.async_call(VENDOR_NAME, ASYNC_PULL_APPSTORE_DOWNLOAD_PAGE, params, nil, function()
    E.LOG.debug(TAG, "receive appstore download page close")
    if install_page_state_listener then
      install_page_state_listener(false)
    end
  end)
end

function M.set_install_page_state_change_listener(listener)
  install_page_state_listener = listener
end

local EVT_HANDLERS = {}
EVT_HANDLERS[INTERNAL_EVENT.EVT_UPDATE_CURRENT_DOWNLOAD_SPEED] = function(body)
  local speed_value = body[LUA_KEY_SPEED_VALUE] or 0
  local speed_in_byte = speed_value / 8
  E.LOG.debug(TAG, "EVT_UPDATE_CURRENT_DOWNLOAD_SPEED 更新当前下载速度:" .. tostring(speed_in_byte))
  DOWNLOAD_RULES.handle_sdk_download_speed_limit(speed_in_byte)
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_GET_CURRENT_DOWNLOAD_SPEED] = function()
  E.LOG.debug(TAG, "EVT_GET_CURRENT_DOWNLOAD_SPEED 收到云游SDK获取当前速度消息:")
  if get_current_download_speed_listener then
    get_current_download_speed_listener()
  end
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_CLOUD_GAME_VISIBILITY_CHANGE] = function(body)
  local visible = body[LUA_KEY_VISIBLE] or false
  E.LOG.debug(TAG, "EVT_CLOUD_GAME_VISIBILITY_CHANGE 收到当前云游界面的可见状态 >> " .. tostring(visible) .. ", lis:" .. type(cloud_game_visibility_change_listener))
  if cloud_game_visibility_change_listener then
    cloud_game_visibility_change_listener(visible)
  end
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_CONNECT_SETUP_SUCC] = function(body)
  if current_cloud_mode ~= M.CLOUD_MODE.MOBILE then
    return
  end
  local connect_type = body[LUA_KEY_CONN_TYPE] or "unknown"
  E.LOG.debug(TAG, "EVT_CONNECT_SETUP_SUCC, conn_type:" .. tostring(connect_type))
  local stat_params = {connect_type = connect_type, is_priority_high = true}
  CSTAT.stat_action("mini_client_conn_setup", nil, true, stat_params)
  DOWNLOAD_RULES.handle_sdk_connect_type_changed(connect_type)
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_CLOUD_DESTROYED] = function(_body)
  E.LOG.debug(TAG, "EVT_ON_CLOUD_DESTROYED")
  silent_exit_game()
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ACTIVITY_STATE_CHANGED] = function(body)
  if body and body.state then
    E.LOG.debug(TAG, "receive msg EVT_ACTIVITY_STATE_CHANGED, state:" .. tostring(body.state))
    local state_info = {
      state = body.state
    }
    ET.publish(cloud_config.CLOUD_TOPIC.TOPIC_ACTIVITY_STATE_CHANGED_INNER, state_info)
  else
    E.LOG.warn(TAG, "receive EVT_ACTIVITY_STATE_CHANGED, body is nil, do nothing")
  end
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_LUA_CLOSE_EVENT] = function(_body)
  E.LOG.debug(TAG, "received EVT_ON_LUA_CLOSE_EVENT")
  ET.publish(cloud_config.CLOUD_TOPIC.TOPIC_LUA_CLOSED)
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_SHOW_RATIONALE_CLOSE_VIEW_EVENT] = function(_body)
  E.LOG.debug(TAG, "received EVT_SHOW_RATIONALE_CLOSE_VIEW_EVENT")
  local facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  facade.exit_cloud_game(false, {}, function(_succ, ...)
  end)
  local cstat = require("ejoysdk_lua.cloud_game.cloud_stat")
  cstat.stat_cloud_exit("back_key")
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_REMOTE_MSG_CALLBACK] = function(body)
  if body and body.data then
    local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
    E.LOG.debug(TAG, "receive msg on java ,EVT_ON_REMOTE_MSG_CALLBACK, now receive_data:")
    E.LOG.debug(TAG, body.data)
    CG.receive_data(body.data)
  else
    E.LOG.warn(TAG, "receive EVT_ON_REMOTE_MSG_CALLBACK, body is nil OR body.data is nil, do nothing")
  end
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_NETWORK_CHANGE] = function(_body)
  E.LOG.debug(TAG, "receive EVT_ON_NETWORK_CHANGE, now receive_data:")
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_CGError] = function(body)
  local err_code = body.event
  E.LOG.warn(TAG, "[cloud game] EVT_ON_CGError event " .. tostring(err_code))
  M.change_native_network_quality_visible(false)
  local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
  CG.on_cg_error(err_code)
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_YUNYOU_EXIT_EVENT] = function(_body)
  E.LOG.debug(TAG, "lua receive EVT_ON_YUNYOU_EXIT_EVENT")
end
local last_show_network_quality_low_time

local function handle_cloud_network_quality(data)
  if data and data[M.NETWORK_QUALITY.NETWORK_QUALITY] then
    local network_quality = data[M.NETWORK_QUALITY.NETWORK_QUALITY]
    if 0 == network_quality or 1 == network_quality then
      if cloud_network_quality and cloud_network_quality[M.NETWORK_QUALITY.NETWORK_QUALITY] then
        local current_network_quality = cloud_network_quality[M.NETWORK_QUALITY.NETWORK_QUALITY]
        local show_quality_tips_interval = 0
        if nil ~= last_show_network_quality_low_time then
          show_quality_tips_interval = os.time() - last_show_network_quality_low_time
        end
        if 0 ~= current_network_quality and 1 ~= current_network_quality then
          local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
          CG.cloud_network_quality_low()
          last_show_network_quality_low_time = os.time()
        elseif show_quality_tips_interval > 10 then
          local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
          CG.cloud_network_quality_low()
          last_show_network_quality_low_time = os.time()
        end
      else
        local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
        CG.cloud_network_quality_low()
        last_show_network_quality_low_time = os.time()
      end
    end
  end
  cloud_network_quality = data
end

local function handle_cloud_game_native_stat(body)
  if body and body.event then
    E.LOG.debug(TAG, "stat native event >> " .. tostring(body.event))
    CSTAT.stat_action(body.event)
  else
    E.LOG.debug(TAG, "stat native event, event is nil, do nothing")
  end
end

EVT_HANDLERS[INTERNAL_EVENT.EVT_CLOUD_GAME_NETWORK_QUALITY] = function(body)
  E.LOG.debug(TAG, "lua receive EVT_CLOUD_GAME_NETWORK_QUALITY")
  E.log(body)
  handle_cloud_network_quality(body)
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_CLOUD_GAME_NATIVE_STAT] = function(body)
  E.LOG.debug(TAG, "lua receive EVT_CLOUD_GAME_NATIVE_STAT")
  E.log(body)
  handle_cloud_game_native_stat(body)
end

local function check_restrict_rules(bit_rate, network_delay)
  if not start_game_begin_time then
    E.LOG.warn(TAG, "check_restrict_rules start game not begin, return check")
    return
  end
  local current_time_sec = os.time()
  local from_start_game_time = current_time_sec - start_game_begin_time
  local skip_time_before_restrict_check_sec = current_cloud_vendor.get_server_skip_time_before_restrict_check_sec()
  if from_start_game_time < skip_time_before_restrict_check_sec then
    E.LOG.debug(TAG, "check_restrict_rules from_start_game_time less than skip_time_before_restrict_check_sec skip, from_start_game_time:" .. tostring(from_start_game_time) .. ", skip_time_before_restrict_check_sec:" .. tostring(skip_time_before_restrict_check_sec))
    return
  end
  local state_changed = false
  
  local function update_restrict_state(state, restrict_rule)
    local origin_state = current_restrict_state.state
    if origin_state ~= state then
      E.LOG.debug(TAG, "update_restrict_state state changed")
      state_changed = true
    end
    current_restrict_state.state = state
    current_restrict_state.current_restrict_rule = restrict_rule
  end
  
  local restrict_rules = current_cloud_vendor.get_server_restrict_rules()
  for index, rule in ipairs(restrict_rules) do
    local rule_min_fps = rule[RES_KEY.EX_RULE_MIN_FPS]
    local rule_max_rtt_ms = rule[RES_KEY.EX_RULE_MAX_RTT_MS]
    local rule_check_interval_sec = rule[RES_KEY.EX_RULE_CHECK_INTERVAL_SEC]
    local rule_max_rtt_delay_percent = rule[RES_KEY.EX_RULE_MAX_RTT_DELAY_PERCENT]
    local rule_rtt_timeout_ms = rule[RES_KEY.EX_RULE_RTT_PING_TIMEOUT_MS]
    if current_restrict_state.state then
      local current_restrict_rule = current_restrict_state.current_restrict_rule
      if current_restrict_rule then
        E.LOG.debug(TAG, "check_restrict_rules1, bit_rate:" .. tostring(bit_rate) .. ", min_fpx:" .. tostring(current_restrict_rule[RES_KEY.EX_RULE_MIN_FPS]) .. ", network_delay:" .. tostring(network_delay) .. ", max_rtt:" .. tostring(current_restrict_rule[RES_KEY.EX_RULE_MAX_RTT_MS]))
        if bit_rate > current_restrict_rule[RES_KEY.EX_RULE_MIN_FPS] and (network_delay >= rule_rtt_timeout_ms or network_delay < current_restrict_rule[RES_KEY.EX_RULE_MAX_RTT_MS]) then
          E.LOG.debug(TAG, "check_restrict_rules2, OK")
          update_restrict_state(false, nil)
          break
        end
      end
    else
      current_restrict_state.rtt_total_times = current_restrict_state.rtt_total_times or {}
      table.insert(current_restrict_state.rtt_total_times, current_time_sec)
      if bit_rate > 0 and bit_rate <= rule_min_fps then
        E.LOG.debug(TAG, "check_restrict_rules3 fail, index:" .. tostring(index) .. ",bit_rate:" .. tostring(bit_rate) .. ", rule_min_fps:" .. tostring(rule_min_fps))
        update_restrict_state(true, rule)
        break
      elseif network_delay > rule_max_rtt_ms and network_delay < rule_rtt_timeout_ms then
        E.LOG.debug(TAG, "check_restrict_rules4 fail, network_delay:" .. tostring(network_delay) .. ", rule_max_rtt_ms:" .. tostring(rule_max_rtt_ms))
        current_restrict_state[index] = current_restrict_state[index] or {}
        local index_state = current_restrict_state[index]
        index_state.rtt_delay_items = index_state.rtt_delay_items or {}
        table.insert(index_state.rtt_delay_items, current_time_sec)
        local filtered_expired_delay_items = {}
        for _, item_sec in ipairs(index_state.rtt_delay_items) do
          if rule_check_interval_sec >= current_time_sec - item_sec then
            table.insert(filtered_expired_delay_items, item_sec)
          end
        end
        index_state.rtt_delay_items = filtered_expired_delay_items
        local filtered_expired_total_items = {}
        for _, item_sec in ipairs(current_restrict_state.rtt_total_times) do
          if rule_check_interval_sec >= current_time_sec - item_sec then
            E.LOG.debug(TAG, "check_restrict_rules mark_expired_total_indexs, state_index:" .. tostring(index) .. ", _ind:" .. tostring(_) .. ", len:" .. tostring(#current_restrict_state.rtt_total_times) .. ", current_time_sec:" .. tostring(current_time_sec) .. ", item_sec:" .. tostring(item_sec))
            table.insert(filtered_expired_total_items, item_sec)
          end
        end
        current_restrict_state.rtt_total_times = filtered_expired_total_items
        local delay_count = #index_state.rtt_delay_items
        local total_count = #current_restrict_state.rtt_total_times
        local delay_percent = math.floor(delay_count / total_count * 100)
        E.LOG.debug(TAG, "check_restrict_rules5, index:" .. tostring(index) .. ", delay_percent:" .. tostring(delay_percent) .. ", max delay percent:" .. tostring(rule_max_rtt_delay_percent) .. ", delay_count:" .. tostring(delay_count) .. ", total_count:" .. tostring(total_count))
        if rule_max_rtt_delay_percent < delay_percent then
          E.LOG.debug(TAG, "check_restrict_rules6 fail, index:" .. tostring(index) .. ", reach delay max percent, delay_percent:" .. tostring(delay_percent) .. ", max:" .. tostring(rule_max_rtt_delay_percent))
          update_restrict_state(true, rule)
          break
        end
      elseif network_delay > rule_max_rtt_ms and network_delay >= rule_rtt_timeout_ms then
        E.LOG.debug(TAG, "its timeout, not need process, skip")
      end
    end
  end
  if state_changed then
    E.LOG.debug(TAG, "check_restrict_rules state changed, now check rules>>")
    if current_restrict_state.current_restrict_rule and current_restrict_state.current_restrict_rule.restrict then
      E.LOG.debug(TAG, "check_restrict_rules start call on_restrict")
    else
      E.LOG.debug(TAG, "check_restrict_rules start hide restrict")
    end
  else
    E.LOG.debug(TAG, "check_restrict_rules state not changed, skip")
  end
end

local last_stat_cg_info_time = 0
local stat_cg_info_stat_interval = 60
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_CG_INFO_CHANGE] = function(body)
  if current_cloud_mode ~= M.CLOUD_MODE.MOBILE then
    return
  end
  local bit_rate = body[LUA_KEY_BIT_RATE] or 0
  local network_delay = body[LUA_KEY_NETWORK_DELAY] or 0
  local network_cost = body[LUA_KEY_NETWORK_COST] or 0
  E.LOG.warn(TAG, "[cloud game] EVT_ON_CG_INFO_CHANGE, bit_rate:" .. tostring(bit_rate) .. ", network_delay:" .. tostring(network_delay) .. ", network_cost:" .. tostring(network_cost))
  check_restrict_rules(bit_rate, network_delay)
  if network_cost > 0 and network_delay > 0 and bit_rate > 0 then
    local current_time = os.time()
    if current_time - last_stat_cg_info_time >= stat_cg_info_stat_interval then
      last_stat_cg_info_time = current_time
      E.LOG.debug(TAG, "on_cg_info_change state begin >>")
      local stat_params = {
        network_delay = math.floor(network_delay),
        bit_rate = math.floor(bit_rate),
        network_cost = math.floor(network_cost),
        is_priority_high = true
      }
      E.LOG.debug(TAG, stat_params)
      local finish_download
      if download_game_res_finish_state then
        finish_download = "finish"
      else
        finish_download = "downloading"
      end
      CSTAT.stat_action("mini_client_cg_info", finish_download, true, stat_params)
    end
  end
end

local function get_cloud_sdk_name()
  local sdk_infos = E.get_meta_config("sdks")
  for _, sdk_info in ipairs(sdk_infos) do
    local abilities = sdk_info.ability
    if abilities then
      for _, ab in ipairs(abilities) do
        if ab == BASE_CLOUD_API.get_vendor_name() then
          return sdk_info.name
        end
      end
    end
  end
  return nil
end

local function find_cloud_vendor()
  if nil ~= current_cloud_vendor then
    return current_cloud_vendor
  end
  local find_cloud_sdk_name = get_cloud_sdk_name()
  E.LOG.debug(TAG, "check_init_cloud, find_cloud_sdk_name:" .. tostring(find_cloud_sdk_name))
  if find_cloud_sdk_name == BASE_CLOUD_API.CLOUD_SDK_NAMES.ALIYUN_CLOUD_GAME then
    E.LOG.debug(TAG, "its aliyun cloudgame")
    current_cloud_vendor = require("ejoysdk_lua.cloud_game.ali_cloud_game_api")
  else
    E.LOG.debug(TAG, "its aligame cloudgame")
    current_cloud_vendor = require("ejoysdk_lua.cloud_game.aligame_cloud_game_api")
  end
  return current_cloud_vendor
end

local function check_init_cloud(cb)
  E.LOG.debug(TAG, "check_init_cloud begin")
  if init_cloud_succ then
    E.LOG.debug(TAG, "init_cloud already succ, now return")
    cb(true)
    return
  end
  current_cloud_vendor.init(function(succ, ...)
    init_cloud_succ = succ
    if succ then
      E.LOG.debug(TAG, "cloud game init succ, mode: " .. (current_cloud_mode or "nil"))
      local is_cloud_remote = current_cloud_mode == M.CLOUD_MODE.CLOUD
      if is_cloud_remote then
        local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
        local CC = require("ejoysdk_lua.cloud_game.cloud_config")
        local cconfig = cloud_config.get_cloud_meta_config()
        local init_params = UTILS.deepcopy(cconfig)
        init_params[CC.CONFIG_KEYS.CLOUD_GAME_MODE] = CC.CLOUD_MODE.CLOUD
        E.LOG.debug(TAG, "start init remote yunyou with mode: " .. tostring(current_cloud_mode))
        CG.init_mode(init_params, function(result)
          E.LOG.debug(TAG, "init_mode result >> result:" .. tostring(result.result) .. "code:" .. tostring(result.code) .. ", msg: " .. tostring(result.msg))
          cb(result.result, result.code, result.msg)
        end)
      else
        cb(true)
      end
      UNI.register_event_cb(VENDOR_NAME, function(type, body_data)
        if not type or "" == type then
          E.LOG.debug(TAG, "type is invalid")
          return
        end
        local handler = EVT_HANDLERS[type]
        if handler then
          E.LOG.debug(TAG, "handled event with type:" .. (type or "nil"))
          handler(body_data)
        end
      end)
    else
      E.LOG.warn(TAG, "init_cloud failed")
      cb(false, ...)
    end
  end)
end

function M.start_game(remote_config, cb, ex_params)
  check_init_cloud(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "check init succ, now do_start_game")
      current_cloud_vendor.start_game(remote_config, function(succ2, ...)
        if succ2 then
          start_game_begin_time = os.time()
          E.LOG.debug(TAG, "start_game succ")
          DOWNLOAD_RULES.handle_sdk_cloud_game_started()
        else
          start_game_begin_time = nil
          local code, msg = ...
          E.LOG.debug(TAG, "start_game failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
          DOWNLOAD_RULES.handle_failed_in_start_cloud()
        end
        cb(succ2, ...)
      end, ex_params)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "check init failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, ...)
      DOWNLOAD_RULES.handle_failed_in_start_cloud()
    end
  end)
end

function M.send_msg(message, cb, msg_id)
  current_cloud_vendor.send_msg(message, cb, msg_id)
end

function M.start_game_activity(direct_start_game_activity)
  local params = {
    [LUA_KEY_DIRECT_START_GAME_ACTIVITY] = direct_start_game_activity
  }
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_START_GAME_ACTIVITY, params, nil)
  E.LOG.debug(TAG, "start_game_activity sync_call result:" .. tostring(ret))
  if not ret then
    local ALL_CHANNEL = "ALL"
    UNI.register_init_listener(ALL_CHANNEL, function(succ2, msg)
      if succ2 then
        E.LOG.debug(TAG, "native init succ, now start game activity")
        UNI.sync_call(VENDOR_NAME, SYNC_START_GAME_ACTIVITY, params, nil)
      else
        E.LOG.warn(TAG, "native init failed, ")
        local err_msg = "游戏初始化失败，请尝试手动重启游戏"
        E.Toast.show(err_msg)
      end
    end)
    local _params = {}
    UNI.init(ALL_CHANNEL, _params)
  end
end

function M.cloud_sync_call(type_, params, _chunk)
  UNI.sync_call(VENDOR_NAME, type_, params)
end

function M.set_cloud_info(_key, _value)
  local params = {key = _key, value = _value}
  M.cloud_sync_call(SYNC_SET_INFO, params, nil)
end

function M.get_cloud_mode()
  do return end
  return cloud_config.get_cloud_mode, nil
end

local function login_begin_handler(_vendor_name)
  E.LOG.debug(TAG, "login_begin_handler >>")
  CSTAT.vendor_login_begin(_vendor_name)
  local run_mode = CSTAT.get_mobile_run_mode()
  if run_mode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    UNI.cast(VENDOR_NAME, CAST_LOGIN_EVENT, {
      [LUA_KEY_LOGIN_EVENT] = LOGIN_EVENT.LOGIN_BEGIN
    })
  end
end

local function pay_begin_handler()
  E.LOG.debug(TAG, "pay_begin_handler >>")
  CSTAT.pay_begin()
end

local function create_order_handler()
  E.LOG.debug(TAG, "create_order_handler >>")
  CSTAT.create_order_finish()
end

local function pay_succ_handler()
  E.LOG.debug(TAG, "pay_succ_handler >>")
  CSTAT.pay_end(true)
end

local function pay_fail_handler(params)
  E.LOG.debug(TAG, "pay_fail_handler >>")
  CSTAT.pay_end(false, params)
end

local function login_end_handler(succ, ...)
  E.LOG.debug(TAG, "login_end_handler >>")
  if succ then
    CSTAT.vendor_login_end(true, ...)
  else
    local result = (...)
    local code = -1
    local msg
    if result then
      code = result.code
      msg = result.msg
    end
    CSTAT.vendor_login_end(false, code, msg or "")
  end
  local run_mode = CSTAT.get_mobile_run_mode()
  if run_mode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    UNI.cast(VENDOR_NAME, CAST_LOGIN_EVENT, {
      [LUA_KEY_LOGIN_EVENT] = LOGIN_EVENT.LOGIN_END,
      [LUA_KEY_LOGIN_RESULT] = succ
    })
  end
end

local function acquire_succ_handler()
  E.LOG.debug(TAG, "acquire_succ_handler >>")
  local stat_params = {}
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  stat_params.is_guest = EG.is_magic_guest()
  CSTAT.vendor_acquire_end(true, stat_params)
  local run_mode = CSTAT.get_mobile_run_mode()
  if run_mode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    UNI.cast(VENDOR_NAME, CAST_LOGIN_EVENT, {
      [LUA_KEY_LOGIN_EVENT] = LOGIN_EVENT.ACQUIRE_END,
      [LUA_KEY_LOGIN_RESULT] = true
    })
  end
end

local function register_succ_handler(_user_info)
  E.LOG.debug(TAG, "register_succ_handler >>")
  CSTAT.vendor_register_end()
end

local function acquire_fail_handler(fail_info)
  local _fail_info = fail_info or {}
  local code = _fail_info.code
  local msg = _fail_info.msg
  E.LOG.debug(TAG, "acquire_fail_handler, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
  CSTAT.vendor_acquire_end(false, code, msg)
  local run_mode = CSTAT.get_mobile_run_mode()
  if run_mode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    UNI.cast(VENDOR_NAME, CAST_LOGIN_EVENT, {
      [LUA_KEY_LOGIN_EVENT] = LOGIN_EVENT.ACQUIRE_END,
      [LUA_KEY_LOGIN_RESULT] = false
    })
  end
end

local function network_state_change_listener(state)
  E.LOG.debug(TAG, "receive network state change >> " .. tostring(state))
end

local function init_end_handler(succ, ...)
  E.LOG.debug(TAG, "init_end_handler >>")
  CSTAT.cloudgame_init_end(succ, ...)
  if not succ then
    E.LOG.warn(TAG, "init_end_handler failed, handle_failed_in_start_cloud")
    DOWNLOAD_RULES.handle_failed_in_start_cloud()
  end
end

local log_speed_last_time = 0

local function cloud_download_state_change_listener(download_state_info)
  local state_info = download_state_info or {}
  local speed_value = state_info.speed or 0
  local speed_bit = speed_value * 8
  UNI.cast(VENDOR_NAME, CAST_DOWNLOAD_SPEED_CHANGED, {
    [LUA_KEY_SPEED_VALUE] = speed_bit
  })
  local cur_time = os.time()
  if cur_time - log_speed_last_time > 5 then
    log_speed_last_time = cur_time
    E.LOG.debug(TAG, "[download] current speed:" .. tostring(speed_value))
  end
end

local function cloud_limit_state_changed(state)
  E.LOG.debug(TAG, "cloud_limit_state_changed:" .. tostring(state))
  M.set_cloud_info(INFO_KEY.INFO_KEY_DOWNLOAD_SPEED_CONTROL, state)
end

local function gangplank_inited_handler()
  E.LOG.debug(TAG, "recev gangplank initted")
end

local function check_has_option(target_option)
  local meta_config = cloud_config.get_cloud_meta_config()
  local debuggable = meta_config[cloud_config.CONFIG_KEYS.CLOUD_DEBUGGABLE] or false
  if debuggable then
    local debug_options = meta_config[cloud_config.CONFIG_KEYS.DEBUG_OPTIONS] or {}
    E.LOG.debug(TAG, "debug options >>")
    E.LOG.debug(TAG, debug_options)
    if debug_options and next(debug_options) ~= nil then
      for _, opt in ipairs(debug_options) do
        if opt == target_option then
          E.LOG.debug(TAG, "check_has_option true, target_option:" .. tostring(target_option))
          return true
        end
      end
    end
  end
  return false
end

local function predisable_methods()
  local debug_run_cloud_single_option = check_has_option(cloud_config.DEBUG_OPTIONS_VALUE.RUN_CLOUD_SINGLE)
  if debug_run_cloud_single_option then
    E.LOG.debug(TAG, "debuggable and TestRunCloudSingle enabled, return")
    return
  end
  E.LOG.debug(TAG, "predisable_methods begin, disable acquire_token")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  
  function EG.acquire_token(...)
    E.LOG.debug(TAG, "登录服务暂停")
  end
end

local function get_sdk_version(sdk_infos, sdk_name)
  local version = ""
  for _, sdk in pairs(sdk_infos) do
    if sdk.name and sdk.name == sdk_name then
      version = sdk.version
    end
  end
  return version
end

local function init_params_to_crash(cloud_mode)
  local sdk_info = UNI.get_sdk_infos()
  local cloud_game_version = get_sdk_version(sdk_info, "alicloudgame")
  local cloud_game_sdk_version = get_sdk_version(sdk_info, "cloudgamesdk")
  local lua_version = VERSION.LUA_VERSION
  E.LOG.debug(TAG, "cloud_game_version >> " .. tostring(cloud_game_version) .. ", cloud_game_sdk_version >> " .. tostring(cloud_game_sdk_version))
  local crashsdk = require("ejoysdk_lua.vendors.crashsdk")
  crashsdk.add_header_info("wk_cloud_game_version", cloud_game_version)
  crashsdk.add_header_info("wk_cloud_game_sdk_version", cloud_game_sdk_version)
  crashsdk.add_header_info("wk_cloud_mode", cloud_mode)
  crashsdk.add_header_info("wk_lua_version", lua_version)
end

function M.set_mobile_run_mode(_mobile_run_mode)
  E.LOG.debug(TAG, "set_mobile_run_mode to crashsdk:" .. tostring(_mobile_run_mode))
  if not _mobile_run_mode then
    return
  end
  local crashsdk = require("ejoysdk_lua.vendors.crashsdk")
  crashsdk.add_header_info("wk_cloud_run_mode", _mobile_run_mode)
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "yunyou stat start init!")
  CSTAT.cloudgame_init_begin()
  ET.subscribe(ET.gangplank.PAY_INVOKE, pay_begin_handler)
  ET.subscribe(ET.analytics.CREATE_ORDER, create_order_handler)
  ET.subscribe(ET.gangplank.PAY, pay_succ_handler)
  ET.subscribe(ET.gangplank.PAY_FAILED, pay_fail_handler)
  ET.subscribe(ET.gangplank.VENDOR_LOGIN_BEGIN, login_begin_handler)
  ET.subscribe(ET.gangplank.VENDOR_LOGIN_END, login_end_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ_handler)
  ET.subscribe(ET.analytics.REGISTER, register_succ_handler)
  ET.subscribe(ET.gangplank.ACQUIRE_FAILED, acquire_fail_handler)
  ET.subscribe(ET.gangplank.INITED, init_end_handler)
  ET.subscribe(cloud_config.CLOUD_TOPIC.TOPIC_DOWNLOAD_STATE_CHANGED, cloud_download_state_change_listener)
  ET.subscribe(cloud_config.CLOUD_TOPIC.TOPIC_LIMIT_STATE_CHANGE, cloud_limit_state_changed)
  ET.subscribe(EI.SUBSCRIBE_GANGPLANK_INITED, gangplank_inited_handler)
  if _ejoysdk.os() == "ios" then
    ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, network_state_change_listener)
  end
  current_cloud_vendor = find_cloud_vendor()
  current_cloud_mode = M.get_cloud_mode()
  local CG = require("ejoysdk_lua.cloud_game.cloud_manager")
  if current_cloud_mode == M.CLOUD_MODE.MOBILE then
    local run_mode = CG.get_mobile_run_mode()
    if run_mode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
      E.LOG.debug(TAG, "skip init_mode with run_mode:" .. tostring(run_mode))
      cb(true)
    else
      E.LOG.debug(TAG, "init_mode begin with run_mode: " .. tostring(run_mode))
      CG.init_mode(opt, function(result_obj)
        local succ = false
        if type(result_obj.result) == "boolean" then
          succ = result_obj.result
        end
        local code = result_obj.code
        local msg = result_obj.msg
        E.LOG.debug(TAG, "init mode result:" .. tostring(succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if succ then
          E.LOG.debug(TAG, "its cloud start mode, now init crash params")
          init_params_to_crash(current_cloud_mode)
          cb(true)
        else
          cb(false, code, msg)
        end
      end)
    end
  elseif current_cloud_mode == M.CLOUD_MODE.CLOUD then
    local run_mode = CG.get_mobile_run_mode()
    E.LOG.debug(TAG, "in cloud side hook base method:" .. tostring(run_mode))
    predisable_methods()
    check_init_cloud(function(succ, ...)
      E.LOG.debug(TAG, "start init cloud")
      cb(succ, ...)
    end)
  end
end

function M.request_cloud_server_config(cb)
  E.LOG.debug(TAG, "request_cloud_config begin")
  local cur_vendor = find_cloud_vendor()
  cur_vendor.request_cloud_config(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "request_cloud_config succ")
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end)
end

function M.request_cloud_static_config(cb)
  E.LOG.debug(TAG, "request_cloud_static_config begin")
  local cur_vendor = find_cloud_vendor()
  cur_vendor.request_cloud_static_config(function(succ, ...)
    cb(succ, ...)
  end)
end

function M.observer_cloud_static_config_refresh(cb)
  local cur_vendor = find_cloud_vendor()
  cur_vendor.observer_cloud_static_config_refresh(cb)
end

function M.get_cloud_static_config()
  E.LOG.debug(TAG, "get_cloud_static_config begin")
  local cur_vendor = find_cloud_vendor()
  do return end
  return cur_vendor.get_cloud_static_config, "get_cloud_static_config begin"
end

function M.get_cloud_server_config()
  local server_config = M.get_server_config_data()
  return server_config
end

function M.get_current_play_config()
  local curr_play_config = current_cloud_vendor.get_current_play_config()
  E.LOG.debug(TAG, "get_current_play_config >>")
  E.LOG.debug(TAG, curr_play_config)
  return curr_play_config
end

function M.show_tips(message)
  E.LOG.debug(TAG, "show_tips message:" .. tostring(message))
  UNI.cast(VENDOR_NAME, CAST_SHOW_TIPS, {msg = message})
end

function M.hide_tips()
  E.LOG.debug(TAG, "hide_tips")
  UNI.cast(VENDOR_NAME, CAST_HIDE_TIPS, {})
end

function M.show_loading()
  E.LOG.debug(TAG, "show_loading")
  UNI.cast(VENDOR_NAME, CAST_SHOW_LOADING, {})
end

function M.hide_loading()
  E.LOG.debug(TAG, "hide_loading")
  UNI.cast(VENDOR_NAME, CAST_HIDE_LOADING, {})
end

function M.set_relink()
  current_cloud_vendor.set_relink()
end

function M.show_input_method(cb, params)
  local function err_cb(code, msg)
    cb(false, code, msg)
  end
  
  local function ok_cb(input_text_str)
    cb(true, input_text_str)
  end
  
  local _params = params or {}
  if current_cloud_mode == M.CLOUD_MODE.CLOUD then
    E.LOG.debug(TAG, "show_input_method begin >>")
    local input_rpc = require("ejoysdk_lua.cloud_game.cloud_input_rpc")
    input_rpc.request_input(err_cb, ok_cb, _params)
  else
    E.LOG.debug(TAG, "show_input_method received, call native show input dialog >>")
    E.LOG.debug(TAG, _params)
    UNI.async_call(VENDOR_NAME, ASYNC_SHOW_INPUT_DIALOG, _params, nil, function(succ, ...)
      E.LOG.debug(TAG, "ASYNC_SHOW_INPUT_DIALOG input result")
      if succ then
        local body = (...)
        local text_content = body[LUA_KEY_INPUT_CONTENT]
        E.LOG.debug(TAG, "show_input_method result:" .. tostring(text_content))
        cb(true, text_content)
      else
        local code, body = ...
        local msg = body.error_msg or ""
        E.LOG.warn(TAG, "show_input_method failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if code == INNER_ERR_CODE.INPUT_CANCELLED then
          code = EC.CLOUD_GAME_ERROR_CODES.INPUT_CANCELLED
        end
        cb(false, code, msg)
      end
    end)
  end
end

function M.clip_plain_text(label, text, cb)
  if not text then
    E.LOG.warn(TAG, "clip_plain_text skip, no text data")
    if cb then
      cb(false, EC.CLOUD_GAME_ERROR_CODES.TEXT_LENGHT_EMPTY, "text length is empty")
    end
    return
  end
  if type(text) ~= "string" then
    E.LOG.warn(TAG, "clip_plain_text skip, text type is not string:" .. tostring(type(text)))
    if cb then
      cb(false, EC.CLOUD_GAME_ERROR_CODES.TEXT_TYPE_INVALID, "text type is not string:" .. tostring(type(text)))
    end
    return
  end
  if #text > MAX_CLIP_TEXT_LEN then
    E.LOG.warn(TAG, "clip_plain_text failed, for text length is big than 4k")
    if cb then
      cb(false, EC.CLOUD_GAME_ERROR_CODES.TEXT_LENGHT_BIGGER_THAN_4K, "text content length bigger than 4k")
    end
    return
  end
  label = label or ""
  E.LOG.debug(TAG, "clip_plain_text, current_cloud_mode:" .. tostring(current_cloud_mode))
  if current_cloud_mode == M.CLOUD_MODE.CLOUD then
    E.LOG.debug(TAG, "clip_plain_text begin >>")
    local CM = require("ejoysdk_lua.cloud_game.cloud_manager")
    CM.invoke_remote(nil, "cloud_game.cloud_game_facade", "clip_plain_text", {label, text})
    if cb then
      cb(true)
    end
  else
    E.LOG.debug(TAG, "clip_plain_text received, call native clip_plain_text >>")
    E.LOG.debug(TAG, tostring(text))
    local _params = {label = label, text = text}
    UNI.async_call(VENDOR_NAME, ASYNC_CLIP_PLAIN_TEXT, _params, nil, function(succ, ...)
      E.LOG.debug(TAG, "ASYNC_CLIP_PLAIN_TEXT input result")
      if succ then
        E.LOG.debug(TAG, "clip_plain_text result succ")
        if cb then
          cb(true)
        end
      else
        local code, body = ...
        local msg = body.error_msg or ""
        E.LOG.warn(TAG, "show_input_method failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if cb then
          cb(false, code, msg)
        end
      end
    end)
  end
end

function M.get_cloud_env()
  local cur_vendor = find_cloud_vendor()
  local cloud_env = cur_vendor.get_cloud_env()
  return cloud_env
end

function M.get_min_download_speed()
  local cur_vendor = find_cloud_vendor()
  local min_speed = cur_vendor.get_min_download_speed()
  return min_speed
end

function M.check_game_file_valid(params, cb)
  UNI.async_call(VENDOR_NAME, ASYNC_BATCH_CHECK_FILE_VALID, params, nil, function(_succ, ...)
    E.LOG.debug(TAG, "check_game_file_exists succ")
    local file_map_result = (...)
    cb(file_map_result)
  end)
end

function M.refresh_app_download_state(download_state)
  local params = {download_state = download_state}
  UNI.async_call(VENDOR_NAME, ASYNC_CHANGE_APP_DOWNLOAD_STATE, params, nil)
end

function M.resume_game()
  UNI.sync_call(VENDOR_NAME, SYNC_RESUME_GAME, {}, nil)
end

function M.set_cloud_game_visibility_change_listener(listener)
  cloud_game_visibility_change_listener = listener
end

function M.set_get_current_download_speed_listener(listener)
  get_current_download_speed_listener = listener
end

function M.init_floater_config(config)
  UNI.sync_call(VENDOR_NAME, SYNC_INIT_FLOATER_CONFIG, config, nil)
end

function M.show_floater(config)
  UNI.sync_call(VENDOR_NAME, SYNC_SHOW_FLOATER, config, nil)
end

function M.hide_floater()
  UNI.sync_call(VENDOR_NAME, SYNC_HIDE_FLOATER, {}, nil)
end

function M.show_floater_tips(message, color)
  local params = {floater_tips_message = message, floater_tips_color = color}
  UNI.sync_call(VENDOR_NAME, SYNC_SHOW_FLOATER_TIPS, params, nil)
end

function M.hide_floater_tips()
  UNI.sync_call(VENDOR_NAME, SYNC_HIDE_FLOATER_TIPS, {}, nil)
end

function M.change_native_network_quality_visible(is_show)
  local params = {visible = is_show}
  UNI.sync_call(VENDOR_NAME, SYNC_NETWORK_QUALITY_VISIBLE, params, nil)
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local M = {}
local TAG = "cloud_time_limit_manager"
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.SERVICE = {
  CLOUD_MSG_CHECK = "cloud.msg.check"
}
M.DSP_SERVICE_MAPPING = {
  [M.SERVICE.CLOUD_MSG_CHECK] = DSP.SERVICE.CLOUD_MSG_CHECK
}
M.POLL_SCENE = {SCENE_NORMAL = 0, SCENE_KICK = 1}
M.POLL_STATUS = {STATUS_STOP = 0, STATUS_POLLING = 1}
M.CLOUD_ERROR_CODE = {TIME_OUT = "5003001"}
M.POLL_MSG_ID = {
  MSG_TIPS_2 = "901000",
  MSG_TIPS = "901001",
  MSG_H5 = "901002",
  MSG_FORBID_EXPERIENCE_TIME_END = "901003",
  MSG_FORBID_TOTAL_TIME_END = "901004"
}
M.TIME_LIMIT_STAGE = {
  UNKNOWN = "unkonwn",
  IN_EXPERIENCE_TIME = "in_experience_time",
  EXPERIENCE_TIME_END = "experience_time_end",
  PLAY_TOTAL_TIME_COMING = "play_total_time_coming",
  PLAY_TOTAL_TIME_COMING_2 = "play_total_time_coming_2",
  PLAY_TOTAL_TIME_END = "play_total_time_end"
}
local TIME_LIMIT_ORDER = {
  [M.TIME_LIMIT_STAGE.UNKNOWN] = 0,
  [M.TIME_LIMIT_STAGE.IN_EXPERIENCE_TIME] = 1,
  [M.TIME_LIMIT_STAGE.EXPERIENCE_TIME_END] = 2,
  [M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING] = 3,
  [M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING_2] = 4,
  [M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END] = 5
}
M.STATE_INFO_KEY = {
  KEY_STAGE = "stage",
  KEY_PLAY_TIME_SEC = "play_time_sec",
  KEY_EXPERIENCE_TIME_LIMIT_SEC = "experience_time_limit_sec",
  KEY_TOTAL_TIME_LIMIT_SEC = "total_time_limit_sec",
  KEY_DOWNLOAD_COMPLETE_EXPERIENCE_LIMIT_SEC = "download_complete_experience_limit_sec",
  KEY_REFRESH_TIME_STAMP = "refresh_time_stamp",
  KEY_NEXT_INTERVAL = "next_interval"
}
local TIME_2_MIN_IN_SEC = 120
local _TEST_TIME_SEC = 5
M.DEFAULT_EXPERIENCE_TIME_LIMIT_SEC = 3600
M.DEFAULT_TOTAL_TIME_LIMIT_SEC = 36000
M.DEFAULT_DOWNLOAD_COMPLETE_EXPERIENCE_LIMIT_SEC = 1800
local env = M.ENV.DEBUG
local current_play_sec = -1
local poll_status = M.POLL_STATUS.STATUS_STOP
local is_polling = false
local current_poll_scene = M.POLL_SCENE.SCENE_NORMAL
local heartbeat_interval_sec = TIME_2_MIN_IN_SEC
local current_state_info = {
  stage = M.TIME_LIMIT_STAGE.UNKNOWN
}
local state_change_listeners = {}
local connect_state_instance
local _test_monitor_coming_count = 2
local _test_monitor_coming2_count = 4
local _test_monitor_end_count = 6
local _test_monitor_poll_count = 0

local function update_stage_changed(stage)
  local previous_stage = current_state_info[M.STATE_INFO_KEY.KEY_STAGE]
  local previous_stage_order = -1
  local target_stage_order = -1
  if previous_stage then
    previous_stage_order = TIME_LIMIT_ORDER[previous_stage]
  end
  if stage then
    target_stage_order = TIME_LIMIT_ORDER[stage]
  end
  E.LOG.debug(TAG, "update_stage_changed before check, previous:" .. tostring(previous_stage) .. ", now:" .. tostring(stage) .. ", pre_order:" .. tostring(previous_stage_order) .. ", target_stage_order:" .. target_stage_order)
  if stage and previous_stage ~= stage and -1 ~= target_stage_order and previous_stage_order < target_stage_order then
    E.LOG.debug(TAG, "update_stage_changed, previous:" .. tostring(previous_stage) .. ", now:" .. tostring(stage))
    current_state_info[M.STATE_INFO_KEY.KEY_STAGE] = stage
    for _, callback in ipairs(state_change_listeners) do
      callback(current_state_info)
    end
  end
end

local function double_check_time_limit(timeCtl)
  if not timeCtl then
    return
  end
  local experience_time_limit_sec = timeCtl.limitTimeSec or M.DEFAULT_EXPERIENCE_TIME_LIMIT_SEC
  local total_time_limit_sec = timeCtl.maxLimitTimeSec or M.DEFAULT_TOTAL_TIME_LIMIT_SEC
  local target_stage
  local current_stage = current_state_info[M.STATE_INFO_KEY.KEY_STAGE]
  if experience_time_limit_sec > current_play_sec then
    if current_stage ~= M.TIME_LIMIT_STAGE.IN_EXPERIENCE_TIME then
      target_stage = M.TIME_LIMIT_STAGE.IN_EXPERIENCE_TIME
    end
  elseif experience_time_limit_sec <= current_play_sec and total_time_limit_sec > current_play_sec then
    if current_stage ~= M.TIME_LIMIT_STAGE.EXPERIENCE_TIME_END and current_stage ~= M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING and current_stage ~= M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING_2 then
      target_stage = M.TIME_LIMIT_STAGE.EXPERIENCE_TIME_END
    end
  elseif total_time_limit_sec <= current_play_sec and current_stage ~= M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END then
    target_stage = M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END
  end
  if nil ~= target_stage then
    E.LOG.debug(TAG, "update_time_limit_info and find stage changed, current:" .. tostring(current_stage) .. ", target_stage:" .. tostring(target_stage))
    update_stage_changed(target_stage)
  end
end

local function update_time_limit_info(timeCtl, next_interval)
  if not timeCtl then
    return
  end
  current_play_sec = timeCtl.playTimeSec or 0
  local experience_time_limit_sec = timeCtl.limitTimeSec or M.DEFAULT_EXPERIENCE_TIME_LIMIT_SEC
  local total_time_limit_sec = timeCtl.maxLimitTimeSec or M.DEFAULT_TOTAL_TIME_LIMIT_SEC
  current_state_info[M.STATE_INFO_KEY.KEY_PLAY_TIME_SEC] = current_play_sec
  current_state_info[M.STATE_INFO_KEY.KEY_EXPERIENCE_TIME_LIMIT_SEC] = experience_time_limit_sec
  current_state_info[M.STATE_INFO_KEY.KEY_TOTAL_TIME_LIMIT_SEC] = total_time_limit_sec
  current_state_info[M.STATE_INFO_KEY.KEY_DOWNLOAD_COMPLETE_EXPERIENCE_LIMIT_SEC] = M.DEFAULT_DOWNLOAD_COMPLETE_EXPERIENCE_LIMIT_SEC
  current_state_info[M.STATE_INFO_KEY.KEY_REFRESH_TIME_STAMP] = os.time()
  current_state_info[M.STATE_INFO_KEY.KEY_NEXT_INTERVAL] = next_interval
end

local function on_handle_time_ctrl_info(timeCtl, next_interval, _msg)
  update_time_limit_info(timeCtl, next_interval)
  local msg = _msg
  if CC.DEBUG_OPTIONS.TestTimeLimitComing then
    E.LOG.warn(TAG, "TestTimeLimitComing enabled")
    next_interval = _TEST_TIME_SEC
    msg = {}
    if _test_monitor_poll_count == _test_monitor_coming_count then
      msg.templateId = M.POLL_MSG_ID.MSG_TIPS
    elseif _test_monitor_poll_count == _test_monitor_coming2_count then
      msg.templateId = M.POLL_MSG_ID.MSG_TIPS_2
    elseif _test_monitor_poll_count == _test_monitor_end_count then
      msg.templateId = M.POLL_MSG_ID.MSG_FORBID_TOTAL_TIME_END
    end
    _test_monitor_poll_count = _test_monitor_poll_count + 1
  end
  if next_interval > 0 then
    heartbeat_interval_sec = next_interval
    E.LOG.debug(TAG, "update heartbeat interval:" .. tostring(heartbeat_interval_sec))
  end
  if msg then
    local templateId = msg.templateId
    E.LOG.debug(TAG, "request_play_time_limit_from_server, templateId:" .. tostring(templateId))
    if templateId == M.POLL_MSG_ID.MSG_TIPS or templateId == M.POLL_MSG_ID.MSG_TIPS_2 or templateId == M.POLL_MSG_ID.MSG_H5 then
      if templateId == M.POLL_MSG_ID.MSG_TIPS then
        update_stage_changed(M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING)
      elseif templateId == M.POLL_MSG_ID.MSG_TIPS_2 then
        update_stage_changed(M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING_2)
      end
    elseif templateId == M.POLL_MSG_ID.MSG_FORBID_EXPERIENCE_TIME_END then
      update_stage_changed(M.TIME_LIMIT_STAGE.EXPERIENCE_TIME_END)
    elseif templateId == M.POLL_MSG_ID.MSG_FORBID_TOTAL_TIME_END then
      E.LOG.debug(TAG, "poll out !")
      current_poll_scene = M.POLL_SCENE.SCENE_KICK
      update_stage_changed(M.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END)
    end
  else
    E.LOG.debug(TAG, "msg is nil, do nothing,")
  end
  double_check_time_limit(timeCtl)
end

local function request_play_time_limit_from_server(msg_token, cb)
  local cur_connect_state = connect_state_instance.current_connect_state()
  if current_play_sec >= 0 and "connected" == cur_connect_state then
    current_play_sec = current_play_sec + heartbeat_interval_sec
  elseif current_play_sec < 0 then
    current_play_sec = 0
  end
  local service = M.SERVICE.CLOUD_MSG_CHECK
  local dsp_service = M.DSP_SERVICE_MAPPING[service]
  local params = {msgToken = msg_token, playSeconds = current_play_sec}
  E.LOG.debug(TAG, "cloud heartbeat play_time:" .. tostring(current_play_sec) .. ", interval:" .. tostring(heartbeat_interval_sec) .. ", cur_connect_state:" .. tostring(cur_connect_state))
  E.log(params)
  DSP.post(dsp_service, params, function(succ, ...)
    if poll_status == M.POLL_STATUS.STATUS_STOP then
      E.LOG.debug(TAG, "poll state is stop")
      return
    end
    if current_poll_scene == M.POLL_SCENE.SCENE_NORMAL then
      if succ then
        local resp = (...)
        on_handle_time_ctrl_info(resp.timeCtl, resp.nextInterval, resp.msg)
      else
        local code, message = ...
        E.LOG.error(TAG, "get remain time error >> code:" .. code .. ", msg: " .. message)
      end
    end
    E.LOG.debug(TAG, "time once next:" .. tostring(heartbeat_interval_sec))
    cb(succ, ...)
  end)
end

local function get_msg_token()
  local server_config_data = CA.get_cloud_server_config()
  local msgToken = server_config_data.msgToken
  E.LOG.debug(TAG, "get token msg token >> " .. tostring(msgToken) .. "， env:" .. tostring(env))
  return msgToken
end

function M.start_poll_time()
  local msg_token = get_msg_token()
  E.LOG.debug(TAG, "start_poll_time remain time interval is " .. heartbeat_interval_sec .. ", msgToken:" .. tostring(msg_token))
  local getLastTryTime
  
  function getLastTryTime()
    if poll_status == M.POLL_STATUS.STATUS_STOP then
      is_polling = false
      return
    end
    E.LOG.debug(TAG, "start_poll_time, schedule next")
    request_play_time_limit_from_server(msg_token, function(succ, ...)
      E.LOG.debug(TAG, "start_poll_time, result:" .. tostring(succ))
      if poll_status == M.POLL_STATUS.STATUS_POLLING and current_poll_scene == M.POLL_SCENE.SCENE_NORMAL then
        E.Timer.once(heartbeat_interval_sec, getLastTryTime)
      end
    end)
  end
  
  poll_status = M.POLL_STATUS.STATUS_POLLING
  if not is_polling then
    is_polling = true
    getLastTryTime(M.POLL_SCENE.SCENE_NORMAL)
  else
    E.LOG.debug(TAG, "is polling, return")
  end
end

function M.stop_poll_time()
  E.LOG.warn(TAG, "stop_poll_time begin")
  poll_status = M.POLL_STATUS.STATUS_STOP
end

function M.request_time_config(cb)
  E.LOG.debug(TAG, "request_time_config begin2")
  local msg_token = get_msg_token()
  request_play_time_limit_from_server(msg_token, cb)
end

function M.on_change_from_cloud_config()
  E.LOG.debug(TAG, "on_change_from_cloud_config")
  local server_config_data = CA.get_server_config_data()
  local play_time_info = server_config_data.playTimeInfo
  if not play_time_info or not play_time_info.timeCtl then
    E.LOG.warn(TAG, "on_change_from_cloud_config skip, no play_time_info in resp")
    return
  end
  E.LOG.debug(TAG, "on_change_from_cloud_config begin update time ctrl info")
  local next_interval = play_time_info.nextInterval or heartbeat_interval_sec
  on_handle_time_ctrl_info(play_time_info.timeCtl, next_interval)
end

function M.init()
  connect_state_instance = require("ejoysdk_lua.cloud_game.cloud_connect_statemachine")
  env = CA.get_cloud_env()
  DSP.set_env(DSP.ENV.RELEASE)
  if env == M.ENV.DEBUG then
    DSP.set_env(DSP.ENV.DEBUG)
  elseif env == M.ENV.PRE_RELEASE then
    DSP.set_env(DSP.ENV.PRE_RELEASE)
  end
end

function M.register_time_limit_state_changed(_state_change_listener)
  for _, handler in ipairs(state_change_listeners) do
    if handler == _state_change_listener then
      return
    end
  end
  state_change_listeners[#state_change_listeners + 1] = _state_change_listener
end

function M.current_state_info()
  return current_state_info
end

return M

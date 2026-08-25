local STAT = require("ejoysdk_lua.ejoysdk_stat")
local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local quality_log = require("ejoysdk_lua.ejoysdk_qualitylog")
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_stat"
local M = {}
local LAST_RUN_MODE = E.LazyKeyStore:New("CLOUD_LAST_RUN_MODE", false, false, false)
local init_begin_time = 0
local connect_begin_time = 0
M.MOBILE_RUN_MODE = {
  MODE_RUN_CONNECT_REMOTE = "run_connect_remote",
  MODE_RUN_WITH_LOCAL_RES = "run_with_local_resource",
  MODE_RUN_IN_CLOUD_SIDE = "run_in_cloud_side",
  MODE_NORMAL_GAME = "run_in_normal_mode"
}
M.STAT_TYPE = {TYPE_ERROR = "error", TYPE_INFO = "info"}
local action_stat_time = {}
local mobile_run_mode = M.MOBILE_RUN_MODE.MODE_NORMAL_GAME
local has_check_last_mobile_run_mode = false

function M.mini_start_begin()
  local run_mode = M.get_mobile_run_mode()
  E.LOG.debug(TAG, "start_begin, run_mode:" .. tostring(run_mode))
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    M.stat_action("mini_client_startup", nil, true)
    E.LOG.debug(TAG, "mini_start_begin MODE_RUN_CONNECT_REMOTE")
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    M.stat_action("mini_client_download_source_startup", nil, true)
    STAT.flush_cached_events()
    E.LOG.debug(TAG, "mini_start_begin MODE_RUN_WITH_LOCAL_RES")
  end
end

function M.cloudgame_init_begin()
  local run_mode = M.get_mobile_run_mode()
  E.LOG.debug(TAG, "init_begin, run_mode:" .. tostring(run_mode))
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    E.LOG.debug(TAG, "stat mini_client_download_source_history_init")
    M.stat_action("mini_client_download_source_history_init", nil, true, nil)
  end
end

function M.init_begin()
  init_begin_time = os.time()
  local run_mode = M.get_mobile_run_mode()
  E.LOG.debug(TAG, "init_begin, run_mode:" .. tostring(run_mode))
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    M.stat_action("cloud_tech_init_begin", "run_with_local_res")
  else
    M.stat_action("cloud_tech_init_begin", "run_conn_remote")
  end
end

function M.stat_splash_show()
  local cost_time = os.time() - init_begin_time
  local net_type = E.Sysinfo.network_type_name()
  M.stat_action("cloud_tech_splash_show", net_type, cost_time)
end

function M.stat_connect_end(succ, code, msg)
  local curr_time = os.time()
  local cost_time = 0
  if init_begin_time > 0 then
    cost_time = curr_time - init_begin_time
  end
  local connect_cost_time = 0
  if connect_begin_time > 0 then
    connect_cost_time = curr_time - connect_begin_time
  end
  local params = {duration = connect_cost_time}
  local net_type = E.Sysinfo.network_type_name()
  if succ then
    M.stat_action("cloud_tech_connect_succ", net_type, cost_time, params)
  else
    M.stat_action_fail("cloud_tech_connect_failed", net_type, code, msg)
  end
end

function M.stat_init_start_local_game()
  local curr_time = os.time()
  local cost_time = 0
  if init_begin_time > 0 then
    cost_time = curr_time - init_begin_time
  end
  M.stat_action("cloud_tech_run_local", cost_time)
end

function M.stat_connect_begin()
  connect_begin_time = os.time()
  local net_type = E.Sysinfo.network_type_name()
  M.stat_action("cloud_tech_connect_begin", net_type)
end

function M.cloudgame_init_end(succ, ...)
  local run_mode = M.get_mobile_run_mode()
  E.LOG.debug(TAG, "init_end, run_mode:" .. tostring(run_mode))
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    if succ then
      M.stat_action("mini_client_download_source_history_init_complete", nil, true, nil)
    else
      local msg = (...)
      M.stat_action_fail("mini_client_download_source_history_init_complete", nil, -1, msg)
    end
    E.LOG.debug(TAG, "stat mini_client_download_source_history_init_complete, " .. tostring(succ))
  end
end

function M.vendor_login_begin(_vendor_name)
  E.LOG.debug(TAG, "vendor_login_begin, _vendor_name:" .. tostring(_vendor_name))
  local run_mode = M.get_mobile_run_mode()
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    E.LOG.debug(TAG, "stat mini_client_lingxi_login_page")
    M.stat_action("mini_client_lingxi_login_page", _vendor_name)
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    E.LOG.debug(TAG, "stat mini_client_download_source_history_lingxi_login_page")
    M.stat_action("mini_client_download_source_history_lingxi_login_page", _vendor_name)
  end
end

function M.pay_begin()
  E.LOG.debug(TAG, "pay_begin")
  local run_mode = M.get_mobile_run_mode()
  local stat_action
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    E.LOG.debug(TAG, "stat mini_client_receive_pay")
    stat_action = "mini_client_receive_pay"
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    E.LOG.debug(TAG, "stat mini_client_download_source_history_pay")
    stat_action = "mini_client_download_source_history_pay"
  end
  if not stat_action then
    E.LOG.warn(TAG, "pay_begin not action in mode, skip")
    return
  end
  M.stat_action(stat_action, nil, true)
end

function M.create_order_finish()
  E.LOG.debug(TAG, "pay_begin")
  local run_mode = M.get_mobile_run_mode()
  local stat_action
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    E.LOG.debug(TAG, "stat cloud_request_mini_client_pay_page")
    stat_action = "cloud_request_mini_client_pay_page"
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    E.LOG.debug(TAG, "stat mini_client_download_source_history_pay_page")
    stat_action = "mini_client_download_source_history_pay_page"
  end
  if not stat_action then
    E.LOG.warn(TAG, "pay_begin not action in mode, skip")
    return
  end
  M.stat_action(stat_action, nil, true)
end

function M.pay_end(result, params)
  E.LOG.debug(TAG, "pay_end, result:" .. tostring(result))
  local run_mode = M.get_mobile_run_mode()
  local pay_result_params = params or {}
  local stat_params = {is_priority_high = true}
  local stat_action
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    if true == result then
      E.LOG.debug(TAG, "stat cloud_request_mini_client_pay_success")
      stat_action = "cloud_request_mini_client_pay_success"
    else
      E.LOG.warn(TAG, "stat cloud_request_mini_client_pay_failed")
      stat_action = "cloud_request_mini_client_pay_failed"
      stat_params.code = pay_result_params.code
      stat_params.msg = pay_result_params.msg
    end
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    if true == result then
      E.LOG.debug(TAG, "stat mini_client_download_source_history_pay_success")
      stat_action = "mini_client_download_source_history_pay_success"
    else
      E.LOG.debug(TAG, "stat mini_client_download_source_history_pay_failed")
      stat_action = "mini_client_download_source_history_pay_failed"
      stat_params.code = pay_result_params.code
      stat_params.msg = pay_result_params.msg
    end
  end
  if not stat_action then
    E.LOG.warn(TAG, "pay_begin not action in mode, skip")
    return
  end
  M.stat_action(stat_action, nil, result, stat_params)
end

function M.vendor_login_end(succ, ...)
  E.LOG.debug(TAG, "vendor_login_end")
  local run_mode = M.get_mobile_run_mode()
  local outsource = (...)
  outsource = outsource or {}
  local EV = require("ejoysdk_lua.ejoysdk_vendors")
  local vendor_name = EV.get_vendor_name(outsource)
  E.LOG.debug(TAG, "vendor_login_end vendor_name:" .. tostring(vendor_name))
  local stat_action
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    E.LOG.debug(TAG, "stat mini_client_lingxi_login_complete")
    stat_action = "mini_client_lingxi_login_complete"
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    E.LOG.debug(TAG, "stat mini_client_download_source_history_login_complete")
    stat_action = "mini_client_download_source_history_login_complete"
  end
  if not stat_action then
    E.LOG.warn(TAG, "vendor_login_end not action in mode, skip")
    return
  end
  E.LOG.debug(TAG, "vendor_login_end stat, action:" .. tostring(stat_action) .. ", result:" .. tostring(succ))
  if succ then
    M.stat_action(stat_action, vendor_name, true, nil)
  else
    local code, msg = ...
    M.stat_action_fail(stat_action, vendor_name, code, msg)
  end
end

function M.vendor_acquire_end(succ, ...)
  E.LOG.debug(TAG, "vendor_acquire_end")
  local run_mode = M.get_mobile_run_mode()
  local stat_action
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    E.LOG.debug(TAG, "stat mini_client_lingxi_acquire_complete")
    stat_action = "mini_client_lingxi_acquire_complete"
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    E.LOG.debug(TAG, "stat mini_client_download_source_history_acquire_complete")
    stat_action = "mini_client_download_source_history_acquire_complete"
  end
  if not stat_action then
    E.LOG.warn(TAG, "vendor_acquire_end not action in mode, skip")
    return
  end
  E.LOG.debug(TAG, "vendor_acquire_end stat, action:" .. tostring(stat_action) .. ", result:" .. tostring(succ))
  if succ then
    local stat_params = (...)
    M.stat_action(stat_action, nil, true, stat_params)
  else
    local code, msg = ...
    M.stat_action_fail(stat_action, nil, code, msg)
  end
end

function M.vendor_register_end()
  E.LOG.debug(TAG, "vendor_register_end")
  local run_mode = M.get_mobile_run_mode()
  local stat_action
  if run_mode == M.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE then
    E.LOG.debug(TAG, "stat mini_client_lingxi_register_complete")
    stat_action = "mini_client_lingxi_register_complete"
  elseif run_mode == M.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES then
    E.LOG.debug(TAG, "stat mini_client_download_source_history_register_complete")
    stat_action = "mini_client_download_source_history_register_complete"
  end
  if not stat_action then
    E.LOG.warn(TAG, "vendor_register_end not action in mode, skip")
    return
  end
  E.LOG.debug(TAG, "vendor_register_end stat, action:" .. tostring(stat_action))
  M.stat_action(stat_action, nil, true)
end

function M.set_mobile_run_mode(mode)
  E.LOG.debug(TAG, "set_mobile_run_mode: " .. tostring(mode))
  mobile_run_mode = mode
  LAST_RUN_MODE:set(mobile_run_mode)
end

function M.get_mobile_run_mode()
  if not has_check_last_mobile_run_mode then
    mobile_run_mode = LAST_RUN_MODE:get()
    has_check_last_mobile_run_mode = true
  end
  return mobile_run_mode
end

local function stat_windows_file(type, message)
  E.LOG.debug(TAG, "stat_inner its windows side, save to local")
  local time = os.date("%Y-%m-%dT%H:%M:%S")
  local cg_port = E.CONFIG.get_config("cloudgame_cg_port")
  local game_session = E.CONFIG.get_config("cloudgame_cg_game_session") or ""
  local trace_id = STAT.get_trace_id()
  local format_err_msg = time .. ",port:" .. tostring(cg_port) .. ",session:" .. tostring(game_session) .. ", tid:" .. tostring(trace_id) .. ":" .. tostring(message) .. ")\n"
  local file_time_suffix = os.date("%Y%m%dT%H")
  local file_name_prefix = "cloud_channel_err_"
  if type ~= M.STAT_TYPE.TYPE_ERROR then
    file_name_prefix = "cloud_channel_info_"
  end
  local filename_with_time = file_name_prefix .. file_time_suffix .. ".log"
  local succ, error = pcall(E.File.writefile, filename_with_time, format_err_msg, true)
  if not succ then
    E.LOG.warn(TAG, "failed to write local file: " .. tostring(error) .. ", filename:" .. tostring(filename_with_time))
  else
    E.LOG.debug(TAG, "write local file, filename:" .. tostring(filename_with_time))
  end
end

function M.stat_err_msg(err_msg)
  if E.Sysinfo.os() == "windows" then
    E.LOG.debug(TAG, "stat_inner its windows side, save to local")
    stat_windows_file(M.STAT_TYPE.TYPE_ERROR, err_msg)
  else
    E.LOG.debug(TAG, "stat_inner NOT windows side, call ejoysdk_stat")
    M.stat_action_fail("cloud_side_channel_socket_err", nil, CONSTANTS.CLOUD_GAME_ERROR_CODES.SOCKET_ERROR, tostring(err_msg))
  end
end

function M.get_cloud_stat_info(params)
  local stat_params = params or {}
  stat_params.game_session = E.CONFIG.get_config("cloudgame_cg_game_session") or ""
  stat_params.trace_id = STAT.get_trace_id()
  return stat_params
end

function M.stat_event(event, params)
  local event_message = tostring(event)
  local stat_params = M.get_cloud_stat_info(params)
  local action = ""
  if params then
    action = params.action or ""
  end
  if E.Sysinfo.os() == "windows" then
    E.LOG.debug(TAG, "stat_inner its windows side, save to local")
    local ok, encode_params = pcall(JSON.encode, stat_params)
    if ok then
      event_message = event_message .. tostring(encode_params)
    end
    E.LOG.debug(TAG, "stat_inner windows side, event_message:" .. event_message)
    stat_windows_file(M.STAT_TYPE.TYPE_INFO, event_message)
  end
  E.LOG.debug(TAG, "stat_inner NOT windows side, call ejoysdk_stat")
  M.stat_action(event, action, true, stat_params)
end

function M.stat_action(action, action_type, result, params)
  local stat_params = params or {}
  stat_params.is_priority_high = true
  stat_params.is_ab_on = CC.get_ab_flag()
  STAT.stat_action(action, action_type, result, stat_params)
end

function M.stat_action_interval(action, action_type, result, params, interval)
  local last_time = action_stat_time[action]
  last_time = last_time or 0
  interval = interval or 0
  local cur_time = os.time()
  if interval < cur_time - last_time then
    M.stat_action(action, action_type, result, params)
    action_stat_time[action] = cur_time
  end
end

function M.stat_action_fail(action, action_type, ...)
  local params = {}
  local args = (...)
  local args_type = type(args)
  if "table" == args_type then
    params = args
  else
    local code, msg = ...
    params.code = code
    params.msg = msg
  end
  params.is_priority_high = true
  params.is_ab_on = CC.get_ab_flag()
  STAT.stat_action_fail(action, action_type, params)
end

function M.stat_cloud_exit(from)
  local _cloud_facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  local _csg = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  local cloud_state = _cloud_facade.get_cloud_state_info()
  local connect_state_info = cloud_state[_csg.STATE_INFO_KEY.CONNECT_STATE] or {}
  local download_biz_state_info = cloud_state[_csg.STATE_INFO_KEY.DOWNLOAD_BIZ_STATE] or {}
  local connect_state = connect_state_info[_csg.CONNECT_STATE_INFO_KEY.KEY_STATE]
  local download_state = download_biz_state_info[_csg.DOWNLOAD_STATE_INFO_KEY.KEY_STATE]
  local current_scene
  E.LOG.debug(TAG, "stat_cloud_exit, connect_state:" .. tostring(connect_state) .. ", download_state:" .. tostring(download_state))
  E.log(cloud_state)
  if download_state == _csg.DOWNLOAD_BIZ_STATES.GAME_RES_READY then
    current_scene = "download_complete"
  elseif connect_state == _csg.CONNECT_STATES.CONNECTED or connect_state == _csg.CONNECT_STATES.CONNECTING then
    current_scene = "connect_interrupt"
  else
    current_scene = connect_state
  end
  M.stat_action("mini_client_exit_cloud_game", from, current_scene)
end

function M.commit_event(event_name, params)
  quality_log.commit_event(event_name, params, true)
end

return M

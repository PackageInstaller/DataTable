local remote_logic = require("ejoysdk_lua.cloud_game.cloud_remote_logic")
local local_logic = require("ejoysdk_lua.cloud_game.cloud_local_logic")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local cloud_ui = require("ejoysdk_lua.cloud_game.cloud_ui")
local ui_text = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_text_normal")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local E = require("ejoysdk_lua.ejoysdk")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CG = require("ejoysdk_lua.vendors.cloud_game")
local ELU = require("ejoysdk_lua.lang.util")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CSM = require("ejoysdk_lua.cloud_game.cloud_state_manager")
local free_data = require("ejoysdk_lua.cloud_game.cloud_free_data_pkg")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_mgr"
M.CLOUD_MODE = {
  MODE_CLOUD = cloud_config.CLOUD_MODE.CLOUD,
  MODE_MOBILE = cloud_config.CLOUD_MODE.MOBILE,
  MODE_UNKNOWN = cloud_config.CLOUD_MODE.UNKNOWN
}
local data = {
  product = nil,
  logic = nil,
  is_cloud_remote = false,
  retry_down_cnt = 0,
  cg_error_obj_cache = nil,
  cg_visibility = false,
  is_record_splash_time = false,
  splash_time_begin = 0
}
local cloud_info = {}
local cloud_mode
local restrict_state = {}
local init_tag = false
local is_show_close_bluetooth_tips = false

local function get_native_result(succ, ...)
  local result = {}
  if succ then
    result.result = true
    result.code = 200
  else
    local code, msg, body = ...
    result.result = false
    result.code = code
    result.msg = msg
    result.body = body
  end
  return result
end

function M.set_mobile_run_mode(mode)
  local UIM = require("ejoysdk_lua.user_info_manager")
  cloud_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE] = mode
  UIM.set_cloud_game_info(cloud_info)
  CSTAT.set_mobile_run_mode(mode)
  cloud_adapter.set_mobile_run_mode(mode)
end

function M.get_mobile_run_mode()
  do return end
  return CSTAT.get_mobile_run_mode, nil
end

function M._connect_cloud_sucess()
  if not data.is_record_splash_time then
    local splash_time = os.time() - data.splash_time_begin
    local stat_params = {is_priority_high = true}
    CSTAT.stat_action("mini_client_splash_time", tostring(splash_time), true, stat_params)
    data.is_record_splash_time = true
  end
  cloud_adapter.set_retry_connected_tip("")
  cloud_adapter.set_cloud_visibility(true)
  cloud_ui.set_is_retry_connecting(false)
  cloud_ui.reset_error_ui_state()
end

function M._retry_connect_cloud(cb, last_err_code)
  if cloud_ui.get_is_retry_connecting() then
    return
  end
  CG.set_relink()
  cloud_ui.set_is_retry_connecting(true)
  cloud_ui.reconnect()
  local connect_time_begin = os.time()
  local request_time_out = 10
  local request_interval = 4
  local request_time = request_time_out - request_interval
  local retry_cnt = 0
  local finish = false
  local run_fail_code = last_err_code
  
  local function request_connect_cloud()
    if finish then
      return
    end
    E.LOG.debug(TAG, "[cloud game] start_cloud_game retry " .. tostring(retry_cnt))
    retry_cnt = retry_cnt + 1
    cloud_adapter.cloud_stat_action("server_send_relink_actual_frequency")
    cloud_adapter.run_cloud_game(function(succ2, ...)
      E.LOG.debug(TAG, "[cloud game] start_cloud_game retry result " .. tostring(succ2))
      if succ2 then
        finish = true
        cloud_adapter.cloud_stat_action("click_relink_enter_game_success")
        cb(succ2, ...)
      else
        run_fail_code = (...)
      end
    end)
  end
  
  request_connect_cloud()
  local update_time_fun
  
  function update_time_fun()
    local time_left = request_time_out - math.ceil(os.time() - connect_time_begin)
    if time_left < 1 then
      time_left = 0
    end
    E.LOG.debug(TAG, "[cloud game] -------cancel_update_time=" .. tostring(time_left))
    cloud_adapter.set_retry_connected_tip(string.format(ELU.getString(ui_text.RetryConnect.text), time_left))
    if not cloud_ui.get_is_retry_connecting() or finish or time_left <= 0 then
      if not finish then
        cb(false, run_fail_code)
        cloud_ui.check_and_show_error()
        E.LOG.debug(TAG, "[cloud game] -------超时没有连接成功")
      end
      finish = true
      cloud_ui.set_is_retry_connecting(false)
      cloud_adapter.set_retry_connected_tip("")
      return
    end
    if time_left <= request_time then
      request_time = time_left - request_interval
      request_connect_cloud()
    end
    E.Timer.once(1, function()
      update_time_fun()
    end)
  end
  
  cloud_adapter.cloud_stat_action("click_relink_page")
  update_time_fun()
end

function M._init_cloud_rpc(is_cloud, msg_logic)
  local message = msg_logic.get_msg()
  local cloud_input_rpc = require("ejoysdk_lua.cloud_game.cloud_input_rpc")
  cloud_input_rpc.init(is_cloud, message)
end

function M._run_test()
  if not cloud_config.DEBUG_OPTIONS.Debug then
    return
  end
  if cloud_config.DEBUG_OPTIONS.TestCloudTimeLimit then
    E.Timer.once(cloud_config.DEBUG_OPTIONS.TestCloudTimeLimit, function()
      cloud_ui.show_stop_cloud_game_by_server()
    end)
  end
  local check_cg_error
  
  function check_cg_error()
    E.Timer.once(3, function()
      if download_utils.is_file_exist(cloud_config.DEBUG_OPTIONS.TestCloudCGErrorFile) then
        os.remove(download_utils.download_folder .. cloud_config.DEBUG_OPTIONS.TestCloudCGErrorFile)
        M.on_cg_error(123, "test")
      end
      check_cg_error()
    end)
  end
  
  check_cg_error()
end

local function check_pending_errors()
  cloud_ui.check_and_show_error()
end

local function _show_download_splash_ui(total_size, downloading_size, cb)
  cloud_ui.set_state(cloud_ui.State.FlashScreen)
  cloud_ui.set_download_progress(downloading_size, total_size)
  cloud_ui.show_flash_screen()
  cloud_adapter.set_download_progress(total_size, downloading_size)
  
  local function splash_ui_dimiss_listener()
    E.LOG.debug(TAG, "splash dismissed, now show peding errors")
    check_pending_errors()
    cloud_ui.check_mobile_network_change()
  end
  
  E.Timer.once(1, function()
    if math.floor(downloading_size / total_size * 100) >= 1 then
      E.LOG.debug(TAG, "ui_update_flash_screen yes downloading_size = " .. tostring(downloading_size / 1024 / 1024))
      cloud_ui.set_download_progress(downloading_size, total_size)
      cloud_ui.show_flash_screen()
      cloud_adapter.set_download_progress(total_size, downloading_size)
    end
    cloud_ui.hide_flash_screen(4, function()
      cloud_ui.set_state(cloud_ui.State.FlashScreenDismiss)
      splash_ui_dimiss_listener()
      if cb then
        cb(true)
      end
    end)
  end)
end

function M.connect_with_remote_game(params, cb)
  CSM.connect_remote(params, function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "connect_with_remote_game failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end)
end

function M.stop_connect_with_remote_game(cb)
  CSM.stop_connect_remote({}, function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "stop_connect_with_remote_game failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.run_local_game()
  cloud_adapter.run_local_game()
end

function M.start_installed_local_game()
  cloud_adapter.start_installed_local_game()
end

function M.init_mode(params, cb)
  cb = cb or function()
    E.LOG.debug(TAG, "[cloud game] -------init_mode cb nil-------")
  end
  if init_tag then
    E.LOG.debug(TAG, "init manager inited, return")
    local result = get_native_result(true)
    cb(result)
    return
  end
  init_tag = true
  local log_config = {is_console = true}
  E.open_log_with_config(log_config)
  E.set_log_level(E.LOG_LEVEL.debug)
  E.LOG.debug(TAG, "[cloud game] -------init_mode -------")
  E.LOG.debug(TAG, params)
  params = params or {}
  cloud_config.init_config(params)
  cloud_mode = cloud_config.CloudGameMode
  local UIM = require("ejoysdk_lua.user_info_manager")
  cloud_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] = cloud_mode
  UIM.set_cloud_game_info(cloud_info)
  data.is_cloud_remote = false
  if M.CLOUD_MODE.MODE_CLOUD == cloud_mode then
    data.is_cloud_remote = true
  end
  E.LOG.debug(TAG, "init_mode cloud_mode: " .. tostring(cloud_config.CloudGameMode))
  E.LOG.debug(TAG, "init_mode cloud_mode begin:" .. tostring(cloud_mode))
  if data.is_cloud_remote then
    E.LOG.debug(TAG, "start remote logic")
    data.logic = remote_logic
    data.logic.init_message()
    M._init_cloud_rpc(true, data.logic)
    local result = get_native_result(true)
    cb(result)
    M.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_RUN_IN_CLOUD_SIDE)
  else
    M.set_mobile_run_mode(nil)
    E.LOG.debug(TAG, "start local logic")
    data.retry_down_cnt = 0
    data.product = require("ejoysdk_lua.cloud_game.product_adapter")
    E.LOG.debug(TAG, "begin init cloud_state_machine")
    if cloud_config.DEBUG_OPTIONS.TestEnableLuaProfile then
      E.LOG.debug(TAG, "lua profile enabled, now start lua profile")
      local profile = require("ejoysdk_lua.cloud_game.debug.profile")
      profile.lua_profile_start()
    end
    CSM.init(function(succ, ...)
      E.LOG.debug(TAG, "start up cloud game succ >> " .. tostring(succ))
      local result = get_native_result(succ, ...)
      cb(result)
    end)
    free_data.init()
  end
end

function M.init_local_logic()
  E.LOG.debug(TAG, "init_local_logic begin")
  data.logic = local_logic
  data.logic.init_message()
  M._init_cloud_rpc(false, data.logic)
end

function M.need_intercept_error(error_code)
  local code = tostring(error_code)
  if "nil" ~= code and #code > 4 then
    local prefix = string.sub(code, 1, 4)
    local prefix_number = tonumber(prefix)
    if prefix_number then
      return prefix_number < 5002
    end
  end
  return true
end

function M.receive_data(json_str)
  if data.logic then
    data.logic.get_msg():receive_data(json_str)
  end
end

function M.invoke_remote(error_handle, module, func, params)
  if data.logic then
    E.LOG.debug(TAG, "invoke_remote begin, module:" .. tostring(module) .. ", func:" .. tostring(func))
    data.logic.get_msg():invoke_remote(error_handle, module, func, params)
  else
    E.LOG.warn(TAG, "invoke_remote skip, logic obj is invalid")
  end
end

function M.on_cg_error(err_code, err_msg)
  E.LOG.debug(TAG, "on_cg_error received")
  CSM.on_connect_error(cloud_ui.ErrorType.CloudCGError, err_code, err_msg)
end

local last_update_restrict_time = 0

local function update_retrict_ui()
  if restrict_state and restrict_state.notify_type ~= nil then
    E.LOG.debug(TAG, "update_retrict_ui")
    local current_time = os.time()
    if current_time - last_update_restrict_time >= 1 then
      last_update_restrict_time = current_time
      cloud_ui.show_restrict_ui(restrict_state)
    end
  end
end

function M.on_restrict(restrict_obj)
  restrict_state.last_restrict_time = os.time()
  E.LOG.debug(TAG, "on_restrict >>")
  E.log(restrict_obj)
  if restrict_obj.notify_type then
    restrict_state.notify_type = restrict_obj.notify_type
    restrict_state.msg = restrict_obj.message
    restrict_state.msg_no_download = restrict_obj.message_no_download
    cloud_ui.show_restrict_ui(restrict_state)
    ET.subscribe(cloud_ui.CLOUD_TOPIC.TOPIC_DOWNLOAD_PROGRESS_CHANGED, update_retrict_ui)
  end
  if restrict_obj.game_res_download_limit_kps and restrict_obj.game_res_download_limit_kps > 0 then
    E.LOG.debug(TAG, "on_restrict download limit:" .. tostring(restrict_obj.game_res_download_limit_kps))
    cloud_config.force_http_kps_limit(restrict_obj.game_res_download_limit_kps)
  end
end

function M.cloud_network_quality_low()
  E.LOG.debug(TAG, "receive network quality low")
  if not is_show_close_bluetooth_tips and _ejoysdk.os() == "ios" then
    is_show_close_bluetooth_tips = true
    cloud_ui.show_close_bluetooth_tips()
    return
  end
  if CSM.is_cloud_connected() then
    cloud_ui.show_network_quality_low()
  end
end

local function hide_restrict()
  E.LOG.debug(TAG, "recover HttpKpsLimit: " .. tostring(cloud_config.force_http_kps))
  cloud_config.force_http_kps_limit(nil)
  E.LOG.debug(TAG, "hide_restrict begin")
  cloud_ui.hide_restrict_ui(restrict_state)
  restrict_state = {}
  ET.unsubscribe(cloud_ui.CLOUD_TOPIC.TOPIC_DOWNLOAD_PROGRESS_CHANGED, update_retrict_ui)
end

function M.on_remove_restrict()
  local current_time = os.time()
  local last_restrict_time = restrict_state.last_restrict_time or current_time
  local last_show_duration = current_time - last_restrict_time
  if last_show_duration < 2 then
    E.LOG.debug(TAG, "last show not larger than 2 sec, delay remove")
    E.Timer.once(2, function()
      hide_restrict()
    end)
    return
  end
  hide_restrict()
end

function M.get_cloud_mode()
  if cloud_mode then
    E.LOG.debug(TAG, "get_cloud_mode find current cloud_mode cache: " .. tostring(cloud_mode))
    return cloud_mode
  end
  cloud_mode = cloud_adapter.get_cloud_mode()
  E.LOG.debug(TAG, "get_cloud_mode in cloud_adapter: " .. tostring(cloud_mode))
  return cloud_mode
end

function M.get_server_config_data()
  do return end
  return cloud_adapter.get_server_config_data, nil
end

function M.start_cloud_game(cb, ex_params)
  cloud_adapter.run_cloud_game(cb, ex_params)
end

function M.stop_game(cb)
  cloud_adapter.stop_cloud_game(cb)
end

function M.open_full_download()
  E.LOG.debug(TAG, "open_full_download begin")
  CSM.open_full_download()
end

function M.exit_app()
  cloud_adapter.exit_app()
end

function M.exit_cloud_game_app()
  cloud_adapter.exit_cloud_game_app()
end

function M.close_cloud_game_view(params, cb)
  CSM.close_cloud_game_view(params, cb)
end

function M.cloud_view_not_visible()
  cloud_ui.hide_all_ui()
end

function M.disable_download()
  cloud_config.DEBUG_OPTIONS.TestDisableDownload = true
end

function M.is_mobile_network()
  do return end
  return cloud_adapter.is_mobile_network, nil
end

function M.is_network_available()
  do return end
  return cloud_adapter.is_network_available, nil
end

function M.get_play_config()
  return cloud_adapter.get_play_config() or {}
end

function M.get_product()
  return data.product
end

function M.notify_remote_local_device_info()
  local_logic.notify_remote_local_device_info()
end

function M.register_cloud_state_change_listener(cb)
  CSM.register_cloud_state_change_listener(cb)
end

return M

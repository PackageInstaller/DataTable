local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CloudUI = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_content_interface")
local WebTxt = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_text_web")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UI_STAT = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_ui_stat")
local facade, state_manager
local UI_NAME = "NORMAL_WEB"
local default_url = "file:///android_asset/demo/js/cloud_game/modal.html"
if _ejoysdk.os() == "ios" then
  local paths = _ejoysdk.sysinfo_paths()
  local bundle_path_ios = paths.bundle_path .. "/cloudgame.bundle/"
  default_url = "file://" .. bundle_path_ios .. "cloud_game/modal.html"
end
local M = CloudUI:Inherit(UI_NAME)
M.SCENE = WebTxt.SCENE
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_content_normal_web"
local data = {}

local function get_state_manager()
  state_manager = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  return state_manager
end

local function get_facade()
  facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  return facade
end

local function format(f, ...)
  local ret, msg = pcall(string.format, f, ...)
  if not ret then
    E.LOG.debug(TAG, string.format([[
[cloud game] format error!!!!!!! %s 
%s]], f, msg))
    return f
  end
  return msg
end

local function handle_btn_event(args)
  if not (args and args.chl) or not args.type then
    return nil
  end
  local channel = args.chl
  local type = args.type
  local btn_id
  if "cloud_game" == channel and "btn_click_event" == type then
    btn_id = args.params.btn_id
  end
  return btn_id
end

function M.get_storage_error(retry_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.MEMORY_SPACE_LOWER_1)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      E.log("js callback invoke")
      E.log(_values)
      local btn_id = handle_btn_event(_values.args)
      E.log("btn event id type >> " .. tostring(type(btn_id)))
      if "retry" == btn_id and retry_cb then
        E.WebView.close()
        retry_cb()
      end
    end
  }
  return content
end

function M.get_exper_time_coming()
  local txt = WebTxt.get_txt(WebTxt.SCENE.EXPER_TIME_COMING)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "ok" == btn_id then
        E.WebView.close()
      end
    end
  }
  return content
end

function M.get_exper_time_coming_2()
  local txt = WebTxt.get_txt(WebTxt.SCENE.EXPER_TIME_COMING_2)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "ok" == btn_id then
        E.WebView.close()
      end
    end
  }
  return content
end

function M.get_flash_screen(download_cb, need_user_confirm)
  download_cb = download_cb or function()
  end
  local is_4g = cloud_adapter.is_mobile_network()
  local is_show_btn = need_user_confirm
  local txt, js_callback
  
  local function download_cb_with_confirm_wrap(is_download)
    download_cb(is_download, true)
  end
  
  local function download_cb_with_no_confirm_wrap(is_download)
    download_cb(is_download, false)
  end
  
  if is_4g then
    local state = get_state_manager().get_cloud_state_info()
    E.LOG.debug(TAG, "show 4g splash view ")
    E.log(state)
    local time_limit_state = state.time_limit_state
    local is_exper_end = time_limit_state.is_experience_time_end
    E.LOG.debug(TAG, "get_mobile_network_tips, is_exper_end:" .. tostring(is_exper_end))
    if is_exper_end then
      txt = WebTxt.get_txt(WebTxt.SCENE.SPLASH_4G_2)
      
      function js_callback(values)
        local btn_id = handle_btn_event(values.args)
        if "1" == btn_id then
          E.WebView.close()
          download_cb_with_confirm_wrap(true)
          UI_STAT.stat_click_mobile_play_with_download()
        elseif "2" == btn_id then
          E.WebView.close()
          cloud_adapter.exit_app()
          UI_STAT.stat_splash_exit()
        end
      end
    else
      txt = WebTxt.get_txt(WebTxt.SCENE.SPLASH_4G_1)
      
      function js_callback(values)
        local btn_id = handle_btn_event(values.args)
        if "1" == btn_id then
          E.WebView.close()
          download_cb_with_confirm_wrap(false)
          UI_STAT.stat_click_mobile_try_play()
        elseif "2" == btn_id then
          E.WebView.close()
          download_cb_with_confirm_wrap(true)
          UI_STAT.stat_click_mobile_play_with_download()
        elseif "3" == btn_id then
          E.WebView.close()
          cloud_adapter.exit_app()
          UI_STAT.stat_splash_exit()
        end
      end
    end
  else
    txt = WebTxt.get_txt(WebTxt.SCENE.SPLASH_WIFI)
    if not is_show_btn then
      txt.btns = nil
    end
    
    function js_callback(values)
      local btn_id = handle_btn_event(values.args)
      if "1" == btn_id then
        E.WebView.close()
        download_cb_with_no_confirm_wrap(false)
        UI_STAT.stat_splash_confirm()
      elseif "2" == btn_id then
        E.WebView.close()
        cloud_adapter.exit_app()
        UI_STAT.stat_splash_exit()
      end
    end
  end
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  UI_STAT.stat_splash_show()
  return content
end

function M.get_free_exper_time_over(download_cb)
  local txt, js_callback
  txt = WebTxt.get_txt(WebTxt.SCENE.FREE_EXPER_TIME_OVER)
  
  function js_callback(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      download_cb(true)
      UI_STAT.stat_experience_time_end_download()
    elseif "2" == btn_id then
      E.WebView.close()
      cloud_adapter.exit_app()
      UI_STAT.stat_experience_time_end_reject_download()
    end
  end
  
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  return content
end

function M.get_down_finish_with_no_exp_time()
  local txt, js_callback
  txt = WebTxt.get_txt(WebTxt.SCENE.DOWNLOAD_FINISH_1)
  
  function js_callback(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      cloud_adapter.run_local_game()
    end
  end
  
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  return content
end

function M.get_exp_time_over_with_download_unfinish()
  local txt, js_callback
  txt = WebTxt.get_txt(WebTxt.SCENE.DOWNLOAD_EXPER_TIME_OVER)
  
  function js_callback(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      cloud_adapter.exit_app()
      UI_STAT.stat_total_time_end_reject_download()
    end
  end
  
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  return content
end

function M.get_exp_time_over_with_download_unfinish_counting()
  local txt, js_callback
  txt = WebTxt.get_txt(WebTxt.SCENE.DOWNLOAD_EXPER_TIME_OVER_COUNTING)
  
  function js_callback(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      cloud_adapter.exit_app()
      UI_STAT.stat_total_time_end_reject_download()
    end
  end
  
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  return content
end

function M.get_download_exper_time_over()
  local state = get_state_manager().get_cloud_state_info()
  local is_download_finish = state.download_state.state == "complete"
  if is_download_finish then
    do return end
    return M.get_down_finish_with_no_exp_time
  else
    do return end
    return M.get_exp_time_over_with_download_unfinish
  end
end

function M.get_cloud_error(error_type, error_code, is_cloud_start_error, param)
  local txt = WebTxt.get_txt(WebTxt.SCENE.CLOUD_CONNECT_FAILED_WITH_DOWNLOADING)
  txt.message = txt.message .. format("(%s-%s)", error_type or "", error_code or "")
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_relink_button", nil, error_code)
        if param then
          param()
        end
      elseif "2" == btn_id then
        E.WebView.close()
        if is_cloud_start_error then
          cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_drop_button", nil, error_code)
        else
          cloud_adapter.cloud_stat_action_fail_upload("cloud_cg_failed_page_click_drop_button", nil, error_code)
        end
        cloud_adapter.exit_app()
      end
    end
  }
  return content
end

function M.get_cloud_error_with_pkg_installed(start_local_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.CLOUD_CONNECT_FAILED_WITH_PKG_INSTALLED)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and start_local_cb then
        start_local_cb()
      end
    end
  }
  return content
end

function M.get_cloud_error_with_reason(error_type, error_code, is_network_available, retry_cb)
  local txt
  if is_network_available then
    txt = WebTxt.get_txt(WebTxt.SCENE.CLOUD_CONNECT_FAILED_WITH_UNKNOWN_REASON)
  else
    txt = WebTxt.get_txt(WebTxt.SCENE.CLOUD_CONNECT_FAILED_WITH_NO_NETWORK)
  end
  txt.message = txt.message .. format("（%s-%s）", error_type or "", error_code or "")
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_relink_button", nil, error_code)
        if retry_cb then
          retry_cb()
        end
      end
    end
  }
  return content
end

function M.get_cloud_error_without_download(error_type, error_code, download_cb, is_cloud_start_error)
  local txt = WebTxt.get_txt(WebTxt.SCENE.CLOUD_CONNECT_FAILED)
  txt.message = txt.message .. format("(%s-%s)", error_type or "", error_code or "")
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(values)
      local btn_id = handle_btn_event(values.args)
      if "1" == btn_id then
        E.WebView.close()
        if download_cb then
          download_cb()
        end
      elseif "2" == btn_id then
        E.WebView.close()
        if is_cloud_start_error then
          cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_drop_button", nil, error_code)
        else
          cloud_adapter.cloud_stat_action_fail_upload("cloud_cg_failed_page_click_drop_button", nil, error_code)
        end
        cloud_adapter.exit_app()
      end
    end
  }
  return content
end

function M.get_connect_cloud_error(download_cb, exit_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.CLOUD_CONNECT_FAILED)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        if download_cb then
          download_cb()
        end
      elseif "2" == btn_id then
        E.WebView.close()
        if exit_cb then
          exit_cb()
        end
      end
    end
  }
  return content
end

function M.get_resource_update_tips_2(exit_cb, connect_remote_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.RESOURCE_UPDATE_TIPS_2)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        if exit_cb then
          exit_cb()
        end
      elseif "2" == btn_id then
        E.WebView.close()
        if connect_remote_cb then
          connect_remote_cb()
        end
      end
    end
  }
  return content
end

function M.get_resource_update_tips_1(exit_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.RESOURCE_UPDATE_TIPS_1)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        if exit_cb then
          exit_cb()
        end
      end
    end
  }
  return content
end

function M.get_exp_over_and_download_finish(restart_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.EXPER_TIME_OVER_WITH_DOWNLOAD_FINISH)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and restart_cb then
        E.WebView.close()
        restart_cb()
      end
    end
  }
  return content
end

function M.get_mobile_network_tips(type, _is_ab_test_for_btn_one, confirm_cb)
  local ab_stat_params = {is_priority_high = true}
  local txt, _js_callback
  local state = get_state_manager().get_cloud_state_info()
  E.LOG.debug(TAG, "get_mobile_network_tips show 4g splash view ")
  E.log(state)
  local time_limit_state = state.time_limit_state
  local is_exper_end = time_limit_state.is_experience_time_end
  E.LOG.debug(TAG, "get_mobile_network_tips, is_exper_end:" .. tostring(is_exper_end))
  if is_exper_end then
    E.LOG.debug(TAG, "get_mobile_network_tips, use2")
    txt = WebTxt.get_txt(WebTxt.SCENE.SPLASH_4G_2)
    
    function _js_callback(values)
      local btn_id = handle_btn_event(values.args)
      if "1" == btn_id then
        E.WebView.close()
        confirm_cb(true)
        UI_STAT.stat_click_mobile_play_with_download()
      elseif "2" == btn_id then
        E.WebView.close()
        cloud_adapter.exit_app()
      end
    end
  else
    E.LOG.debug(TAG, "get_mobile_network_tips, use1")
    txt = WebTxt.get_txt(WebTxt.SCENE.SPLASH_4G_1)
    
    function _js_callback(values)
      local btn_id = handle_btn_event(values.args)
      if "1" == btn_id then
        E.WebView.close()
        confirm_cb(false)
      elseif "2" == btn_id then
        E.WebView.close()
        confirm_cb(true)
        UI_STAT.stat_click_mobile_play_with_download()
      elseif "3" == btn_id then
        E.WebView.close()
        CSTAT.stat_action("network_switch_page_click_refused_button", type, true, {})
        cloud_adapter.exit_app()
      end
    end
  end
  cloud_adapter.cloud_stat_action("network_switch_page_btn", "btn_two", false, ab_stat_params)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = _js_callback
  }
  return content
end

function M.get_download_finish(had_cg_error, _connect_with_remote_enabled)
  local ui_content, txt
  local state = get_state_manager().get_cloud_state_info()
  local is_cloud_connected = state.connect_state.state == "connected"
  if had_cg_error or not is_cloud_connected then
    txt = WebTxt.get_txt(WebTxt.SCENE.DOWNLOAD_FINISH_1)
    ui_content = {
      url = default_url,
      startupData = txt,
      js_callback = function(_values)
        local btn_id = handle_btn_event(_values.args)
        if "1" == btn_id then
          E.WebView.close()
          cloud_adapter.cloud_stat_action("download_complete_page_click_reload_button")
          cloud_adapter.run_local_game()
        end
      end
    }
  else
    txt = WebTxt.get_txt(WebTxt.SCENE.DOWNLOAD_FINISH_2)
    ui_content = {
      url = default_url,
      startupData = txt,
      js_callback = function(_values)
        local btn_id = handle_btn_event(_values.args)
        if "1" == btn_id or data.had_cg_error then
          E.WebView.close()
          cloud_adapter.cloud_stat_action("download_complete_page_click_reload_button")
          cloud_adapter.run_local_game()
        else
          E.WebView.close()
          cloud_adapter.cloud_stat_action("download_complete_page_click_continue_button")
        end
      end
    }
  end
  return ui_content
end

function M.get_exper_time_over()
  local txt = WebTxt.get_txt(WebTxt.SCENE.EXPER_TIME_OVER)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        CSTAT.stat_action("cloud_time_limit_click_exit")
        cloud_adapter.exit_app()
      end
    end
  }
  return content
end

function M.get_more_exper_time_over_with_download_finish()
  local time_limit = cloud_config.CloudGamePlayTimeLimit
  local txt = WebTxt.get_txt(WebTxt.SCENE.MORE_EXPER_OVER)
  txt.data = {downloadAsPlayTotalTimeMinute = time_limit}
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        cloud_adapter.cloud_stat_action("stop_cloud_game_" .. "download_complete_play_again_timeup_page_click_reload_button")
        cloud_adapter.run_local_game()
      end
    end
  }
  return content
end

function M.get_network_error(error_type, error_code)
  local txt = WebTxt.get_txt(WebTxt.SCENE.NETWORK_ERROR)
  txt.message = txt.message .. format("(%s-%s)", error_type or "", error_code or "")
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        CSTAT.stat_action("network_link_failed_page_click_replay_button")
        facade.exit_cloud_game(false, {})
      elseif "2" == btn_id then
        E.WebView.close()
      end
    end
  }
  return content
end

function M.get_exit_confirm(download_finish, cb)
  local txt
  if download_finish then
    txt = WebTxt.get_txt(WebTxt.SCENE.EXIT_CONFIRM_WITH_DOWNLOADED)
  else
    txt = WebTxt.get_txt(WebTxt.SCENE.EXIT_CONFIRM)
  end
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        get_facade().exit_cloud_game(true, {})
        if cb then
          cb(true)
        end
      elseif "2" == btn_id then
        E.WebView.close()
        if cb then
          cb(false)
        end
      end
    end
  }
  return content
end

function M.get_network_error_retry(error_type, error_code, retry_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.NETWORK_ERROR_RETRY)
  txt.message = txt.message .. format("(%s-%s)", error_type or "", error_code or "")
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        CSTAT.stat_action("network_link_failed_page_click_replay_button")
        get_facade().exit_cloud_game(false, {})
      elseif "2" == btn_id then
        E.WebView.close()
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_relink_button", nil, error_code)
        if retry_cb then
          retry_cb()
        end
      end
    end
  }
  return content
end

function M.get_download_complete(start_local_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.DOWNLOAD_COMPLETE)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and start_local_cb then
        start_local_cb()
      end
    end
  }
  return content
end

function M.get_play_over(start_local_cb, count_down)
  local txt
  if cloud_config.SelfStart then
    E.LOG.debug(TAG, "get_play_over is selfstart, now show self start time over ui")
    txt = WebTxt.get_txt(WebTxt.SCENE.PLAY_TIME_OVER_SELF_START)
  else
    E.LOG.debug(TAG, "get_play_over is NOT selfstart, now show try play time over ui")
    txt = WebTxt.get_txt(WebTxt.SCENE.PLAY_TIME_OVER)
  end
  if count_down and count_down > 0 then
    local ext_data = txt.ext_data or {}
    ext_data.countDown = count_down
    txt.ext_data = ext_data
  end
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and start_local_cb then
        start_local_cb()
      end
    end
  }
  return content
end

function M.get_play_over_with_download_finish(start_local_cb, count_down)
  local txt = WebTxt.get_txt(WebTxt.SCENE.PLAY_TIME_OVER_WITH_DOWNLOAD_FINISH)
  if count_down and count_down > 0 then
    local ext_data = txt.ext_data or {}
    ext_data.countDown = count_down
    txt.ext_data = ext_data
    txt.displayTime = count_down
  end
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and start_local_cb then
        start_local_cb()
      end
    end
  }
  return content
end

function M.get_network_quality_low()
  local txt = WebTxt.get_txt(WebTxt.SCENE.NETWORK_QUALITY_LOW)
  local content = {url = default_url, startupData = txt}
  return content
end

function M.get_close_bluetooth_tips()
  local txt = WebTxt.get_txt(WebTxt.SCENE.BLUETOOTH_CLOSE_TIPS)
  local content = {url = default_url, startupData = txt}
  return content
end

function M.get_not_wifi_remain()
  local txt = WebTxt.get_txt(WebTxt.SCENE.NOT_WIFI_REMAIN)
  local content = {url = default_url, startupData = txt}
  return content
end

function M.get_free_cg_tips()
  local txt = WebTxt.get_txt(WebTxt.SCENE.FREE_CG_TIPS)
  local content = {url = default_url, startupData = txt}
  return content
end

function M.get_connect_fail_tips()
  local txt = WebTxt.get_txt(WebTxt.SCENE.CONNECT_FAIL_TIPS)
  local content = {url = default_url, startupData = txt}
  return content
end

function M.get_pkg_installed_tips(run_local_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.PKG_INSTALLED_TIPS)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and run_local_cb then
        run_local_cb()
      end
    end
  }
  return content
end

function M.get_start_download_tips(is_wifi)
  local txt
  if is_wifi then
    txt = WebTxt.get_txt(WebTxt.SCENE.START_DOWNLOAD_WIFI_TIPS)
  else
    txt = WebTxt.get_txt(WebTxt.SCENE.START_DOWNLOAD_MOBILE_TIPS)
  end
  local content = {url = default_url, startupData = txt}
  return content
end

function M.get_on_cg_error(retry_cb, is_kick_out, code, _msg)
  local txt
  if is_kick_out then
    txt = WebTxt.get_txt(WebTxt.SCENE.ON_CG_ERROR_KICK_OUT)
  else
    txt = WebTxt.get_txt(WebTxt.SCENE.ON_CG_ERROR)
  end
  if txt and txt.message then
    txt.message = txt.message .. "(" .. tostring(code or "") .. ")"
  end
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "2" == btn_id then
        E.WebView.close()
        if retry_cb then
          retry_cb()
        end
        UI_STAT.click_error_retry()
      elseif "1" == btn_id then
        UI_STAT.click_error_exit()
        E.WebView.close()
        get_facade().exit_cloud_game(false, {})
      end
    end
  }
  return content
end

function M.get_pkg_install_complete(try_play_cb, run_local_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.PKG_INSTALL_COMPLETE)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        if try_play_cb then
          try_play_cb()
        end
      elseif "2" == btn_id and run_local_cb then
        run_local_cb()
      end
    end
  }
  return content
end

function M.get_pkg_install_complete_without_connect(run_local_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.PKG_INSTALL_COMPLETE_WITHOUT_CONNECT)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        cloud_adapter.exit_app()
      elseif "2" == btn_id and run_local_cb then
        run_local_cb()
      end
    end
  }
  return content
end

function M.get_time_end_with_installed(run_local_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.TIME_END_WITH_INSTALLED)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id then
        E.WebView.close()
        cloud_adapter.exit_app()
      elseif "2" == btn_id and run_local_cb then
        run_local_cb()
      end
    end
  }
  return content
end

function M.get_time_end_with_not_installed(install_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.TIME_END_WITH_NOT_INSTALLED)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      E.LOG.debug(TAG, "receive ui btn click event, btn_id >> " .. tostring(btn_id))
      if "1" == btn_id then
        E.WebView.close()
        cloud_adapter.exit_app()
      elseif "2" == btn_id and install_cb then
        install_cb()
      end
    end
  }
  return content
end

function M.get_time_coming_with_installed_tips(run_local_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.TIME_COMING_WITH_INSTALLED_TIPS)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and run_local_cb then
        run_local_cb()
      end
    end
  }
  return content
end

function M.get_time_coming_with_not_installed_tips(install_cb)
  local txt = WebTxt.get_txt(WebTxt.SCENE.TIME_COMING_WITH_NOT_INSTALLED_TIPS)
  local content = {
    url = default_url,
    startupData = txt,
    js_callback = function(_values)
      local btn_id = handle_btn_event(_values.args)
      if "1" == btn_id and install_cb then
        install_cb()
      end
    end
  }
  return content
end

function M.get_weak_network_toast_content()
  local txt = WebTxt.get_txt(WebTxt.SCENE.NETWORK_WEAK)
  local content = {url = default_url, startupData = txt}
  return content
end

function M._get_size_show(total_size, downloading_size)
  E.LOG.debug(TAG, "_get_size_show, total_size >> " .. tostring(total_size) .. ", downloading_size" .. tostring(downloading_size))
  total_size = total_size * cloud_config.DownloadSizeFix
  local total_str
  local down_str = 0
  if total_size < 1048576 then
    total_str = format("%.3fM", total_size / 1024 / 1024)
  else
    total_str = format("%.1fM", total_size / 1024 / 1024)
  end
  if downloading_size and downloading_size > 0 then
    downloading_size = downloading_size * cloud_config.DownloadSizeFix
    down_str = math.floor(downloading_size / total_size * 100)
  end
  return total_str, down_str
end

function M.get_game_res_checking_ui()
  local txt = WebTxt.get_txt(WebTxt.SCENE.GAME_RES_CHECKING)
  local content = {url = default_url, startupData = txt}
  return content
end

return M

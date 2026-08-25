local E = require("ejoysdk_lua.ejoysdk")
local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
local local_res = require("ejoysdk_lua.free_flow.web_txt_res")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local FSTAT = require("ejoysdk_lua.free_flow.free_flow_stat")
local ACTION = FSTAT.FREE_FLOW_ACTION
local M = {}
local TAG = "free_flow#free_flow_ui"
local default_url = "file:///android_asset/demo/js/cloud_game/index.html"
local user_auth = "file:///android_asset/demo/js/cloud_game/traffic.html"
local INJECTION_PATH = "/android_asset/demo/js/cloud_game/index.html"
local INJECTION_PATH_USER_AUTH = "/android_asset/demo/js/cloud_game/traffic.html"
if _ejoysdk.os() == "ios" then
  local paths = _ejoysdk.sysinfo_paths()
  local bundle_path_ios = paths.bundle_path .. "/cloudgame.bundle/"
  default_url = "file://" .. bundle_path_ios .. "cloud_game/index.html"
  user_auth = "file://" .. bundle_path_ios .. "cloud_game/traffic.html"
  INJECTION_PATH = bundle_path_ios .. "cloud_game/index.html"
  INJECTION_PATH_USER_AUTH = bundle_path_ios .. "cloud_game/traffic.html"
end
M.SCENE = {
  SCENE_USER_AUTH = "user_auth",
  SCENE_LOADING = "loading",
  SCENE_RECEIVE_SUCCESS = "receive_success",
  SCENE_RECEIVE_FAIL = "receive_fail_1",
  SCENE_RECEIVE_FAIL_NOMSG = "receive_fail_2",
  SCENE_ALREADY_RECEIVE = "already_receive",
  SCENE_SWITCH_FREE_FLOW = "switch_free_flow",
  SCENE_SWITCH_PAY_FLOW = "switch_pay_flow",
  SPLASH_4G_CTCC = "splash_4g_ctcc"
}
local web_ui_txt_cache
local dataPkgName = "阿里云畅玩15G专属流量包"

local function _check_remote_content_cache()
  if web_ui_txt_cache then
    return web_ui_txt_cache
  end
  local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
  local cloud_game_config = CA.get_cloud_static_config()
  if cloud_game_config and next(cloud_game_config) ~= nil then
    local config_data = cloud_game_config.config
    web_ui_txt_cache = config_data and config_data.web_ui_content or nil
  end
  return web_ui_txt_cache
end

local function find_ui_content_in_config(config_data, scene)
  local content
  for _, v in ipairs(config_data.dialog_infos) do
    if v.scene == scene then
      content = utils.deepcopy(v)
    end
  end
  return content
end

local function get_txt_by_scene(scene)
  local content = find_ui_content_in_config(local_res, scene)
  if not content then
    E.LOG.warn(TAG, "do not find the content for scene >> " .. tostring(scene))
    return nil
  end
  return content
end

local function handle_btn_event(args)
  E.LOG.debug(TAG, "handle btn event")
  E.log(args)
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

local function open_web(ui_content, type, close_cb)
  local url = ui_content.url
  E.LOG.debug(TAG, "get_download_info_for_ui")
  local injection = {
    [INJECTION_PATH] = {
      transparent = true,
      startupData = {
        init_params = {
          dialog_info = ui_content.startupData
        }
      }
    },
    [INJECTION_PATH_USER_AUTH] = {
      transparent = true,
      startupData = {
        init_params = {
          dialog_info = ui_content.startupData
        }
      }
    }
  }
  local options = {
    use_fragment = true,
    compactMode = true,
    hide_close_btn = true,
    use_cutout = true,
    disable_backkey_press = true
  }
  local js_callback = ui_content.js_callback
  if ui_content.startupData.priority and ui_content.startupData.priority == "high" then
    EWB.add_webview_priority(url, injection, options, js_callback, close_cb, type)
  else
    EWB.add_webview(url, injection, options, js_callback, close_cb, type)
  end
end

function M.update_data_pkg_name(name)
  E.LOG.debug(TAG, "update data pkg name >> " .. tostring(name))
  if name then
    dataPkgName = name
  end
end

function M.show_user_auth(mask, protocol_name, protocol_url, cb)
  local txt = get_txt_by_scene(M.SCENE.SCENE_USER_AUTH)
  local format_protocol_name = "《" .. protocol_name .. "》"
  local is_callback = false
  txt.ext_info = {
    mobile_agreement = {name = format_protocol_name, url = protocol_url}
  }
  txt.data = {phoneMask = mask, dataPkgName = dataPkgName}
  
  local function js_callback(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      if not is_callback then
        is_callback = true
        if cb then
          cb(true)
        end
      end
    end
  end
  
  local ui_content = {
    url = user_auth,
    startupData = txt,
    js_callback = js_callback
  }
  open_web(ui_content, M.SCENE.SCENE_USER_AUTH, function()
    E.LOG.debug(TAG, "receive dialog close event, is_callback >> " .. tostring(is_callback))
    if not is_callback then
      is_callback = true
      if cb then
        cb(false)
      end
    end
  end)
end

function M.show_receive_loading(close_cb)
  local txt = get_txt_by_scene(M.SCENE.SCENE_LOADING)
  
  local function js_callback(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      if close_cb then
        close_cb()
      end
    end
  end
  
  local ui_content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  open_web(ui_content, M.SCENE.SCENE_LOADING, function()
  end)
end

function M.hide_receive_loading()
  EWB.close_view(M.SCENE.SCENE_LOADING)
end

function M.show_receive_success(ensure_cb)
  local txt = get_txt_by_scene(M.SCENE.SCENE_RECEIVE_SUCCESS)
  txt.data = {dataPkgName = dataPkgName}
  
  local function js_callback(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      FSTAT.stat_action(ACTION.FREE_FLOW_SHOW_RECEIVE_SUCC_ENTER)
      if ensure_cb then
        ensure_cb()
      end
    end
  end
  
  local ui_content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  FSTAT.stat_action(ACTION.FREE_FLOW_SHOW_RECEIVE_SUCC_PAGE)
  open_web(ui_content, M.SCENE.SCENE_RECEIVE_SUCCESS, function()
    E.LOG.debug(TAG, "receive success dialog close callback")
  end)
end

function M.show_receive_fail(retry_cb, enter_game_cb, no_msg)
  FSTAT.stat_action(ACTION.FREE_FLOW_SHOW_RECEIVE_FAIL)
  E.LOG.debug(TAG, "show receive fail view")
  local txt, js_callback
  if no_msg then
    txt = get_txt_by_scene(M.SCENE.SCENE_RECEIVE_FAIL_NOMSG)
  else
    txt = get_txt_by_scene(M.SCENE.SCENE_RECEIVE_FAIL)
  end
  txt.data = {dataPkgName = dataPkgName}
  
  function js_callback(values)
    E.LOG.debug(TAG, "receive js callback and args >> ")
    E.log(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      FSTAT.stat_action(ACTION.FREE_FLOW_SHOW_RECEIVE_FAIL_ENTER)
      if enter_game_cb then
        enter_game_cb()
      end
    elseif "back" == btn_id then
      E.WebView.close()
      FSTAT.stat_action(ACTION.FREE_FLOW_SHOW_RECEIVE_FAIL_RETRY)
      if retry_cb then
        retry_cb()
      end
    end
  end
  
  local ui_content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  open_web(ui_content, M.SCENE.SCENE_RECEIVE_FAIL, function()
    E.LOG.debug(TAG, "receive fail dialog close callback")
  end)
end

function M.show_already_receive_fail(enter_game_cb)
  E.LOG.debug(TAG, "show already receive fail view")
  local txt = get_txt_by_scene(M.SCENE.SCENE_ALREADY_RECEIVE)
  
  local function js_callback(values)
    E.LOG.debug(TAG, "receive js callback and args >> ")
    E.log(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      if enter_game_cb then
        enter_game_cb()
      end
    end
  end
  
  local ui_content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  open_web(ui_content, M.SCENE.SCENE_ALREADY_RECEIVE, function()
    E.LOG.debug(TAG, "receive fail dialog close callback")
  end)
end

function M.show_switch_to_free_flow()
  local txt = get_txt_by_scene(M.SCENE.SCENE_SWITCH_FREE_FLOW)
  local ui_content = {
    url = default_url,
    startupData = txt,
    js_callback = function()
    end
  }
  FSTAT.stat_action(ACTION.FREE_FLOW_TOAST)
  open_web(ui_content, M.SCENE.SCENE_SWITCH_FREE_FLOW, function()
    E.LOG.debug(TAG, "receive switch free flow dialog close callback")
  end)
  E.Timer.once(3, function()
    EWB.close_view(M.SCENE.SCENE_SWITCH_FREE_FLOW)
  end)
end

function M.show_switch_to_pay_flow(close_cb)
  local txt = get_txt_by_scene(M.SCENE.SCENE_SWITCH_PAY_FLOW)
  local ui_content = {
    url = default_url,
    startupData = txt,
    js_callback = function()
    end
  }
  open_web(ui_content, M.SCENE.SCENE_SWITCH_PAY_FLOW, function()
    E.LOG.debug(TAG, "receive switch pay flow dialog close callback")
  end)
  E.Timer.once(3, function()
    EWB.close_view(M.SCENE.SCENE_SWITCH_PAY_FLOW)
    if close_cb then
      close_cb()
    end
  end)
end

function M.show_receive_splash(enter_cb)
  local txt = get_txt_by_scene(M.SCENE.SPLASH_4G_CTCC)
  
  local function js_callback(values)
    E.LOG.debug(TAG, "receive js callback and args >> ")
    E.log(values)
    local btn_id = handle_btn_event(values.args)
    if "1" == btn_id then
      E.WebView.close()
      FSTAT.stat_action(ACTION.DX_GET_FREE_FLOW_PAGE_LOGIN_BUTTON)
      if enter_cb then
        enter_cb()
      end
    end
  end
  
  local ui_content = {
    url = default_url,
    startupData = txt,
    js_callback = js_callback
  }
  FSTAT.stat_action(ACTION.DX_GET_FREE_FLOW_PAGE)
  open_web(ui_content, M.SCENE.SPLASH_4G_CTCC, function()
    E.LOG.debug(TAG, "receive switch pay flow dialog close callback")
  end)
end

return M

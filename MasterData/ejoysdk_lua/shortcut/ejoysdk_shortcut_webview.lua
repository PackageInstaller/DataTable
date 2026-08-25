local E = require("ejoysdk_lua.ejoysdk")
local CC = require("ejoysdk_lua.ejoysdk_config_center")
local uuid = require("ejoysdk_lua.ejoysdk_uuid")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = "base#sc_webview"
local Utils = require("ejoysdk_lua.native.utils.Utils")
local WVMI = require("ejoysdk_lua.webview.multi_instance")
local LAST_WV_STORAGE = E.LazyKeyStore:New("LAST_WV_STORAGE", false, true, false)
local LAST_WV_SHORTCUT_OPTS = E.LazyKeyStore:New("LAST_WV_SHORTCUT_OPTS", false, true, false)
local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
local ejoysdk_topic = require("ejoysdk_lua.ejoysdk_topic")
local EVS = require("ejoysdk_lua.vendors.shortcut")
local e_utils = require("ejoysdk_lua.ejoysdk_utils")
local Live = require("ejoysdk_lua.webview.live_floater")
M.Type = {Community = "community", Site = "site"}
M.CONFIG_KEYS = {
  SC_ENV = "sdk_server_env",
  GAME_PRODUCT_ID = "game_product_id",
  DEBUGGABLE = "debuggable",
  Type = "type"
}
M.DEBUG_OPTIONS = {Debug = false}
M.LIVE_EVENT = Live.LIVE_EVENT
local DEFAULT_SITE_FRAME_WIDTH = 540
local DEFAULT_SITE_FRAME_HEIGHT = 960
local sc_webview_maps = {}
local callback_maps = {}
local last_from_source_data_map = {}
local last_floater_startup_data = {}

local function get_config_from_cc_h5res(_type)
  local sc_params
  local cc_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
  local sc_configs = cc_config and cc_config.config and cc_config.config.shortcut
  if sc_configs and sc_configs.items then
    for _, v in pairs(sc_configs.items) do
      if v.type == _type then
        sc_params = v
        break
      end
    end
  end
  return sc_params
end

local function get_local_preload_config(_type)
  local cc_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
  local sc_configs = _type and cc_config and cc_config.config and cc_config.config[_type]
  return sc_configs
end

M.get_config_from_cc_h5res = get_config_from_cc_h5res
local subscribed_once = false
local is_opening_before_destroy_live = false
local webview_live_callbacks = {}
local current_event = Live.LIVE_EVENT.ON_LIVE_DESTROY

local function on_live_handler(event, disable_live_event)
  if event and not disable_live_event then
    for k, v in pairs(webview_live_callbacks) do
      if type(v) == "function" then
        local is_open = M.is_opened_biz(k) or is_opening_before_destroy_live
        v(event, {biz_type = k, is_open = is_open})
        if event == Live.LIVE_EVENT.ON_LIVE_DESTROY and is_opening_before_destroy_live then
          is_opening_before_destroy_live = false
        end
      end
    end
  end
  current_event = event
end

local function subscribe_webview_live_floater(biz_type, live_cb)
  if live_cb and type(live_cb) == "function" then
    webview_live_callbacks[biz_type] = live_cb
    if not subscribed_once then
      ejoysdk_topic.subscribe(ejoysdk_topic.live_floater.ON_CHANGED, on_live_handler)
      subscribed_once = true
    end
  end
end

local function reset_local_config()
  is_opening_before_destroy_live = false
end

local function dispath_offline_res_update(url_code, res_config_data)
  if _ejoysdk.os() == "windows" then
    return
  end
  E.LOG.debug(TAG, "handle_offline_res_udpate: " .. tostring(url_code))
  M.handle_offline_res_udpate(url_code, res_config_data)
end

local _sub_lang_changed_handler = false

function M.lang_changed_handler(biz_type, _new_lan)
  local sc_wv = sc_webview_maps[biz_type]
  local last_lan = sc_wv:get_data("language")
  if sc_wv and last_lan ~= _new_lan then
    if sc_wv:is_opened() then
      E.LOG.debug(TAG, "sc_webview update in next open " .. tostring(biz_type))
      sc_wv:disable_hide(true)
    elseif E.WebView.is_opened() then
      E.LOG.debug(TAG, "sc_webview update in next open, other wv is open " .. tostring(biz_type))
      sc_wv:disable_hide(true)
    else
      E.LOG.debug(TAG, "sc_webview update " .. tostring(biz_type))
      sc_wv:remove_hide_cache()
      sc_webview_maps[biz_type] = nil
    end
  end
end

function M.register(biz_type, on_callbacks)
  callback_maps[biz_type] = on_callbacks
  local need_prepare_webview = false
  if _ejoysdk.os() == "windows" then
    need_prepare_webview = true
  end
  local c_config = get_local_preload_config(biz_type)
  if c_config and type(c_config) == "table" and c_config.need_prepare_webview ~= nil then
    need_prepare_webview = c_config.need_prepare_webview
  end
  if need_prepare_webview then
    E.WebView.prepare({})
  end
end

function M.add_shortcut_webview(biz_type, cb, option)
  cb = cb or function()
  end
  option = option or {}
  if not biz_type then
    E.LOG.debug(TAG, "add_shortcut_webview type is nil")
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "add_shortcut_webview type is nil")
    return
  end
  local sc_params = get_config_from_cc_h5res(biz_type)
  local title_str = sc_params and sc_params.title or option and option.title
  local android_long_title_str = sc_params and sc_params.android_long_title or option and option.android_long_title
  if sc_params and title_str and sc_params.url then
    E.LOG.debug(TAG, sc_params)
    local params = {
      title = title_str,
      url = sc_params.url,
      android_long_title = android_long_title_str or title_str,
      android_icon_name = "shortcut_" .. biz_type .. "_icon",
      id = biz_type,
      ios_icon_url = sc_params.ios_icon_url,
      ios_gen_url = sc_params.ios_gen_url,
      biz_type = biz_type,
      page_type = EVS.Type.WebView
    }
    EVS.add_shortcut(params, cb, option)
  else
    E.LOG.debug(TAG, "add_shortcut_webview config is not ready or error")
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_CONFIG_NOT_READY, "add_shortcut_webview config is not ready or error")
  end
end

local function wv_event_callback(biz_type, even_name, is_open)
  local callbacks = callback_maps[biz_type] or {}
  if callbacks.on_js_callback and type(callbacks.on_js_callback) == "function" then
    callbacks.on_js_callback({
      args = {
        type = even_name,
        params = {
          biz_type = biz_type,
          is_open = is_open,
          from = "lua"
        }
      }
    })
  end
end

function M.open_shortcut_webview(biz_type, _params, _option, _on_callbacks)
  E.LOG.d(TAG, "open_shortcut_webview >>")
  if not biz_type then
    E.LOG.debug(TAG, "open_shortcut_webview biz_type is nil")
    return
  end
  _params = _params or {}
  local from_source_data = _params.from_source_data
  last_from_source_data_map[biz_type] = from_source_data or {}
  if from_source_data and from_source_data.open_type == "live_floater" or current_event ~= Live.LIVE_EVENT.ON_LIVE_DESTROY then
    E.LOG.debug(TAG, "need destroy live first, state:" .. tostring(current_event))
    is_opening_before_destroy_live = true
    Live.destroy()
  end
  local hide_event_hander
  
  function hide_event_hander(_value)
    if _value and _value.hideArgs == "backkey" then
      local sc_webview = sc_webview_maps[biz_type]
      if sc_webview then
        sc_webview:sync_data("is_show", false)
      end
      wv_event_callback(biz_type, biz_type .. "_hide", false)
    end
    ejoysdk_topic.unsubscribe("webview_hide", hide_event_hander)
  end
  
  ejoysdk_topic.subscribe("webview_hide", hide_event_hander)
  if nil ~= sc_webview_maps[biz_type] then
    local sc_webview = sc_webview_maps[biz_type]
    if sc_webview:can_hide() then
      M.show_shortcut_webview(biz_type, from_source_data)
      wv_event_callback(biz_type, biz_type .. "_show", true)
      return
    else
      sc_webview:remove_hide_cache()
      sc_webview_maps[biz_type] = nil
    end
  end
  local local_params = _params.local_params
  local sc_params = get_config_from_cc_h5res(biz_type)
  local url
  if sc_params and sc_params.url then
    url = sc_params.url
  elseif local_params and local_params.url then
    E.LOG.debug(TAG, "open_shortcut_webview config is not ready or error, use local config")
    url = local_params.url
  end
  if not url and _params and _params.default_url then
    url = _params.default_url
  end
  if url then
    local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    local opt_params = {}
    if is_overseas then
      if _params.language then
        opt_params.language = _params.language
      else
        local language = E.CONFIG.get_config("lang")
        if language and #language > 0 then
          opt_params.language = language
        end
      end
      local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
      if publish_area and #publish_area > 0 then
        opt_params.publish_area = publish_area
      end
      if _params.h5debug then
        opt_params.h5debug = _params.h5debug
      end
    end
    local prepare_data = {}
    if local_params then
      prepare_data = LAST_WV_STORAGE:get() or {}
      if not prepare_data.startupData then
        prepare_data.startupData = {}
      end
      prepare_data.startupData.from_source = local_params.from_source
      if is_overseas then
        local last_opt_params = LAST_WV_SHORTCUT_OPTS:get() or {}
        opt_params.language = opt_params.language or last_opt_params.language
        opt_params.publish_area = opt_params.publish_area or last_opt_params.publish_area
        url = E.HTTP.url_query(url, opt_params)
      end
    else
      prepare_data.startupData = {}
      prepare_data.startupData.from_source = biz_type
      if is_overseas then
        url = E.HTTP.url_query(url, opt_params)
        LAST_WV_SHORTCUT_OPTS:set(opt_params)
      end
    end
    if from_source_data then
      prepare_data.startupData.from_source_data = from_source_data
    end
    if last_floater_startup_data and next(last_floater_startup_data) then
      local prepare_frame = prepare_data.startupData.frame
      if not prepare_frame or not next(prepare_frame) then
        prepare_data.startupData.frame = last_floater_startup_data.frame
      end
    end
    local callbacks = callback_maps[biz_type] or {}
    if _on_callbacks then
      callbacks = _on_callbacks
    end
    local ori_close_callback = callbacks.on_close_callback
    local on_close_callback
    
    function on_close_callback(_value)
      if ori_close_callback then
        ori_close_callback(_value)
      end
      sc_webview_maps[biz_type] = nil
    end
    
    callbacks.on_close_callback = on_close_callback
    if callbacks.on_live_callback then
      subscribe_webview_live_floater(biz_type, callbacks.on_live_callback)
    end
    local injection = {}
    if url and type(url) == "string" then
      local host_object = E.HTTP.parse(url)
      if host_object and host_object.host then
        local end_host = string.match(host_object.host, "^[%w%-]+(.*)")
        end_host = end_host or host_object.host
        E.LOG.debug(TAG, "inject host:" .. tostring(end_host))
        injection[end_host] = {
          startupData = prepare_data.startupData or {}
        }
      end
    end
    local webview_id = biz_type or uuid()
    local params = {
      webview_id = webview_id,
      injection = injection,
      from_source = "shortcut",
      language = opt_params.language,
      publish_area = opt_params.publish_area
    }
    if not _option or not next(_option) then
      _option = {}
      _option.screen_orientation = "portrait"
      _option.use_fragment = false
    end
    last_floater_startup_data = {}
    _option.enable_auto_media_playback = true
    _option.disable_auto_fontsize = true
    _option.disable_fill_fallback_url = true
    if _ejoysdk.os() == "windows" then
      _option.draggable = true
      _option.show_title = true
      _option.nonmodal_window = true
      _option.enable_multi_instance = true
      if _option.nonmodal_window_frame == nil then
        _option.nonmodal_window_frame = {dx = 20, dy = 20}
        if biz_type == M.Type.Site then
          _option.nonmodal_window_frame.width = DEFAULT_SITE_FRAME_WIDTH
          _option.nonmodal_window_frame.height = DEFAULT_SITE_FRAME_HEIGHT
        end
      end
    end
    if local_params and local_params.from_source == "shortcut" then
      _option.backkey_action = "exit"
      _option.hide_close_btn = true
      if not M.disable_fast_open and _ejoysdk.os() == "android" then
        if sc_params and sc_params.use_fragment then
          _option.use_fragment = true
        end
        _option.enable_loading = false
      end
      if sc_params and sc_params.shortcut_ext_options and type(sc_params.shortcut_ext_options) == "table" then
        for ext_k, ext_v in pairs(sc_params.shortcut_ext_options) do
          if type(ext_k) == "string" then
            _option[ext_k] = ext_v
          end
        end
      end
    elseif biz_type == M.Type.Community or biz_type == M.Type.Site then
      _option.backkey_action = "hide"
      if sc_params and sc_params.ext_options and "table" == type(sc_params.ext_options) then
        for ext_k, ext_v in pairs(sc_params.ext_options) do
          if type(ext_k) == "string" then
            _option[ext_k] = ext_v
          end
        end
      end
    end
    local sc_webview = WVMI:New(url, params, _option, callbacks)
    sc_webview_maps[biz_type] = sc_webview
    sc_webview:open()
    wv_event_callback(biz_type, biz_type .. "_show", true)
    local url_offline_code = E.Utils.url_clipping(url)
    if url_offline_code then
      ejoysdk_topic.subscribe(ejoysdk_topic.lightboat.RES_UPDATE_FINISH_PREFIX .. tostring(url_offline_code), dispath_offline_res_update)
    end
    if is_overseas and not _sub_lang_changed_handler then
      ejoysdk_topic.subscribe(ejoysdk_topic.config.CONFIG_CHANGED .. "_lang", function(_new_lang)
        M.lang_changed_handler(biz_type, _new_lang)
      end)
      _sub_lang_changed_handler = true
    end
  else
    E.LOG.debug(TAG, "open failed, config url is not ready")
    if local_params and local_params.from_source == "shortcut" then
      M.start_game()
    end
  end
end

function M.open_from_webview(biz_type, params, _option, cb)
  if params and type(params) ~= "table" then
    E.LOG.debug(TAG, "invalid params")
    if cb then
      cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "invalid params")
    end
    return
  end
  if M.is_opened_biz(biz_type) then
    E.LOG.debug(TAG, "already open " .. tostring(biz_type))
    if cb then
      cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_CONFIG_CAN_IGNORE, "already open " .. tostring(biz_type))
    end
    return
  end
  if E.WebView.is_opened() then
    local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
    EWB.hide_all_web()
    E.Timer.once(1, function()
      M.open_shortcut_webview(biz_type, params, _option)
      if cb then
        cb(true)
      end
    end)
  else
    M.open_shortcut_webview(biz_type, params, _option)
    if cb then
      cb(true)
    end
  end
end

function M.open(biz_type, url, _params, _option, _on_callbacks)
  E.LOG.d(TAG, "open >>")
  if not biz_type or not url then
    E.LOG.debug(TAG, "open failed, biz_type or url is nil")
    return
  end
  _params = _params or {}
  local from_source_data = _params.from_source_data
  last_from_source_data_map[biz_type] = from_source_data or {}
  if from_source_data and from_source_data.open_type == "live_floater" or current_event ~= Live.LIVE_EVENT.ON_LIVE_DESTROY then
    E.LOG.debug(TAG, "need destroy live first, state:" .. tostring(current_event))
    is_opening_before_destroy_live = true
    Live.destroy()
  end
  local hide_event_hander
  
  function hide_event_hander(_value)
    if _value and _value.hideArgs == "backkey" then
      local sc_webview = sc_webview_maps[biz_type]
      if sc_webview then
        sc_webview:sync_data("is_show", false)
      end
      wv_event_callback(biz_type, biz_type .. "_hide", false)
    end
    ejoysdk_topic.unsubscribe("webview_hide", hide_event_hander)
  end
  
  ejoysdk_topic.subscribe("webview_hide", hide_event_hander)
  if nil ~= sc_webview_maps[biz_type] then
    local sc_webview = sc_webview_maps[biz_type]
    if sc_webview:can_hide() then
      M.show_shortcut_webview(biz_type, from_source_data)
      wv_event_callback(biz_type, biz_type .. "_show", true)
      return
    else
      sc_webview:remove_hide_cache()
      sc_webview_maps[biz_type] = nil
    end
  end
  local local_params = _params.local_params
  local prepare_data = {}
  if local_params then
    prepare_data = LAST_WV_STORAGE:get() or {}
    if not prepare_data.startupData then
      prepare_data.startupData = {}
    end
    prepare_data.startupData.from_source = local_params.from_source
  else
    prepare_data.startupData = {}
    prepare_data.startupData.from_source = biz_type
  end
  if from_source_data then
    prepare_data.startupData.from_source_data = from_source_data
  end
  local callbacks = callback_maps[biz_type] or {}
  if _on_callbacks then
    callbacks = _on_callbacks
  end
  local ori_close_callback = callbacks.on_close_callback
  local on_close_callback
  
  function on_close_callback(_value)
    if ori_close_callback then
      ori_close_callback(_value)
    end
    sc_webview_maps[biz_type] = nil
  end
  
  callbacks.on_close_callback = on_close_callback
  if callbacks.on_live_callback then
    subscribe_webview_live_floater(biz_type, callbacks.on_live_callback)
  end
  local injection = {}
  if url and type(url) == "string" then
    local host_object = E.HTTP.parse(url)
    if host_object and host_object.host then
      local end_host = string.match(host_object.host, "^[%w%-]+(.*)")
      end_host = end_host or host_object.host
      E.LOG.debug(TAG, "inject host:" .. tostring(end_host))
      injection[end_host] = {
        startupData = prepare_data.startupData or {}
      }
    end
  end
  local webview_id = biz_type or uuid()
  local params = {
    webview_id = webview_id,
    injection = injection,
    from_source = "shortcut"
  }
  _option = _option or {}
  _option.screen_orientation = _option.screen_orientation or "portrait"
  _option.use_fragment = _option.use_fragment or false
  if _option.enable_auto_media_playback == nil then
    _option.enable_auto_media_playback = true
  end
  if nil == _option.disable_auto_fontsize then
    _option.disable_auto_fontsize = true
  end
  if _ejoysdk.os() == "windows" then
    if nil == _option.draggable then
      _option.draggable = true
    end
    if nil == _option.show_title then
      _option.show_title = true
    end
    if nil == _option.nonmodal_window then
      _option.nonmodal_window = true
    end
    if nil == _option.nonmodal_window_frame then
      _option.nonmodal_window_frame = {dx = 20, dy = 20}
    end
    _option.enable_multi_instance = true
  end
  if local_params and local_params.from_source == "shortcut" then
    _option.backkey_action = "exit"
    _option.hide_close_btn = true
  else
    _option.backkey_action = "hide"
  end
  local sc_webview = WVMI:New(url, params, _option, callbacks)
  sc_webview_maps[biz_type] = sc_webview
  sc_webview:open()
  wv_event_callback(biz_type, biz_type .. "_show", true)
  local url_offline_code = E.Utils.url_clipping(url)
  if url_offline_code then
    ejoysdk_topic.subscribe(ejoysdk_topic.lightboat.RES_UPDATE_FINISH_PREFIX .. tostring(url_offline_code), dispath_offline_res_update)
  end
end

function M.start_game()
  local SCV = require("ejoysdk_lua.vendors.shortcut")
  SCV.start_game_activity()
end

function M.show_shortcut_webview(biz_type, _params)
  local sc_webview = sc_webview_maps[biz_type]
  if sc_webview then
    sc_webview:show(_params)
  else
    _params = _params or {}
    if not E.WebView.is_opened() then
      E.WebView.show(_params)
    end
  end
end

function M.hide_shortcut_webview(biz_type)
  local sc_webview = sc_webview_maps[biz_type]
  if sc_webview then
    if sc_webview:can_hide() then
      sc_webview:hide()
    else
      M.close_shortcut_webview(biz_type)
    end
  else
    E.WebView.hide({webview_id = biz_type})
  end
  reset_local_config()
end

function M.close_shortcut_webview(biz_type)
  local sc_webview = sc_webview_maps[biz_type]
  if sc_webview then
    sc_webview:close()
    sc_webview_maps[biz_type] = nil
  else
    E.WebView.close()
  end
  reset_local_config()
end

function M.reload(biz_type)
  local sc_webview = sc_webview_maps[biz_type]
  if sc_webview then
    sc_webview:reload()
  else
    E.WebView.reload()
  end
end

function M.remove_hide_cache(biz_type)
  local sc_webview = sc_webview_maps[biz_type]
  if sc_webview then
    sc_webview:remove_hide_cache()
    sc_webview_maps[biz_type] = nil
  else
    E.WebView.remove_hide_cache({})
  end
end

function M.get_webview(biz_type)
  return sc_webview_maps[biz_type]
end

function M.call_js(biz_type, js_script, is_fallback)
  local sc_webview = sc_webview_maps[biz_type]
  if sc_webview then
    sc_webview:call_js(js_script)
  elseif is_fallback then
    E.WebView.call_js(js_script)
  end
end

function M.is_opened_biz(biz_type)
  local sc_webview = sc_webview_maps[biz_type]
  if sc_webview then
    if _ejoysdk.os() == "windows" then
      local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
      local VCheck = require("ejoysdk_lua.ejoysdk_version_check")
      local check_result = VCheck.compare_versions(sdk_version, "2.6.0")
      if tonumber(check_result) >= 0 then
        local ACT_WEBVIEW_IS_OPENED = "is_opened"
        do return sc_webview.operator, sc_webview, ACT_WEBVIEW_IS_OPENED end
        return sc_webview.operator, sc_webview, ACT_WEBVIEW_IS_OPENED, {webview_id = biz_type}
      end
    end
    do return sc_webview.is_opened end
    return sc_webview.is_opened, sc_webview, VCheck.compare_versions(sdk_version, "2.6.0"), "is_opened", sc_webview.operator, sc_webview, ACT_WEBVIEW_IS_OPENED, {webview_id = biz_type}
  end
  return false
end

function M.is_support_shortcut(biz_type)
  local sc_params = get_config_from_cc_h5res(biz_type)
  if sc_params and sc_params.disable_shortcut then
    return false
  end
  do return end
  return EVS.is_support_shortcut
end

function M.get_from_source_data(biz_type)
  local last_from_source_data = last_from_source_data_map[biz_type] or {}
  do return e_utils.deepcopy end
  return e_utils.deepcopy, last_from_source_data
end

function M.get_preload_config(biz_type)
  local pre_config = get_local_preload_config(biz_type)
  return pre_config
end

function M.set_from_source_data(biz_type, from_source_data)
  last_from_source_data_map[biz_type] = e_utils.deepcopy(from_source_data)
end

function M.save_shortcut_webview_data()
  local EW = require("ejoysdk_lua.ejoysdk_web")
  local injections = {}
  EW.fill_injection_with_common_params(injections, {})
  local local_startup_data
  for _host, sub_injection in pairs(injections) do
    if sub_injection.startupData then
      local_startup_data = sub_injection.startupData
      break
    end
  end
  if local_startup_data and local_startup_data.tokens then
    local_startup_data.last_tokens = local_startup_data.tokens
  elseif injections.host_common_data then
    local_startup_data.last_tokens = injections.host_common_data.tokens
    local_startup_data.tokens = injections.host_common_data.tokens
    local_startup_data.common_params = injections.host_common_data.common_params
  end
  local params = {startupData = local_startup_data}
  LAST_WV_STORAGE:set(params)
end

function M.clear_shortcut_webview_data()
  LAST_WV_STORAGE:delete()
  for _biz_type, sc_webview in pairs(sc_webview_maps or {}) do
    if M.is_opened_biz(_biz_type) and sc_webview then
      if _ejoysdk.os() == "windows" then
        local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
        local VCheck = require("ejoysdk_lua.ejoysdk_version_check")
        local check_result = VCheck.compare_versions(sdk_version, "2.6.0")
        if tonumber(check_result) >= 0 then
          local ACT_WEBVIEW_CLOSE = "close"
          sc_webview:operator(ACT_WEBVIEW_CLOSE, {webview_id = _biz_type})
        else
          sc_webview:close()
        end
      else
        sc_webview:close()
      end
      sc_webview_maps[_biz_type] = nil
    end
  end
  for k, v in pairs(sc_webview_maps) do
    v:remove_hide_cache()
    E.LOG.debug(TAG, "move hide cache: " .. tostring(k))
  end
  sc_webview_maps = {}
  if current_event ~= Live.LIVE_EVENT.ON_LIVE_DESTROY then
    Live.destroy()
  end
  reset_local_config()
end

function M.handle_offline_res_udpate(url_code, _res_config_data)
  if sc_webview_maps then
    local found_biz_type
    for biz_type_key, sc_wv in pairs(sc_webview_maps) do
      local biz_url = sc_wv:get_url()
      local url_offline_code = E.Utils.url_clipping(biz_url)
      if url_code and url_offline_code and url_code == url_offline_code then
        if sc_wv:is_opened() then
          E.LOG.debug(TAG, "sc_webview res offline code:" .. tostring(url_code) .. " update in next open")
          sc_wv:disable_hide(true)
        elseif E.WebView.is_opened() then
          E.LOG.debug(TAG, "sc_webview res offline code:" .. tostring(url_code) .. " update in next open, other wv is open")
          sc_wv:disable_hide(true)
        else
          E.LOG.debug(TAG, "sc_webview res code:" .. tostring(url_code) .. " update")
          found_biz_type = biz_type_key
          sc_wv:remove_hide_cache()
        end
      end
    end
    if found_biz_type then
      sc_webview_maps[found_biz_type] = nil
    end
  end
end

local function auth_listener(succ, ...)
  if succ then
    E.LOG.debug(TAG, "-------gangplank login success-------")
  else
    local code, message = ...
    E.LOG.debug(TAG, "code: " .. code .. " ,message: " .. message)
  end
end

ejoysdk_topic.subscribe(ejoysdk_topic.gangplank.LOGOUT, function()
  local EC = require("ejoysdk_lua.ejoysdk_config")
  if not EC.has_vendor_config("shortcut") then
    E.LOG.debug(TAG, "gangplank logout and clear shortcut data")
    M.clear_shortcut_webview_data()
  end
end)
local LAST_SCLIVE_STORAGE = E.LazyKeyStore:New("LAST_SCLIVE_STORAGE", false, true, false)

function M.save_last_shortcut_live(url, frame, parmas)
  if url and parmas then
    local safe_parmas = {}
    safe_parmas.injectJS = parmas.injectJS
    safe_parmas.create_type = parmas.create_type or ""
    safe_parmas.use_center_per = parmas.use_center_per
    local last_p = {
      url = url,
      frame = frame,
      parmas = safe_parmas,
      timestamp = os.time()
    }
    LAST_SCLIVE_STORAGE:set(last_p)
  end
end

function M.remove_last_shortcut_live()
  local last_p = e_utils.deepcopy(LAST_SCLIVE_STORAGE:get())
  LAST_SCLIVE_STORAGE:delete()
  return last_p
end

function M.init_vm(params, cb)
  local sdk_meta_configs = params or {}
  cb = cb or function()
    E.LOG.debug(TAG, "init_vm cb nil")
  end
  M.DEBUG_OPTIONS.Debug = sdk_meta_configs[M.CONFIG_KEYS.DEBUGGABLE] or false
  if M.DEBUG_OPTIONS.Debug then
    local ELOG = require("ejoysdk_lua.ejoysdk_log")
    local ej_debugable = E.get_ej_debugable()
    ELOG.setup_ej_debugable(ej_debugable)
    if ej_debugable then
      E.open_log(ej_debugable)
    end
  end
  E.LOG.debug(TAG, sdk_meta_configs)
  M.ShortcutEnv = sdk_meta_configs[M.CONFIG_KEYS.SC_ENV] or "release"
  if M.ShortcutEnv == "product" then
    M.ShortcutEnv = "release"
  end
  M.ShortcutGameId = sdk_meta_configs[M.CONFIG_KEYS.SC_GAME_ID] or 0
  M.ProductId = sdk_meta_configs[M.CONFIG_KEYS.GAME_PRODUCT_ID] or nil
  local vm_type = sdk_meta_configs.biz_type or "community"
  local sc_params = get_config_from_cc_h5res(vm_type)
  M.disable_fast_open = true
  local os_str = _ejoysdk.os()
  if "android" == os_str then
    M.disable_fast_open = false
  end
  if sc_params and sc_params.disable_fast_open then
    M.disable_fast_open = true
  end
  local biz_url = sc_params and sc_params.biz_url or sdk_meta_configs.url
  local config_params = {
    open_log = M.DEBUG_OPTIONS.Debug,
    env = M.ShortcutEnv
  }
  ejoysdk_init.config(M.ProductId, config_params)
  local sdk_list = params.sdk_list or {}
  
  local function open_wv_from_shortcut()
    local _params = {
      local_params = {}
    }
    _params.local_params.from_source = "shortcut"
    if sdk_meta_configs.biz_data then
      local JSON = require("ejoysdk_lua.ejoysdk_json")
      local biz_data = JSON.safe_decode(sdk_meta_configs.biz_data)
      if biz_data then
        _params.from_source_data = _params.from_source_data or {}
        _params.from_source_data.biz_data = biz_data
      end
    end
    local callbacks = callback_maps[vm_type] or {}
    
    function callbacks.on_close_callback()
      E.Timer.once(2, function()
        open_wv_from_shortcut()
      end)
    end
    
    if vm_type == M.Type.Site then
      M.open_shortcut_webview(vm_type, _params, nil, callbacks)
      return
    end
    M.open(vm_type, biz_url, _params, nil, callbacks)
  end
  
  local is_wv_opened = false
  ejoysdk_topic.subscribe(ejoysdk_init.SUBSCRIBE_GANGPLANK_INITED, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "init succ")
      Utils.notify(cb, 200, "init succ", {vm = "shortcut"})
      if not is_wv_opened then
        E.LOG.debug(TAG, "open shortcut webview after GANGPLANK_INITED")
        is_wv_opened = true
        open_wv_from_shortcut()
      end
    else
      local code, error_msg = ...
      Utils.notify(cb, -1, error_msg or "init failed", {
        code = code or -1,
        vm = "shortcut"
      })
      E.LOG.warn(TAG, "init failed:" .. tostring(code) .. ", msg:" .. tostring(error_msg))
    end
  end)
  if not M.disable_fast_open then
    ejoysdk_topic.subscribe(ejoysdk_topic.lightboat.INITED, function(...)
      if not is_wv_opened then
        is_wv_opened = true
        E.LOG.debug(TAG, "open shortcut webview after lightboat.INITED")
        open_wv_from_shortcut()
      end
    end)
  end
  local vendors = sdk_list
  ejoysdk_init.gangplank(vendors, {auth_listener = auth_listener})
  ejoysdk_init.init()
end

function M.open_floater_site(biz_type, _params, frame, _on_callbacks)
  E.LOG.d(TAG, "open_floater_site >>")
  if not biz_type then
    E.LOG.debug(TAG, "open_floater_site biz_type is nil")
    return
  end
  _params = _params or {}
  local from_source_data = _params.from_source_data
  last_from_source_data_map[biz_type] = from_source_data or {}
  local sc_params = get_config_from_cc_h5res(biz_type)
  local url
  if sc_params and sc_params.url then
    url = sc_params.url
  end
  if url then
    local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    local opt_params = {}
    if is_overseas then
      if _params.language then
        opt_params.language = _params.language
      else
        local language = E.CONFIG.get_config("lang")
        if language and #language > 0 then
          opt_params.language = language
        end
      end
      local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
      if publish_area and #publish_area > 0 then
        opt_params.publish_area = publish_area
      end
      if _params.h5debug then
        opt_params.h5debug = _params.h5debug
      end
    end
    local prepare_data = {}
    prepare_data.startupData = {}
    prepare_data.startupData.from_source = biz_type
    if is_overseas then
      url = E.HTTP.url_query(url, opt_params)
    end
    if from_source_data then
      prepare_data.startupData.from_source_data = from_source_data
    end
    prepare_data.startupData.isFloater = true
    prepare_data.startupData.frame = frame
    last_floater_startup_data.frame = frame
    local callbacks = callback_maps[biz_type] or {}
    if _on_callbacks then
      callbacks = _on_callbacks
    end
    local ori_close_callback = callbacks.on_close_callback
    local on_close_callback
    
    function on_close_callback(_value)
      if ori_close_callback then
        ori_close_callback(_value)
      end
    end
    
    callbacks.on_close_callback = on_close_callback
    local injection = {}
    if url and type(url) == "string" then
      local host_object = E.HTTP.parse(url)
      if host_object and host_object.host then
        local end_host = string.match(host_object.host, "^[%w%-]+(.*)")
        end_host = end_host or host_object.host
        E.LOG.debug(TAG, "inject host:" .. tostring(end_host))
        injection[end_host] = {
          startupData = prepare_data.startupData or {}
        }
      end
    end
    local params = {
      adjust_size = _params.adjust_size,
      injection = injection,
      draggable = _params.draggable,
      drag_padding = _params.drag_padding
    }
    local FLOATER = require("ejoysdk_lua.webview.floater")
    local target_url = from_source_data.target_url
    if target_url then
      url = url .. "#" .. target_url
    end
    if _ejoysdk.os() == "harmonyos" then
      E.LOG.debug(TAG, "open_floater_site create async with harmonyos")
      FLOATER.create(url, frame, params, function(succ, ...)
        if succ then
          E.LOG.debug(TAG, "open_floater_site create succ")
        else
          local code, msg = ...
          E.LOG.warn(TAG, "open_floater_site create failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
        FLOATER.set_draggable(true)
        FLOATER.show()
      end)
    else
      E.LOG.debug(TAG, "open_floater_site create sync")
      FLOATER.create(url, frame, params)
      FLOATER.set_draggable(true)
      FLOATER.show()
    end
  else
    E.LOG.debug(TAG, "open failed, config url is not ready")
  end
end

return M

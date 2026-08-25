local JSON = require("ejoysdk_lua.ejoysdk_json")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local unpack = unpack or table.unpack
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local LANG = require("ejoysdk_lua.lang.util")
local LUA_FILE = require("ejoysdk_lua.libs.luafile")
local ECC = require("ejoysdk_lua.ejoysdk_constants")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local _TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ios"
local M = {}
local cbs = {}
local cb_id = math.random(1000, 9999)
local global_request_task_tag = math.random(1000, 9999)
local UTDID
M.PLATFORM = {
  OS = "iOS",
  HTTP_UA = "AFNetworking/2.4.5 (iOS; iPhone)"
}
local native_support_functions = {}
local _Private = {}

function M.is_support_function(func_name)
  local cache_result = native_support_functions[func_name]
  if type(cache_result) ~= "nil" then
    return cache_result
  end
  if _ejoysdk[func_name] ~= nil or func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD or func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.DOWNLOAD_SINGLE_POOL or func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.TIMER_FLOAT_INTERVAL then
    native_support_functions[func_name] = true
    return true
  end
  if func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.BATCH_FILE_OPERATION or func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.FILE_DIR_OPERATION then
    local ret = nil ~= _ejoysdk.batch_remove
    native_support_functions[func_name] = ret
    return ret
  end
  if _ejoysdk.is_native_support and _ejoysdk.is_native_support(func_name) then
    _ejoysdk.log("is_native_support:" .. tostring(func_name) .. ", ret: true")
    return true
  end
  native_support_functions[func_name] = false
  _ejoysdk.log("is_support_function failed, func_name = " .. tostring(func_name))
  return false
end

local _life_is_paused = false
_ejoysdk.register_cb("APP_LIFE_CIRCLE_EVENT", function(_cbid, value)
  local result = JSON.decode(value) or {}
  M.log("APP_LIFE_CIRCLE_EVENT ----called:" .. tostring(result.event_name))
  M.log(result)
  if result.event_name == "applicationWillResignActive:" then
    _life_is_paused = true
  elseif result.event_name == "applicationDidBecomeActive:" then
    _life_is_paused = false
  end
  if next(result) ~= nil then
    ET.publish("APP_LIFE_CIRCLE_EVENT", result)
  end
end)

function M.is_paused()
  return _life_is_paused
end

function M.async_call(fn_name, cb, ...)
  local id = cb_id
  cb_id = cb_id + 1
  cbs[id] = cb
  local func = _ejoysdk[fn_name]
  if nil ~= func then
    func(id, ...)
  else
    _ejoysdk.log(fn_name .. " 该函数不存在！！！！！")
  end
  return id
end

function M.async_call_lua_module()
end

function M.async_response_lua_module(_func_id, _callback_params)
end

function M.sync_call(fn_name, ...)
  local func = _ejoysdk[fn_name]
  if nil ~= func then
    do return func, ... end
    return func, ...
  end
  return nil
end

function M.async_call_with_opts(fn_name, opts, cb, ...)
  local id = M.async_call(fn_name, cb, ...)
  if opts and opts.timeout and opts.timeout_cb then
    M.Timer.once(opts.timeout, function()
      if cbs[id] then
        cbs[id] = nil
        opts.timeout_cb()
      end
    end)
  end
  return id
end

local function async_callback(id, ...)
  local cb = cbs[id]
  if cb then
    cbs[id] = nil
    cb(...)
  end
end

_ejoysdk.register_cb("ASYNC_CALL", async_callback)

function M.printl(content)
  M.log({msg = content})
end

local HTTP_EVENT = "HTTP_EVENT"
local http_progress_cbs = {}
local http_progress_tid_cbid_map = {}
local patch_progress_cbs = {}
_ejoysdk.register_cb(HTTP_EVENT, function(cbid, received, total, type, ext, http_ext_params)
  local params = http_progress_cbs[cbid]
  if params then
    if type and "header" == type then
      if ext and ext.headers and params.header_cb then
        params.header_cb(ext.headers)
      end
    elseif -1 == received then
      http_progress_cbs[cbid] = nil
      if params.finish_cb then
        params.finish_cb()
      end
    else
      http_ext_params = http_ext_params or {}
      params.progress(params.url, params.file, received, total, nil, http_ext_params.event_time)
    end
  end
end)
local HTTP = {}
M.HTTP = HTTP

function HTTP.get_headers(url, _params, cb)
  local headers = HTTP.check_and_update_headers({})
  M.async_call("http_get_headers", function(resp)
    if cb then
      cb(JSON.decode(resp))
    end
  end, url, headers)
end

function HTTP.add_cert(ca_name, ca_chunk, cb)
  local function cb_wrap(resp)
    local succ, result = pcall(JSON.decode, resp)
    
    if not succ then
      local error_msg = result
      local stat = require("ejoysdk_lua.ejoysdk_stat")
      stat.stat_action("ios_add_cert", "wrong_type", false, {resp = resp, error_msg = error_msg})
      if cb then
        cb(false)
      end
      return
    elseif cb then
      cb(result.succ)
    end
  end
  
  local optStr = JSON.encode({name = ca_name})
  M.async_call("http_add_cert", cb_wrap, optStr, ca_chunk)
end

function HTTP.add_cert_pin(_host_pattern, _ca_name, _ca_chunk, _cb)
end

local function gen_request_tag()
  local request_tag = global_request_task_tag
  global_request_task_tag = global_request_task_tag + 1
  return "ejoy_http_" .. tostring(request_tag)
end

function HTTP.process_get(url, params, cb)
  params = params or {}
  local headers = params.headers or {}
  local task_id = params.taskId
  if not task_id then
    task_id = gen_request_tag()
    params.taskId = task_id
  end
  local progress = params.progress
  params.progress = nil
  local finish_cb = params.finish_cb
  params.finish_cb = nil
  local header_cb = params.header_cb
  params.header_cb = nil
  local name = "http_get"
  if params.file then
    name = "http_get_file"
    if params.enable_limit_speed and _ejoysdk.http_get_file_limit_speed then
      name = "http_get_file_limit_speed"
    end
    local temp_name = M.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE
    if params.enable_download_range and params.file and M.is_support_function(temp_name) then
      name = temp_name
    end
  end
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local params_str = CJSON.encode(params or {})
  local cbid = M.async_call_with_opts(name, {
    timeout = params.timeout,
    timeout_cb = function()
      cb({status = 0})
    end
  }, function(status, resp_headers, body, http_ext_params)
    resp_headers = HTTP.Header.New(resp_headers)
    local info = {status = status, headers = resp_headers}
    info.body = body
    info.http_ext_params = CJSON.safe_decode(http_ext_params)
    cb(info)
  end, url, headers, params.file, params_str)
  M.HTTP.unregister_progress_cb(task_id)
  if params.file and progress then
    http_progress_cbs[cbid] = {
      url = url,
      file = params.file,
      progress = progress,
      finish_cb = finish_cb,
      header_cb = header_cb
    }
  end
  if task_id then
    http_progress_tid_cbid_map[task_id] = cbid
  end
end

function HTTP.process_post(url, params, content_type, body, cb)
  params = params or {}
  local headers = params.headers or {}
  local safe_params = {}
  safe_params.use_gzip = params.use_gzip or false
  for pkey, pvalue in pairs(params) do
    if pkey and type(pkey) == "string" and pkey:sub(1, 5) == "safe_" and type(pvalue) ~= "function" then
      safe_params[pkey] = pvalue
    end
  end
  local safe_params_str = JSON.encode(safe_params)
  M.async_call_with_opts("http_post", {
    timeout = params.timeout,
    timeout_cb = function()
      cb({status = 0})
    end
  }, function(status, resp_headers, resp_body, http_ext_params)
    resp_headers = HTTP.Header.New(resp_headers)
    local info = {status = status, headers = resp_headers}
    info.body = resp_body
    info.http_ext_params = JSON.safe_decode(http_ext_params)
    cb(info)
  end, url, headers, body, content_type, safe_params_str)
end

function HTTP.process_stop(_task_id_arr, _params, cb)
  if not _task_id_arr or next(_task_id_arr) == nil then
    return
  end
  local _task_id = _task_id_arr[1]
  _params = _params or {}
  _params.task_array = _task_id_arr
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local optionString = CJSON.encode(_params)
  M.async_call("http_stop", cb, _task_id, optionString)
end

function HTTP.unregister_progress_cb(_task_id, rm_async_cb)
  if not _task_id then
    return
  end
  local _cb_id = http_progress_tid_cbid_map[_task_id]
  if not _cb_id then
    return
  end
  http_progress_cbs[_cb_id] = nil
  if rm_async_cb then
    cbs[_cb_id] = nil
  end
  http_progress_tid_cbid_map[_task_id] = nil
end

function HTTP.update_with_config(params)
  local optionString = "{}"
  if params then
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    optionString = CJSON.encode(params)
  end
  M.sync_call("http_update_config", optionString)
end

function HTTP.http_remove_cache()
  M.sync_call("http_remove_cache")
end

function HTTP.http_enable_cache(is_open)
  M.sync_call("http_enable_cache", is_open)
end

local KEYSTORE_KEY = "ejoysdk"
local KeyStore = {}
M.KeyStore = KeyStore

function KeyStore.get(key)
  local store = _ejoysdk.load_from_keychain(KEYSTORE_KEY) or {}
  return store[key]
end

function KeyStore.get_group(access_group)
  if access_group and _ejoysdk.load_from_keychain_group then
    local store = _ejoysdk.load_from_keychain_group(KEYSTORE_KEY, access_group) or {}
    return store
  end
  return nil
end

function KeyStore.set(key, value)
  local store = _ejoysdk.load_from_keychain(KEYSTORE_KEY) or {}
  store[key] = value
  _ejoysdk.save_to_keychain(KEYSTORE_KEY, store)
end

function KeyStore.set_group(key, access_group, value)
  if access_group and _ejoysdk.save_to_keychain_group then
    local store = KeyStore.get_group(access_group) or {}
    store[key] = value
    _ejoysdk.save_to_keychain_group(KEYSTORE_KEY, access_group, store)
  end
end

function KeyStore.delete(key)
  local store = _ejoysdk.load_from_keychain(KEYSTORE_KEY)
  if store then
    store[key] = nil
    _ejoysdk.save_to_keychain(KEYSTORE_KEY, store)
  end
end

function KeyStore.delete_group(key, access_group)
  if access_group and _ejoysdk.save_to_keychain_group then
    local store = KeyStore.get_group(access_group)
    if store then
      store[key] = nil
      _ejoysdk.save_to_keychain_group(KEYSTORE_KEY, access_group, store)
    end
  end
end

function KeyStore.clear()
  _ejoysdk.delete_from_keychain(KEYSTORE_KEY)
end

function KeyStore.clear_group(access_group)
  if access_group and _ejoysdk.delete_from_keychain_group then
    _ejoysdk.delete_from_keychain_group(KEYSTORE_KEY, access_group)
  end
end

function KeyStore.custom_sub_dir(_sub_dir_param)
end

local UnRecoverKeyStore = {}
M.UnRecoverKeyStore = UnRecoverKeyStore

function UnRecoverKeyStore.get(key)
  local store = _ejoysdk.load_from_userdefault(KEYSTORE_KEY) or {}
  return store[key]
end

function UnRecoverKeyStore.set(key, value)
  local store = _ejoysdk.load_from_userdefault(KEYSTORE_KEY) or {}
  store[key] = value
  _ejoysdk.save_to_userdefault(KEYSTORE_KEY, store)
end

function UnRecoverKeyStore.delete(key)
  UnRecoverKeyStore.set(key, nil)
end

function UnRecoverKeyStore.clear()
  _ejoysdk.delete_from_userdefault(KEYSTORE_KEY)
end

local SPRawKeyStore = {}

function SPRawKeyStore.get(_sp_name, key)
  local succ, msg = pcall(_ejoysdk.load_from_userdefault, key)
  if not succ then
    M.log("iOS SPRawKeyStore get value error, key: " .. tostring(key))
    M.log("sdk catch error msg: " .. tostring(msg))
    return nil
  else
    return msg
  end
end

function SPRawKeyStore.set(_sp_name, key, value)
  local succ, msg = pcall(_ejoysdk.save_to_userdefault, key, value)
  if not succ then
    M.log("iOS SPRawKeyStore set value error, key: " .. tostring(key) .. " ,value: " .. tostring(value))
    M.log("sdk catch error msg: " .. tostring(msg))
  end
  return succ
end

function SPRawKeyStore.delete(_sp_name, key)
  _ejoysdk.delete_from_userdefault(key)
end

M.SPRawKeyStore = SPRawKeyStore
local SYNC_WEBVIEW_OPERATOR = "webview_operator"
local ACT_WEBVIEW_GO_BACK = "go_back"
local ACT_WEBVIEW_GO_FORWARD = "go_forward"
local ACT_WEBVIEW_RELOAD = "reload"
local ACT_WEBVIEW_SHOW = "show"
local ACT_WEBVIEW_HIDE = "hide"
local ACT_WEBVIEW_REMOVE_HIDE_CACHE = "remove_hide_cache"
local SYNC_WEBVIEW_REMOVE_CACHE = "webview_remove_cache"
local WebView = {}
M.WebView = WebView

function WebView.open(url, injection, option, on_js_callback, on_close_callback)
  local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
  do return EWB.add_webview, url, injection, option, on_js_callback end
  return EWB.add_webview, url, injection, option, on_js_callback, on_close_callback
end

function WebView.close()
  do return end
  return _ejoysdk.webview_close, nil
end

function WebView.remove_cache(url)
  local ejoysdk_web = require("ejoysdk_lua.ejoysdk_web")
  ejoysdk_web.webview_remove_cache_callback(url)
  local jsonStr = JSON.encode({url = url})
  M.sync_call(SYNC_WEBVIEW_REMOVE_CACHE, jsonStr)
end

function WebView.prepare(_params)
  return false
end

function WebView.go_back()
  local parmas = {type = ACT_WEBVIEW_GO_BACK}
  local parmasString = JSON.encode(parmas)
  return M.sync_call(SYNC_WEBVIEW_OPERATOR, parmasString) or false
end

function WebView.go_forward()
  local parmas = {type = ACT_WEBVIEW_GO_FORWARD}
  local parmasString = JSON.encode(parmas)
  return M.sync_call(SYNC_WEBVIEW_OPERATOR, parmasString) or false
end

function WebView.reload()
  local parmas = {type = ACT_WEBVIEW_RELOAD}
  local parmasString = JSON.encode(parmas)
  M.sync_call(SYNC_WEBVIEW_OPERATOR, parmasString)
end

function WebView.show(params)
  params = params or {}
  local parmasString = JSON.encode({type = ACT_WEBVIEW_SHOW, data = params})
  do return M.sync_call, SYNC_WEBVIEW_OPERATOR end
  return M.sync_call, SYNC_WEBVIEW_OPERATOR, parmasString
end

function WebView.hide(params)
  params = params or {}
  local parmasString = JSON.encode({type = ACT_WEBVIEW_HIDE, data = params})
  do return M.sync_call, SYNC_WEBVIEW_OPERATOR end
  return M.sync_call, SYNC_WEBVIEW_OPERATOR, parmasString
end

function WebView.remove_hide_cache(params)
  params = params or {}
  local parmasString = JSON.encode({type = ACT_WEBVIEW_REMOVE_HIDE_CACHE, data = params})
  do return M.sync_call, SYNC_WEBVIEW_OPERATOR end
  return M.sync_call, SYNC_WEBVIEW_OPERATOR, parmasString
end

function WebView.update_toolbar(toolbar_config)
  local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
  EWB.update_toolbar(toolbar_config)
end

function WebView.update_toolbar_item(params)
  local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
  EWB.update_toolbar_item(params)
end

function WebView.capture(callback)
  M.async_call("webview_capture", function(resp)
    local body = JSON.decode(resp)
    callback(body)
  end)
end

function WebView.is_opened()
  do return end
  return _ejoysdk.webview_is_opened, nil
end

function WebView.is_opened_async(cb)
  cb(WebView.is_opened())
end

function WebView.call_js(script)
  if _ejoysdk.webview_call_js then
    _ejoysdk.webview_call_js(script)
  end
end

function WebView.callback_js(id, message)
  if _ejoysdk.webview_callback_js then
    _ejoysdk.webview_callback_js(id, message)
  end
end

local WEBVIEW_EVENT = "WEBVIEW_EVENT"
local WEBVIEW_JSARGS_EVENT = 0
local WEBVIEW_CLOSE_EVENT = 1
local WEBVIEW_URL_REDIRECT = 2
local WEBVIEW_LIFE_CYCLE_EVENT = 3
local WEBVIEW_LOAD_ERROR = 4
local WEBVIEW_OPEN_APP = 5
_ejoysdk.register_cb(WEBVIEW_EVENT, function(cbid, value)
  value = JSON.safe_decode(value)
  local WE = require("ejoysdk_lua.ejoysdk_webview_event")
  if cbid == WEBVIEW_JSARGS_EVENT then
    if value and value.args then
      if value.args.type == "oauthUri" then
        ET.publish("logindone", value)
      else
        ET.publish("webview_jsargs", value)
      end
    end
  elseif cbid == WEBVIEW_CLOSE_EVENT then
    ET.publish("webview_close", value)
  elseif cbid == WEBVIEW_URL_REDIRECT then
    ET.publish("webview_url_redirect", value)
  elseif cbid == WEBVIEW_LIFE_CYCLE_EVENT then
    ET.publish("webview_life_cycle", value)
    WE.on_page_lifecycle(value)
  elseif cbid == WEBVIEW_LOAD_ERROR then
    WE.on_entry_url_load_error(value)
  elseif cbid == WEBVIEW_OPEN_APP then
    WE.open_app(value)
  end
end)
local url_open_datas = {}
local gangplank_inited = false
local did_register_event = false

function M.get_url_open_datas()
  M.ability_report("get_url_open_datas")
  local last_openurl_data = M.get_last_openurl_data()
  if last_openurl_data and next(last_openurl_data) then
    return last_openurl_data
  else
    return UTILS.deepcopy(url_open_datas) or {}
  end
end

function M.get_last_openurl_data()
  local last_openurl_data_json = M.sync_call("get_last_openurl_data")
  local last_openurl_data = JSON.safe_decode(last_openurl_data_json)
  if last_openurl_data and last_openurl_data.value and next(last_openurl_data.value) then
    do return UTILS.deepcopy end
    return UTILS.deepcopy, {
      last_openurl_data.value
    }, last_openurl_data.value
  else
    return {}
  end
end

local function publish_urlopen(data)
  _ejoysdk.log("url_open, [v2]_app_event_handler, publish_data:" .. JSON.encode(data))
  if data.type and data.type == "handleOpenUniversalLink" then
    ET.publish("urlopen_v2", "universal_link", data)
  else
    ET.publish("urlopen_v2", "url", data)
    if data.url then
      _ejoysdk.log("url_open, _app_event_handler, publish_url:" .. data.url)
      ET.publish("urlopen", data.url)
    end
  end
end

local function init_handler()
  gangplank_inited = true
  if url_open_datas and 0 == #url_open_datas or nil == url_open_datas then
    local ukeystore = M.get_url_data_keystore()
    if ukeystore then
      url_open_datas = ukeystore:get()
      ukeystore:delete()
    end
  end
  if url_open_datas then
    for _, data in pairs(url_open_datas) do
      publish_urlopen(data)
    end
  end
  M.Sysinfo.network_monitor_start()
end

local is_modal_opened = false

local function on_vendor_login_begin()
  _ejoysdk.log("on_vendor_login_begin, login modal opened")
  is_modal_opened = true
end

local function on_vendor_login_end()
  _ejoysdk.log("on_vendor_login_begin, login modal closed")
  is_modal_opened = false
end

local last_network_type

local function register_event()
  if did_register_event then
    return
  end
  did_register_event = true
  ET.subscribe(ET.gangplank.INITED, init_handler)
  ET.subscribe(ET.gangplank.VENDOR_LOGIN_BEGIN, on_vendor_login_begin)
  ET.subscribe(ET.gangplank.VENDOR_LOGIN_END, on_vendor_login_end)
  local APP_EVENT = "APP_EVENT"
  local APP_OPENURL_EVENT = 0
  local APP_ON_STOP_EVENT = 1
  local APP_NETWORK_STATE_CHANGE_EVENT = 10
  local APP_AUDIO_MUTE_CHANGE_EVENT = 11
  local _app_event_handler = {
    [APP_OPENURL_EVENT] = function(obj)
      local data = obj or {}
      if gangplank_inited then
        publish_urlopen(data)
      else
        url_open_datas = url_open_datas or {}
        table.insert(url_open_datas, data)
        local ukeystore = M.get_url_data_keystore()
        if ukeystore then
          ukeystore:set(url_open_datas)
        end
      end
      if data and data.type and data.type == "handleOpenUniversalLink" then
        if data.data and data.data.ejoysdk_debugable then
          M.File.writefile("ejoysdk.debug", "")
        elseif data.data and data.data.ejoysdk_debugdisable then
          M.File.remove("ejoysdk.debug")
        end
      end
    end,
    [APP_ON_STOP_EVENT] = function()
      ET.publish("app_on_stop")
    end,
    [APP_NETWORK_STATE_CHANGE_EVENT] = function(state_info)
      _ejoysdk.log("lua receive network_state_change, type=" .. tostring(state_info.type) .. ", state=" .. tostring(state_info.state))
      local network_type = M.Sysinfo.network_type()
      _ejoysdk.log("get the network type >> " .. tostring(network_type) .. ", and last type >> " .. tostring(last_network_type))
      if nil == last_network_type or network_type ~= last_network_type then
        last_network_type = network_type
        ET.publish("network_state_change", state_info)
      else
        _ejoysdk.log("new network type is same to last network type, do not publish event")
      end
    end,
    [APP_AUDIO_MUTE_CHANGE_EVENT] = function(audio_mute_info)
      _ejoysdk.log("lua receive audio_mute_change, type=" .. tostring(audio_mute_info.type) .. ", is_mute=" .. tostring(audio_mute_info.isMute))
      ET.publish("audio_mute_change", audio_mute_info)
    end
  }
  _ejoysdk.register_cb(APP_EVENT, function(cbid, js_str, chunk)
    local handler = _app_event_handler[cbid]
    if handler then
      local value = JSON.safe_decode(js_str)
      handler(value, chunk)
    end
  end)
end

register_event()

function M.is_support_ejoy_style_alert()
  return true
end

local Modal = {}
M.Modal = Modal

function Modal.open(title, option, cb)
  local optionString = "{}"
  if option then
    optionString = JSON.encode(option)
  end
  
  local function cb_wrapper(...)
    is_modal_opened = false
    if cb then
      cb(...)
    end
  end
  
  is_modal_opened = true
  M.async_call("modal_open", cb_wrapper, title or "Title", optionString)
end

function Modal.close(cb)
  is_modal_opened = false
  cb = cb or function()
  end
  M.async_call("modal_close", cb)
end

function Modal.alert(title, message, cb)
  local option = {
    message = tostring(message),
    buttons = {"确定"}
  }
  
  local function cb_wrap(_index)
    cb()
  end
  
  Modal.open(title, option, cb_wrap)
end

function Modal.confirm(title, message, cb)
  local option = {
    message = tostring(message),
    buttons = {"取消", "确定"}
  }
  
  local function cb_wrap(index)
    cb(0 ~= index)
  end
  
  Modal.open(title, option, cb_wrap)
end

function Modal.is_opened()
  return is_modal_opened
end

local Toast = {}
M.Toast = Toast

function Toast.show(message, option)
  local optionString = "{}"
  if option then
    optionString = JSON.encode(option)
  end
  do return _ejoysdk.toast_open, message or "" end
  return _ejoysdk.toast_open, message or "", optionString
end

function Toast.hide()
  do return _ejoysdk.toast_open, "" end
  return _ejoysdk.toast_open, "", "{}"
end

local Loading = {}
M.Loading = Loading

function Loading.show(params, _cb)
  params = params or {}
  local params_str = JSON.encode(params)
  
  local function cb_wrap(ret)
    if _cb then
      _cb(JSON.decode(ret))
    end
  end
  
  M.async_call("loading_show", cb_wrap, params_str)
end

function Loading.dismiss()
  do return M.async_call end
  return M.async_call, "loading_dismiss"
end

function Loading.is_support_custom()
  do return M.is_support_function end
  return M.is_support_function, ECC.NATIVE_SUPPORT_FUNCTION_NAMES.CUSTOM_LOADING
end

local Sysinfo = {}
M.Sysinfo = Sysinfo

function Sysinfo.idfa()
  do return end
  return _ejoysdk.sysinfo_idfa, nil
end

function Sysinfo.device_id()
  do return end
  return Sysinfo.idfa, nil
end

function Sysinfo.idfv()
  do return end
  return _ejoysdk.sysinfo_idfv, nil
end

function Sysinfo.uuid()
  do return end
  return Sysinfo.idfv, nil
end

local keychain_group_share_name

local function get_keychain_share_group_name()
  if keychain_group_share_name then
    return keychain_group_share_name
  end
  local group_name = M.Sysinfo.package_name()
  local UNI = require("ejoysdk_lua.vendors.unisdk")
  local sdk_infos = UNI.get_sdk_infos()
  local cloud_game = "CLOUD_GAME"
  local cloud_data = sdk_infos[cloud_game]
  if cloud_data and cloud_data.meta_data then
    local meta_data = cloud_data.meta_data
    if meta_data.keychain_share_group then
      group_name = meta_data.keychain_share_group
    end
  end
  keychain_group_share_name = group_name
  return keychain_group_share_name
end

function Sysinfo.utdid()
  if nil == UTDID then
    local utdid_key = "utdid"
    
    local function set_utdid_to_share_group_keychain_func(utdid_value)
      local group_name = get_keychain_share_group_name()
      M.KeyStore.set_group(utdid_key, group_name, utdid_value)
    end
    
    local value = M.KeyStore.get(utdid_key)
    if value and type(value) == "string" and string.len(value) > 0 then
      UTDID = value
      set_utdid_to_share_group_keychain_func(value)
    else
      UTDID = _ejoysdk.sysinfo_utdid()
      if UTDID and type(UTDID) == "string" and string.len(UTDID) > 0 then
        M.KeyStore.set(utdid_key, UTDID)
        set_utdid_to_share_group_keychain_func(UTDID)
      end
    end
  end
  return UTDID or ""
end

function Sysinfo.ds_channel_id()
  if M.CONFIG.get_config(M.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    return ""
  else
    local CONFIG = require("ejoysdk_lua.ejoysdk_config")
    local has_aligames = CONFIG.has_vendor_config("ALIGAMES")
    if has_aligames then
      return "998233"
    end
    return ""
  end
end

function Sysinfo.ds_sub_channel_id()
  return _ejoysdk.sysinfo_sub_channel_id and _ejoysdk.sysinfo_sub_channel_id() or ""
end

function Sysinfo.country()
  if _ejoysdk.sysinfo_country then
    do return end
    return _ejoysdk.sysinfo_country, nil
  else
    return ""
  end
end

function Sysinfo.language()
  if _ejoysdk.sysinfo_apple_languages then
    local apple_languages = _ejoysdk.sysinfo_apple_languages()
    local strs = M.Utils.split_string(apple_languages, "-")
    if strs and #strs > 0 then
      return strs[1] or ""
    end
  end
  return ""
end

function Sysinfo.language_script()
  if _ejoysdk.sysinfo_apple_languages then
    local apple_languages = _ejoysdk.sysinfo_apple_languages()
    local strs = M.Utils.split_string(apple_languages, "-")
    if strs and 3 == #strs then
      return strs[2] or ""
    end
  end
  return ""
end

function Sysinfo.time_zone()
  if _ejoysdk.sysinfo_time_zone then
    do return end
    return _ejoysdk.sysinfo_time_zone, nil
  else
    return ""
  end
end

function Sysinfo.set_audio_category(category)
  _ejoysdk.sysinfo_set_audio_category(category)
end

function Sysinfo.get_audio_category()
  do return end
  return _ejoysdk.sysinfo_audio_category, nil
end

function Sysinfo.set_audio_options(category, mode, options, _fore_active)
  if _ejoysdk.sysinfo_set_audio_options then
    _ejoysdk.sysinfo_set_audio_options(category, mode, options, _fore_active)
  end
end

function Sysinfo.open_url(url)
  do return _ejoysdk.sysinfo_open_url end
  return _ejoysdk.sysinfo_open_url, url
end

function Sysinfo.can_open_url(url)
  do return M.sync_call, "can_open_url" end
  return M.sync_call, "can_open_url", url
end

function Sysinfo.async_can_open_url(url, cb)
  if cb then
    cb(Sysinfo.can_open_url(url))
  end
end

function Sysinfo.battery()
  do return end
  return _ejoysdk.sysinfo_battery, nil
end

local _gyro_proxy, _gyro

local function init_gyro()
  if not _gyro then
    _gyro = require("ejoysdk_lua.ejoysdk_gyroscope")
  end
  return _gyro
end

_gyro_proxy = setmetatable({}, {
  __index = function(_, key)
    return init_gyro()[key]
  end,
  __newindex = function(_, key, value)
    init_gyro()[key] = value
  end
})
Sysinfo.Gyro = _gyro_proxy

function Sysinfo.battery_v2(cb)
  M.async_call("sysinfo_battery_v2", cb)
end

function Sysinfo.battery_ext(_filter, _cb)
end

function Sysinfo.launch_battery()
  do return end
  return _ejoysdk.sysinfo_launch_battery, nil
end

function Sysinfo.network_type()
  do return end
  return _ejoysdk.sysinfo_network_type, nil
end

function Sysinfo.network_type_cache()
  if nil == last_network_type then
    last_network_type = M.Sysinfo.network_type()
  end
  return last_network_type
end

function Sysinfo.network_type_name()
  local res = Sysinfo.network_current_state()
  local net_name = "unknown"
  if 2 == res then
    net_name = "wifi"
  elseif 3 == res then
    net_name = "2g"
  elseif 4 == res then
    net_name = "3g"
  elseif 5 == res then
    net_name = "4g"
  elseif 6 == res then
    net_name = "5g"
  end
  return net_name
end

function Sysinfo.network_current_state()
  local res = M.sync_call("network_current_state") or 0
  return res
end

function Sysinfo.network_current_state_async(cb)
  local net_state = Sysinfo.network_current_state()
  cb({succ = true, state = net_state})
end

function Sysinfo.network_monitor_start()
  M.sync_call("sysinfo_network_monitor_start")
end

function Sysinfo.network_monitor_stop()
  M.sync_call("sysinfo_network_monitor_stop")
end

function Sysinfo.network_ping(_params, _cb)
end

function Sysinfo.network_traceroute(_params, _cb)
end

function Sysinfo.app_name()
  return _ejoysdk.sysinfo_app_name() or ""
end

function Sysinfo.app_version_code()
  do return end
  return _ejoysdk.sysinfo_app_version_code, nil
end

function Sysinfo.app_version_name()
  do return end
  return _ejoysdk.sysinfo_app_version_name, nil
end

function Sysinfo.device_with_android_id()
  do return end
  return M.Sysinfo.utdid, nil
end

function Sysinfo.is_passive_mode()
  return _ejoysdk.is_passive_mode and _ejoysdk.is_passive_mode()
end

local userAgent

function Sysinfo.get_user_agent()
  if not userAgent or "unknown" == userAgent then
    userAgent = M.sync_call("_sysinfo_get_user_agent")
  end
  if not userAgent or "unknown" == userAgent then
    local userAgent_jf = M.sync_call("_sysinfo_get_user_agent_jf")
    if userAgent_jf then
      userAgent = userAgent_jf
    end
  end
  return userAgent
end

local hwMachine

function Sysinfo.hw_machine()
  if not hwMachine then
    hwMachine = M.sync_call("sysinfo_hw_machine")
  end
  return hwMachine
end

function Sysinfo.get_storage_info()
  do return M.sync_call end
  return M.sync_call, "get_storage_info"
end

function Sysinfo.async_get_storage_info(cb)
  if _ejoysdk.async_get_storage_info then
    M.async_call("async_get_storage_info", cb)
  else
    cb(Sysinfo.get_storage_info())
  end
end

function Sysinfo.storage()
  local storage_info = M.Sysinfo.get_storage_info()
  if storage_info then
    local available = storage_info.internal_available_storage_size
    return {availableInternalStorage = available}
  end
  return {}
end

function Sysinfo.async_storage(cb)
  Sysinfo.async_get_storage_info(function(storage_info)
    if storage_info then
      local available = storage_info.internal_available_storage_size
      cb({availableInternalStorage = available})
      return
    end
    cb({})
  end)
end

function Sysinfo.os_version()
  do return end
  return _ejoysdk.sysinfo_os_version, nil
end

function Sysinfo.install_time()
  return ""
end

function Sysinfo.update_time()
  return ""
end

function Sysinfo.screen_width()
  return M.Sysinfo.screen().width
end

function Sysinfo.screen_height()
  return M.Sysinfo.screen().height
end

function Sysinfo.content_size(cb)
  if not cb then
    return
  end
  local width = Sysinfo.screen_width()
  local height = Sysinfo.screen_height()
  cb(width, height)
end

function Sysinfo.model()
  do return end
  return _ejoysdk.sysinfo_model, nil
end

function Sysinfo.machine()
  do return end
  return _ejoysdk.sysinfo_machine, nil
end

function Sysinfo.brand()
  return "Apple"
end

function Sysinfo.package_name()
  do return end
  return _ejoysdk.sysinfo_bundleid, nil
end

function Sysinfo.package_type()
  return -1
end

function Sysinfo.screen()
  do return end
  return _ejoysdk.sysinfo_screen_size, nil
end

function Sysinfo.is_jailbroken()
  do return end
  return _ejoysdk.sysinfo_is_jailbroken, nil
end

function Sysinfo.device_name()
  do return end
  return _ejoysdk.sysinfo_device_name, nil
end

function Sysinfo.launch_time()
  local ret = M.sync_call("sysinfo_launch_time") or 0
  return ret
end

function Sysinfo.launch_time_async(_cb)
end

function Sysinfo.run_time()
  return os.time() * 1000 - Sysinfo.launch_time()
end

function Sysinfo.run_time_async(_cb)
end

function Sysinfo.mobile_info()
  do return end
  return _ejoysdk.sysinfo_mobile_info, nil
end

function Sysinfo.mobile_info_async(cb)
  cb(M.Sysinfo.mobile_info())
end

function Sysinfo.is_vpn_connected()
  if _ejoysdk.is_vpn_connected then
    do return end
    return _ejoysdk.is_vpn_connected, nil
  else
    return false
  end
end

function Sysinfo.get_boot_time()
  do return end
  return _ejoysdk.sysinfo_get_boot_time, nil
end

function Sysinfo.is_app_install(query_scheme)
  if _ejoysdk.can_open_url then
    do return _ejoysdk.can_open_url end
    return _ejoysdk.can_open_url, query_scheme
  else
    return false
  end
end

function Sysinfo.open_app(_package_name)
  return false
end

function Sysinfo.can_resolve_activity(_package_name, _package_activity_name)
  return false
end

function Sysinfo.get_install_time()
  do return end
  return _ejoysdk.sysinfo_get_install_time, nil
end

function Sysinfo.device_idfv()
  do return end
  return _ejoysdk.sysinfo_device_idfv, nil
end

local ejoyExtInfoStr

function Sysinfo.sysinfo_ejoy_ext_info()
  if not ejoyExtInfoStr then
    ejoyExtInfoStr = M.sync_call("sysinfo_ejoy_ext_info")
  end
  return ejoyExtInfoStr
end

local g_screen_scale_ratio = 1.0

function Sysinfo.update_screen_scale_ratio(ratio)
  if ratio < 1 then
    g_screen_scale_ratio = ratio
  end
end

function Sysinfo.cutout()
  local orientation = _ejoysdk.sysinfo_statusbar_orientation()
  local screen_size = _ejoysdk.sysinfo_screen_size()
  local scale = screen_size.scale
  local safe_inset = _ejoysdk.sysinfo_safearea_inset()
  local model = _ejoysdk.sysinfo_model()
  local cutout_height = 0
  if "iPhone X" == model or "iPhone XS" == model or "iPhone XS Max" == model then
    cutout_height = 30 * scale
  elseif "iPhone XR" == model then
    cutout_height = 33 * scale
  end
  local cutout_rect = {
    x = 0,
    y = 0,
    width = 0,
    height = 0
  }
  if 1 == orientation then
    cutout_rect.width = screen_size.width * scale
    cutout_rect.height = cutout_height
  elseif 2 == orientation then
    cutout_rect.y = screen_size.height * scale - cutout_height
    cutout_rect.width = screen_size.width * scale
    cutout_rect.height = cutout_height
  elseif 3 == orientation then
    cutout_rect.width = cutout_height
    cutout_rect.height = screen_size.height * scale
  elseif 4 == orientation then
    cutout_rect.x = screen_size.width * scale - cutout_height
    cutout_rect.width = cutout_height
    cutout_rect.height = screen_size.height * scale
  end
  local result = {
    cutout_rects = {cutout_rect},
    safe_inset = {
      top = safe_inset.top * scale,
      left = safe_inset.left * scale,
      bottom = safe_inset.bottom * scale,
      right = safe_inset.right * scale
    }
  }
  return result
end

function Sysinfo.cutout_async(cb)
  local cutout_info = Sysinfo.cutout()
  if cutout_info.safe_inset then
    cutout_info.safe_inset.top = math.floor(cutout_info.safe_inset.top * g_screen_scale_ratio)
    cutout_info.safe_inset.left = math.floor(cutout_info.safe_inset.left * g_screen_scale_ratio)
    cutout_info.safe_inset.bottom = math.floor(cutout_info.safe_inset.bottom * g_screen_scale_ratio)
    cutout_info.safe_inset.right = math.floor(cutout_info.safe_inset.right * g_screen_scale_ratio)
  end
  if cutout_info.cutout_rects and type(cutout_info.cutout_rects) == "table" then
    for _i, rect in pairs(cutout_info.cutout_rects) do
      rect.x = math.floor(rect.x * g_screen_scale_ratio)
      rect.y = math.floor(rect.y * g_screen_scale_ratio)
      rect.width = math.floor(rect.width * g_screen_scale_ratio)
      rect.height = math.floor(rect.height * g_screen_scale_ratio)
    end
  end
  cb(cutout_info)
end

function Sysinfo.update_cutout(_params)
end

function Sysinfo.get_disk_info_async(cb)
  if cb then
    cb(false, -1, "only windows support")
  end
end

function Sysinfo.cpu_usage(cb)
  M.async_call("sysinfo_cpu_usage", cb)
end

function Sysinfo.cpu_start_monitor()
end

function Sysinfo.cpu_stop_monitor()
end

function Sysinfo.cpu_monitor_enable()
  return false
end

function Sysinfo.memory()
  do return M.sync_call end
  return M.sync_call, "sysinfo_total_memory"
end

function Sysinfo.memory_info()
  return {}
end

function Sysinfo.get_manufacturer()
  return ""
end

function Sysinfo.device_info(types, cb)
  local valid_type_names = {
    cpu = true,
    memory = true,
    battery = true
  }
  local get_type_result = {}
  local get_type_count = 0
  for _, v in pairs(types) do
    if valid_type_names[v] then
      get_type_result[v] = {}
      get_type_count = get_type_count + 1
    end
  end
  if 0 == get_type_count then
    cb(false, "get type count zero")
    return
  end
  local time_out = false
  local async_come_full = false
  local async_come_count = 0
  
  local function check_end()
    if not time_out and async_come_count == get_type_count then
      async_come_full = true
      cb(true, get_type_result)
    end
  end
  
  M.Timer.once(3, function()
    if not async_come_full then
      cb(true, get_type_result)
    end
    time_out = true
  end)
  for k, _ in pairs(get_type_result) do
    if "cpu" == k then
      Sysinfo.cpu_usage(function(ret)
        async_come_count = async_come_count + 1
        if ret and ret.succ == true then
          get_type_result.cpu = ret
        end
        check_end()
      end)
    elseif "memory" == k then
      Sysinfo.memory_detail(function(ret)
        async_come_count = async_come_count + 1
        if ret then
          get_type_result.memory = ret
        end
        check_end()
      end)
    elseif "battery" == k then
      Sysinfo.battery_v2(function(ret)
        async_come_count = async_come_count + 1
        if ret then
          get_type_result.battery = ret
        end
        check_end()
      end)
    end
  end
end

function Sysinfo.memory_detail(cb)
  M.async_call("sysinfo_memory", cb)
end

function Sysinfo.get_cpu_model()
  return nil
end

function Sysinfo.get_cpu_max_freq()
  return -1
end

function Sysinfo.get_cpu_cores_count()
  do return M.sync_call end
  return M.sync_call, "sysinfo_cores_count"
end

function Sysinfo.sysinfo_ios_app_on_mac()
  do return M.sync_call end
  return M.sync_call, "sysinfo_ios_app_on_mac"
end

function Sysinfo.get_gpu_info(cb)
  cb({})
end

function Sysinfo.manifest_meta_data(type, key)
  return ""
end

function Sysinfo.is_support_hardware_info()
  if _ejoysdk.sysinfo_cores_count and _ejoysdk.sysinfo_total_memory then
    return true
  else
    return false
  end
end

function Sysinfo.get_ejoy_referer()
  return nil
end

function Sysinfo.get_hardware_info(cb)
  M.ability_report("get_hardware_info")
  if not Sysinfo.is_support_hardware_info() then
    cb({})
    return
  end
  local hardware_info = {
    cpu = {
      model = nil,
      core_num = Sysinfo.get_cpu_cores_count(),
      max_freq = nil
    },
    gpu = {},
    memory = {
      total_size = Sysinfo.memory()
    },
    model = Sysinfo.hw_machine(),
    brand = Sysinfo.brand()
  }
  if hardware_info.memory.total_size and hardware_info.memory.total_size > 0 then
    hardware_info.memory.total_size = hardware_info.memory.total_size / 1000000
  end
  if cb then
    cb(hardware_info)
  end
end

function Sysinfo.get_audio_mute_info(cb)
  if cb then
    M.async_call("sysinfo_audio_mute_info", function(js_str)
      if not js_str then
        cb(true, -1, "native error")
        return
      end
      local ret = JSON.safe_decode(js_str)
      if ret then
        cb(true, ret)
      else
        cb(false, -1, "json decode error")
      end
    end)
  end
end

function Sysinfo.start_listen_audio_mute()
  M.sync_call("start_listen_audio_mute")
end

function Sysinfo.stop_listen_audio_mute()
  M.sync_call("stop_listen_audio_mute")
end

function Sysinfo.is_audio_mute_listen_open()
  do return M.sync_call end
  return M.sync_call, "is_audio_mute_listen_open"
end

function Sysinfo.get_screen_refresh_rate(cb)
  M.async_call("get_screen_refresh_rate", function(temp)
    if temp and not temp.device_rate_max and temp.frame_rate_max then
      temp.device_rate_max = temp.frame_rate_max
    end
    if cb then
      cb(temp)
    end
  end)
end

function Sysinfo.go_to_app_market()
end

function Sysinfo.oaid()
  return nil
end

function Sysinfo.oaid_async(cb)
  if cb then
    cb(nil)
  end
end

function Sysinfo.get_device_system()
  return "ios"
end

function Sysinfo.get_device_system_version()
  do return end
  return Sysinfo.os_version, nil
end

function Sysinfo.get_device_type()
  return nil
end

function Sysinfo.restart_self()
  return false
end

function Sysinfo.install_app(_path, cb)
  if cb then
    cb(false, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
  end
end

function Sysinfo.launch_process(_path)
  return nil, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support"
end

function Sysinfo.is_process_exists(_process_info)
  return false
end

function Sysinfo.kill_process(_process_info)
  return false, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT
end

function Sysinfo.launch_process_and_exit_self(_path)
  return false, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support"
end

local Timer = {}
M.Timer = Timer

function Timer.once(interval, cb)
  M.async_call("timer_once", cb, interval)
end

function M.tick(once)
  register_event()
  local tick = _ejoysdk.tick_nopcall or _ejoysdk.tick
  repeat
    local result = {
      tick()
    }
    local cb_type = result[1]
    if not cb_type then
      return false
    elseif type(cb_type) == "string" then
      local cb = _ejoysdk.get_register_cb(cb_type)
      if cb then
        table.remove(result, 1)
        cb(unpack(result))
      end
    end
  until true == once
  return true
end

local _FileBatch = {}
local _FileCompat = {}
do
  local is_support_batch = M.is_support_function(ECC.NATIVE_SUPPORT_FUNCTION_NAMES.BATCH_FILE_OPERATION)
  _ejoysdk.log("ios load with support batch:" .. tostring(is_support_batch))
  local File
  if is_support_batch then
    File = _FileBatch
  else
    File = {}
  end
  setmetatable(File, {__index = _FileCompat})
  M.File = File
end

local function get_doc_path()
  local paths = _ejoysdk.sysinfo_paths()
  return paths.document_path
end

local cache_ext_stg_dir
_Private.sys_dirs = nil

function _FileCompat.get_sys_dirs()
  if _Private.sys_dirs then
    return _Private.sys_dirs
  end
  local paths = _ejoysdk.sysinfo_paths()
  _Private.sys_dirs = paths
  return paths
end

function _FileCompat.get_ext_file_dir()
  if cache_ext_stg_dir and "" ~= cache_ext_stg_dir then
    return cache_ext_stg_dir
  end
  local paths = _ejoysdk.sysinfo_paths()
  cache_ext_stg_dir = paths.document_path
  return cache_ext_stg_dir
end

function _FileCompat.writefile(filename, filedata, append, is_b64)
  local paths = _ejoysdk.sysinfo_paths()
  local file_path = paths.document_path .. "/" .. filename
  local EU = require("ejoysdk_lua.res.ejoy_http_res_utils")
  local parent_path = EU.get_parent_folder(file_path)
  M.File.make_dirs(parent_path)
  if true == is_b64 then
    local succ, data = pcall(_ejoysdk_crypt.base64decode, filedata)
    if true == succ then
      filedata = data
    else
      filedata = nil
    end
  end
  if not filedata then
    _ejoysdk.log("writefile error!!! invalid data")
    return false
  end
  local file, error, append_value
  if true == append then
    file, error = io.open(file_path, "ab")
    append_value = 1
  else
    file, error = io.open(file_path, "wb")
    append_value = 0
  end
  if not file then
    _ejoysdk.log("writefile error!!! path = " .. tostring(file_path))
    _ejoysdk.log("error = " .. tostring(error))
    do return _FileCompat.writefile_fullpath, file_path, filedata end
    return _FileCompat.writefile_fullpath, file_path, filedata, append_value
  end
  file:write(filedata)
  file:close()
  return true, file_path
end

function _FileCompat.writefile_fullpath(filepath, filedata, append, is_b64)
  if type(append) == "boolean" then
    if append then
      append = 1
    else
      append = 0
    end
  elseif type(append) == "nil" then
    append = 0
  end
  if true == is_b64 then
    local succ, data = pcall(_ejoysdk_crypt.base64decode, filedata)
    if true == succ then
      filedata = data
    else
      filedata = nil
    end
  end
  if not filedata then
    _ejoysdk.log("writefile error!!! invalid data")
    return false
  end
  M.sync_call("writefile", filepath, filedata, append)
  return true, filepath
end

function _FileCompat.readfile_fullpath(filename)
  if not filename then
    return nil
  end
  local ret = M.sync_call("read_file", filename)
  return ret
end

function _FileCompat.readfile(filename, from_bundle)
  local ret
  local doc_path = _FileCompat.get_ext_file_dir()
  local path = string.format("%s/%s", doc_path, filename)
  if from_bundle then
    ret = _ejoysdk.lread(filename)
  else
    ret = M.sync_call("read_file", path)
  end
  return ret
end

function _FileCompat.process_exists(path)
  local exists = LUA_FILE.exists(path)
  return exists
end

function _FileCompat.process_is_directory(_file_path)
  return false
end

function _FileCompat.process_remove(file_path)
  M.sync_call("remove_files", -1, file_path)
  local exists = _FileCompat.process_exists(file_path)
  if exists then
    return false, ECC.EJOY_LIB_ERROR.FILE_REMOVE_FILE_FAILED, "remove file fail"
  end
  return true
end

function _FileCompat.process_batch_remove(list, cb)
  list = list or {}
  local list_size = #list
  if 0 == list_size then
    if cb then
      cb(true)
    end
    return
  end
  for _, path in ipairs(list) do
    _FileCompat.process_remove(path)
  end
  if cb then
    cb(true)
  end
end

function _FileCompat.process_copy(src_fullpath, dst_fullpath, opts)
  local succ, code, msg
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  succ, code, msg = LUA_FILE.copy(src_fullpath, dst_fullpath, override)
  return succ, code, msg
end

function _FileCompat.process_batch_copy(map, cb, opts)
  LUA_FILE.batch_src_dst_operation(map, _FileCompat.process_copy, function(succ, code, msg, result_ext)
    if cb then
      cb(succ, code, msg, result_ext)
    end
  end, opts)
end

_FileCompat.sep = "/"

function _FileCompat.join(path)
  do return table.concat, path end
  return table.concat, path, _FileCompat.sep
end

function _FileCompat.dirname(path)
  local dirname = string.gsub(path, "(.*" .. _FileCompat.sep .. ").*", "%1")
  return dirname
end

function _FileCompat.process_rename(src_fullpath, dst_fullpath)
  do return LUA_FILE.rename, src_fullpath end
  return LUA_FILE.rename, src_fullpath, dst_fullpath
end

function _FileCompat.process_batch_rename(map, cb)
  LUA_FILE.batch_rename(map, cb)
end

function _FileCompat.release_bundle_res(src_path, dst_path, cb)
  if src_path and dst_path and "" ~= src_path and "" ~= dst_path then
    local target_path = string.format("%s/%s", get_doc_path(), dst_path)
    M.async_call("release_bundle_res", function(ret)
      if cb then
        cb(JSON.decode(ret))
      end
    end, src_path, target_path)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.unzip(src_path, dst_path, cb)
  if src_path and dst_path and "" ~= src_path and "" ~= dst_path then
    local src_full_path = string.format("%s/%s", get_doc_path(), src_path)
    local target_path = string.format("%s/%s", get_doc_path(), dst_path)
    M.async_call("unzip", function(ret)
      if cb then
        cb(JSON.decode(ret))
      end
    end, src_full_path, target_path)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.unzip_full_path(src_full_path, dst_full_path, cb)
  if src_full_path and dst_full_path and "" ~= src_full_path and "" ~= dst_full_path then
    M.async_call("unzip", function(ret)
      if cb then
        cb(JSON.decode(ret))
      end
    end, src_full_path, dst_full_path)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.zip(src_file_path, file_name, dst_path, cb)
  if src_file_path and dst_path and "" ~= src_file_path and "" ~= dst_path then
    local src_full_path = src_file_path
    local src_file_name = file_name or tostring(os.time())
    local target_path = dst_path
    M.async_call("zip_file", function(ret_str)
      if cb then
        local ret = JSON.safe_decode(ret_str)
        if ret and ret.succ then
          cb(true, ret.data or "")
        else
          cb(false, -1, ret.data or "")
        end
      end
    end, src_full_path, src_file_name, target_path)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.size(src_path, cb)
  if src_path and "" ~= src_path then
    local src_full_path = string.format("%s/%s", get_doc_path(), src_path)
    M.async_call("get_file_size", function(ret)
      if cb then
        cb(JSON.decode(ret))
      end
    end, src_full_path)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.is_support_handling_file_cache()
  if _ejoysdk.unzip and _ejoysdk.release_bundle_res and _ejoysdk.remove_files then
    return true
  else
    return false
  end
end

function _FileCompat.process_make_dirs(dir)
  local ret = M.sync_call("make_dirs", dir)
  ret = ret or {}
  return ret.succ or false
end

function _FileCompat.file_md5(_path)
  local result = M.sync_call("file_md5", _path)
  local code, msg
  if not result then
    code = ECC.EJOY_LIB_ERROR.FILE_MD5_FINISH_FAILED
    msg = "md5 failed"
  end
  return result, code, msg
end

function _FileCompat.process_md5(file_path)
  do return _FileCompat.file_md5 end
  return _FileCompat.file_md5, file_path
end

function _FileCompat.process_batch_md5(file_list, cb)
  file_list = file_list or {}
  local succ_data = {}
  local fail_data = {}
  local last_err_code, last_err_msg
  for _, f in ipairs(file_list) do
    local md5_val, _code, _msg = _FileCompat.process_md5(f)
    if md5_val then
      succ_data[f] = md5_val
    else
      last_err_code = _code
      last_err_msg = _msg
      fail_data[f] = {code = last_err_code, msg = last_err_msg}
    end
  end
  if cb then
    if last_err_code then
      cb(false, last_err_code, last_err_msg, succ_data, fail_data)
    else
      cb(true, succ_data)
    end
  end
end

function _FileCompat.process_batch_info(file_list, cb, _opts)
  LUA_FILE.batch_info(file_list, cb, _opts)
end

function _FileCompat.process_list_directory(_dir_path, _recursive, _cb)
  if _cb then
    _cb(nil)
  end
end

function _FileCompat.process_list_bundle(_dir_path, _recursive, _cb)
  if _cb then
    _cb(nil)
  end
end

function _FileBatch.process_exists(path)
  local exists = M.sync_call("file_exists", path)
  return exists
end

function _FileBatch.process_is_directory(file_path)
  local is_dir = M.sync_call("is_directory", file_path)
  return is_dir
end

function _FileBatch.process_batch_remove(list, cb, opts)
  list = list or {}
  local list_size = #list
  if 0 == list_size then
    if cb then
      cb(true)
    end
    return
  end
  local params = JSON.encode({files = list, opts = opts})
  M.async_call("batch_remove", function(ret)
    local ret_obj = JSON.safe_decode(ret)
    ret_obj = ret_obj or {}
    if cb then
      cb(ret_obj.succ or false, ret_obj.code, ret_obj.msg, ret_obj.result_ext)
    end
  end, params)
end

function _FileBatch.process_copy(src_fullpath, dst_fullpath, opts)
  local succ, code, msg
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  succ, code, msg = M.sync_call("copy_file", src_fullpath, dst_fullpath, override)
  return succ, code, msg
end

function _FileBatch.process_batch_copy(map, cb, opts)
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local params = CJSON.encode({
    files = map,
    need_override = override,
    opts = opts
  })
  M.async_call("batch_copy", function(ret)
    local ret_obj = CJSON.safe_decode(ret)
    ret_obj = ret_obj or {}
    if cb then
      cb(ret_obj.succ, ret_obj.code, ret_obj.msg, ret_obj.result_ext)
    end
  end, params)
end

function _FileBatch.process_batch_rename(map, cb, opts)
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local params = CJSON.encode({files = map, opts = opts})
  M.async_call("batch_rename", function(ret)
    local ret_obj = CJSON.safe_decode(ret)
    ret_obj = ret_obj or {}
    if cb then
      cb(ret_obj.succ, ret_obj.code, ret_obj.msg, ret_obj.result_ext)
    end
  end, params)
end

function _FileBatch.process_batch_md5(file_list, cb, base_path)
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local params = CJSON.encode({files = file_list, base_path = base_path})
  M.async_call("batch_md5", function(ret)
    local ret_obj = CJSON.decode(ret)
    ret_obj = ret_obj or {}
    local result_ext = ret_obj.result_ext or {}
    if cb then
      if ret_obj.succ then
        cb(true, result_ext.succ_data or {})
      else
        cb(false, ret_obj.code, ret_obj.msg, result_ext.succ_data or {}, result_ext.fail_data)
      end
    end
  end, params)
end

function _FileBatch.process_batch_info(file_list, cb, _opts)
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local params_str = CJSON.encode({files = file_list, opts = _opts})
  M.async_call("batch_file_info", function(ret)
    local ret_obj = CJSON.decode(ret) or {}
    local result_ext = ret_obj.result_ext or {}
    if cb then
      local succ_data = result_ext.succ_data or {}
      cb(succ_data)
    end
  end, params_str)
end

function _FileBatch.process_list_directory(dir_path, recursive, cb)
  M.async_call("list_directory", function(ret)
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local ret_obj = CJSON.safe_decode(ret) or {}
    if cb then
      cb(ret_obj)
    end
  end, dir_path, recursive)
end

function _FileBatch.process_list_bundle(dir_path, recursive, cb)
  M.async_call("list_bundle", function(ret)
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local ret_obj = CJSON.safe_decode(ret) or {}
    if cb then
      cb(ret_obj)
    end
  end, dir_path, recursive)
end

local BATCH_SUBMIT_EVENT = "BATCH_SUBMIT_EVENT"
_ejoysdk.register_cb(BATCH_SUBMIT_EVENT, function(_cbid, resp, _chunk)
  if resp and resp.list then
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local list = CJSON.decode(resp.list)
    for _, action_obj in ipairs(list) do
      local cb_type = action_obj.cb_type
      local cb = _ejoysdk.get_register_cb(cb_type)
      if "HTTP_EVENT" == cb_type then
        local cbid = action_obj.cbid
        local recv = action_obj.recv
        local total = action_obj.total
        local type = action_obj.type
        local ext = action_obj.ext
        local http_ext_params = action_obj.http_ext_params
        if cb then
          cb(cbid, recv, total, type, ext, http_ext_params)
        end
      else
        local status = action_obj.status
        local cbid = action_obj.cbid
        local http_ext_params = action_obj.http_ext_params
        if cb then
          cb(cbid, status, nil, nil, http_ext_params)
        end
      end
    end
  end
end)

function HTTP.submit_download_list(list, file_ext, opts, submit_cb, single_cb, single_progress_cb, single_header_cb)
  local submit_cnt = #list
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local id_begin = cb_id
  local id_end = id_begin + submit_cnt - 1
  local list_idx = 1
  for id = id_begin, id_end do
    local item = list[list_idx]
    item.cbid = id
    local item_task_id = item.taskId
    local cb_fun
    
    function cb_fun(status, resp_headers, body, http_ext_params)
      resp_headers = HTTP.Header.New(resp_headers)
      local info = {status = status, headers = resp_headers}
      info.body = body
      info.http_ext_params = http_ext_params
      cbs[id] = nil
      http_progress_cbs[id] = nil
      single_cb(item_task_id, info)
    end
    
    cbs[id] = cb_fun
    http_progress_cbs[id] = {
      url = item.path,
      progress = function(...)
        single_progress_cb(item_task_id, ...)
      end,
      header_cb = function(...)
        single_header_cb(item_task_id, ...)
      end
    }
    http_progress_tid_cbid_map[item_task_id] = id
    list_idx = list_idx + 1
  end
  cb_id = id_end + 1
  local list_str = CJSON.encode(list)
  local dest_file_name = "ejoy_download_temp/_download_submit_list" .. tostring(id_end) .. ".json"
  local write_result = M.File.writefile(dest_file_name, list_str)
  local file_path, list_data
  if write_result then
    file_path = M.Path.join(_FileCompat.get_ext_file_dir(), dest_file_name)
    _ejoysdk.log("submit_download_list use file_path:" .. tostring(file_path))
  else
    list_data = list_str
    _ejoysdk.log("submit_download_list use list cnt:" .. tostring(submit_cnt))
  end
  do return M.async_call, "submit_download_list", function(ret, code, msg)
    local code2, msg2
    if false == ret then
      code2 = code
      msg2 = msg
    end
    _ejoysdk.log("submit_download_list ret:" .. tostring(ret) .. ", code:" .. tostring(code2) .. ", msg:" .. tostring(msg2))
    if submit_cb and type(ret) == "boolean" then
      submit_cb(ret, code2, msg2)
    end
  end end
  return M.async_call, "submit_download_list", function(ret, code, msg)
    local code2, msg2
    if false == ret then
      code2 = code
      msg2 = msg
    end
    _ejoysdk.log("submit_download_list ret:" .. tostring(ret) .. ", code:" .. tostring(code2) .. ", msg:" .. tostring(msg2))
    if submit_cb and type(ret) == "boolean" then
      submit_cb(ret, code2, msg2)
    end
  end, {
    list = list_data,
    file = file_path,
    file_ext = file_ext,
    opts = opts
  }, function(...)
    single_header_cb(item_task_id, ...)
  end
end

function HTTP.update_download_priority(task_id_priority_map, cb)
  _ejoysdk.log("update_download_priority, task_id_priority_map")
  if not task_id_priority_map or next(task_id_priority_map) == nil then
    if cb then
      cb(false, EC.EJOYSDK_ERROR_CODES.PARAMS_INVALID, "task_id_priority_map is nil")
    end
    return
  end
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local params = {task_id_priority_map = task_id_priority_map}
  local params_str = CJSON.encode(params)
  M.async_call("update_download_priority", function(resp)
    local code, msg
    if not resp.ret then
      code = resp.code
      msg = resp.msg
    end
    if cb then
      cb(resp.ret, code, msg)
    end
  end, params_str, "")
end

local Media = {
  DEFAULT_MAX_FILESIZE = 5242880,
  DEFAULT_MAX_DURATION = 60000,
  DEFAULT_SAMPLING_RATE = 16000,
  DEFAULT_ENCODING_BIT_RATE = 16000,
  DEFAULT_BIT_DEPTH_RATE = 16,
  DEFAULT_CHANNEL = 1,
  DEFAULT_AMR_NB_ENCODING_BIT_RATE = 12200,
  DEFAULT_AMR_WB_ENCODING_BIT_RATE = 18250
}
M.Media = Media

function Media.start_record(opt, cb)
  opt = opt or {}
  local max_filesize = Media.DEFAULT_MAX_FILESIZE
  if opt.max_filesize and max_filesize >= opt.max_filesize then
    max_filesize = opt.max_filesize
  end
  local max_duration = Media.DEFAULT_MAX_DURATION
  if opt.max_duration and max_duration >= opt.max_duration then
    max_duration = opt.max_duration
  end
  local trace_volume = opt.volume_cb and true or false
  local params = {
    filename = opt.filename or "noname",
    format = opt.format or "amr",
    max_filesize = max_filesize,
    max_duration = max_duration,
    sampling_rate = opt.sampling_rate or Media.DEFAULT_SAMPLING_RATE,
    encoding_bit_rate = opt.encoding_bit_rate or Media.DEFAULT_ENCODING_BIT_RATE,
    bit_depth_rate = opt.bit_depth_rate or Media.DEFAULT_BIT_DEPTH_RATE,
    channel = opt.channel or Media.DEFAULT_CHANNEL,
    volume_trace_period = opt.volume_trace_period or 200,
    trace_volume = trace_volume
  }
  if params.format == "amr" then
    _ejoysdk.log("params.format sampling_rate: " .. tostring(params.sampling_rate))
    if params.sampling_rate ~= 8000 and params.sampling_rate ~= 16000 then
      error("when format is amr, sampling_rate should be 8000 or 16000")
      return
    end
    if 16 ~= params.bit_depth_rate then
      error("when format is amr, bit_depth_rate should be 16")
      return
    end
    if 1 ~= params.channel then
      error("when format is amr, channel should be 1")
      return
    end
    local constants = require("ejoysdk_lua.ejoysdk_constants")
    if params.sampling_rate == 8000 and not constants.AMR_NB_BIT_RATE[params.encoding_bit_rate] then
      params.encoding_bit_rate = Media.DEFAULT_AMR_NB_ENCODING_BIT_RATE
    end
    if params.sampling_rate == 16000 and not constants.AMR_WR_BIT_RATE[params.encoding_bit_rate] then
      params.encoding_bit_rate = Media.DEFAULT_AMR_WB_ENCODING_BIT_RATE
    end
  end
  
  local function cb_wrap(info, body)
    info = JSON.decode(info)
    cb(info, body)
  end
  
  local optStr = opt and JSON.encode(params)
  M.async_call("media_start_record", cb_wrap, optStr)
end

function Media.stop_record(opt, cb)
  local optStr = opt and JSON.encode(opt) or "{}"
  
  local function cb_wrap(info, body)
    info = JSON.decode(info)
    info.bytes = body
    cb(info)
  end
  
  M.async_call("media_stop_record", cb_wrap, optStr)
end

local MEDIA_PLAY = "MEDIA_PLAY"
local media_play_cbs = {}
_ejoysdk.register_cb(MEDIA_PLAY, function(cbid, _js_str, _chunk)
  local params = media_play_cbs[cbid]
  if params and params.finish_cb then
    params.finish_cb()
    media_play_cbs[cbid] = nil
  end
end)

function Media.start_play(opt, cb)
  opt = opt or {}
  local format = "amr"
  if opt.format ~= "auto" then
    format = opt.format
  end
  local params = {
    filename = opt.filename or "noname",
    format = format,
    audio_category = opt.audio_category,
    volume = opt.volume or 1.0,
    volume_multiplier = opt.volume_multiplier or 1
  }
  
  local function cb_wrap(info, body)
    if cb then
      info = JSON.decode(info)
      cb(info, body)
    end
  end
  
  local optStr = opt and JSON.encode(params)
  local cbid = M.async_call("media_start_play", cb_wrap, optStr)
  media_play_cbs[cbid] = {
    finish_cb = opt.finish_cb
  }
end

function Media.stop_play(opt, cb)
  local optStr = opt and JSON.encode(opt) or "{}"
  
  local function cb_wrap(info, body)
    info = JSON.decode(info)
    cb(info, body)
  end
  
  M.async_call("media_stop_play", cb_wrap, optStr)
end

function Media.delete(opt, cb)
  local optStr = opt and JSON.encode(opt) or "{}"
  
  local function cb_wrap(info, body)
    info = JSON.decode(info)
    cb(info, body)
  end
  
  M.async_call("media_delete", cb_wrap, optStr)
end

function Media.get_record_dir()
  do return end
  return _ejoysdk.media_record_dir, nil
end

function Media.is_support()
  return true
end

local Permission = {}
M.Permission = Permission

function Permission.support_compliance_check()
  if M.sync_call("support_compliance_check") then
    return true
  end
  return false
end

function Permission.async_support_compliance_check(cb)
  if cb then
    cb(M.Permission.support_compliance_check())
  end
end

function Permission.checkPermission(_permission_detail, _cb)
end

function Permission.check_permission_v2(permission, cb)
  local originPermissionName = permission
  if "NSCameraUsageDescription" == permission then
    originPermissionName = "camera"
  elseif "NSPhotoLibraryUsageDescription" == permission or "NSPhotoLibraryAddUsageDescription" == permission then
    originPermissionName = "photo"
  elseif "NSMicrophoneUsageDescription" == permission then
    originPermissionName = "microphone"
  elseif "NSCalendarsUsageDescription" == permission or "NSCalendarsFullAccessUsageDescription" == permission then
    originPermissionName = "calendar_full"
  elseif "NSCalendarsWriteOnlyAccessUsageDescription" == permission then
    originPermissionName = "calendar_write"
  end
  _ejoysdk.log("check_permission_v2 originPermissionName:" .. tostring(originPermissionName))
  local optStr = JSON.encode({permission = originPermissionName})
  
  local function wrap(info)
    _ejoysdk.log("iOS get permission")
    info = JSON.decode(info)
    M.log(info)
    cb(info.succ)
  end
  
  M.async_call("check_permission_v2", wrap, optStr)
end

local handle_on_check_permission_v3 = {}

function Permission.check_permission_v3(options, cb)
  M.log(options)
  if not (options and options.permissions) or not next(options.permissions) then
    cb(true)
    return
  end
  local permission_names = {}
  for permission_name, _ in pairs(options.permissions) do
    table.insert(permission_names, permission_name:lower())
  end
  table.sort(permission_names)
  local total_permission_names = table.concat(permission_names, "-")
  if total_permission_names and #total_permission_names > 0 and handle_on_check_permission_v3[tostring(total_permission_names)] then
    _ejoysdk.log("Permission.check_permission_v3 is already handling for permissions:" .. tostring(total_permission_names) .. ", just cache the cb and return directly.")
    table.insert(handle_on_check_permission_v3[tostring(total_permission_names)], cb)
    return
  end
  handle_on_check_permission_v3[tostring(total_permission_names)] = {}
  local util = require("ejoysdk_lua.ejoysdk_utils")
  local _permissions = {}
  for p, _ in pairs(options.permissions) do
    table.insert(_permissions, p)
  end
  _ejoysdk.log("check_permission_list_v2 begin:")
  M.log(_permissions)
  M.Permission.check_permission_list_v2(_permissions, function(grant_ret, reject_permissions)
    M.log("check_permission_list_v2 ret:" .. tostring(grant_ret))
    M.log(reject_permissions)
    local reject_permission_descs = {}
    reject_permissions = reject_permissions or {}
    for _, rp in ipairs(reject_permissions) do
      reject_permission_descs[rp] = options.permissions[rp]
    end
    if not grant_ret then
      local title, desc = M.Permission.permission_default_description(reject_permission_descs)
      local tempOptions = {
        title = title or "",
        message = desc or "",
        buttons = {
          LANG.getString("cancel", "取消"),
          LANG.getString("setting", "设置")
        },
        permissions = {reject_permission_descs}
      }
      M.Timer.once(0.75, function()
        Permission.show_usage_dialog(tempOptions, function(tempIndex)
          if 1 == tempIndex then
            M.Permission.openSetting()
          end
        end)
        util.safe_call_cb(cb, grant_ret)
        for _, cached_cb in ipairs(handle_on_check_permission_v3[tostring(total_permission_names)]) do
          util.safe_call_cb(cached_cb, grant_ret)
        end
        handle_on_check_permission_v3[tostring(total_permission_names)] = nil
      end)
    else
      util.safe_call_cb(cb, grant_ret)
      for _, cached_cb in ipairs(handle_on_check_permission_v3[tostring(total_permission_names)]) do
        util.safe_call_cb(cached_cb, grant_ret)
      end
      handle_on_check_permission_v3[tostring(total_permission_names)] = nil
    end
  end)
end

function Permission.detect_permission(permission, cb)
  if "notification" == permission then
    M.Permission.check_permission_v2("notification", function(succ)
      local resp = {}
      if succ then
        resp.status = 1
      else
        resp.status = 0
      end
      cb(succ, resp)
    end)
  else
    M.async_call("detect_permission", function(resp, _chunk)
      if cb and resp then
        cb(1 == resp.status, resp)
      end
    end, permission)
  end
end

function Permission.get_requested_permissions()
  return {}
end

function Permission.async_get_requested_permissions(cb)
  if cb then
    cb(M.Permission.get_requested_permissions())
  end
end

function Permission.openSetting(_ext_param)
  local setting_url = "app-settings:"
  if M.Sysinfo.can_open_url(setting_url) then
    M.Sysinfo.open_url(setting_url)
  end
end

function Permission.openApplicationSetting()
  Permission.openSetting()
end

function Permission.show_usage_dialog(options, cb)
  options = options or {}
  if not options.permissions then
    if cb then
      cb(-1)
    end
    return
  end
  options.style = "lingxi"
  if not options.title or not options.message then
    local title, desc = M.Permission.permission_default_description(options.permissions)
    options.title = options.title or title
    options.message = options.message or desc
  end
  options.buttons = options.buttons or {
    LANG.getString("cancel", "取消"),
    LANG.getString("setting", "设置")
  }
  
  local function cb_wrap(index)
    if cb then
      cb(index)
    end
  end
  
  M.Modal.open(options.title, options, cb_wrap)
end

local Sdkinfo = {}
M.Sdkinfo = Sdkinfo

function Sdkinfo.getSDKVersionName(sdkName)
  do return M.sync_call, "sdkinfo_get_version_name" end
  return M.sync_call, "sdkinfo_get_version_name", sdkName
end

function M.qrcode_scan(cb)
  local app_on_mac = M.Sysinfo.sysinfo_ios_app_on_mac()
  if app_on_mac then
    local opt = {
      buttons = {"好"}
    }
    M.Modal.open("扫码登陆功能仅用于手机端~", opt)
    return
  end
  
  local function scan_result_handler(result)
    _ejoysdk.log("ios qrcode_scan result: ")
    M.log(result)
    cb(true, result)
  end
  
  M.async_call("qrcode_scan", scan_result_handler)
end

function M.get_cba_tweleve_info()
  local info = M.sync_call("get_cba_tweleve_info") or "{}"
  local infoTable = JSON.safe_decode(info)
  return infoTable
end

function M.support_save_to_album()
  local ret = M.sync_call("support_save_to_album")
  return ret and true == ret
end

function M.save_to_album(path, need_delete, cb)
  if M.support_save_to_album() then
    M.async_call("save_to_album", function(resp)
      local body = JSON.decode(resp)
      cb(body)
    end, path, tostring(need_delete))
  else
    cb({
      code = -99,
      msg = "保存失败，暂不支持该功能"
    })
  end
end

function M.copy_clipboard(params)
  local ret = M.sync_call("copy_clipboard", JSON.encode(params))
  return {succ = ret}
end

function M.kill_app()
  _ejoysdk.log("kill_app begin")
  _ejoysdk.kill_app()
end

function M.support_app_reviews()
  return true
end

function M.async_support_app_reviews(cb)
  if cb then
    cb(M.support_app_reviews())
  end
end

function M.app_reviews()
  M.ability_report("app_reviews")
  UTILS.appstore_score()
end

function M.comment_app(appId)
  UTILS.appstore_write_comment(appId)
end

local QRCode = {}
M.QRCode = QRCode

function QRCode.gen_bmp(text)
  if _ejoysdk.qrcode_gen_bmp then
    local succ, data = _ejoysdk.qrcode_gen_bmp(text)
    return succ, data
  else
    return false
  end
end

local Calendar = {}
M.Calendar = Calendar

function Calendar.add_event(event_data, cb)
  _ejoysdk.log("calendar add_event received")
  M.log(event_data)
  local params = {action = "add_event", data = event_data}
  local param_str = JSON.encode(params)
  M.async_call("calendar", function(succ, ret)
    if cb then
      local ret_data = JSON.decode(ret) or {}
      if succ then
        _ejoysdk.log("calendar add_event callback received, succ:" .. tostring(succ))
        M.log(ret_data)
        cb(true, ret_data)
      else
        _ejoysdk.log("calendar add_event callback received, succ:" .. tostring(succ) .. ", code:" .. tostring(ret_data.code) .. ", msg:" .. tostring(ret_data.msg))
        cb(false, ret_data.code, ret_data.msg)
      end
    end
  end, param_str)
end

function Calendar.delete_event(event_data, cb)
  _ejoysdk.log("calendar delete_event received")
  M.log(event_data)
  local params = {
    action = "delete_event",
    data = event_data
  }
  local param_str = JSON.encode(params)
  M.async_call("calendar", function(succ, ret)
    if cb then
      local ret_data = JSON.decode(ret) or {}
      if succ then
        _ejoysdk.log("calendar delete_event callback received, succ:" .. tostring(succ))
        M.log(ret_data)
        cb(true, ret_data)
      else
        _ejoysdk.log("calendar delete_event callback received, succ:" .. tostring(succ) .. ", code:" .. tostring(ret_data.code) .. ", msg:" .. tostring(ret_data.msg))
        cb(false, ret_data.code, ret_data.msg)
      end
    end
  end, param_str)
end

function Calendar.update_event(update_data, cb)
  _ejoysdk.log("calendar update_event received")
  M.log(update_data)
  local params = {
    action = "update_event",
    data = update_data
  }
  local param_str = JSON.encode(params)
  M.async_call("calendar", function(succ, ret)
    if cb then
      local ret_data = JSON.decode(ret) or {}
      if succ then
        _ejoysdk.log("calendar update_event callback received, succ:" .. tostring(succ))
        M.log(ret_data)
        cb(true, ret_data)
      else
        _ejoysdk.log("calendar update_event callback received, succ:" .. tostring(succ) .. ", code:" .. tostring(ret_data.code) .. ", msg:" .. tostring(ret_data.msg))
        cb(false, ret_data.code, ret_data.msg)
      end
    end
  end, param_str)
end

function Calendar.query_event(event_info, cb)
  _ejoysdk.log("calendar query_event received")
  M.log(event_info)
  local params = {
    action = "query_event",
    data = event_info
  }
  local param_str = JSON.encode(params)
  M.async_call("calendar", function(succ, ret)
    if cb then
      local ret_data = JSON.decode(ret) or {}
      if succ then
        _ejoysdk.log("calendar query_event callback received, succ:" .. tostring(succ))
        M.log(ret_data)
        cb(true, ret_data)
      else
        _ejoysdk.log("calendar query_event callback received, succ:" .. tostring(succ) .. ", code:" .. tostring(ret_data.code) .. ", msg:" .. tostring(ret_data.msg))
        cb(false, ret_data.code, ret_data.msg)
      end
    end
  end, param_str)
end

function Calendar.query_event_id(event_info, cb)
  _ejoysdk.log("calendar query_event received")
  M.log(event_info)
  local params = {
    action = "query_event_id",
    data = event_info
  }
  local param_str = JSON.encode(params)
  M.async_call("calendar", function(succ, ret)
    if cb then
      local ret_data = JSON.decode(ret) or {}
      if succ then
        _ejoysdk.log("calendar query_event_id callback received, succ:" .. tostring(succ))
        M.log(ret_data)
        cb(true, ret_data)
      else
        _ejoysdk.log("calendar query_event_id callback received, succ:" .. tostring(succ) .. ", code:" .. tostring(ret_data.code) .. ", msg:" .. tostring(ret_data.msg))
        cb(false, ret_data.code, ret_data.msg)
      end
    end
  end, param_str)
end

local Sensor = {}
M.Sensor = Sensor
M.Sensor.TimeThreshold = 300
M.Sensor.SHAKE_EVENT = {
  BEGIN = "SHAKE_BEGIN",
  END = "SHAKE_END",
  CANCEL = "SHAKE_CANCEL"
}
local SHAKE_EVENT = "SHAKE_EVENT"
local shake_cb
_ejoysdk.register_cb(SHAKE_EVENT, function(_cbid, value)
  local result = JSON.decode(value) or {}
  if result and result.event then
    local event = result.event
    _ejoysdk.log("receive shake cb event >> " .. tostring(event))
    if shake_cb then
      shake_cb(event)
    end
  end
end)

function Sensor.set_threshold(threshold)
  if threshold and threshold > 0 then
    M.Sensor.TimeThreshold = threshold
    M.sync_call("set_threshold", M.Sensor.TimeThreshold)
  end
end

function Sensor.is_shake_support()
  local support = M.sync_call("is_shake_support")
  _ejoysdk.log("ret support >> " .. tostring(support))
  return support or false
end

function Sensor.register_shake(cb)
  shake_cb = cb
  M.sync_call("register_shake", M.Sensor.TimeThreshold)
end

function Sensor.unregister_shake()
  shake_cb = nil
  M.sync_call("unregister_shake")
end

function M.get_brightness()
  return M.sync_call("get_brightness") or -1
end

function M.set_brightness(brightness)
  M.sync_call("set_brightness", brightness)
end

function M.reset_brightness()
  M.sync_call("reset_brightness")
end

function M.vibrate(milliseconds)
  M.sync_call("vibrate", milliseconds)
end

function M.is_vibrate_support()
  return M.sync_call("is_vibrate_support") or false
end

function M.set_app_orientation(orientation)
  do return M.sync_call, "set_app_orientation" end
  return M.sync_call, "set_app_orientation", orientation
end

function M.support_webview()
  return true
end

function M.disable_embed_webview()
  return false
end

function M.scroll_log_file(file_name)
  do return M.sync_call, "scroll_log_file" end
  return M.sync_call, "scroll_log_file", file_name or ""
end

function M.flush_log()
  do return M.sync_call end
  return M.sync_call, "flush_log"
end

function M.is_log_file_support()
  return _ejoysdk_lua_cjson ~= nil
end

function M.get_log_file_infos(_params, cb)
  local paramsStr = _params and JSON.encode(_params) or "{}"
  M.async_call("get_log_file_infos", function(ret)
    if cb then
      cb(JSON.decode(ret))
    end
  end, paramsStr)
end

function M.get_current_log_file(_params, cb)
  local paramsStr = _params and JSON.encode(_params) or "{}"
  M.async_call("get_current_log_file", function(ret)
    if cb then
      cb(JSON.decode(ret))
    end
  end, paramsStr)
end

function M.get_ej_debugable()
  local is = M.File.exists("ejoysdk.debug")
  return is
end

function M.get_ej_detail_debuggable()
  local is = M.File.exists("ejoysdk_dl.debug")
  return is
end

function M.switch_to_game()
  return false
end

function M.set_pc_ad_token(_pc_ad_token)
end

function M.get_pc_ad_token()
end

function M.get_pre_order_items(cb)
  cb = cb or function()
  end
  local platform = "ios"
  if M.is_support_function("get_purchase_items") then
    M.async_call("get_purchase_items", function(result)
      local ret = result and JSON.decode(result) or {}
      local succ = ret.succ
      if succ then
        cb(true, platform, ret.data or {})
      else
        cb(false, platform, ret.code or -2, ret.msg or "unknown")
      end
    end)
  else
    cb(false, platform, -1, "not support")
  end
end

function M.get_system_properties(_key, _default_value)
end

_ejoysdk.register_cb("PATCH_EVENT", function(cbid, complete_count, total_count, _chunk)
  local params = patch_progress_cbs[cbid]
  if params and params.progress then
    params.progress(complete_count, total_count)
  end
end)

function M.patch_dir(params, cb, progress_cb)
  local paths = _ejoysdk.sysinfo_paths()
  local bundle_path = paths.bundle_path
  params.resPkgDirPath = M.Path.join(bundle_path, params.resPkgDirPath)
  local optStr = JSON.encode(params)
  local cbid = M.async_call("ejoysdk_patch_dir", function(resp_str)
    local resp = resp_str and JSON.decode(resp_str) or {}
    if 0 == resp.ret then
      cb(true)
    else
      cb(false, resp.ret)
    end
  end, optStr)
  patch_progress_cbs[cbid] = {progress = progress_cb}
end

function M.patch_files(params, cb, progress_cb)
  params = params or {}
  if type(params.oldFilePaths) ~= "table" or "table" ~= type(params.patchFilePaths) or "table" ~= type(params.newFilePaths) or #params.oldFilePaths ~= #params.patchFilePaths or #params.oldFilePaths ~= #params.newFilePaths then
    M.log("patch files params invalid.")
  elseif "table" == type(params.newFileMd5Array) and #params.newFileMd5Array ~= #params.newFilePaths then
    M.log("patch files params invalid. newFileMd5Array size not equal to newFilePaths size")
  else
    if not next(params.patchFilePaths) then
      cb(true)
    else
      local options = (params or {}).options or {}
      local paths = _ejoysdk.sysinfo_paths()
      local bundle_path = paths.bundle_path
      options.resPkgDirPath = M.Path.join(bundle_path, options.resPkgDirPath)
      local optStr = JSON.encode(params)
      local cbid = M.async_call("ejoysdk_patch_files", function(resp_str)
        local resp = resp_str and JSON.decode(resp_str) or {}
        if 0 == resp.ret then
          cb(true)
        else
          cb(false, resp.ret, resp.patch_succ_files, resp.patch_fail_files)
        end
      end, optStr)
      patch_progress_cbs[cbid] = {progress = progress_cb}
    end
    return
  end
  cb(false, EC.PATCH_ERROR.CODE_PARAM_INVALID)
end

function M.check_compatibility()
  return true
end

function M.picker(_params, cb)
  _params = _params or {}
  if (not _params.media_type or _params.media_type == "image") and M.is_support_function("image_picker") then
    M.image_picker(_params.max_select_num, _params, cb)
    return
  end
  if not M.is_support_function("picker") then
    if cb then
      cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
    end
    return
  end
  if _Private.is_picker_processing then
    M.LOG.debug("picker", "picker is processing, return directly")
    if cb then
      cb(false, ECC.BASE_API_COMMON_ERROR.CODE_IN_PROCESSING, "picker is busy")
    end
    return
  end
  _Private.is_picker_processing = true
  local params = {}
  if not _params.compress_quality then
    params.compress_quality = 1.0
  end
  params.media_type = _params.media_type
  params.editable = _params.enable_edit == nil and true or _params.enable_edit
  local paramsStr = params and JSON.encode(params) or "{}"
  M.async_call("picker", function(ret, file_data)
    _Private.is_picker_processing = false
    if cb then
      local ret_tb = JSON.decode(ret) or {}
      ret_tb.data = ret_tb.data or {}
      ret_tb.data.file_data = file_data
      ret_tb.data.size = #file_data
      ret_tb.data.image_path = ret_tb.data.file_path
      local code = ret_tb.code
      if 0 == code then
        cb(true, {
          ret_tb.data
        })
      else
        cb(false, ret_tb.code, ret_tb.msg)
      end
    end
  end, paramsStr)
end

function M.image_picker(max_select_num, _params, cb)
  if not M.is_support_function("image_picker") then
    if cb then
      cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
    end
    return
  end
  if _Private.is_picker_processing then
    M.LOG.debug("image_picker", "image_picker is processing, return directly")
    if cb then
      cb(false, ECC.BASE_API_COMMON_ERROR.CODE_IN_PROCESSING, "image picker is busy")
    end
    return
  end
  _Private.is_picker_processing = true
  local params = {}
  if not max_select_num or type(max_select_num) ~= "number" then
    max_select_num = 1
  elseif max_select_num < 1 then
    max_select_num = 1
  elseif max_select_num > 9 then
    max_select_num = 9
  end
  params.max_select_num = max_select_num
  if not _params or type(_params) ~= "table" then
    _params = {}
  end
  params.enable_edit = _params.enable_edit == nil and true or _params.enable_edit
  local ratio_x = _params.force_clip_ratio_x
  local ratio_y = _params.force_clip_ratio_y
  if ratio_x and ratio_y then
    params.force_clip_ratio = tostring(ratio_x) .. "x" .. tostring(ratio_y)
  end
  params.enable_camera = nil == _params.enable_camera and true or _params.enable_camera
  params.done_btn_text = _params.done_btn_text
  local params_str = JSON.encode(params)
  M.async_call("image_picker", function(ret, images)
    _Private.is_picker_processing = false
    if cb then
      local ret_tb = JSON.decode(ret) or {}
      local code = ret_tb.code
      if 0 == code then
        cb(true, JSON.decode(images) or {})
      else
        cb(false, ret_tb.code, ret_tb.msg, ret_tb.data)
      end
    end
  end, params_str)
end

function M.subscribe_msg(_options, _cb)
  if _cb then
    _cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
  end
end

return M

local JSON = require("ejoysdk_lua.ejoysdk_json")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local LUA_FILE = require("ejoysdk_lua.libs.luafile")
local ECC = require("ejoysdk_lua.ejoysdk_constants")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local unpack = unpack or table.unpack
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "win"
local M = {}
local cbs = {}
local cb_id = math.random(1000, 9999)
local native_support_functions, idfa_cache
local _Private = {}
M.PLATFORM = {
  OS = "Windows",
  HTTP_UA = "libcurl/7.61.0 (Windows; PC)"
}

function M.async_call(fn_name, cb, ...)
  if cb then
    assert(type(cb) == "function", "cb参数必须要是函数类型！！！")
  end
  local id = cb_id
  cb_id = cb_id + 1
  cbs[id] = cb
  local func = _ejoysdk[fn_name]
  if nil ~= func then
    func(id, ...)
  else
    _ejoysdk.log(TAG .. tostring(fn_name) .. " 该函数不存在！！！！！")
  end
  return id
end

function M.async_call_lua_module()
end

function M.async_response_lua_module(_func_id, _callback_params)
end

function M.sync_call(fn_name, ...)
  local func = _ejoysdk[fn_name]
  local value
  if nil ~= func then
    value = func(...)
  end
  return value
end

local Timer = {}
M.Timer = Timer

function Timer.once(interval, cb)
  M.async_call("timer_once", cb, interval)
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

local function _on_async_callback(id, resp, chunk)
  local cb = cbs[id]
  if cb then
    cbs[id] = nil
    cb(resp, chunk)
  end
end

local function async_callback(id, json_str, chunk)
  local cb = cbs[id]
  if cb then
    local resp = JSON.decode(json_str)
    _on_async_callback(id, resp, chunk)
  end
end

local gangplank_inited = false
local did_register_event = false

local function init_handler()
  if false == gangplank_inited then
    gangplank_inited = true
    local WLU = require("ejoysdk_lua.windows_launcher.updater")
    pcall(WLU.cleanup)
  end
end

local function register_event()
  if did_register_event then
    return
  end
  did_register_event = true
  ET.subscribe(ET.gangplank.INITED, init_handler)
end

register_event()
_ejoysdk.register_cb("ASYNC_CALL", async_callback)
local HTTP_EVENT = "HTTP_EVENT"
local http_progress_cbs = {}
local http_progress_tid_cbid_map = {}
local patch_progress_cbs = {}

local function _on_handle_progress_http_event(cbid, resp, http_ext_params)
  local params = http_progress_cbs[cbid]
  if params then
    if resp.type and resp.type == "header" then
      if resp.ext and resp.ext.headers and params.header_cb then
        params.header_cb(resp.ext.headers)
      end
    elseif -1 == resp.received then
      http_progress_cbs[cbid] = nil
      if params.finish_cb then
        params.finish_cb()
      end
    else
      http_ext_params = http_ext_params or {}
      params.progress(params.url, params.file, resp.received, resp.total, nil, http_ext_params.event_time)
    end
  end
end

_ejoysdk.register_cb(HTTP_EVENT, function(cbid, js_str, _chunk)
  local params = http_progress_cbs[cbid]
  if params then
    local resp = JSON.decode(js_str)
    _on_handle_progress_http_event(cbid, resp)
  end
end)

function M.printl(content)
  M.log({msg = content})
end

local HTTP = {}
M.HTTP = HTTP

function HTTP.add_cert(ca_name, ca_chunk, cb)
  local function cb_wrap(resp)
    if type(resp) == "string" then
      resp = JSON.decode(resp)
    end
    local result = resp
    if cb then
      cb(result.succ)
    end
  end
  
  local optStr = JSON.encode({name = ca_name})
  M.async_call("http_add_cert", cb_wrap, optStr, ca_chunk)
end

function HTTP.add_cert_pin(_host_pattern, ca_name, ca_chunk, cb)
  local function cb_wrap(resp)
    if type(resp) == "string" then
      resp = JSON.decode(resp)
    end
    local result = resp
    if cb then
      cb(result.succ)
    end
  end
  
  local optStr = JSON.encode({name = ca_name, host_pattern = _host_pattern})
  M.async_call("http_add_cert_pin", cb_wrap, optStr, ca_chunk)
end

function HTTP.process_get(url, params, cb)
  params = params or {}
  _ejoysdk.log("HTTP GET: " .. url)
  local name = "http_get"
  if params.file then
    name = "http_get_file"
  end
  local headers = params.headers or {}
  local progress = params.progress
  params.progress = nil
  local finish_cb = params.finish_cb
  params.finish_cb = nil
  local header_cb = params.header_cb
  params.header_cb = nil
  local _cbid = M.async_call_with_opts(name, {
    timeout = params.timeout,
    timeout_cb = function()
      cb({status = 0})
    end
  }, function(info, body)
    info.headers = HTTP.Header.New(info.headers)
    info.body = body
    cb(info)
  end, url, headers, params)
  local task_id = params.taskId
  M.HTTP.unregister_progress_cb(task_id)
  if params.file and progress then
    http_progress_cbs[_cbid] = {
      url = url,
      file = params.file,
      progress = progress,
      finish_cb = finish_cb,
      header_cb = header_cb
    }
  end
  if task_id then
    http_progress_tid_cbid_map[task_id] = _cbid
  end
end

function HTTP.process_post(url, params, _content_type, body, cb)
  params = params or {}
  _ejoysdk.log("HTTP POST: " .. url)
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
  }, function(info, resp_body)
    info.headers = HTTP.Header.New(info.headers)
    info.body = resp_body
    cb(info)
  end, url, headers, body, safe_params_str)
end

function HTTP.process_stop(_task_id_arr, params, cb)
  if not _task_id_arr or next(_task_id_arr) == nil then
    cb(false, {})
    return
  end
  local _task_id = _task_id_arr[1]
  params = params or {}
  params.task_id_arr = CJSON.encode(_task_id_arr)
  M.async_call_with_opts("http_stop_file", {}, function(info, body)
    local succ = info.succ
    info.body = body
    cb(succ, info)
  end, _task_id, params)
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

function HTTP.update_with_config(_params)
  _ejoysdk.http_update_download_config(_params)
end

function HTTP.http_remove_cache()
end

function HTTP.http_enable_cache()
end

local KeyStore = {}
local ExtKeyStore = {}
local EXT_DATA_FILE_NAME = "ext_config.dat"
M.KeyStore = KeyStore
ExtKeyStore.data_map = {}

function ExtKeyStore.init(file_name)
  file_name = file_name or EXT_DATA_FILE_NAME
  local data = ExtKeyStore.data_map[file_name]
  if nil == data then
    local ext_data = M.File.readfile(file_name)
    if ext_data then
      local ext_data_json = JSON.decode(ext_data)
      if ext_data_json then
        ExtKeyStore.data_map[file_name] = ext_data_json
        return file_name, ExtKeyStore.data_map[file_name]
      end
    end
    ExtKeyStore.data_map[file_name] = {}
  end
  return file_name, ExtKeyStore.data_map[file_name]
end

function ExtKeyStore.get(key, filename)
  local _, data = ExtKeyStore.init(filename)
  if type(key) == "string" then
    return data[key]
  end
  return nil
end

function ExtKeyStore.set(key, value, filename)
  local data
  filename, data = ExtKeyStore.init(filename)
  if type(key) == "string" then
    data[key] = value
    M.File.writefile(filename, JSON.encode(data), false)
  end
end

function ExtKeyStore.delete(key, filename)
  local data
  filename, data = ExtKeyStore.init(filename)
  if type(key) == "string" then
    data[key] = nil
    M.File.writefile(filename, JSON.encode(data), false)
  end
end

function KeyStore.get(key)
  local get_data = _ejoysdk.keystore_get(key)
  if nil == get_data then
    get_data = ExtKeyStore.get(key)
  end
  M.log("KeyStore.get, key = " .. tostring(key))
  M.log({get_data = get_data})
  M.log("KeyStore.get end")
  return get_data
end

function KeyStore.get_group(_access_group)
  return nil
end

local _MAX_KEYSTORE_VALUE_SIZE = 65536

function KeyStore.set(key, value)
  if nil == value then
    _ejoysdk.log("keystore set skip, value is nil")
    return
  end
  if type(value) == "string" and string.len(value) > _MAX_KEYSTORE_VALUE_SIZE then
    _ejoysdk.log("[warn]data will be writen to ext_config.dat caused oversized value (>64KB)")
    KeyStore.delete(key)
    ExtKeyStore.set(key, value, EXT_DATA_FILE_NAME)
    return
  end
  _ejoysdk.keystore_set(key, value)
end

function KeyStore.set_group(_key, _access_group, _value)
end

function KeyStore.delete(key)
  _ejoysdk.keystore_delete(key)
end

function KeyStore.delete_group(_key, _access_group)
end

function KeyStore.clear()
  _ejoysdk.keystore_clear()
end

function KeyStore.clear_group(_access_group)
end

function KeyStore.custom_sub_dir(sub_dir_param)
  if not sub_dir_param or next(sub_dir_param) == nil then
    _ejoysdk.log("custom_sub_dir sub_dir_param is invalid")
    return
  end
  local sub_dir_param_string = JSON.encode(sub_dir_param)
  _ejoysdk.log("custom_sub_dir:" .. tostring(sub_dir_param_string))
  _ejoysdk.keystore_custom_sub_dir(sub_dir_param_string)
end

M.UnRecoverKeyStore = KeyStore
local SPRawKeyStore = {}

function SPRawKeyStore.get(_sp_name, _key)
  do return ExtKeyStore.get, _key end
  return ExtKeyStore.get, _key, _sp_name
end

function SPRawKeyStore.set(_sp_name, _key, _value)
  ExtKeyStore.set(_key, _value, _sp_name)
end

function SPRawKeyStore.delete(_sp_name, _key)
  ExtKeyStore.delete(_key, _sp_name)
end

M.SPRawKeyStore = SPRawKeyStore
local SYNC_WEBVIEW_OPERATOR = "webview_operator"
local ACT_WEBVIEW_SHOW = "show"
local ACT_WEBVIEW_HIDE = "hide"
local ACT_WEBVIEW_REMOVE_HIDE_CACHE = "remove_hide_cache"
local ACT_WEBVIEW_PREPARE = "prepare"
local WebView = {}
M.WebView = WebView
local disable_embed_webview

function WebView.open(url, injection, option, on_js_callback, on_close_callback)
  option = option or {}
  if disable_embed_webview then
    option.webview_type = "os_browser"
  else
    local CC = require("ejoysdk_lua.ejoysdk_config_center")
    local core_config = CC.get_config(CC.NAMESPACE.EJOYSDK_CORE)
    if core_config and core_config.config then
      local webview_flags = core_config.config.wv_flags
      option.webview_flags = webview_flags or ""
      if core_config.config.collect_webview_log then
        M.Timer.once(15, function()
          local exe_path2 = M.File.get_sys_dirs().program_dir
          local log_file2 = M.File.join({
            exe_path2,
            "webview2.log.zip"
          })
          local LOG_EX_API = require("ejoysdk_lua.server_api.log_collector_ex")
          LOG_EX_API.upload_client_log(log_file2, {
            log_url = url or ""
          }, function(succ, ...)
            if succ then
              M.log("upload webview2.log suc")
            else
              M.log("upload webview2.log fail")
            end
          end)
        end)
      end
    end
  end
  local use_os_browser = false
  if option.webview_type and option.webview_type == "os_browser" then
    use_os_browser = true
  end
  if M.support_webview() and not use_os_browser then
    local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
    do return EWB.add_webview, url, injection, option, on_js_callback end
    return EWB.add_webview, url, injection, option, on_js_callback, on_close_callback, nil, nil, nil
  end
  injection = injection or {}
  if not injection[".ejoy.com"] then
    injection[".ejoy.com"] = {}
  end
  local WU = require("ejoysdk_lua.ejoysdk_web")
  WU.fill_injection_with_common_params(injection, option)
  local JSBridge = require("ejoysdk_lua.ejoysdk_js_bridge")
  JSBridge.init()
  WU.webview_callback_helper(url, option, on_js_callback, on_close_callback)
  local optionString = "{}"
  local succ, msg = pcall(JSON.encode, option)
  if succ then
    optionString = msg
  end
  local injectionString = JSON.encode(injection)
  do return _ejoysdk.webview_open, url, injectionString end
  return _ejoysdk.webview_open, url, injectionString, optionString
end

function WebView.close()
  do return end
  return _ejoysdk.webview_close, nil
end

function WebView.remove_cache(_url)
end

function WebView.is_opened()
  do return end
  return _ejoysdk.webview_is_opened, nil
end

function WebView.is_opened_async(cb)
  cb(WebView.is_opened())
end

function WebView.go_back()
end

function WebView.go_forward()
end

function WebView.reload()
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

function WebView.prepare(_params)
  _params = _params or {}
  local CC = require("ejoysdk_lua.ejoysdk_config_center")
  local core_config = CC.get_config(CC.NAMESPACE.EJOYSDK_CORE)
  if core_config and core_config.config then
    local webview_flags = core_config.config.wv_flags
    _params.webview_flags = webview_flags or ""
  end
  local parmasString = JSON.encode({type = ACT_WEBVIEW_PREPARE, data = _params})
  M.sync_call(SYNC_WEBVIEW_OPERATOR, parmasString)
  return true
end

function WebView.update_toolbar(_toolbar_config)
end

function WebView.update_toolbar_item(_params)
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

function WebView.capture(_callback)
end

local WEBVIEW_EVENT = "WEBVIEW_EVENT"
local WEBVIEW_JSARGS_EVENT = 0
local WEBVIEW_CLOSE_EVENT = 1
local WEBVIEW_URL_REDIRECT = 2
local WEBVIEW_LIFE_CYCLE_EVENT = 3
local WEBVIEW_LOAD_ERROR = 4
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
  end
end)

function M.is_paused()
  return false
end

local Sysinfo = {}
M.Sysinfo = Sysinfo

function Sysinfo.idfa()
  if idfa_cache then
    return idfa_cache
  end
  idfa_cache = M.KeyStore.get("ej_win_ut")
  local from_cache = true
  if not idfa_cache then
    idfa_cache = _ejoysdk.sysinfo_idfa() or ""
    M.KeyStore.set("ej_win_ut", idfa_cache)
    from_cache = false
  end
  _ejoysdk.log("win idfa:" .. tostring(idfa_cache) .. ", is_cache:" .. tostring(from_cache))
  return idfa_cache
end

function Sysinfo.device_id()
  do return end
  return Sysinfo.idfa, nil
end

function Sysinfo.package_name()
  return M.get_pkg_info().pkg_name or ""
end

function Sysinfo.package_type()
  return -1
end

function Sysinfo.app_name()
  do return end
  return Sysinfo.package_name, nil
end

function Sysinfo.os_version()
  if _ejoysdk.sysinfo_os_version then
    return _ejoysdk.sysinfo_os_version() or "windows"
  end
  return "windows"
end

function Sysinfo.install_time()
  if _ejoysdk.sysinfo_install_time then
    local install_time = tonumber(_ejoysdk.sysinfo_install_time())
    if install_time then
      do return math.floor end
      return math.floor, install_time
    end
  end
  return -1
end

function Sysinfo.update_time()
  if _ejoysdk.sysinfo_update_time then
    local update_time = tonumber(_ejoysdk.sysinfo_update_time())
    if update_time then
      do return math.floor end
      return math.floor, update_time
    end
  end
  return -1
end

function Sysinfo.mobile_info()
  return ""
end

function Sysinfo.mobile_info_async(cb)
  cb(M.Sysinfo.mobile_info())
end

function Sysinfo.is_vpn_connected()
  return false
end

function Sysinfo.network_type()
  return 1
end

function Sysinfo.network_type_cache()
  do return end
  return M.Sysinfo.network_type, nil
end

function Sysinfo.network_type_name()
  return "wifi"
end

function Sysinfo.screen_width()
  if _ejoysdk.sysinfo_screen_width then
    return _ejoysdk.sysinfo_screen_width() or -1
  end
  return -1
end

function Sysinfo.screen_height()
  if _ejoysdk.sysinfo_screen_height then
    return _ejoysdk.sysinfo_screen_height() or -1
  end
  return -1
end

function Sysinfo.content_size(cb)
  if not cb then
    return
  end
  local width = Sysinfo.screen_width()
  local height = Sysinfo.screen_height()
  cb(width, height)
end

function Sysinfo.screen()
  local width = Sysinfo.screen_width()
  local height = Sysinfo.screen_height()
  if _ejoysdk.sysinfo_window_size then
    local window_width, window_height = _ejoysdk.sysinfo_window_size()
    return {
      width = width,
      height = height,
      scale = -1,
      window_width = window_width or -1,
      window_height = window_height or -1
    }
  end
  return {
    width = width,
    height = height,
    scale = -1
  }
end

function Sysinfo.si()
  do return end
  return Sysinfo.idfa, nil
end

function Sysinfo.uuid()
  do return end
  return Sysinfo.idfa, nil
end

function Sysinfo.utdid()
  do return end
  return Sysinfo.idfa, nil
end

local computer_info = {model = nil, brand = nil}

function Sysinfo.get_computer_info_async(cb)
  if computer_info and computer_info.model then
    cb(true, computer_info)
  end
  if _ejoysdk.get_computer_info_async then
    M.async_call_with_opts("get_computer_info_async", {}, function(result)
      M.log("get_computer_info_async result")
      M.log(result)
      if result.succ then
        computer_info = {
          model = result.model,
          brand = result.manufacturer
        }
        cb(true, computer_info)
      else
        cb(false, result.code or -1, result.message or "")
      end
    end)
  else
    cb({
      false,
      -1,
      ""
    })
  end
end

function Sysinfo.brand()
  return computer_info.brand or ""
end

function Sysinfo.model()
  return computer_info.model or ""
end

function Sysinfo.time_zone()
  if _ejoysdk.sysinfo_time_zone then
    return _ejoysdk.sysinfo_time_zone() or ""
  else
    return ""
  end
end

function Sysinfo.country()
  if _ejoysdk.sysinfo_country then
    return _ejoysdk.sysinfo_country() or ""
  end
  return ""
end

function Sysinfo.language()
  if _ejoysdk.sysinfo_language then
    return _ejoysdk.sysinfo_language() or ""
  end
  return ""
end

function Sysinfo.language_script()
  return ""
end

local function get_pack_config_version_info()
  local PACK_CONFIG_FILE = "ejoy_pack_config.json"
  local pack_config_content = _ejoysdk.lread(PACK_CONFIG_FILE)
  local pack_config = JSON.safe_decode(pack_config_content)
  if not pack_config then
    return nil
  end
  return {
    version_code = pack_config.version_code,
    version_name = pack_config.version_name
  }
end

local pack_config_version_info = get_pack_config_version_info()

function Sysinfo.app_version_code()
  local C = M.CONFIG
  local app_version_code = C.get_config(C.KEY.WINDOWS_APP_VERSION_CODE)
  if (not app_version_code or 0 == app_version_code) and pack_config_version_info then
    _ejoysdk.log("get sdkconfig version_code is," .. tostring(app_version_code) .. " use pack_config version_code instead: " .. tostring(pack_config_version_info.version_code))
    app_version_code = pack_config_version_info.version_code
  end
  return app_version_code or 0
end

function Sysinfo.app_version_name()
  local sdkinfo = _ejoysdk.sdkinfo()
  local app_version_name = sdkinfo and sdkinfo.app_version
  if not app_version_name and pack_config_version_info then
    _ejoysdk.log("get sdkconfig version_name is," .. tostring(app_version_name) .. " use pack_config version_name instead: " .. tostring(pack_config_version_info.version_name))
    app_version_name = pack_config_version_info.version_name
  end
  return app_version_name or ""
end

function Sysinfo.get_storage_info()
  local disk_total_size = -1
  if _ejoysdk.sysinfo_disk_size then
    disk_total_size = _ejoysdk.sysinfo_disk_size()
  end
  local storage_info = {
    internal_total_storage_size = disk_total_size,
    internal_available_storage_size = -1,
    external_total_storage_size = -1,
    external_available_storage_size = -1
  }
  return storage_info
end

function Sysinfo.async_get_storage_info(cb)
  cb(Sysinfo.get_storage_info())
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
  cb(Sysinfo.storage())
end

function Sysinfo.open_url(url)
  local option = {webview_type = "os_browser"}
  local option_str = JSON.encode(option)
  do return _ejoysdk.sysinfo_open_url, url, "" end
  return _ejoysdk.sysinfo_open_url, url, "", option_str
end

function Sysinfo.can_open_url(_url)
  return true
end

function Sysinfo.install_app(path, cb)
  local pinfo, code, msg = M.Sysinfo.launch_process(path)
  if pinfo then
    _ejoysdk.log("install_app succ path:" .. tostring(path))
    if cb then
      cb(true)
    end
  else
    _ejoysdk.log("install_app failed path:" .. tostring(path) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    if cb then
      cb(false, code, msg)
    end
  end
end

function Sysinfo.restart_self()
  _ejoysdk.log("restart_self received")
  local succ
  if _ejoysdk.restart_self then
    succ = _ejoysdk.restart_self()
    _ejoysdk.log("restart_self ret:" .. tostring(succ))
  else
    _ejoysdk.log("restart_self not support")
    succ = false
  end
  return succ
end

function Sysinfo.launch_process(path)
  if _ejoysdk.launch_process then
    if not path then
      _ejoysdk.log("launch_process failed , path is nil")
      return nil, CONSTANTS.EJOY_LIB_ERROR.PARAMETER_INVALID, "path is nil"
    end
    local exists = M.File.process_exists(path)
    if not exists then
      _ejoysdk.log("launch_process failed, file not exists:" .. tostring(path))
      return nil, CONSTANTS.EJOY_LIB_ERROR.FILE_NOT_EXISTS, "file not exists"
    end
    local pinfo, code, msg = _ejoysdk.launch_process(path)
    return pinfo, code, msg
  else
    return nil, CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support"
  end
end

function Sysinfo.is_process_exists(process_info)
  if _ejoysdk.is_process_running then
    _ejoysdk.log("is_process_running begin:" .. tostring(type(process_info)))
    if not process_info then
      _ejoysdk.log("is_process_running process info is nil")
      return false
    end
    local exists = _ejoysdk.is_process_running(process_info)
    _ejoysdk.log("is_process_running exists:" .. tostring(exists))
    return exists
  else
    _ejoysdk.log("is_process_exists not support")
    return false
  end
end

function Sysinfo.kill_process(process_info)
  _ejoysdk.log("kill_process received")
  local succ, code
  if _ejoysdk.kill_process then
    local process_exists = M.Sysinfo.is_process_exists(process_info)
    if not process_exists then
      _ejoysdk.log("kill_process process_info not exists")
      return false, CONSTANTS.EJOY_LIB_ERROR.PROCESS_NOT_EXISTS
    end
    succ, code = _ejoysdk.kill_process(process_info)
    _ejoysdk.log("kill_process ret:" .. tostring(succ) .. ", code:" .. tostring(code))
  else
    _ejoysdk.log("kill_process not support")
    succ = false
    code = CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT
  end
  return succ, code
end

function Sysinfo.launch_process_and_exit_self(path)
  if _ejoysdk.launch_process_kill_self then
    if not path then
      _ejoysdk.log("launch_process_kill_self failed , path is nil")
      return nil, CONSTANTS.EJOY_LIB_ERROR.PARAMETER_INVALID, "path is nil"
    end
    local exists = M.File.process_exists(path)
    if not exists then
      _ejoysdk.log("launch_process failed, file not exists:" .. tostring(path))
      return nil, CONSTANTS.EJOY_LIB_ERROR.FILE_NOT_EXISTS, "file not exists"
    end
    local succ, code, msg = _ejoysdk.launch_process_kill_self(path)
    return succ, code, msg
  else
    return false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support"
  end
end

function Sysinfo.is_app_install(_app_name)
  return false
end

function Sysinfo.open_app(_package_name)
  return false
end

function Sysinfo.async_can_open_url(_url, cb)
  if cb then
    cb(Sysinfo.can_open_url(_url))
  end
end

function Sysinfo.sysinfo_ejoy_ext_info()
  return ""
end

function Sysinfo.update_screen_scale_ratio(_ratio)
end

function Sysinfo.cutout()
  local result = {
    cutout_rects = {
      {
        x = 0,
        y = 0,
        width = 0,
        height = 0
      }
    },
    safe_inset = {
      top = 0,
      left = 0,
      bottom = 0,
      right = 0
    }
  }
  return result
end

function Sysinfo.cutout_async(cb)
  local cutout_info = Sysinfo.cutout()
  cb(cutout_info)
end

function Sysinfo.update_cutout(_params)
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

local cache_sub_channel_id

function Sysinfo.ds_sub_channel_id()
  if cache_sub_channel_id then
    return cache_sub_channel_id
  end
  if nil == cache_sub_channel_id then
    local config_content = M.File.readfile("ejoysdk_pc_ad.ini")
    if nil ~= config_content then
      local data = JSON.safe_decode(config_content)
      if data and data.sub_channel_id then
        cache_sub_channel_id = data.sub_channel_id
      end
    end
  end
  return cache_sub_channel_id or ""
end

function Sysinfo.get_user_agent()
  return M.PLATFORM.HTTP_UA
end

function Sysinfo.memory()
  local default = {Total = -1}
  if _ejoysdk.sysinfo_memory_size then
    return _ejoysdk.sysinfo_memory_size() or default
  end
  return default
end

function Sysinfo.memory_info()
  local default = {
    TotalPhys = -1,
    TotalVirtual = -1,
    AvailPhys = -1,
    AvailVirtual = -1,
    TotalPageFile = -1,
    AvailPageFile = -1,
    AvailExtendedVirtual = -1,
    Length = -1,
    MemoryLoad = -1
  }
  if _ejoysdk.sysinfo_memory_info then
    return _ejoysdk.sysinfo_memory_info() or default
  end
  return default
end

function Sysinfo.memory_detail(cb)
  M.async_call("sysinfo_memory", cb)
end

function Sysinfo.device_info(types, cb)
  local valid_type_names = {cpu = true, memory = true}
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
    end
  end
end

local cpu_info = {
  model = nil,
  core_num = -1,
  max_freq = -1
}

function Sysinfo.get_cpu_info_async(cb)
  if cpu_info and cpu_info.model then
    cb(true, cpu_info)
    return
  end
  if _ejoysdk.get_cpu_info_async then
    M.async_call_with_opts("get_cpu_info_async", {
      timeout = 3,
      timeout_cb = function()
        cb(false, -1, "get_cpu_info_async timeout")
      end
    }, function(result)
      M.log("get_cpu_info_async result")
      M.log(result)
      if result.succ then
        cpu_info = {
          model = result.model,
          core_num = result.core_num,
          max_freq = result.max_freq
        }
        cb(true, cpu_info)
      else
        cb(false, result.code or -1, result.message or "")
      end
    end)
  else
    cb({
      false,
      -1,
      ""
    })
  end
end

function Sysinfo.get_disk_info_async(cb)
  if _ejoysdk.get_disk_info_async then
    M.async_call_with_opts("get_disk_info_async", {}, function(result)
      M.log("get_disk_info_async result")
      M.log(result)
      if result.succ then
        cb(true, result.disk_info_list)
      else
        cb(false, result.code or -1, result.message or "")
      end
    end)
  else
    cb(false, -1, "native is old version")
  end
end

Sysinfo.get_cpu_info_async(function()
  Sysinfo.get_computer_info_async(function()
  end)
end)

function Sysinfo.get_cpu_model()
  return cpu_info.model
end

function Sysinfo.get_cpu_cores_count()
  return cpu_info.core_num
end

function Sysinfo.get_cpu_max_freq()
  return cpu_info.max_freq
end

function Sysinfo.get_gpu_info(cb)
  if _ejoysdk.get_gpu_info_async then
    local options = {
      timeout = 6,
      timeout_cb = function()
        cb({})
      end
    }
    M.async_call_with_opts("get_gpu_info_async", options, function(result)
      M.log("get_gpu_info_async result")
      M.log(result)
      if result.succ then
        cb(result)
      else
        local error_code = result.code
        local error_message = result.message
        M.log("get_gpu_info fail, code: " .. tostring(error_code) .. " ,message: " .. tostring(error_message))
        cb({})
      end
    end)
  else
    cb({})
  end
end

function Sysinfo.manifest_meta_data(_type, _key)
  return ""
end

function Sysinfo.is_support_hardware_info()
  if _ejoysdk.get_cpu_info_async and _ejoysdk.get_gpu_info_async then
    return true
  else
    return false
  end
end

function Sysinfo.sysinfo_ios_app_on_mac()
  return false
end

function Sysinfo.get_hardware_info(cb)
  M.ability_report("get_hardware_info")
  if not Sysinfo.is_support_hardware_info() then
    cb({})
    return
  end
  local hardware_info = {
    cpu = {},
    gpu = {},
    memory = {
      total_size = Sysinfo.memory()
    },
    model = Sysinfo.model(),
    brand = Sysinfo.brand()
  }
  Sysinfo.get_cpu_info_async(function(succ, ...)
    if succ then
      hardware_info.cpu = (...)
      Sysinfo.get_gpu_info(function(gpu_info)
        hardware_info.gpus = gpu_info.gpus
        cb(hardware_info)
      end)
    else
      cb({})
    end
  end)
end

function Sysinfo.is_passive_mode()
  if _ejoysdk.is_passive_mode then
    local passive_mode_val = _ejoysdk.is_passive_mode()
    if 0 == passive_mode_val then
      return false
    else
      return true
    end
  else
    return nil
  end
end

function Sysinfo.get_manufacturer()
  return ""
end

function Sysinfo.go_to_app_market()
end

function Sysinfo.get_device_system()
  return "windows"
end

function Sysinfo.get_device_system_version()
  do return end
  return Sysinfo.os_version, nil
end

function Sysinfo.get_device_type()
  return "pc"
end

local function table_maxn(t)
  local mn = 0
  for k, _ in pairs(t) do
    if k > mn then
      mn = k
    end
  end
  return mn
end

function M.tick(once)
  repeat
    local result = {
      _ejoysdk.tick()
    }
    local cb_type = result[1]
    if cb_type then
      local cb = _ejoysdk.get_register_cb(cb_type)
      if cb then
        table.remove(result, 1)
        local result_size = table_maxn(result)
        cb(unpack(result, 1, result_size))
      end
    else
      return false
    end
  until true == once
  return true
end

function M.get_url_open_datas()
  return {}
end

function M.get_last_openurl_data()
  return {}
end

local function calculateLineCountUTF8(text, maxCharsPerLine)
  local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
  local utf8 = compat.utf8
  local paragraphs = {}
  for paragraph in text:gmatch([[
([^
]*)
?]]) do
    table.insert(paragraphs, paragraph)
  end
  local totalLines = 0
  for _, para in ipairs(paragraphs) do
    local charCount = utf8.len(para)
    if nil == charCount then
      totalLines = 3
      return totalLines
    elseif 0 == charCount then
      totalLines = totalLines + 1
    else
      totalLines = totalLines + math.ceil(charCount / maxCharsPerLine)
    end
  end
  return totalLines
end

function M.is_support_ejoy_style_alert()
  local ejoysdk_version = M.get_sdk_version_name("EJOYSDK")
  local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
  local support_lingxi_alert = VER_CHECK.compare_versions(ejoysdk_version, "2.6.22") >= 0
  return support_lingxi_alert
end

local is_modal_opened = false
local Modal = {}
M.Modal = Modal

function Modal.alert(title, message, _cb)
  local option = {
    message = tostring(message),
    buttons = {"确定"}
  }
  do return Modal.open, title, option end
  return Modal.open, title, option, _cb
end

function Modal.open(title, option, _cb)
  option = option or {}
  if option and option.type ~= "simple" then
    local ejoysdk_version = M.get_sdk_version_name("EJOYSDK")
    local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
    local support_simple_alert_en = VER_CHECK.compare_versions(ejoysdk_version, "2.5.3.4") >= 0
    local support_simple_alert_zh = VER_CHECK.compare_versions(ejoysdk_version, "2.6.4") >= 0
    if M.is_support_ejoy_style_alert() then
      if not option.messageHeight then
        option.messageHeight = 60
        if option.message then
          local text = option.message
          local succ, total_lines = pcall(calculateLineCountUTF8, text, 25)
          if succ then
            option.messageHeight = total_lines * 20
            if 1 == total_lines then
              option.alignType = "center"
            end
          end
        end
      end
      if not option.buttons then
        local LANG = require("ejoysdk_lua.lang.util")
        local button_text = LANG.getStringSuitCNOverseas("confirm", "")
        option.buttons = {button_text}
      end
    elseif support_simple_alert_zh then
      option.type = "simple"
    elseif support_simple_alert_en then
      if option and option.type ~= "simple" then
        title = option.message
        option.message = nil
      end
      _ejoysdk.log("this PC ejoysdk verion, lua modal.open should do nothing")
    else
      title = option.message
      option.message = nil
    end
  end
  local optionString = JSON.encode(option)
  
  local function cb_wrap(data)
    is_modal_opened = false
    if _cb then
      local index = data.index
      local utils = require("ejoysdk_lua.ejoysdk_utils")
      if option.buttons and type(option.buttons) == "table" and 1 == utils.tablelength(option.buttons) then
        index = 0
      end
      _cb(index)
    end
  end
  
  is_modal_opened = true
  M.async_call("modal_open", cb_wrap, title, optionString)
end

function Modal.close(cb)
  M.async_call("modal_close", function()
  end)
  is_modal_opened = false
  if cb then
    cb()
  end
end

function Modal.is_opened()
  return is_modal_opened
end

function M.is_support_function(func_name)
  if not func_name or "" == func_name then
    _ejoysdk.log("is_support_function failed, func_name invalid")
    return false
  end
  if not _ejoysdk.get_support_functions then
    return false
  end
  if not native_support_functions then
    local data_str = _ejoysdk.get_support_functions()
    native_support_functions = JSON.decode(data_str)
  end
  local ret_type = type(native_support_functions)
  if "table" ~= ret_type then
    _ejoysdk.log("is_support_function failed, ret type invalid:" .. tostring(native_support_functions))
    return false
  end
  if native_support_functions[func_name] or func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD or func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.TIMER_FLOAT_INTERVAL then
    return true
  else
    return false
  end
end

local _FileBatch = {}
local _FileCompat = {}
do
  local is_support_batch = M.is_support_function(ECC.NATIVE_SUPPORT_FUNCTION_NAMES.BATCH_FILE_OPERATION)
  _ejoysdk.log("windows load with support batch:" .. tostring(is_support_batch))
  local File
  if is_support_batch then
    File = _FileBatch
  else
    File = {}
  end
  setmetatable(File, {__index = _FileCompat})
  M.File = File
  M._TEST_FileBatch = _FileBatch
end
local cache_ext_stg_dir

function _FileCompat.get_ext_file_dir()
  if cache_ext_stg_dir and "" ~= cache_ext_stg_dir then
    return cache_ext_stg_dir
  end
  local files = _FileCompat.get_sys_dirs()
  if files then
    cache_ext_stg_dir = files.program_private_dir
  end
  return cache_ext_stg_dir
end

local function get_program_file_dir()
  local sys_dirs = M.File.get_sys_dirs()
  return sys_dirs and sys_dirs.program_dir or _FileCompat.get_ext_file_dir()
end

function _FileCompat.writefile(filename, filedata, append)
  local append_int = 0
  if true == append then
    append_int = 1
  end
  local succ, result = pcall(_ejoysdk.writefile, filename, filedata, append_int)
  if succ then
    return result
  else
    M.log("windows failed to writefile, error: " .. tostring(result))
    return nil
  end
end

function _FileCompat.writefile_fullpath(filename, filedata, append, is_b64)
  if "" == filename or nil == filename then
    _ejoysdk.log("writefile failed, full_path is invalid,")
    return false, ECC.EJOY_LIB_ERROR.PARAMETER_INVALID, "file data invalid"
  end
  if type(append) == "number" then
    if append > 0 then
      append = true
    else
      append = false
    end
  end
  if M.is_support_function(M.NATIVE_SUPPORT_FUNCTION_NAMES.FILE_DIR_OPERATION) then
    local append_int = 0
    if true == append then
      append_int = 1
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
      return false, ECC.EJOY_LIB_ERROR.PARAMETER_INVALID, "file data invalid"
    end
    local is_full_path = 1
    local succ, result = pcall(_ejoysdk.writefile, filename, filedata, append_int, is_full_path)
    if succ then
      if not result then
        result = true
      elseif type(result) == "number" then
        result = result > 0
      end
      return result
    else
      M.log("windows failed to writefile new, error: " .. tostring(result))
      return false
    end
  else
    M.log("not support write full path")
    local E = require("ejoysdk_lua.ejoysdk")
    E.Path.ensure_parent_dir(filename)
    local ret, code, msg = LUA_FILE._do_write_file(filename, filedata, append, is_b64)
    if not ret and _ejoysdk.utf8_to_acp then
      local acp_filename = _ejoysdk.utf8_to_acp(filename)
      ret, code, msg = LUA_FILE._do_write_file(acp_filename, filedata, append, is_b64)
      _ejoysdk.log("write_file acp begin:" .. tostring(acp_filename) .. ", ret:" .. tostring(ret))
    end
    return ret, code, msg
  end
end

function _FileCompat.readfile_fullpath(_filename)
  do return _ejoysdk.lread end
  return _ejoysdk.lread, _filename
end

function _FileCompat.readfile(filename, _from_bundle)
  do return _ejoysdk.lread end
  return _ejoysdk.lread, filename
end

function _FileCompat.process_exists(path)
  local exists
  if _ejoysdk.is_file_exists then
    exists = _ejoysdk.is_file_exists(path)
  else
    exists = LUA_FILE.exists(path)
    if not exists and _ejoysdk.utf8_to_acp then
      local acp_path = _ejoysdk.utf8_to_acp(path)
      exists = LUA_FILE.exists(acp_path)
    end
  end
  return exists
end

function _FileCompat.process_remove(file_path)
  local ret, code, msg
  if _ejoysdk.removefile then
    ret, msg = _ejoysdk.removefile(file_path)
  end
  if not ret then
    ret, code, msg = LUA_FILE.remove(file_path)
  end
  if not ret and _ejoysdk.utf8_to_acp then
    local acp_path = _ejoysdk.utf8_to_acp(file_path)
    ret, code, msg = LUA_FILE.remove(acp_path)
  end
  if ret then
    code = nil
    msg = nil
  end
  return ret, code, msg
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

local function _do_copy(src_fullpath, dst_fullpath, need_override)
  local ret, code, msg
  if _ejoysdk.copy_file then
    ret, code, msg = _ejoysdk.copy_file(src_fullpath, dst_fullpath, need_override)
  else
    ret, code, msg = LUA_FILE.copy(src_fullpath, dst_fullpath, need_override)
    if not ret and _ejoysdk.utf8_to_acp then
      local acp_src_fullpath = _ejoysdk.utf8_to_acp(src_fullpath)
      local acp_dst_fullpath = _ejoysdk.utf8_to_acp(dst_fullpath)
      ret, code, msg = LUA_FILE.copy(acp_src_fullpath, acp_dst_fullpath, need_override)
    end
  end
  if ret then
    code = nil
    msg = nil
  end
  return ret, code, msg
end

function _FileCompat.process_copy(src_fullpath, dst_fullpath, opts)
  opts = opts or {}
  local override = true
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  local ret, code, msg = _do_copy(src_fullpath, dst_fullpath, override)
  return ret, code, msg
end

function _FileCompat.process_batch_copy(map, cb, opts)
  opts = opts or {}
  local override = true
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  
  local function _batch_op(src, dst, _override)
    do return _do_copy, src, dst end
    return _do_copy, src, dst, _override
  end
  
  LUA_FILE.batch_src_dst_operation(map, _batch_op, function(succ, code, msg, result_ext)
    if cb then
      cb(succ, code, msg, result_ext)
    end
  end, override)
end

function _FileCompat.is_support_handling_file_cache()
  return true
end

function _FileCompat.zip(_src_file_path, _file_name, _dst_path, _cb)
end

function _FileCompat.list(_src_path, _dst_path, _cb)
end

function _FileCompat.process_make_dirs(_path)
  if _ejoysdk.make_dirs then
    local result_str = _ejoysdk.make_dirs(_path)
    local result = JSON.decode(result_str)
    local succ = false
    if result then
      succ = result.succ
    end
    _ejoysdk.log("make_dirs, path:" .. tostring(_path) .. ", result:" .. tostring(succ))
    return succ
  else
    _ejoysdk.log("make_dirs")
    local file = io.open(_path, "rb")
    local file_exists = nil ~= file
    if file then
      file:close()
    end
    return file_exists
  end
end

_Private.sys_dirs = nil

function _FileCompat.get_sys_dirs()
  if not _ejoysdk.get_paths then
    _ejoysdk.log("get_sys_dirs get_paths not support")
    return nil
  end
  if _Private.sys_dirs then
    return _Private.sys_dirs
  end
  local path_json_str = _ejoysdk.get_paths()
  local paths = JSON.decode(path_json_str)
  _Private.sys_dirs = paths
  return paths
end

_FileCompat.sep = "\\"

function _FileCompat.join(path)
  do return table.concat, path end
  return table.concat, path, _FileCompat.sep
end

function _FileCompat.dirname(path)
  local dirname = string.gsub(path, "(.*" .. _FileCompat.sep .. ").*", "%1")
  return dirname
end

function _FileCompat.process_rename(src_fullpath, dst_fullpath)
  if _ejoysdk.renamefile then
    do return _ejoysdk.renamefile, src_fullpath end
    return _ejoysdk.renamefile, src_fullpath, dst_fullpath, nil, nil, nil, nil, nil
  end
  local ret, code, msg = LUA_FILE.rename(src_fullpath, dst_fullpath)
  if not ret and _ejoysdk.utf8_to_acp then
    local acp_src_fullpath = _ejoysdk.utf8_to_acp(src_fullpath)
    local acp_dst_fullpath = _ejoysdk.utf8_to_acp(dst_fullpath)
    ret, code, msg = LUA_FILE.rename(acp_src_fullpath, acp_dst_fullpath)
  end
  return ret, code, msg
end

function _FileCompat.process_batch_rename(map, cb)
  LUA_FILE.batch_src_dst_operation(map, _FileCompat.process_rename, function(succ, code, msg)
    if cb then
      cb(succ, code, msg)
    end
  end)
end

function _FileCompat.process_md5(file_path)
  local md5_hex_str, error_code, error_msg
  if _ejoysdk.readfile_offset_length and _ejoysdk.file_length then
    local file_exists = _ejoysdk.is_file_exists(file_path)
    if not file_exists then
      return nil, EC.EJOYSDK_ERROR_CODES.RES_FILE_NOT_EXISTS, "file not exists"
    end
    local real_size = _ejoysdk.file_length(file_path)
    if real_size and real_size > 0 then
      local md5_ud = _ejoysdk_crypt.md5.start_md5c()
      local offset = 0
      local length = 204800
      repeat
        local str = _ejoysdk.readfile_offset_length(file_path, offset, length)
        offset = offset + length
        if str then
          _ejoysdk_crypt.md5.update_md5c(md5_ud, str)
        end
      until not str or real_size <= offset
      local md5_data = _ejoysdk_crypt.md5.finish_md5c(md5_ud)
      if md5_data then
        md5_hex_str = _ejoysdk_crypt.hexencode(md5_data)
      else
        _ejoysdk.log("md5 data is empty for path:" .. tostring(file_path))
        md5_hex_str = nil
        error_code = EC.EJOY_LIB_ERROR.FILE_MD5_FINISH_FAILED
        error_msg = "md5 finish error"
      end
    elseif real_size and 0 == real_size then
      md5_hex_str = "d41d8cd98f00b204e9800998ecf8427e"
    else
      _ejoysdk.log("get file size failed for path:" .. tostring(file_path))
      md5_hex_str = nil
      error_code = EC.EJOY_LIB_ERROR.FILE_SIZE_GET_FAILED
      error_msg = "file size error"
    end
  else
    md5_hex_str, error_code, error_msg = LUA_FILE.md5(file_path)
    if not md5_hex_str and _ejoysdk.utf8_to_acp then
      local acp_file_path = _ejoysdk.utf8_to_acp(file_path)
      md5_hex_str, error_code, error_msg = LUA_FILE.md5(acp_file_path)
    end
  end
  _ejoysdk.log("read md5 return :" .. tostring(md5_hex_str))
  return md5_hex_str, error_code, error_msg
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

function _FileCompat.process_is_directory(_file_path)
  return false
end

function _FileCompat.process_batch_info(file_list, cb, _opts)
  local function _exists_status_handler(path, opts)
    opts = opts or {}
    
    local check_size = opts.check_size or false
    local exists = _FileCompat.process_exists(path)
    local real_size
    if exists and check_size then
      if _ejoysdk.file_length then
        real_size = _ejoysdk.file_length(path)
      else
        local file = io.open(path, "rb")
        if not file and _ejoysdk.utf8_to_acp then
          local acp_file_path = _ejoysdk.utf8_to_acp(path)
          file = io.open(acp_file_path, "rb")
        end
        if file then
          real_size = file:seek("end")
          real_size = real_size or -1
          file:close()
        end
      end
    end
    return exists, real_size
  end
  
  LUA_FILE.batch_info_op(file_list, cb, _opts, _exists_status_handler)
end

function _FileCompat.process_list_directory(dir_path, _recursive, cb)
  if not dir_path then
    if cb then
      cb(nil)
    end
    return
  end
  if _recursive then
    _ejoysdk.log("!!! process_list_directory in old version could not do recursive list, if need please update new version")
  end
  local path_len = #dir_path
  local dir_path_last_ch = dir_path:sub(path_len, path_len)
  local dir_path_has_sep_suffix = "/" == dir_path_last_ch or "\\" == dir_path_last_ch
  if dir_path_has_sep_suffix then
    dir_path = dir_path .. "*"
  else
    dir_path = dir_path .. _FileCompat.sep .. "*"
  end
  local ret = _ejoysdk.listdir(dir_path)
  ret = ret or {}
  local result = {}
  for _, path in ipairs(ret) do
    local _path = M.Path.trim_begin_separator(path)
    table.insert(result, {path = _path, is_dir = false})
  end
  if cb then
    cb(result)
  end
end

function _FileCompat.process_list_bundle(_dir_path, _recursive, cb)
  if cb then
    cb(nil)
  end
end

function _FileCompat.release_bundle_res(src_path, dst_path, _cb)
  local base_src_path = _ejoysdk.get_resources_path and _ejoysdk.get_resources_path() or get_program_file_dir()
  local base_dst_path = _FileCompat.get_ext_file_dir()
  local src_full_path = M.Path.join(base_src_path, src_path)
  local dst_full_path = M.Path.join(base_dst_path, dst_path)
  local ret, code, msg = _FileCompat.process_copy(src_full_path, dst_full_path, {override = true})
  if _cb then
    _cb({
      succ = ret,
      code = code,
      msg = msg
    })
  end
end

function _FileCompat.unzip(src_path, dst_path, cb)
  if src_path and dst_path and "" ~= src_path and "" ~= dst_path then
    local tmp_path = _FileCompat.get_ext_file_dir()
    local src_full_path = M.Path.join(tmp_path, src_path)
    local dst_full_path = M.Path.join(tmp_path, dst_path)
    _FileCompat.unzip_full_path(src_full_path, dst_full_path, cb)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.unzip_full_path(src_full_path, dst_full_path, cb)
  if src_full_path and dst_full_path and "" ~= src_full_path and "" ~= dst_full_path then
    local zip = require("ejoysdk_lua.libs.zip")
    zip.unzip(src_full_path, dst_full_path, function(_succ, ...)
      if _succ then
        if cb then
          cb({succ = true})
        end
      else
        local _code, _msg = ...
        if cb then
          cb({
            succ = false,
            code = _code,
            msg = _msg
          })
        end
      end
    end)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileBatch.process_remove(file_path)
  local ret, code, msg = _ejoysdk.removefile(file_path)
  return ret, code, msg
end

function _FileBatch.process_batch_remove(list, cb, opts)
  list = list or {}
  local list_size = #list
  _ejoysdk.log("_FileBatch.process_batch_remove, list_size:" .. tostring(list_size))
  if 0 == list_size then
    if cb then
      cb(true)
    end
    return
  end
  local params = JSON.encode({files = list, opts = opts})
  M.async_call("batch_remove", function(ret)
    ret = ret or {}
    if cb then
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end, params)
end

function _FileBatch.process_copy(src_fullpath, dst_fullpath, opts)
  opts = opts or {}
  local override = true
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  local succ, code, msg = _ejoysdk.copy_file(src_fullpath, dst_fullpath, override)
  return succ, code, msg
end

function _FileBatch.process_batch_copy(map, cb, opts)
  opts = opts or {}
  local override = true
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  _ejoysdk.log("_FileBatch.process_batch_copy, override:" .. tostring(override))
  local params = JSON.encode({
    files = map,
    need_override = override,
    opts = opts
  })
  M.async_call("batch_copy", function(ret)
    ret = ret or {}
    if cb then
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end, params)
end

function _FileBatch.process_rename(src_fullpath, dst_fullpath)
  do return _ejoysdk.renamefile, src_fullpath end
  return _ejoysdk.renamefile, src_fullpath, dst_fullpath
end

function _FileBatch.process_batch_rename(map, cb, opts)
  _ejoysdk.log("_FileBatch.process_batch_rename")
  local params = JSON.encode({files = map, opts = opts})
  M.async_call("batch_rename", function(ret)
    ret = ret or {}
    if cb then
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end, params)
end

function _FileBatch.process_batch_md5(file_list, cb, base_path)
  _ejoysdk.log("_FileBatch.process_batch_md5")
  local params = JSON.encode({files = file_list, base_path = base_path})
  M.async_call("batch_md5", function(ret)
    ret = ret or {}
    if cb then
      if ret.succ then
        cb(true, ret.succ_data or {})
      else
        cb(false, ret.code, ret.msg, ret.succ_data or {}, ret.fail_data)
      end
    end
  end, params)
end

function _FileBatch.process_is_directory(file_path)
  local exists = M.sync_call("is_directory", file_path)
  return exists
end

function _FileBatch.process_batch_info(file_list, cb, _opts)
  _ejoysdk.log("_FileBatch.process_batch_info")
  local params = JSON.encode({files = file_list, opts = _opts})
  M.async_call("batch_info", function(ret)
    ret = ret or {}
    if ret.succ then
      if cb then
        ret.succ_info = ret.succ_info or {}
        cb(ret.succ_info)
      end
    elseif cb then
      cb(nil, ret.code, ret.msg)
    end
  end, params)
end

function _FileBatch.process_list_directory(dir_path, recursive, cb)
  _ejoysdk.log("_FileBatch.process_list_directory")
  M.async_call("list_dir_ex", function(data_obj)
    data_obj = data_obj or {}
    local data = data_obj.data
    local code = data_obj.code
    local msg = data_obj.msg
    if data then
      if cb then
        cb(data)
      end
    elseif cb then
      cb(nil, code, msg)
    end
  end, dir_path, recursive)
end

local BATCH_SUBMIT_EVENT = "BATCH_SUBMIT_EVENT"
_ejoysdk.register_cb(BATCH_SUBMIT_EVENT, function(_cbid, resp_str, _chunk)
  local before = M.system_clock()
  local resp = CJSON.decode(resp_str)
  if resp and resp.list then
    local list = resp.list
    for _, action_obj in ipairs(list) do
      local cb_type = action_obj.cb_type
      if "HTTP_EVENT" == cb_type then
        local cbid = action_obj.cbid
        local http_ext_params = action_obj.http_ext_params
        _on_handle_progress_http_event(cbid, action_obj, http_ext_params)
      else
        local cbid = action_obj.cbid
        _on_async_callback(cbid, action_obj)
      end
    end
  end
  _ejoysdk.log("batch_submit BATCH_SUBMIT_EVENT received, _cbid:" .. tostring(_cbid) .. ", list size:" .. tostring(resp and resp.list and #resp.list or 0) .. ", cost:" .. tostring(M.system_clock() - before))
end)

function HTTP.submit_download_list(list, file_ext, opts, submit_cb, single_cb, single_progress_cb, single_header_cb)
  local submit_cnt = #list
  _ejoysdk.log("submit_download_list list received, cnt:" .. tostring(submit_cnt))
  local id_begin = cb_id
  local id_end = id_begin + submit_cnt - 1
  local list_idx = 1
  for id = id_begin, id_end do
    local item = list[list_idx]
    item.cbid = id
    local item_task_id = item.taskId
    local cb_fun
    
    function cb_fun(info, body)
      info.headers = HTTP.Header.New(info.headers)
      info.body = body
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
  do return M.async_call, "submit_download_list", function(ret)
    ret = ret or {}
    M.log("process_batch_info >>")
    M.log(ret)
    if ret.succ then
      if submit_cb then
        submit_cb(true)
      end
    elseif submit_cb then
      submit_cb(false, ret.code, ret.msg)
    end
  end end
  return M.async_call, "submit_download_list", function(ret)
    ret = ret or {}
    M.log("process_batch_info >>")
    M.log(ret)
    if ret.succ then
      if submit_cb then
        submit_cb(true)
      end
    elseif submit_cb then
      submit_cb(false, ret.code, ret.msg)
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

local media_play_cbs = {}
_ejoysdk.register_cb("MEDIA_PLAY", function(cbid, _js_str, _chunk)
  local params = media_play_cbs[cbid]
  if params and params.finish_cb then
    params.finish_cb()
    media_play_cbs[cbid] = nil
  end
end)
local Media = {
  DEFAULT_MAX_FILESIZE = 5242880,
  DEFAULT_MAX_DURATION = 60000,
  DEFAULT_SAMPLING_RATE = 8000,
  DEFAULT_ENCODING_BIT_RATE = 16,
  DEFAULT_CHANNEL = 1,
  DEFAULT_BIT_DEPTH_RATE = 16
}
M.Media = Media

function Media.start_record(opt, cb)
  if not M.is_support_function(CONSTANTS.NATIVE_SUPPORT_FUNCTION_NAMES.MEDIA_RECORD) then
    if cb then
      local ret = {
        succ = false,
        code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_NOT_SUPPORT,
        message = "audio not support"
      }
      cb(ret)
    end
    return
  end
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
  local filename = opt.filename or "noname"
  local format = opt.format or "amr"
  local params = {
    filename = filename,
    format = format,
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
      if cb then
        local ret = {
          succ = false,
          code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_SAMPLING_RATE_NOT_VALID,
          message = "when format is amr, sampling_rate should be 8000 or 16000"
        }
        cb(ret)
      end
      return
    end
    if 16 ~= params.bit_depth_rate then
      if cb then
        local ret = {
          succ = false,
          code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_BIT_DEPTH_NOT_VALID,
          message = "when format is amr, bit_depth_rate should be 16"
        }
        cb(ret)
      end
      return
    end
    if 1 ~= params.channel then
      if cb then
        local ret = {
          succ = false,
          code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_CHANNEL_COUNT_NOT_VALID,
          message = "when format is amr, channel should be 1"
        }
        cb(ret)
      end
      return
    end
    if params.sampling_rate == 8000 and not CONSTANTS.AMR_NB_BIT_RATE[params.encoding_bit_rate] then
      params.encoding_bit_rate = Media.DEFAULT_AMR_NB_ENCODING_BIT_RATE
    end
    if params.sampling_rate == 16000 and not CONSTANTS.AMR_WR_BIT_RATE[params.encoding_bit_rate] then
      params.encoding_bit_rate = Media.DEFAULT_AMR_WB_ENCODING_BIT_RATE
    end
  end
  local optStr = opt and JSON.encode(params)
  M.async_call("media_start_record", cb, optStr)
end

function Media.stop_record(opt, cb)
  if not M.is_support_function(CONSTANTS.NATIVE_SUPPORT_FUNCTION_NAMES.MEDIA_RECORD) then
    if cb then
      local ret = {
        succ = false,
        code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_NOT_SUPPORT,
        message = "audio not support"
      }
      cb(ret)
    end
    return
  end
  local optStr = opt and JSON.encode(opt) or "{}"
  
  local function cb_wrap(info, body)
    info.bytes = body
    if cb then
      cb(info)
    end
  end
  
  M.async_call("media_stop_record", cb_wrap, optStr)
end

function Media.start_play(opt, cb)
  if not M.is_support_function(CONSTANTS.NATIVE_SUPPORT_FUNCTION_NAMES.MEDIA_RECORD) then
    local ret = {
      succ = false,
      code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_NOT_SUPPORT,
      message = "audio not support"
    }
    cb(ret)
    return
  end
  opt = opt or {}
  local format = "amr"
  if opt.format and opt.format ~= "auto" then
    format = opt.format
  end
  local filename = opt.filename or "noname"
  local filepath = M.Path.join(M.File.get_ext_file_dir(), "records", filename .. "." .. format)
  local params = {
    filename = opt.filename or "noname",
    filepath = filepath,
    format = format,
    volume = opt.volume or 1.0
  }
  local optStr = opt and JSON.encode(params)
  local cbid = M.async_call("media_start_play", cb, optStr)
  media_play_cbs[cbid] = {
    finish_cb = opt.finish_cb
  }
end

function Media.stop_play(opt, cb)
  if not M.is_support_function(CONSTANTS.NATIVE_SUPPORT_FUNCTION_NAMES.MEDIA_RECORD) then
    if cb then
      local ret = {
        succ = false,
        code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_NOT_SUPPORT,
        message = "audio not support"
      }
      cb(ret)
    end
    return
  end
  local optStr = opt and JSON.encode(opt) or "{}"
  
  local function cb_wrap(info, body)
    info = JSON.decode(info)
    if cb then
      cb(info, body)
    end
  end
  
  M.async_call("media_stop_play", cb_wrap, optStr)
end

function Media.delete(opt, cb)
  if not M.is_support_function(CONSTANTS.NATIVE_SUPPORT_FUNCTION_NAMES.MEDIA_RECORD) then
    if cb then
      local ret = {
        succ = false,
        code = CONSTANTS.MEDIA_ERROR.CODE_MEDIA_NOT_SUPPORT,
        message = "audio not support"
      }
      cb(ret)
    end
    return
  end
  local optStr = opt and JSON.encode(opt)
  M.async_call("media_delete", cb, optStr)
end

function Media.get_record_dir()
  if not M.is_support_function(CONSTANTS.NATIVE_SUPPORT_FUNCTION_NAMES.MEDIA_RECORD) then
    return
  end
  do return M.Path.join, (M.File.get_ext_file_dir()) end
  return M.Path.join, M.File.get_ext_file_dir(), "records"
end

function Media.is_support()
  do return M.is_support_function end
  return M.is_support_function, CONSTANTS.NATIVE_SUPPORT_FUNCTION_NAMES.MEDIA_RECORD
end

local Sdkinfo = {}
M.Sdkinfo = Sdkinfo

function Sdkinfo.getSDKVersionName(sdkName)
  do return _ejoysdk.sdkinfo_get_version_name end
  return _ejoysdk.sdkinfo_get_version_name, sdkName
end

function M.disable_embed_webview(disable)
  M.log("disable_embed_webview")
  if nil == disable then
    disable_embed_webview = true
  else
    disable_embed_webview = disable
  end
  return disable_embed_webview
end

function M.support_webview()
  if disable_embed_webview then
    return false
  end
  local version = M.Sdkinfo.getSDKVersionName("EJOYSDK")
  local version_check = require("ejoysdk_lua.ejoysdk_version_check")
  local result = version_check.compare_versions(version, "2.2.0")
  if tonumber(result) >= 0 then
    return true
  end
  return false
end

local QRCode = {}
M.QRCode = QRCode

function QRCode.gen_bmp(text)
  local succ, data = _ejoysdk.qrcode_gen_bmp(text)
  return succ, data
end

local Calendar = {}
M.Calendar = Calendar

function Calendar.add_event(_params, _cb)
  _ejoysdk.log("todo add_event")
end

function Calendar.delete_event(_params, _cb)
  _ejoysdk.log("todo delete_event")
end

function Calendar.update_event(_params, _cb)
  _ejoysdk.log("todo update_event")
end

function Calendar.query_event(_params, _cb)
  _ejoysdk.log("todo query_event")
end

function Calendar.query_event_id(_params, _cb)
  _ejoysdk.log("todo query_event")
end

function M.support_save_to_album()
  return false
end

function M.save_to_album(_path, _need_delete, cb)
  if cb then
    cb({
      code = -99,
      msg = "保存失败，不支持windows"
    })
  end
end

function M.kill_app()
  error("kill_app 需要实现")
end

function M.support_app_reviews()
  return false
end

function M.async_support_app_reviews(cb)
  if cb then
    cb(M.support_app_reviews())
  end
end

function M.app_reviews()
  M.log("rate_app is not supported in Windows")
end

function M.comment_app()
  M.log("comment_app is not supported in Windows")
end

function M.set_app_orientation(_orientation)
end

function M.copy_clipboard(_params)
  if _ejoysdk.copy_clipboard then
    local data_str = _ejoysdk.copy_clipboard(JSON.encode(_params))
    do return JSON.decode end
    return JSON.decode, data_str
  end
  return {
    succ = false,
    msg = "客户端不支持"
  }
end

function M.get_cba_tweleve_info()
  return {}
end

function Sysinfo.get_ejoy_referer()
  return nil
end

local Permission = {}
M.Permission = Permission

function Permission.check_permission_v3(_options, _cb)
end

function Permission.get_requested_permissions()
  return {}
end

function Permission.async_get_requested_permissions(cb)
  if cb then
    cb(M.Permission.get_requested_permissions())
  end
end

function Permission.show_usage_dialog(_options, _cb)
end

function Permission.checkPermission(_permission_detail, _cb)
end

function Permission.check_permission_v2(_permission, _cb)
end

function Permission.detect_permission(_permission, _cb)
end

function Permission.openSetting(_ext_param)
end

function Permission.openApplicationSetting()
end

function Permission.support_compliance_check()
  return false
end

function Permission.async_support_compliance_check(cb)
  if cb then
    cb(M.Permission.support_compliance_check())
  end
end

_ejoysdk.register_cb("FOREIGN_NATIVE_CALL", function(...)
  local lua_adapter = require("ejoysdk_lua.ejoysdk_foreign_call")
  do return lua_adapter.input, ... end
  return lua_adapter.input, ...
end)
_ejoysdk.register_cb("FOREIGN_JSON_DECODE", CJSON.decode)
_ejoysdk.register_cb("FOREIGN_JSON_ENCODE", CJSON.encode)
local Loading = {}
M.Loading = Loading

function Loading.show()
end

function Loading.dismiss()
end

function Loading.is_support_custom()
  return false
end

local Toast = {}
M.Toast = Toast

function Toast.show(message, option)
  option = option or {}
  if not option.messageHeight then
    option.messageHeight = 20
    local succ, total_lines = pcall(calculateLineCountUTF8, message, 25)
    if succ then
      option.messageHeight = total_lines * 20
    end
  end
  local optionString = JSON.encode(option)
  M.async_call("toast_open", function()
  end, message or "", optionString)
end

function Toast.hide()
  M.async_call("toast_open", function()
  end, "", "{}")
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

function Sysinfo.battery()
  return {}
end

function Sysinfo.battery_v2(_cb)
end

function Sysinfo.battery_ext(_filter, _cb)
end

function Sysinfo.launch_battery()
  return {}
end

function Sysinfo.launch_time()
  return -1
end

function Sysinfo.launch_time_async(cb)
  M.async_call("sysinfo_launch_time", cb, {})
end

function Sysinfo.run_time()
  return -1
end

function Sysinfo.run_time_async(cb)
  if not cb then
    return
  end
  Sysinfo.launch_time_async(function(info)
    if info.succ then
      local run_time = os.time() * 1000 - info.launch_time
      cb({succ = true, run_time = run_time})
    else
      cb({succ = false})
    end
  end)
end

function Sysinfo.network_current_state()
  return -1
end

function Sysinfo.network_current_state_async(cb)
  M.async_call("network_current_state", cb)
end

function Sysinfo.network_monitor_start()
end

function Sysinfo.network_monitor_stop()
end

function Sysinfo.network_ping(_params, _cb)
end

function Sysinfo.network_traceroute(_params, _cb)
end

function Sysinfo.get_audio_mute_info(_cb)
end

function Sysinfo.start_listen_audio_mute()
end

function Sysinfo.stop_listen_audio_mute()
end

function Sysinfo.is_audio_mute_listen_open()
  return false
end

function Sysinfo.set_audio_category(_category)
end

function Sysinfo.can_resolve_activity(_package_name, _package_activity_name)
  return false
end

function Sysinfo.get_screen_refresh_rate(cb)
  M.async_call("get_screen_refresh_rate", function(temp)
    if temp then
      if not temp.frame_rate_now then
        temp.frame_rate_now = -1
      end
      if not temp.device_rate_max and temp.frame_rate_max then
        temp.device_rate_max = temp.frame_rate_max
      end
    end
    if cb then
      cb(temp)
    end
  end)
end

function Sysinfo.oaid()
  return nil
end

function Sysinfo.oaid_async(cb)
  if cb then
    cb(nil)
  end
end

local Sensor = {}
M.Sensor = Sensor
M.Sensor.SHAKE_EVENT = {
  BEGIN = "SHAKE_BEGIN",
  END = "SHAKE_END",
  CANCEL = "SHAKE_CANCEL"
}

function Sensor.set_threshold(_threshold)
end

function Sensor.register_shake(_cb)
end

function Sensor.unregister_shake()
end

function M.get_brightness()
  return -1
end

function M.set_brightness(_brightness)
end

function M.reset_brightness()
end

function M.vibrate(_milliseconds)
end

function M.is_vibrate_support()
  return false
end

function Sysinfo.get_audio_category()
end

function Sysinfo.set_audio_options(_category, _mode, _options, _fore_active)
end

function M.scroll_log_file(_file_name)
  do return M.sync_call end
  return M.sync_call, "scroll_log_file"
end

function M.flush_log()
  do return M.sync_call end
  return M.sync_call, "flush_log"
end

function M.get_log_file_infos(_params, cb)
  local paramsStr = _params and JSON.encode(_params) or "{}"
  M.async_call("get_log_file_infos", function(resp)
    if cb then
      cb(resp)
    end
  end, paramsStr)
end

local _is_log_file_support

function M.is_log_file_support()
  if nil ~= _is_log_file_support then
    return _is_log_file_support
  end
  local version = M.Sdkinfo.getSDKVersionName("EJOYSDK")
  local version_check = require("ejoysdk_lua.ejoysdk_version_check")
  local result = version_check.compare_versions(version, "2.6.8")
  if tonumber(result) >= 0 then
    _is_log_file_support = true
    return _is_log_file_support
  end
  _is_log_file_support = false
  return _is_log_file_support
end

function M.get_current_log_file(_params, cb)
  local paramsStr = _params and JSON.encode(_params) or "{}"
  M.async_call("get_current_log_file", function(resp)
    if cb then
      cb(resp)
    end
  end, paramsStr)
end

function M.is_support_jf_file_cache()
  if _ejoysdk.jf_log then
    return true
  end
  return false
end

function M.init_jf_file_cache(dir_name)
  local param_str = JSON.encode({dir_name = dir_name})
  M.sync_call("init_jf_file_cache", param_str)
end

function M.switch_jf_sub_dir(sub_dir_name)
  M.sync_call("switch_jf_sub_dir", sub_dir_name)
end

function M.jf_log(event_log_str)
  M.sync_call("jf_log", event_log_str)
end

function M.get_jf_file_infos(cb)
  M.async_call("get_jf_file_infos", function(log_files)
    cb(log_files and log_files.data or nil)
  end, "{}")
end

function M.get_current_jf_file_info(cb)
  M.async_call("get_current_jf_file_info", function(resp)
    cb(resp)
  end, "{}")
end

function M.flush_jf_log()
  M.sync_call("flush_jf_log")
end

function M.scroll_jf_log()
  M.sync_call("scroll_jf_log_file")
end

function M.get_ej_debugable()
  do return _FileCompat.process_exists end
  return _FileCompat.process_exists, "C:/EjoySdkLogs"
end

function M.get_ej_detail_debuggable()
  do return _FileCompat.process_exists end
  return _FileCompat.process_exists, "C:/ejoysdk_dl.debug"
end

function M.switch_to_game()
  if _ejoysdk.switch_to_game then
    return 1 == _ejoysdk.switch_to_game()
  end
  return false
end

local cache_pc_ad_token

function M.set_pc_ad_token(pc_ad_token)
  if pc_ad_token and "" ~= pc_ad_token then
    cache_pc_ad_token = pc_ad_token
    M.get_pkg_info().pc_ad_token = cache_pc_ad_token
    local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
    ESTAT.reset_env_info()
  end
end

function M.get_pc_ad_token()
  if nil == cache_pc_ad_token then
    local config_content = M.File.readfile("ejoysdk_pc_ad.ini")
    if nil ~= config_content then
      local data = JSON.safe_decode(config_content)
      if data and data.pcAdToken then
        cache_pc_ad_token = data.pcAdToken
        M.get_pkg_info().pc_ad_token = cache_pc_ad_token
      end
    end
  end
  return cache_pc_ad_token
end

function M.get_pre_order_items(cb)
  cb = cb or function()
  end
  cb(false, "windows", -1, "not support")
end

function M.get_system_properties(_key, _default_value)
end

_ejoysdk.register_cb("PATCH_EVENT", function(cbid, patch_cb_info, _chunk)
  local params = patch_progress_cbs[cbid]
  if params then
    local resp = CJSON.decode(patch_cb_info) or {}
    if params.progress then
      params.progress(resp.completeCount, resp.totalCount)
    end
  end
end)

function M.patch_dir(params, cb, progress_cb)
  local exe_path = M.File.get_sys_dirs().program_dir
  params.resPkgDirPath = M.Path.join(exe_path, params.resPkgDirPath)
  local optStr = JSON.encode(params)
  local cbid = M.async_call("ejoysdk_patch_dir", function(resp)
    if 0 == resp.ret then
      cb(true)
    else
      cb(false, resp.ret)
    end
  end, optStr)
  patch_progress_cbs[cbid] = {progress = progress_cb}
end

local function is_absolute_path(path)
  if type(path) ~= "string" then
    return false
  end
  path = path:match("^%s*(.-)%s*$")
  if 0 == #path then
    return false
  end
  if path:match("^%a:[\\/]") then
    return true
  end
  if path:sub(1, 2) == "\\\\" then
    return true
  end
  return false
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
      if options.resPkgDirPath == "" or not is_absolute_path(options.resPkgDirPath) then
        M.log("patch files options.resPkgDirPath is relative path, join with exe path, resPkgDirPath:" .. tostring(options.resPkgDirPath))
        local exe_path = M.File.get_sys_dirs().program_dir
        options.resPkgDirPath = M.Path.join(exe_path, options.resPkgDirPath)
      end
      local optStr = JSON.encode(params)
      local cbid = M.async_call("ejoysdk_patch_files", function(resp)
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
  if _ejoysdk.is_build_in_webview_available then
    local is_support, code = _ejoysdk.is_build_in_webview_available()
    if false == is_support and -1 == code then
      local os_version = Sysinfo.os_version()
      local major_version = string.match(os_version, "(%d+)%.(%d+)%.(%d+)") or 0
      if (tonumber(major_version) or 0) >= 10 then
        return true
      end
      return false, CONSTANTS.ENV_ERROR.CODE_WV2_INCOMPATIBLE_WIN7, "WebView2 is incompatible with your system"
    end
  end
  return true
end

function M.picker(_params, cb)
  if cb then
    cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
  end
end

local original_io_open = io.open

local function to_long_path(path)
  if not path or 0 == #path then
    return nil
  end
  local normalized = path:gsub("/", "\\")
  normalized = normalized:gsub("\\\\+", "\\")
  return "\\\\?\\" .. normalized
end

local function has_relative_path_token(path)
  if not path then
    return false
  end
  return path:match("(^|[\\/])%.([\\/]|$)") ~= nil or nil ~= path:match("(^|[\\/])%.%.([\\/]|$)")
end

function io.open(filename, mode)
  local is_converted = false
  local final_path = filename
  local is_long_path = filename and #filename > 255 or false
  local has_relative_token = has_relative_path_token(filename)
  if filename:match("^\\\\%?\\") then
    is_converted = true
  elseif filename and #filename > 255 then
    final_path = to_long_path(filename)
    is_converted = true
  end
  local file_handle, err_msg = original_io_open(final_path, mode)
  if not file_handle and is_long_path then
    local ELOG = require("ejoysdk_lua.ejoysdk_log")
    ELOG.LOG.warn(TAG, string.format(" IO OPEN FAILED >>  long_path=%s, converted=%s, file=%s, err=%s", tostring(is_long_path), tostring(is_converted), tostring(final_path), tostring(err_msg)))
    return nil, err_msg
  end
  if is_long_path and has_relative_token then
    local ELOG = require("ejoysdk_lua.ejoysdk_log")
    ELOG.LOG.warn(TAG, string.format("long path contains relative token, mode=%s, converted=%s, file=%s", tostring(mode), tostring(is_converted), tostring(final_path)))
  end
  return file_handle
end

function M.subscribe_msg(_options, _cb)
  if _cb then
    _cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
  end
end

return M

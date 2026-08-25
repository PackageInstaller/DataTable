local TI = require("ejoysdk_lua.ejoysdk_platform_base.timer")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ECC = require("ejoysdk_lua.ejoysdk_constants")
local Class = require("ejoysdk_lua.ejoysdk_class")
local ELOG = require("ejoysdk_lua.ejoysdk_log")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
JSON.enable_cjson(true)
local _ejoysdk_copy = UTILS.deep_copy_with_metatable(_ejoysdk)
_ejoysdk = nil
_ejoysdk = _ejoysdk_copy
local dy_api = setmetatable({}, {
  __index = function(self, key)
    local _func = rawget(self, key)
    if not _func then
      _func = _ejoysdk.dy[key] or function()
        error("Not implemented: " .. key)
      end
      rawset(self, key, _func)
    end
    return _func
  end
})

local function reset_metatable_value(self)
  for k in pairs(self) do
    if "inited" ~= k then
      self[k] = nil
    end
  end
  self.inited = false
end

local M = {}
local dy_fs = dy_api.getFileSystemManager()

function _ejoysdk.lread(filename)
  local ret, data = pcall(dy_fs.readFileSync, filename, "binary")
  return ret and data or nil
end

M.PLATFORM = {
  OS = "douyin",
  HTTP_UA = "EjoySDK-http-client/0.1 (Linux; douyin)"
}
local native_supported = {
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD] = true,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE_V1] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_STOP] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_BATCH_STOP] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_NATIVE_FORMDATA] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS] = true,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.DOWNLOAD_SINGLE_POOL] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.OPEN_COMMON_SETTING] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.ADD_CARLENDAR_EVENT] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.GET_BRIGHTNESS] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.SET_BRIGHTNESS] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.RESET_BRIGHTNESS] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.VIBRATE] = true,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.IS_VIBRATE_SUPPORT] = true,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.REGISTER_SHAKE] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.UNREGISTER_SHAKE] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.IS_SHAKE_SUPPORT] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.GET_SCREEN_REFRESH_RATE] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_PROGRESS_NOTIFICATION_NATIVE_ONLY] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.BATCH_FILE_OPERATION] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.FILE_DIR_OPERATION] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.TIMER_FLOAT_INTERVAL] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_WEBVIEW_PRELOAD] = false,
  [ECC.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_FILE_BATCH_OPERATION_BASE_PATH] = false
}

function M.is_support_function(name)
  if native_supported[name] then
    return true
  end
  return false
end

local ori_js_log = _ejoysdk.log

local function js_log(...)
  if not ELOG.is_log_open() then
    return
  end
  local log = {
    ...
  }
  if 1 == #log then
    log = log[1]
  end
  ori_js_log(log)
end

_ejoysdk.js_log = js_log
_ejoysdk.log = js_log
local HTTP = {}
HTTP.dy_timeout = 60000
M.HTTP = HTTP

local function http_get_file(url, params, cb)
  assert(not params.header_cb, "douyin http get file not support header_cb")
  local headers = params and params.headers
  M.Path.ensure_parent_dir(params.file)
  local download_task = _ejoysdk.dy.downloadFile({
    url = url,
    header = headers,
    timeout = HTTP.dy_timeout,
    filePath = params.file,
    success = function(resp)
      local resp_copy = resp
      if nil == resp_copy then
        _ejoysdk.log("Error: resp_copy is nil")
        cb({
          status = ECC.EJOYSDK_ERROR_CODES.REQUEST_RESP_INVALID
        })
        return
      end
      local info = {
        status = resp_copy.statusCode,
        headers = HTTP.Header.New(resp_copy.header),
        body = resp_copy.filePath
      }
      cb(info)
    end,
    fail = function(err)
      local error_status = err and err.errNo or ECC.EJOYSDK_ERROR_CODES.REQUEST_RESP_INVALID
      cb({status = error_status})
    end
  })
  if params.progress or params.finish_cb then
    local progress_cb
    
    function progress_cb(res)
      local progress = res.progress
      local received = res.totalBytesWritten or 0
      local total = res.totalBytesExpectedToWrite or 0
      if params.progress and progress then
        params.progress(url, params.file, received, total)
      end
      if 100 == progress and params.finish_cb then
        params.finish_cb()
      end
    end
    
    download_task.onProgressUpdate(progress_cb)
  end
end

local function http_get_data(url, params, cb)
  local headers = params and params.headers
  assert(headers, "params.headers should not be nil")
  headers["user-agent"] = nil
  dy_api.request({
    url = url,
    method = "GET",
    header = headers,
    timeout = HTTP.dy_timeout,
    dataType = "binary",
    responseType = "arraybuffer",
    success = function(resp)
      local resp_copy = resp
      if nil == resp_copy then
        _ejoysdk.log("Error: resp_copy is nil")
        cb({
          status = ECC.EJOYSDK_ERROR_CODES.REQUEST_RESP_INVALID
        })
        return
      end
      local info = {
        status = resp_copy.statusCode,
        headers = HTTP.Header.New(resp_copy.header),
        body = _wasmoon.tolstring(resp_copy.data)
      }
      cb(info)
    end,
    fail = function(err)
      local error_status = err and err.errNo or ECC.EJOYSDK_ERROR_CODES.REQUEST_RESP_INVALID
      cb({status = error_status})
    end
  })
end

function HTTP.process_get(url, params, cb)
  if not params.file then
    http_get_data(url, params, cb)
  else
    http_get_file(url, params, cb)
  end
end

local function http_post_and_get_file(_url, _params, _content_type, _body, _cb)
  error("Not implemented")
end

local function http_post_data(url, params, content_type, body, cb)
  local headers = params and params.headers
  assert(headers, "params.headers should not be nil")
  headers["user-agent"] = nil
  headers.content_type = content_type or "application/json"
  local req = {
    url = url,
    method = "POST",
    header = headers,
    timeout = HTTP.dy_timeout,
    data = _wasmoon.to_arraybuffer(body),
    dataType = "binary",
    responseType = "arraybuffer"
  }
  
  function req.success(resp)
    local resp_copy = resp
    if nil == resp_copy then
      _ejoysdk.log("Error: resp_copy is nil")
      cb({
        status = ECC.EJOYSDK_ERROR_CODES.REQUEST_RESP_INVALID
      })
      return
    end
    local info = {
      status = resp_copy.statusCode,
      headers = HTTP.Header.New(resp_copy.header),
      body = _wasmoon.tolstring(resp_copy.data)
    }
    cb(info)
  end
  
  function req.fail(err)
    local error_status = err and err.errNo or ECC.EJOYSDK_ERROR_CODES.REQUEST_RESP_INVALID
    cb({status = error_status})
  end
  
  dy_api.request(req)
end

function HTTP.process_post(url, params, content_type, body, cb)
  if not params.file then
    http_post_data(url, params, content_type, body, cb)
  else
    http_post_and_get_file(url, params, content_type, body, cb)
  end
end

function HTTP.process_stop()
end

local network_type_map = {
  none = 0,
  wifi = 1,
  ["2g"] = 2,
  ["3g"] = 2,
  ["4g"] = 2,
  ["5g"] = 2,
  unknown = 3
}
local last_network_name = "unknown"

local function get_network_type(network_name)
  local type = network_type_map[network_name]
  if type then
    return type
  else
    return 3
  end
end

local system_info = setmetatable({}, {
  __index = function(self, idx)
    if "reset" == idx then
      return reset_metatable_value
    end
    if not rawget(self, "inited") then
      local info = _ejoysdk.dy.getSystemInfoSync()
      rawset(self, "language", info.language)
      rawset(self, "system", info.system)
      rawset(self, "platform", info.platform)
      rawset(self, "brand", info.brand)
      rawset(self, "model", info.model)
      rawset(self, "version", info.version)
      rawset(self, "appName", info.appName)
      rawset(self, "SDKVersion", info.SDKVersion)
      rawset(self, "screenWidth", info.screenWidth)
      rawset(self, "screenHeight", info.screenHeight)
      rawset(self, "windowWidth", info.windowWidth)
      rawset(self, "windowHeight", info.windowHeight)
      rawset(self, "safeArea", {
        left = info.safeArea.left,
        right = info.safeArea.right,
        top = info.safeArea.top,
        bottom = info.safeArea.bottom,
        width = info.safeArea.width,
        height = info.safeArea.height
      })
      rawset(self, "pixelRatio", info.pixelRatio)
      rawset(self, "deviceScore", {
        cpu = info.deviceScore.cpu,
        gpu = info.deviceScore.right,
        memory = info.deviceScore.memory,
        overall = info.deviceScore.overall
      })
      rawset(self, "deviceOrientation", info.deviceOrientation)
      rawset(self, "inited", true)
    end
    return rawget(self, idx) or ""
  end
})

function system_info:reset()
  _ejoysdk.log("trigger system_info reset")
  reset_metatable_value(self)
end

local env_info = setmetatable({}, {
  __index = function(self, idx)
    if not rawget(self, "inited") then
      local info = _ejoysdk.dy.getEnvInfoSync()
      rawset(self, "microapp", {
        mpVersion = info.microapp.mpVersion,
        envType = info.microapp.envType,
        appId = info.microapp.appId
      })
      rawset(self, "common", {
        USER_DATA_PATH = info.common.USER_DATA_PATH
      })
      rawset(self, "inited", true)
    end
    return rawget(self, idx) or ""
  end
})
local Sysinfo = {}
M.Sysinfo = Sysinfo

local function get_sys_network_type_async()
  dy_api.getNetworkType({
    success = function(res)
      last_network_name = res.networkType
    end
  })
end

get_sys_network_type_async()

function Sysinfo.network_type()
  do return get_network_type end
  return get_network_type, last_network_name
end

function Sysinfo.network_type_cache()
  do return get_network_type end
  return get_network_type, last_network_name
end

function Sysinfo.network_type_name()
  return last_network_name
end

function Sysinfo.network_current_state()
  get_sys_network_type_async()
  local network_map = {
    none = 0,
    unknown = 1,
    wifi = 2,
    ["2g"] = 3,
    ["3g"] = 4,
    ["4g"] = 5,
    ["5g"] = 6
  }
  local type = network_map[last_network_name]
  return type or 1
end

function Sysinfo.network_current_state_async(cb)
  dy_api.getNetworkType({
    success = function(res)
      last_network_name = res.networkType
      cb({
        succ = true,
        state = get_network_type(last_network_name)
      })
    end,
    fail = function()
      cb({succ = false})
    end
  })
end

function Sysinfo.is_support_hardware_info()
  return false
end

function Sysinfo.get_hardware_info(cb)
  M.ability_report("get_hardware_info")
  local hardware_info = {
    cpu = {
      model = Sysinfo.get_cpu_model(),
      core_num = nil,
      max_freq = nil
    },
    gpu = {},
    memory = {
      total_size = Sysinfo.memory().Total or -1
    },
    model = Sysinfo.model(),
    brand = Sysinfo.brand()
  }
  cb(hardware_info)
end

function Sysinfo.get_gpu_info(cb)
  if cb then
    cb({})
  end
end

local function reset_window_info_listener()
  system_info:reset()
end

dy_api.onDeviceOrientationChange(reset_window_info_listener)
dy_api.onWindowResize(reset_window_info_listener)

function Sysinfo.cutout()
  local cutout_rect = {
    x = 0,
    y = 0,
    width = 0,
    height = 0
  }
  local safe_inset
  local screen_width = system_info.screenWidth
  local screen_height = system_info.screenHeight
  if not system_info.safeArea.top or system_info.safeArea.top == "" then
    safe_inset = {
      top = 0,
      left = 0,
      bottom = 0,
      right = 0
    }
  else
    if screen_width < system_info.safeArea.width then
      _ejoysdk.log("system_info screen width height error, origin width: " .. tostring(screen_width) .. ", origin height: " .. tostring(screen_height))
      local temp_screen_width = screen_width
      screen_width = screen_height
      screen_height = temp_screen_width
      _ejoysdk.log("system_info screen width height error, final width: " .. tostring(screen_width) .. ", final height: " .. tostring(screen_height))
    end
    safe_inset = {
      top = math.floor(system_info.safeArea.top * system_info.pixelRatio),
      left = math.floor(system_info.safeArea.left * system_info.pixelRatio),
      bottom = math.floor((screen_height - system_info.safeArea.bottom) * system_info.pixelRatio),
      right = math.floor((screen_width - system_info.safeArea.right) * system_info.pixelRatio)
    }
  end
  if safe_inset.top < 0 or safe_inset.bottom < 0 or safe_inset.left < 0 or safe_inset.right < 0 then
    _ejoysdk.log("safe_inset error, return default_safe_inset, origin safe_inset: ")
    _ejoysdk.js_log(safe_inset)
    safe_inset = {
      top = 0,
      bottom = 0,
      left = 0,
      right = 0
    }
  end
  local result = {
    cutout_rects = {cutout_rect},
    safe_inset = safe_inset
  }
  return result
end

function Sysinfo.cutout_async(cb)
  local cutout_info = Sysinfo.cutout()
  cb(cutout_info)
end

local utdid

function Sysinfo.device_id()
  if nil == utdid then
    utdid = _ejoysdk.get_utdid()
  end
  return utdid
end

function Sysinfo.manifest_meta_data()
  return ""
end

function Sysinfo.idfa()
  do return end
  return M.Sysinfo.utdid, nil
end

local uuid

function Sysinfo.uuid()
  if nil == uuid then
    uuid = _ejoysdk.get_uuid()
  end
  return uuid
end

function Sysinfo.utdid()
  if nil == utdid then
    utdid = _ejoysdk.get_utdid()
  end
  return utdid
end

function Sysinfo.oaid_async(cb)
  if cb then
    cb(nil)
  end
end

function Sysinfo.brand()
  return system_info.brand
end

function Sysinfo.model()
  return system_info.model
end

function Sysinfo.package_name()
  return "douyin_" .. tostring(env_info.microapp.appId)
end

function Sysinfo.app_name()
  return "douyin_" .. tostring(env_info.microapp.appId)
end

function Sysinfo.time_zone()
end

function Sysinfo.language()
  return system_info.language or "zh_CN"
end

function Sysinfo.language_script()
end

function Sysinfo.country()
  return "CN"
end

function Sysinfo.mobile_info()
end

function Sysinfo.is_vpn_connected()
  return false
end

function Sysinfo.os_version()
  return system_info.version
end

function Sysinfo.os_sdk_version()
  return system_info.SDKVersion
end

function Sysinfo.os()
  return "douyin"
end

local update_time_storage_key = env_info.microapp.appId .. "update_time"

function Sysinfo.install_time()
  local update_time = M.KeyStore.get(update_time_storage_key)
  return update_time
end

function Sysinfo.update_time()
  local update_time = M.KeyStore.get(update_time_storage_key)
  if not update_time then
    update_time = math.floor(_ejoysdk.system_ms())
    M.KeyStore.set(update_time_storage_key, update_time)
  end
  return update_time
end

function Sysinfo.app_version_code()
  return 0
end

function Sysinfo.app_version_name()
  return tostring(env_info.microapp.envType) .. "-" .. tostring(env_info.microapp.mpVersion)
end

function Sysinfo.get_cpu_model()
  return ""
end

function Sysinfo.open_url(_url)
end

function Sysinfo.can_open_url(_url)
  return false
end

function Sysinfo.async_can_open_url(_url, _cb)
  _cb(false)
end

function Sysinfo.sysinfo_ejoy_ext_info()
  return ""
end

function Sysinfo.get_user_agent()
  return _ejoysdk.ua
end

function Sysinfo.get_ejoy_referer()
  return ""
end

function Sysinfo.get_storage_info()
  return {internal_total_storage_size = 0}
end

function Sysinfo.screen()
  return {
    width = system_info.windowWidth,
    hight = system_info.windowHeight
  }
end

function Sysinfo.screen_width()
  return system_info.windowWidth
end

function Sysinfo.screen_height()
  return system_info.windowHeight
end

function Sysinfo.memory()
  return {}
end

function Sysinfo.network_ping(_params, _cb)
  if _cb then
    _cb(nil)
  end
end

function Sysinfo.network_traceroute(_params, _cb)
  if _cb then
    _cb(nil)
  end
end

function Sysinfo.async_storage(cb)
  cb({
    availableInternalStorage = Sysinfo.get_storage_info().internal_total_storage_size
  })
end

function Sysinfo.ds_channel_id()
  return "998233"
end

function Sysinfo.ds_sub_channel_id()
end

function Sysinfo.go_to_app_market()
end

function Sysinfo.get_device_system()
  local system = system_info.system
  local brand = system_info.brand
  local os = "unknown"
  if not system or "" == system then
    return os
  end
  system = string.lower(system)
  if string.find(system, "ios") then
    os = "ios"
  elseif string.find(system, "android") then
    os = "android"
  elseif string.find(system, "harmony") then
    os = "harmonyos"
  else
    brand = string.lower(brand)
    if string.find(brand, "apple") then
      os = "mac"
    else
      os = "windows"
    end
  end
  return os
end

function Sysinfo.get_device_system_version()
  local system = system_info.system
  if string.match(system, "^[%d%.]+$") then
    return system
  else
    return string.match(system, "%s+([%d%.]+)") or system
  end
end

function Sysinfo.get_device_type()
  local os_value = Sysinfo.get_device_system()
  if "mac" == os_value or "windows" == os_value then
    return "pc"
  end
  return nil
end

function Sysinfo.launch_time()
  return 0
end

function Sysinfo.launch_time_async(_cb)
end

function Sysinfo.run_time()
  return 0
end

function Sysinfo.run_time_async(_cb)
end

function Sysinfo.memory_detail(cb)
  cb({})
end

function Sysinfo.cpu_usage(cb)
  cb({succ = false})
end

function Sysinfo.is_simulator()
  return system_info.platform == "devtools"
end

function Sysinfo.battery(_cb)
  return {
    level = 0,
    scale = 0,
    status = 0
  }
end

function Sysinfo.battery_v2(cb)
  cb(M.Sysinfo.battery())
end

function Sysinfo.battery_ext(_filter, cb)
  cb({})
end

function Sysinfo.launch_battery()
  do return end
  return M.Sysinfo.battery, nil
end

function Sysinfo.device_info(_types, _cb)
  local valid_type_names = {
    cpu = true,
    memory = true,
    battery = true
  }
  local get_type_result = {}
  local get_type_count = 0
  for _, v in pairs(_types) do
    if valid_type_names[v] then
      get_type_result[v] = {}
      get_type_count = get_type_count + 1
    end
  end
  if 0 == get_type_count then
    _cb(false, "get type count zero")
    return
  end
  local time_out = false
  local async_come_full = false
  local async_come_count = 0
  
  local function check_end()
    if not time_out and async_come_count == get_type_count then
      async_come_full = true
      _cb(true, get_type_result)
    end
  end
  
  M.Timer.once(3, function()
    if not async_come_full then
      _cb(true, get_type_result)
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

local Sdkinfo = {}
M.Sdkinfo = Sdkinfo

function Sdkinfo.getSDKVersionName(sdkName)
  local uni = require("ejoysdk_lua.vendors.unisdk")
  local sdk_info = uni.get_sdk_info(sdkName)
  local sdk_version = sdk_info and sdk_info.version or "0"
  js_log("getSDKVersionName:" .. tostring(sdkName) .. ", ver:" .. tostring(sdk_version))
  return sdk_version
end

local Timer = {}
M.Timer = Timer
local dy_set_timeout = _ejoysdk.setTimeout

function Timer.once(interval, callback)
  dy_set_timeout(callback, interval * 1000)
end

function Timer.tick()
end

TI:check(Timer)
local LUA_FILE = require("ejoysdk_lua.libs.luafile")
local user_dir_cache = _ejoysdk.dy.env.USER_DATA_PATH
local File = {}
M.File = File

function File.get_ext_file_dir()
  return user_dir_cache
end

function File.get_sys_dirs()
  return {}
end

function File.writefile(filename, filedata, append, is_b64)
  local file_path = user_dir_cache .. "/" .. filename
  if true == is_b64 then
    local succ, data = pcall(_ejoysdk_crypt.base64decode, filedata)
    if true == succ then
      filedata = data
    else
      filedata = nil
    end
  end
  if not filedata then
    js_log("writefile error!!! invalid data")
    return false
  end
  do return File.writefile_fullpath, file_path, filedata end
  return File.writefile_fullpath, file_path, filedata, append
end

function File.writefile_fullpath(filepath, filedata, append, is_b64)
  local EU = require("ejoysdk_lua.res.ejoy_http_res_utils")
  local parent_path = EU.get_parent_folder(filepath)
  assert(M.File.make_dirs(parent_path), "make dirs error " .. tostring(parent_path))
  if type(append) == "number" then
    if append > 0 then
      append = true
    else
      append = false
    end
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
    js_log("writefile error!!! invalid data")
    return false
  end
  local is_write_succ = pcall(append and dy_fs.appendFileSync or dy_fs.writeFileSync, filepath, filedata)
  return is_write_succ, filepath
end

function File.readfile(filename, from_bundle)
  local path = string.format("%s/%s", user_dir_cache, filename)
  if from_bundle then
    do return _ejoysdk.lread end
    return _ejoysdk.lread, filename, filename, nil
  else
    local ret, data = pcall(dy_fs.readFileSync, path, "utf-8")
    return ret and data or nil
  end
end

function File.readfile_fullpath(filename)
  if not filename then
    return nil
  end
  local ret = dy_fs.readFileSync(filename, "utf-8")
  return ret
end

function File.process_exists(path)
  local ret, e = pcall(dy_fs.accessSync, path)
  _ejoysdk.log("File.process_exists result: ")
  js_log(ret, e)
  return ret
end

function File.process_is_directory(_file_path)
  local stat = dy_fs.statSync(_file_path)
  do return end
  return stat.isDirectory
end

function File.process_remove(file_path)
  dy_fs.removeSavedFile({
    filePath = file_path,
    success = function(res)
      local exists = File.process_exists(file_path)
      if exists then
        return false, ECC.EJOY_LIB_ERROR.FILE_REMOVE_FILE_FAILED, "remove file fail"
      end
      return true
    end,
    fail = function(res)
      return false, ECC.EJOY_LIB_ERROR.FILE_REMOVE_FILE_FAILED, res.errMsg or "remove file fail"
    end
  })
  return true
end

function File.process_batch_remove(list, cb)
  list = list or {}
  local list_size = #list
  if 0 == list_size and cb then
    cb(true)
  end
  for _, path in ipairs(list) do
    File.process_remove(path)
  end
  if cb then
    cb(true)
  end
end

function File.process_copy(src_fullpath, dst_fullpath, opts)
  local succ, code, msg
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  succ, code, msg = LUA_FILE.copy(src_fullpath, dst_fullpath, override)
  return succ, code, msg
end

function File.process_batch_copy(map, cb, opts)
  LUA_FILE.batch_src_dst_operation(map, File.process_copy, function(succ, code, msg, result_ext)
    if cb then
      cb(succ, code, msg, result_ext)
    end
  end, opts)
end

File.sep = "/"

function File.join(path)
  do return table.concat, path end
  return table.concat, path, File.sep
end

function File.dirname(path)
  local dirname = string.gsub(path, "(.*" .. File.sep .. ").*", "%1")
  return dirname
end

function File.process_rename(src_fullpath, dst_fullpath)
  if src_fullpath == dst_fullpath then
    return false, ECC.EJOY_LIB_ERROR.FILE_DST_PATH_SAME_WITH_SRC, "dst path same with src"
  end
  local Path = require("ejoysdk_lua.libs.path")
  Path.ensure_parent_dir(dst_fullpath)
  local ret, msg = pcall(dy_fs.renameSync, src_fullpath, dst_fullpath)
  if not ret then
    return false, ECC.EJOY_LIB_ERROR.FILE_RENAME_FAILED, msg
  else
    return true
  end
end

function File.process_batch_rename(map, cb)
  LUA_FILE.batch_rename(map, cb)
end

local function get_doc_path()
  return user_dir_cache
end

function File.release_bundle_res(src_path, dst_path, cb)
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

function File.unzip(src_path, dst_path, cb)
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

function File.unzip_full_path(src_full_path, dst_full_path, cb)
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

function File.zip(_src_file_path, _file_name, _dst_path, _cb)
end

function File.size(_src_path, _cb)
end

function File.is_support_handling_file_cache()
  if _ejoysdk.unzip and _ejoysdk.release_bundle_res and _ejoysdk.remove_files then
    return true
  else
    return false
  end
end

function File.process_make_dirs(dir)
  if File.process_exists(dir) then
    return true
  end
  js_log("make dirs: " .. dir)
  local ret, e = pcall(dy_fs.mkdirSync, dir, true)
  if not ret then
    js_log(e)
  end
  return ret
end

function File.file_md5(_path)
end

function File.process_md5(file_path)
  do return File.file_md5 end
  return File.file_md5, file_path
end

function File.process_batch_md5(file_list, cb)
  file_list = file_list or {}
  local succ_data = {}
  local fail_data = {}
  local last_err_code, last_err_msg
  for _, f in ipairs(file_list) do
    local md5_val, _code, _msg = File.process_md5(f)
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

function File.process_batch_info(file_list, cb, _opts)
  LUA_FILE.batch_info(file_list, cb, _opts)
end

function File.process_list_directory(_dir_path, _recursive, _cb)
  if _cb then
    _cb(nil)
  end
end

function File.process_list_bundle(_dir_path, _recursive, _cb)
  if _cb then
    _cb(nil)
  end
end

local KeyStore = {}
M.KeyStore = KeyStore
local PREFERENCES_NAME = "ejoysdk"
local kv_cache_dir = user_dir_cache .. "/ejoysdk/kv_store/"
local kv_cache_file_path = kv_cache_dir .. PREFERENCES_NAME .. ".json"

local function get_cache_from_file(key)
  local succ = pcall(dy_fs.accessSync, kv_cache_file_path)
  local val
  if not succ then
    return nil
  end
  local content = dy_fs.readFileSync(kv_cache_file_path, "utf8")
  local kv_json = JSON.safe_decode(content)
  if kv_json then
    val = kv_json[key]
  end
  return val
end

local function contains_key(keys, _key)
  for _, k in ipairs(keys) do
    if k == _key then
      return true
    end
  end
  return false
end

function KeyStore.get(key)
  local value = dy_api.getStorageSync(key)
  if "" == value then
    local res = dy_api.getStorageInfoSync()
    if not contains_key(res.keys, key) then
      local succ, val = pcall(get_cache_from_file, key)
      return succ and val or nil
    end
  end
  return value
end

local function set_cache_into_file(key, value)
  local succ = pcall(dy_fs.accessSync, kv_cache_dir)
  if not succ then
    dy_fs.mkdirSync(kv_cache_dir, true)
  end
  local is_file_exist = pcall(dy_fs.accessSync, kv_cache_file_path)
  local kv_store = {}
  if is_file_exist then
    local content = dy_fs.readFileSync(kv_cache_file_path, "utf8")
    kv_store = JSON.safe_decode(content)
  end
  kv_store[key] = value
  local json_content = JSON.encode(kv_store)
  dy_fs.writeFileSync(kv_cache_file_path, json_content, "utf8")
end

function KeyStore.set(key, value, _apply)
  if nil == value then
    return
  end
  local max_value_size = 1048576
  if max_value_size <= #tostring(value) then
    set_cache_into_file(key, value)
    return
  end
  local succ, err = pcall(dy_api.setStorageSync, key, value)
  if not succ then
    js_log("dy_api.setStorageSync failed: " .. tostring(err))
    set_cache_into_file(key, value)
  end
end

function KeyStore.delete(key)
  if nil == key then
    return
  end
  local res = dy_api.getStorageInfoSync()
  if contains_key(res.keys, key) then
    dy_api.removeStorageSync(key)
  else
    set_cache_into_file(key, nil)
  end
end

local function clear_cache_file()
  pcall(dy_fs.unlinkSync, kv_cache_file_path)
end

function KeyStore.clear()
  dy_api.clearStorageSync()
  clear_cache_file()
end

function KeyStore.get_group(_access_group)
  return nil
end

function KeyStore.set_group(_key, _access_group, _value)
end

function KeyStore.delete_group(_key, _access_group)
end

function KeyStore.clear_group(_access_group)
end

function KeyStore.custom_sub_dir(_sub_dir_param)
end

M.UnRecoverKeyStore = KeyStore
local SPRawKeyStore = {}

function SPRawKeyStore.get(sp_name, key)
  do return M.KeyStore.get end
  return M.KeyStore.get, sp_name .. key, key
end

function SPRawKeyStore.set(sp_name, key, value, _apply)
  M.KeyStore.set(sp_name .. key, value)
  return true
end

function SPRawKeyStore.delete(sp_name, key)
  M.KeyStore.delete(sp_name .. key)
end

M.SPRawKeyStore = SPRawKeyStore

function M.disable_embed_webview()
  return false
end

function M.check_compatibility()
  return true
end

function M.picker(_params, cb)
  cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
end

function M.get_game_id()
end

function M.get_url_open_datas()
  return {}
end

local function catch_args(func, ...)
  if func then
    xpcall(func, function(err)
      js_log("[wasmoon_async_callbacks] run error: ", err)
    end, ...)
  end
  return func
end

function M.tick()
  if not wasmoon_async_callbacks then
    return false
  end
  while catch_args(wasmoon_async_callbacks()) do
  end
  return true
end

local Toast = {}
M.Toast = Toast

function Toast.show(msg, opts)
  opts = opts or {}
  dy_api.showToast({
    title = msg,
    duration = opts.duration
  })
end

function Toast.hide()
  dy_api.hideToast()
end

local Modal = {}
M.Modal = Modal
local is_modal_opened = false

function Modal.open(title, option, cb)
  option = option or {}
  local params = {
    title = title,
    content = option.message,
    showCancel = false,
    success = function(res)
      js_log("res.confirm=" .. tostring(res.confirm) .. ", res.cancel=" .. tostring(res.cancel))
      is_modal_opened = false
      if cb then
        cb(res.confirm == true and 1 or 0)
      end
    end
  }
  if option.buttons and option.buttons[2] ~= nil then
    params.confirmText = option.buttons and option.buttons[2]
    params.showCancel = true
    params.cancelText = option.buttons and option.buttons[1]
  elseif option.buttons and option.buttons[1] ~= nil then
    params.confirmText = option.buttons and option.buttons[1]
  end
  is_modal_opened = true
  dy_api.showModal(params)
end

function Modal.close(cb)
  is_modal_opened = false
  if cb then
    cb()
  end
end

function Modal.alert(title, message, cb)
  local option = {
    message = message,
    buttons = {"确定"}
  }
  
  local function cb_wrap(_index)
    if cb then
      cb()
    end
  end
  
  Modal.open(title, option, cb_wrap)
end

function Modal.confirm(title, message, cb)
  local option = {
    message = message,
    buttons = {"取消", "确认"}
  }
  
  local function cb_wrap(index)
    cb(0 ~= index)
  end
  
  Modal.open(title, option, cb_wrap)
end

function Modal.is_opened()
  return is_modal_opened
end

local Loading = {}
M.Loading = Loading

function Loading.show(option)
  option = option or {}
  dy_api.showLoading(option)
end

function Loading.dismiss()
  dy_api.hideLoading()
end

function Loading.is_support_custom()
  return false
end

local ET = require("ejoysdk_lua.ejoysdk_topic")

function M.on_stop()
  ET.publish("app_on_stop")
end

function M.kill_app()
  js_log("kill_app begin")
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

function M.qrcode_scan(cb)
  js_log("qrcode_scan")
  _ejoysdk.dy.scanCode({
    complete = function(res)
      cb(res)
    end
  })
end

function M.support_save_to_album()
  return true
end

function M.save_to_album(_path, _need_delete, _cb)
  _ejoysdk.dy.saveImageToPhotosAlbum({
    filePath = _path,
    complete = function(res)
      if _need_delete then
        js_log("delete file " .. _path)
        dy_fs.unlink({filePath = _path})
      end
      _cb(res)
    end
  })
end

function M.get_cba_tweleve_info()
  return {}
end

function M.support_app_reviews()
  return false
end

function M.async_support_app_reviews(cb)
  if cb then
    cb(M.support_app_reviews())
  end
end

function M.app_reviews(_cb)
end

function M.comment_app()
end

function M.copy_clipboard(_params)
  _ejoysdk.dy.setClipboardData({
    data = _params.text
  })
  return {succ = true}
end

local QRCode = {}
M.QRCode = QRCode

function QRCode.gen_bmp(_text)
end

local Calendar = {}
M.Calendar = Calendar

function Calendar.add_event(_params, cb)
  if cb then
    cb(false, -1, "not support")
  end
end

function Calendar.delete_event(_params, cb)
  if cb then
    cb(false, -1, "not support")
  end
end

function Calendar.update_event(_params, cb)
  if cb then
    cb(false, -1, "not support")
  end
end

function Calendar.query_event(_params, cb)
  if cb then
    cb(false, -1, "not support")
  end
end

function Calendar.query_event_id(_params, cb)
  if cb then
    cb(false, -1, "not support")
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

function M.vibrate(milliseconds)
  if not milliseconds or -1 == milliseconds or milliseconds <= 15 then
    dy_api.vibrateShort({
      success = function(res)
        _ejoysdk.log("douyin vibrateShort success")
      end,
      fail = function(res)
        _ejoysdk.log("douyin vibrateShort fail")
      end
    })
    return
  end
  dy_api.vibrateLong({
    success = function(res)
      _ejoysdk.log("douyin vibrateLong success")
    end,
    fail = function(res)
      _ejoysdk.log("douyin vibrateLong fail")
    end
  })
end

function M.is_vibrate_support()
  return true
end

function M.get_system_properties(_key, _default_value)
end

function M.set_app_orientation(orientation)
  local val = "portrait"
  if 0 == orientation then
    val = "landscape"
  elseif 1 == orientation then
    val = "portrait"
  elseif 2 == orientation then
    js_log("not support orientation 2")
    return
  end
  _ejoysdk.dy.setDeviceOrientation({
    value = val,
    complete = function(res)
      js_log(res)
    end
  })
end

function Sysinfo.set_audio_category(_category)
end

function Sysinfo.get_audio_category()
end

function Sysinfo.set_audio_options(_category, _mode, _options, _fore_active)
end

function M.support_webview()
  return false
end

function M.scroll_log_file(_file_name)
end

function M.flush_log()
end

function M.is_log_file_support()
  return false
end

function M.get_log_file_infos()
end

function M.get_current_log_file()
end

function M.get_ej_debugable()
  return false
end

function M.get_ej_detail_debuggable()
  return false
end

function M.switch_to_game()
  return false
end

function M.set_pc_ad_token(_pc_ad_token)
end

function M.get_pc_ad_token()
end

function M.patch_dir()
end

function M.patch_files()
end

local Permission = {}
M.Permission = Permission

function Permission.check_permission_v2(permission, cb)
  Permission.detect_permission(permission, function(is_granted, has_res)
    if is_granted then
      cb(true)
    else
      js_log("detect failed before check:", has_res)
      _ejoysdk.dy.authorize({
        scope = permission,
        success = function(res)
          cb(true, res)
        end,
        fail = function(res)
          js_log("authorize failed:", res)
          cb(false, res)
        end
      })
    end
  end)
end

function Permission.detect_permission(permission, cb)
  _ejoysdk.dy.getSetting({
    success = function(res)
      local permissions = res.authSetting
      if permissions then
        if permissions[permission] then
          cb(true, res)
        else
          cb(false, res)
        end
      else
        cb(false)
      end
    end,
    fail = function(res)
      js_log(res)
      cb(false)
    end
  })
end

function Permission.openSetting(options)
  options = options or {}
  _ejoysdk.dy.openSetting({
    success = options.success,
    fail = options.fail,
    complete = function(res)
      js_log(res)
    end
  })
end

function Permission.openApplicationSetting()
  Permission.openSetting()
end

function Permission.support_compliance_check()
  return false
end

function Permission.async_support_compliance_check(cb)
  if cb then
    cb(M.Permission.support_compliance_check())
  end
end

function Permission.checkPermission()
end

function Permission.get_requested_permissions()
  return false
end

function Permission.async_get_requested_permissions(cb)
  local permissions = M.Permission.get_requested_permissions()
  cb(permissions)
end

function Permission.show_usage_dialog()
end

function M.open_privacy(_params)
  _ejoysdk.js_log("open_privacy dy minigame not support")
end

function M.require_privacy(_params)
  _ejoysdk.js_log("require_privacy dy minigame not support")
end

function M.subscribe_msg(options, cb)
  _ejoysdk.js_log("subscribe_msg")
  options = options or {}
  _ejoysdk.js_log(options)
  local meta = M.CONFIG.get_config("unisdk_meta")
  local template_id = meta.message_template_id
  assert(template_id, "sdkconfig.json message_template_id should not be nil")
  local tmplIds = {}
  table.insert(tmplIds, template_id)
  dy_api.requestSubscribeMessage({
    tmplIds = tmplIds,
    success = function(res)
      if "accept" == res[template_id] then
        local push_api = require("ejoysdk_lua.server_api.push_ex")
        push_api.inc_msg_subscribe("douyin", template_id)
        js_log("subscribe msg success:", res)
        cb(true, res)
      else
        js_log("subscribe msg fail:", res)
        cb(false, res)
      end
    end,
    fail = function(res)
      js_log("subscribe msg fail:", res)
      cb(false, res)
    end
  })
end

local _life_is_paused = false
_ejoysdk.dy.onShow(function(res)
  local result = res or {}
  result.life = "onForeground"
  _life_is_paused = true
  ET.publish("APP_LIFE_CIRCLE_EVENT", result)
end)
_ejoysdk.dy.onHide(function(res)
  local result = res or {}
  result.life = "onBackground"
  _life_is_paused = false
  ET.publish("APP_LIFE_CIRCLE_EVENT", result)
end)

function M.is_paused()
  return _life_is_paused
end

function M.get_pre_order_items(cb)
  cb = cb or function()
  end
  cb(false, "douyin", -1, "not support")
end

local WebView = {
  close = function()
  end,
  remove_cache = function(_url)
  end,
  capture = function(_callback)
  end,
  callback_js = function(_js_cb_id, _message, _ext)
  end,
  call_js = function(_script, _ext)
  end,
  is_opened = function()
  end,
  is_opened_async = function(_cb)
    _cb()
  end,
  go_back = function()
  end,
  go_forward = function()
  end,
  reload = function()
  end,
  show = function(_params)
  end,
  remove_hide_cache = function(_params)
  end,
  prepare = function(_params)
  end,
  update_toolbar = function(_params)
  end,
  update_toolbar_item = function(_params)
  end
}

function WebView.open(_url, _injection, _option, _on_js_callback, on_close_callback)
  _ejoysdk.log("douyin can not open WebView, biz url:" .. tostring(_url))
  if on_close_callback then
    on_close_callback()
  end
end

M.WebView = WebView
local WebSocket = Class:Inherit("WebSocket")
M.WebSocket = WebSocket
WebSocket.CONNECTING = 0
WebSocket.OPEN = 1
WebSocket.CLOSING = 2
WebSocket.CLOSED = 3

function WebSocket:_init(params)
  self.params = params
  _ejoysdk.log("create websocket to " .. tostring(params.url))
  self.ws_task = _ejoysdk.dy.connectSocket({
    url = params.url,
    header = params.header,
    protocols = params.protocols,
    success = function(res)
      js_log("connect success:", res)
    end,
    fail = function(res)
      js_log("connect fail:", res)
      if params.onerror then
        params.onerror({
          code = -1,
          reason = "connect fail"
        })
      end
    end,
    complete = function(res)
      js_log("connect complete:", res)
    end
  })
  if not self.ws_task then
    error("create websocket failed")
  end
  if params.onopen then
    self.ws_task:onOpen(function(res)
      js_log("onOpen:", res)
      do return params.onopen end
      return params.onopen, res, res
    end)
  end
  if params.onmessage then
    self.ws_task:onMessage(function(resp)
      local data = resp.data
      if type(data) ~= "string" then
        data = _wasmoon.tolstring(data)
      end
      params.onmessage(data)
    end)
  end
  if params.onclose then
    self.ws_task:onClose(function(res)
      js_log("onClose:", res)
      do return params.onclose end
      return params.onclose, res, res
    end)
  end
  if params.onerror then
    self.ws_task:onError(function(res)
      js_log("onError:", res)
      do return params.onerror end
      return params.onerror, res, res
    end)
  end
end

function WebSocket:send(data)
  if self:get_state() == WebSocket.OPEN then
    self.ws_task:send({
      data = _wasmoon.to_arraybuffer(data),
      success = function(res)
        js_log("send success:", res)
      end,
      fail = function(res)
        js_log("send fail:", res)
      end,
      complete = function(res)
        js_log("send complete:", res)
      end
    })
  else
    js_log("send failed:", self.state)
  end
end

function WebSocket:close()
  if self:get_state() == WebSocket.OPEN then
    _ejoysdk.log("close websocket by sdk")
    self.ws_task:close({
      code = 1000,
      reason = "close",
      success = function(res)
        js_log("close success:", res)
      end,
      fail = function(res)
        js_log("close fail:", res)
      end,
      complete = function(res)
        js_log("close complete:", res)
      end
    })
  else
    js_log("close failed:", self.state)
  end
end

function WebSocket:get_state()
  if self.ws_task then
    return self.ws_task.readyState
  end
end

return M

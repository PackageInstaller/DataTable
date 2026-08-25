local Channel = require("ejoysdk_lua.ejoysdk_channel")
local LUA_FILE = require("ejoysdk_lua.libs.luafile")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local CM = require("ejoysdk_lua.vm_channel.ejoy_vm_manager")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local SYNC_WEBVIEW_REMOVE_CACHE = "webview_remove_cache"
local jf = lunate.js_functions
_ejoysdk.log = jf.log
_ejoysdk.register_cb = jf.register_cb
local C = _ejoysdk.channel
local url_open_datas = {}
local gangplank_inited = false
local did_register_event = false
local global_request_task_tag = math.random(1000, 9999)
local ej_debuggable = false
local ej_detail_debuggable = false
local _Private = {}

function _ejoysdk.lread(filename)
  if filename:sub(1, 1) == "/" then
    if not LUA_FILE.exists(filename) then
      return nil
    end
    local fs = jf.import("@ohos.file.fs")
    local ret, file = pcall(fs.openSync, filename, fs.OpenMode.READ_ONLY)
    if ret then
      local stat = fs.statSync(file.fd)
      local buffer = lunate.create_array_buffer(stat.size)
      fs.readSync(file.fd, buffer)
      fs.closeSync(file.fd)
      local content = lunate.deepcopy(buffer)
      return content
    end
  else
    local function read_raw_file(_filename)
      local ctx = jf.get_context()
      
      do return ctx.resourceManager.getRawFileContentSync, ctx.resourceManager end
      return ctx.resourceManager.getRawFileContentSync, ctx.resourceManager, _filename
    end
    
    local ret, content = pcall(read_raw_file, filename)
    if ret then
      return content
    end
  end
end

local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local LANG = require("ejoysdk_lua.lang.util")
local _TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "HarmonyOS"
local M = {}
local vm_cbs = {}
local vm_cb_id = math.random(1000, 9999)
local channel
local CHANNEL_TYPE_CALL = 1
local CHANNEL_TYPE_CAST = 2
local CHANNEL_TYPE_RESP = 3
local CHANNEL_TYPE_ERROR = 4
local CHANNEL_TYPE_LUA_MODULE_CALL = 5
local CHANNEL_TYPE_LUA_MODULE_CALL_RESPONSE = 6
local CHANNEL_TYPE_ON_NATIVE_ASYNC_CALLBACK = 7

function _ejoysdk.register_ejoysdk_vm_func(t, cb)
  assert(type(t) == "string", "register callback type must be string: " .. tostring(t))
  vm_cbs[t] = cb
end

local channel_cache = {}

local function channel_push(...)
  if not channel then
    local msg = C.pack(...)
    table.insert(channel_cache, msg)
    return
  end
  local ret = channel:push(...)
  assert(ret, "ejoysdk channel full")
end

function M.async_call_once(fn_name, cb, ...)
  local id = vm_cb_id
  vm_cb_id = vm_cb_id + 1
  vm_cbs[id] = cb
  channel_push(CHANNEL_TYPE_CALL, fn_name, id, true, ...)
end

function M.set_native_async_callback(cb)
  local id = vm_cb_id
  vm_cb_id = vm_cb_id + 1
  vm_cbs[id] = cb
  return id
end

function M.async_call(fn_name, cb, ...)
  local id = vm_cb_id
  vm_cb_id = vm_cb_id + 1
  vm_cbs[id] = cb
  channel_push(CHANNEL_TYPE_CALL, fn_name, id, false, ...)
end

function M.async_cast(fn_name, ...)
  channel_push(CHANNEL_TYPE_CAST, fn_name, ...)
end

function M.async_load_module(module_name, cb)
  M.async_call_once("load_module", function(succ)
    if succ then
      _ejoysdk.log("load " .. tostring(module_name) .. " module success")
      if cb then
        cb(succ)
      end
    end
  end, module_name)
end

function M.impl_in_lua(fn_name, v_channel, v_type, params, _chunk)
  if "unisdk_cast" == fn_name and "AGORA" == v_channel then
    local FUNC_MAPS = require("ejoysdk_lua.harmonyos.ejoysdk_vm_vendor_func_maps")
    if FUNC_MAPS.is_impl_in_lua(v_channel, v_type) then
      local vm_func_vendor = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_agora")
      vm_func_vendor.cast(v_type, params, _chunk)
      return true
    end
  end
  return false
end

local harmony_utils_module_loaded = false

local function load_harmonyos_utils_module(cb)
  if true == harmony_utils_module_loaded then
    if cb then
      cb(true)
    end
    return
  end
  M.async_load_module("ejoysdk_lua.harmonyos.utils", function(succ)
    if succ then
      harmony_utils_module_loaded = true
      _ejoysdk.log("utils load succ")
    else
      _ejoysdk.log("utils load failed")
    end
    if cb then
      cb(succ)
    end
  end)
end

local function on_async_call(fn_name, id, once, ...)
  local cb = vm_cbs[fn_name]
  if cb then
    _ejoysdk.log("on call:" .. tostring(id))
    
    local function acb(...)
      channel_push(CHANNEL_TYPE_RESP, id, once, ...)
    end
    
    local ret, msg = pcall(cb, acb, ...)
    if not ret then
      channel_push(CHANNEL_TYPE_ERROR, id, msg)
      error(msg)
    end
  else
    _ejoysdk.log("recv error call: " .. fn_name .. ":" .. tostring(id))
  end
end

function M.async_call_lua_module(message)
  channel_push(CHANNEL_TYPE_LUA_MODULE_CALL, message)
end

local function on_async_lua_module_call(message)
  CM.on_receive_message(message)
end

function M.async_response_lua_module(func_id, callback_params)
  channel_push(CHANNEL_TYPE_LUA_MODULE_CALL_RESPONSE, func_id, callback_params)
end

local function on_async_lua_module_call_response(func_id, callback_params)
  CM.on_message_response(func_id, callback_params)
end

local function on_native_async_callback(cbid, msg)
  local cb = vm_cbs[cbid]
  _ejoysdk.log("on_native_async_callback cbid:" .. tostring(cbid) .. ", cb:" .. tostring(type(cb)))
  if cb then
    cb(msg)
  end
end

local function on_async_cast(fn_name, ...)
  local cb = vm_cbs[fn_name]
  if cb then
    cb(...)
  end
end

local function on_async_resp(id, once, ...)
  local cb = vm_cbs[id]
  if once then
    vm_cbs[id] = nil
  end
  if cb then
    cb(...)
  end
end

local function on_async_error(id, err)
  _ejoysdk.log("error at remote: " .. tostring(id) .. ":" .. err)
end

local callbacks = {
  [CHANNEL_TYPE_CALL] = on_async_call,
  [CHANNEL_TYPE_CAST] = on_async_cast,
  [CHANNEL_TYPE_RESP] = on_async_resp,
  [CHANNEL_TYPE_ERROR] = on_async_error,
  [CHANNEL_TYPE_LUA_MODULE_CALL] = on_async_lua_module_call,
  [CHANNEL_TYPE_LUA_MODULE_CALL_RESPONSE] = on_async_lua_module_call_response,
  [CHANNEL_TYPE_ON_NATIVE_ASYNC_CALLBACK] = on_native_async_callback
}

local function channel_callback(type, ...)
  callbacks[type](...)
end

if _ejoysdk.MAIN then
  channel = Channel.Channel:New()
end

function M.attach_channel(entry)
  channel = Channel.attach(entry)
  assert(channel, "attach channel failed")
  if channel_cache and next(channel_cache) then
    for _, msg in ipairs(channel_cache) do
      channel_push(C.unpack(msg))
    end
    channel_cache = {}
  end
end

function M.tick(once)
  if not channel then
    return
  end
  repeat
    if channel:pedding() > 0 then
      channel_callback(channel:pop())
    else
      return
    end
  until true == once
end

function M.vendor_native_init()
  local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
  local memory_map = jf.allocate_lua_memory()
  local is_harmony_vendor_native_init = memory_map.get("is_harmony_vendor_native_init")
  _ejoysdk.log("[vendor_native_init] is_harmony_vendor_native_init" .. tostring(is_harmony_vendor_native_init))
  if not is_harmony_vendor_native_init and _ejoysdk.MAIN then
    memory_map.set("is_harmony_vendor_native_init", true)
    local UNI = require("ejoysdk_lua.vendors.unisdk")
    local EV = require("ejoysdk_lua.ejoysdk_vendors")
    local sdk_infos = UNI.get_sdk_infos()
    if type(sdk_infos) ~= "table" then
      _ejoysdk.log("[vendor_native_init] get invalid sdk_infos")
      return
    end
    local success_vendors_num = 0
    local fail_vendors_num = 0
    local miss_vendors_num = 0
    local total_vendors_num = 0
    
    local function log_vendor_finish()
      if total_vendors_num ~= success_vendors_num + fail_vendors_num + miss_vendors_num then
        return
      end
      _ejoysdk.log("[vendor_native_init] all vendors pre_init finished, success_vendors_num=" .. tostring(success_vendors_num) .. ", fail_vendors_num=" .. tostring(fail_vendors_num) .. ", miss_vendors_num=" .. tostring(miss_vendors_num) .. ", total_vendors_num=" .. tostring(total_vendors_num))
      local statParams = {
        apus_only = true,
        total_vendors_num = total_vendors_num,
        success_vendors_num = success_vendors_num,
        fail_vendors_num = fail_vendors_num,
        miss_vendors_num = miss_vendors_num
      }
      ESTAT.stat_action("vendor_native_init_all_finished", nil, true, statParams)
    end
    
    for vendor_name, vendor_info in pairs(sdk_infos) do
      local vendor = EV.get(vendor_name)
      total_vendors_num = total_vendors_num + 1
      if vendor and type(vendor) == "table" and type(vendor.pre_init) == "function" then
        local function successCallback(is_success)
          _ejoysdk.log("[vendor_native_init] vendor " .. vendor_name .. " pre_init done, is_success: " .. tostring(is_success))
          
          ESTAT.stat_action("vendor_native_init_success", nil, true, {vendor_name = vendor_name, apus_only = true})
          success_vendors_num = success_vendors_num + 1
          log_vendor_finish()
        end
        
        xpcall(vendor.pre_init, function(error)
          _ejoysdk.log("[vendor_native_init] vendor " .. vendor_name .. " pre_init fail, error: " .. tostring(error))
          ESTAT.stat_action("vendor_native_init_fail", nil, false, {vendor_name = vendor_name, apus_only = true})
          fail_vendors_num = fail_vendors_num + 1
          log_vendor_finish()
        end, vendor_info, successCallback)
      else
        _ejoysdk.log("[vendor_native_init] vendor " .. vendor_name .. " pre_init method not found")
        miss_vendors_num = miss_vendors_num + 1
      end
    end
    log_vendor_finish()
  end
end

local _app_event_handler = {
  APP_AUDIO_MUTE_CHANGE_EVENT = function(mute_info)
    _ejoysdk.log("lua receive audio_mute_change, type=" .. tostring(mute_info.type) .. ", is_mute=" .. tostring(mute_info.isMute))
    ET.publish("audio_mute_change", mute_info)
  end
}

local function publish_urlopen(data)
  _ejoysdk.log("url_open, [v2]_app_event_handler, publish_data:" .. JSON.encode(data))
  ET.publish("urlopen_v2", "url", data)
  if data.url then
    _ejoysdk.log("url_open, _app_event_handler, publish_url:" .. data.url)
    ET.publish("urlopen", data.url)
  end
end

local function check_open_log(uri)
  if not uri then
    return
  end
  local uri_query_index = uri:find("?", 1, true)
  if not uri_query_index or uri_query_index <= 0 then
    return
  end
  local uri_query = uri:sub(uri_query_index + 1)
  if not uri_query then
    return
  end
  local Uri = require("ejoysdk_lua.libs.uri")
  local query_obj = Uri.parse_query(uri_query)
  if not query_obj.ejoysdk_debugable then
    return
  end
  local open_log_from_open_uri = query_obj.ejoysdk_debugable or false
  ej_debuggable = open_log_from_open_uri
  local open_detail_log_from_open_uri = query_obj.ej_detail_debuggable or false
  ej_detail_debuggable = open_detail_log_from_open_uri
  _ejoysdk.log("check_open_log:" .. tostring(ej_debuggable) .. ", ej_detail_debuggable:" .. tostring(ej_detail_debuggable) .. ", uri query:" .. tostring(uri_query) .. ", json:" .. tostring(JSON.encode(query_obj)))
end

local function on_handle_url_open(value)
  _ejoysdk.log("on_handle_url_open received:" .. tostring(value))
  value = JSON.decode(value)
  local data = value or {}
  check_open_log(data.url)
  if gangplank_inited then
    _ejoysdk.log("gangplank_inited publish_urlopen begin")
    publish_urlopen(data)
  else
    _ejoysdk.log("url_open, [v2]_app_event_handler, add cache:" .. JSON.encode(value))
    url_open_datas = url_open_datas or {}
    table.insert(url_open_datas, data)
    local ukeystore
    if M.get_url_data_keystore then
      ukeystore = M.get_url_data_keystore()
      ukeystore:set(url_open_datas)
    else
      local data_str = JSON.encode(url_open_datas)
      M.KeyStore.set("SDK_URL_OPEN_DATAS", data_str)
    end
  end
end

local _life_is_paused = false
if _ejoysdk.MAIN then
  channel:sync_main_channel_info()
  jf.register_listener({
    tick = M.tick,
    get_entry = function()
      do return channel.get_entry end
      return channel.get_entry, channel
    end,
    app_event = function(cbid, js_str, chunk)
      local handler = _app_event_handler[cbid]
      if handler then
        local value = JSON.safe_decode(js_str)
        handler(value, chunk)
      else
        _ejoysdk.log("app event handler not found")
      end
    end,
    on_url_open = function(value, _chunk)
      jf.utils():setTimeout(function()
        on_handle_url_open(value)
      end, 0)
    end,
    on_app_life_cycle = function(cbid, msg)
      _ejoysdk.log("APP_LIFE_CIRCLE_EVENT ----called")
      _ejoysdk.log("on_app_life_cycle cbid>>" .. tostring(cbid))
      _ejoysdk.log("on_app_life_cycle msg>>" .. msg)
      local result = JSON.decode(msg) or {}
      if result then
        _ejoysdk.log("receive lifecycle in ejoy vm:" .. tostring(result.life))
        if result.life == "onBackground" then
          _life_is_paused = true
        elseif result.life == "onForeground" then
          _life_is_paused = false
        end
        ET.publish("APP_LIFE_CIRCLE_EVENT", result)
        local CET = CM.cross_vm_require(CM.LUA_VM.GAME, "ejoysdk_lua.ejoysdk_topic")
        CET.publish("CROSS_VM_APP_LIFE_CIRCLE_EVENT", result)
      end
    end,
    vendor_native_init = M.vendor_native_init
  })
  require("ejoysdk_lua.harmonyos.ejoysdk_vm_func")
else
  jf.register_listener({
    on_attach = function(entry)
      M.attach_channel(entry)
    end,
    app_event = function(cbid, js_str, chunk)
      local handler = _app_event_handler[cbid]
      if handler then
        local value = JSON.safe_decode(js_str)
        handler(value, chunk)
      else
        _ejoysdk.log("app event handler not found")
      end
    end,
    on_url_open = function(value, _chunk)
      jf.utils():setTimeout(function()
        on_handle_url_open(value)
      end, 0)
    end
  })
  ET.subscribe("CROSS_VM_APP_LIFE_CIRCLE_EVENT", function(life_data)
    life_data = life_data or {}
    _ejoysdk.log("receive lifecycle in game vm:" .. tostring(life_data.life))
    if life_data.life == "onBackground" then
      _life_is_paused = true
    elseif life_data.life == "onForeground" then
      _life_is_paused = false
    end
    ET.publish("APP_LIFE_CIRCLE_EVENT", life_data)
  end)
end

function M.is_paused()
  return _life_is_paused
end

local cache_ext_stg_dir
M.PLATFORM = {
  OS = "HarmonyOS",
  HTTP_UA = "EjoySDK-http-client/0.1 (Linux; HarmonyOS)"
}

function M.invoke(_type, _params, _chunk)
  assert(false, "invoke not implemented on" .. _ejoysdk.os())
end

function M.register_async_cb(_type, _cb)
  assert(false, "register_async_cb not implemented on" .. _ejoysdk.os())
end

function M.printl(content)
  M.log({msg = content})
end

local harmony_ejoysdk_napi = jf and jf.get_ejoysdk_napi and jf.get_ejoysdk_napi() or nil

function M.is_support_function(func_name)
  if not func_name or "" == func_name then
    _ejoysdk.log("is_support_function failed, func_name invalid")
    return false
  end
  if func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS then
    return true
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.FILE_DIR_OPERATION then
    local _is_support = jf.utils().fileUtil and jf.utils().fileUtil.batchRemove ~= nil
    _ejoysdk.log("is_support_function is_support:" .. tostring(_is_support))
    return _is_support
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE_V1 then
    return nil ~= jf.download
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.DOWNLOAD_SINGLE_POOL then
    return false
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_PROGRESS_NOTIFICATION_NATIVE_ONLY then
    return false
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_MULTI_DOWNLOAD_REQUEST then
    return nil ~= jf.download and nil ~= jf.download().submitDownloadList
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.INIT_JF_FILE_CACHE then
    local is_napi_support = harmony_ejoysdk_napi and harmony_ejoysdk_napi.ejoy_log and nil ~= harmony_ejoysdk_napi.ejoy_log.ejoysdk_jflog_init or false
    _ejoysdk.log("harmony_ejoysdk_napi: " .. tostring(harmony_ejoysdk_napi) .. ", is_napi_support: " .. tostring(is_napi_support))
    return jf and jf.utils and jf.utils().jfFileUtil and nil ~= jf.utils().jfFileUtil.initJFFileCache and is_napi_support
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.ADD_CARLENDAR_EVENT then
    return nil ~= jf.import("@kit.CalendarKit.calendarManager")
  elseif func_name == M.NATIVE_SUPPORT_FUNCTION_NAMES.CUSTOM_LOADING then
    return jf and jf.utils and jf.utils().isSupportFunction and jf.utils().isSupportFunction(func_name) or false
  end
  return true
end

local _FileBatch = {}
local _FileCompat = {}
_ejoysdk.log("harmony batchRemove exists:" .. tostring(jf.utils().fileUtil and jf.utils().fileUtil.batchRemove) .. ", fu:" .. tostring(jf.utils().fileUtil))
do
  local is_support_batch = jf.utils().fileUtil and jf.utils().fileUtil.batchRemove ~= nil or false
  _ejoysdk.log("harmony load with support batch:" .. tostring(is_support_batch))
  local File
  if is_support_batch then
    File = _FileBatch
  else
    File = {}
  end
  setmetatable(File, {__index = _FileCompat})
  M.File = File
end

function _FileCompat.process_exists(path)
  do return LUA_FILE.exists end
  return LUA_FILE.exists, path
end

function _FileCompat.process_remove(file_path)
  local fs = jf.import("@ohos.file.fs")
  local ret
  local exists = M.File.process_exists(file_path)
  if not exists then
    _ejoysdk.log("process_remove skip, path not exists:" .. tostring(file_path))
    return true
  end
  local code, msg
  local is_dir = M.File.process_is_directory(file_path)
  local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
  if is_dir then
    ret = compat.xpcall(fs.rmdirSync, function(err)
      _ejoysdk.log("rmdirSync failed:" .. tostring(err))
      code = EC.EJOY_LIB_ERROR.DIR_REMOVE_FAILED
      msg = tostring(err)
    end, file_path)
  else
    ret = compat.xpcall(fs.unlinkSync, function(err)
      _ejoysdk.log("rmdirSync failed:" .. tostring(err))
      code = EC.EJOY_LIB_ERROR.FILE_REMOVE_FILE_FAILED
      msg = tostring(err)
    end, file_path)
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

function _FileCompat.process_rename(src_fullpath, dst_fullpath)
  do return LUA_FILE.rename, src_fullpath end
  return LUA_FILE.rename, src_fullpath, dst_fullpath
end

function _FileCompat.process_batch_rename(map, cb)
  LUA_FILE.batch_rename(map, cb)
end

function _FileCompat.process_copy(src_fullpath, dst_fullpath, opts)
  _ejoysdk.log("copy file: " .. tostring(dst_fullpath))
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  local ret, code, msg = LUA_FILE.copy(src_fullpath, dst_fullpath, override)
  return ret, code, msg
end

function _FileCompat.process_batch_copy(map, cb, opts)
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  LUA_FILE.batch_copy(map, cb, override)
end

function _FileCompat.process_md5(file_path)
  do return LUA_FILE.md5 end
  return LUA_FILE.md5, file_path
end

function _FileCompat.process_batch_md5(file_list, cb)
  LUA_FILE.batch_md5(file_list, cb)
end

function _FileCompat.process_batch_info(file_list, cb, opts)
  LUA_FILE.batch_info(file_list, cb, opts)
end

function _FileCompat.process_is_directory(_file_path)
  return false
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

function _FileCompat.get_ext_file_dir()
  if cache_ext_stg_dir and "" ~= cache_ext_stg_dir then
    return cache_ext_stg_dir
  end
  local context = jf.get_context()
  cache_ext_stg_dir = context.filesDir
  return cache_ext_stg_dir
end

function _FileCompat._test_reset_exit_file_dir()
  cache_ext_stg_dir = nil
end

function _FileCompat.writefile(filename, filedata, append, is_b64)
  local tmp_path = _FileCompat.get_ext_file_dir()
  if "" == tmp_path or nil == tmp_path then
    _ejoysdk.log("writefile failed, ext files dir is invalid,")
    return false
  end
  local path = string.format("%s/%s", tmp_path, filename)
  _ejoysdk.log("writefile path = " .. tostring(path))
  do return _FileCompat.writefile_fullpath, path, filedata, append end
  return _FileCompat.writefile_fullpath, path, filedata, append, is_b64
end

function _FileCompat.writefile_fullpath(full_path, filedata, append, is_b64)
  if type(append) == "number" then
    if append > 0 then
      append = true
    else
      append = false
    end
  end
  if "" == full_path or nil == full_path then
    _ejoysdk.log("writefile failed, full_path is invalid,")
    return false
  end
  _ejoysdk.log("writefile path = " .. tostring(full_path))
  local EU = require("ejoysdk_lua.res.ejoy_http_res_utils")
  local parent_path = EU.get_parent_folder(full_path)
  if M.is_support_function(M.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    M.File.make_dirs(parent_path)
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
  local file
  if true == append then
    file = io.open(full_path, "ab")
  else
    file = io.open(full_path, "wb")
  end
  if not file then
    _ejoysdk.log("writefile error!!! path = " .. tostring(full_path))
    return false
  end
  file:write(filedata)
  file:close()
  return true, full_path
end

function _FileCompat.readfile_fullpath(path)
  _ejoysdk.log("readfile fullpath = " .. tostring(path))
  do return _ejoysdk.lread end
  return _ejoysdk.lread, path, tostring(path), path
end

function _FileCompat.readfile(filename, from_bundle)
  if from_bundle then
    do return _ejoysdk.lread end
    return _ejoysdk.lread, filename, nil, nil, nil, nil
  end
  local tmp_path = _FileCompat.get_ext_file_dir()
  if "" == tmp_path or nil == tmp_path then
    _ejoysdk.log("readfile failed, external files dir is invalid,")
    return nil
  end
  local path = string.format("%s/%s", tmp_path, filename)
  _ejoysdk.log("readfile path = " .. tostring(path))
  do return _ejoysdk.lread end
  return _ejoysdk.lread, path, tostring(path), path
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

function _FileCompat.release_bundle_res(src_path, dst_path, _cb)
  if not jf.utils().fileUtil then
    if _cb then
      _cb({
        succ = false,
        msg = "not support"
      })
    end
    return
  end
  if src_path and dst_path and "" ~= src_path and "" ~= dst_path then
    local tmp_path = _FileCompat.get_ext_file_dir()
    if "" == tmp_path or nil == tmp_path then
      _ejoysdk.log("writefile failed, ext files dir is invalid,")
      if _cb then
        _cb({
          succ = false,
          msg = "ext file dir is invalid"
        })
      end
    end
    local dst_file_path = M.Path.join(tmp_path, dst_path)
    _ejoysdk.log("release_bundle_res dst path = " .. tostring(dst_file_path))
    _ejoysdk.log("release_bundle_res fileUtil:" .. tostring(type(jf.utils().fileUtil) .. ", releaseBundleRes:" .. tostring(jf.utils().fileUtil.releaseBundleRes)))
    jf.utils().fileUtil:releaseBundleRes(src_path, dst_file_path, function(result)
      local _succ = result.succ
      if _succ then
        _ejoysdk.log("release_bundle_res succ:" .. tostring(result.succ))
      else
        _ejoysdk.log("release_bundle_res failed, code:" .. tostring(result.code) .. ", msg:" .. tostring(result.msg))
      end
      if _cb then
        _cb(result)
      end
    end)
  elseif _cb then
    _cb({
      succ = false,
      msg = "参数错误"
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
    load_harmonyos_utils_module(function(succ)
      if succ then
        M.async_call_once("unzip", function(succ2, ...)
          if succ2 then
            _ejoysdk.log("unzip_full_path succ")
            cb({succ = true})
          else
            local _code, _msg = ...
            _ejoysdk.log("unzip_full_path failed, code:" .. tostring(_code) .. ", _msg:" .. tostring(_msg))
            cb({
              succ = true,
              code = _code,
              msg = _msg
            })
          end
        end, src_full_path, dst_full_path)
      else
        _ejoysdk.log("unzip_full_path failed, for load utils module failed")
        cb({
          succ = true,
          code = EC.EJOYSDK_ERROR_CODES.HARMONY_MODULE_LOAD_FAILED,
          msg = "load utils module failed"
        })
      end
    end)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.zip(_src_file_path, _file_name, _dst_path, _cb)
end

function _FileCompat.size(_src_path, _cb)
end

function _FileCompat.is_support_handling_file_cache()
  return true
end

function _FileCompat.process_make_dirs(_path)
  local fs = jf.import("@ohos.file.fs")
  local access_ret, is_dir_exist = pcall(fs.accessSync, _path)
  if access_ret and is_dir_exist then
    return true
  end
  local ret = pcall(fs.mkdirSync, _path, true)
  return ret
end

_Private.sys_dirs = nil

function _FileCompat.get_sys_dirs()
  if _Private.sys_dirs then
    return _Private.sys_dirs
  end
  local context = jf.get_context()
  local internal_app_files_dir = context.filesDir
  local EU = require("ejoysdk_lua.res.ejoy_http_res_utils")
  local internal_app_root_dir = EU.get_parent_folder(internal_app_files_dir)
  local paths = {
    internal_app_files_dir = internal_app_files_dir,
    internal_app_root_dir = internal_app_root_dir,
    external_app_files_dir = internal_app_files_dir,
    external_root_dir = internal_app_root_dir,
    internal_downloads_dir = internal_app_root_dir .. "cache"
  }
  _Private.sys_dirs = paths
  return paths
end

function _FileCompat.file_md5(path)
  do return M.File.process_md5 end
  return M.File.process_md5, path
end

local HTTP = {}
M.HTTP = HTTP

function HTTP.get_headers(_url, _params, _cb)
end

function HTTP.add_cert(_ca_name, _ca_chunk, _cb)
end

function HTTP.add_cert_pin(_host_pattern, _ca_name, _ca_chunk, _cb)
end

local function gen_request_tag()
  local request_tag = global_request_task_tag
  global_request_task_tag = global_request_task_tag + 1
  return "ejoy_http_" .. tostring(request_tag)
end

function HTTP.submit_download_list(list, file_ext, opts, submit_cb, single_cb, single_progress_cb, single_header_cb)
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local list_str = CJSON.encode(list)
  local dest_file_name = "ejoy_download_temp/_download_submit_list" .. tostring(M.system_clock()) .. ".json"
  local write_result = M.File.writefile(dest_file_name, list_str)
  local file_path, list_data
  if write_result then
    file_path = M.Path.join(_FileCompat.get_ext_file_dir(), dest_file_name)
    _ejoysdk.log("submit_download_list use file_path:" .. tostring(file_path))
  else
    list_data = list
    _ejoysdk.log("submit_download_list use list cnt:" .. tostring(#list))
  end
  jf.download():submitDownloadList({
    list = list_data,
    file = file_path,
    file_ext = file_ext,
    opts = opts
  }, function(succ, ...)
    _ejoysdk.log("start_download succ:" .. tostring(succ))
    local code, msg
    if not succ then
      code, msg = ...
      _ejoysdk.log("submitDownloadList result failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    else
      _ejoysdk.log("submitDownloadList result succ")
    end
    if submit_cb then
      submit_cb(succ, code, msg)
    end
  end, {
    resp_cb = function(task_id, resp)
      _ejoysdk.log("start_download resp:" .. tostring(resp))
      local resp_obj = CJSON.decode(resp)
      resp_obj.headers = HTTP.Header.New(resp_obj.headers)
      single_cb(task_id, resp_obj)
    end,
    header_cb = function(task_id, data)
      local data_json = CJSON.decode(data) or {}
      single_header_cb(task_id, HTTP.Header.New(data_json.headers))
    end,
    progress_cb = function(task_id, data)
      local progress_info = CJSON.decode(data) or {}
      local received = progress_info.received
      local total = progress_info.total
      local headers = progress_info.headers
      local file = progress_info.file
      local url = progress_info.url
      single_progress_cb(task_id, url, file, received, total, headers)
    end
  })
end

function HTTP.update_download_priority(_task_id_priority_map, _cb)
end

function HTTP.process_get(url, params, cb)
  params = params or {}
  _ejoysdk.log("HTTP GET: " .. url)
  if not params.file then
    local headers = params.headers or {}
    local http = jf.import("@ohos.net.http")
    local httpRequest = http.createHttp()
    local options = {
      method = "GET",
      header = headers,
      expectDataType = 2,
      connectTimeout = 20000,
      readTimeout = 20000,
      usingCache = false,
      priority = 1,
      maxLimit = 104857600
    }
    httpRequest:request(url, options, function(err, _data)
      if not err then
        local data = lunate.deepcopy(_data)
        local info = {
          headers = HTTP.Header.New(data.header),
          status = data.responseCode,
          body = data.result
        }
        cb(info)
      else
        cb({
          status = err.code
        })
      end
      httpRequest:destroy()
    end)
  elseif not jf.download then
    _ejoysdk.log("download with old request library")
    local HTTP_UTIL = require("ejoysdk_lua.harmonyos.harmonyos_http_download")
    HTTP_UTIL.download("GET", url, params, cb)
  else
    _ejoysdk.log("download with new rcp library begin")
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
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    jf.download():start({url = url, params = params}, function(resp)
      _ejoysdk.log("start_download resp:" .. tostring(resp))
      local resp_obj = CJSON.decode(resp)
      resp_obj.headers = HTTP.Header.New(resp_obj.headers)
      cb(resp_obj)
    end, {
      header_cb = function(data)
        local data_json = CJSON.decode(data) or {}
        if header_cb then
          header_cb(data_json.headers)
        end
      end,
      progress_cb = function(data)
        local progress_info = CJSON.decode(data) or {}
        local received = progress_info.received
        local total = progress_info.total
        local headers = progress_info.headers
        if progress then
          progress(url, params.file, received, total, headers)
        end
        if -1 == received and finish_cb then
          finish_cb()
        end
      end
    })
  end
end

function HTTP.process_post(url, params, content_type, body, cb)
  params = params or {}
  _ejoysdk.log("HTTP POST: " .. url)
  local headers = params.headers or {}
  if not params.file then
    local form_data_list
    if params.safe_formdata and next(params.safe_formdata) then
      content_type = "multipart/form-data"
      form_data_list = {}
      headers["content-type"] = content_type
      for _, form_data in ipairs(params.safe_formdata) do
        local ohos_from_data = {
          name = form_data.name,
          contentType = form_data.content_type,
          data = form_data.data,
          filePath = form_data.file_path,
          remoteFileName = form_data.file_name
        }
        table.insert(form_data_list, ohos_from_data)
      end
    end
    if content_type and (M.Utils.start_with(content_type, "multipart/form-data") or M.Utils.start_with(content_type, "application/octet-stream")) then
      body = lunate.to_array_buffer(body)
    end
    local http = jf.import("@ohos.net.http")
    local httpRequest = http.createHttp()
    local options = {
      method = "POST",
      header = headers,
      extraData = body,
      expectDataType = 2,
      connectTimeout = 20000,
      readTimeout = 20000,
      usingCache = false,
      multiFormDataList = form_data_list,
      priority = 1,
      maxLimit = 104857600
    }
    httpRequest:request(url, options, function(err, _data)
      if not err then
        local data = lunate.deepcopy(_data)
        local info = {
          headers = HTTP.Header.New(data.header),
          status = data.responseCode,
          body = data.result
        }
        cb(info)
      else
        cb({
          status = err.code
        })
      end
      httpRequest:destroy()
    end)
  else
    local HTTP_UTIL = require("ejoysdk_lua.harmonyos.harmonyos_http_download")
    HTTP_UTIL.download("POST", url, params, cb)
  end
end

function HTTP.process_stop(task_id_arr, _params, cb)
  jf.download():stop({taskIdArr = task_id_arr}, function(succ, ...)
    _ejoysdk.log("process_stop succ:" .. tostring(succ))
    if cb then
      cb(succ, ...)
    end
  end)
end

function HTTP.unregister_progress_cb(_task_id)
end

function HTTP.http_remove_cache()
end

function HTTP.http_enable_cache()
end

function HTTP.update_with_config(params)
  jf.download():updateConfig(params)
end

local KEYSTORE_KEY = "ejoysdk"
local KeyStore = {}
M.KeyStore = KeyStore

function KeyStore.get(key)
  if nil == key then
    return
  end
  local preference = jf.utils().preference
  local ctx = jf.get_context()
  do return preference.get, preference, ctx, KEYSTORE_KEY end
  return preference.get, preference, ctx, KEYSTORE_KEY, key
end

function KeyStore.get_group(_access_group)
  return nil
end

function KeyStore.set(key, value)
  if nil == value or nil == key or type(value) == "table" then
    return
  end
  local preference = jf.utils().preference
  local ctx = jf.get_context()
  
  local function fun(...)
    preference:set(...)
  end
  
  do return pcall, fun, ctx, KEYSTORE_KEY, key end
  return pcall, fun, ctx, KEYSTORE_KEY, key, value
end

function KeyStore.set_group(_key, _access_group, _value)
end

function KeyStore.delete(key)
  if nil == key then
    return
  end
  local preference = jf.utils().preference
  local ctx = jf.get_context()
  do return preference.delete, preference, ctx, KEYSTORE_KEY end
  return preference.delete, preference, ctx, KEYSTORE_KEY, key
end

function KeyStore.delete_group(_key, _access_group)
end

function KeyStore.clear()
  local preference = jf.utils().preference
  local ctx = jf.get_context()
  do return preference.clear, preference, ctx end
  return preference.clear, preference, ctx, KEYSTORE_KEY
end

function KeyStore.clear_group(_access_group)
end

function KeyStore.custom_sub_dir(_sub_dir_param)
end

M.UnRecoverKeyStore = KeyStore
local SPRawKeyStore = {}

function SPRawKeyStore.get(sp_name, key)
  if nil == sp_name or nil == key then
    return
  end
  local preference = jf.utils().preference
  local ctx = jf.get_context()
  do return preference.get, preference, ctx, sp_name end
  return preference.get, preference, ctx, sp_name, key
end

function SPRawKeyStore.set(sp_name, key, value, _apply)
  if nil == value or nil == sp_name then
    return
  end
  local preference = jf.utils().preference
  local ctx = jf.get_context()
  do return preference.set, preference, ctx, sp_name, key end
  return preference.set, preference, ctx, sp_name, key, value
end

function SPRawKeyStore.delete(sp_name, key)
  if nil == key or nil == sp_name then
    return
  end
  local preference = jf.utils().preference
  local ctx = jf.get_context()
  do return preference.delete, preference, ctx, sp_name end
  return preference.delete, preference, ctx, sp_name, key
end

M.SPRawKeyStore = SPRawKeyStore
local WebView = {}
M.WebView = WebView

function WebView.open(url, injection, option, on_js_callback, on_close_callback)
  local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
  do return EWB.add_webview, url, injection, option, on_js_callback end
  return EWB.add_webview, url, injection, option, on_js_callback, on_close_callback
end

function WebView.close()
  M.async_cast("webview_close")
end

function WebView.capture(_callback)
  local ejoy_vm_func = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func")
  ejoy_vm_func.capture_webview(function(succ, ...)
    local result_obj = {}
    result_obj.body = {}
    if succ then
      _ejoysdk.log("capture image succ")
      local uri = (...)
      result_obj.code = 0
      result_obj.body.img_uri = uri
    else
      local code, msg = ...
      result_obj.code = -1
      result_obj.body.err_code = code
      result_obj.body.err_msg = msg
      _ejoysdk.log("capture image failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    if _callback then
      _callback(result_obj)
    end
  end)
end

function WebView.callback_js(js_cb_id, message, ext)
  M.async_cast("webview_callback_js", js_cb_id, message, ext)
end

function WebView.call_js(_script, _ext)
end

function WebView.is_opened()
  if jf.webview then
    do return jf.webview().isOpened end
    return jf.webview().isOpened, (jf.webview())
  end
  return false
end

function WebView.is_opened_async(cb)
  M.async_call_once("webview_is_opened", function(_is_opened)
    cb(_is_opened)
  end)
end

function WebView.go_back()
  M.async_cast("webview_go_back")
end

function WebView.go_forward()
  M.async_cast("webview_go_forward")
end

function WebView.reload()
  M.async_cast("webview_reload")
end

function WebView.show(_params)
end

function WebView.hide(_params)
end

function WebView.remove_hide_cache(_params)
end

function WebView.prepare(_params)
end

function WebView.update_toolbar(_toolbar_config)
end

function WebView.update_toolbar_item(_params)
end

function WebView.remove_cache(url)
  local ejoysdk_web = require("ejoysdk_lua.ejoysdk_web")
  ejoysdk_web.webview_remove_cache_callback(url)
  local jsonStr = JSON.encode({url = url})
  M.async_call_once(SYNC_WEBVIEW_REMOVE_CACHE, function()
  end, jsonStr)
end

function M.get_url_open_datas()
  M.ability_report("get_url_open_datas")
  local last_openurl_data = M.get_last_openurl_data()
  if last_openurl_data and next(last_openurl_data) then
    return last_openurl_data
  else
    local UTILS = require("ejoysdk_lua.ejoysdk_utils")
    return UTILS.deepcopy(url_open_datas) or {}
  end
end

function M.get_last_openurl_data()
  local last_openurl_data_str = jf.get_last_open_url_data()
  local last_open_url_data = JSON.decode(last_openurl_data_str)
  if last_open_url_data then
    return last_open_url_data
  else
    return {}
  end
end

local function init_handler()
  if false == gangplank_inited then
    gangplank_inited = true
  end
  if url_open_datas and 0 == #url_open_datas or nil == url_open_datas then
    local ukeystore = M.get_url_data_keystore()
    if ukeystore then
      url_open_datas = ukeystore:get()
      ukeystore:delete()
    end
    M.KeyStore.delete("SDK_URL_OPEN_DATAS")
  end
  if url_open_datas then
    for _, data in pairs(url_open_datas) do
      publish_urlopen(data)
    end
  end
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

local function register_event()
  if did_register_event then
    return
  end
  did_register_event = true
  ET.subscribe(ET.gangplank.INITED, init_handler)
  ET.subscribe(ET.gangplank.VENDOR_LOGIN_BEGIN, on_vendor_login_begin)
  ET.subscribe(ET.gangplank.VENDOR_LOGIN_END, on_vendor_login_end)
end

register_event()
local last_network_type

function M.is_support_ejoy_style_alert()
  return true
end

local Modal = {}
M.Modal = Modal

function Modal.open(title, option, cb)
  local module = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func")
  is_modal_opened = true
  module.modal_open(title, option, function(...)
    is_modal_opened = false
    if cb then
      cb(...)
    end
  end)
end

function Modal.close(cb)
  M.async_cast("modal_close")
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

function Toast.show(message, _option)
  local promptAction = jf.import("@ohos.promptAction")
  promptAction.showToast({message = message, duration = 2000})
end

function Toast.hide()
end

local Loading = {}
M.Loading = Loading

function Loading.show(params, cb)
  local loading = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_loading")
  loading.show(params, cb)
end

function Loading.dismiss()
  local loading = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_loading")
  loading.dismiss()
end

function Loading.is_support_custom()
  do return M.is_support_function end
  return M.is_support_function, M.NATIVE_SUPPORT_FUNCTION_NAMES.CUSTOM_LOADING
end

local device_static_info_list

local function get_device_info_list()
  if not jf.utils().getDeviceInfoList then
    _ejoysdk.log("get_device_info_list not support")
    return {}
  end
  if not device_static_info_list then
    device_static_info_list = lunate.deepcopy(jf.utils():getDeviceInfoList())
  end
  return device_static_info_list
end

function M.get_device_info_list()
  do return end
  return get_device_info_list, nil
end

local Sysinfo = {}
M.Sysinfo = Sysinfo

function Sysinfo.utdid()
  return get_device_info_list().utdid
end

local oaid = ""

function Sysinfo.oaid()
  if "" == oaid then
    oaid = jf.utils():getOaid()
    M.log("get oaid is " .. tostring(oaid))
  end
  return oaid
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

function Sysinfo.oaid_async(cb)
  local _oaid = Sysinfo.oaid()
  if _oaid and "" ~= _oaid then
    if cb then
      cb(_oaid)
    end
  elseif jf.utils().getOaidAsync then
    jf.utils():getOaidAsync(function(oaid2)
      if cb then
        cb(oaid2)
      end
    end)
  end
end

function Sysinfo.app_name()
  return get_device_info_list().app_name
end

function Sysinfo.app_version_code()
  return get_device_info_list().app_version_code
end

function Sysinfo.app_version_name()
  return get_device_info_list().app_version
end

function Sysinfo.os_version()
  return get_device_info_list().os_version
end

function Sysinfo.install_time()
  return get_device_info_list().app_install_time
end

function Sysinfo.update_time()
  return get_device_info_list().app_update_time
end

function Sysinfo.model()
  return get_device_info_list().model
end

function Sysinfo.brand()
  return get_device_info_list().brand
end

function Sysinfo.package_name()
  return get_device_info_list().pkg_name
end

function Sysinfo.package_type()
  return -1
end

function Sysinfo.screen_width()
  return get_device_info_list().width
end

function Sysinfo.screen_height()
  return get_device_info_list().height
end

function Sysinfo.is_passive_mode()
  return true
end

function Sysinfo.content_size(_cb)
  local vm_func = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func")
  vm_func.get_stage_window_size(function(size_obj)
    if not size_obj then
      _ejoysdk.log("content_size failed, size obj is nil")
      local default_width = Sysinfo.screen_width()
      local default_height = Sysinfo.screen_height()
      _cb(default_width, default_height)
    else
      _ejoysdk.log("content_size succ")
      _cb(size_obj.width, size_obj.height)
    end
  end)
end

function Sysinfo.is_simulator()
  local device_info = get_device_info_list()
  return device_info.model == "emulator" or "emulator" == device_info.cpu_model
end

function Sysinfo.density()
  return get_device_info_list().dp
end

function Sysinfo.get_boot_time()
  return get_device_info_list().boot
end

function Sysinfo.get_cpu_detail()
  return get_device_info_list().cpu
end

function Sysinfo.get_cpu_model()
  return get_device_info_list().cpu_model
end

function Sysinfo.get_cpu_max_freq()
  return -1
end

function Sysinfo.is_accessibility_enable()
  return get_device_info_list().acc
end

function Sysinfo.is_param_mod_inuse()
  return get_device_info_list().mod
end

function Sysinfo.is_qemu_device()
  return false
end

function Sysinfo.is_adb_enabled()
  return false
end

function Sysinfo.get_app_install_time()
  return get_device_info_list().appins
end

local user_agent

function Sysinfo.get_user_agent()
  if user_agent then
    return user_agent
  else
    M.Sysinfo.get_user_agent_async(function(_user_agent)
      user_agent = _user_agent
    end)
  end
end

function Sysinfo.get_user_agent_async(cb)
  if not channel then
    return
  end
  M.async_call_once("sysinfo_get_user_agent", cb)
end

function Sysinfo.is_xposed_installed()
  return false
end

function Sysinfo.get_ejoy_referer()
  return ""
end

function Sysinfo.is_app_install(_package_name)
  return false
end

function Sysinfo.open_app(_package_name)
  return false
end

function Sysinfo.can_resolve_activity(_package_name, _package_activity_name)
  return false
end

function Sysinfo.get_system_install_time()
end

function Sysinfo.get_cpu_cores_count()
  return get_device_info_list().cores or -1
end

function Sysinfo.get_manufacturer()
  return get_device_info_list().mt
end

function Sysinfo.get_disk_info_async(cb)
  if cb then
    cb(false, -1, "only windows support")
  end
end

function Sysinfo.get_cpu_id()
  return get_device_info_list().cpu_model
end

function Sysinfo.is_device_root()
  return false
end

function Sysinfo.android_id()
  return get_device_info_list().android_id
end

function Sysinfo.ds_channel_id()
  return "998233"
end

function Sysinfo.ds_sub_channel_id()
  return get_device_info_list().ds_sub_ch_id
end

function Sysinfo.country()
  return get_device_info_list().country
end

function Sysinfo.language()
  return get_device_info_list().language
end

function Sysinfo.language_script()
  return get_device_info_list().language_script
end

function Sysinfo.time_zone()
  return get_device_info_list().time_zone
end

function Sysinfo.sysinfo_ios_app_on_mac()
  return false
end

function Sysinfo.idfa()
  do return end
  return M.Sysinfo.utdid, nil
end

function Sysinfo.device_with_android_id()
  do return end
  return M.Sysinfo.utdid, nil
end

function Sysinfo.uuid()
  return get_device_info_list().uuid
end

function Sysinfo.screen()
  return {
    width = get_device_info_list().width,
    height = get_device_info_list().height,
    scale = get_device_info_list().dp
  }
end

function Sysinfo.cpu_usage(_cb)
  if not jf.utils().getCpuUsage then
    if _cb then
      _cb({succ = false})
    end
    return
  end
  local ret = lunate.deepcopy(jf.utils():getCpuUsage())
  if _cb then
    _cb(ret)
  end
end

function Sysinfo.cpu_start_monitor()
end

function Sysinfo.cpu_stop_monitor()
end

function Sysinfo.cpu_monitor_enable()
  return false
end

function Sysinfo.memory()
  if not jf.utils().getMemoryInfo then
    return {}
  end
  do return lunate.deepcopy, jf.utils():getMemoryInfo() end
  return lunate.deepcopy, jf.utils():getMemoryInfo()
end

function Sysinfo.memory_info()
  return {}
end

function Sysinfo.memory_detail(cb)
  if not jf.utils().getMemoryDetail then
    _ejoysdk.log("memory_detail not support")
    if cb then
      cb({})
    end
    return
  end
  local ret = jf.utils():getMemoryDetail()
  if cb then
    cb(lunate.deepcopy(ret))
  end
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

function Sysinfo.storage()
  local statvfs = lunate.import("@ohos.file.statvfs")
  local available_size = statvfs.getFreeSizeSync("/data/storage/el1/bundle")
  return {availableInternalStorage = available_size}
end

function Sysinfo.async_storage(cb)
  cb(Sysinfo.storage())
end

function Sysinfo.get_storage_info()
  local statvfs = lunate.import("@ohos.file.statvfs")
  local available_size = statvfs.getFreeSizeSync("/data/storage/el1/bundle")
  local total_size = statvfs.getTotalSizeSync("/data/storage/el1/bundle")
  return {
    internal_total_storage_size = total_size,
    internal_available_storage_size = available_size,
    external_total_storage_size = total_size,
    external_available_storage_size = available_size
  }
end

function Sysinfo.async_get_storage_info(cb)
  cb(Sysinfo.get_storage_info())
end

function Sysinfo.opengl()
end

function Sysinfo.open_url(_url)
  local context = jf.get_context()
  local wantInfo = {
    action = "ohos.want.action.viewData",
    uri = _url
  }
  context:startAbility(wantInfo)
end

function Sysinfo.can_open_url(_url)
  return true
end

function Sysinfo.async_can_open_url(_url, _cb)
  _cb(true)
end

function Sysinfo.battery()
  local batteryInfo = jf.import("@ohos.batteryInfo")
  local level = batteryInfo.batterySOC
  local scale = 100
  local charging_status = batteryInfo.chargingStatus
  local status = charging_status
  if 1 == charging_status then
    status = 2
  elseif 2 == charging_status then
    status = 1
  end
  return {
    level = level,
    scale = scale,
    status = status
  }
end

function Sysinfo.battery_v2(cb)
  cb(M.Sysinfo.battery())
end

function Sysinfo.battery_ext(_filter, cb)
  local filter = _filter or {}
  local map_filter = {}
  for _, v in pairs(filter) do
    map_filter[v] = true
  end
  local batteryInfo = jf.import("@ohos.batteryInfo")
  local ret = {}
  if map_filter.temperature then
    ret.temperature = batteryInfo.batteryTemperature / 10
  end
  if map_filter.voltage then
    ret.voltage = batteryInfo.voltage / 1000000
  end
  cb(ret)
end

function Sysinfo.launch_battery()
  do return end
  return M.Sysinfo.battery, nil
end

function Sysinfo.wifi_async(cb)
  local vm_func = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func")
  vm_func.get_wifi_info(function(wifi_data)
    if cb then
      _ejoysdk.log("wifi result>>")
      M.log(wifi_data)
      cb(wifi_data)
    end
  end)
end

function Sysinfo.mobile_info()
  return {}
end

function Sysinfo.mobile_info_async(cb)
  local radio = jf.import("@ohos.telephony.radio")
  local sim = jf.import("@ohos.telephony.sim")
  radio.getPrimarySlotId().Then(function(slot_id)
    sim.getSimOperatorNumeric(slot_id).Then(function(operator)
      local mcc = string.sub(operator, 1, 3)
      local mnc = string.sub(operator, 4)
      cb({
        mcc = mcc,
        mnc = mnc,
        operator = operator
      })
    end).catch(function()
      cb({})
    end)
  end).catch(function()
    cb({})
  end)
end

function Sysinfo.is_vpn_connected()
  local connection = jf.import("@ohos.net.connection")
  local netHandle = connection.getDefaultNetSync()
  if 0 == netHandle.netId then
    return false
  else
    return jf.utils().isVpnConnected and jf.utils():isVpnConnected() or false
  end
end

function Sysinfo.network_type()
  local connection = jf.import("@ohos.net.connection")
  local netHandle = connection.getDefaultNetSync()
  if 0 == netHandle.netId then
    return 0
  else
    local netCapabilities = connection.getNetCapabilitiesSync(netHandle)
    local bearTypes = netCapabilities.bearerTypes
    if bearTypes and nil ~= bearTypes[1] then
      if 0 == bearTypes[1] then
        return 2
      elseif 1 == bearTypes[1] then
        return 1
      else
        return 3
      end
    else
      return 3
    end
  end
end

function Sysinfo.network_type_cache()
  if nil == last_network_type then
    last_network_type = M.Sysinfo.network_type()
  end
  return last_network_type
end

local function get_signal_type()
  local radio = jf.import("@ohos.telephony.radio")
  local signal_type
  local signal_informations_slot0 = radio.getSignalInformationSync(0)
  if signal_informations_slot0 and signal_informations_slot0[1] then
    signal_type = signal_informations_slot0[1].signalType
  else
    local signal_informations_slot1 = radio.getSignalInformationSync(1)
    if signal_informations_slot1 and signal_informations_slot1[1] then
      signal_type = signal_informations_slot1[1].signalType
    end
  end
  return signal_type
end

function Sysinfo.network_type_name()
  local network_type = M.Sysinfo.network_type()
  if 1 == network_type then
    return "wifi"
  elseif 2 == network_type then
    local signal_type = get_signal_type()
    local net_work_type = {
      [1] = "2g",
      [2] = "2g",
      [3] = "3g",
      [4] = "3g",
      [5] = "4g",
      [6] = "5g"
    }
    if signal_type and signal_type > 0 and net_work_type[signal_type] then
      return net_work_type[signal_type]
    else
      return "unknown"
    end
  else
    return "unknown"
  end
end

function Sysinfo.network_current_state()
  local network_type = M.Sysinfo.network_type()
  if 0 == network_type then
    return 0
  elseif 1 == network_type then
    return 2
  elseif 3 == network_type then
    return 1
  end
  local signal_type = get_signal_type()
  local network_state = {
    [1] = 3,
    [2] = 3,
    [3] = 4,
    [4] = 4,
    [5] = 5,
    [6] = 6
  }
  if signal_type and network_state[signal_type] then
    return network_state[signal_type]
  else
    return 1
  end
end

function Sysinfo.network_current_state_async(cb)
  cb({
    succ = true,
    state = M.Sysinfo.network_current_state()
  })
end

local net_con
local is_net_con_registered = false

local function get_net_con()
  if not net_con then
    local connection = jf.import("@ohos.net.connection")
    net_con = connection.createNetConnection()
  end
  return net_con
end

local function on_network_state_change()
  local network_type = M.Sysinfo.network_type()
  _ejoysdk.log("get the network type >> " .. tostring(network_type) .. ", and last type >> " .. tostring(last_network_type))
  if nil == last_network_type or network_type ~= last_network_type then
    last_network_type = network_type
    local state_info = {
      type = "networkStateChange",
      state = M.Sysinfo.network_current_state()
    }
    _ejoysdk.log("publish network state change event, state_info.state: " .. tostring(state_info.state))
    ET.publish(ET.gangplank.NETWORK_STATE_CHANGE, state_info)
  else
    _ejoysdk.log("new network type is same to last network type, do not publish event")
  end
end

function Sysinfo.network_monitor_start()
  net_con = get_net_con()
  if not is_net_con_registered then
    net_con.register(function(error)
      if error then
        local error_str = JSON.safe_encode(error)
        _ejoysdk.log("network_monitor_start error: " .. tostring(error_str))
      else
        is_net_con_registered = true
      end
    end)
    net_con.on("netAvailable", on_network_state_change)
    net_con.on("netLost", on_network_state_change)
    net_con.on("netUnavailable", on_network_state_change)
  else
    _ejoysdk.log("network_monitor_start, has registered")
  end
end

function Sysinfo.network_monitor_stop()
  if net_con then
    net_con.unregister(function(error)
      if error then
        local error_str = JSON.safe_encode(error)
        _ejoysdk.log("network_monitor_stop error: " .. tostring(error_str))
      else
        is_net_con_registered = false
      end
    end)
  end
end

function Sysinfo.network_ping(_params, _cb)
end

function Sysinfo.network_traceroute(_params, _cb)
end

function Sysinfo.update_screen_scale_ratio(_ratio)
end

local cutout_info_cache

function Sysinfo.cutout()
  if cutout_info_cache then
    return cutout_info_cache
  end
end

function Sysinfo.cutout_async(cb)
  local default_result = {
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
  local display = jf.import("@ohos.display")
  local default_display = display.getDefaultDisplaySync()
  local orientation = default_display.orientation
  local screen_width = default_display.width
  local screen_height = default_display.height
  default_display:getCutoutInfo():Then(function(_cutout_info)
    local cutout_info = lunate.deepcopy(_cutout_info)
    if cutout_info and cutout_info.boundingRects and cutout_info.boundingRects[1] then
      local result = {}
      result.cutout_rects = {}
      result.safe_inset = {
        top = 0,
        left = 0,
        right = 0,
        bottom = 0
      }
      for _, _cutout_rect in pairs(cutout_info.boundingRects) do
        local cutout_rect = {
          x = _cutout_rect.left,
          y = _cutout_rect.top,
          width = _cutout_rect.width,
          height = _cutout_rect.height
        }
        local temp_safe_inset = {}
        local _safe_top = _cutout_rect.top + _cutout_rect.height
        temp_safe_inset.tag = "top"
        temp_safe_inset.size = _safe_top
        temp_safe_inset.area_size = screen_width * _safe_top
        local _safe_bottom = screen_height - _cutout_rect.top
        local _safe_bottom_area_size = screen_width * _safe_bottom
        if 0 ~= _safe_bottom and _safe_bottom_area_size < temp_safe_inset.area_size then
          temp_safe_inset.tag = "bottom"
          temp_safe_inset.size = _safe_bottom
          temp_safe_inset.area_size = _safe_bottom_area_size
        end
        local _safe_left = _cutout_rect.left + _cutout_rect.width
        local _safe_left_area_size = screen_height * _safe_left
        if 0 ~= _safe_left and _safe_left_area_size <= temp_safe_inset.area_size and (_safe_left_area_size ~= temp_safe_inset.area_size or 0 ~= orientation and 2 ~= orientation) then
          temp_safe_inset.tag = "left"
          temp_safe_inset.size = _safe_left
          temp_safe_inset.area_size = _safe_left_area_size
        end
        local _safe_right = screen_width - _cutout_rect.left
        local _safe_right_area_size = screen_height * _safe_right
        if 0 ~= _safe_right and _safe_right_area_size <= temp_safe_inset.area_size and (_safe_right_area_size ~= temp_safe_inset.area_size or 0 ~= orientation and 2 ~= orientation) then
          temp_safe_inset.tag = "right"
          temp_safe_inset.size = _safe_right
          temp_safe_inset.area_size = _safe_right_area_size
        end
        if result.safe_inset[temp_safe_inset.tag] < temp_safe_inset.size then
          result.safe_inset[temp_safe_inset.tag] = temp_safe_inset.size
        end
        table.insert(result.cutout_rects, cutout_rect)
      end
      cutout_info_cache = result
      cb(result)
    else
      cutout_info_cache = default_result
      cb(default_result)
    end
  end):catch(function()
    cutout_info_cache = default_result
    cb(default_result)
  end)
end

M.Sysinfo.cutout_async(function()
end)

function Sysinfo.update_cutout(_params)
end

function Sysinfo.device_id()
  return get_device_info_list().oaid
end

function Sysinfo.gaid()
end

function Sysinfo.gaid_async(_cb)
end

function Sysinfo.manifest_meta_data(_type, key)
  if "cn.gosdk.channelVer" == key then
    return "1.0.0"
  end
end

function Sysinfo.get_gpu_info(cb)
  if cb then
    cb({})
  end
end

function Sysinfo.is_support_hardware_info()
  local memTotal = type(Sysinfo.memory().Total) == "number" and Sysinfo.memory().Total or -1
  if Sysinfo.get_cpu_cores_count() > 0 and memTotal > 0 then
    return true
  else
    return false
  end
end

function Sysinfo.sysinfo_ejoy_ext_info()
  return ""
end

function Sysinfo.get_hardware_info(cb)
  M.ability_report("get_hardware_info")
  if not Sysinfo.is_support_hardware_info() then
    cb({})
    return
  end
  local cpu_max_freq = Sysinfo.get_cpu_max_freq()
  local hardware_info = {
    cpu = {
      model = Sysinfo.get_cpu_model(),
      core_num = Sysinfo.get_cpu_cores_count(),
      max_freq = cpu_max_freq >= 0 and cpu_max_freq or nil
    },
    gpu = {},
    memory = {
      total_size = Sysinfo.memory().Total or -1
    },
    model = Sysinfo.model(),
    brand = Sysinfo.brand()
  }
  if hardware_info.cpu.max_freq and hardware_info.cpu.max_freq > 0 then
    hardware_info.cpu.max_freq = hardware_info.cpu.max_freq / 1000000
  end
  if hardware_info.memory.total_size and hardware_info.memory.total_size > 0 then
    hardware_info.memory.total_size = hardware_info.memory.total_size / 1000000
  end
  if cb then
    cb(hardware_info)
  end
end

function Sysinfo.launch_time()
  return get_device_info_list().launch_time
end

function Sysinfo.launch_time_async(_cb)
end

function Sysinfo.run_time()
  return os.time() * 1000 - Sysinfo.launch_time()
end

function Sysinfo.run_time_async(_cb)
end

function Sysinfo.get_audio_mute_info(_cb)
  if _cb then
    local ret = jf.utils().getAudioMuteInfo and jf.utils():getAudioMuteInfo() or false
    if not ret then
      _cb(false, -1, "native error")
      return
    end
    _cb(true, lunate.deepcopy(ret))
  end
end

function Sysinfo.start_listen_audio_mute()
  if not jf.utils().startListenAudioMute then
    _ejoysdk.log("start_listen_audio_mute skip, not support")
    return
  end
  jf.utils():startListenAudioMute()
end

function Sysinfo.stop_listen_audio_mute()
  if not jf.utils().stopListenAudioMute then
    _ejoysdk.log("stopListenAudioMute skip, not support")
    return
  end
  jf.utils():stopListenAudioMute()
end

function Sysinfo.is_audio_mute_listen_open()
  if not jf.utils().isAudioMuteListenOpen then
    _ejoysdk.log("isAudioMuteListenOpen skip, not support")
    return false
  end
  do return jf.utils().isAudioMuteListenOpen end
  return jf.utils().isAudioMuteListenOpen, (jf.utils())
end

function Sysinfo.get_screen_refresh_rate(_cb)
  if not jf.utils().getScreenRefreshRate then
    _ejoysdk.log("get_screen_refresh_rate skip, not support")
    return
  end
  local ret = jf.utils():getScreenRefreshRate()
  if _cb then
    _cb(lunate.deepcopy(ret))
  end
end

function Sysinfo.go_to_app_market()
  M.async_cast("go_to_app_market", M.Sysinfo.package_name())
end

function Sysinfo.get_device_system()
  return "harmonyos"
end

function Sysinfo.get_device_system_version()
  do return end
  return Sysinfo.os_version, nil
end

function Sysinfo.get_device_type()
  local value = get_device_info_list().device_type
  if value then
    if "phone" == value or "tablet" == value then
      return value
    elseif "2in1" == value then
      return "pc"
    else
      return "others"
    end
  end
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
  jf.utils():setTimeout(cb, interval * 1000)
end

function M.on_stop()
  ET.publish("app_on_stop")
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

function Media.start_record(_opt, _cb)
  local media = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_media")
  media.start_record(function(_succ, ...)
    local _code, _msg = ...
    local ret = {
      succ = _succ,
      code = _code,
      message = _msg
    }
    if _cb then
      _cb(ret)
    end
  end, _opt)
end

function Media.stop_record(_opt, _cb)
  local media = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_media")
  media.stop_record(_cb)
end

function Media.start_play(_opt, _cb)
  local media = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_media")
  media.start_play(_opt, _cb)
end

function Media.stop_play(_opt, _cb)
  local media = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_media")
  media.stop_play(_opt, _cb)
end

function Media.delete(_opt, _cb)
  local media = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_media")
  media.delete(_opt, _cb)
end

function Media.get_record_dir()
  do return M.Path.join, (M.File.get_ext_file_dir()) end
  return M.Path.join, M.File.get_ext_file_dir(), "records"
end

function Media.is_support()
  return true
end

function M.goto_application_settings()
end

local Permission = {}
M.Permission = Permission

function Permission.support_compliance_check()
  return true
end

function Permission.async_support_compliance_check(cb)
  cb(true)
end

function Permission.checkPermission(_permission_detail, _cb)
end

local KEY_PERMISSIONS = "ejoysdk_requested_permissions"

function Permission.check_permission_v2(permission, cb)
  if "notification" == permission then
    local noti_manager = lunate.import("@ohos.notificationManager")
    noti_manager:isNotificationEnabled():Then(function(is_granted)
      if is_granted then
        _ejoysdk.log("isNotificationEnabled true")
        cb(true)
      else
        local context = jf.get_context()
        noti_manager:requestEnableNotification(context):Then(function()
          _ejoysdk.log("check_permission_v2, result, permission:" .. tostring(permission) .. ", result:true")
          cb(true)
        end):catch(function(_err_data)
          cb(false)
          if 1600004 == _err_data and _err_data.code then
            _ejoysdk.log("[ANS] requestEnableNotification refused")
          else
            local code = _err_data and _err_data.code
            local message = _err_data and _err_data.message
            _ejoysdk.log("[ANS] requestEnableNotification failed, code is " .. tostring(code) .. ", message is " .. tostring(message))
          end
        end)
      end
    end):catch(function(_err_data)
      cb(false)
      local code = _err_data and _err_data.code
      local message = _err_data and _err_data.message
      _ejoysdk.log("[ANS] isNotificationEnabled error, code is " .. tostring(code) .. ", message is " .. tostring(message))
    end)
    return
  end
  local bundle_manager = lunate.import("@ohos.bundle.bundleManager")
  local bundle_info = bundle_manager.getBundleInfoForSelfSync(1)
  local access_token_id = bundle_info.appInfo.accessTokenId
  local ability_access_ctrl = lunate.import("@ohos.abilityAccessCtrl")
  local at_manager = ability_access_ctrl.createAtManager()
  local has_request_permissions = M.KeyStore.get(KEY_PERMISSIONS)
  if has_request_permissions and not string.find(has_request_permissions, permission) then
    has_request_permissions = has_request_permissions .. "|" .. permission
  else
    has_request_permissions = has_request_permissions or permission
  end
  _ejoysdk.log("check_permission_v2 has_request_permissions:" .. tostring(has_request_permissions))
  M.KeyStore.set(KEY_PERMISSIONS, has_request_permissions)
  at_manager:checkAccessToken(access_token_id, permission):Then(function(grant_status)
    _ejoysdk.log("check_permission_v2 at_manager checkAccessToken:" .. tostring(permission) .. ", grant_status:" .. tostring(grant_status))
    if 0 == grant_status then
      cb(true)
    else
      local context = jf.get_context()
      at_manager:requestPermissionsFromUser(context, {permission}):Then(function(data)
        _ejoysdk.log("check_permission_v2, result, permission:" .. tostring(permission) .. ", result:" .. tostring(data and data.authResults and data.authResults[1] ~= nil and 0 == data.authResults[1]))
        if data and data.authResults and data.authResults[1] ~= nil and 0 == data.authResults[1] then
          cb(true)
        else
          cb(false)
        end
      end):catch(function()
        cb(false)
      end)
    end
  end):catch(function()
    cb(false)
  end)
end

function Permission.check_permission_v3(options, cb)
  cb = cb or function()
  end
  if not options or not options.permissions then
    cb(true)
    return
  end
  local util = require("ejoysdk_lua.ejoysdk_utils")
  
  local function detect_finish_cb(not_allow_list, forbidden_list)
    if forbidden_list and next(forbidden_list) then
      local title, desc = M.Permission.permission_default_description(forbidden_list)
      local default_str = "系统拒绝应用申请此权限。如需使用功能，请前往系统设置内手动打开此权限。"
      local result_str = LANG.getString("system_deny_permission_des", default_str)
      desc = result_str .. [[


]] .. desc
      local tempOptions = {
        buttons = {
          LANG.getString("cancel", "取消"),
          LANG.getString("goto_system_auth", "前往系统授权")
        },
        title = title,
        message = desc,
        permissions = forbidden_list
      }
      M.Permission.show_usage_dialog(tempOptions, function(ret)
        local is_open_settings = false
        if 1 == ret then
          M.Permission.openSetting({forbidden_list = forbidden_list})
          is_open_settings = true
        end
        cb(false, is_open_settings)
      end)
    elseif not_allow_list and next(not_allow_list) then
      local title, desc = M.Permission.permission_default_description(not_allow_list)
      local tempOptions = {
        buttons = {
          LANG.getString("confirm", "确定")
        },
        title = title,
        message = desc,
        permissions = not_allow_list
      }
      M.Permission.show_usage_dialog(tempOptions, function()
        local not_allow_array = {}
        for p, _ in pairs(not_allow_list) do
          table.insert(not_allow_array, p)
        end
        M.Permission.check_permission_list_v2(not_allow_array, cb)
      end)
    else
      cb(true)
    end
  end
  
  local index = util.tablelength(options.permissions)
  local not_allow_permissions = {}
  local forbidden_permissions = {}
  for permission, description in pairs(options.permissions) do
    M.Permission.detect_permission(permission, function(succ, resp)
      index = index - 1
      if not succ then
        local status = resp.status
        if 0 == status then
          not_allow_permissions[permission] = description
        elseif -1 == status then
          forbidden_permissions[permission] = description
        end
      end
      if index <= 0 then
        detect_finish_cb(not_allow_permissions, forbidden_permissions)
      end
    end)
  end
end

function Permission.detect_permission(permission, cb)
  local bundle_manager = lunate.import("@ohos.bundle.bundleManager")
  local bundle_info = bundle_manager.getBundleInfoForSelfSync(1)
  local access_token_id = bundle_info.appInfo.accessTokenId
  local ability_access_ctrl = lunate.import("@ohos.abilityAccessCtrl")
  local at_manager = ability_access_ctrl.createAtManager()
  at_manager:checkAccessToken(access_token_id, permission):Then(function(grant_status)
    _ejoysdk.log("detect_permission checkAccessToken result:" .. tostring(permission) .. ", grant_status:" .. tostring(grant_status))
    if 0 == grant_status then
      cb(true)
    else
      local has_request_permissions = M.KeyStore.get(KEY_PERMISSIONS)
      _ejoysdk.log("detect_permission has_request_permissions:" .. tostring(has_request_permissions) .. ", permission:" .. tostring(permission) .. ", find:" .. tostring(has_request_permissions and string.find(has_request_permissions, permission)))
      if has_request_permissions and string.find(has_request_permissions, permission) then
        cb(false, {status = -1})
      else
        cb(false, {status = 0})
      end
    end
  end):catch(function()
    cb(false, {status = -1})
  end)
end

function Permission.openSetting(_ext_param)
  local context = jf.get_context()
  local bundle_name = context.abilityInfo.bundleName
  local wantInfo = {
    bundleName = "com.huawei.hmos.settings",
    abilityName = "com.huawei.hmos.settings.MainAbility",
    uri = "application_info_entry",
    parameters = {pushParams = bundle_name}
  }
  context:startAbility(wantInfo)
end

function Permission.openApplicationSetting()
  M.Permission.openSetting()
end

function Permission.get_requested_permissions()
  local bundle_manager = lunate.import("@ohos.bundle.bundleManager")
  local bundle_info = bundle_manager.getBundleInfoForSelfSync(16)
  local _req_permissions = bundle_info.reqPermissionDetails
  local ret = {}
  if _req_permissions and _req_permissions[1] then
    local req_permissions = lunate.deepcopy(_req_permissions)
    for _, req_permission in ipairs(req_permissions) do
      table.insert(ret, req_permission.name)
    end
  end
  return ret
end

function Permission.async_get_requested_permissions(cb)
  local permissions = M.Permission.get_requested_permissions()
  cb(permissions)
end

function Permission.show_usage_dialog(options, cb)
  cb = cb or function()
  end
  options = options or {}
  if not options.permissions then
    cb(-1)
    return
  end
  options.style = "lingxi"
  if not (options.title and options.title ~= "" and options.message) or "" == options.message then
    local title, desc = M.Permission.permission_default_description(options.permissions)
    options.title = options.title or title or ""
    options.message = options.message or desc or ""
  end
  options.buttons = options.buttons or {"确定"}
  if not (options.title and options.title ~= "" and options.message) or "" == options.message then
    M.LOG.warn("ejoysdk_harmonyos", "show_usage_dialog with empty title and message, title:" .. tostring(options.title) .. ", msg:" .. tostring(options.message))
  end
  M.Modal.open(options.title, options, cb)
end

local Sdkinfo = {}
M.Sdkinfo = Sdkinfo

function Sdkinfo.getSDKVersionName(_sdkName)
  local uni = require("ejoysdk_lua.vendors.unisdk")
  local sdk_info = uni.get_sdk_info(_sdkName)
  local sdk_version = sdk_info and sdk_info.version or "0"
  _ejoysdk.log("getSDKVersionName:" .. tostring(_sdkName) .. ", ver:" .. tostring(sdk_version))
  return sdk_version
end

function M.qrcode_scan(cb)
  M.async_call_once("qrcode_scan", cb)
end

function M.get_cba_tweleve_info()
  return {}
end

function M.support_save_to_album()
  return true
end

function M.save_to_album(_path, _need_delete, _cb)
  local ejoy_vm_func = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func")
  ejoy_vm_func.save_to_album(_path, _need_delete, _cb)
end

function M.kill_app()
  _ejoysdk.log("kill_app begin")
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
  local function try_copy_clipboard_text(_text)
    local pasteboard = lunate.import("@ohos.pasteboard")
    
    local pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, _text or "")
    local systemPasteboard = pasteboard.getSystemPasteboard()
    systemPasteboard.setDataSync(pasteData)
    return true
  end
  
  local status, result = pcall(try_copy_clipboard_text, _params.text)
  return {
    succ = status and result
  }
end

local QRCode = {}
M.QRCode = QRCode

function QRCode.gen_bmp(_text)
end

local Calendar = {}
setmetatable(Calendar, {
  __index = function(_t, k)
    local H_CALENDAR = require("ejoysdk_lua.harmonyos.calendar")
    return H_CALENDAR[k]
  end
})
M.Calendar = Calendar
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

function M.get_system_properties(_key, _default_value)
end

function M.set_app_orientation(orientation)
  local ohos_orientation
  if 0 == orientation then
    ohos_orientation = 2
  elseif 1 == orientation then
    ohos_orientation = 1
  elseif 2 == orientation then
    ohos_orientation = 5
  end
  if ohos_orientation then
    M.async_cast("set_app_orientation", ohos_orientation)
  else
    _ejoysdk.log("set_app_orientation value only support 0:landscape, 1: portrait, 2: auto")
  end
end

function Sysinfo.set_audio_category(_category)
end

function Sysinfo.get_audio_category()
end

function Sysinfo.set_audio_options(_category, _mode, _options, _fore_active)
end

function M.support_webview()
  return true
end

function M.disable_embed_webview()
  return false
end

function M.scroll_log_file(_file_name)
  if jf.utils().logUtil then
    jf.utils().logUtil:scrollLogFile()
  end
end

function M.flush_log()
  if jf.utils().logUtil then
    jf.utils().logUtil:flushLog()
  end
end

function M.is_log_file_support()
  return jf.utils().logUtil ~= nil
end

function M.get_log_file_infos(params, cb)
  if jf.utils().logUtil then
    local _log_file_infos = jf.utils().logUtil:getLogFiles(params)
    local log_file_infos = lunate.deepcopy(_log_file_infos)
    log_file_infos = log_file_infos or {}
    local ret_log_file_datas = {}
    for _, v_logfile in pairs(log_file_infos.data or {}) do
      table.insert(ret_log_file_datas, v_logfile)
    end
    log_file_infos.data = ret_log_file_datas
    cb(log_file_infos)
  end
end

function M.get_current_log_file(_params, cb)
  if jf.utils().logUtil then
    local log_file = jf.utils().logUtil:getCurrentLogFile()
    cb(lunate.deepcopy(log_file))
  end
end

function M.init_jf_file_cache(dir_name)
  if jf.utils().jfFileUtil then
    jf.utils().jfFileUtil:initJFFileCache({dir_name = dir_name})
  end
end

function M.switch_jf_sub_dir(sub_dir_name)
  if jf.utils().jfFileUtil then
    jf.utils().jfFileUtil:switchJFSubDir(sub_dir_name)
  end
end

function M.jf_log(event_log_str)
  if jf.utils().jfFileUtil then
    jf.utils().jfFileUtil:jfLog(event_log_str)
  end
end

function M.get_jf_file_infos(cb)
  if jf.utils().jfFileUtil then
    local log_files = jf.utils().jfFileUtil:getJFFileInfos({})
    local log_file_infos = lunate.deepcopy(log_files and log_files.data)
    cb(log_file_infos)
  end
end

function M.get_current_jf_file_info(cb)
  if jf.utils().jfFileUtil then
    local log_file = jf.utils().jfFileUtil:getCurrentJFFileInfo()
    local log_file_info = lunate.deepcopy(log_file)
    cb(log_file_info)
  end
end

function M.flush_jf_log()
  if jf.utils().jfFileUtil then
    jf.utils().jfFileUtil:flushJFLog()
  end
end

function M.scroll_jf_log()
  if jf.utils().jfFileUtil then
    jf.utils().jfFileUtil:scrollJFLogFile()
  end
end

function M.get_ej_debugable()
  return ej_debuggable
end

function M.get_ej_detail_debuggable()
  return ej_detail_debuggable
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
  cb(false, "harmonyos", -1, "not support")
end

function _FileBatch.process_batch_remove(list, cb, opts)
  jf.utils().fileUtil:batchRemove({files = list, opts = opts}, function(ret)
    if cb then
      local json = require("ejoysdk_lua.ejoysdk_json")
      ret = json.decode(ret)
      ret = ret or {}
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end)
end

function _FileBatch.process_batch_rename(map, cb, opts)
  _ejoysdk.log("process_batch_rename received in lua")
  jf.utils().fileUtil:batchRename({files = map, opts = opts}, function(ret)
    if cb then
      local json = require("ejoysdk_lua.ejoysdk_json")
      ret = json.decode(ret)
      ret = ret or {}
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end)
end

function _FileBatch.process_exists(path)
  local fs = jf.import("@ohos.file.fs")
  local access_ret, file_exists = pcall(fs.accessSync, path, fs.AccessModeType.EXIST)
  return access_ret and file_exists
end

local function process_list_directory_sync(dir_path, recursive)
  _ejoysdk.log("_FileBatch process_list_directory begin:" .. tostring(dir_path) .. ", recur:" .. tostring(recursive))
  local ret = jf.utils().fileUtil:listDirectorySync({path = dir_path, recur = recursive})
  local json = require("ejoysdk_lua.ejoysdk_json")
  ret = json.decode(ret)
  ret = ret or {}
  local data = ret.value or {}
  return data
end

function _FileBatch.process_copy(src_fullpath, dst_fullpath, opts)
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  if src_fullpath == dst_fullpath then
    return false, EC.EJOY_LIB_ERROR.FILE_DST_PATH_SAME_WITH_SRC, "dst path same with src"
  end
  local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
  local fs = jf.import("@ohos.file.fs")
  
  local function copy_single_file(_src_file, _dst_file)
    local _result, _code, _msg
    local dst_exists = M.File.process_exists(_dst_file)
    if dst_exists then
      if override then
        local rm_ret = M.File.process_remove(_dst_file)
        if rm_ret then
          _result = compat.xpcall(fs.copyFileSync, function(err)
            _ejoysdk.log("copyFileSync failed1:" .. tostring(err))
            _code = EC.EJOY_LIB_ERROR.FILE_COPY_FAILED
            _msg = tostring(err)
          end, _src_file, _dst_file)
        else
          _result = false
          _code = EC.EJOY_LIB_ERROR.FILE_REMOVE_FILE_FAILED
          _msg = "dst exists and remove failed"
        end
      else
        _result = false
        _code = EC.EJOY_LIB_ERROR.FILE_ALREADY_EXISTS
        _msg = "file already exists"
      end
    else
      _ejoysdk.log("copyFileSync begin, src:" .. tostring(_src_file) .. ", dst:" .. tostring(_dst_file))
      _result = compat.xpcall(fs.copyFileSync, function(err)
        _ejoysdk.log("copyFileSync failed2:" .. tostring(err))
        _code = EC.EJOY_LIB_ERROR.FILE_COPY_FAILED
        _msg = tostring(err)
      end, _src_file, _dst_file)
    end
    return _result, _code, _msg
  end
  
  local copy_result, code, msg
  local src_exists = M.File.process_exists(src_fullpath)
  if src_exists then
    local is_dir = M.File.process_is_directory(src_fullpath)
    if is_dir then
      M.Path.ensure_dir(dst_fullpath)
      local copy_dir_mode = override and 1 or 0
      local file_list_arr = process_list_directory_sync(src_fullpath, false)
      local dir_items_len = #file_list_arr
      if dir_items_len > 0 then
        for _, file_item in ipairs(file_list_arr) do
          local item_name = file_item.path
          local item_is_dir = file_item.is_dir
          local item_src_full_path = M.Path.join(src_fullpath, item_name)
          local item_dst_full_path = M.Path.join(dst_fullpath, item_name)
          if item_is_dir then
            copy_result = compat.xpcall(fs.copyDirSync, function(err)
              _ejoysdk.log("copyDirSync failed:" .. tostring(err))
              code = EC.EJOY_LIB_ERROR.DIR_COPY_FAILED
              msg = tostring(err)
            end, item_src_full_path, dst_fullpath, copy_dir_mode)
            _ejoysdk.log("process_copy is dir:" .. tostring(is_dir) .. ", copy_dir_mode:" .. tostring(copy_dir_mode) .. ", override:" .. tostring(override) .. ", copy_result:" .. tostring(copy_result) .. ", src:" .. tostring(item_src_full_path) .. ", dst:" .. tostring(item_dst_full_path))
          else
            copy_result, code, msg = copy_single_file(item_src_full_path, item_dst_full_path)
            _ejoysdk.log("copyFileSync begin, src:" .. tostring(item_src_full_path) .. ", dst:" .. tostring(item_dst_full_path) .. ", result:" .. tostring(copy_result))
          end
          if not copy_result then
            _ejoysdk.log("copy dir failed with items, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            break
          end
        end
      else
        copy_result = true
      end
    else
      M.Path.ensure_parent_dir(dst_fullpath)
      copy_result, code, msg = copy_single_file(src_fullpath, dst_fullpath)
    end
  else
    copy_result = false
    code = EC.EJOY_LIB_ERROR.FILE_NOT_EXISTS
    msg = "src file not exists"
  end
  return copy_result, code, msg
end

function _FileBatch.process_batch_copy(map, cb, opts)
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  _ejoysdk.log("_FileBatch process_batch_copy begin:" .. tostring(override))
  jf.utils().fileUtil:batchCopy({
    files = map,
    need_override = override,
    opts = opts
  }, function(ret)
    if cb then
      local json = require("ejoysdk_lua.ejoysdk_json")
      ret = json.decode(ret)
      ret = ret or {}
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end)
end

function _FileBatch.process_batch_md5(file_list, cb, base_path)
  _ejoysdk.log("_FileBatch process_batch_md5 begin:" .. tostring(file_list and #file_list or 0))
  jf.utils().fileUtil:batchMd5({files = file_list, base_path = base_path}, function(ret)
    if cb then
      local json = require("ejoysdk_lua.ejoysdk_json")
      ret = json.decode(ret)
      ret = ret or {}
      ret.result_ext = ret.result_ext or {}
      if ret.succ then
        cb(true, ret.result_ext.succ_data or {})
      else
        cb(false, ret.code, ret.msg, ret.result_ext.succ_data or {}, ret.result_ext.fail_data)
      end
    end
  end)
end

function _FileBatch.process_batch_info(file_list, cb, opts)
  jf.utils().fileUtil:batchInfo({files = file_list, opts = opts}, function(ret)
    if cb then
      local json = require("ejoysdk_lua.ejoysdk_json")
      ret = json.decode(ret)
      ret = ret or {}
      local result_ext = ret.result_ext or {}
      cb(result_ext)
    end
  end)
end

function _FileBatch.process_is_directory(file_path)
  _ejoysdk.log("_FileBatch process_is_directory begin:" .. tostring(file_path))
  local fs = jf.import("@ohos.file.fs")
  local err_msg = "process file failed:" .. tostring(file_path)
  local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
  local ret, stat = compat.xpcall(fs.statSync, function(err)
    _ejoysdk.log("statSync failed:" .. tostring(err))
    err_msg = tostring(err)
  end, file_path)
  if not ret or not stat then
    _ejoysdk.log("process_is_directory pcall failed:" .. tostring(file_path))
    return false, EC.EJOY_LIB_ERROR.FILE_STAT_FAILED, err_msg
  end
  local is_dir = stat.isDirectory()
  return is_dir
end

function _FileBatch.process_list_directory(dir_path, recursive, cb)
  _ejoysdk.log("_FileBatch process_list_directory begin:" .. tostring(dir_path) .. ", recur:" .. tostring(recursive))
  jf.utils().fileUtil:listDirectory({path = dir_path, recur = recursive}, function(ret)
    if cb then
      local json = require("ejoysdk_lua.ejoysdk_json")
      ret = json.decode(ret)
      ret = ret or {}
      local data = ret.value or {}
      cb(data)
    end
  end)
end

function _FileBatch.process_list_bundle(dir_path, recursive, cb)
  _ejoysdk.log("_FileBatch process_list_bundle begin:" .. tostring(dir_path) .. ", recur:" .. tostring(recursive))
  jf.utils().fileUtil:listBundle({
    context = jf.get_context(),
    path = dir_path,
    recur = recursive
  }, function(ret)
    if cb then
      local json = require("ejoysdk_lua.ejoysdk_json")
      ret = json.decode(ret)
      ret = ret or {}
      local data = ret.value or {}
      cb(data)
    end
  end)
end

function M.patch_dir(params, cb, progress_cb)
  _ejoysdk.log("patch_dir invoke")
  local hpatchz = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_hpatchz")
  hpatchz.patch_dir(params, cb, progress_cb)
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
      local hpatchz = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_hpatchz")
      hpatchz.patch_files(params, cb, progress_cb)
    end
    return
  end
  cb(false, EC.PATCH_ERROR.CODE_PARAM_INVALID)
end

function M.check_compatibility()
  return true
end

function M.picker(_params, cb)
  if cb then
    cb(false, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
  end
end

function M.subscribe_msg(_options, _cb)
  if _cb then
    _cb(false, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
  end
end

return M

local JSON = require("ejoysdk_lua.ejoysdk_json")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local LANG = require("ejoysdk_lua.lang.util")
local LUA_FILE = require("ejoysdk_lua.libs.luafile")
local ECC = require("ejoysdk_lua.ejoysdk_constants")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local CT_GET_EXT_STG_DIR = "GET_EXT_STG_DIR"
local IVK_KEYSTORE_SET = "KEYSTORE_SET"
local IVK_KEYSTORE_DELETE = "KEYSTORE_DELETE"
local IVK_KEYSTORE_CLEAR = "KEYSTORE_CLEAR"
local SYNC_WEBVIEW_OPERATOR = "WEBVIEW_OPERATOR"
local IVK_WEBVIEW_OPERATOR = "WEBVIEW_OPERATOR"
local M = {}
local cbs = {}
local cb_id = math.random(1000, 9999)
local native_support_functions
local global_request_task_tag = math.random(1000, 9999)
local cache_ext_stg_dir
local http_progress_cbs = {}
local http_progress_tid_cbid_map = {}
local patch_progress_cbs = {}
local _Private = {}
M.USAGE_DIALOG_IS_SHOWED = false
M.PLATFORM = {
  OS = "Android",
  HTTP_UA = "EjoySDK-http-client/0.1 (Linux; Android)"
}
M.JAVA_CALL_STATIC_CLASS = "com/ejoy/ejoysdk/LuaCall"
local _life_is_paused = false
_ejoysdk.register_cb("APP_LIFE_CIRCLE_EVENT", function(_cbid, value)
  local result = JSON.decode(value) or {}
  M.log("APP_LIFE_CIRCLE_EVENT ----called")
  M.log(result)
  if result.life == "onPause" then
    _life_is_paused = true
  elseif result.life == "onResume" then
    _life_is_paused = false
  end
  if next(result) ~= nil then
    ET.publish("APP_LIFE_CIRCLE_EVENT", result)
  end
end)

function M.is_paused()
  return _life_is_paused
end

function M.async_call(type, params, chunk, cb, opts)
  chunk = chunk or ""
  local id = cb_id
  cb_id = cb_id + 1
  cbs[id] = cb
  if opts and opts.timeout and opts.timeout_cb then
    M.Timer.once(opts.timeout, function()
      if cbs[id] then
        cbs[id] = nil
        opts.timeout_cb()
      end
    end)
  end
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local json_str = CJSON.encode(params)
  do return _ejoysdk.async_call, M.JAVA_CALL_STATIC_CLASS, type, id, json_str end
  return _ejoysdk.async_call, M.JAVA_CALL_STATIC_CLASS, type, id, json_str, chunk
end

function M.async_call_lua_module()
end

function M.async_response_lua_module(_func_id, _callback_params)
end

local function async_callback(id, json_str, chunk)
  local cb = cbs[id]
  if cb then
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local resp = CJSON.decode(json_str)
    cbs[id] = nil
    cb(resp, chunk)
  end
end

_ejoysdk.register_cb("ASYNC_CALL", async_callback)

function M.sync_call(type, params, chunk)
  params = params or {}
  chunk = chunk or ""
  local json_str = JSON.encode(params)
  local json_ret = _ejoysdk.sync_call(M.JAVA_CALL_STATIC_CLASS, type, json_str, chunk)
  return json_ret and JSON.decode(json_ret)
end

function M.invoke(type, params, chunk)
  params = params or {}
  chunk = chunk or ""
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local json_str = CJSON.encode(params)
  do return _ejoysdk.invoke, M.JAVA_CALL_STATIC_CLASS, type, json_str end
  return _ejoysdk.invoke, M.JAVA_CALL_STATIC_CLASS, type, json_str, chunk
end

function M.register_async_cb(type, cb)
  _ejoysdk.register_cb(type, cb)
end

function M.printl(content)
  M.log({msg = content})
end

function M.is_support_function(func_name)
  if not func_name or "" == func_name then
    _ejoysdk.log("is_support_function failed, func_name invalid")
    return false
  end
  if not native_support_functions then
    local CT_GET_SUPPORT_FUNCTIONS = "GET_SUPPORT_FUNCTIONS"
    native_support_functions = M.sync_call(CT_GET_SUPPORT_FUNCTIONS)
  end
  local ret_type = type(native_support_functions)
  if "table" ~= ret_type then
    _ejoysdk.log("is_support_function failed, ret type invalid:" .. tostring(native_support_functions))
    return false
  end
  if native_support_functions[func_name] or func_name == ECC.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD then
    return true
  else
    return false
  end
end

local _FileBatch = {}
local _FileCompat = {}
do
  local is_support_batch = M.is_support_function(ECC.NATIVE_SUPPORT_FUNCTION_NAMES.BATCH_FILE_OPERATION)
  _ejoysdk.log("android load with support batch:" .. tostring(is_support_batch))
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
  local ACT_FILE_DELETE = "FILE_DELETE"
  local ret = M.sync_call(ACT_FILE_DELETE, {path = file_path})
  ret = ret or {}
  local succ = true
  if type(ret.succ) == "boolean" then
    succ = ret.succ
  end
  return succ
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

function _FileCompat.process_batch_info(file_list, cb, _opts)
  LUA_FILE.batch_info(file_list, cb, _opts)
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
  cache_ext_stg_dir = M.sync_call(CT_GET_EXT_STG_DIR).path
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

function _FileCompat.release_bundle_res(src_path, dst_path, cb)
  local ACT_RELEASE_BUILTIN_RES = "RELASE_BUILTIN_RES"
  if src_path and dst_path and "" ~= src_path and "" ~= dst_path then
    local tmp = M.sync_call(CT_GET_EXT_STG_DIR)
    local target_path = string.format("%s/%s", tmp.path, dst_path)
    M.async_call(ACT_RELEASE_BUILTIN_RES, {src = src_path, dst = target_path}, "", cb)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.unzip(src_path, dst_path, cb)
  if src_path and dst_path and "" ~= src_path and "" ~= dst_path then
    local tmp = M.sync_call(CT_GET_EXT_STG_DIR)
    local src_full_path = string.format("%s/%s", tmp.path, src_path)
    local target_path = string.format("%s/%s", tmp.path, dst_path)
    local ACT_UNZIP = "UNZIP"
    M.async_call(ACT_UNZIP, {src = src_full_path, dst = target_path}, "", cb)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.unzip_full_path(src_full_path, dst_full_path, cb)
  if src_full_path and dst_full_path and "" ~= src_full_path and "" ~= dst_full_path then
    local ACT_UNZIP = "UNZIP"
    M.async_call(ACT_UNZIP, {src = src_full_path, dst = dst_full_path}, "", cb)
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.zip(src_file_path, file_name, dst_path, cb)
  local ACT_ZIP_FILE = "ZIP_FILE"
  if src_file_path and dst_path and "" ~= src_file_path and "" ~= dst_path then
    local src_full_path = src_file_path
    local src_file_name = file_name or tostring(os.time())
    local target_path = dst_path
    local params = {
      src = src_full_path,
      file_name = src_file_name,
      dst = target_path
    }
    M.async_call(ACT_ZIP_FILE, params, "", function(ret)
      if cb then
        if ret and ret.succ and 1 == ret.succ then
          cb(true, ret.data or "")
        else
          cb(false, -1, ret.data or "")
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

function _FileCompat.size(src_path, cb)
  if src_path and "" ~= src_path then
    local tmp = M.sync_call(CT_GET_EXT_STG_DIR)
    if tmp then
      local src_full_path = string.format("%s/%s", tmp.path, src_path)
      M.async_call("get_file_size", {}, "", function(ret)
        if cb then
          cb(JSON.decode(ret))
        end
      end, src_full_path)
    end
  elseif cb then
    cb({
      succ = false,
      msg = "参数错误"
    })
  end
end

function _FileCompat.is_support_handling_file_cache()
  local IVK_IS_SUPPORT_HANDLING_FILE_CACHE = "IS_SUPPORT_HANDLING_FILE_CACHE"
  local result = M.sync_call(IVK_IS_SUPPORT_HANDLING_FILE_CACHE, {})
  if nil == result then
    return false
  else
    return result.value
  end
end

function _FileCompat.process_make_dirs(_path)
  local CT_MAKE_DIRS = "MAKE_DIRS"
  local result = M.sync_call(CT_MAKE_DIRS, {path = _path})
  local succ = false
  if result then
    succ = result.succ
  end
  _ejoysdk.log("make_dirs, path:" .. tostring(_path) .. ", result:" .. tostring(succ))
  return succ
end

_Private.sys_dirs = nil

function _FileCompat.get_sys_dirs()
  if _Private.sys_dirs then
    return _Private.sys_dirs
  end
  local ACT_GET_SYS_PATHS = "GET_SYS_PATHS"
  local result = M.sync_call(ACT_GET_SYS_PATHS)
  _Private.sys_dirs = result
  return result
end

function _FileCompat.file_md5(_path)
  local ACT_GET_FILE_MD5 = "GET_FILE_MD5"
  local result = M.sync_call(ACT_GET_FILE_MD5, {path = _path})
  local md5_value = result and result.value or nil
  return md5_value
end

local HTTP_EVENT = "HTTP_EVENT"
_ejoysdk.register_cb(HTTP_EVENT, function(cbid, js_str, _chunk)
  local params = http_progress_cbs[cbid]
  if params then
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local resp = CJSON.decode(js_str)
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
      local http_ext_params = resp.http_ext_params or {}
      params.progress(params.url, params.file, resp.received, resp.total, resp.headers, http_ext_params.event_time)
    end
  end
end)
local HTTP = {}
M.HTTP = HTTP

function HTTP.get_headers(url, params, cb)
  local ACT_HTTP_HEADERS = "HTTP_HEADERS"
  M.async_call(ACT_HTTP_HEADERS, {
    url = url,
    params = params or {}
  }, "", cb)
end

function HTTP.add_cert(ca_name, ca_chunk, cb)
  local ACT_HTTP_ADD_CERT = "HTTP_ADD_CERT"
  M.async_call(ACT_HTTP_ADD_CERT, {name = ca_name}, ca_chunk, function(resp, _chunk)
    if cb then
      cb(resp.succ)
    end
  end)
end

function HTTP.add_cert_pin(_host_pattern, _ca_name, _ca_chunk, _cb)
end

local function gen_request_tag()
  local request_tag = global_request_task_tag
  global_request_task_tag = global_request_task_tag + 1
  return "ejoy_http_" .. tostring(request_tag)
end

local BATCH_SUBMIT_EVENT = "BATCH_SUBMIT_EVENT"
_ejoysdk.register_cb(BATCH_SUBMIT_EVENT, function(_cbid, resp_str, _chunk)
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local resp = CJSON.decode(resp_str)
  local before = M.system_clock()
  local size
  if resp then
    local resp_type = resp.type or "download_progress_changed"
    if "download_state_changed" == resp_type then
      local state = resp.state
      _ejoysdk.log("BATCH_SUBMIT_EVENT download_state_changed received:" .. tostring(state))
      M.log(resp)
    else
      if resp.list then
        size = #resp.list
        for _, action_obj in ipairs(resp.list) do
          local cb_type = action_obj.cb_type
          local cbid = action_obj.cbid
          local msg = action_obj.msg
          local chunk = action_obj.chunk
          local cb = _ejoysdk.get_register_cb(cb_type)
          if cb then
            cb(cbid, msg, chunk)
          end
        end
      else
        size = 0
      end
      local after = M.system_clock()
      _ejoysdk.log("BATCH_SUBMIT_EVENT received cost:" .. tostring(after - before) .. ", cnt:" .. tostring(size) .. ", resp type:" .. tostring(resp_type))
    end
  end
end)

function HTTP.submit_download_list(list, file_ext, opts, submit_cb, single_cb, single_progress_cb, single_header_cb)
  local submit_cnt = #list
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
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local list_str = CJSON.encode(list)
  local dest_file_name = "ejoy_download_temp/_download_submit_list" .. tostring(id_end) .. ".json"
  local write_result = M.File.writefile(dest_file_name, list_str)
  local file_path, list_data
  if write_result then
    file_path = M.Path.join(_FileCompat.get_ext_file_dir(), dest_file_name)
    _ejoysdk.log("submit_download_list use file_path:" .. tostring(file_path))
  else
    list_data = list
    _ejoysdk.log("submit_download_list use list cnt:" .. tostring(submit_cnt))
  end
  do return M.async_call, "submit_download_list", {
    list = list_data,
    file = file_path,
    file_ext = file_ext,
    opts = opts
  }, "" end
  return M.async_call, "submit_download_list", {
    list = list_data,
    file = file_path,
    file_ext = file_ext,
    opts = opts
  }, "", function(resp)
    local code, msg
    if not resp.ret then
      code = resp.code
      msg = resp.msg
    end
    if submit_cb then
      submit_cb(resp.ret, code, msg)
    end
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
  M.async_call("update_download_priority", {task_id_priority_map = task_id_priority_map}, "", function(resp)
    local code, msg
    if not resp.ret then
      code = resp.code
      msg = resp.msg
    end
    if cb then
      cb(resp.ret, code, msg)
    end
  end)
end

function HTTP.process_get(url, params, cb)
  params = params or {}
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
  local ACT_HTTP_GET = "HTTP_GET"
  local cbid = M.async_call(ACT_HTTP_GET, {url = url, params = params}, "", function(info, body)
    info.headers = HTTP.Header.New(info.headers)
    info.body = body
    cb(info)
  end, {
    timeout = params.timeout,
    timeout_cb = function()
      cb({status = 0})
    end
  })
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
  http_progress_tid_cbid_map[task_id] = cbid
end

function HTTP.process_post(url, params, _content_type, body, cb)
  params = params or {}
  local task_id = params.taskId
  if not task_id then
    task_id = gen_request_tag()
    params.taskId = task_id
  end
  local ACT_HTTP_POST = "HTTP_POST"
  local progress = params.progress
  params.progress = nil
  local cbid = M.async_call(ACT_HTTP_POST, {url = url, params = params}, body, function(info, resp_body)
    info.headers = HTTP.Header.New(info.headers)
    info.body = resp_body
    cb(info)
  end, {
    timeout = params.timeout,
    timeout_cb = function()
      cb({status = 0})
    end
  })
  M.HTTP.unregister_progress_cb(task_id)
  if params.file and progress then
    http_progress_cbs[cbid] = {
      url = url,
      file = params.file,
      progress = progress,
      finish_cb = params.finish_cb
    }
  end
  http_progress_tid_cbid_map[task_id] = cbid
end

function HTTP.process_stop(_task_id_arr, params, cb)
  local ACT_HTTP_STOP = "HTTP_STOP"
  if not _task_id_arr or next(_task_id_arr) == nil then
    cb(false, {})
    return
  end
  local _task_id = _task_id_arr[1]
  M.async_call(ACT_HTTP_STOP, {
    taskId = _task_id,
    taskIdArr = _task_id_arr,
    submit_cbid = params.submit_cbid
  }, "", function(info)
    cb(info.succ, info)
  end, {
    timeout = params.timeout,
    timeout_cb = function()
      cb(false, {})
    end
  })
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

function HTTP.http_remove_cache()
end

function HTTP.http_enable_cache()
end

function HTTP.update_with_config(params)
  local ACT_HTTP_UPDATE_CONFIG = "HTTP_UPDATE_CONFIG"
  M.invoke(ACT_HTTP_UPDATE_CONFIG, params)
end

local KEYSTORE_KEY = "ejoysdk"
local KeyStore = {}
M.KeyStore = KeyStore

function KeyStore.get(key)
  local CT_KEYSTORE_GET = "KEYSTORE_GET"
  return M.sync_call(CT_KEYSTORE_GET, {service = KEYSTORE_KEY, key = key}).value
end

function KeyStore.get_group(_access_group)
  return nil
end

function KeyStore.set(key, value, _apply)
  if nil == value then
    return
  end
  M.invoke(IVK_KEYSTORE_SET, {
    service = KEYSTORE_KEY,
    key = key,
    value = value,
    apply = _apply
  })
end

function KeyStore.set_group(_key, _access_group, _value)
end

function KeyStore.delete(key)
  M.invoke(IVK_KEYSTORE_DELETE, {service = KEYSTORE_KEY, key = key})
end

function KeyStore.delete_group(_key, _access_group)
end

function KeyStore.clear()
  M.invoke(IVK_KEYSTORE_CLEAR, {service = KEYSTORE_KEY})
end

function KeyStore.clear_group(_access_group)
end

function KeyStore.custom_sub_dir(_sub_dir_param)
end

M.UnRecoverKeyStore = KeyStore
local SPRawKeyStore = {}

function SPRawKeyStore.get(sp_name, key)
  local CT_KEYSTORE_GET = "KEYSTORE_GET"
  return M.sync_call(CT_KEYSTORE_GET, {service = sp_name, key = key}).value
end

function SPRawKeyStore.set(sp_name, key, value, _apply)
  M.invoke(IVK_KEYSTORE_SET, {
    service = sp_name,
    key = key,
    value = value,
    apply = _apply
  })
  return true
end

function SPRawKeyStore.delete(sp_name, key)
  M.invoke(IVK_KEYSTORE_DELETE, {service = sp_name, key = key})
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
  local IVK_WEBVIEW_CLOSE = "WEBVIEW_CLOSE"
  do return M.invoke end
  return M.invoke, IVK_WEBVIEW_CLOSE
end

function WebView.remove_cache(url)
  require("ejoysdk_lua.ejoysdk_web").webview_remove_cache_callback(url)
  local IVK_WEBVIEW_REMOVE_CACHE = "WEBVIEW_REMOVE_CACHE"
  do return M.invoke, IVK_WEBVIEW_REMOVE_CACHE end
  return M.invoke, IVK_WEBVIEW_REMOVE_CACHE, {url = url}
end

function WebView.capture(callback)
  local ACT_WEBVIEW_CAPTURE = "WEBVIEW_CAPTURE"
  M.async_call(ACT_WEBVIEW_CAPTURE, {}, "", callback, nil)
end

function WebView.callback_js(js_cb_id, message, ext)
  local IVK_WEBVIEW_CALLBACK_JS = "WEBVIEW_CALLBACK_JS"
  do return M.invoke, IVK_WEBVIEW_CALLBACK_JS end
  return M.invoke, IVK_WEBVIEW_CALLBACK_JS, {
    cb_id = js_cb_id,
    message = message,
    ext = ext
  }
end

function WebView.call_js(script, ext)
  local IVK_WEBVIEW_CALL_JS = "WEBVIEW_CALL_JS"
  do return M.invoke, IVK_WEBVIEW_CALL_JS end
  return M.invoke, IVK_WEBVIEW_CALL_JS, {script = script, ext = ext}
end

function WebView.is_opened()
  local IVK_WEBVIEW_IS_OPENED = "WEBVIEW_IS_OPENED"
  return (M.sync_call(IVK_WEBVIEW_IS_OPENED) or {}).isOpened == true
end

function WebView.is_opened_async(cb)
  cb(WebView.is_opened())
end

function WebView.go_back()
  local ACT_WEBVIEW_GO_BACK = "go_back"
  return (M.sync_call(SYNC_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_GO_BACK}) or {}).value == true
end

function WebView.go_forward()
  local ACT_WEBVIEW_GO_FORWARD = "go_forward"
  return (M.sync_call(SYNC_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_GO_FORWARD}) or {}).value == true
end

function WebView.reload()
  local ACT_WEBVIEW_RELOAD = "reload"
  M.sync_call(SYNC_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_RELOAD})
end

function WebView.show(params)
  params = params or {}
  local ACT_WEBVIEW_SHOW = "show"
  do return M.invoke, IVK_WEBVIEW_OPERATOR end
  return M.invoke, IVK_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_SHOW, data = params}
end

function WebView.hide(params)
  params = params or {}
  local ACT_WEBVIEW_HIDE = "hide"
  do return M.invoke, IVK_WEBVIEW_OPERATOR end
  return M.invoke, IVK_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_HIDE, data = params}
end

function WebView.remove_hide_cache(params)
  params = params or {}
  local ACT_WEBVIEW_REMOVE_HIDE_CACHE = "remove_hide_cache"
  do return M.invoke, IVK_WEBVIEW_OPERATOR end
  return M.invoke, IVK_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_REMOVE_HIDE_CACHE, data = params}
end

function WebView.prepare(_params)
  _params = _params or {}
  local ACT_WEBVIEW_PREPARE = "prepare"
  do return M.invoke, IVK_WEBVIEW_OPERATOR end
  return M.invoke, IVK_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_PREPARE, data = _params}
end

function WebView.update_toolbar(toolbar_config)
  local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
  EWB.update_toolbar(toolbar_config)
end

function WebView.update_toolbar_item(params)
  local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
  EWB.update_toolbar_item(params)
end

local WEBVIEW_EVENT = "WEBVIEW_EVENT"
local WEBVIEW_JSARGS_EVENT = 0
local WEBVIEW_CLOSE_EVENT = 1
local WEBVIEW_URL_REDIRECT = 2
local WEBVIEW_LIFE_CYCLE_EVENT = 3
local WBEVIEW_HIDE_EVENT = 4
local WEBVIEW_ERROR_EVENT = 5
local WEBVIEW_OPEN_APP = 6
_ejoysdk.register_cb(WEBVIEW_EVENT, function(cbid, js_str, _chunk)
  local WE = require("ejoysdk_lua.ejoysdk_webview_event")
  _ejoysdk.log("WEBVIEW_EVENT callback")
  local value = JSON.safe_decode(js_str)
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
  elseif cbid == WBEVIEW_HIDE_EVENT then
    ET.publish("webview_hide", value)
  elseif cbid == WEBVIEW_ERROR_EVENT then
    ET.publish("webview_error", value)
    WE.on_entry_url_load_error(value)
  elseif cbid == WEBVIEW_OPEN_APP then
    ET.publish("webview_open_app", value)
    WE.open_app(value)
  end
end)
local LUA_CALL_EVENT = "LUA_CALL_EVENT"
_ejoysdk.register_cb(LUA_CALL_EVENT, function(_eventid, params, _chunk)
  local ADAPTER = require("ejoysdk_lua.ejoysdk_lua_adapter")
  if 2 == _eventid then
    ADAPTER.input(params)
  else
    ADAPTER.input(JSON.safe_decode(params), true)
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
    local UTILS = require("ejoysdk_lua.ejoysdk_utils")
    return UTILS.deepcopy(url_open_datas) or {}
  end
end

function M.get_last_openurl_data()
  local IVK_GET_LAST_OPENURL_DATA = "GET_LAST_OPENURL_DATA"
  local last_openurl_data = M.sync_call(IVK_GET_LAST_OPENURL_DATA, {})
  if last_openurl_data and last_openurl_data.value and next(last_openurl_data.value) then
    local UTILS = require("ejoysdk_lua.ejoysdk_utils")
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
  ET.publish("urlopen_v2", "url", data)
  if data.url then
    _ejoysdk.log("url_open, _app_event_handler, publish_url:" .. data.url)
    ET.publish("urlopen", data.url)
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
  M.Sysinfo.cpu_start_monitor()
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
  local APP_BACK_PRESS_EVENT = 2
  local APP_ON_CONFIGURATION_CHANGE = 3
  local APP_NETWORK_STATE_CHANGE_EVENT = 10
  local APP_AUDIO_MUTE_CHANGE_EVENT = 11
  local _app_event_handler = {
    [APP_OPENURL_EVENT] = function(value, _chunk)
      local data = value or {}
      if gangplank_inited then
        publish_urlopen(data)
      else
        _ejoysdk.log("url_open, [v2]_app_event_handler, add cache:" .. JSON.encode(value))
        url_open_datas = url_open_datas or {}
        table.insert(url_open_datas, data)
        local ukeystore = M.get_url_data_keystore()
        if ukeystore then
          ukeystore:set(url_open_datas)
        end
      end
    end,
    [APP_ON_STOP_EVENT] = function()
      ET.publish("app_on_stop")
    end,
    [APP_BACK_PRESS_EVENT] = function()
      ET.publish("backpress")
    end,
    [APP_ON_CONFIGURATION_CHANGE] = function(value)
      local data = value or {}
      ET.publish("on_configuration_change", data)
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
    [APP_AUDIO_MUTE_CHANGE_EVENT] = function(mute_info)
      _ejoysdk.log("lua receive audio_mute_change, type=" .. tostring(mute_info.type) .. ", is_mute=" .. tostring(mute_info.isMute))
      ET.publish("audio_mute_change", mute_info)
    end
  }
  _ejoysdk.register_cb(APP_EVENT, function(cbid, js_str, chunk)
    local handler = _app_event_handler[cbid]
    if handler then
      local value = JSON.safe_decode(js_str)
      handler(value, chunk)
    else
      _ejoysdk.log("app event handler not found")
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
  local ACT_MODAL_OPEN = "MODAL_OPEN"
  option = option or {}
  option.style = option.style or "lingxi"
  cb = cb or function()
  end
  is_modal_opened = true
  M.async_call(ACT_MODAL_OPEN, {title = title, option = option}, "", function(info, _body)
    is_modal_opened = false
    cb(info.index)
  end)
end

function Modal.close(cb)
  M.sync_call("MODAL_CLOSE")
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
  option = option or {}
  local IVK_TOAST_OPEN = "TOAST_OPEN"
  do return M.invoke, IVK_TOAST_OPEN end
  return M.invoke, IVK_TOAST_OPEN, {message = message, option = option}
end

function Toast.hide()
  local IVK_TOAST_OPEN = "TOAST_OPEN"
  do return M.invoke, IVK_TOAST_OPEN end
  return M.invoke, IVK_TOAST_OPEN, {
    message = "",
    option = {}
  }, {}
end

local Loading = {}
M.Loading = Loading

function Loading.show(option, cb)
  option = option or {}
  local IVK_LOADING_SHOW = "LOADING_SHOW"
  if Loading.is_support_custom() then
    M.async_call(IVK_LOADING_SHOW, {option = option}, nil, cb)
    return
  end
  do return M.invoke, IVK_LOADING_SHOW end
  return M.invoke, IVK_LOADING_SHOW, {option = option}, nil, cb
end

function Loading.dismiss()
  local IVK_LOADING_DISMISS = "LOADING_DISMISS"
  do return M.invoke, IVK_LOADING_DISMISS end
  return M.invoke, IVK_LOADING_DISMISS, {}
end

function Loading.is_support_custom()
  do return M.is_support_function end
  return M.is_support_function, ECC.NATIVE_SUPPORT_FUNCTION_NAMES.CUSTOM_LOADING
end

local device_static_info_list

local function get_device_info_list()
  if not device_static_info_list then
    local IVK_SYSINFO_STATIC_LIST = "SYSINFO_STATIC_LIST"
    device_static_info_list = M.sync_call(IVK_SYSINFO_STATIC_LIST, {})
  end
  return device_static_info_list
end

function M.get_device_info_list()
  do return end
  return get_device_info_list, nil
end

local Sysinfo = {}
M.Sysinfo = Sysinfo
local _native_utdid

function Sysinfo.utdid()
  local IVK_GET_UTDID = "GET_UTDID"
  if not _native_utdid or "" == _native_utdid then
    _native_utdid = M.sync_call(IVK_GET_UTDID, {}).value
  end
  return _native_utdid or ""
end

function Sysinfo.oaid()
  return get_device_info_list().oaid
end

function Sysinfo.oaid_async(cb)
  local _oaid = Sysinfo.oaid()
  if cb then
    cb(_oaid)
  end
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

function Sysinfo.get_device_system()
  return "android"
end

function Sysinfo.get_device_system_version()
  do return end
  return Sysinfo.os_version, nil
end

function Sysinfo.get_device_type()
  return nil
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
  return ""
end

function Sysinfo.update_time()
  return ""
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

local _ch_package_type_cache

function Sysinfo.package_type()
  if nil == _ch_package_type_cache then
    _ch_package_type_cache = -1
    local bundle_pt_file_content_str = _ejoysdk.lread("biligame_package_info.json")
    if bundle_pt_file_content_str then
      local bundle_pt_file_content = JSON.decode(bundle_pt_file_content_str)
      if bundle_pt_file_content and bundle_pt_file_content.type then
        _ch_package_type_cache = bundle_pt_file_content.type
      end
    end
  end
  return _ch_package_type_cache
end

function Sysinfo.screen_width()
  return get_device_info_list().width
end

function Sysinfo.screen_height()
  return get_device_info_list().height
end

function Sysinfo.is_passive_mode()
  return get_device_info_list().is_passive_mode
end

function Sysinfo.content_size(cb)
  local default_width = Sysinfo.screen_width()
  local default_height = Sysinfo.screen_height()
  local opts = {
    timeout = 3,
    timeout_cb = function()
      if cb then
        _ejoysdk.log("content_size timeout, return default:" .. tostring(default_width) .. ", " .. tostring(default_height))
        cb(default_width, default_height)
      end
    end
  }
  local IVK_SYSINFO_SCREEN_CONTENT_SIZE = "SYSINFO_SCREEN_CONTENT_SIZE"
  M.async_call(IVK_SYSINFO_SCREEN_CONTENT_SIZE, {}, nil, function(info, _body)
    local content_width = info.content_width
    local content_height = info.content_height
    if not content_width or not content_height then
      content_width = default_width
      content_height = default_height
    end
    if cb then
      cb(content_width, content_height)
    end
  end, opts)
end

function Sysinfo.go_to_app_market()
end

function Sysinfo.restart_self()
  return false
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

local function is_simulator_by_c_native()
  local IVK_IS_SIMULATOR_BY_C_NATIVE = "IS_SIMULATOR_BY_C_NATIVE"
  local is_simulator = M.sync_call(IVK_IS_SIMULATOR_BY_C_NATIVE, {})
  if nil == is_simulator then
    return false
  else
    return is_simulator.value or false
  end
end

local function support_c_native_detect_simulator()
  local IVK_IS_SIMULATOR_BY_C_NATIVE = "IS_SIMULATOR_BY_C_NATIVE"
  local is_simulator = M.sync_call(IVK_IS_SIMULATOR_BY_C_NATIVE, {})
  return nil ~= is_simulator
end

local function detect_simulator_by_feature()
  if M.is_support_function("get_system_properties") then
    local simulatorFlagCount = 0
    local hardware = M.get_system_properties("ro.hardware", "default")
    local flavor = M.get_system_properties("ro.build.flavor", "default")
    local product_model = M.get_system_properties("ro.product.model", "default")
    local manufacturer = M.get_system_properties("ro.product.manufacturer", "default")
    local board = M.get_system_properties("ro.product.board", "default")
    local board_platform = M.get_system_properties("ro.board.platform", "default")
    local base_band_version = M.get_system_properties("gsm.version.baseband", "default")
    local dalvik_vm_isa_arm = M.get_system_properties("ro.dalvik.vm.isa.arm", "default")
    local dalvik_vm_isa_arm64 = M.get_system_properties("ro.dalvik.vm.isa.arm64", "default")
    local hv_platform = M.get_system_properties("ro.build.hv.platform", "default")
    local gsm_ver_ril_impl = M.get_system_properties("gsm.version.ril-impl", "default")
    M.LOG.debug("simu", "simulator feature: hardware is " .. tostring(hardware) .. ", flavor is " .. tostring(flavor) .. ", product_model is " .. tostring(product_model) .. ", manufacturer is " .. tostring(manufacturer) .. ", board is " .. tostring(board) .. ", board_platform is " .. tostring(board_platform) .. ", base_band_version is " .. tostring(base_band_version))
    if string.find(hardware, "ttvm") or string.find(hardware, "nox") or string.find(hardware, "cancro") or string.find(hardware, "intel") or string.find(hardware, "vbox") or string.find(hardware, "vbox86") or string.find(hardware, "android_x86") then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if string.find(flavor, "vbox") or string.find(flavor, "sdk_gphone") then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if "aosp-user" == flavor then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if "cancro_x86_64-user" == flavor then
      simulatorFlagCount = simulatorFlagCount + 2
    end
    if string.find(product_model, "google_sdk") or string.find(product_model, "emulator") or string.find(product_model, "android sdk build for x86") then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if string.find(manufacturer, "genymotion") or string.find(manufacturer, "Netease") then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if string.find(board, "android") or string.find(board, "goldfish") then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if string.find(board_platform, "android") then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if "gmin" == board_platform then
      simulatorFlagCount = simulatorFlagCount + 2
    end
    if string.find(base_band_version, "1.0.0.0") then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if "default" == base_band_version then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if "x86" == dalvik_vm_isa_arm or "x86_64" == dalvik_vm_isa_arm64 then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if "qemu" == hv_platform then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if "default" == gsm_ver_ril_impl or string.find(gsm_ver_ril_impl, "android reference-ril", 1, true) then
      simulatorFlagCount = simulatorFlagCount + 1
    end
    if simulatorFlagCount >= 2 then
      return true
    end
  end
  return false
end

local lua_detect_simulator_result

local function detect_simulator_by_lua()
  if nil == lua_detect_simulator_result then
    lua_detect_simulator_result = false
    local pkg_names = {
      "com.mumu.launcher",
      "com.blue.huang17.launcher",
      "cn.itools.vm.launcher",
      "com.bignox.launcher",
      "com.windroy.launcher",
      "com.microvirt.launcher",
      "com.microvirt.launcher2",
      "com.vphone.launcher",
      "com.bluestacks.home",
      "com.android.flysilkworm"
    }
    for _, pkg_name in pairs(pkg_names) do
      local is_simulator_apk_installed = Sysinfo.is_app_install(pkg_name)
      if is_simulator_apk_installed then
        lua_detect_simulator_result = true
        break
      end
    end
    lua_detect_simulator_result = lua_detect_simulator_result or is_simulator_by_c_native() or detect_simulator_by_feature() or false
    local IVK_SET_SIMULATOR_FLAG = "SET_SIMULATOR_FLAG"
    M.sync_call(IVK_SET_SIMULATOR_FLAG, {is_simulator = lua_detect_simulator_result})
  end
  return lua_detect_simulator_result
end

local is_simulator

function Sysinfo.is_simulator()
  if nil == is_simulator then
    local os_version = Sysinfo.os_version() or ""
    local os_version_number = tonumber(os_version)
    if os_version_number and os_version_number >= 31 or support_c_native_detect_simulator() then
      is_simulator = detect_simulator_by_lua()
      get_device_info_list().simulatorjaq = is_simulator
      return is_simulator
    end
    is_simulator = get_device_info_list().simulatorjaq
  end
  return is_simulator
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
  return get_device_info_list().cpu_max_freq
end

function Sysinfo.is_accessibility_enable()
  return get_device_info_list().acc
end

function Sysinfo.is_param_mod_inuse()
  return get_device_info_list().mod
end

function Sysinfo.is_qemu_device()
  return get_device_info_list().qe
end

function Sysinfo.is_adb_enabled()
  return get_device_info_list().adb
end

function Sysinfo.get_app_install_time()
  return get_device_info_list().appins
end

function Sysinfo.get_user_agent()
  return get_device_info_list().useragent
end

function Sysinfo.is_xposed_installed()
  return get_device_info_list().xp
end

function Sysinfo.get_ejoy_referer()
  return get_device_info_list().ejoy_referer
end

function Sysinfo.is_app_install(package_name)
  local IVK_SYSINFO_IS_APP_INSTALLED = "HAS_PKG_INSTALLED"
  local ret = M.sync_call(IVK_SYSINFO_IS_APP_INSTALLED, {pkgName = package_name})
  if ret and ret.value then
    return ret.value == "true"
  else
    return false
  end
end

function Sysinfo.open_app(package_name)
  local IVK_SYSINFO_OPEN_APP = "OPEN_APP"
  local ret = M.sync_call(IVK_SYSINFO_OPEN_APP, {pkgName = package_name})
  if ret and ret.value then
    return ret.value == "true"
  else
    return false
  end
end

function Sysinfo.can_resolve_activity(package_name, package_activity_name)
  local IVK_SYSINFO_CAN_RESOLVE_ACTIVITY = "CAN_RESOLVE_ACTIVITY"
  local ret = M.sync_call(IVK_SYSINFO_CAN_RESOLVE_ACTIVITY, {package_name = package_name, package_activity_name = package_activity_name})
  if ret and ret.value then
    return ret.value == "true"
  else
    return false
  end
end

function Sysinfo.get_system_install_time()
  return get_device_info_list().sysins
end

function Sysinfo.get_cpu_cores_count()
  return get_device_info_list().cores
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
  return get_device_info_list().cid
end

function Sysinfo.is_device_root()
  return get_device_info_list().rt
end

function Sysinfo.android_id()
  return get_device_info_list().android_id
end

function Sysinfo.ds_channel_id()
  if M.CONFIG.get_config(M.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    return ""
  else
    local ds_channel = get_device_info_list().ds_ch_id
    if nil == ds_channel or "" == ds_channel then
      local CONFIG = require("ejoysdk_lua.ejoysdk_config")
      local has_airline_v2 = CONFIG.has_vendor_config("AIRLINE_V2")
      if has_airline_v2 then
        ds_channel = "998233"
      end
    end
    return ds_channel
  end
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
  local IVK_SYSINFO_DEVICE_WITH_ANDROID = "SYSINFO_DEVICE_ANDROID_ID"
  return M.sync_call(IVK_SYSINFO_DEVICE_WITH_ANDROID, {}).value
end

function Sysinfo.uuid()
  local IVK_GET_UUID = "GET_UUID"
  return M.sync_call(IVK_GET_UUID).value
end

function Sysinfo.screen()
  local IVK_SYSINFO_SCREEN = "SYSINFO_SCREEN"
  do return M.sync_call end
  return M.sync_call, IVK_SYSINFO_SCREEN
end

function Sysinfo.cpu_usage(cb)
  local IVK_SYSINFO_CPU_USAGE = "SYSINFO_CPU_USAGE"
  M.async_call(IVK_SYSINFO_CPU_USAGE, {}, "", cb)
end

function Sysinfo.cpu_start_monitor()
  local IVK_SYSINFO_CPU_START_MONITOR = "SYSINFO_CPU_START_MONITOR"
  M.sync_call(IVK_SYSINFO_CPU_START_MONITOR)
end

function Sysinfo.cpu_stop_monitor()
  local IVK_SYSINFO_CPU_STOP_MONITOR = "SYSINFO_CPU_STOP_MONITOR"
  M.sync_call(IVK_SYSINFO_CPU_STOP_MONITOR)
end

function Sysinfo.cpu_monitor_enable()
  local IVK_SYSINFO_CPU_MONITOR_ENABLE = "SYSINFO_CPU_MONITOR_ENABLE"
  do return M.sync_call end
  return M.sync_call, IVK_SYSINFO_CPU_MONITOR_ENABLE
end

function Sysinfo.memory()
  local IVK_SYSINFO_MEMORY = "SYSINFO_MEMORY"
  do return M.sync_call end
  return M.sync_call, IVK_SYSINFO_MEMORY
end

function Sysinfo.memory_info()
  return {}
end

function Sysinfo.memory_detail(cb)
  local IVK_SYSINFO_MEMORY_V2 = "SYSINFO_MEMORY_V2"
  M.async_call(IVK_SYSINFO_MEMORY_V2, {}, "", cb)
end

function Sysinfo.install_app(path, cb)
  local IVK_SYSINFO_INSTALL_APP = "INSTALL_APP"
  M.async_call(IVK_SYSINFO_INSTALL_APP, {path = path}, "", function(ret)
    if cb then
      _ejoysdk.log("install_app result:")
      ret = ret or {}
      M.log(ret)
      local succ = ret.succ or false
      if succ then
        _ejoysdk.log("install_app success")
        cb(true, ret)
      else
        local code = ret.code
        local msg = ret.msg
        _ejoysdk.log("install_app failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        cb(false, code, msg)
      end
    end
  end)
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

function Sysinfo.storage()
  local IVK_SYSINFO_STORAGE = "SYSINFO_STORAGE"
  do return M.sync_call end
  return M.sync_call, IVK_SYSINFO_STORAGE
end

function Sysinfo.async_storage(cb)
  cb(Sysinfo.storage())
end

function Sysinfo.get_storage_info()
  local IVK_GET_STORAGE_INFO = "GET_STORAGE_INFO"
  do return M.sync_call end
  return M.sync_call, IVK_GET_STORAGE_INFO
end

function Sysinfo.async_get_storage_info(cb)
  cb(Sysinfo.get_storage_info())
end

function Sysinfo.opengl()
  local IVK_SYSINFO_OPENGL = "SYSINFO_OPENGL"
  do return M.sync_call end
  return M.sync_call, IVK_SYSINFO_OPENGL
end

function Sysinfo.open_url(url)
  local IVK_SYSINFO_OPEN_URL = "SYSINFO_OPEN_URL"
  local channel_id = Sysinfo.ds_channel_id()
  if "998280" == channel_id and string.find(url, "^yiyuan://") ~= nil then
    local ALIGAMES = require("ejoysdk_lua.vendors.aligames")
    ALIGAMES.common_call("launch_or_download_app", {scheme_url = url}, nil)
    return
  end
  do return M.invoke, IVK_SYSINFO_OPEN_URL end
  return M.invoke, IVK_SYSINFO_OPEN_URL, {url = url}, {scheme_url = url}, nil
end

function Sysinfo.can_open_url(url)
  local IVK_SYSINFO_CAN_OPEN_URL = "SYSINFO_CAN_OPEN_URL"
  local ret = M.sync_call(IVK_SYSINFO_CAN_OPEN_URL, {url = url})
  return ret and ret.value or false
end

function Sysinfo.async_can_open_url(url, cb)
  if cb then
    cb(Sysinfo.can_open_url(url))
  end
end

function Sysinfo.battery()
  local IVK_SYSINFO_BATTERY = "SYSINFO_BATTERY"
  do return M.sync_call, IVK_SYSINFO_BATTERY end
  return M.sync_call, IVK_SYSINFO_BATTERY, {}
end

function Sysinfo.battery_v2(cb)
  local IVK_SYSINFO_BATTERY_V2 = "SYSINFO_BATTERY_V2"
  M.async_call(IVK_SYSINFO_BATTERY_V2, {}, "", cb)
end

function Sysinfo.battery_ext(_filter, cb)
  local filter = _filter or {}
  local map_filter = {}
  for _, v in pairs(filter) do
    map_filter[v] = true
  end
  local IVK_SYSINFO_BATTERY_EXT = "SYSINFO_BATTERY_EXT"
  M.async_call(IVK_SYSINFO_BATTERY_EXT, map_filter, "", cb)
end

function Sysinfo.launch_battery()
  local IVK_SYSINFO_LAUNCH_BATTERY = "SYSINFO_LAUNCH_BATTERY"
  do return M.sync_call, IVK_SYSINFO_LAUNCH_BATTERY end
  return M.sync_call, IVK_SYSINFO_LAUNCH_BATTERY, {}
end

function Sysinfo.wifi()
  local IVK_SYSINFO_WIFI_INFO = "SYSINFO_WIFI_INFO"
  do return M.sync_call, IVK_SYSINFO_WIFI_INFO end
  return M.sync_call, IVK_SYSINFO_WIFI_INFO, {}
end

function Sysinfo.mobile_info()
  local IVK_SYSINFO_MOBILE_INFO = "SYSINFO_MOBILE_INFO"
  do return M.sync_call, IVK_SYSINFO_MOBILE_INFO end
  return M.sync_call, IVK_SYSINFO_MOBILE_INFO, {}
end

function Sysinfo.mobile_info_async(cb)
  cb(M.Sysinfo.mobile_info())
end

function Sysinfo.is_vpn_connected()
  local IVK_SYSINFO_VPN_CONNECTED = "SYSINFO_VPN_CONNECTED"
  local ret = M.sync_call(IVK_SYSINFO_VPN_CONNECTED, {})
  return ret and ret.value or false
end

function Sysinfo.network_type()
  local IVK_SYSINFO_NETWORK_TYPE = "SYSINFO_NETWORK_TYPE"
  return (M.sync_call(IVK_SYSINFO_NETWORK_TYPE, {}) or {type = 3}).type
end

function Sysinfo.network_type_cache()
  if nil == last_network_type then
    last_network_type = M.Sysinfo.network_type()
  end
  return last_network_type
end

function Sysinfo.network_type_name()
  local IVK_SYSINFO_NETWORK_TYPE_NAME = "SYSINFO_NETWORK_TYPE_NAME"
  local ret = M.sync_call(IVK_SYSINFO_NETWORK_TYPE_NAME, {})
  local network_type_name = ret and ret.name or ""
  return network_type_name
end

function Sysinfo.network_current_state()
  local IVK_SYSINFO_NETWORK_CURRENT_STATE = "SYSINFO_NETWORK_CURRENT_STATE"
  local res = M.sync_call(IVK_SYSINFO_NETWORK_CURRENT_STATE) or 0
  return res
end

function Sysinfo.network_current_state_async(cb)
  local net_state = Sysinfo.network_current_state()
  cb({succ = true, state = net_state})
end

function Sysinfo.network_monitor_start()
  local IVK_SYSINFO_NETWORK_MONITOR_START = "SYSINFO_NETWORK_MONITOR_START"
  M.sync_call(IVK_SYSINFO_NETWORK_MONITOR_START)
end

function Sysinfo.network_monitor_stop()
  local IVK_SYSINFO_NETWORK_MONITOR_STOP = "SYSINFO_NETWORK_MONITOR_STOP"
  M.sync_call(IVK_SYSINFO_NETWORK_MONITOR_STOP)
end

function Sysinfo.network_ping(_params, _cb)
end

function Sysinfo.network_traceroute(_params, _cb)
end

function Sysinfo.update_screen_scale_ratio(_ratio)
end

function Sysinfo.cutout()
  local IVK_GET_CUTOUT_INFO = "GET_CUTOUT_INFO"
  return M.sync_call(IVK_GET_CUTOUT_INFO, {}).value
end

function Sysinfo.cutout_async(cb)
  local cutout_info = Sysinfo.cutout()
  cb(cutout_info)
end

function Sysinfo.update_cutout(params)
  local IVK_UPATE_CUTOUT_INFO = "UPATE_CUTOUT_INFO"
  M.sync_call(IVK_UPATE_CUTOUT_INFO, params)
end

function Sysinfo.device_id()
  local IVK_SYSINFO_DEVICE_ID = "SYSINFO_DEVICE_ID"
  return M.sync_call(IVK_SYSINFO_DEVICE_ID, {}).value
end

function Sysinfo.gaid()
  local IVK_GET_GAID = "GET_GOOGLE_ADVERTISING_ID"
  return M.sync_call(IVK_GET_GAID, {}).value
end

function Sysinfo.gaid_async(cb)
  local IVK_GET_GAID = "GET_GOOGLE_ADVERTISING_ID"
  M.async_call(IVK_GET_GAID, {}, "", cb)
end

function Sysinfo.manifest_meta_data(type, key)
  local IVK_MANIFEST_META_DATA = "GET_MANIFEST_META_DATA"
  return M.sync_call(IVK_MANIFEST_META_DATA, {type = type, key = key}).value
end

function Sysinfo.get_gpu_info(cb)
  local ACT_GET_GPU_INFO = "GET_GPU_INFO"
  M.async_call(ACT_GET_GPU_INFO, {}, "", cb)
end

function Sysinfo.is_support_hardware_info()
  local IVK_IS_SUPPORT_HARDWARE_INFO = "IS_SUPPORT_HARDWARE_INFO"
  local result = M.sync_call(IVK_IS_SUPPORT_HARDWARE_INFO, {})
  if nil == result then
    return false
  else
    return result.value
  end
end

function Sysinfo.sysinfo_ejoy_ext_info()
  return ""
end

local function stat_hardware_info_error(hardware_info)
  local HAS_STATED_STORAGE = M.LazyKeyStore:New("HAS_STATED_STORAGE", false, false, false)
  local has_stated = HAS_STATED_STORAGE:get()
  if "true" == has_stated then
    M.log("has_stated hardware info error")
    return
  end
  
  local function do_stat(type)
    local stat = require("ejoysdk_lua.ejoysdk_stat")
    local stat_action = "hardware_info_error"
    local stat_params = {
      url = JSON.encode(hardware_info),
      sub_params_code = hardware_info.cpu.model,
      sub_params_message = hardware_info.cpu.max_freq,
      trace_id = hardware_info.gpu.model
    }
    stat.stat_action(stat_action, type, false, stat_params)
    HAS_STATED_STORAGE:set("true")
  end
  
  local cpu_model = hardware_info.cpu.model
  if nil == cpu_model or type(cpu_model) == "string" and 0 == #cpu_model then
    do_stat("cpu_model_empty")
    return
  end
  local cpu_max_freq = hardware_info.cpu.max_freq
  if nil == cpu_max_freq or -1 == cpu_max_freq then
    do_stat("cpu_max_freq_empty")
    return
  end
end

function Sysinfo.get_hardware_info(cb)
  M.ability_report("get_hardware_info")
  if not Sysinfo.is_support_hardware_info() then
    cb({})
    return
  end
  local hardware_info = {
    cpu = {
      model = Sysinfo.get_cpu_model(),
      core_num = Sysinfo.get_cpu_cores_count(),
      max_freq = Sysinfo.get_cpu_max_freq()
    },
    gpu = {},
    memory = {
      total_size = Sysinfo.memory().Total
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
  stat_hardware_info_error(hardware_info)
  if cb then
    cb(hardware_info)
  end
end

function Sysinfo.launch_time()
  local IVK_SYSINFO_LAUNCH_TIME = "SYSINFO_LAUNCH_TIME"
  do return M.sync_call, IVK_SYSINFO_LAUNCH_TIME end
  return M.sync_call, IVK_SYSINFO_LAUNCH_TIME, {}
end

function Sysinfo.launch_time_async(_cb)
end

function Sysinfo.run_time()
  return os.time() * 1000 - Sysinfo.launch_time()
end

function Sysinfo.run_time_async(_cb)
end

function Sysinfo.get_audio_mute_info(cb)
  if cb then
    local ret = M.sync_call("SYSINFO_AUDIO_MUTE_INFO")
    if not ret then
      cb(false, -1, "native error")
      return
    end
    cb(true, ret)
  end
end

function Sysinfo.start_listen_audio_mute()
  M.sync_call("START_LISTEN_AUDIO_MUTE_INFO")
end

function Sysinfo.stop_listen_audio_mute()
  M.sync_call("STOP_LISTEN_AUDIO_MUTE_INFO")
end

function Sysinfo.is_audio_mute_listen_open()
  do return M.sync_call end
  return M.sync_call, "IS_AUDIO_MUTE_LISTEN_OPEN"
end

function Sysinfo.get_screen_refresh_rate(cb)
  M.async_call("GET_SCREEN_REFRESH_RATE", {}, "", cb)
end

local Timer = {}
M.Timer = Timer

function Timer.once(interval, cb)
  local ACT_TIMER_ONCE = "TIMER_ONCE"
  M.async_call(ACT_TIMER_ONCE, {interval = interval, ver = "v2"}, "", function(_info, _body)
    cb()
  end)
end

function M.tick(once)
  register_event()
  repeat
    local cb_type, cbid, msg, chunk = _ejoysdk.tick(M.JAVA_CALL_STATIC_CLASS)
    if cb_type then
      local cb = _ejoysdk.get_register_cb(cb_type)
      if cb then
        cb(cbid, msg, chunk)
      end
    else
      return false
    end
  until true == once
  return true
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
local MEDIA_RECORD = "MEDIA_RECORD"
local media_record_cb = {}
_ejoysdk.register_cb(MEDIA_RECORD, function(cbid, js_str, _chunk)
  local params = media_record_cb[cbid]
  if params and params.volume_cb then
    local resp = JSON.decode(js_str)
    local stop = resp.stop or false
    if stop then
      media_record_cb[cbid] = nil
    else
      local volume = resp.volume
      local db = math.log(volume, 10) * 20
      _ejoysdk.log("lua volume: " .. volume .. " ,db: " .. db)
      params.volume_cb(db, volume)
    end
  end
end)

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
    show_permission_request = opt.show_permission_request or true,
    volume_trace_period = opt.volume_trace_period or 200,
    trace_volume = trace_volume
  }
  if params.format == "amr" then
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
  local ACT_MEDIA_START_RECORD = "MEDIA_START_RECORD"
  local cbid = M.async_call(ACT_MEDIA_START_RECORD, params, "", cb)
  if trace_volume then
    media_record_cb[cbid] = {
      volume_cb = opt.volume_cb
    }
  end
end

function Media.stop_record(opt, cb)
  local ACT_MEDIA_STOP_RECORD = "MEDIA_STOP_RECORD"
  local params = opt or {}
  
  local function cb_wrap(info, body)
    info.bytes = body
    cb(info)
  end
  
  M.async_call(ACT_MEDIA_STOP_RECORD, params, "", cb_wrap)
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
    volume = opt.volume or 1.0
  }
  local ACT_MEDIA_START_PLAY = "MEDIA_START_PLAY"
  local cbid = M.async_call(ACT_MEDIA_START_PLAY, params, "", cb)
  media_play_cbs[cbid] = {
    finish_cb = opt.finish_cb
  }
end

function Media.stop_play(opt, cb)
  local ACT_MEDIA_STOP_PLAY = "MEDIA_STOP_PLAY"
  local params = opt or {}
  M.async_call(ACT_MEDIA_STOP_PLAY, params, "", cb)
end

function Media.delete(opt, cb)
  local ACT_MEDIA_DELETE = "MEDIA_DELETE"
  local params = opt or {}
  M.async_call(ACT_MEDIA_DELETE, params, "", cb)
end

function Media.get_record_dir()
  local CT_MEDIA_RECORD_DIR = "MEDIA_RECORD_DIR"
  local ret = M.sync_call(CT_MEDIA_RECORD_DIR)
  return ret.path
end

function Media.is_support()
  return true
end

function M.goto_application_settings()
  local IVK_GOTO_APPLICATION_SETTINGS = "GOTO_APPLICATION_SETTINGS"
  M.invoke(IVK_GOTO_APPLICATION_SETTINGS)
end

local Permission = {}
M.Permission = Permission

function Permission.support_compliance_check()
  local CT_SUPPORT_COMPLIANCE_CHECK = "SUPPORT_COMPLIANCE_CHECK"
  if M.sync_call(CT_SUPPORT_COMPLIANCE_CHECK, {}, nil) then
    return true
  end
  return false
end

function Permission.async_support_compliance_check(cb)
  if cb then
    cb(M.Permission.support_compliance_check())
  end
end

function Permission.checkPermission(permission_detail, cb)
  local ACT_CHECK_PERMISSION = "CHECK_PERMISSION"
  M.async_call(ACT_CHECK_PERMISSION, permission_detail, "", function(resp, _chunk)
    if resp.ret == "0" then
      cb.onDeny()
    elseif resp.ret == "1" then
      cb.onGrant()
    end
  end)
end

function Permission.check_permission_v2(permission, cb)
  local ACT_CHECK_PERMISSION_V2 = "CHECK_PERMISSION_V2"
  if "notification" == permission and not M.is_support_function("notification_permission") then
    cb(true)
    return
  end
  M.async_call(ACT_CHECK_PERMISSION_V2, {permission = permission}, "", function(resp, _chunk)
    cb(resp.succ, resp)
  end)
end

local function compare_os_version(target_ver)
  local os_ver = tonumber(Sysinfo.os_version())
  if type(os_ver) == "nil" then
    _ejoysdk.log("compare_os_version failed!!! os_ver is nil")
    return -1
  end
  _ejoysdk.log("compare_os_version os_ver:" .. tostring(os_ver) .. ", target_ver:" .. tostring(target_ver))
  if target_ver < os_ver then
    return 1
  elseif os_ver == target_ver then
    return 0
  else
    return -1
  end
end

local permission_check_cache = {
  last_permission_rationale_cache = nil,
  last_permission_rationale_cache_first_start = nil,
  permission_first_start_checked_state = {},
  LAST_PERMISSION_RATIONALE_STATUS_CACHE = nil
}

local function keystore_for_last_permission_rationale()
  if permission_check_cache.LAST_PERMISSION_RATIONALE_STATUS_CACHE then
    return permission_check_cache.LAST_PERMISSION_RATIONALE_STATUS_CACHE
  end
  permission_check_cache.LAST_PERMISSION_RATIONALE_STATUS_CACHE = M.LazyKeyStore:New("LAST_PERMISSION_RATIONALE_STATUS_CACHE", false, true, false)
  permission_check_cache.last_permission_rationale_cache_first_start = permission_check_cache.LAST_PERMISSION_RATIONALE_STATUS_CACHE:get() or {}
  return permission_check_cache.LAST_PERMISSION_RATIONALE_STATUS_CACHE
end

local function is_harmonyos_support_grant_permission_current_start()
  local info_list = get_device_info_list()
  local hw_os_brand = info_list.hw_os_brand
  local hm_api_version = tonumber(info_list.hm_api_version) or 0
  local is_harmony_larger_than_3 = "harmony" == hw_os_brand and hm_api_version >= 6
  _ejoysdk.log("check_permission_v3 should_show_rationale_api_30" .. ", is_harmony_larger_than_3:" .. tostring(is_harmony_larger_than_3) .. ", hw_os_brand:" .. tostring(hw_os_brand) .. ", hm_api_version:" .. tostring(hm_api_version))
  return is_harmony_larger_than_3
end

local function is_support_grant_permission_current_start()
  local ret = compare_os_version(30)
  return ret >= 0 or is_harmonyos_support_grant_permission_current_start()
end

local function cache_rationale_api_30(permission, rationale)
  local support = is_support_grant_permission_current_start()
  if not support then
    return
  end
  local keystore = keystore_for_last_permission_rationale()
  if not permission_check_cache.last_permission_rationale_cache then
    permission_check_cache.last_permission_rationale_cache = keystore:get() or {}
  end
  local last_rationale = permission_check_cache.last_permission_rationale_cache[permission]
  local could_set_rationale_in_current_state = nil == rationale or nil == last_rationale and true == rationale or true == last_rationale and false == rationale or nil == last_rationale and false == rationale and is_harmonyos_support_grant_permission_current_start()
  _ejoysdk.log("check_permission_v3 cache_rationale_api_30 could_set_rationale_in_current_state:" .. tostring(could_set_rationale_in_current_state) .. ", last_rationale:" .. tostring(last_rationale) .. ", rationale:" .. tostring(rationale))
  if could_set_rationale_in_current_state then
    permission_check_cache.last_permission_rationale_cache[permission] = rationale
    keystore:set(permission_check_cache.last_permission_rationale_cache)
    _ejoysdk.log("check_permission_v3 cache_rationale_api_30, permisstion:" .. tostring(permission) .. ", rationale:" .. tostring(rationale))
  else
    _ejoysdk.log("check_permission_v3 cache_rationale_api_30, skip set rationale, permisstion:" .. tostring(permission) .. ", rationale:" .. tostring(rationale) .. ", last_rationale:" .. tostring(last_rationale))
  end
end

local function get_rationale_cache_api_30(permission)
  if not permission_check_cache.last_permission_rationale_cache then
    local keystore = keystore_for_last_permission_rationale()
    permission_check_cache.last_permission_rationale_cache = keystore:get() or {}
  end
  local last_permission_rationale_in_mem = permission_check_cache.last_permission_rationale_cache[permission]
  local last_permission_rationale_first_start = permission_check_cache.last_permission_rationale_cache_first_start[permission]
  return last_permission_rationale_in_mem, last_permission_rationale_first_start
end

local function should_show_rationale_api_30(permission, status)
  local current_rationale = 0 == status
  local rationale_result, need_follow_request_permission_result
  if not is_support_grant_permission_current_start() then
    _ejoysdk.log("check_permission_v3 should_show_rationale_api_30 below 30, just return:" .. tostring(status))
    rationale_result = current_rationale
  else
    local last_permission_rationale_in_mem, last_permission_rationale_first_start = get_rationale_cache_api_30(permission)
    local set_only_once_in_setting_check = false == last_permission_rationale_first_start and false == current_rationale
    local current_should_goto_settings = false == current_rationale and permission_check_cache.permission_first_start_checked_state[permission]
    rationale_result = not current_should_goto_settings
    need_follow_request_permission_result = rationale_result and nil ~= last_permission_rationale_in_mem
    _ejoysdk.log("check_permission_v3 should_show_rationale_api_30 above 30, last_permission_rationale:" .. tostring(last_permission_rationale_in_mem) .. ", current_rationale:" .. tostring(current_rationale) .. ", set_only_once_in_setting_check:" .. tostring(set_only_once_in_setting_check) .. ", should_goto_settings:" .. tostring(current_should_goto_settings) .. ", need_follow_request_permission_result:" .. tostring(need_follow_request_permission_result))
  end
  return rationale_result, need_follow_request_permission_result
end

local function save_current_reject_rationale(req_permissions, reject_permissions, reject_resps)
  if reject_permissions and next(reject_permissions) ~= nil and reject_resps then
    local _, reject_resp = next(reject_resps)
    local resp_has_rationale = reject_resp and type(reject_resp.show_rationale) == "boolean"
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    _ejoysdk.log("check_permission_v3 save_current_reject_rationale resp_has_rationale:" .. tostring(resp_has_rationale) .. ", reject_resps" .. tostring(CJSON.encode(reject_resps)))
    if not resp_has_rationale then
      _ejoysdk.log("check_permission_v3 save_current_reject_rationale native resp not has rationale, now detect permission manual")
      for _, reject_per in ipairs(reject_permissions) do
        permission_check_cache.permission_first_start_checked_state[reject_per] = true
        M.Permission.detect_permission(reject_per, function(succ, resp)
          if not succ then
            local rationale = -1 ~= resp.status
            cache_rationale_api_30(reject_per, rationale)
          end
        end)
      end
    else
      _ejoysdk.log("check_permission_v3 save_current_reject_rationale native resp has rationale, now set with native resp")
      for reject_permission, _resp in pairs(reject_resps) do
        permission_check_cache.permission_first_start_checked_state[reject_permission] = true
        local rationale = _resp.show_rationale
        cache_rationale_api_30(reject_permission, rationale)
      end
    end
  end
  for _, req_per in ipairs(req_permissions) do
    if not reject_resps[req_per] then
      cache_rationale_api_30(req_per, nil)
    end
  end
end

function Permission.check_permission_v3(options, cb)
  cb = cb or function()
  end
  if not options or not options.permissions then
    cb(true)
    return
  end
  
  local function show_goto_settings_dialog(forbidden_list)
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
  end
  
  local util = require("ejoysdk_lua.ejoysdk_utils")
  
  local function detect_finish_cb(not_allow_list, forbidden_list, not_allow_follow_req_ret)
    if forbidden_list and next(forbidden_list) then
      show_goto_settings_dialog(forbidden_list)
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
        M.Permission.check_permission_list_v2(not_allow_array, function(grant_ret, reject_permissions, reject_resps)
          save_current_reject_rationale(not_allow_array, reject_permissions, reject_resps)
          if grant_ret then
            cb(true)
          else
            local _forbidden_list = {}
            for _, permission in ipairs(reject_permissions) do
              local follow = not_allow_follow_req_ret[permission]
              if follow then
                _forbidden_list[permission] = not_allow_list[permission]
              end
            end
            local is_open_settings = next(_forbidden_list) ~= nil
            _ejoysdk.log("check_permission_v3 check_permission_list_v2 return, still has reject permissions, check follow and open settings result:" .. tostring(is_open_settings))
            if is_open_settings then
              show_goto_settings_dialog(_forbidden_list)
            end
            cb(false, is_open_settings)
          end
        end)
      end)
    else
      cb(true)
    end
  end
  
  local index = util.tablelength(options.permissions)
  local not_allow_permissions = {}
  local not_allow_follow_req_ret = {}
  local forbidden_permissions = {}
  for permission, description in pairs(options.permissions) do
    M.Permission.detect_permission(permission, function(succ, resp)
      index = index - 1
      if not succ then
        local status = resp.status
        local rationale, follow_req_per_ret = should_show_rationale_api_30(permission, status)
        if rationale then
          not_allow_permissions[permission] = description
          not_allow_follow_req_ret[permission] = follow_req_per_ret
        elseif -1 == status then
          forbidden_permissions[permission] = description
        end
      end
      if index <= 0 then
        detect_finish_cb(not_allow_permissions, forbidden_permissions, not_allow_follow_req_ret)
      end
    end)
  end
end

function Permission.detect_permission(permission, cb)
  if "notification" == permission and not M.is_support_function("notification_permission") then
    cb(true)
    return
  end
  local ACT_DETECT_PERMISSION = "DETECT_PERMISSION"
  M.async_call(ACT_DETECT_PERMISSION, {permission = permission}, "", function(resp, _chunk)
    if cb then
      cb(1 == resp.status, resp)
    end
  end)
end

function Permission.openSetting(ext_param)
  local IVK_OPEN_PERMISSION_SETTING = "OPEN_PERMISSION_SETTING"
  M.sync_call(IVK_OPEN_PERMISSION_SETTING, ext_param or {}, nil)
end

function Permission.openApplicationSetting()
  if M.is_support_function(M.NATIVE_SUPPORT_FUNCTION_NAMES.OPEN_COMMON_SETTING) then
    local IVK_OPEN_PERMISSION_COMMON_SETTING = "OPEN_PERMISSION_COMMON_SETTING"
    M.sync_call(IVK_OPEN_PERMISSION_COMMON_SETTING, {}, nil)
  else
    Permission.openSetting()
  end
end

function Permission.get_requested_permissions()
  local IVK_GET_REQUESTED_PERMISSIONS = "GET_REQUESTED_PERMISSIONS"
  do return M.sync_call end
  return M.sync_call, IVK_GET_REQUESTED_PERMISSIONS
end

function Permission.async_get_requested_permissions(cb)
  if cb then
    cb(M.Permission.get_requested_permissions())
  end
end

function Permission.show_usage_dialog(options, cb)
  cb = cb or function()
  end
  
  local function cb_wrapper(...)
    cb(...)
    M.USAGE_DIALOG_IS_SHOWED = false
  end
  
  options = options or {}
  if not options.permissions then
    cb_wrapper(-1)
    return
  end
  options.style = "lingxi"
  if not options.title or not options.message then
    local title, desc = M.Permission.permission_default_description(options.permissions)
    options.title = options.title or title or ""
    options.message = options.message or desc or ""
  end
  options.buttons = options.buttons or {"确定"}
  M.USAGE_DIALOG_IS_SHOWED = true
  M.Modal.open(options.title, options, cb_wrapper)
end

local Sdkinfo = {}
M.Sdkinfo = Sdkinfo

function Sdkinfo.getSDKVersionName(sdkName)
  local IVK_GET_SDK_VERSION_NAME = "GET_SDK_VERSION_NAME"
  return M.sync_call(IVK_GET_SDK_VERSION_NAME, {name = sdkName}).value
end

function M.qrcode_scan(cb)
  local ACT_QRCODE_SCAN = "QRCODE_SCAN"
  
  local function scan_result_handler(info)
    _ejoysdk.log("android qrcode_scan result: ")
    M.log(info)
    if info.succ then
      cb(true, info.result)
    else
      cb(false, info.err_code, info.err_msg)
    end
  end
  
  M.async_call(ACT_QRCODE_SCAN, {}, "", scan_result_handler)
end

function M.get_cba_tweleve_info()
  return {}
end

function M.support_save_to_album()
  local CT_SUPPORT_SAVE_TO_ALBUM = "SUPPORT_SAVE_TO_ALBUM"
  if M.sync_call(CT_SUPPORT_SAVE_TO_ALBUM, {}, nil) then
    return true
  end
  return false
end

function M.save_to_album(path, need_delete, cb)
  local ACT_SAVE_TO_ALBUM = "SAVE_TO_ALBUM"
  if M.support_save_to_album() then
    local params = {img_path = path, need_delete = need_delete}
    local os_version = Sysinfo.os_version() or ""
    local os_version_number = tonumber(os_version)
    if M.USAGE_DIALOG_IS_SHOWED == false and os_version_number and os_version_number < 29 then
      M.Permission.detect_permission("android.permission.WRITE_EXTERNAL_STORAGE", function(succ)
        if not succ then
          local options = {
            style = "lingxi",
            buttons = {
              LANG.getString("confirm", "确定")
            },
            permissions = {
              ["android.permission.WRITE_EXTERNAL_STORAGE"] = {}
            }
          }
          M.Permission.show_usage_dialog(options, function()
            M.async_call(ACT_SAVE_TO_ALBUM, params, "", cb)
          end)
        else
          M.async_call(ACT_SAVE_TO_ALBUM, params, "", cb)
        end
      end)
      return
    end
    M.async_call(ACT_SAVE_TO_ALBUM, params, "", cb)
  else
    cb({
      code = -99,
      msg = "保存失败，暂不支持该功能"
    })
  end
end

function M.kill_app()
  _ejoysdk.log("kill_app begin")
  local IVK_KILL_APP = "KILL_APP"
  do return M.sync_call end
  return M.sync_call, IVK_KILL_APP
end

_Private._is_support_tap_appreviews = nil

function _Private.is_support_tap_appreviews()
  if type(_Private._is_support_tap_appreviews) == "boolean" then
    M.log("is_support_tap_appreviews has cache just return:" .. tostring(_Private._is_support_tap_appreviews))
    return _Private._is_support_tap_appreviews
  end
  local CONFIG = require("ejoysdk_lua.ejoysdk_config")
  if CONFIG.has_vendor_config("tapreview") then
    _Private._is_support_tap_appreviews = true
    _ejoysdk.log("support_app_reviews")
  elseif CONFIG.has_vendor_config("tapupdate") then
    local VC = require("ejoysdk_lua.ejoysdk_version_check")
    local tapupdate_ver = M.Sdkinfo.getSDKVersionName("TAP_UPDATE")
    local cmp_result = VC.compare_versions(tapupdate_ver, "4.5.3.8") >= 0 and VC.compare_versions(tapupdate_ver, "4.5.3.10") < 0
    _Private._is_support_tap_appreviews = cmp_result
    _ejoysdk.log("support_app_reviews tapupdate_ver:" .. tostring(tapupdate_ver) .. ", is_tapupdate_support:" .. tostring(_Private._is_support_tap_appreviews))
  else
    _ejoysdk.log("support_app_reviews not has tapupdate config, not support tapupdate app reviews")
    _Private._is_support_tap_appreviews = false
  end
  return _Private._is_support_tap_appreviews
end

function M.support_app_reviews()
  if _Private.is_support_tap_appreviews() then
    M.log("support_app_reviews support tap app reviews just return true")
    return true
  else
    M.log("support_app_reviews not support tap app reviews, now check ejoysdk native support")
  end
  local CT_SUPPORT_APP_REVIEWS = "SUPPORT_APP_REVIEWS"
  local ret = M.sync_call(CT_SUPPORT_APP_REVIEWS, {}, nil)
  return ret and ret.support == true
end

function M.async_support_app_reviews(cb)
  if cb then
    cb(M.support_app_reviews())
  end
end

function M.app_reviews(cb)
  local ACT_APP_REVIEWS = "APP_REVIEWS"
  M.ability_report("app_reviews")
  if _Private.is_support_tap_appreviews() then
    M.log("app_reviews support tap app reviews just call tap update sdk")
    local CONFIG = require("ejoysdk_lua.ejoysdk_config")
    local has_review = CONFIG.has_vendor_config("tapreview")
    local UNI = require("ejoysdk_lua.vendors.unisdk")
    if has_review then
      UNI.async_call("TAP_REVIEW", ACT_APP_REVIEWS, {}, nil, function(succ, ...)
        M.LOG.debug("TAP_REVIEW", "open tap reviews complete >>" .. tostring(succ))
        if cb then
          cb({code = 1})
        end
      end)
    else
      UNI.async_call("TAP_UPDATE", ACT_APP_REVIEWS, {}, nil, function(succ, ...)
        M.LOG.debug("TAP_UPDATE", "open tap reviews complete >>" .. tostring(succ))
        if cb then
          cb({code = 1})
        end
      end)
    end
  else
    M.log("app_reviews not support tap app reviews, now call ejoysdk native app reviews")
    M.async_call(ACT_APP_REVIEWS, {}, "", function(ret)
      if cb then
        cb(ret)
      end
    end)
  end
end

function M.comment_app()
  M.app_reviews()
end

function M.copy_clipboard(params)
  local CT_COPY_CLIPBOARD = "COPY_CLIPBOARD"
  do return M.sync_call, CT_COPY_CLIPBOARD end
  return M.sync_call, CT_COPY_CLIPBOARD, params
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

function Calendar.add_event(params, cb)
  local ACT_CALENDAR_ADD_EVENT = "CALENDAR_ADD_EVENT"
  M.async_call(ACT_CALENDAR_ADD_EVENT, params, "", function(ret)
    if cb then
      local data = ret.data
      local succ = ret.succ
      if succ then
        cb(true, data)
      else
        local code = ret.code
        local msg = ret.msg
        cb(false, code, msg)
      end
    end
  end)
end

function Calendar.delete_event(params, cb)
  local ACT_CALENDAR_DEL_EVENT = "CALENDAR_DEL_EVENT"
  M.async_call(ACT_CALENDAR_DEL_EVENT, params, "", function(ret)
    if cb then
      local data = ret.data
      local succ = ret.succ
      if succ then
        cb(true, data)
      else
        local code = ret.code
        local msg = ret.msg
        cb(false, code, msg)
      end
    end
  end)
end

function Calendar.update_event(params, cb)
  local ACT_CALENDAR_UPDATE_EVENT = "CALENDAR_UPDATE_EVENT"
  M.async_call(ACT_CALENDAR_UPDATE_EVENT, params, "", function(ret)
    if cb then
      local data = ret.data
      local succ = ret.succ
      if succ then
        cb(true, data)
      else
        local code = ret.code
        local msg = ret.msg
        cb(false, code, msg)
      end
    end
  end)
end

function Calendar.query_event(params, cb)
  local ACT_CALENDAR_QUERY_EVENT = "CALENDAR_QUERY_EVENT"
  M.async_call(ACT_CALENDAR_QUERY_EVENT, params, "", function(ret)
    if cb then
      local data = ret.data
      local succ = ret.succ
      if succ then
        cb(true, data)
      else
        local code = ret.code
        local msg = ret.msg
        cb(false, code, msg)
      end
    end
  end)
end

function Calendar.query_event_id(params, cb)
  local ACT_CALENDAR_QUERY_EVENT_ID = "CALENDAR_QUERY_EVENT_ID"
  M.async_call(ACT_CALENDAR_QUERY_EVENT_ID, params, "", function(ret)
    if cb then
      local data = ret.data
      local succ = ret.succ
      if succ then
        cb(true, data)
      else
        local code = ret.code
        local msg = ret.msg
        cb(false, code, msg)
      end
    end
  end)
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
  local ACT_SENSOR_SET_THRESHOLD = "ACT_SENSOR_SET_THRESHOLD"
  if threshold and threshold > 0 then
    M.Sensor.TimeThreshold = threshold
    M.sync_call(ACT_SENSOR_SET_THRESHOLD, {
      value = M.Sensor.TimeThreshold
    })
  end
end

function Sensor.register_shake(cb)
  local ACT_SENSOR_SHAKE_REGISTER = "ACT_SENSOR_SHAKE_REGISTER"
  shake_cb = cb
  M.sync_call(ACT_SENSOR_SHAKE_REGISTER, {
    value = M.Sensor.TimeThreshold
  })
end

function Sensor.unregister_shake()
  local ACT_SENSOR_SHAKE_UNREGISTER = "ACT_SENSOR_SHAKE_UNREGISTER"
  shake_cb = nil
  M.sync_call(ACT_SENSOR_SHAKE_UNREGISTER)
end

function Sensor.is_shake_support()
  local IS_SENSOR_SHAKE_SUPPORT = "IS_SENSOR_SHAKE_SUPPORT"
  local ret = M.sync_call(IS_SENSOR_SHAKE_SUPPORT)
  if ret then
    _ejoysdk.log("ret support >> " .. tostring(ret.support))
    return ret.support or false
  end
  return false
end

function M.get_brightness()
  local ACT_GET_BRIGHTNESS = "GET_BRIGHTNESS"
  local result = M.sync_call(ACT_GET_BRIGHTNESS)
  if nil == result or nil == result.value then
    return -1
  else
    return result.value
  end
end

function M.set_brightness(brightness)
  local ACT_SET_BRIGHTNESS = "SET_BRIGHTNESS"
  M.sync_call(ACT_SET_BRIGHTNESS, {value = brightness})
end

function M.reset_brightness()
  local ACT_RESET_BRIGHTNESS = "RESET_BRIGHTNESS"
  M.sync_call(ACT_RESET_BRIGHTNESS)
end

function M.vibrate(milliseconds)
  local ACT_VIBRATE = "VIBRATE"
  M.sync_call(ACT_VIBRATE, {time = milliseconds})
end

function M.is_vibrate_support()
  local ACT_SUPPORT_VIBRATE = "SUPPORT_VIBRATE"
  local result = M.sync_call(ACT_SUPPORT_VIBRATE)
  if nil == result then
    return false
  else
    return result.value == "true"
  end
end

function M.get_system_properties(key, default_value)
  local ACT_GET_SYSTEM_PROPERTIES = "GET_SYSTEM_PROPERTIES"
  local params = {key = key, default_value = default_value}
  local result = M.sync_call(ACT_GET_SYSTEM_PROPERTIES, params)
  if result then
    return result.value
  end
end

function M.set_app_orientation(_orientation)
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

function M.scroll_log_file(file_name)
  local IVK_SCROLL_LOG_FILE = "SCROLL_LOG_FILE"
  do return M.sync_call, IVK_SCROLL_LOG_FILE end
  return M.sync_call, IVK_SCROLL_LOG_FILE, {
    file_name = file_name or ""
  }, file_name or ""
end

function M.flush_log()
  local IVK_FLUSH_LOG = "FLUSH_LOG"
  do return M.sync_call end
  return M.sync_call, IVK_FLUSH_LOG
end

function M.is_log_file_support()
  return _ejoysdk_lua_cjson ~= nil
end

function M.get_log_file_infos(_params, cb)
  local params = _params or {}
  local IVK_GET_LOG_FILES = "GET_LOG_FILES"
  M.async_call(IVK_GET_LOG_FILES, params, "", function(ret)
    if cb then
      cb(ret)
    end
  end)
end

function M.get_current_log_file(_params, cb)
  local params = _params or {}
  local IVK_GET_CURRENT_LOG_FILE = "GET_CURRENT_LOG_FILE"
  M.async_call(IVK_GET_CURRENT_LOG_FILE, params, "", function(ret)
    if cb then
      cb(ret)
    end
  end)
end

function M.get_ej_debugable()
  local IVK_IS_EJOYSDK_DEBUGABLE = "IS_EJOYSDK_DEBUGABLE"
  do return M.sync_call, IVK_IS_EJOYSDK_DEBUGABLE end
  return M.sync_call, IVK_IS_EJOYSDK_DEBUGABLE, {}
end

function M.get_ej_detail_debuggable()
  do return M.File.process_exists end
  return M.File.process_exists, "/sdcard/ejoysdk_dl.debug"
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
  local platform = "google"
  local IVK_GET_GOOGLE_PURCHASE_ITEMS = "GET_GOOGLE_PURCHASE_ITEMS"
  if M.is_support_function("get_google_purchase_items") then
    M.async_call(IVK_GET_GOOGLE_PURCHASE_ITEMS, {}, nil, function(ret)
      local succ = ret.succ
      if true == succ then
        cb(true, platform, ret.data or {}, ret.origin_data or {}, ret.type)
      else
        cb(false, platform, ret.code or -2, ret.msg or "unknown")
      end
    end)
  else
    cb(false, platform, -1, "not support")
  end
end

function _FileBatch.process_batch_remove(list, cb, opts)
  local ACT_FILE_BATCH_REMOVE = "FILE_BATCH_REMOVE"
  list = list or {}
  local list_size = #list
  if 0 == list_size then
    if cb then
      cb(true)
    end
    return
  end
  _ejoysdk.log("_FileBatch process_batch_remove begin:" .. tostring(list_size))
  M.async_call(ACT_FILE_BATCH_REMOVE, {files = list, opts = opts}, "", function(ret)
    ret = ret or {}
    if cb then
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end)
end

function _FileBatch.process_batch_rename(map, cb, opts)
  local ACT_FILE_BATCH_RENAME = "FILE_BATCH_RENAME"
  _ejoysdk.log("_FileBatch process_batch_rename begin")
  M.async_call(ACT_FILE_BATCH_RENAME, {files = map, opts = opts}, "", function(ret)
    ret = ret or {}
    if cb then
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end)
end

function _FileBatch.process_copy(src_fullpath, dst_fullpath, opts)
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  local ACT_FILE_COPY = "FILE_COPY"
  local result = M.sync_call(ACT_FILE_COPY, {
    src_path = src_fullpath,
    dst_path = dst_fullpath,
    need_override = override
  }, "")
  return result.succ, result.code, result.msg
end

function _FileBatch.process_batch_copy(map, cb, opts)
  local ACT_FILE_BATCH_COPY = "FILE_BATCH_COPY"
  local override = true
  opts = opts or {}
  if type(opts.override) == "boolean" then
    override = opts.override
  end
  _ejoysdk.log("_FileBatch process_batch_copy begin:" .. tostring(override))
  M.async_call(ACT_FILE_BATCH_COPY, {
    files = map,
    need_override = override,
    opts = opts
  }, "", function(ret)
    ret = ret or {}
    if cb then
      cb(ret.succ, ret.code, ret.msg, ret.result_ext)
    end
  end)
end

function _FileBatch.process_batch_md5(file_list, cb, base_path)
  local ACT_FILE_BATCH_MD5 = "FILE_BATCH_MD5"
  _ejoysdk.log("_FileBatch process_batch_md5 begin:" .. tostring(file_list and #file_list or 0))
  M.async_call(ACT_FILE_BATCH_MD5, {files = file_list, base_path = base_path}, "", function(ret)
    ret = ret or {}
    if cb then
      ret.result_ext = ret.result_ext or {}
      if ret.succ then
        cb(true, ret.result_ext.succ_data or {})
      else
        cb(false, ret.code, ret.msg, ret.result_ext.succ_data or {}, ret.result_ext.fail_data)
      end
    end
  end)
end

function _FileBatch.process_batch_info(file_list, cb, _opts)
  local ACT_FILE_BATCH_INFO = "FILE_BATCH_INFO"
  M.async_call(ACT_FILE_BATCH_INFO, {files = file_list, opts = _opts}, "", function(ret)
    ret = ret or {}
    if cb then
      ret.result_ext = ret.result_ext or {}
      cb(ret.result_ext)
    end
  end)
end

function _FileBatch.process_is_directory(file_path)
  _ejoysdk.log("_FileBatch process_is_directory begin:" .. tostring(file_path))
  local CT_FILE_IS_DIRECTORY = "FILE_IS_DIRECTORY"
  local ret = M.sync_call(CT_FILE_IS_DIRECTORY, {path = file_path})
  ret = ret or {}
  return ret.value, ret.code, ret.msg
end

function _FileBatch.process_list_directory(dir_path, recursive, cb)
  _ejoysdk.log("_FileBatch process_list_directory begin:" .. tostring(dir_path) .. ", recur:" .. tostring(recursive))
  local CT_FILE_LIST_DIRECTORY = "FILE_LIST_DIRECTORY"
  M.async_call(CT_FILE_LIST_DIRECTORY, {path = dir_path, recur = recursive}, "", function(ret)
    ret = ret or {}
    local data = ret.value or {}
    if cb then
      cb(data)
    end
  end)
end

function _FileBatch.process_list_bundle(dir_path, recursive, cb)
  _ejoysdk.log("_FileBatch process_list_bundle begin:" .. tostring(dir_path) .. ", recur:" .. tostring(recursive))
  local CT_FILE_LIST_BUNDLE = "FILE_LIST_BUNDLE"
  M.async_call(CT_FILE_LIST_BUNDLE, {path = dir_path, recur = recursive}, "", function(ret)
    ret = ret or {}
    local data = ret.value or {}
    if cb then
      cb(data)
    end
  end)
end

_ejoysdk.register_cb("PATCH_EVENT", function(cbid, patch_cb_info, _chunk)
  local params = patch_progress_cbs[cbid]
  if params then
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local resp = CJSON.decode(patch_cb_info) or {}
    if params.progress then
      params.progress(resp.completeCount, resp.totalCount)
    end
  end
end)

function M.patch_dir(params, cb, progress_cb)
  local IVK_PATCH_DIR = "PATCH_DIR"
  local cbid = M.async_call(IVK_PATCH_DIR, params, nil, function(resp)
    if 0 == resp.ret then
      cb(true)
    else
      cb(false, resp.ret)
    end
  end)
  M.log("patch cbid is " .. tostring(cbid))
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
      local IVK_PATCH_FILES = "PATCH_FILES"
      local cbid = M.async_call(IVK_PATCH_FILES, params, nil, function(resp)
        if 0 == resp.ret then
          cb(true)
        else
          cb(false, resp.ret, resp.patch_succ_files, resp.patch_fail_files)
        end
      end)
      M.log("patch files cbid is " .. tostring(cbid))
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
  if not _params.media_type or _params.media_type == "" or _params.media_type == "none" then
    _params.media_type = "image"
  end
  if _params.media_type == "image" and M.is_support_function("image_picker") then
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
  _params.editable = _params.enable_edit == nil and true or _params.enable_edit
  M.async_call("PICKER", _params, "", function(ret, file_data)
    _Private.is_picker_processing = false
    ret = ret or {}
    local succ = ret.succ
    if succ then
      ret.data = ret.data or {}
      ret.data.file_data = file_data
      ret.data.size = #file_data
      ret.data.image_path = ret.data.file_path
      if cb then
        cb(true, {
          ret.data
        })
      end
    else
      local code, msg = ret.code, ret.msg
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

function M.image_picker(max_select_num, _params, cb)
  if not M.is_support_function("image_picker") then
    if cb then
      cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
    end
    return
  end
  if _Private.is_image_picker_processing then
    M.LOG.debug("image_picker", "image_picker is processing, return directly")
    if cb then
      cb(false, ECC.BASE_API_COMMON_ERROR.CODE_IN_PROCESSING, "image_picker is busy")
    end
    return
  end
  _Private.is_image_picker_processing = true
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
  params.force_clip_ratio_x = nil == _params.force_clip_ratio_x and 0 or _params.force_clip_ratio_x
  params.force_clip_ratio_y = nil == _params.force_clip_ratio_y and 0 or _params.force_clip_ratio_y
  params.enable_camera = nil == _params.enable_camera and true or _params.enable_camera
  params.done_btn_text = _params.done_btn_text
  M.async_call("IMAGE_PICKER", params, "", function(ret)
    _Private.is_image_picker_processing = false
    ret = ret or {}
    local succ = ret.succ
    M.LOG.debug("image_picker ret", ret)
    if succ then
      ret.data = ret.data or {}
      if cb then
        cb(true, ret.data)
      end
    else
      local code, msg = ret.code, ret.msg
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

function M.subscribe_msg(options, cb)
  local CLOUDGAME_3RD = require("ejoysdk_lua.ejoysdk_cloudgame_3rd")
  if CLOUDGAME_3RD.is_cloudgame() then
    local cvd = CLOUDGAME_3RD.get_cloudgame_vendor()
    if cvd and cvd.subscribe_msg then
      options = options or {}
      if not options.tmplIds then
        local meta_config = M.CONFIG.get_vendor_config_v2(CLOUDGAME_3RD.get_cloudgame_type()) or {}
        local template_id = meta_config.message_template_id
        local tmplIds = {}
        if template_id then
          table.insert(tmplIds, template_id)
        end
        options.tmplIds = tmplIds
        options.template_id = template_id
      end
      cvd.subscribe_msg(options, cb)
    elseif cb then
      cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
    end
  elseif cb then
    cb(false, ECC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "not support")
  end
end

return M

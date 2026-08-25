local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local CHANNEL = "CRASH_SDK"
local M = Vendor:Inherit(CHANNEL)
local CAST_INIT_CRASH_SDK = "CAST_INIT_CRASH_SDK"
local CAST_CRASH_SDK_UPDATE_DATA = "CAST_CRASH_SDK_UPDATE_DATA"
local CAST_CREATE_CUSTOM_LOG = "CAST_CREATE_CUSTOM_LOG"
local CAST_ADD_HEADER_INFO = "CAST_ADD_HEADER_INFO"
local CAST_ADD_CACHED_INFO = "CAST_ADD_CACHED_INFO"
local TAG = EM.MODULE.VENDORS.CRASH_SDK
local ffi_supported_os = {weixin = true, douyin = true}
local support_ffi = ffi_supported_os[E.Sysinfo.os()] or false
local ffi_crash_sdk = _ejoysdk.ffi_crash_sdk and _ejoysdk.ffi_crash_sdk() or nil

function M.create_custom_log(log_level, err_msg, stack_trace, stack_hash, extra)
  if "" == stack_hash then
    stack_hash = nil
  end
  if _ejoysdk.os() == "windows" then
    _ejoysdk.error_report("lua", log_level, err_msg, stack_trace, stack_hash, extra)
    return
  end
  local log_params = {
    logType = "lua",
    logLevel = log_level,
    errMsg = err_msg,
    stackTrace = stack_trace,
    stackHash = stack_hash,
    extra = extra
  }
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.createCustomLog(log_params)
  else
    UNI.cast(CHANNEL, CAST_CREATE_CUSTOM_LOG, log_params)
  end
end

function M.create_custom_log_with_checkutf8(log_level, err_msg, stack_trace, stack_hash, extra)
  stack_trace = EU.verify_utf_char(stack_trace)
  err_msg = EU.verify_utf_char(err_msg)
  extra = EU.verify_utf_char(extra)
  M.create_custom_log(log_level, err_msg, stack_trace, stack_hash, extra)
end

function M.add_header_info(key, value)
  assert(type(key) == "string", "key must be string")
  assert(type(value) == "string", "value must be string")
  local header = {key = key, value = value}
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.addHeaderInfo(header)
  else
    UNI.cast(CHANNEL, CAST_ADD_HEADER_INFO, header)
  end
end

function M.add_cached_info(key, value)
  assert(type(key) == "string", "key must be string")
  assert(type(value) == "string", "value must be string")
  local param = {key = key, value = value}
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.addCachedInfo(param)
  else
    UNI.cast(CHANNEL, CAST_ADD_CACHED_INFO, param)
  end
end

local function init_crash_sdk(crash_doc_url)
  local ch = E.get_channel()
  local game_id = E.get_game_id()
  local init_param = {
    channel_id = ch,
    game_id = game_id,
    crash_doc_url = crash_doc_url
  }
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.luaCrashInit(init_param)
  else
    UNI.cast(CHANNEL, CAST_INIT_CRASH_SDK, init_param)
  end
end

local function update_data(params)
  if support_ffi and ffi_crash_sdk then
    for key, value in pairs(params) do
      ffi_crash_sdk.updateHeaderInfo({key = key, value = value})
    end
  else
    UNI.cast(CHANNEL, CAST_CRASH_SDK_UPDATE_DATA, params)
  end
end

local function login_handler(user_info)
  local params = {
    uid = user_info.uid
  }
  update_data(params)
end

local function gangplank_logout_handler()
  local params = {uid = ""}
  update_data(params)
end

local function gangplank_exit_handler()
  M.exit()
end

function M.exit()
  local params = {uid = ""}
  update_data(params)
  E.LOG.debug(TAG, "接收到gangplank exit事件，退出崩溃SDK")
  UNI.exit(CHANNEL)
end

local function get_progress(current, total)
  return current .. "/" .. total
end

local DUMP_UPDATE_EVENT = {
  SUCC = "crashsdk_dump_upload_succ",
  FAIL = "crashsdk_dump_upload_fail",
  GZIP_fail = "crashsdk_dump_zip_fail",
  Complete = "crashsdk_dump_upload_complete"
}

local function do_stat_action(event, succ, params)
  local stat = require("ejoysdk_lua.ejoysdk_stat")
  stat.stat_action(event, TAG, succ, {
    is_priority_high = true,
    progress_table = params or nil
  })
end

local MAX_RETRY_PER_FILE = 3
local MAX_UPLOAD_COUNT = 3

local function ensure_gz_file_exists(dmp_path)
  local gz_path = dmp_path .. ".gz"
  local EC = require("ejoysdk_lua.ejoysdk_constants")
  local file_size
  if _ejoysdk.file_length then
    file_size = _ejoysdk.file_length(dmp_path)
  end
  if not file_size or file_size <= 0 then
    return false, nil, EC.EJOY_LIB_ERROR.FILE_SIZE_GET_FAILED, "Invalid file size"
  end
  if file_size > 104857600 then
    E.LOG.debug(TAG, "Skip gzipping oversized file: " .. dmp_path .. " (" .. file_size .. " bytes)")
    return false, nil, EC.EJOY_LIB_ERROR.FILE_OPEN_FAILED, "File exceeds 100MB limit"
  end
  E.LOG.debug(TAG, "Compressing to gz: " .. gz_path)
  local zip = require("ejoysdk_lua.libs.zip")
  local ok, code, msg = zip.win_gzip_file_full_path(dmp_path, gz_path)
  if not ok then
    return false, nil, code, msg
  end
  return true, gz_path, 0, ""
end

local function upload_dump(dir_name, dump_list, on_complete)
  local function upload_with_retry(idx, retry)
    if idx > #dump_list then
      do_stat_action(DUMP_UPDATE_EVENT.Complete, true, nil)
      
      on_complete()
      return
    end
    local dump_file = dump_list[idx]
    local full_path = dir_name .. "/" .. dump_file
    E.LOG.debug(TAG, string.format("Uploading crash file[%d/%d]: %s with (retry=%d)", idx, #dump_list, dump_file, retry))
    local gz_ok, gz_path, gz_code, gz_msg = ensure_gz_file_exists(full_path)
    local dump_size = _ejoysdk.file_length(full_path)
    if not gz_ok then
      E.LOG.debug(TAG, "Failed to prepare gz for " .. dump_file .. ",code: " .. tostring(gz_code) .. " ,msg: " .. tostring(gz_msg))
      upload_with_retry(idx + 1, 0)
      do_stat_action(DUMP_UPDATE_EVENT.GZIP_fail, false, {
        wk_dump_file_name = full_path,
        progress = get_progress(idx, #dump_list),
        retry = retry,
        code = gz_code,
        msg = gz_msg,
        file_size = dump_size
      })
      return
    end
    local log_collector = require("ejoysdk_lua.server_api.log_collector_ex")
    log_collector.upload_and_commit({dummy_player_id = dump_file}, gz_path, log_collector.INPUT_TYPE.PATH, "application/octet-stream", function(succ, ...)
      if succ then
        local msg = string.format("dump file %s upload succ ", dump_file)
        E.LOG.debug(TAG, msg)
        E.File.remove_fullpath(full_path)
        E.File.remove_fullpath(gz_path)
        do_stat_action(DUMP_UPDATE_EVENT.SUCC, true, {
          wk_dump_file_name = full_path,
          progress = get_progress(idx, #dump_list),
          retry = retry,
          file_size = dump_size
        })
        upload_with_retry(idx + 1, 0)
      else
        local code, msg = ...
        if retry < MAX_RETRY_PER_FILE then
          local f_msg = string.format("Uploading crash file[%d/%d] failed: %s with (retry=%d) , code: %d , message: %s", idx, #dump_list, dump_file, retry, code, msg)
          E.LOG.debug(TAG, f_msg)
          upload_with_retry(idx, retry + 1)
        else
          E.LOG.debug(TAG, string.format("dump %s upload failed with retry time:%d", dump_file, retry))
          do_stat_action(DUMP_UPDATE_EVENT.FAIL, false, {
            wk_dump_file_name = full_path,
            progress = get_progress(idx, #dump_list),
            retry = retry,
            code = code,
            msg = msg,
            file_size = dump_size
          })
          upload_with_retry(idx + 1, 0)
        end
      end
    end)
  end
  
  upload_with_retry(1, 0)
end

local is_dump_uploading = false

local function upload_crash_dumps_limited(crash_dir_path)
  if is_dump_uploading then
    E.LOG.debug(TAG, "dump file uploading task is running,skipping duplicate call")
    return
  else
    is_dump_uploading = true
  end
  E.File.process_list_directory(crash_dir_path, false, function(file_list, code, msg)
    if not file_list then
      E.LOG.debug(TAG, "list crash dir error, code: " .. tostring(code) .. ", message: " .. tostring(msg))
      return
    end
    for i, entry in ipairs(file_list) do
      if entry.is_dir == false and entry.path and E.Utils.end_with(entry.path, ".gz.tmp") then
        local succ, rm_code, rm_msg = E.File.remove_fullpath(crash_dir_path .. "/" .. entry.path)
        if succ then
          E.LOG.debug(TAG, "Cleaned up  tmp file: " .. entry.path .. " at index: " .. tostring(i))
        else
          E.LOG.debug(TAG, "Failed to remove tmp file: " .. entry.path .. " ,code: " .. tostring(rm_code) .. " ,msg: " .. rm_msg)
        end
      end
    end
    local dmp_list = {}
    for _, entry in ipairs(file_list) do
      if entry.is_dir == false and entry.path and string.match(entry.path, "%.dmp$") then
        table.insert(dmp_list, entry.path)
      end
    end
    if 0 == #dmp_list then
      E.LOG.debug(TAG, "no dump file found")
      return
    end
    table.sort(dmp_list, function(a, b)
      return b < a
    end)
    local upload_list = {}
    local count = math.min(MAX_UPLOAD_COUNT, #dmp_list)
    for i = 1, count do
      table.insert(upload_list, dmp_list[i])
    end
    E.LOG.debug(TAG, string.format("try uploading total %d  dumps :", #upload_list))
    E.LOG.debug(TAG, upload_list)
    
    local function on_complete()
      E.LOG.debug(TAG, "dump upload task finished!")
      is_dump_uploading = false
    end
    
    upload_dump(crash_dir_path, upload_list, on_complete)
  end)
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "crashsdk start init!")
  if _ejoysdk.os() == "windows" then
    local CC = require("ejoysdk_lua.ejoysdk_config_center")
    local biz_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
    local do_upload_dump = true
    if biz_config and biz_config.config and biz_config.config.dump_config and biz_config.config.dump_config.upload_dump == false then
      do_upload_dump = false
    end
    local url = "https://alidocs.dingtalk.com/i/nodes/YMyQA2dXW7gYo6MzcpDQA0kOWzlwrZgb?corpId="
    init_crash_sdk(url)
    local sys_dirs = E.File.get_sys_dirs()
    local crash_dir_path = sys_dirs.program_private_dir .. "/dump"
    if true == do_upload_dump then
      E.LOG.debug(TAG, "crashsdk will launch dump upload task!")
      upload_crash_dumps_limited(crash_dir_path)
    else
      E.LOG.debug(TAG, "crashsdk will not launch dump upload task!")
    end
  else
    init_crash_sdk()
  end
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  cb(true)
end

return M

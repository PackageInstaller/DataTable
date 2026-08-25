local E = require("ejoysdk_lua.ejoysdk")
local JSONUtils = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local FileUtils = require("ejoysdk_lua.apm-sdk-lua.common.file_utils")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local ErrUtils = require("ejoysdk_lua.apm-sdk-lua.common.err_utils")
local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local M = {}
M.__index = M
M.ERROR = {CODE_NOT_SUPPORT = 7014100, CODE_ERROR_PARAMS = 7014101}
local LOGGER = "apm_ejoysdkutils"

function M.has_upgrade_log_file_native()
  if type(E.is_log_file_support) == "function" then
    E.LOG.debug(LOGGER, "E.is_log_file_support:" .. tostring(E.is_log_file_support()))
    do return end
    return E.is_log_file_support, LOGGER, "E.is_log_file_support:" .. tostring(E.is_log_file_support()), tostring(E.is_log_file_support()), E.is_log_file_support()
  end
  local os = E.Sysinfo.os() or ""
  return ("android" == os or "ios" == os) and _ejoysdk_lua_cjson ~= nil
end

function M.use_file_store()
  local has_save_with_prefix_function = type(E.LOG.save_with_prefix) == "function"
  E.LOG.debug(LOGGER, "has_save_with_prefix_function:" .. tostring(has_save_with_prefix_function))
  return M.has_upgrade_log_file_native() and Cfg.should_send_log_to_cloud_through_file() and Cfg.get_store_type() == Global.StoreTypeEnum.FILE and has_save_with_prefix_function
end

local default_http_header = {rawFile = "true"}
local default_retry_code_list = {
  Global.HTTPStatusCodeEnum.TOO_MANY_REQUEST,
  Global.HTTPStatusCodeEnum.INTERNAL_ERR,
  Global.HTTPStatusCodeEnum.BAD_GATEWAY,
  Global.HTTPStatusCodeEnum.SERVICE_UNAVAILABLE,
  Global.HTTPStatusCodeEnum.GATEWAY_TIMEOUT
}
local MAX_RETRY_BUDGET = 10

local function hit_retry_code_list(code, opts)
  local retry_code_list = default_retry_code_list
  if type(opts.retry_code_list) == "table" and next(opts.retry_code_list) ~= nil then
    retry_code_list = opts.retry_code_list
  end
  for _, retry_code in ipairs(retry_code_list) do
    if type(retry_code) == "number" and code == retry_code then
      return true
    end
  end
  return false
end

local function should_retry(code, opts)
  if not opts then
    return false
  end
  if type(opts.retry_budget) ~= "number" or "number" ~= type(opts.retried_count) then
    return false
  end
  if opts.retry_budget > MAX_RETRY_BUDGET then
    opts.retry_budget = MAX_RETRY_BUDGET
  end
  if opts.retry_budget < 1 then
    return false
  end
  if opts.retried_count > MAX_RETRY_BUDGET then
    return false
  end
  if not hit_retry_code_list(code, opts) then
    return false
  end
  return true, 2 ^ opts.retried_count
end

local function get_resp_msg(resp)
  if nil == resp then
    return ""
  end
  local msg = resp.body or ""
  if "" ~= msg then
    return msg
  end
  msg = resp.headers and resp.headers["err-msg"] or ""
  return msg
end

local function upload_file_to_apus(url, params, file_full_path, opts, cb)
  opts.retried_count = opts.retried_count or 0
  if type(cb) ~= "function" then
    return
  end
  local file_name = FileUtils.get_file_name(file_full_path)
  if not file_name or 0 == string.len(file_name) then
    cb(false, M.ERROR.CODE_ERROR_PARAMS, "file_name should not be nil")
    return
  end
  if type(params.form_header) ~= "table" then
    cb(false, M.ERROR.CODE_ERROR_PARAMS, "miss form_header or form_header is invalid,won't upload file.")
    return
  end
  local formdata = E.HTTP.NativeBuildFormData.New()
  formdata:add_file("file", file_full_path, "application/octet-stream", file_name)
  formdata:add_part("resource", JSONUtils.encode(params.form_header))
  
  local function http_post_cb(resp)
    E.LOG.debug(LOGGER, "upload_file_to_apus resp:")
    E.LOG.debug(LOGGER, resp)
    if resp and resp.status == 200 then
      cb(true, {
        file_path = file_full_path,
        file_name = file_name,
        resp_body = resp.body
      })
      return
    end
    local code = resp and resp.status or -1
    local msg = get_resp_msg(resp)
    local ok, interval = should_retry(code, opts)
    if not ok then
      E.LOG.debug(LOGGER, "upload_file_to_apus fail,stop retry.")
      cb(false, code, tostring(msg))
      return
    end
    local retry_log_msg = string.format("upload_file_to_apus fail,try to retry,remaining retry_budget:%d,retried_count:%d,interval:%d,file:%s", opts.retry_budget, opts.retried_count, interval, file_full_path)
    E.LOG.debug(LOGGER, retry_log_msg)
    
    local function retry_upload_file_to_apus()
      opts.retry_budget = opts.retry_budget - 1
      opts.retried_count = opts.retried_count + 1
      M.upload_file_to_apus(url, params, file_full_path, opts, cb)
    end
    
    E.Timer.once(interval, retry_upload_file_to_apus)
  end
  
  E.HTTP.post(url, {
    safe_formdata = formdata:get_part(),
    headers = params.http_header or default_http_header
  }, formdata:content_type(), formdata:empty_body(), http_post_cb)
end

local function check_upload_file_for_window(params, file_full_path, cb)
  if type(cb) ~= "function" then
    return "", false
  end
  local file_name = FileUtils.get_file_name(file_full_path)
  if not file_name or 0 == string.len(file_name) then
    cb(false, M.ERROR.CODE_ERROR_PARAMS, "file_name should not be nil")
    return "", false
  end
  if type(params.form_header) ~= "table" then
    cb(false, M.ERROR.CODE_ERROR_PARAMS, "miss form_header or form_header is invalid,won't upload file.")
    return "", false
  end
  local ejoysdk_ver = E.get_sdk_version_name("EJOYSDK") or ""
  if "" ~= ejoysdk_ver and VER_CHECK.compare_versions(ejoysdk_ver, "2.2.4") < 0 then
    cb(false, M.ERROR.CODE_NOT_SUPPORT, "expect ejoysdk_ver above v2.2.4 but got" .. tostring(ejoysdk_ver))
    return "", false
  end
  return file_name, true
end

local function upload_file_to_apus_for_windows(url, params, file_full_path, opts, cb)
  opts.retried_count = opts.retried_count or 0
  local file_name, valid = check_upload_file_for_window(params, file_full_path, cb)
  if not valid then
    return
  end
  local formdata = E.HTTP.FormData.New()
  formdata:add_simple_part("resource", JSONUtils.encode(params.form_header))
  local data = E.File.readfile(file_full_path)
  if nil == data or 0 == data or 0 == #data then
    cb(false, M.ERROR.CODE_ERROR_PARAMS, "no file data to send,won't upload file.")
    return
  end
  formdata:add_part("file", data, false, false, file_name)
  
  local function http_post_cb(resp)
    E.LOG.debug(LOGGER, "upload_file_to_apus_for_windows resp:")
    E.LOG.debug(LOGGER, resp)
    if resp and resp.status == 200 then
      cb(true, {
        file_path = file_full_path,
        file_name = file_name,
        resp_body = resp.body
      })
      return
    end
    local code = resp and resp.status or -1
    local msg = get_resp_msg(resp)
    local ok, interval = should_retry(code, opts)
    if not ok then
      E.LOG.debug(LOGGER, "upload_file_to_apus_for_windows fail,stop retry.")
      cb(false, code, tostring(msg))
      return
    end
    local retry_log_msg = string.format("upload_file_to_apus_for_w fail,try to retry,remain retry_budget:%d,retried_count:%d,interval:%d,file:%s", opts.retry_budget, opts.retried_count, interval, file_full_path)
    E.LOG.debug(LOGGER, retry_log_msg)
    
    local function retry_upload_file_to_apus_for_windows()
      opts.retry_budget = opts.retry_budget - 1
      opts.retried_count = opts.retried_count + 1
      M.upload_file_to_apus(url, params, file_full_path, opts, cb)
    end
    
    E.Timer.once(interval, retry_upload_file_to_apus_for_windows)
  end
  
  E.HTTP.post(url, {
    acceptable = E.HTTP.CT_JSON,
    headers = params.http_header or default_http_header
  }, formdata:content_type(), formdata:build(), http_post_cb)
end

function M.is_windows_os()
  return E.Sysinfo.os() == "windows"
end

local is_windows_os = M.is_windows_os()

function M.upload_file_to_apus(url, params, file_full_path, opts, cb)
  local function upload_file_to_apus_fn()
    if is_windows_os then
      do return upload_file_to_apus_for_windows, url, params, file_full_path, opts end
      
      return upload_file_to_apus_for_windows, url, params, file_full_path, opts, cb
    else
      do return upload_file_to_apus, url, params, file_full_path, opts end
      return upload_file_to_apus, url, params, file_full_path, opts, cb
    end
  end
  
  xpcall(upload_file_to_apus_fn, ErrUtils.handle_err)
end

return M

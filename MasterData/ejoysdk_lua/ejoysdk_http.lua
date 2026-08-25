local E = require("ejoysdk_lua.ejoysdk")
local HTTP = require("ejoysdk_lua.libs.http")
local HttpDns = require("ejoysdk_lua.ejoysdk_http_dns")
local CONFIG = require("ejoysdk_lua.ejoysdk_config")
local ETracer = require("ejoysdk_lua.ejoysdk_span_reporter")
local TAG = "ejoy_http"
local M = {}
local CONST_TRACE_ID_KEY = "_http_trace_id"
M.Header = HTTP.Header
M.NativeBuildFormData = HTTP.NativeBuildFormData
M.FormData = HTTP.FormData
local l_opentracing_enable

function M.opentracing_enable()
  if nil == l_opentracing_enable then
    if CONFIG.has_vendor_config("APM") then
      l_opentracing_enable = true
    else
      l_opentracing_enable = false
    end
  end
  return l_opentracing_enable
end

local OPENTRACING = {}
local TracerHttp, TracerTags, TracerContext
local TracerLink = {}

function OPENTRACING.get_tracer()
  if nil == TracerHttp then
    local ETRACER = require("ejoysdk_lua.opentracing.ejoysdk_tracer")
    local TracerBuilder = ETRACER.TracerBuilder
    TracerHttp = TracerBuilder:New(nil, nil, "ejoysdk"):build()
  end
  return TracerHttp
end

function OPENTRACING.get_tags()
  if nil == TracerTags then
    TracerTags = require("ejoysdk_lua.opentracing.ejoysdk_tags")
  end
  return TracerTags
end

function OPENTRACING.get_context()
  return TracerContext
end

function OPENTRACING.set_context(context)
  TracerContext = context
end

local function get_span_dep(span_buz)
  return TracerLink[span_buz]
end

local function set_span_dep(span, span_buz)
  TracerLink[span_buz] = span
end

local function _start_http_span(method, url, params)
  if not M.opentracing_enable() then
    return nil
  end
  local opentracing = params.opentracing
  local net_span
  if opentracing and type(opentracing) == "table" then
    if opentracing.span_buz ~= nil and nil ~= opentracing.reference then
      local parent_span = get_span_dep(opentracing.span_buz)
      if nil ~= parent_span and type(parent_span) == "table" then
        net_span = OPENTRACING.get_tracer():build_span(opentracing.span_buz or method):as_child_of_span(parent_span):start()
      end
    end
    if nil == net_span then
      net_span = OPENTRACING.get_tracer():build_span(opentracing.span_buz or method):start()
    end
    net_span:set_tag(OPENTRACING.get_tags().HTTP_URL, url)
    net_span:set_tag(OPENTRACING.get_tags().HTTP_METHOD, method)
    net_span:set_tag(OPENTRACING.get_tags().SPAN_KIND, OPENTRACING.get_tags().SPAN_KIND_CLIENT)
  end
  return net_span
end

local function inject_tracing_header(span, params)
  if not M.opentracing_enable() then
    return
  end
  if nil ~= span then
    local context = span:context()
    if nil ~= context then
      local trace_id = tostring(context:get_trace_id())
      local context_string = trace_id .. ":" .. tostring(context:get_span_id()) .. ":" .. tostring(context:get_parent_id()) .. ":1"
      if nil ~= params.headers then
        params.headers[OPENTRACING.get_tags().INJECT_HTTP_HEADER] = context_string
      else
        params.headers = {
          [OPENTRACING.get_tags().INJECT_HTTP_HEADER] = context_string
        }
      end
      params.headers[CONST_TRACE_ID_KEY] = trace_id
    end
  end
  params.opentracing = nil
  E.LOG.debug(TAG, "inject_tracing_header return, print params")
  E.LOG.debug(TAG, params)
  return params
end

local function _stop_http_span(opentracing, span, info)
  if not M.opentracing_enable() then
    return
  end
  if nil ~= span then
    span:set_tag(OPENTRACING.get_tags().HTTP_STATUS, tostring(info and info.status) or "-1")
    span:finish_now()
    if opentracing.span_buz then
      if opentracing.reference and opentracing.reference == OPENTRACING.get_tags().FOLLOWS_FROM then
        return
      end
      set_span_dep(span, opentracing.span_buz)
    end
  end
end

local host_map_config

function M.set_http_retry_list(params)
  E.LOG.debug(TAG, "set_http_retry_list >> ")
  E.LOG.debug(TAG, params)
  host_map_config = params
end

local function get_http_retry_url(url, status)
  local os = E.Sysinfo.os()
  if host_map_config[os] and next(host_map_config[os]) then
    for _, host_config in ipairs(host_map_config[os]) do
      local config_status = host_config.status
      local config_host_map = host_config.host_map
      if config_status == status and config_host_map then
        for _, config_host in ipairs(config_host_map) do
          if E.Utils.start_with(url, config_host.original) then
            local original_host = config_host.original
            local retry_url = config_host.new .. string.sub(url, #original_host + 1)
            E.LOG.debug(TAG, "old url is " .. tostring(url) .. ", status is " .. tostring(status) .. ", new url is " .. tostring(retry_url))
            return retry_url
          end
        end
      end
    end
  end
end

local function check_http_func_enable_states(params, opts)
  opts = opts or {}
  local enable_states = {}
  if params.opentracing ~= nil and (nil == opts.enable_opentracing or opts.enable_opentracing == true) then
    enable_states.enable_opentracing = true
  else
    enable_states.enable_opentracing = opts.enable_opentracing
  end
  if params._log_config and nil ~= params._log_config.disable then
    enable_states.disable_http_log = params._log_config.disable
  else
    enable_states.disable_http_log = opts.disable_http_log
  end
  enable_states.disable_http_stat = opts.disable_http_stat
  if nil ~= params.enable_download_range then
    enable_states.enable_download_range = params.enable_download_range
  else
    enable_states.enable_download_range = opts.enable_download_range
  end
  if nil ~= params.httpdns then
    enable_states.enable_http_dns = params.httpdns
  elseif nil ~= CONFIG.get_config("http_dns") then
    enable_states.enable_http_dns = CONFIG.get_config("http_dns")
  else
    enable_states.enable_http_dns = opts.enable_http_dns
  end
  return enable_states
end

local function http_send(http_type, url, params, content_type, _body, cb)
  _ejoysdk.log("http#" .. tostring(http_type) .. ": url = " .. tostring(url))
  params = params or {}
  local _log_config = params._log_config
  params._log_config = nil
  if _log_config and _log_config.disable then
    return false
  end
  local trace_id
  if params.headers and params.headers[CONST_TRACE_ID_KEY] then
    trace_id = params.headers[CONST_TRACE_ID_KEY]
    params.headers[CONST_TRACE_ID_KEY] = nil
  end
  if not trace_id then
    local guuid = require("ejoysdk_lua.ejoysdk_uuid")
    trace_id = guuid.random_i64() .. guuid.random_i64()
  end
  local content_data = {}
  content_data.url = url or ""
  content_data.trace_id = trace_id
  content_data.http_type = http_type or ""
  content_data.content_type = content_type or ""
  content_data.cb = cb or "_nil_cb"
  local ejoy_log = require("ejoysdk_lua.ejoysdk_log_mgr")
  local log_level = ejoy_log.LOG_LEVEL.LOW
  if _log_config and type(_log_config) == "table" then
    log_level = _log_config.log_level or ejoy_log.LOG_LEVEL.LOW
  end
  ejoy_log.http_send({}, TAG, log_level, content_data, {})
  return true, trace_id, log_level
end

local function http_receive(_log_trace_id, _log_level, _url, _info)
end

function M.post(url, params, content_type, body, cb, opts)
  params = params or {}
  local switch_states = check_http_func_enable_states(params, opts)
  local http_post_span
  if params and params.opentracing then
    local opentracing = params.opentracing
    local parent_span_id = opentracing.span_id
    E.LOG.debug(TAG, "opentracing is not nil, and span_id >> " .. tostring(parent_span_id))
    local tags = {}
    tags[OPENTRACING.get_tags().HTTP_URL] = url
    tags[OPENTRACING.get_tags().HTTP_METHOD] = "POST"
    tags[OPENTRACING.get_tags().SPAN_KIND] = OPENTRACING.get_tags().SPAN_KIND_CLIENT
    http_post_span = ETracer.start_span("http_post_span", parent_span_id, tags)
    inject_tracing_header(http_post_span, params)
    E.LOG.debug(TAG, "inject_tracing_header returned, print params")
    E.LOG.debug(TAG, params)
  end
  
  local function cb_wrapper(...)
    if http_post_span then
      local info = (...)
      E.LOG.debug(TAG, "finish http post span")
      local tags = {
        status_code = tostring(info and info.status or "-1")
      }
      ETracer.finish_span(http_post_span:context():get_span_id(), tags)
    end
    if cb then
      cb(...)
    end
  end
  
  local can_log, log_trace_id, log_level
  if not switch_states.disable_http_log then
    can_log, log_trace_id, log_level = http_send("POST", url, params, content_type, body, cb_wrapper)
  end
  
  local function http_retry_callback_wrapper(...)
    local resp = (...)
    local status = tonumber((resp or {}).status)
    if nil == status or status >= 200 and status < 300 or nil == host_map_config then
      do return cb_wrapper, ... end
      return cb_wrapper, ...
    end
    local retry_url = get_http_retry_url(url, status)
    if retry_url then
      M.post(retry_url, params, content_type, body, cb_wrapper)
    else
      cb_wrapper(...)
    end
  end
  
  local cb_inner = http_retry_callback_wrapper
  if not switch_states.disable_http_stat then
    local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
    cb_inner = QL.make_log_http_callback(url, true, params, http_retry_callback_wrapper, E.system_clock(), M.opentracing_enable())
  end
  
  local function cb_inner_log_wrapper(...)
    local info = (...)
    _ejoysdk.log("http#post#resp: url = " .. url .. ", status = " .. (info and info.status or "-1"))
    if can_log then
      http_receive(log_trace_id, log_level, url, info)
    end
    cb_inner(...)
  end
  
  if switch_states.enable_http_dns then
    do return HttpDns.post, url, params, content_type, body end
    return HttpDns.post, url, params, content_type, body, cb_inner_log_wrapper, M.opentracing_enable()
  else
    local HTTP_Adapter = require("ejoysdk_lua.ejoysdk_http_adapter")
    do return HTTP_Adapter.http_post_adapter_security, url, params, content_type, body end
    return HTTP_Adapter.http_post_adapter_security, url, params, content_type, body, cb_inner_log_wrapper
  end
end

function M.get(url, params, cb, opts)
  params = params or {}
  local switch_states = check_http_func_enable_states(params, opts)
  local http_get_span
  if params and params.opentracing then
    local opentracing = params.opentracing
    local parent_span_id = opentracing.span_id
    E.LOG.debug(TAG, "opentracing is not nil, and span_id >> " .. tostring(parent_span_id))
    local tags = {}
    tags[OPENTRACING.get_tags().HTTP_URL] = url
    tags[OPENTRACING.get_tags().HTTP_METHOD] = "POST"
    tags[OPENTRACING.get_tags().SPAN_KIND] = OPENTRACING.get_tags().SPAN_KIND_CLIENT
    http_get_span = ETracer.start_span("http_get_span", parent_span_id, tags)
    inject_tracing_header(http_get_span, params)
  end
  
  local function cb_wrapper(...)
    if http_get_span then
      local info = (...)
      E.LOG.debug(TAG, "finish http get span")
      local tags = {
        status_code = tostring(info and info.status or "-1")
      }
      ETracer.finish_span(http_get_span:context():get_span_id(), tags)
    end
    if cb then
      cb(...)
    end
  end
  
  local can_log, log_trace_id, log_level
  if not switch_states.disable_http_log then
    can_log, log_trace_id, log_level = http_send("GET", url, params, nil, nil, cb_wrapper)
  end
  if switch_states.enable_download_range and params.file then
    local range_fun_name
    local _os = _ejoysdk.os()
    if "android" == _os then
      range_fun_name = E.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE
    elseif "ios" == _os then
      range_fun_name = E.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE
    else
      range_fun_name = E.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE_V1
    end
    if E.is_support_function(range_fun_name) then
      local util = require("ejoysdk_lua.res.ejoy_http_res_utils")
      local is_exist, size = util.is_file_exists(params.file)
      _ejoysdk.log("is_file_exists is_exist:" .. tostring(is_exist) .. ", size:" .. tostring(size))
      size = tonumber(size) or 0
      if is_exist and size > 0 then
        params.headers = params.headers or {}
        params.headers.Range = "bytes=" .. tostring(size) .. "-"
        E.LOG.debug("process_get", " range download continue, start with size:" .. tostring(size))
      else
        E.LOG.debug("process_get", " start download new file")
      end
    end
  end
  
  local function http_retry_callback_wrapper(...)
    local resp = (...)
    local status = tonumber((resp or {}).status)
    if nil == status or status >= 200 and status < 300 or nil == host_map_config then
      do return cb_wrapper, ... end
      return cb_wrapper, ...
    end
    local retry_url = get_http_retry_url(url, status)
    if retry_url then
      M.get(retry_url, params, cb_wrapper)
    else
      cb_wrapper(...)
    end
  end
  
  local cb_inner = http_retry_callback_wrapper
  if not switch_states.disable_http_stat then
    local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
    cb_inner = QL.make_log_http_callback(url, false, params, http_retry_callback_wrapper, E.system_clock(), M.opentracing_enable())
  end
  
  local function cb_inner_log_wrapper(...)
    local info = (...)
    _ejoysdk.log("[ejoysdk]http#get#resp: url = " .. url .. ", status = " .. (info and info.status or "-1"))
    if can_log then
      http_receive(log_trace_id, log_level, url, info)
    end
    cb_inner(...)
  end
  
  if switch_states.enable_http_dns then
    do return HttpDns.get, url, params end
    return HttpDns.get, url, params, cb_inner_log_wrapper, http_retry_callback_wrapper, E.system_clock(), M.opentracing_enable()
  else
    local HTTP_Adapter = require("ejoysdk_lua.ejoysdk_http_adapter")
    do return HTTP_Adapter.http_get_adapter_security, url, params end
    return HTTP_Adapter.http_get_adapter_security, url, params, cb_inner_log_wrapper, E.system_clock(), M.opentracing_enable()
  end
end

function M.stop(_task_id_arr, params, cb)
  HTTP.stop(_task_id_arr, params, cb)
end

local function guess_network_type_name()
  local network_type = E.Sysinfo.network_type_cache()
  local network_type_name = "unknown"
  if 1 == network_type then
    network_type_name = "wifi"
  elseif 2 == network_type then
    network_type_name = "4g"
  end
  return network_type_name
end

function M.check_and_update_headers(headers)
  local ret = HTTP.Header.New(headers)
  ret["User-Agent"] = ret["User-Agent"] or E.PLATFORM.HTTP_UA
  ret["Accept-Charset"] = ret["Accept-Charset"] or "UTF-8"
  ret["Net-Type"] = guess_network_type_name()
  ret["trace-id"] = E.get_pkg_info().utdid .. "-" .. tostring(os.time())
  return ret
end

function M.body_tostring(body, content_type)
  do return HTTP.body_tostring, body end
  return HTTP.body_tostring, body, content_type
end

return M

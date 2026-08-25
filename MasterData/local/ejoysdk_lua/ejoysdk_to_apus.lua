local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local TAG = "EAPUS"
local APUSEVENT, APUS_CONFIGURATOR, APUS_FAST_EVENT, _EXISTS_APUS_LUA

local function report_apus_event(event_name, _lablels, _trace_id, _msg, _stats)
  if nil ~= APUSEVENT then
    local labels = _lablels or {}
    local trace_id = _trace_id or 0
    local stats = _stats or {}
    local msg = _msg or ""
    APUSEVENT.post(event_name, labels, trace_id, msg, stats)
  end
end

local function add_public_params(params)
  params.ab_type = E.get_pkg_info().ab_type or ""
  params.net_type_name = E.Sysinfo.network_type_name() or ""
end

function M.is_apus_enabled()
  if false == _EXISTS_APUS_LUA then
    return false
  end
  if nil == _EXISTS_APUS_LUA then
    local ok, apus_event_module = pcall(require, "ejoysdk_lua.apm-sdk-lua.event.event")
    if ok then
      APUSEVENT = apus_event_module
      _EXISTS_APUS_LUA = true
    else
      _EXISTS_APUS_LUA = false
    end
  end
  return APUSEVENT and E.has_apus_vendor()
end

local function post_with_low_priority(event_name, params)
  local apus_stats = {}
  if params._sdk_apus_stats then
    apus_stats = params._sdk_apus_stats
    params._sdk_apus_stats = nil
  end
  local _trace_id = E.get_pkg_info().sdk_trace_id
  report_apus_event(event_name, params, _trace_id, tostring(params.msg or params.code or params.result or "empty_msg"), apus_stats)
end

local function post_event(event_name, params, is_upload_now)
  if not APUS_CONFIGURATOR then
    local ok, apus_configurator = pcall(require, "ejoysdk_lua.apm-sdk-lua.config.configurator")
    if ok then
      APUS_CONFIGURATOR = apus_configurator
    else
      E.LOG.warn(TAG, "post_event fail, require ejoysdk_lua.apm-sdk-lua.config.configurator fail")
      return false
    end
  end
  if not APUS_FAST_EVENT then
    local ok, apus_fast_event = pcall(require, "ejoysdk_lua.apm-sdk-lua.fast-event.event")
    local ingester_url = APUS_CONFIGURATOR.get_ingester_server()
    E.LOG.debug(TAG, "ingester_url: " .. tostring(ingester_url))
    if ok then
      local env = E.CONFIG.get_config("product")
      local utdid = E.Sysinfo.utdid() or ""
      local os = E.Sysinfo.os() or ""
      local labels = {
        env = env,
        utdid = utdid,
        os = os
      }
      APUS_FAST_EVENT = apus_fast_event.new_eventer(ingester_url, labels)
    else
      E.LOG.warn(TAG, "post_event fail, require ejoysdk_lua.apm-sdk-lua.fast-event.event fail")
      return false
    end
  end
  if not APUS_FAST_EVENT then
    return false
  end
  if is_upload_now then
    APUS_FAST_EVENT:post_with_high_priority(event_name, params, "", {})
  else
    APUS_FAST_EVENT:post(event_name, params, "", {})
  end
  return true
end

function M.commit_event(event_name, params, options)
  if not M.is_apus_enabled() then
    E.LOG.warn(TAG, "commit_event skip, apus not enabled")
    return
  end
  params = params or {}
  add_public_params(params)
  options = options or {}
  E.LOG.debug(TAG, "commit_event:" .. tostring(event_name))
  local post_result = false
  if options.is_upload_now then
    post_result = post_event(event_name, params, true)
  elseif options.is_priority_high then
    post_result = post_event(event_name, params, false)
  end
  if not post_result then
    post_with_low_priority(event_name, params)
  end
end

function M.add_dynamic_label(label, fun)
  if not label or "" == label then
    E.LOG.warn(TAG, "add_dynamic_label skip, label is nil or empty")
    return
  end
  local ok, apus = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
  if not ok then
    E.LOG.warn(TAG, "add_dynamic_label skip for apus not exists, label:" .. tostring(label))
    return
  end
  E.LOG.debug(TAG, "add_dynamic_label begin, label:" .. tostring(label))
  apus.add_dynamic_label(label, fun)
end

return M

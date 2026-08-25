local E = require("ejoysdk_lua.ejoysdk")
local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local Common = require("ejoysdk_lua.apm-sdk-lua.stats.common")
local Metrics = require("ejoysdk_lua.apm-sdk-lua.common.metrics")
local ApmStats = require("ejoysdk_lua.apm-sdk-lua.stats.apm_stats")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local LOGGER = "apm_api_stats"
local HTTP_METHOD_GET = 1
local HTTP_METHOD_POST = 2
local HTTP_METHOD_PATCH = 3
local HTTP_METHOD_DELETE = 4
local HTTP_METHOD_PUT = 5
local M = {}
local stats_name = "api_stats"
local api_stats

local function get_api_stats()
  do return Common.get_stats end
  return Common.get_stats, M.agg_group
end

function M.init()
  api_stats = Stats.new(stats_name, Global.namespace_api_stats)
  M.agg_group = Metrics.new_aggregate_group("api_agg_group")
  M.invalid_report_counter = ApmStats:new_counter("invalid_report_api_count", true)
  api_stats:set_calc_func(get_api_stats)
end

local function is_request_method_valid(request_method)
  if type(request_method) ~= "number" then
    return false
  end
  if request_method == HTTP_METHOD_GET or request_method == HTTP_METHOD_POST or request_method == HTTP_METHOD_PUT or request_method == HTTP_METHOD_DELETE or request_method == HTTP_METHOD_PATCH then
    return true
  end
  return false
end

local function check_param(server, api, response_code, cost, request_method)
  if nil == server or "" == server then
    return "invalid server"
  end
  if nil == api or "" == api then
    return "invalid api"
  end
  if nil == response_code or "" == response_code then
    return "invalid response_code"
  end
  if type(cost) ~= "number" or cost < 0 then
    return "invalid cost"
  end
  if not is_request_method_valid(request_method) then
    return "invalid request_method"
  end
  return nil
end

function M.count_platform_api_call(server, api, response_code, cost_ms, request_method, caller_module)
  if api_stats and not api_stats.enabled then
    return
  end
  if M.agg_group == nil then
    return
  end
  if not Global.is_apus_sdk_initialized() then
    return
  end
  local err = check_param(server, api, response_code, cost_ms, request_method)
  if nil ~= err then
    E.LOG.debug(LOGGER, "illegal report_api_call param,err:" .. err)
    M.invalid_report_counter:inc()
    return
  end
  api, err = Common.apply_pattern(api)
  if nil ~= err then
    E.LOG.debug(LOGGER, "illegal report_api_call param,api:" .. err)
    M.invalid_report_counter:inc()
    return
  end
  M.agg_group:update(cost_ms, {
    srv = server,
    api = api,
    rc = response_code,
    rm = request_method,
    cm = caller_module
  })
end

return M

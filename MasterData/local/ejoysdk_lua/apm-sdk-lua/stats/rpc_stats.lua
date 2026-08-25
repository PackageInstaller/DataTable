local E = require("ejoysdk_lua.ejoysdk")
local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local Common = require("ejoysdk_lua.apm-sdk-lua.stats.common")
local Metrics = require("ejoysdk_lua.apm-sdk-lua.common.metrics")
local ApmStats = require("ejoysdk_lua.apm-sdk-lua.stats.apm_stats")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local LOGGER = "apm_rpc_stats"
local stats_name = "rpc_stats"
local M = {}
local rpc_stats

local function get_rpc_stats()
  do return Common.get_stats end
  return Common.get_stats, M.agg_group
end

function M.init()
  rpc_stats = Stats.new(stats_name, Global.namespace_rpc_stats)
  M.agg_group = Metrics.new_aggregate_group("rpc_agg_group")
  M.invalid_report_counter = ApmStats:new_counter("invalid_report_rpc_count", true)
  rpc_stats:set_calc_func(get_rpc_stats)
end

local function check_param(service, succ, response_code, cost_ms)
  if nil == service or "" == service then
    return "invalid service"
  end
  if type(succ) ~= "boolean" then
    return "invalid succ"
  end
  if type(response_code) ~= "number" and type(response_code) ~= "string" or "" == response_code then
    return "invalid response_code"
  end
  if type(cost_ms) ~= "number" or cost_ms < 0 then
    return "invalid cost_ms"
  end
  return nil
end

M.RESPONSE_CODE_SUCC_FOR_RPC_CALL = 0

function M.count_game_rpc_call(service, succ, response_code, cost_ms, caller_module)
  if rpc_stats and not rpc_stats.enabled then
    return
  end
  if M.agg_group == nil then
    return
  end
  if not Global.is_apus_sdk_initialized() then
    return
  end
  local err = check_param(service, succ, response_code, cost_ms)
  if nil ~= err then
    E.LOG.debug(LOGGER, "illegal count_game_rpc_call param,err:" .. err)
    M.invalid_report_counter:inc()
    return
  end
  service, err = Common.apply_pattern(service)
  if nil ~= err then
    E.LOG.debug(LOGGER, "illegal count_game_rpc_call param.service,err:" .. err)
    M.invalid_report_counter:inc()
    return
  end
  M.agg_group:update(cost_ms, {
    svc = service,
    succ = succ and 1 or 0,
    rc = tostring(response_code),
    cm = caller_module
  })
end

return M

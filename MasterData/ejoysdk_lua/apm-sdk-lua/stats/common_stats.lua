local E = require("ejoysdk_lua.ejoysdk")
local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local Metrics = require("ejoysdk_lua.apm-sdk-lua.common.metrics")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local JSON = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local LOGGER = "apm_common_stats"
local M = {
  aggr_groups = {}
}
local stats_name = "common_stats"
local common_stats

local function get_common_stats()
  if not next(M.aggr_groups) then
    E.LOG.debug(LOGGER, "common_stats.aggr_groups is empty , ignore report")
    return
  end
  local stats = {}
  for kk, aggr_group in pairs(M.aggr_groups) do
    E.LOG.debug(LOGGER, "calculating common stats for " .. kk)
    local vector = aggr_group:get_all()
    for k, v in pairs(vector) do
      if #k > 1 and v.count > 0 then
        stats[k] = {
          min = v:get_min(),
          avg = v:get_avg(),
          max = v:get_max(),
          cnt = v:get_count()
        }
      end
    end
    aggr_group:clear()
  end
  if not next(stats) then
    E.LOG.debug(LOGGER, "common stats is empty , ignore report")
    return
  end
  local output = JSON.encode(stats)
  E.LOG.debug(LOGGER, "common_stats:" .. output)
  local result = {metric_group = output}
  return result
end

function M.init()
  common_stats = Stats.new(stats_name, Global.namespace_common_stats)
  common_stats:set_calc_func(get_common_stats)
end

local function get_aggr_group(metric_type)
  local ag = M.aggr_groups[metric_type]
  if nil ~= ag then
    return ag
  end
  ag = Metrics.new_aggregate_group("common_agg_group_" .. metric_type)
  M.aggr_groups[metric_type] = ag
  return ag
end

function M.count_common_stats(metric_type, metric_value, extra_labels)
  if common_stats and not common_stats.enabled then
    E.LOG.warn(LOGGER, "common_stats disabled, skip count_common_stats")
    return
  end
  if not Global.is_apus_sdk_initialized() then
    E.LOG.warn(LOGGER, "is_apus_sdk_initialized:false,skip count_ui_render")
    return
  end
  assert(type(metric_type) == "string" and "" ~= metric_type, "params#1 metric_type expect a non-nil string")
  assert(type(metric_value) == "number", "params#2 metric_value expect a number")
  local aggr_group = get_aggr_group(metric_type)
  if nil == aggr_group then
    E.LOG.warn(LOGGER, "aggr_group is nil,skip count_common_stats")
    return
  end
  local labels = {metric_type = metric_type}
  if type(extra_labels) == "table" and next(extra_labels) then
    labels = Utils.merge_table(labels, extra_labels, false)
  end
  aggr_group:update(metric_value, labels)
end

return M

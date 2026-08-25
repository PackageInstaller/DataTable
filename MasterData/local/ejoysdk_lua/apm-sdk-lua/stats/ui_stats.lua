local E = require("ejoysdk_lua.ejoysdk")
local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local Metrics = require("ejoysdk_lua.apm-sdk-lua.common.metrics")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local JSON = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local LOGGER = "apm_ui_stats"
local M = {
  aggr_groups = {}
}
local stats_name = "ui_stats"
local ui_stats

local function get_ui_stats()
  if not next(M.aggr_groups) then
    E.LOG.debug(LOGGER, "ui_stats.aggr_groups is empty , ignore report")
    return
  end
  local stats = {}
  for kk, aggr_group in pairs(M.aggr_groups) do
    E.LOG.debug(LOGGER, "calculating ui stats for " .. kk)
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
    E.LOG.debug(LOGGER, "ui stats is empty , ignore report")
    return
  end
  local output = JSON.encode(stats)
  E.LOG.debug(LOGGER, "ui_stats:" .. output)
  local result = {metric_group = output}
  return result
end

function M.init()
  ui_stats = Stats.new(stats_name, Global.namespace_ui_stats)
  ui_stats:set_calc_func(get_ui_stats)
end

local function get_aggr_group(metric_type)
  local ag = M.aggr_groups[metric_type]
  if nil ~= ag then
    return ag
  end
  ag = Metrics.new_aggregate_group("ui_agg_group_" .. metric_type)
  M.aggr_groups[metric_type] = ag
  return ag
end

function M.count_ui_render(ui, metric_type, metric_value, extra_labels)
  if ui_stats and not ui_stats.enabled then
    E.LOG.warn(LOGGER, "ui_stats disabled, skip count_ui_render")
    return
  end
  if not Global.is_apus_sdk_initialized() then
    E.LOG.warn(LOGGER, "is_apus_sdk_initialized:false,skip count_ui_render")
    return
  end
  assert(type(ui) == "string" and "" ~= ui, "params#1 ui expect a non-nil string")
  assert(type(metric_type) == "string" and "" ~= metric_type, "params#2 metric_type expect a non-nil string")
  assert(type(metric_value) == "number", "params#3 metric_value expect a number")
  local aggr_group = get_aggr_group(metric_type)
  if nil == aggr_group then
    E.LOG.warn(LOGGER, "aggr_group is nil,skip count_ui_render")
    return
  end
  local labels = {ui = ui, metric_type = metric_type}
  if type(extra_labels) == "table" and next(extra_labels) then
    labels = Utils.merge_table(labels, extra_labels, false)
  end
  aggr_group:update(metric_value, labels)
end

return M

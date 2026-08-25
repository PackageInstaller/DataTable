local E = require("ejoysdk_lua.ejoysdk")
local APM_Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local StringUtils = require("ejoysdk_lua.apm-sdk-lua.common.string_utils")
local LOGGER = "apm_metrics"
local M = {}
M.MAX_NIL_COUNT_BEFORE_CLEAR = 5
M.DEFAULT_MAX_SERIES_LIMIT = 100
local metrics_full_list = {}

local function sortedKeys(t)
  local tmp_table = {}
  for key, _ in pairs(t) do
    table.insert(tmp_table, key)
  end
  table.sort(tmp_table)
  return tmp_table
end

local function hash_labels(labels)
  if nil == labels then
    return nil
  end
  local sb = StringUtils.new_string_buffer()
  local label_size = Utils.table_size(labels)
  for i, k in ipairs(sortedKeys(labels)) do
    local v = tostring(labels[k])
    k = string.gsub(k, APM_Global.labels_kv_concate_str, "____")
    v = string.gsub(v, APM_Global.labels_kvpair_concate_str, "_")
    sb:append(k)
    sb:append(APM_Global.labels_kv_concate_str)
    sb:append(v)
    if label_size > i then
      sb:append(APM_Global.labels_kvpair_concate_str)
    end
  end
  do return sb.to_string end
  return sb.to_string, sb, ipairs(sortedKeys(labels))
end

M.__hash_lables = hash_labels
local Metric = {
  __name = "Metric",
  name = "",
  type = APM_Global.MetricTypeEnum.NoneType,
  nil_count = 0
}
Metric.__index = Metric

function Metric.new(metric_name, metric_type, clearable, verbose)
  if nil ~= metrics_full_list[metric_name] then
    E.LOG.error(LOGGER, "metric already exists: " .. metric_name)
    return nil
  end
  local max_series_limit = Cfg.get(Cfg.CATEGORY_STATS, "max_series_num", M.DEFAULT_MAX_SERIES_LIMIT)
  if max_series_limit <= M.get_series_count() then
    if M.exceed_max_series_counter then
      M.exceed_max_series_counter:inc()
    end
    return nil
  end
  local obj = {
    name = metric_name,
    type = metric_type,
    clearable = clearable,
    verbose = verbose,
    nil_count = 0
  }
  metrics_full_list[metric_name] = 0
  do return setmetatable, obj end
  return setmetatable, obj, Metric
end

function Metric:delete()
  metrics_full_list[self.name] = nil
end

function Metric:get_name()
  return self.name
end

function Metric:is_group()
  return false
end

function Metric:should_purge()
  return 0 == self.count and self.clearable and self.nil_count >= M.MAX_NIL_COUNT_BEFORE_CLEAR
end

function Metric:should_collect()
  if not self.verbose then
    return true
  end
  do return end
  return Cfg.get_stats_verbose
end

local MetricGroup = {
  __name = "MetricGroup",
  name = "",
  type = APM_Global.MetricTypeEnum.NoneType,
  count = 0,
  vector = {}
}
MetricGroup.__index = MetricGroup

function MetricGroup.new(metric_name, type)
  local obj = {
    name = metric_name,
    type = type,
    count = 0,
    vector = {}
  }
  do return setmetatable, obj end
  return setmetatable, obj, MetricGroup
end

function MetricGroup:get_or_create_metric(labels)
  if nil == labels then
    E.LOG.error(LOGGER, "get_or_create_metric| recv nil labels")
    return nil
  end
  local hash = hash_labels(labels)
  local metric = self.vector[hash]
  if nil == metric then
    metric = M.create_metric(hash, self.type, true)
    if metric then
      self.vector[hash] = metric
    end
  end
  return metric
end

function M.register_exceed_max_series_counter(exceed_max_series_counter)
  M.exceed_max_series_counter = exceed_max_series_counter
end

function MetricGroup:get(labels)
  if nil == labels then
    E.LOG.error(LOGGER, "get| recv nil labels")
    return nil
  end
  local hash = hash_labels(labels)
  local metric = self.vector[hash]
  if nil ~= metric then
    do return metric.get end
    return metric.get, metric
  end
  return nil
end

function MetricGroup:get_all()
  return self.vector
end

function MetricGroup:delete(labels)
  if nil == labels then
    E.LOG.error(LOGGER, "delete| recv nil labels")
    return
  end
  local hash = hash_labels(labels)
  local metric = self.vector[hash]
  if nil ~= metric then
    self.vector[hash] = nil
    metric:delete()
  end
end

function MetricGroup:is_group()
  return true
end

function MetricGroup:get_group()
  local result = {}
  for _, v in pairs(self.vector) do
    result[v.name] = v:get()
  end
  return result
end

local Counter = {
  __name = "Counter",
  type = APM_Global.MetricTypeEnum.CounterType,
  count = 0
}
setmetatable(Counter, Metric)
Counter.__index = Counter

function Counter.new(metric_name, clearable, verbose)
  local obj = Metric.new(metric_name, APM_Global.MetricTypeEnum.CounterType, clearable, verbose)
  if nil ~= obj then
    do return setmetatable, obj end
    return setmetatable, obj, Counter, verbose
  end
  return nil
end

function Counter:inc(num)
  num = num or 1
  self.count = self.count + num
  return self.count
end

function Counter:get()
  if 0 == self.count and self.clearable and self.nil_count >= M.MAX_NIL_COUNT_BEFORE_CLEAR then
    return nil
  end
  if not self:should_collect() then
    return nil
  end
  return self.count
end

function Counter:clear()
  if self.clearable then
    if 0 == self.count then
      self.nil_count = self.nil_count + 1
      return
    else
      self.nil_count = 0
    end
  end
  self.count = 0
end

local CounterGroup = {
  __name = "CounterGroup",
  type = APM_Global.MetricTypeEnum.CounterType
}
setmetatable(CounterGroup, MetricGroup)
CounterGroup.__index = CounterGroup

function CounterGroup.new(metric_name)
  local obj = MetricGroup.new(metric_name, APM_Global.MetricTypeEnum.CounterType)
  do return setmetatable, obj end
  return setmetatable, obj, CounterGroup
end

function CounterGroup:inc(num, labels)
  local counter = self:get_or_create_metric(labels)
  do return counter.inc, counter end
  return counter.inc, counter, num
end

function CounterGroup:clear()
  for k, v in pairs(self.vector) do
    v:clear()
    if v:should_purge() then
      self.vector[k] = nil
      v:delete()
    end
  end
end

local Gauge = {
  __name = "Gauge",
  type = APM_Global.MetricTypeEnum.GaugeType,
  value = 0
}
setmetatable(Gauge, Metric)
Gauge.__index = Gauge

function Gauge.new(metric_name, verbose)
  local obj = Metric.new(metric_name, APM_Global.MetricTypeEnum.GaugeType, false, verbose)
  if nil ~= obj then
    do return setmetatable, obj end
    return setmetatable, obj, Gauge, verbose
  end
  return nil
end

function Gauge:set_calc_func(func, ...)
  self.calc_func = func
  self.calc_args = {
    ...
  }
end

function Gauge:set(value)
  local v = self.value
  self.value = value or 0
  return v
end

function Gauge:get()
  if not self:should_collect() then
    return nil
  end
  if self.calc_func == nil then
    return self.value
  end
  local v = Utils.exec(self.calc_func, self.calc_args)
  if type(v) == "number" then
    return v
  end
end

local GaugeGroup = {
  __name = "GaugeGroup",
  type = APM_Global.MetricTypeEnum.GaugeType
}
setmetatable(GaugeGroup, MetricGroup)
GaugeGroup.__index = GaugeGroup

function GaugeGroup.new(metric_name)
  local obj = MetricGroup.new(metric_name, APM_Global.MetricTypeEnum.GaugeType)
  do return setmetatable, obj end
  return setmetatable, obj, GaugeGroup
end

function GaugeGroup:set(value, labels)
  local gauge = self:get_or_create_metric(labels)
  do return gauge.set, gauge end
  return gauge.set, gauge, value
end

local Aggregate = {
  __name = "Aggregate",
  type = APM_Global.MetricTypeEnum.AggregateType,
  count = 0,
  sum = 0,
  min = 0,
  max = 0
}
setmetatable(Aggregate, Metric)
Aggregate.__index = Aggregate

function Aggregate.new(metric_name, clearable, verbose)
  local obj = Metric.new(metric_name, APM_Global.MetricTypeEnum.AggregateType, clearable, verbose)
  if nil ~= obj then
    do return setmetatable, obj end
    return setmetatable, obj, Aggregate, verbose
  end
  return nil
end

function Aggregate:update(value)
  if not self:should_collect() then
    return nil
  end
  if self.count > 0 then
    self.count = self.count + 1
    self.sum = self.sum + value
    if value < self.min then
      self.min = value
    end
    if value > self.max then
      self.max = value
    end
  else
    self.count = 1
    self.sum = value
    self.min = value
    self.max = value
  end
end

function Aggregate:get_min()
  if not self:should_collect() then
    return nil
  end
  return self.min
end

function Aggregate:get_max()
  if not self:should_collect() then
    return nil
  end
  return self.max
end

function Aggregate:get_avg()
  if not self:should_collect() then
    return nil
  end
  if 0 == self.count then
    return 0
  end
  return self.sum / self.count
end

function Aggregate:get_count()
  if not self:should_collect() then
    return nil
  end
  if self.count > 0 then
    self.nil_count = 0
  end
  return self.count
end

function Aggregate:get()
  if not self:should_collect() then
    return nil
  end
  if self.count > 0 then
    self.nil_count = 0
    return {
      count = self.count,
      sum = self.sum,
      min = self.min,
      max = self.max
    }
  else
    return {count = 0, sum = 0}
  end
end

function Aggregate:clear()
  if 0 == self.count then
    self.nil_count = self.nil_count + 1
  end
  self.count = 0
  self.sum = 0
  self.min = 0
  self.max = 0
end

local AggregateGroup = {
  __name = "AggregateGroup",
  type = APM_Global.MetricTypeEnum.AggregateType
}
setmetatable(AggregateGroup, MetricGroup)
AggregateGroup.__index = AggregateGroup

function AggregateGroup.new(metric_name)
  local obj = MetricGroup.new(metric_name, APM_Global.MetricTypeEnum.AggregateType)
  do return setmetatable, obj end
  return setmetatable, obj, AggregateGroup
end

local has_print_aggr_update_err = false

function AggregateGroup:update(value, labels)
  local aggr = self:get_or_create_metric(labels)
  if nil == aggr then
    if not has_print_aggr_update_err then
      E.LOG.warn(LOGGER, "get_or_create_metric return a nil aggr,update opr is ignored,value:" .. value)
      E.LOG.warn(LOGGER, labels)
      has_print_aggr_update_err = true
    end
    return
  end
  do return aggr.update, aggr end
  return aggr.update, aggr, value, value
end

function AggregateGroup:clear()
  for k, v in pairs(self.vector) do
    v:clear()
    if v:should_purge() then
      self.vector[k] = nil
      v:delete()
    end
  end
end

local MetricType = {
  [APM_Global.MetricTypeEnum.NoneType] = nil,
  [APM_Global.MetricTypeEnum.CounterType] = Counter,
  [APM_Global.MetricTypeEnum.GaugeType] = Gauge,
  [APM_Global.MetricTypeEnum.AggregateType] = Aggregate
}

function M.create_metric(metric_name, metric_type, clearable)
  do return MetricType[metric_type].new, metric_name end
  return MetricType[metric_type].new, metric_name, clearable
end

function M.new_counter(metric_name, clearable, verbose)
  do return Counter.new, metric_name, clearable end
  return Counter.new, metric_name, clearable, verbose
end

function M.new_counter_group(metric_name)
  do return CounterGroup.new end
  return CounterGroup.new, metric_name
end

function M.new_gauge(metric_name, verbose)
  do return Gauge.new, metric_name end
  return Gauge.new, metric_name, verbose
end

function M.new_gauge_with_func(metric_name, verbose, func, ...)
  local gauge = Gauge.new(metric_name, verbose)
  gauge:set_calc_func(func, ...)
  return gauge
end

function M.new_gauge_group(metric_name)
  do return GaugeGroup.new end
  return GaugeGroup.new, metric_name
end

function M.new_aggregate(metric_name, verbose)
  do return Aggregate.new, metric_name end
  return Aggregate.new, metric_name, verbose
end

function M.new_aggregate_group(metric_name)
  do return AggregateGroup.new end
  return AggregateGroup.new, metric_name
end

function M.get_series_count()
  do return Utils.table_size end
  return Utils.table_size, metrics_full_list
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local apm_stats = require("ejoysdk_lua.apm-sdk-lua.stats.apm_stats")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local CFG_BUFF_SIZE = "buff_size"
local STATS_TYPE = Global.DataTypeEnum.STATS_TYPE
local EVENT_TYPE = Global.DataTypeEnum.EVENT_TYPE
local LOG_TYPE = Global.DataTypeEnum.LOG_TYPE
local TRACE_TYPE = Global.DataTypeEnum.TRACE_TYPE
local MAX_DATA_TYPE = Utils.table_size(Global.DataTypeEnum)
local LOGGER = "apm_store_mem"
local report_by_bufsize
local Store = {
  __name = "Store",
  queue = nil,
  max_queue_size = 0,
  date_type = 0,
  buff_size = 0,
  queue_exceeded_counter = nil,
  collect_counter = nil
}
Store.__index = Store
local store_full_list = {}

function Store.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  if nil ~= store_full_list[data_type] then
    E.LOG.error(LOGGER, "data_type already exists: " .. data_type)
    return nil
  end
  local obj = {
    queue = queue,
    data_type = data_type,
    max_queue_size = max_queue_size,
    buff_size = buff_size,
    queue_exceeded_counter = queue_exceeded_counter,
    collect_counter = collect_counter
  }
  local result = setmetatable(obj, Store)
  store_full_list[data_type] = result
  return result
end

local function should_report_by_bufsize(dtype)
  return dtype ~= STATS_TYPE
end

function Store:retrieve_data()
  if not next(self.queue) then
    return nil
  end
  local data = self.queue
  self.queue = {}
  return data
end

function Store:update_buff_size(buff_size)
  self.buff_size = buff_size
end

function Store:submit(data)
  local queue = self.queue
  if nil == queue then
    return
  end
  local dtype = self.data_type
  table.insert(queue, data)
  local queue_size = #queue
  if should_report_by_bufsize(dtype) then
    if queue_size >= self.buff_size then
      E.LOG.debug(LOGGER, "shoule_report_by_bufsize ...")
      assert(report_by_bufsize, "report_by_bufsize_fn is unset")
      report_by_bufsize(dtype)
    end
    return
  end
  if queue_size > self.max_queue_size then
    table.remove(queue, 1)
    if self.queue_exceeded_counter then
      self.queue_exceeded_counter:inc()
    end
  end
end

local StatsStore = {__name = "StatsStore"}
setmetatable(StatsStore, Store)
StatsStore.__index = StatsStore

function StatsStore.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  local obj = Store.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, StatsStore, buff_size, queue_exceeded_counter, collect_counter
end

local EventStore = {__name = "EventStore"}
setmetatable(EventStore, Store)
EventStore.__index = EventStore

function EventStore.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  local obj = Store.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, EventStore, buff_size, queue_exceeded_counter, collect_counter
end

local LogStore = {__name = "LogStore"}
setmetatable(LogStore, Store)
LogStore.__index = LogStore

function LogStore.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  local obj = Store.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, LogStore, buff_size, queue_exceeded_counter, collect_counter
end

local TraceStore = {__name = "TraceStore"}
setmetatable(TraceStore, Store)
TraceStore.__index = TraceStore

function TraceStore.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  local obj = Store.new(data_type, queue, max_queue_size, buff_size, queue_exceeded_counter, collect_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, TraceStore, buff_size, queue_exceeded_counter, collect_counter
end

local DEFAULT_MAX_QUEUE_SIZE = 100
local DEFAULT_BUFF_SIZE = 200
local M = {
  stats_store = StatsStore.new(STATS_TYPE, {}, DEFAULT_MAX_QUEUE_SIZE, DEFAULT_BUFF_SIZE, apm_stats:new_counter("dropped_stats", true), apm_stats:new_counter("count_stats", true)),
  event_store = EventStore.new(EVENT_TYPE, {}, DEFAULT_MAX_QUEUE_SIZE, DEFAULT_BUFF_SIZE, nil, apm_stats:new_counter("count_event", true)),
  log_store = LogStore.new(LOG_TYPE, {}, DEFAULT_MAX_QUEUE_SIZE, DEFAULT_BUFF_SIZE, apm_stats:new_counter("dropped_log", true), apm_stats:new_counter("count_log", true)),
  trace_store = TraceStore.new(TRACE_TYPE, {}, DEFAULT_MAX_QUEUE_SIZE, DEFAULT_BUFF_SIZE, apm_stats:new_counter("dropped_trace", true), apm_stats:new_counter("count_trace", true))
}
M.DEFAULT_BUFF_SIZE = DEFAULT_BUFF_SIZE
M.DEFAULT_MAX_QUEUE_SIZE = DEFAULT_MAX_QUEUE_SIZE
M.__index = M

local function is_valid_bufsize(bufsize)
  if #bufsize ~= MAX_DATA_TYPE then
    return false
  end
  for _, v in ipairs(bufsize) do
    if type(v) ~= "number" or v <= 0 then
      return false
    end
  end
  return true
end

function M.init()
  local buff_size = Cfg.get(Cfg.CATEGORY_REPORT, CFG_BUFF_SIZE, {
    DEFAULT_BUFF_SIZE,
    DEFAULT_BUFF_SIZE,
    DEFAULT_BUFF_SIZE,
    DEFAULT_BUFF_SIZE
  })
  if is_valid_bufsize(buff_size) then
    for _, store in ipairs(store_full_list) do
      store:update_buff_size(buff_size[store.data_type])
    end
  end
end

function M.set_report_by_bufsize_fn(report_by_bufsize_fn)
  assert(type(report_by_bufsize_fn) == "function", "expect a function")
  report_by_bufsize = report_by_bufsize_fn
end

local function split_stats(stats)
  local result = {
    api_stats = {},
    api_count = 0,
    rpc_stats = {},
    rpc_count = 0,
    ui_stats = {},
    ui_count = 0,
    common_stats = {},
    common_count = 0,
    default_stats = {},
    default_count = 0
  }
  for k, v in pairs(stats) do
    if string.sub(k, 1, #Global.namespace_api_stats) == Global.namespace_api_stats then
      result.api_stats[k] = v
      result.api_count = result.api_count + 1
    elseif string.sub(k, 1, #Global.namespace_rpc_stats) == Global.namespace_rpc_stats then
      result.rpc_stats[k] = v
      result.rpc_count = result.rpc_count + 1
    elseif string.sub(k, 1, #Global.namespace_ui_stats) == Global.namespace_ui_stats then
      result.ui_stats[k] = v
      result.ui_count = result.ui_count + 1
    elseif string.sub(k, 1, #Global.namespace_common_stats) == Global.namespace_common_stats then
      result.common_stats[k] = v
      result.common_count = result.common_count + 1
    else
      result.default_stats[k] = v
      result.default_count = result.default_count + 1
    end
  end
  return result
end

function M.retrieve_data(dtype)
  local store = store_full_list[dtype]
  if store then
    do return store.retrieve_data end
    return store.retrieve_data, store, nil
  else
    E.LOG.error(LOGGER, "retrieve_data ... store is nil")
  end
end

function M.submit_stats(stats)
  local result = split_stats(stats)
  if result.default_count > 0 then
    M.stats_store.collect_counter:inc(result.default_count)
    M.stats_store:submit(M.pack(Global.DataCgrEnum.APM_STATS, result.default_stats))
  end
  for k, api_stat in pairs(result.api_stats) do
    for _, v in ipairs(api_stat) do
      M.stats_store.collect_counter:inc(1)
      M.stats_store:submit(M.pack(Global.DataCgrEnum.API_STATS, {
        [k] = v
      }))
    end
  end
  for k, rpc_stat in pairs(result.rpc_stats) do
    for _, v in ipairs(rpc_stat) do
      M.stats_store.collect_counter:inc(1)
      M.stats_store:submit(M.pack(Global.DataCgrEnum.RPC_STATS, {
        [k] = v
      }))
    end
  end
  for k, ui_stat in pairs(result.ui_stats) do
    M.stats_store.collect_counter:inc(1)
    M.stats_store:submit(M.pack(Global.DataCgrEnum.UI_STATS, {
      [k] = ui_stat
    }))
  end
  for k, common_stat in pairs(result.common_stats) do
    M.stats_store.collect_counter:inc(1)
    M.stats_store:submit(M.pack(Global.DataCgrEnum.COMMON_STATS, {
      [k] = common_stat
    }))
  end
end

function M.submit_event(event)
  M.event_store.collect_counter:inc()
  local attributes = Labeler.get_attributes()
  if event.labels then
    attributes = Utils.merge_table(attributes, event.labels, false)
    attributes.event_name = event.event_name
  else
    attributes = Utils.merge_table(attributes, {
      event_name = event.event_name
    }, false)
  end
  M.stats_store:submit(M.pack(Global.DataCgrEnum.APM_EVENT_STATS, event.stats, attributes))
  if event.msg ~= nil then
    local log = {
      event_name = event.event_name,
      trace_id = event.trace_id,
      message = event.msg,
      stats = event.stats
    }
    M.log_store:submit(M.pack(Global.DataCgrEnum.APM_EVENT_LOG, log, attributes))
  end
end

function M.submit_log(log)
  M.log_store.collect_counter:inc()
  M.log_store:submit(M.pack(Global.DataCgrEnum.APM_LOG, log))
end

function M.submit_trace(span)
  M.trace_store.collect_counter:inc()
  M.trace_store:submit(span)
end

function M.pack(datatype, data, attributes)
  return {
    type = datatype,
    timestamp = Time.now_ms(),
    attributes = attributes or Labeler.get_attributes(),
    body = data
  }
end

return M

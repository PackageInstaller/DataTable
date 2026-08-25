local E = require("ejoysdk_lua.ejoysdk")
local LOGGER = "apm_fast_event"
local JSONUtil = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local Ratelimit = require("ejoysdk_lua.apm-sdk-lua.common.ratelimit")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local sformat = string.format
local M = {}
local MAX_LIMIT = 1000
local MAX_BURST = 2000
local MAX_QUEUE_SIZE = 5000
local full_eventer_list = {}
local support_os = {
  ios = 1,
  android = 2,
  windows = 3,
  harmonyos = 4,
  douyin = 5,
  weixin = 6
}
local eventer = {
  ingester_url = "",
  post_url = "",
  env = "",
  utdid = "",
  game_ver = "",
  os = "",
  dt = "",
  labels = {},
  limit = 500,
  burst = 1000,
  max_length = 10240,
  queue = nil,
  rate_limiter = nil
}
eventer.__index = eventer
local default_timeout = 5

local function http_post(post_url, req_body)
  local function cb(resp)
    if not resp then
      E.LOG.error(LOGGER, "error posting, resp is nil ")
      
      return
    end
    local status = tostring(resp.status)
    if resp.status ~= 200 then
      E.LOG.error(LOGGER, "error sending " .. ",status:" .. status)
      E.LOG.error(LOGGER, resp.body)
    end
  end
  
  E.LOG.debug(LOGGER, "HTTP POST: url=" .. post_url)
  E.HTTP.post(post_url, {use_gzip = true, timeout = default_timeout}, E.HTTP.CT_JSON, req_body, cb)
end

local has_printed_clean_stats_err = {}

local function clean_stats(stats)
  if type(stats) ~= "table" then
    return
  end
  for k, v in pairs(stats) do
    if type(v) ~= "number" then
      if not has_printed_clean_stats_err[k] then
        E.LOG.error(LOGGER, string.format("value of [key:%s] expects number type,but got %s", k, type(v)))
        has_printed_clean_stats_err[k] = true
      end
      stats[k] = nil
    end
  end
  return stats
end

local has_printed_clean_labels_err = {}

local function clean_labels(labels)
  if type(labels) ~= "table" then
    return {}
  end
  for k, _ in pairs(labels) do
    if type(k) ~= "string" then
      if not has_printed_clean_labels_err[k] then
        E.LOG.error(LOGGER, string.format("value of [key:%s] expects string type,but got %s", k, type(k)))
        has_printed_clean_labels_err[k] = true
      end
      labels[k] = nil
    end
  end
  return labels
end

local function add_namespace(stats)
  if nil == stats then
    return stats
  end
  local result = {}
  for k, v in pairs(stats) do
    result["ev_" .. k] = v
  end
  return result
end

local function pack(event, dt)
  local attributes = {
    event_name = event.event_name
  }
  if event.labels then
    attributes = Utils.merge_table(attributes, event.labels, false)
  end
  return {
    type = dt or Global.DataCgrEnum.APM_EVENT_STATS,
    timestamp = Time.now_ms(),
    attributes = attributes,
    body = event.stats
  }
end

local function build_data(event_name, labels, msg, stats, dt)
  stats = clean_stats(stats)
  labels = clean_labels(labels)
  labels = Utils.merge_table(labels, {msg = msg}, false)
  if not labels.timestamp then
    labels.timestamp = Time.now_ms()
  end
  local event = {
    event_name = event_name,
    labels = labels,
    stats = add_namespace(stats)
  }
  local data = pack(event, dt)
  return data
end

function eventer:post_with_high_priority(event_name, labels, msg, stats)
  if self.ratelimiter ~= nil and not self.ratelimiter:allow() then
    E.LOG.error(LOGGER, "eventer:post_with_high_priority is rejected by ratelimiter")
    return
  end
  if nil ~= msg and #msg > self.max_length then
    msg = string.sub(msg, 1, self.max_length)
  end
  local data = build_data(event_name, labels, msg, stats, self.dt)
  local encapsulate = require("ejoysdk_lua.apm-sdk-lua.reporter.otlp_http")
  local _labels = Utils.merge_table(Labeler.get_resource(), self.labels, true)
  local req_body = encapsulate.build_otlp_logs_v2(_labels, {data})
  E.LOG.debug(LOGGER, req_body)
  http_post(self.post_url, req_body)
end

function eventer:post(event_name, labels, msg, stats)
  if self.ratelimiter ~= nil and not self.ratelimiter:allow() then
    E.LOG.error(LOGGER, "eventer:post is rejected by ratelimiter")
    return
  end
  if nil ~= msg and #msg > self.max_length then
    msg = string.sub(msg, 1, self.max_length)
  end
  local data = build_data(event_name, labels, msg, stats, self.dt)
  self:enqueue(data)
end

function eventer:enqueue(data)
  if self.queue == nil then
    E.LOG.error(LOGGER, "queue is nil,ignore enqueue")
    return
  end
  local queue_size = #self.queue
  if queue_size >= MAX_QUEUE_SIZE then
    E.LOG.error(LOGGER, "reach max queue size,ignore enqueue")
    return
  end
  table.insert(self.queue, data)
  E.LOG.debug(LOGGER, "enqueue done, queue size:" .. tostring(#self.queue))
end

function eventer:report_event()
  if not next(self.queue) then
    E.LOG.debug(LOGGER, "queue is empty , ignore report")
    return
  end
  local data = self.queue
  self.queue = {}
  local encapsulate = require("ejoysdk_lua.apm-sdk-lua.reporter.otlp_http")
  local labels = Utils.merge_table(Labeler.get_resource(), self.labels, true)
  local req_body = encapsulate.build_otlp_logs_v2(labels, data)
  http_post(self.post_url, req_body)
end

local function adjust_limit_burst(limit, burst)
  if type(limit) ~= "number" or type(burst) ~= "number" then
    limit = 500
    burst = 1000
  end
  if limit > MAX_LIMIT then
    limit = MAX_LIMIT
  end
  if burst > MAX_BURST then
    burst = MAX_BURST
  end
  return limit, burst
end

local function check_labels(labels)
  if type(labels) ~= "table" then
    return "illegal param,labels expect table"
  end
  if type(labels.env) ~= "string" or labels.env == "" then
    return "illegal param,labels.env expect a not nil string"
  end
  if "string" ~= type(labels.utdid) or "" == labels.utdid then
    return "illegal param,labels.utdid expect a not nil string"
  end
  if "string" ~= type(labels.os) or "" == labels.os then
    return "illegal param,labels.os expect a not nil string"
  end
  return ""
end

local rl_scene_counter = 0

function eventer.new(ingester_url, labels, limit, burst, dt)
  local check_label_result = check_labels(labels)
  if "" ~= check_label_result then
    return nil, check_label_result
  end
  limit, burst = adjust_limit_burst(limit, burst)
  if limit < 0 or burst < 0 then
    return nil, "illegal param,expect positive limit and burst"
  end
  if type(ingester_url) ~= "string" or "" == ingester_url then
    return nil, "illegal param,ingester_url expect a not nil string"
  end
  if support_os[labels.os] == nil then
    return nil, "illegal param,labels.os expect only android/os/windows/harmonyos/douyin/weixin"
  end
  rl_scene_counter = rl_scene_counter + 1
  local api = "/v1/stats"
  if dt == Global.DataCgrEnum.APM_EVENT_LOG then
    api = "/v1/logs"
  end
  local obj = {
    ingester_url = ingester_url,
    post_url = sformat("%s/%s%s", ingester_url, labels.env, api),
    env = labels.env,
    utdid = labels.utdid,
    game_ver = labels.game_ver,
    os = labels.os,
    labels = labels,
    burst = burst,
    limit = limit,
    queue = {},
    max_length = 10240,
    dt = dt,
    ratelimiter = Ratelimit.new_limiter(limit, burst, "fast_event" .. tostring(rl_scene_counter))
  }
  local result = setmetatable(obj, eventer)
  table.insert(full_eventer_list, result)
  return result, nil
end

function M.new_eventer(ingester_url, labels, limit, burst, dt)
  dt = dt or Global.DataCgrEnum.APM_EVENT_STATS
  M.init()
  JSONUtil.init()
  do return eventer.new, ingester_url, labels, limit, burst end
  return eventer.new, ingester_url, labels, limit, burst, dt
end

function M.report_event()
  for _, ev in ipairs(full_eventer_list) do
    ev:report_event()
  end
end

local initialized = false
local stopping = true
local report_interval = 5
local report_event

function report_event()
  local fast_log_report_interval = Cfg.get_fast_event_report_interval()
  if nil ~= fast_log_report_interval then
    report_interval = fast_log_report_interval
  end
  if not stopping then
    E.Timer.once(report_interval, report_event)
  end
  M.report_event()
end

function M.stop_event_timer()
  stopping = true
end

function M.init()
  if initialized then
    return
  end
  initialized = true
  if true == stopping then
    stopping = false
    E.Timer.once(report_interval, report_event)
    E.LOG.debug(LOGGER, "event_reporter started")
  end
end

return M

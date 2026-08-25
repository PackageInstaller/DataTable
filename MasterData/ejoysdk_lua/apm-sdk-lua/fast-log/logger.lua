local Ratelimit = require("ejoysdk_lua.apm-sdk-lua.common.ratelimit")
local E = require("ejoysdk_lua.ejoysdk")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local sformat = string.format
local JSONUtil = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local LOGGER = "apm_fast_log"
local M = {}
local MAX_LIMIT = 1000
local MAX_BURST = 2000
local MAX_QUEUE_SIZE = 5000
local default_timeout = 5
local full_logger_list = {}
local support_levels = {
  CRI = 1,
  ERR = 2,
  WAR = 3,
  INF = 4,
  DBG = 5
}
local support_os = {
  ios = 1,
  android = 2,
  windows = 3,
  harmonyos = 4,
  douyin = 5,
  weixin = 6
}
local logger = {
  ingester_url = "",
  post_url = "",
  env = "",
  utdid = "",
  game_ver = "",
  os = "",
  limit = 500,
  burst = 1000,
  queue = nil,
  rate_limiter = nil
}
logger.__index = logger

local function check_log_params(level, line, ts, msg)
  if type(level) ~= "string" then
    return "illegal param,level expect string"
  end
  if nil == support_levels[level] then
    return "illegal param,level expects one of CRI/ERR/WAR/INF/DBG"
  end
  if type(line) ~= "string" or "" == line then
    return "illegal param,line expect a not nil string"
  end
  if type(msg) ~= "string" or "" == msg then
    return "illegal param,msg expect a not nil string"
  end
  if type(ts) ~= "number" or ts < 0 then
    return "illegal param,ts expect a positive number"
  end
  return ""
end

local function http_post(post_url, req_body)
  local function cb(resp)
    if not resp then
      E.LOG.error(LOGGER, "error posting, resp is nil ")
      
      return
    end
    local status = tostring(resp.status)
    E.LOG.debug(LOGGER, "url=" .. post_url .. ", status=" .. status)
    if resp.status ~= 200 then
      E.LOG.error(LOGGER, "error sending " .. ",status:" .. status)
      E.LOG.error(LOGGER, resp.body)
    end
  end
  
  E.HTTP.post(post_url, {use_gzip = true, timeout = default_timeout}, E.HTTP.CT_JSON, req_body, cb)
end

local last_time, last_time_str

local function format_time(timestamp)
  local sec = math.floor(timestamp)
  local ms = math.floor(timestamp * 1000 % 1000)
  local f
  if sec == last_time then
    f = last_time_str
  else
    f = Time.format(sec)
    last_time_str = f
    last_time = sec
  end
  do return sformat, "%s.%03d", f end
  return sformat, "%s.%03d", f, ms
end

function logger:log(level, line, ts, msg, extra_labels)
  if self.ratelimiter ~= nil and not self.ratelimiter:allow() then
    E.LOG.error(LOGGER, "fast-log log is rejected by ratelimiter")
    return
  end
  local err = check_log_params(level, line, ts, msg)
  if "" ~= err then
    E.LOG.error(LOGGER, "check_log_params fails,msg:" .. tostring(err))
    return
  end
  local sec = math.floor(ts)
  local ms = math.floor(ts * 1000 % 1000)
  local timestamp = sec * 1000 + ms
  local attributes = {}
  if type(extra_labels) == "table" then
    attributes = extra_labels
  end
  local log = {
    body = {
      module = "app",
      message = msg,
      timestamp = format_time(ts),
      line = line,
      level = level
    },
    type = "apm_log",
    timestamp = timestamp,
    attributes = attributes
  }
  self:enqueue(log)
end

function logger:enqueue(data)
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

function logger:report_log()
  if not next(self.queue) then
    E.LOG.debug(LOGGER, "queue is empty , ignore report")
    return
  end
  local data = self.queue
  self.queue = {}
  local res = {
    utdid = self.utdid,
    game_ver = self.game_ver,
    env = self.env,
    os = self.os
  }
  local encapsulate = require("ejoysdk_lua.apm-sdk-lua.reporter.otlp_http")
  local req_body = encapsulate.build_otlp_logs_v2(res, data)
  E.LOG.debug(LOGGER, req_body)
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

function logger.new(ingester_url, labels, limit, burst)
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
  local obj = {
    ingester_url = ingester_url,
    post_url = sformat("%s/%s/v1/logs", ingester_url, labels.env),
    env = labels.env,
    utdid = labels.utdid,
    game_ver = labels.game_ver,
    os = labels.os,
    burst = burst,
    limit = limit,
    queue = {},
    ratelimiter = Ratelimit.new_limiter(limit, burst, "fast_log" .. tostring(rl_scene_counter))
  }
  local result = setmetatable(obj, logger)
  table.insert(full_logger_list, result)
  return result, nil
end

function M.new_logger(ingester_url, labels, limit, burst)
  M.init()
  JSONUtil.init()
  do return logger.new, ingester_url, labels, limit end
  return logger.new, ingester_url, labels, limit, burst
end

function M.report_log()
  for _, lg in ipairs(full_logger_list) do
    lg:report_log()
  end
end

local initialized = false
local stopping = true
local report_interval = 5
local report_log

function report_log()
  local fast_log_report_interval = Cfg.get_fast_log_report_interval()
  if nil ~= fast_log_report_interval then
    report_interval = fast_log_report_interval
  end
  if not stopping then
    E.Timer.once(report_interval, report_log)
  end
  M.report_log()
end

function M.init()
  if initialized then
    return
  end
  initialized = true
  if true == stopping then
    stopping = false
    E.Timer.once(report_interval, report_log)
    E.LOG.debug(LOGGER, "log_reporter started")
  end
end

return M

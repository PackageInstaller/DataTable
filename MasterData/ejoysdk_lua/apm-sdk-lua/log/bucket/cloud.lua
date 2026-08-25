local Formatter = require("ejoysdk_lua.apm-sdk-lua.log.formatter")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local Ratelimit = require("ejoysdk_lua.apm-sdk-lua.common.ratelimit")
local CollectFilter = require("ejoysdk_lua.apm-sdk-lua.common.collect_filter")
local E = require("ejoysdk_lua.ejoysdk")
local Store = require("ejoysdk_lua.apm-sdk-lua.store.store")
local DD = require("ejoysdk_lua.apm-sdk-lua.dedup.deduper")
local UserAction = require("ejoysdk_lua.apm-sdk-lua.recorder.user_action")
local sformat = string.format
local sgsub = string.gsub
local ssub = string.sub
local slog_fmt = "({+)([%w_]*)(}+)"
local error = _ENV.error
local LOGGER = "apm_bucket_cloud"
local cloud = {
  handle = io.stdout
}
local structured_keys = {}

local function build_args(values, msg)
  if nil == values or 0 == #values then
    return nil
  end
  local idx, n = 0, #values
  
  local function fargs(left, mid, right)
    local lnum, rnum = #left, #right
    local parity = lnum % 2
    if rnum % 2 ~= parity then
      error("mismatched parentheses")
    end
    left = ssub(left, 1, math.floor(lnum / 2))
    right = ssub(right, 1, math.floor(rnum / 2))
    if 1 == parity then
      idx = idx + 1
      if idx > n then
        error(sformat("no value to %s (%s#%d)", msg, mid, idx))
      end
      structured_keys[idx] = mid
      structured_keys[idx + 1] = nil
      do return sformat, "%s%s:%s%s", left, mid, values[idx] end
      return sformat, "%s%s:%s%s", left, mid, values[idx], right
    end
    do return sformat, "%s%s%s", left, mid end
    return sformat, "%s%s%s", left, mid, right, right
  end
  
  sgsub(msg, slog_fmt, fargs)
  local args = {}
  for i = 1, #values do
    local key = structured_keys[i]
    if not key then
      return nil
    end
    if 0 == #key or args[key] then
      key = sformat("%s#%d", key, i)
    end
    args[key] = values[i]
  end
  return args
end

local MAX_LOG_LENGTH = 8192

local function truncate_msg(msg)
  if #msg >= MAX_LOG_LENGTH then
    msg = string.sub(msg, 1, MAX_LOG_LENGTH)
  end
  return msg
end

local function get_level_desc(level)
  local desc = Formatter.level_desc[level]
  local level_desc = desc and desc.name or tostring(level)
  return level_desc
end

function cloud:close_deduper()
  self.deduper = nil
end

function cloud:set_deduper(deduper)
  self.deduper = deduper
end

function cloud:should_block(event_name, msg)
  if not Cfg.is_log_enabled() then
    return true
  end
  if CollectFilter.is_in_log_blacklist(event_name) then
    return true
  end
  if self.deduper ~= nil and self.deduper:should_dedup(msg) then
    E.LOG.debug(LOGGER, "cloud log put is deduped")
    return true
  end
  if nil ~= self.ratelimiter and not self.ratelimiter:allow() then
    E.LOG.debug(LOGGER, "cloud log put is rejected by ratelimiter")
    return true
  end
  return false
end

function cloud:put(catalog, record)
  local event_name = "pure_log"
  if record.values ~= nil and next(record.values) then
    event_name = record.msg
  end
  local msg = self.formatter(catalog, record)
  msg = truncate_msg(msg)
  if self:should_block(event_name, msg) then
    E.LOG.debug(LOGGER, "cloud log put is blocked")
    return
  end
  local level_desc = get_level_desc(record.level)
  local log = {
    event_name = event_name,
    trace_id = nil,
    message = msg,
    line = record.line,
    timestamp = Formatter.format_time(record.timestamp),
    module = record.module,
    tags = record.tags,
    args = build_args(record.values, record.msg),
    level = level_desc,
    o_timestamp = record.timestamp,
    o_level = record.level,
    stats = nil
  }
  UserAction.trigger_report()
  Store.submit_log(log)
  return true
end

function cloud:close()
end

cloud.default_params = {format = "text", color = false}

function cloud.new(_, params)
  local rate_limit = Cfg.get(Cfg.CATEGORY_LOG, "rate_limit", 10)
  local burst = Cfg.get(Cfg.CATEGORY_LOG, "burst", 100)
  local err
  cloud.ratelimiter, err = Ratelimit.new_limiter(rate_limit, burst, "cloud_log")
  if nil ~= err then
    E.LOG.error(LOGGER, "new limiter err:" .. err)
  else
    E.LOG.debug(LOGGER, "new limiter succ")
  end
  local dedup_cfg = Cfg.get_log_dedup_cfg()
  if dedup_cfg.enabled then
    cloud.deduper = DD.new_deduper(dedup_cfg.queue_len)
  end
  cloud.formatter = Formatter.get_formatter(params.format, params.color)
  return cloud
end

return cloud

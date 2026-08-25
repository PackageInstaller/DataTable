local E = require("ejoysdk_lua.ejoysdk")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local Ratelimit = require("ejoysdk_lua.apm-sdk-lua.common.ratelimit")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Store = require("ejoysdk_lua.apm-sdk-lua.store.store")
local ErrUtils = require("ejoysdk_lua.apm-sdk-lua.common.err_utils")
local M = {
  enabled = true,
  burst = 100,
  rate_limit = 10
}
local CFG_RATE = "rate_limit"
local CFG_BURST = "burst"
local LOGGER = "apm_trace_collector"

local function assert_greater_than(value, key, boundary)
  if type(value) == "number" and type(boundary) == "number" and boundary < value then
    E.LOG.debug(LOGGER, string.format("trace.%s is changed to %.2f", key, value))
    return true
  end
  E.LOG.debug(LOGGER, string.format("invalid %s ,type:%s,value:%s", key, type(value), tostring(value)))
  return false
end

local key_changes_handlers = {
  [Cfg.KEY_ENABLED] = function(value)
    M.enabled = value
    E.LOG.debug(LOGGER, "trace is " .. (value and "enabled" or "disabled"))
  end,
  [CFG_RATE] = function(value)
    if type(value) == "number" then
      M.rate_limit = value
      if M.ratelimiter then
        M.ratelimiter:set_rate(value)
      end
    end
  end,
  [CFG_BURST] = function(value)
    if assert_greater_than(value, CFG_BURST, 0) then
      M.burst = value
      if M.ratelimiter then
        M.ratelimiter:set_burst(value)
      end
    end
  end
}

local function handle_config_update(key, value)
  local handler = key_changes_handlers[key]
  if nil ~= handler then
    handler(value)
  else
    E.LOG.debug(LOGGER, "trace " .. key .. " changes to " .. value .. " but ignored. ")
  end
end

function M.init()
  M.enabled = Cfg.get(Cfg.CATEGORY_TRACE, Cfg.KEY_ENABLED, true)
  M.rate_limit = Cfg.get(Cfg.CATEGORY_TRACE, CFG_RATE, 10)
  M.burst = Cfg.get(Cfg.CATEGORY_TRACE, CFG_BURST, 100)
  Cfg.set_update_callback(Cfg.CATEGORY_TRACE, handle_config_update)
  local err
  M.ratelimiter, err = Ratelimit.new_limiter(M.rate_limit, M.burst, "trace")
  if nil ~= err then
    E.LOG.error(LOGGER, "new limiter err:" .. err)
  else
    E.LOG.debug(LOGGER, "new limiter succ")
  end
end

local function collect(span)
  if not M.enabled then
    E.LOG.warn(LOGGER, "trace collect is not enabled")
    return
  end
  if not Global.is_apus_sdk_initialized() then
    E.LOG.warn(LOGGER, "apus sdk has not initialized")
    return
  end
  if M.rate_limit > 0 and M.ratelimiter ~= nil and not M.ratelimiter:allow() then
    E.LOG.debug(LOGGER, "trace collect is rejected by ratelimiter")
    return
  end
  local context = span:context()
  local tags = span:get_tags()
  local baggage = context:get_baggage()
  local attributes = tags
  if nil ~= baggage then
    for k, v in pairs(baggage) do
      attributes[k] = v
    end
  end
  local parent_id = context:get_parent_id()
  if 0 == parent_id then
    parent_id = nil
  end
  local record = {
    traceId = context:get_trace_id(),
    spanId = context:get_span_id(),
    parentSpanId = parent_id,
    name = span:get_operation_name() or "empty_oper",
    startTimeUnixNano = span:get_start() .. "000000",
    endTimeUnixNano = span:get_end() .. "000000",
    attributes = attributes
  }
  Store.submit_trace(record)
end

function M.collect(span)
  local function collect_fn()
    do return collect end
    
    return collect, span
  end
  
  xpcall(collect_fn, ErrUtils.handle_err)
end

return M

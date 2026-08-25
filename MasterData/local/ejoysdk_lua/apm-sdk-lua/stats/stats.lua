local E = require("ejoysdk_lua.ejoysdk")
local Metrics = require("ejoysdk_lua.apm-sdk-lua.common.metrics")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local CFG_MODULES = "modules"
local instances = {}
local LOGGER = "apm_stats"
local mt = {}
mt.__index = mt

function mt:enable()
  self.enabled = true
end

function mt:disable()
  self.enabled = false
end

function mt:add(metric)
  self.metrics[metric.name] = metric
end

function mt:get(metric_name)
  return self.metrics[metric_name]
end

function mt:remove(metric)
  self.metrics[metric.name] = nil
end

function mt:new_counter(metric_name, clearable, verbose)
  local m = Metrics.new_counter(metric_name, clearable, verbose)
  if nil ~= m then
    self:add(m)
    return m
  end
end

function mt:new_gauge(metric_name)
  local m = Metrics.new_gauge(metric_name)
  if nil ~= m then
    self:add(m)
    return m
  end
end

function mt:new_gauge_with_func(metric_name, verbose, func)
  local m = Metrics.new_gauge_with_func(metric_name, verbose, func)
  if nil ~= m then
    self:add(m)
    return m
  end
end

function mt:new_aggregate(metric_name, verbose)
  local m = Metrics.new_aggregate(metric_name, verbose)
  if nil ~= m then
    self:add(m)
    return m
  end
end

function mt:set_calc_func(func, ...)
  self.calc_func = func
  self.calc_args = {
    ...
  }
end

function mt:destroy()
  instances[self.name] = nil
  self.metrics = {}
end

local function is_config_enabled(stats_name)
  local enabled = true
  local module_cfg = Cfg.get(Cfg.CATEGORY_STATS, CFG_MODULES)
  if nil ~= module_cfg and type(module_cfg) == "table" then
    for name, cfg in pairs(module_cfg) do
      if name == stats_name then
        enabled = cfg[Cfg.KEY_ENABLED]
        break
      end
    end
  end
  return enabled
end

local M = {}

function M.new(name, namespace)
  if not Utils.is_metric_name_valid(namespace) then
    E.LOG.error("namespace is invalid    #" .. tostring(namespace))
    return nil
  end
  if nil ~= namespace and #namespace >= 6 then
    namespace = string.sub(namespace, 1, 6)
  end
  if nil ~= instances[name] then
    E.LOG.error("Stats模块已存在：" .. name)
    return nil
  end
  local enabled = is_config_enabled(name)
  if not enabled then
    E.LOG.debug(LOGGER, "stats " .. name .. " is disabled in stats creation")
  end
  local obj = {
    enabled = enabled,
    name = name,
    namespace = namespace,
    metrics = {},
    calc_func = nil
  }
  setmetatable(obj, mt)
  instances[name] = obj
  E.LOG.debug(LOGGER, string.format("created stats with name=%s, namespace=%s", name, namespace))
  return obj
end

function M.get(name)
  return instances[name]
end

function M.get_instances()
  return instances
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local TAG = "ejoysdk_span_reporter"
local M = {}
local l_opentracing_enable = true
local OPENTRACING_ENABLE_CONFIG_KEY = "opentracing_config"
local OPENTRACING_ENABLE_KEY = "opentracing_enable"
local CONFIG = require("ejoysdk_lua.ejoysdk_config")
local is_inited = false
local OPENTRACING = {}
local TracerHttp, TracerTags, TracerContext

function OPENTRACING.get_tracer()
  if nil == TracerHttp then
    local ETRACER = require("ejoysdk_lua.opentracing.ejoysdk_tracer")
    local TracerBuilder = ETRACER.TracerBuilder
    TracerHttp = TracerBuilder:New(nil, nil, "ejoysdk_account"):build()
  end
  return TracerHttp
end

function OPENTRACING.get_tags()
  if nil == TracerTags then
    TracerTags = require("ejoysdk_lua.opentracing.ejoysdk_tags")
  end
  return TracerTags
end

function OPENTRACING.get_context()
  return TracerContext
end

function OPENTRACING.set_context(context)
  TracerContext = context
end

local TracerLink = {}

local function get_span_dep(span_id)
  if not span_id or "" == span_id then
    return nil
  end
  return TracerLink[span_id]
end

function M.move_span_dep(span_id)
  TracerLink[span_id] = nil
end

function M.set_span_dep(span)
  if not span then
    return
  end
  local span_id = span:context():get_span_id()
  TracerLink[span_id] = span
end

function M.clear_span_dep()
  TracerLink = {}
end

local l_has_apm_vendor

local function has_apm_vendor()
  if nil == l_has_apm_vendor then
    if CONFIG.has_vendor_config("APM") then
      l_has_apm_vendor = true
    else
      l_has_apm_vendor = false
    end
  end
  return l_has_apm_vendor
end

function M.init()
  if not is_inited then
    is_inited = true
    if not has_apm_vendor() then
      l_opentracing_enable = false
      E.LOG.debug(TAG, "apm vendor did not config, return")
      return
    end
    E.LOG.debug(TAG, "init it")
    local CC = require("ejoysdk_lua.ejoysdk_config_center")
    local biz_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
    if biz_config and biz_config.config and biz_config.config[OPENTRACING_ENABLE_CONFIG_KEY] then
      local opentracing_config = biz_config.config[OPENTRACING_ENABLE_CONFIG_KEY] or {}
      if nil ~= opentracing_config[OPENTRACING_ENABLE_KEY] then
        l_opentracing_enable = opentracing_config[OPENTRACING_ENABLE_KEY]
      end
      E.LOG.debug(TAG, "init opentracing_enable from config center >> " .. tostring(opentracing_config[OPENTRACING_ENABLE_KEY]))
    else
      CC.subscribe(CC.NAMESPACE.EJOYSDK_BIZ, function(config)
        E.LOG.debug(TAG, "receive ejoysdk_biz config refresh")
        if config and config.config then
          local opentracing_config = config.config[OPENTRACING_ENABLE_CONFIG_KEY] or {}
          if nil ~= opentracing_config[OPENTRACING_ENABLE_KEY] then
            l_opentracing_enable = opentracing_config[OPENTRACING_ENABLE_KEY]
          end
          E.LOG.debug(TAG, "init opentracing_enable from config center >> " .. tostring(opentracing_config[OPENTRACING_ENABLE_KEY]))
        end
      end)
    end
  else
    E.LOG.debug(TAG, "has inited!")
  end
end

function M.fill_tags(span, tags, perfix)
  if not span or not tags then
    return
  end
  if tags and type(tags) == "table" then
    for key, tag in pairs(tags) do
      if type(key) == "number" then
        key = "k-" .. key
      end
      if perfix then
        key = perfix .. "." .. key
      end
      if tag and type(tag) == "table" then
        M.fill_tags(span, tag, key)
      else
        span:set_tag(key, tag)
      end
    end
  end
end

function M.opentracing_enable()
  if not has_apm_vendor() then
    return false
  end
  return l_opentracing_enable
end

function M.start_span(span_name, parent_span_id, tags)
  E.LOG.debug(TAG, "start span >> " .. tostring(span_name))
  if not M.opentracing_enable() then
    return
  end
  local span
  if parent_span_id and "" ~= parent_span_id then
    local parent_span = get_span_dep(parent_span_id)
    if nil ~= parent_span and type(parent_span) == "table" then
      span = OPENTRACING.get_tracer():build_span(span_name):as_child_of_span(parent_span):start()
    end
  end
  if nil == span then
    span = OPENTRACING.get_tracer():build_span(span_name):start()
  end
  M.set_span_dep(span)
  pcall(M.fill_tags, span, tags)
  return span
end

function M.set_tags(span_id, tags)
  if not M.opentracing_enable() then
    return
  end
  if span_id and "" ~= span_id then
    local span = get_span_dep(span_id)
    pcall(M.fill_tags, span, tags)
  end
end

function M.finish_span(span_id, tags)
  if not M.opentracing_enable() then
    return
  end
  if span_id and "" ~= span_id then
    local span = get_span_dep(span_id)
    if not span then
      E.LOG.debug(TAG, "span is not exist for span_id " .. tostring(span_id))
      return
    end
    E.LOG.debug(TAG, "finish span >> " .. tostring(span_id) .. " span name >> " .. tostring(span:get_operation_name()))
    pcall(M.fill_tags, span, tags)
    span:finish_now()
    M.move_span_dep(span_id)
  end
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.CHAT .. "opentracing"
local OPENTRACING = {}
local TracerHttp, TracerTags, TracerContext
local TracerLink = {}
local M = {}
local RPC = {}
M.RPC = RPC

function OPENTRACING.get_tracer()
  if nil == TracerHttp then
    local ETRACER = require("ejoysdk_lua.opentracing.ejoysdk_tracer")
    local TracerBuilder = ETRACER.TracerBuilder
    TracerHttp = TracerBuilder:New(nil, nil, "ejoysdk"):build()
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

function RPC.get_span_dep(span_buz)
  return TracerLink[span_buz]
end

function RPC.set_span_dep(span, span_buz)
  TracerLink[span_buz] = span
end

function RPC.opentracing_enable()
  do return end
  return E.HTTP.opentracing_enable, nil
end

function RPC.start_rpc_span(method, cmd, params, chat_trace_id)
  if not RPC.opentracing_enable() then
    return nil
  end
  local opentracing = params._opentracing
  local net_span
  if opentracing and type(opentracing) == "table" then
    if opentracing.span_buz ~= nil and nil ~= opentracing.reference then
      local parent_span = RPC.get_span_dep(opentracing.span_buz)
      if nil ~= parent_span and type(parent_span) == "table" then
        net_span = OPENTRACING.get_tracer():build_span(opentracing.span_buz or method):as_child_of_span(parent_span):start()
      end
    end
    if nil == net_span then
      net_span = OPENTRACING.get_tracer():build_span(opentracing.span_buz or method):start()
    end
    net_span:set_tag(OPENTRACING.get_tags().HTTP_URL, cmd)
    net_span:set_tag(OPENTRACING.get_tags().HTTP_METHOD, method)
    net_span:set_tag(OPENTRACING.get_tags().SPAN_KIND, OPENTRACING.get_tags().SPAN_KIND_CLIENT)
    if chat_trace_id then
      net_span:set_tag("rpc.trace", chat_trace_id)
    end
  end
  return net_span
end

function RPC.inject_tracing_header(span, content_header)
  if not RPC.opentracing_enable() then
    return
  end
  if nil ~= span then
    local context = span:context()
    if nil ~= context then
      local trace_id = tostring(context:get_trace_id())
      E.LOG.debug(TAG, "RPC_trace_id=" .. tostring(trace_id))
      local context_string = trace_id .. ":" .. tostring(context:get_span_id()) .. ":" .. tostring(context:get_parent_id()) .. ":1"
      if nil ~= content_header then
        content_header[OPENTRACING.get_tags().INJECT_HTTP_HEADER] = context_string
      else
        content_header = {
          [OPENTRACING.get_tags().INJECT_HTTP_HEADER] = context_string
        }
      end
    end
  end
  return content_header
end

function RPC.stop_rpc_span(opentracing, span, info)
  if not RPC.opentracing_enable() then
    return
  end
  if nil ~= span then
    span:set_tag(OPENTRACING.get_tags().HTTP_STATUS, tostring(info and info.code) or "-1")
    span:finish_now()
    if opentracing.span_buz then
      if opentracing.reference and opentracing.reference == OPENTRACING.get_tags().FOLLOWS_FROM then
        return
      end
      RPC.set_span_dep(span, opentracing.span_buz)
    end
  end
end

return M

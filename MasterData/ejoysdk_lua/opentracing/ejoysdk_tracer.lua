local E = require("ejoysdk_lua.ejoysdk")
local ETR_I = require("ejoysdk_lua.opentracing.api.tracer")
local EREPORT = require("ejoysdk_lua.opentracing.ejoysdk_remote_reporter")
local ESCOPE = require("ejoysdk_lua.opentracing.ejoysdk_scope")
local ESPAN = require("ejoysdk_lua.opentracing.ejoysdk_span")
local ESPANCONTEXT = require("ejoysdk_lua.opentracing.ejoysdk_span_context")
local ECODEC = require("ejoysdk_lua.opentracing.ejoysdk_text_map_codec")
local ETAGS = require("ejoysdk_lua.opentracing.ejoysdk_tags")
local EREFERENCE = require("ejoysdk_lua.opentracing.ejoysdk_reference")
local EUUID = require("ejoysdk_lua.ejoysdk_uuid")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = ETR_I:Inherit("EjoyTracer")
local TAG = EM.MODULE.OPENTRACING .. "EjoyTracer"
local LUA_OPENTRACING_VERSION = "1.3.2.0"

function M:unique_id()
  do return end
  return EUUID.random_i64
end

local TracerBuilder = Class:Inherit("TracerBuilder")

function TracerBuilder:_init(sampler, reporter, service_name)
  self.sampler = sampler
  self.reporter = reporter
  self.service_name = service_name
  self.tags = {}
  self.scope_manager = ESCOPE.EjoyScope:New()
  self.http_codec = ECODEC:New(nil, nil, true)
end

function TracerBuilder:with_reporter(reporter)
  self.reporter = reporter
  return self
end

function TracerBuilder:with_sampler(sampler)
  self.sampler = sampler
  return self
end

function TracerBuilder:with_scope_manager(scope_manager)
  self.scope_manager = scope_manager
  return self
end

function TracerBuilder:with_tag(k, v)
  self.tags[k] = v
  return self
end

function TracerBuilder:with_tags(kv_tags)
  if self.tags ~= nil then
    for k, v in pairs(kv_tags) do
      self.tags[k] = v
    end
  end
  return self
end

function TracerBuilder:create_tracer()
  do return M.New, M end
  return M.New, M, self
end

function TracerBuilder:build()
  if self.reporter == nil then
    self.reporter = EREPORT:New()
    if self.reporter == nil then
      E.LOG.debug(TAG, "TracerBuilder:new reporter is nil")
      return
    end
  end
  do return self.create_tracer end
  return self.create_tracer, self, "TracerBuilder:new reporter is nil"
end

M.TracerBuilder = TracerBuilder
local SpanBuilder = Class:Inherit("SpanBuilder")

function SpanBuilder:_init(tracer, operation_name, start_time_ms)
  self.tracer = tracer
  self.operation_name = operation_name
  self.start_time_ms = start_time_ms
  self.references = {}
  self.tags = {}
  self.ignore_active_span = false
end

function SpanBuilder:add_reference(reference_type, reference)
  if nil == reference then
    return self
  elseif reference_type ~= ETAGS.CHILD_OF and reference_type ~= ETAGS.FOLLOWS_FROM then
    return self
  else
    local new_refer = EREFERENCE:New(reference, reference_type)
    table.insert(self.references, new_refer)
  end
  return self
end

function SpanBuilder:as_child_of(span_context)
  do return self.add_reference, self, ETAGS.CHILD_OF end
  return self.add_reference, self, ETAGS.CHILD_OF, span_context
end

function SpanBuilder:as_child_of_span(parent)
  if nil ~= parent then
    do return self.add_reference, self, ETAGS.CHILD_OF, parent:context() end
    return self.add_reference, self, ETAGS.CHILD_OF, parent:context()
  end
  do return self.add_reference, self, ETAGS.CHILD_OF end
  return self.add_reference, self, ETAGS.CHILD_OF, nil, parent:context()
end

function SpanBuilder:with_tag(k, v)
  self.tags[k] = v
  return self
end

function SpanBuilder:with_start_time_ms(start_time_ms)
  self.start_time_ms = start_time_ms
  return self
end

function SpanBuilder:preferred_reference()
  local prefer = self.references[1]
  local length = #self.references
  if length > 1 then
    for i = 2, length do
      local reference = self.references[i]
      if ETAGS.CHILD_OF == reference.reference_type and ETAGS.CHILD_OF ~= prefer.reference_type then
        prefer = reference
        break
      end
    end
  end
  do return prefer.get_span_context end
  return prefer.get_span_context, prefer, 1, nil, self.references[i], ETAGS.CHILD_OF, prefer.reference_type
end

function SpanBuilder:create_new_context()
  local span_id = M:unique_id()
  local trace_id = M:unique_id() .. span_id
  local new_span_context = ESPANCONTEXT:New(trace_id, span_id, 0, self.baggage)
  return new_span_context
end

function SpanBuilder:create_child_context()
  local parent = self:preferred_reference()
  local span_id = M:unique_id()
  local child_span_context = ESPANCONTEXT:New(parent.trace_id, span_id, parent.span_id, self.flags, self.baggage)
  return child_span_context
end

function SpanBuilder:get_baggage()
  if 1 == #self.references then
    do return self.references[1]:get_span_context().get_baggage end
    return self.references[1]:get_span_context().get_baggage, self.references[1]:get_span_context(), nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  else
    local baggage
    for _, v in pairs(self.references) do
      if v.get_baggage ~= nil then
        if nil == baggage then
          baggage = {}
        end
        for bk, bv in pairs(v.get_baggage()) do
          baggage[bk] = bv
        end
      end
    end
  end
end

function SpanBuilder:is_rpc_server()
  return ETAGS.SPAN_KIND_SERVER == self.tags[ETAGS.SPAN_KIND]
end

function SpanBuilder:ignore_active_span()
  self.ignore_active_span = true
  return self
end

function SpanBuilder:start()
  if self.references == nil then
    self.references = {}
  end
  local new_span_context
  if not self.references or 0 == #self.references then
    new_span_context = self:create_new_context()
  elseif not self.references[1]:get_span_context():has_trace() then
    new_span_context = self:create_new_context()
  else
    new_span_context = self:create_child_context()
  end
  if not self.start_time_ms then
    self.start_time_ms = E.time_ms()
  end
  local new_span = ESPAN:New(self.tracer, self.operation_name, new_span_context, self.start_time_ms, self.tags, self.references)
  return new_span
end

M.SpanBuilder = SpanBuilder

function M:_init(builder)
  if nil == builder then
    E.LOG.debug(TAG, "buider is nil")
    return
  end
  self.servic_ename = builder.service_name
  self.reporter = builder.reporter
  self.sampler = builder.sampler
  self.scope_manager = builder.scope_manager
  self.version = LUA_OPENTRACING_VERSION
  self.tags = {}
  table.insert(self.tags, {
    key = ETAGS.VERSION,
    value = self.version
  })
  self.ipv4 = 0
end

function M:get_version()
  return self.version
end

function M:get_service_name()
  return self.servicename
end

function M:get_tags()
  return self.tags
end

function M:get_ipv4()
  return self.ipv4
end

function M:get_reporter()
  return self.reporter
end

function M:http_headers_inject(span_context, carrier)
  self.http_codec:inject(span_context, carrier)
end

function M:http_headers_extract(carrier)
  do return self.http_codec.extract, self.http_codec end
  return self.http_codec.extract, self.http_codec, carrier
end

function M:context_as_string(span_context)
  do return self.http_codec.context_as_string, self.http_codec end
  return self.http_codec.context_as_string, self.http_codec, span_context
end

function M:scope_manager()
  return self.scope_manager
end

function M:active_span()
  do return self.scope_manager.active_span end
  return self.scope_manager.active_span, self.scope_manager
end

function M:report_span(span)
  if self.reporter == nil then
    E.LOG.warn(TAG, "reporter is nil")
    return
  end
  self.reporter:report_span(span)
end

local function create_span_builder(tracer, operation_name)
  do return M.SpanBuilder.New, M.SpanBuilder, tracer end
  return M.SpanBuilder.New, M.SpanBuilder, tracer, operation_name
end

function M:build_span(operation_name)
  do return create_span_builder, self end
  return create_span_builder, self, operation_name
end

function M:close()
  self.reporter:close()
end

function M:get_hostname()
  return ""
end

function M:activate_span(span)
  do return self.scope_manager.activate, self.scope_manager end
  return self.scope_manager.activate, self.scope_manager, span
end

return M

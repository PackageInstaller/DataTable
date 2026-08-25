local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("Span")
local opentracing_span_context = require("ejoysdk_lua.opentracing.api.span_context")

function M:_init(_tracer)
  self.tracer_ = _tracer
end

function M:context()
  do return opentracing_span_context.New end
  return opentracing_span_context.New, opentracing_span_context
end

function M:tracer()
  return self.tracer_
end

function M:set_operation_name(_operation_name)
end

function M:finish(_finish_timestamp)
end

function M:set_tag(_key, _value)
end

function M:log_kv(_key_values, _timestamp)
end

function M:set_baggage_item(_key, _value)
end

function M:get_baggage_item(_key)
  return nil
end

function M:each_baggage_item()
end

return M

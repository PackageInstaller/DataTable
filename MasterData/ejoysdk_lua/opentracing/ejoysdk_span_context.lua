local ESPC = require("ejoysdk_lua.opentracing.api.span_context")
local M = ESPC:Inherit("EjoySpanContext")

function M:_init(trace_id, span_id, parent_id, baggage)
  self.trace_id = trace_id
  self.span_id = span_id
  self.parent_id = parent_id
  self.baggage = baggage or {}
end

function M:get_trace_id()
  return self.trace_id
end

function M:get_span_id()
  return self.span_id
end

function M:get_parent_id()
  return self.parent_id
end

function M:has_trace()
  return self.trace_id ~= nil and nil ~= self.span_id
end

function M:get_baggage()
  return self.baggage
end

function M:get_baggage_count()
  return #self.baggage
end

function M:get_baggage_item(key)
  local value
  if self.baggage then
    value = self.baggage[key]
  end
  return value
end

function M:to_span_id()
  do return tostring end
  return tostring, self.span_id
end

function M:to_trace_id()
  do return tostring end
  return tostring, self.trace_id
end

function M:get_flag()
  return 0
end

return M

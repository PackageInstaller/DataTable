local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("Tracer")
local opentracing_span = require("ejoysdk_lua.opentracing.api.span")

function M:_init()
end

function M:start_span(_operation_name, _options)
  do return opentracing_span.New, opentracing_span end
  return opentracing_span.New, opentracing_span, self
end

function M:text_map_inject(_span_context, _carrier)
end

function M:http_headers_inject(_span_context, _carrier)
end

function M:binary_inject(_span_context)
  return ""
end

function M:text_map_extract(_carrier)
  return nil
end

function M:http_headers_extract(_carrier)
  return nil
end

function M:binary_extract(_carrier)
  return nil
end

return M

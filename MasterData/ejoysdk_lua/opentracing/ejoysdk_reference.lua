local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("EjoyReference")

function M:_init(span_context, type)
  self.span_context = span_context
  self.type = type
end

function M:get_span_context()
  return self.span_context
end

function M:get_type()
  return self.type
end

return M

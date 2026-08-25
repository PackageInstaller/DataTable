local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("EjoyRemoteReporter")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.OPENTRACING .. "EjoyRemoteReporter"

function M:_init()
end

function M:report_span(span)
  local ok, trace_collector = pcall(require, "ejoysdk_lua.apm-sdk-lua.trace.collector")
  if ok then
    if nil ~= trace_collector then
      trace_collector.collect(span)
    end
  else
    E.LOG.debug(TAG, "collector not exist")
  end
end

return M

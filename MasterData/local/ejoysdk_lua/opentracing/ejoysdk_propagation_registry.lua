local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("EjoyPropagationRegistry")
local TAG = EM.MODULE.OPENTRACING .. "EjoyPropagationRegistry"

function M:_init()
  E.LOG.debug(TAG, "_init")
end

return M

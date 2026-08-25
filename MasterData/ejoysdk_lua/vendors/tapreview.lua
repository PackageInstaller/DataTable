local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CHANNEL = "TAP_REVIEW"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.TAPREVIEW

function M.init(_opt, cb)
  E.LOG.debug(TAG, "tapreview init")
  cb(true)
end

return M

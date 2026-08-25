local ET = require("ejoysdk_lua.ejoysdk_topic")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "REYUN"
local _TAG = EM.MODULE.VENDORS.REYUN
local CAST_INIT = "CAST_INIT"
local CAST_PURCHASE_SUCC = "CAST_PURCHASE_SUCC"
local CAST_REGISTER = "CAST_REGISTER"
local CAST_LOGIN = "CAST_LOGIN"
local CAST_CREATE_ORDER = "CAST_CREATE_ORDER"
local CAST_EXIT = "CAST_EXIT"
local CAST_COMMIT_EVENT = "CAST_COMMIT_EVENT"
local M = Vendor:Inherit(VENDOR_NAME)

local function sha1_hex(data)
  do return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data) end
  return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data)
end

function M.init(opt, cb)
  UNI.cast(VENDOR_NAME, CAST_INIT, opt.config or {})
  ET.subscribe(ET.analytics.REGISTER, function(user_info)
    UNI.cast(VENDOR_NAME, CAST_REGISTER, {
      uid = sha1_hex(user_info.uid)
    })
  end)
  ET.subscribe(ET.analytics.LOGIN, function(user_info)
    UNI.cast(VENDOR_NAME, CAST_LOGIN, {
      uid = sha1_hex(user_info.uid)
    })
  end)
  ET.subscribe(ET.analytics.CREATE_ORDER, function(order_id, product_info)
    UNI.cast(VENDOR_NAME, CAST_CREATE_ORDER, {
      order_id = sha1_hex(order_id),
      product_info = product_info
    })
  end)
  ET.subscribe(ET.analytics.PURCHASE_SUCC, function(order_id, product_info)
    UNI.cast(VENDOR_NAME, CAST_PURCHASE_SUCC, {
      order_id = sha1_hex(order_id),
      product_info = product_info
    })
  end)
  ET.subscribe(ET.analytics.EXIT, function()
    UNI.cast(VENDOR_NAME, CAST_EXIT, {})
  end)
  cb(true)
end

function M.commit_event(event_name, params)
  local event_params = {event_name = event_name, params = params}
  UNI.cast(VENDOR_NAME, CAST_COMMIT_EVENT, event_params)
end

return M

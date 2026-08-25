local CONSTANS = require("ejoysdk_lua.ejoysdk_constants")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.CUSTOM .. "custom_service"

local function get_custom_service_vendor()
  if E.is_scan_pkg() then
    return nil
  end
  local EVDS = require("ejoysdk_lua.ejoysdk_vendors")
  local EV = require("ejoysdk_lua.vendors.vendor")
  local os = E.Sysinfo.os()
  if "weixin" == os then
    local WEIXIN = require("ejoysdk_lua.vendors.weixin")
    return WEIXIN
  end
  if "douyin" == os then
    local DOUYIN = require("ejoysdk_lua.vendors.douyin")
    return DOUYIN
  end
  if "android" == os then
    local CLOUDGAME_3RD = require("ejoysdk_lua.ejoysdk_cloudgame_3rd")
    if CLOUDGAME_3RD.is_cloudgame() then
      do return end
      return CLOUDGAME_3RD.get_cloudgame_vendor, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
  end
  local vendor_names = EVDS.get_native_vendors(EV.ABILITY.CUSTOM_SERVICE)
  if vendor_names and #vendor_names > 0 then
    local vendor = EVDS.get(vendor_names[1])
    if vendor and vendor:is_support_ability({
      EV.ABILITY.CUSTOM_SERVICE
    }) then
      E.LOG.debug(TAG, "find support custom with native ability:" .. tostring(vendor_names[1]))
      return vendor
    end
  end
  for _name, vendor in pairs(EVDS.VENDORS) do
    if vendor:is_support_ability({
      EV.ABILITY.CUSTOM_SERVICE
    }) then
      E.LOG.debug(TAG, "find support custom with vendor ability:" .. tostring(_name))
      return vendor
    end
  end
  E.LOG.warn(TAG, "get_custom_service_vendor nil, no vendor found")
  return nil
end

function M.can_show_custom_service()
  if E.is_scan_pkg() then
    return false
  end
  local vendor = get_custom_service_vendor()
  if nil ~= vendor then
    return true
  end
  return false
end

local default_orientation = "portrait"

function M.show_custom_service(params, cb, close_cb)
  params = params or {}
  params.orientation = params.orientation or default_orientation
  local vendor = get_custom_service_vendor()
  if not vendor then
    E.LOG.warn(TAG, "show_custom_service failed, no vendor found")
    if cb then
      cb(false, CONSTANS.CUSTOM_SERVICE.CODE_NOT_SUPPORT, "不支持客服接口")
    end
    if close_cb then
      close_cb()
    end
    return
  else
    E.LOG.debug(TAG, "show_custom_service begin")
    vendor.show_custom_service(params, cb, close_cb)
  end
end

return M

local M = {}
local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local TAG = "harmonyos#agora"
local VENDOR_NAME = "AGORA"
local CAST_DESTROY_ENGINE = "CAST_DESTROY_ENGINE"
local CAST_SET_PARAMETERS = "CAST_SET_PARAMETERS"
local is_support_cache = {}

function M.is_compat_agora_api(api_name)
  E.LOG.debug(TAG, "is_compat_agora_api")
  if nil ~= is_support_cache[api_name] then
    return is_support_cache[api_name]
  end
  local FUNC_MAPS = require("ejoysdk_lua.harmonyos.ejoysdk_vm_vendor_func_maps")
  is_support_cache[api_name] = FUNC_MAPS.is_impl_in_lua(VENDOR_NAME, api_name)
  return is_support_cache[api_name]
end

function M.destroy()
  E.LOG.debug(TAG, "destroy")
  UNI.cast(VENDOR_NAME, CAST_DESTROY_ENGINE, {})
end

function M.enable_ai_denoise(_enable)
  E.LOG.debug(TAG, "call enable_ai_denoise")
  local paramstr
  if _enable then
    paramstr = "{\"che.audio.ns.mode\":2,\"che.audio.enable.nsng\":true,\"che.audio.nsng.lowerBound\":10,\"che.audio.nsng.lowerMask\":10,\"che.audio.nsng.statisticalbound\":0,\"che.audio.nsng.finallowermask\":8,\"che.audio.nsng.enhfactorstastical\":200}"
  else
    paramstr = "{\"che.audio.ains_mode\":0}"
  end
  UNI.cast(VENDOR_NAME, CAST_SET_PARAMETERS, {params = paramstr})
end

return M

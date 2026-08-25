local E = require("ejoysdk_lua.ejoysdk")
local TAG = "EjoysdkErrorUtils"
local M = {}
local WINDOWS_NETWORK_ERROR_CODES = {
  [6] = true,
  [7] = true,
  [22] = true,
  [23] = true,
  [26] = true,
  [28] = true,
  [35] = true,
  [56] = true,
  [61] = true
}

function M.check_is_network_error(code)
  if type(code) ~= "number" then
    return false
  end
  local os = E.Sysinfo.os()
  E.LOG.debug(TAG, "check_is_network_error, code type: " .. type(code) .. ", code: " .. tostring(code))
  if "android" == os or "ios" == os then
    return code <= -1000 and code >= -1099
  elseif "windows" == os then
    return true == WINDOWS_NETWORK_ERROR_CODES[code]
  else
    return false
  end
end

return M

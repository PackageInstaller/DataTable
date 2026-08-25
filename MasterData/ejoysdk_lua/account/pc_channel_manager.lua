local BILIBILI = require("ejoysdk_lua.vendors.bilibili")
local M = {}

function M.check_is_pc_channel_pkg()
  if _ejoysdk.os() ~= "windows" then
    return nil
  end
  if BILIBILI.is_support_channel_sdk() then
    return "BILIBILI"
  end
  return nil
end

function M.get_channel_vendor()
  if _ejoysdk.os() ~= "windows" then
    return nil
  end
  if BILIBILI.is_support_channel_sdk() then
    return BILIBILI
  end
  return nil
end

return M

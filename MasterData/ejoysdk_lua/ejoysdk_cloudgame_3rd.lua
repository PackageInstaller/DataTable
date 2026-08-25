local EC = require("ejoysdk_lua.ejoysdk_config")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
M.CLOUDGAME_TYPE = {
  DYMINICLOUDGAME = "DYMINICLOUDGAME",
  WXMINICLOUDGAME = "WXMINICLOUDGAME"
}
M.CLOUD_MODE = {
  CLOUD = "cloud",
  MOBILE = "mobile",
  UNKNOWN = "unknown"
}

function M.get_cloudgame_type()
  if EC.has_vendor_config(M.CLOUDGAME_TYPE.WXMINICLOUDGAME) then
    return M.CLOUDGAME_TYPE.WXMINICLOUDGAME
  end
  if EC.has_vendor_config(M.CLOUDGAME_TYPE.DYMINICLOUDGAME) then
    return M.CLOUDGAME_TYPE.DYMINICLOUDGAME
  end
  return nil
end

function M.get_cloudgame_vendor()
  if EC.has_vendor_config(M.CLOUDGAME_TYPE.DYMINICLOUDGAME) then
    local cloud_vendor = require("ejoysdk_lua.vendors.dyminicloudgame")
    return cloud_vendor
  end
  return nil
end

local _cache_is_cloudgame

function M.is_cloudgame()
  if nil ~= _cache_is_cloudgame then
    return _cache_is_cloudgame
  end
  if _ejoysdk.os() ~= "android" then
    _cache_is_cloudgame = false
    return false
  end
  if EC.has_vendor_config(M.CLOUDGAME_TYPE.WXMINICLOUDGAME) or EC.has_vendor_config(M.CLOUDGAME_TYPE.DYMINICLOUDGAME) then
    _cache_is_cloudgame = true
    return true
  end
  _cache_is_cloudgame = false
  return false
end

function M.get_cloudgame_mode()
  if M.is_cloudgame() then
    return M.CLOUD_MODE.CLOUD
  end
end

function M.get_third_open_id()
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_third_open_id then
    do return end
    return vendor.get_third_open_id
  end
end

function M.get_third_ad_params()
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_third_ad_params then
    do return end
    return vendor.get_third_ad_params
  end
end

function M.get_device_system()
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.Sysinfo and vendor.Sysinfo.get_device_system then
    do return end
    return vendor.Sysinfo.get_device_system
  end
end

function M.get_system_info(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_system_info then
    do return vendor.get_system_info, params end
    return vendor.get_system_info, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.get_launch_options(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_launch_options then
    do return vendor.get_launch_options, params end
    return vendor.get_launch_options, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.get_cache_launch_option()
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_cache_launch_option then
    do return end
    return vendor.get_cache_launch_option
  end
end

function M.get_archive_result(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_archive_result then
    do return vendor.get_archive_result, params end
    return vendor.get_archive_result, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.navigate_to_scene(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.navigate_to_scene then
    do return vendor.navigate_to_scene, params end
    return vendor.navigate_to_scene, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.check_scene(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.check_scene then
    do return vendor.check_scene, params end
    return vendor.check_scene, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.add_shortcut(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.add_shortcut then
    do return vendor.add_shortcut, params end
    return vendor.add_shortcut, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.check_shortcut(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.check_shortcut then
    do return vendor.check_shortcut, params end
    return vendor.check_shortcut, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.report_scene(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.report_scene then
    do return vendor.report_scene, params end
    return vendor.report_scene, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.share_app_message(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.share_app_message then
    do return vendor.share_app_message, params end
    return vendor.share_app_message, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.get_setting(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_setting then
    do return vendor.get_setting, params end
    return vendor.get_setting, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.open_setting(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.open_setting then
    do return vendor.open_setting, params end
    return vendor.open_setting, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.set_clipboard_data(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.set_clipboard_data then
    do return vendor.set_clipboard_data, params end
    return vendor.set_clipboard_data, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.get_clipboard_data(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.get_clipboard_data then
    do return vendor.get_clipboard_data, params end
    return vendor.get_clipboard_data, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.show_keyboard(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.show_keyboard then
    do return vendor.show_keyboard, params end
    return vendor.show_keyboard, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.hide_keyboard(params, cb)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.hide_keyboard then
    do return vendor.hide_keyboard, params end
    return vendor.hide_keyboard, params, cb, nil
  end
  if cb then
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT, "api not supported")
  end
end

function M.set_listeners(_listeners)
  local vendor = M.get_cloudgame_vendor()
  if vendor and vendor.set_listeners then
    do return vendor.set_listeners end
    return vendor.set_listeners, _listeners
  end
end

return M

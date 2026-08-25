local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CHANNEL = "ZALO"
local CONTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.VENDORS.ZALO
local M = Vendor:Inherit(CHANNEL)
local android_package_name = "com.zing.zalo"

function M.init(_opt, cb)
  cb(true)
end

local function can_open_zalo()
  E.LOG.debug(TAG, "can_open_zalo, os=" .. tostring(E.Sysinfo.os()))
  if E.Sysinfo.os() == "android" then
    do return E.Sysinfo.is_app_install end
    return E.Sysinfo.is_app_install, android_package_name, "can_open_zalo, os=" .. tostring(E.Sysinfo.os()), tostring(E.Sysinfo.os()), E.Sysinfo.os()
  elseif E.Sysinfo.os() == "ios" then
    do return E.Sysinfo.can_open_url end
    return E.Sysinfo.can_open_url, "zaloshareext://", "can_open_zalo, os=" .. tostring(E.Sysinfo.os()), tostring(E.Sysinfo.os()), E.Sysinfo.os()
  else
    return false
  end
end

local function share_text(param, cb)
  if param.message == nil or 0 == #param.message then
    cb(false, CONTS.SHARE.CODE_SHARE_TEXT_EMPTY, "share text empty")
    return
  end
  local trim = string.gsub(param.message, "%s+", "")
  if trim and 0 == #trim then
    cb(false, CONTS.SHARE.CODE_SHARE_TEXT_EMPTY, "share text empty")
    return
  end
  if E.Sysinfo.os() == "android" then
    local share_to_app_params = {
      message = param.message,
      package_name = android_package_name
    }
    E.async_call("SHARE_TO_APP", share_to_app_params, nil, function(info)
      if info.succ then
        cb(true)
      else
        cb(false, CONTS.SHARE.CODE_SHARE_OPEN_FAIL, "share open fail")
      end
    end)
  elseif E.Sysinfo.os() == "ios" then
    E.async_call("SHARE_TO_SYSTEM", function(info)
      E.LOG.debug(TAG, "zalo share to system callback info >>")
      E.LOG.debug(TAG, info)
      local result = JSON.decode(info) or {}
      if result.succ then
        cb(true)
      else
        cb(false, result.code or CONTS.SHARE.CODE_SHARE_OPEN_FAIL, "can not open zalo")
      end
    end, JSON.encode(param))
  else
    cb(false, CONTS.SHARE.CODE_PLATFORM_NOT_SUPPORT, "os platform not support")
  end
end

local function share_image(param, cb)
  param.media = param.media or {}
  param.media[1] = param.media[1] or {}
  local image_url = param.media[1].data
  if nil == image_url or 0 == #image_url then
    cb(false, CONTS.SHARE.CODE_IMAGE_FILE_EMPTY, "image file empty")
    return
  end
  local f = io.open(image_url, "r")
  if f then
    io.close(f)
  else
    E.LOG.debug(TAG, "image file not exist!!!!")
    cb(false, CONTS.SHARE.CODE_IMAGE_FILE_NOT_EXIST, "image file not exist")
    return
  end
  if E.Sysinfo.os() == "android" then
    local share_to_app_params = {
      image_url = image_url,
      message = param.message,
      package_name = android_package_name,
      type = "image_url"
    }
    E.async_call("SHARE_TO_APP", share_to_app_params, nil, function(info)
      if info.succ then
        cb(true)
      else
        cb(false, CONTS.SHARE.CODE_SHARE_OPEN_FAIL, "share open fail")
      end
    end)
  elseif E.Sysinfo.os() == "ios" then
    E.async_call("SHARE_TO_SYSTEM", function(info)
      E.LOG.debug(TAG, "zalo share to system callback info >>")
      E.LOG.debug(TAG, info)
      local result = JSON.decode(info) or {}
      if result.succ then
        cb(true)
      else
        cb(false, result.code or CONTS.SHARE.CODE_SHARE_OPEN_FAIL, "can not open zalo")
      end
    end, JSON.encode(param))
  else
    cb(false, CONTS.SHARE.CODE_PLATFORM_NOT_SUPPORT, "os platform not support")
  end
end

function M.is_share_support()
  do return end
  return can_open_zalo, nil
end

function M.share(param, _chunk_data, cb)
  E.LOG.debug(TAG, "zalo share >>")
  E.LOG.debug(TAG, param)
  if not can_open_zalo() then
    cb(false, CONTS.SHARE.CODE_PLATFORM_NOT_SUPPORT, "share platform not support")
    return
  end
  if param.content_url then
    cb(false, CONTS.SHARE.CODE_SHARE_TYPE_NOT_SUPPORT, "share link url is not support")
    return
  end
  if param.media and #param.media > 0 and param.media[1].type == "image_url" then
    share_image(param, cb)
    return
  end
  if param.message then
    share_text(param, cb)
    return
  end
end

M:is_implemented({
  Vendor.ABILITY.SHARE
})
return M

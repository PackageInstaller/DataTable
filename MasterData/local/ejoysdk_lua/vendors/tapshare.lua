local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONTS = require("ejoysdk_lua.ejoysdk_constants")
local CHANNEL = "TAPSHARE"
local ASYNC_SHARE = "ASYNC_SHARE"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.TAPSHARE

function M.init(_opt, cb)
  E.LOG.debug(TAG, "tapshare init")
  UNI.async_call(CHANNEL, "INIT_VENDOR", {}, "", function(succ, ...)
    local _, body
    if succ then
      cb(true)
    else
      _, body = ...
      cb(false, body.error_code, body.error_msg)
    end
  end)
end

local function auto_set_channel()
  if "TAP_UPDATE" == CHANNEL then
    return
  end
  local sdk_infos = UNI.get_sdk_infos()
  local sdk_info = sdk_infos[CHANNEL]
  if not sdk_info and E.Sysinfo.os() == "android" then
    CHANNEL = "TAP_UPDATE"
  end
end

function M.share(param, _chunk_data, cb)
  E.LOG.debug(TAG, "taptap share received")
  E.LOG.debug(TAG, param)
  
  local function share_cb(succ, ...)
    E.LOG.debug(TAG, "share taptap succ:" .. tostring(succ))
    if succ then
      if cb then
        cb(true)
      end
    else
      local _code, _body = ...
      _body = _body or {}
      if cb then
        cb(false, _body.error_code or _code, _body.error_msg)
      end
    end
  end
  
  if E.Sysinfo.os() == "android" then
    local temp_share_files = {}
    for idx, media_item in ipairs(param.media or {}) do
      if media_item.type == "image_chunk" and _chunk_data then
        local media_data = media_item.data
        local index = media_data.index
        local length = media_data.length
        local img_bytes = _chunk_data:sub(index + 1, index + length)
        local temp_img_fullpath = E.Path.join(E.File.get_ext_file_dir(), "xhs_share_temp", "media_" .. tostring(idx))
        local result = E.Path.ensure_parent_dir(temp_img_fullpath)
        result = result and E.File.writefile_fullpath(temp_img_fullpath, img_bytes)
        E.LOG.debug(TAG, "share begin, find chunk data image, change to temp file:" .. tostring(temp_img_fullpath) .. ", result:" .. tostring(result))
        if result then
          media_item.type = "image_url"
          media_item.data = temp_img_fullpath
          table.insert(temp_share_files, temp_img_fullpath)
        end
      end
    end
    
    local function share_finish_cb()
      for _, temp_file_path in ipairs(temp_share_files) do
        E.LOG.debug(TAG, "share finish, begin remove temp file:" .. tostring(temp_file_path))
        E.File.remove_fullpath(temp_file_path)
      end
    end
    
    auto_set_channel()
    UNI.async_call(CHANNEL, ASYNC_SHARE, param, nil, function(succ, ...)
      share_finish_cb()
      share_cb(succ, ...)
    end)
  elseif E.Sysinfo.os() == "ios" then
    UNI.async_call(CHANNEL, ASYNC_SHARE, param, _chunk_data, share_cb)
  elseif cb then
    cb(false, CONTS.SHARE.CODE_PLATFORM_NOT_SUPPORT, "not support share platform")
  end
end

function M.is_share_support()
  E.LOG.debug(TAG, "is_tapshare_support, os:" .. tostring(E.Sysinfo.os()))
  if E.Sysinfo.os() == "android" or E.Sysinfo.os() == "ios" then
    return true
  end
  return false
end

M:is_implemented({
  Vendor.ABILITY.SHARE
})
return M

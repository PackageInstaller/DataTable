local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "XIAOHONGSHU"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.XIAOHONGSHU
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ACTION_IS_SUPPORT_SHARE = "SYNC_IS_PLATFORM_SUPPORT"

function M.init(_opt, cb)
  E.LOG.debug(TAG, "init-xhs")
  UNI.async_call(VENDOR_NAME, "INIT_VENDOR", {}, "", function(succ, ...)
    local _, body
    if succ then
      cb(true)
    else
      _, body = ...
      body = body or {}
      cb(false, body.error_code, body.error_msg)
    end
  end)
end

local function can_open_xhs()
  E.LOG.debug(TAG, "can_open_xhs, os:" .. tostring(E.Sysinfo.os()))
  if E.Sysinfo.os() == "android" then
    local ret = UNI.sync_call(VENDOR_NAME, ACTION_IS_SUPPORT_SHARE, {})
    E.LOG.debug(TAG, "is_share_support received ret:")
    E.log(ret)
    local is_support = ret and ret.support or false
    E.LOG.debug(TAG, "is_share_support:" .. tostring(is_support))
    return is_support
  elseif E.Sysinfo.os() == "ios" then
    do return E.Sysinfo.can_open_url end
    return E.Sysinfo.can_open_url, "xhsdiscover://", E.LOG.debug, TAG, "is_share_support:" .. tostring(is_support), tostring(is_support), is_support
  else
    return false
  end
end

function M.is_share_support()
  do return end
  return can_open_xhs, nil
end

function M.share(param, _chunk_data, cb)
  E.LOG.debug(TAG, "xhs share >>>>")
  E.LOG.debug(TAG, param)
  if not can_open_xhs() then
    cb(false, CONTS.SHARE.CODE_PLATFORM_NOT_SUPPORT, "未安装小红书")
    return
  end
  local media_size = param.media and #param.media or 0
  if 0 == media_size then
    cb(false, CONTS.SHARE.CODE_SHARE_NOT_HAS_MEDIA, "小红书分享需要包含图片信息")
    return
  end
  local temp_share_files = {}
  if E.Sysinfo.os() ~= "ios" then
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
  end
  
  local function share_finish_cb()
    for _, temp_file_path in ipairs(temp_share_files) do
      E.LOG.debug(TAG, "share finish, begin remove temp file:" .. tostring(temp_file_path))
      E.File.remove_fullpath(temp_file_path)
    end
  end
  
  UNI.async_call(VENDOR_NAME, "ASYNC_SHARE_TO_PLATFORM", param, _chunk_data, function(succ, ...)
    local _, body
    if succ then
      share_finish_cb()
      cb(true)
    else
      share_finish_cb()
      _, body = ...
      cb(false, body.error_code, body.error_msg)
    end
  end)
end

M:is_implemented({
  Vendor.ABILITY.SHARE
})
return M

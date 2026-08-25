local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local M = {}
local TAG = "aligames_config"
local UNISDK_CHANNEL = "ALIGAMES"
local SYNC_GET_FT_VERSION = "SYNC_GET_FT_VERSION"
M.CONSTANTS = {
  UNISDK_CHANNEL = "ALIGAMES",
  CHANNEL = "ALIGAMES",
  LX_CHANNEL_ID = "998233",
  BRAND_LX_BAIPAI = "baipai",
  PLUGIN_NAME_WHITE_BRAND = "ALIGAMES_WHITE_BRAND"
}
local lx_brand_cache, config_center_base_url_cache

function M.is_for_lingxi()
  local cur_channel_id = E.get_channel()
  local CONFIG = require("ejoysdk_lua.ejoysdk_config")
  E.LOG.debug(TAG, "is_for_lingxi cur channel id:" .. tostring(cur_channel_id) .. ", has aligames:" .. tostring(CONFIG.has_vendor_config(M.CONSTANTS.CHANNEL)))
  if _ejoysdk.os() == "windows" and (not cur_channel_id or "" == cur_channel_id) then
    local pkg_info = E.get_pkg_info()
    cur_channel_id = pkg_info.channel_id
    E.LOG.debug(TAG, "cur_channel_id read from pkg_info.channel_id, cur_channel_id = " .. tostring(cur_channel_id))
  end
  if cur_channel_id == M.CONSTANTS.LX_CHANNEL_ID then
    return true
  else
    return false
  end
end

function M.get_lingxi_brand()
  if lx_brand_cache then
    E.LOG.debug(TAG, "find cache lingxi brand:" .. tostring(lx_brand_cache))
    return lx_brand_cache
  end
  E.LOG.debug(TAG, "now get lingxi brand")
  if E.CONFIG.get_vendor_config("AIRLINE_V2") then
    local airline_config = require("ejoysdk_lua.airline_v2.airline_v2_config")
    lx_brand_cache = airline_config.get_airline_brand()
    E.LOG.debug(TAG, "has airline_v2, lx_brand_cache = " .. tostring(lx_brand_cache))
  elseif E.CONFIG.get_vendor_config(M.CONSTANTS.PLUGIN_NAME_WHITE_BRAND) then
    lx_brand_cache = M.CONSTANTS.BRAND_LX_BAIPAI
    E.LOG.debug(TAG, "lx_brand_cache is baipai")
  else
    E.LOG.debug(TAG, "lx_brand_cache is nil, not has airline_v2, not baipai")
  end
  if nil == lx_brand_cache then
    lx_brand_cache = ""
    E.LOG.debug(TAG, "lx_brand_cache is nil, use empty string instead")
  end
  return lx_brand_cache
end

function M.get_config_center_base_url()
  if config_center_base_url_cache then
    E.LOG.debug(TAG, "find cache config_center_base_url_cache:" .. tostring(config_center_base_url_cache))
    return config_center_base_url_cache
  end
  E.LOG.debug(TAG, "is for lingxi, now check config center base url")
  if E.CONFIG.get_vendor_config("AIRLINE_V2") then
    local airline_config = require("ejoysdk_lua.airline_v2.airline_v2_config")
    config_center_base_url_cache = airline_config.get_config_center_base_url()
    E.LOG.debug(TAG, "is for lingxi, config_center_base_url_cache === " .. tostring(config_center_base_url_cache))
  else
    E.LOG.debug(TAG, "is for lingxi but not airline, skip check config center base url")
  end
  if nil == config_center_base_url_cache then
    config_center_base_url_cache = ""
  end
  return config_center_base_url_cache
end

function M.is_lingxi_baipai()
  local lx_brand = M.get_lingxi_brand()
  return lx_brand == M.CONSTANTS.BRAND_LX_BAIPAI
end

function M.get_ft_version()
  local ret = UNI.sync_call(UNISDK_CHANNEL, SYNC_GET_FT_VERSION, {})
  if ret and ret.value then
    E.LOG.debug(TAG, "get_ft_version success:" .. tostring(ret.value))
    return ret.value
  else
    E.LOG.warn(TAG, "get_ft_version failed")
    return ""
  end
end

return M

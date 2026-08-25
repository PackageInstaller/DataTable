local E = require("ejoysdk_lua.ejoysdk")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local M = {}
local TAG = "DOWNLOAD#download_url_utils"

local function is_entire_url(url)
  return string.find(url, "^http") ~= nil or nil ~= string.find(url, "^https")
end

local function is_mainland()
  local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  publish_area = publish_area and publish_area:lower()
  return "cn" == publish_area
end

local function get_mainland_icon_base_url()
  local server_name = "https://dict.lingxigames.com"
  return server_name
end

local function replace_base_url(base_url, url)
  do return string.gsub, url, "^https?://[^/]+" end
  return string.gsub, url, "^https?://[^/]+", base_url
end

function M.get_banner_url(uri)
  local base_url = EU.get_media_base_url()
  if is_mainland() then
    if is_entire_url(uri) then
      return uri
    else
      return base_url .. "/" .. uri
    end
  elseif is_entire_url(uri) then
    do return replace_base_url, base_url end
    return replace_base_url, base_url, uri
  else
    return base_url .. "/" .. uri
  end
end

function M.get_icon_url(uri)
  local base_url = get_mainland_icon_base_url()
  if is_mainland() then
    if is_entire_url(uri) then
      return uri
    else
      return base_url .. "/" .. uri
    end
  else
    base_url = EU.get_dict_base_url()
    if is_entire_url(uri) then
      do return replace_base_url, base_url end
      return replace_base_url, base_url, uri
    else
      return base_url .. "/" .. uri
    end
  end
end

local RAVEN_REGION_ENUMS = {
  CN = "cn",
  HK = "hk",
  US = "us"
}
local debug_raven_url_template = "https://pre-r.lingxigames.com/{pageId}/index"
local raven_url_template_map = {
  [RAVEN_REGION_ENUMS.CN] = {
    lingxi = "https://game-notice.ejoy.com/{pageId}/index",
    hepin = "https://game-notice.hepinggames.com/{pageId}/index",
    putong = "https://game-notice.putonggames.com/{pageId}/index"
  },
  [RAVEN_REGION_ENUMS.HK] = {
    qookka = "https://game-notice.qookkagames.com/{pageId}/index",
    qooland_hk = "https://game-notice-hk.qoolandgames.com/{pageId}/index",
    sialia = "https://game-notice.sialiagamesinc.com.tw/{pageId}/index",
    vntth = "https://game-notice.vntth.com/{pageId}/index",
    mobijoy = "https://game-notice.mobijoygames.com/{pageId}/index"
  },
  [RAVEN_REGION_ENUMS.US] = {
    qooland_us = "https://game-notice.qoolandgames.com/{pageId}/index"
  }
}

function M.generate_raven_url(pageid_region_map)
  local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
  local ECC = require("ejoysdk_lua.ejoysdk_config_center")
  local EI = require("ejoysdk_lua.ejoysdk_init")
  local is_overseas = EGC.is_gangplank_config_enabled()
  local airline = E.get_pkg_info().airline
  local publish_area = E.get_pkg_info().publish_area
  E.LOG.debug(TAG, "generate_raven_url is_overseas: " .. tostring(is_overseas) .. ", airline: " .. tostring(airline) .. ", publish_area: " .. tostring(publish_area))
  local is_us_area = "us" == publish_area or "es" == publish_area or "pl" == publish_area
  local airline_key = airline
  local region
  if is_overseas then
    if is_us_area then
      region = RAVEN_REGION_ENUMS.US
      if "qooland" == airline then
        airline_key = airline .. "_us"
      end
    else
      region = RAVEN_REGION_ENUMS.HK
      if "qooland" == airline then
        airline_key = airline .. "_hk"
      end
    end
  else
    region = RAVEN_REGION_ENUMS.CN
  end
  E.LOG.debug(TAG, "generate_raven_url determined airline_key: " .. tostring(airline_key) .. ", region: " .. tostring(region))
  local raven_url_template = raven_url_template_map[region][airline_key]
  if not raven_url_template then
    if is_overseas then
      region = RAVEN_REGION_ENUMS.HK
      raven_url_template = raven_url_template_map[region].qookka
      E.LOG.warn(TAG, "generate_raven_url no matching airline_key, downgrade to qookka")
    else
      region = RAVEN_REGION_ENUMS.CN
      raven_url_template = raven_url_template_map[region].lingxi
      E.LOG.warn(TAG, "generate_raven_url no matching airline_key, downgrade to lingxi")
    end
  end
  local current_env = ECC.get_env()
  if current_env ~= EI.ENV.RELEASE then
    E.LOG.debug(TAG, "current_env is " .. tostring(current_env) .. ", using debug_raven_url_template")
    raven_url_template = debug_raven_url_template
  end
  E.LOG.debug(TAG, "generate_raven_url using raven_url_template: " .. tostring(raven_url_template) .. ", region: " .. tostring(region))
  local page_id = pageid_region_map[region]
  local raven_url = raven_url_template:gsub("{pageId}", tostring(page_id))
  E.LOG.debug(TAG, "generate_raven_url generated raven_url: " .. tostring(raven_url))
  return raven_url
end

function M.extract_hostname_from_url(url)
  if not url or type(url) ~= "string" then
    return nil
  end
  local hostname = string.match(url, "^%w+://([^/%?#:]+)")
  if hostname then
    do return string.match, hostname end
    return string.match, hostname, "^([^:]+)"
  end
  return hostname
end

return M

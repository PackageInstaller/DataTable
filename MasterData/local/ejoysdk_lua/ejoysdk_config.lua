local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local unpack = unpack or table.unpack
local EJOYSDK_CONFIG = {
  zone = "CN",
  default_lang = "CN",
  os = "ios",
  id = "https://id.ejoy.com",
  region = nil,
  http_dns = false
}
setmetatable(EJOYSDK_CONFIG, {
  __index = function(self, key)
    if "lang" == key then
      local LANG = require("ejoysdk_lua.ejoysdk_lang")
      local startup_lang = LANG.get_startup_lang()
      rawset(EJOYSDK_CONFIG, "lang", startup_lang)
      return startup_lang
    elseif "district" == key then
      local ejoy = require("ejoysdk_lua.ejoysdk")
      local country = ejoy.Sysinfo.country()
      rawset(EJOYSDK_CONFIG, "district", country)
      return country
    else
      return nil
    end
  end
})
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "config"
local M = {}
M.KEY = {
  REGION = "region",
  PUBLISH_AREA = "publish_area",
  SERVER_DOMAIN = "server_domain",
  LOCAL_GANGPLANK_REGION = "local_gangplank_region",
  LOCAL_GANGPLANK_URL_BASE = "local_gangplank_url_base",
  GLOBAL_GANGPLANK_ENABLED = "global_gangplank_enabled",
  MULTI_REGIONS_ENABLED = "multi_regions_enabled",
  APP_VERSION_UPDATE_CHECK = "app_version_update_check",
  APP_VERSION_UPDATE_CHECK_QZ = "app_version_update_check_qz",
  DOMAIN_ACCOUNT_CENTER = "domain_account_center",
  INIT_ARGS = " initialized_arguments",
  APP_REVIEW_VERSION = "app_review_version",
  WINDOWS_APP_VERSION_CODE = "windows_app_version_code",
  LINGXI_V2_SUPPORT = "lingxi_v2_support",
  CLOSE_SILENT_LOGIN_TIPS = "close_silent_login_tips"
}
M.RULE_KEY = {
  RULE_SERVICE = "service_splice_rule",
  RULE_REGION = "region_splice_rule"
}
M.URL_SERVICE_SPLICE_RULE = {
  RULE_DEFAULT = "rule_service_splice_in_domain",
  RULE_SERVICE_SPLICE_IN_PATH = "rule_service_splice_in_path",
  RULE_FULL_DOMAIN_SPLICE = "rule_service_splice_full_domain"
}
M.URL_REGION_SPLICE_RULE = {
  RULE_DEFAULT = "rule_region_splice_in_domain",
  RULE_NO_REGION = "rule_region_none"
}
M.DOMAIN_EJOY = ".ejoy.com"
M.DOMAIN_CONFIG = {
  USER_CENTER = "https://res.flysdk.cn"
}
local domain = M.DOMAIN_EJOY
local cdn_domain
local DEFAULT_URL_COMBINE_RULES = {
  [M.RULE_KEY.RULE_SERVICE] = M.URL_SERVICE_SPLICE_RULE.RULE_DEFAULT,
  [M.RULE_KEY.RULE_REGION] = M.URL_REGION_SPLICE_RULE.RULE_DEFAULT
}
local current_url_combine_rules = DEFAULT_URL_COMBINE_RULES

function M.set_domain(domain_name)
  if nil == domain_name or "" == domain_name then
    _ejoysdk.log(TAG .. "set_domain failed, domain is nil")
    return
  end
  domain = domain_name
  _ejoysdk.log(TAG .. "set_domain success: " .. domain)
end

function M.reset_domain()
  domain = M.DOMAIN_EJOY
  _ejoysdk.log(TAG .. "reset_domain success: " .. domain)
end

function M.reset_splice_rules()
  current_url_combine_rules = DEFAULT_URL_COMBINE_RULES
  _ejoysdk.log(TAG .. "reset_splice_rules success, service rule:" .. current_url_combine_rules[M.RULE_KEY.RULE_SERVICE] .. ", region rule:" .. current_url_combine_rules[M.RULE_KEY.RULE_REGION])
end

function M.set_splice_rules(splice_rules)
  if not splice_rules then
    return
  end
  local rules = {}
  rules.service_splice_rule = splice_rules.service_splice_rule or M.URL_SERVICE_SPLICE_RULE.RULE_DEFAULT
  rules.region_splice_rule = splice_rules.region_splice_rule or M.URL_REGION_SPLICE_RULE.RULE_DEFAULT
  current_url_combine_rules = rules
end

function M.get_splice_rules()
  return current_url_combine_rules
end

function M.get_domain()
  return domain
end

function M.set_cdn_domain(domain_name)
  cdn_domain = domain_name
end

local all_service_normal = {
  {"launcher", "https"},
  {"trace", "https"},
  {"gangplank", "https"},
  {"holo", "https"},
  {"cs", "https"},
  {"holo-cdn", "http"},
  {"friend", "https"},
  {"pusher", "https"},
  {
    "log-collector",
    "https"
  },
  {"search", "https"},
  {"user-info", "https"},
  {"ad-server", "https"},
  {"qabot", "https"},
  {"favor", "https"},
  {
    "game-adapter",
    "https"
  }
}
local all_service_backup = {
  {"launcher", "http"},
  {"trace", "http"},
  {"gangplank", "http"},
  {"holo", "http"},
  {"cs", "http"},
  {"holo-cdn", "http"},
  {"friend", "http"},
  {"pusher", "https"},
  {
    "log-collector",
    "http"
  },
  {"search", "http"},
  {"user-info", "http"},
  {"ad-server", "http"},
  {"qabot", "http"},
  {"favor", "https"},
  {
    "game-adapter",
    "http"
  }
}
M.PATH_MAPS_V1 = {
  gangplank = "gangplank",
  launcher = "launcher",
  ["user-info"] = "user_info",
  friend = "friend",
  ["chat-wsclient"] = "chat"
}
M.PATH_MAPS_V2 = {
  gangplank = "gangplank",
  launcher = "launcher",
  ["user-info"] = "user_info",
  friend = "friend",
  ["chat-wsclient"] = "chat",
  pusher = "pusher",
  holo = "holo",
  ["server-manager"] = "server_manager",
  ["game-adapter"] = "game_adapter",
  badge = "badge",
  bbs = "bbs",
  qabot = "qabot",
  stake = "stake",
  ["ad-server"] = "ad_server",
  safebox = "safebox",
  ["report-mailbox"] = "report_mailbox",
  trace = "trace",
  search = "search",
  vortex = "vortex",
  sns = "sns"
}
M.DISABLE_PATH_MAPS = {launcher_anns = "launcher"}
local path_service_match_map = {}
local all_service = all_service_normal

function M.set_service_backup()
  all_service = all_service_backup
end

local function url_base(scheme, prefix, service, _new_platform_domain)
  local result
  local use_old_platform_domain = false
  local service_splice_rule = current_url_combine_rules.service_splice_rule
  if M.DISABLE_PATH_MAPS[service] then
    service = M.DISABLE_PATH_MAPS[service]
    use_old_platform_domain = true
  end
  if service_splice_rule == M.URL_SERVICE_SPLICE_RULE.RULE_SERVICE_SPLICE_IN_PATH then
    result = scheme .. "://" .. prefix .. "-platform" .. domain .. "/" .. service
  elseif service_splice_rule == M.URL_SERVICE_SPLICE_RULE.RULE_FULL_DOMAIN_SPLICE then
    result = scheme .. "://" .. domain .. "/" .. service
  else
    result = scheme .. "://" .. prefix .. "-" .. service .. domain
  end
  local r_path = not use_old_platform_domain and M.get_rule_service_splice_in_path(service, _new_platform_domain)
  if r_path then
    result = scheme .. "://" .. prefix .. "-platform" .. domain .. "/" .. r_path
  end
  return result
end

local _service_splice_version = -1

function M.set_service_splice_version(_new_ss_verssion)
  if _service_splice_version ~= _new_ss_verssion then
    _service_splice_version = _new_ss_verssion
    if tonumber(_service_splice_version) >= 2 then
      path_service_match_map = M.PATH_MAPS_V2
    elseif 1 == tonumber(_service_splice_version) then
      path_service_match_map = M.PATH_MAPS_V1
    else
      path_service_match_map = {}
    end
    M.update_ejoysdk_service()
  end
end

function M.get_service_splice_version()
  return _service_splice_version
end

function M.get_rule_service_splice_in_path(_service, _new_platform_domain)
  if M.DISABLE_PATH_MAPS[_service] then
    return nil
  end
  local new_service = path_service_match_map and path_service_match_map[_service]
  if not new_service and _new_platform_domain then
    new_service = string.gsub(_service, "-", "_")
  end
  return new_service
end

function M.is_force_use_rule_service_splice_in_path(_service)
  local r_path = M.get_rule_service_splice_in_path(_service)
  if r_path then
    return true
  end
  return false
end

local function get_prefix_for_region(region)
  local product = EJOYSDK_CONFIG.product
  local prefix
  if "product" == EJOYSDK_CONFIG.env then
    prefix = product
  else
    prefix = tostring(EJOYSDK_CONFIG.env) .. tostring(product)
  end
  if region and current_url_combine_rules.region_splice_rule == M.URL_REGION_SPLICE_RULE.RULE_DEFAULT then
    prefix = tostring(prefix) .. "-" .. tostring(region)
  end
  return prefix
end

local function get_url_base(scheme, prefix, service, _new_platform_domain)
  local url = url_base(scheme, prefix, service, _new_platform_domain)
  url = url:lower()
  return url
end

function M.get_url_base_for_service(service)
  _ejoysdk.log(TAG .. "get_url_base_for_service, service:" .. tostring(service))
  if not service or "" == service then
    _ejoysdk.log(TAG .. "get_url_base_for_service failed, service is nil")
    return nil
  end
  local gangplank_region_prefix = get_prefix_for_region(EJOYSDK_CONFIG.region)
  local url = get_url_base("https", gangplank_region_prefix, service)
  _ejoysdk.log(TAG .. "get_url_base_for_service, service:" .. service .. ", url:" .. tostring(url))
  return url
end

function M.get_platform_base_url(service)
  if not service or "" == service then
    return nil
  end
  local gangplank_region_prefix = get_prefix_for_region(EJOYSDK_CONFIG.region)
  local r_path = path_service_match_map[service] or service
  local url = "https://" .. gangplank_region_prefix .. "-platform" .. domain .. "/" .. r_path
  url = url:lower()
  return url
end

function M.update_ejoysdk_service()
  local gangplank_region_prefix = get_prefix_for_region(EJOYSDK_CONFIG.region)
  for _, v in ipairs(all_service) do
    local service, scheme, _new_platform_domain = unpack(v)
    EJOYSDK_CONFIG[service] = get_url_base(scheme, gangplank_region_prefix, service, _new_platform_domain)
  end
end

local function update_local_gangplank_url(local_gangplank_region)
  if not local_gangplank_region then
    _ejoysdk.log(TAG .. "update_local_gangplank_url failed, region is nil!")
    return
  end
  for _, v in ipairs(all_service) do
    local service, scheme = unpack(v)
    if "gangplank" == service then
      local local_gangplank_region_prefix = get_prefix_for_region(local_gangplank_region)
      EJOYSDK_CONFIG[M.KEY.LOCAL_GANGPLANK_URL_BASE] = get_url_base(scheme, local_gangplank_region_prefix, service)
      break
    end
  end
end

local function init_server_domain()
  local ej = require("ejoysdk_lua.ejoysdk")
  local server_domain = M.get_config(M.KEY.SERVER_DOMAIN)
  if not server_domain or "" == server_domain then
    local meta = M.get_config("unisdk_meta") or {}
    server_domain = meta[ej.META_CONFIG_KEY.SERVER_DOMAIN]
    _ejoysdk.log("ejoysdk_config没有设置server_domain，开始从meta_config读取")
    if server_domain and "" ~= server_domain then
      _ejoysdk.log("meta_config有server_domain，更新ejoysdk_config server_domain:" .. server_domain)
      M.set_config(M.KEY.SERVER_DOMAIN, server_domain)
    end
  end
  if server_domain and "" ~= server_domain then
    if not ej.Utils.start_with(server_domain, ".") then
      _ejoysdk.log("server_domain_suffix server_domain doesnt have dot prefix, add one")
      server_domain = "." .. server_domain
    end
  else
    server_domain = M.DOMAIN_EJOY
  end
  M.set_domain(server_domain)
end

function M.autoconfig(env, product)
  if type(env) == "string" and type(product) == "string" then
    EJOYSDK_CONFIG.product = product
    EJOYSDK_CONFIG.env = env
  elseif type(env) == "table" and nil == product then
    local opt = env
    for k, v in pairs(opt) do
      EJOYSDK_CONFIG[k] = v
    end
  else
    assert(nil, "error config option")
  end
  local _UNI = require("ejoysdk_lua.vendors.unisdk")
  init_server_domain()
  M.set_service_splice_version(-1)
  M.update_ejoysdk_service()
  if cdn_domain then
    EJOYSDK_CONFIG["holo-cdn"] = "http://" .. cdn_domain
  end
  ET.publish(ET.config.CONFIG_CHANGED)
end

local function hook_config_value(key, value)
  if nil == value then
    return nil
  end
  if "lang" == key then
    do return value.lower end
    return value.lower, value
  end
  return value
end

function M.set_config(key, value)
  local old_value = EJOYSDK_CONFIG[key]
  value = hook_config_value(key, value)
  EJOYSDK_CONFIG[key] = value
  local data_changed = old_value ~= value
  if data_changed then
    _ejoysdk.log(TAG .. "set_config data changed, key:" .. (key or "nil"))
  end
  if data_changed then
    if "region" == key then
      M.update_ejoysdk_service()
    elseif key == M.KEY.LOCAL_GANGPLANK_REGION then
      update_local_gangplank_url(value)
    end
    ET.publish(ET.config.CONFIG_CHANGED .. "_" .. key, value)
    ET.publish(ET.config.CONFIG_CHANGED)
  end
end

function M.get_config(key)
  return EJOYSDK_CONFIG[key]
end

function M.get_vendor_config(name)
  local meta = M.get_config("unisdk_meta")
  local E = require("ejoysdk_lua.ejoysdk")
  E.LOG.debug(TAG, "get vendor config >> " .. tostring(name))
  E.LOG.debug(TAG, {meta_data = meta})
  if not meta or not meta.sdks then
    E.LOG.debug(TAG, "get vendor config >> meta is nil")
    return
  end
  for _, i in ipairs(meta.sdks) do
    if i.name == name then
      E.LOG.debug(TAG, "return config >> " .. tostring(name))
      E.LOG.debug(TAG, {
        meta_config = i.meta
      })
      return i.meta or i.meta_data
    end
  end
  E.LOG.debug(TAG, "get vendor config >> return nil")
end

function M.get_vendor_config_v2(name)
  if not name then
    return nil
  end
  local UNI = require("ejoysdk_lua.vendors.unisdk")
  local sdk_infos = UNI.get_sdk_infos()
  if not sdk_infos then
    return
  end
  if _ejoysdk.os() == "ios" then
    for _, i in pairs(sdk_infos) do
      if i.vendor and i.vendor:lower() == name:lower() then
        return i.meta
      end
    end
  elseif _ejoysdk.os() == "android" or _ejoysdk.os() == "windows" or _ejoysdk.os() == "harmonyos" then
    for _, i in pairs(sdk_infos) do
      if i.name and i.name:lower() == name:lower() then
        return i.meta
      end
    end
  end
end

function M.has_vendor_config(name)
  if not name then
    return nil
  end
  local UNI = require("ejoysdk_lua.vendors.unisdk")
  local sdk_infos = UNI.get_sdk_infos()
  if not sdk_infos then
    return false
  end
  local os_name = _ejoysdk.os()
  if "ios" == os_name then
    for sdk_name, i in pairs(sdk_infos) do
      if sdk_name == name or sdk_name:lower() == name:lower() then
        return true
      end
      if i.vendor then
        if i.vendor:lower() == name:lower() then
          return true
        end
      elseif i.name then
        if i.name:lower() == name:lower() then
          return true
        end
      elseif i.class and i.class:lower() == name:lower() then
        return true
      end
    end
  elseif "android" == os_name or "windows" == os_name or "harmonyos" == os_name or "weixin" == os_name or "douyin" == os_name then
    for _, i in pairs(sdk_infos) do
      if i.name and i.name:lower() == name:lower() then
        return true
      end
    end
  end
  return false
end

function M.register_service(service, _new_platform_domain)
  table.insert(all_service_normal, {
    service,
    "https",
    _new_platform_domain
  })
  table.insert(all_service_backup, {
    service,
    "http",
    _new_platform_domain
  })
  M.update_ejoysdk_service()
end

return M

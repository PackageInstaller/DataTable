local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
M.CONFIG_KEY = {
  KEY_PLATFORM_DOMAIN = "pf_domain",
  KEY_CHAT_CONFIG = "pf_chat",
  KEY_HOST = "host",
  KEY_WSS_HOST = "wss_host",
  KEY_CHAT_PORTS = "ports",
  KEY_AREA = "area",
  KEY_URL_SPLICE_RULES = "route-rule",
  KEY_RULE_APPEND_REGION = "append_region",
  KEY_RULE_APPEND_SERVICE = "service_rule"
}
M.CONFIG_VAL = {VAL_SERVICE_IN_DOMAIN = 0, VAL_SERVICE_IN_PATH = 1}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "gangplank_config"
local global_cdn_config, global_gangplank_config, current_publish_area

local function init_current_publish_area()
  local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  if not publish_area or "" == publish_area then
    publish_area = E.get_meta_config(E.CONFIG.KEY.PUBLISH_AREA)
    E.LOG.debug(TAG, "ejoysdk_config没有设置publish_area，开始从meta_config读取")
    if publish_area then
      E.LOG.debug(TAG, "meta_config有publish_area，更新ejoysdk_config publish_area:" .. publish_area)
      E.CONFIG.set_config(E.CONFIG.KEY.PUBLISH_AREA, publish_area)
    end
  end
  current_publish_area = publish_area
  E.LOG.debug(TAG, "init_current_publish_area: " .. (current_publish_area or "nil"))
end

local function check_gangplank_config_enabled()
  local global_gangplank_enabled = E.CONFIG.get_config(E.CONFIG.KEY.GLOBAL_GANGPLANK_ENABLED)
  local multi_regions_enabled = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  E.LOG.debug(TAG, "init_gangplank_url_with_region, global_gangplank_enabled:" .. tostring(global_gangplank_enabled) .. " ,multi_regions_enabled: " .. tostring(multi_regions_enabled))
  return global_gangplank_enabled or multi_regions_enabled
end

function M.is_gangplank_config_enabled()
  local gp_cfg_enabled = check_gangplank_config_enabled()
  E.LOG.debug(TAG, "is_gangplank_config_enabled:" .. tostring(gp_cfg_enabled))
  return gp_cfg_enabled
end

function M.get_base_url_for_service(service)
  if nil == service then
    E.LOG.debug(TAG, "get_base_url_for_service fail, service is nil")
    return nil
  end
  local product = E.CONFIG.get_config("product"):lower()
  local region = E.CONFIG.get_config("region")
  local splice_rules = E.CONFIG.get_splice_rules()
  local region_rule = splice_rules[E.CONFIG.RULE_KEY.RULE_REGION]
  if region and region_rule == E.CONFIG.URL_REGION_SPLICE_RULE.RULE_DEFAULT then
    region = "-" .. region:lower()
  else
    region = ""
  end
  local server_name = "https://" .. product .. region .. "-" .. service .. M.server_domain_suffix()
  return server_name
end

function M.server_domain_suffix()
  local server_domain = E.CONFIG.get_config(E.CONFIG.KEY.SERVER_DOMAIN)
  if not server_domain or "" == server_domain then
    server_domain = E.get_meta_config(E.META_CONFIG_KEY.SERVER_DOMAIN)
    E.LOG.debug(TAG, "ejoysdk_config没有设置server_domain，开始从meta_config读取")
    if server_domain then
      E.LOG.debug(TAG, "meta_config有server_domain，更新ejoysdk_config server_domain:" .. server_domain)
      E.CONFIG.set_config(E.CONFIG.KEY.SERVER_DOMAIN, server_domain)
    end
  end
  if server_domain and "" ~= server_domain then
    if not E.Utils.start_with(server_domain, ".") then
      E.LOG.warn(TAG, "server_domain_suffix server_domain doesnt have dot prefix, add one")
      server_domain = "." .. server_domain
    end
  else
    server_domain = E.CONFIG.DOMAIN_EJOY
  end
  return server_domain
end

local function gen_gangplank_config_url()
  local server_domain = M.server_domain_suffix()
  local product = E.CONFIG.get_config("product"):lower()
  local gangplank_config_url = "https://global-config" .. server_domain .. "/" .. product .. "/gangplank-config"
  local gangplank_bak_config_url = "https://global-config-bak" .. server_domain .. "/" .. product .. "/gangplank-config"
  E.LOG.debug(TAG, "get config server_domain:" .. (server_domain or "nil") .. ", and final url:" .. gangplank_config_url)
  return gangplank_config_url, gangplank_bak_config_url
end

local function real_request_gangplank_config(url, cb)
  E.LOG.debug(TAG .. "request_gangplank_config > url:" .. url)
  E.HTTP.get(url, {}, function(resp)
    E.LOG.debug(TAG .. "request_gangplank_config response >")
    E.log(resp)
    local status = resp.status
    local body = resp.body
    if 200 == status then
      E.LOG.debug(TAG, "request_gangplank_config resp:" .. body)
      local body_json = JSON.decode(body)
      E.log(body_json)
      global_cdn_config = body_json
      if body_json and body_json["gangplank-config"] then
        E.LOG.debug(TAG, "parse gangplank config body success!")
        cb(true, body_json["gangplank-config"])
      else
        E.LOG.error(TAG, "parse gangplank config body failed!")
        cb(false, status, "gangplank-config body parse failed")
      end
      ET.publish(ET.gangplank.GLOBAL_CDN_CONFIG_SUCC, body_json)
    else
      cb(false, status, body and body.message or "")
    end
  end)
end

local function request_gangplank_config(cb)
  local gangplank_config_url, gangplang_bak_config_url = gen_gangplank_config_url()
  real_request_gangplank_config(gangplank_config_url, function(succ, ...)
    if false == succ then
      real_request_gangplank_config(gangplang_bak_config_url, cb)
    else
      cb(succ, ...)
    end
  end)
end

function M.request_gangplank_config_for_unittest(cb)
  request_gangplank_config(cb)
end

local function check_local_area()
  local local_area = current_publish_area
  if local_area and "" ~= local_area then
    E.LOG.debug(TAG, "check_config_region current_publish_area NOT nil, use it as local area:" .. (local_area or "nil"))
    return local_area
  end
  local country = E.CONFIG.get_config("district")
  local_area = country and country:lower()
  E.LOG.debug(TAG, "check_config_region current_publish_area IS nil, now check device country setting:" .. (local_area or "nil"))
  if local_area and "" ~= local_area then
    return local_area
  end
  local_area = CONSTANTS.GLOBAL_GANGPLANK_CONSTANTS.DEFAULT_GANGPLANK_REGION
  local message = "could not find region, use default url:" .. local_area
  E.LOG.warn(TAG, "init_gangplank_url_with_region, " .. message)
  return local_area
end

local function check_region_for_local_area(local_area, gangplank_config_arr)
  local local_gangplank_region, default_gangplank_region
  for _, v in pairs(gangplank_config_arr) do
    if v.area and v.area == local_area then
      local_gangplank_region = v.region
      E.LOG.debug(TAG, "init_gangplank_url_with_region, finded local gangplank region:" .. (v.region or "nil"))
      break
    end
    if v.default then
      E.LOG.debug(TAG, "init_gangplank_url_with_region, find default gangplank region:" .. (v.region or "nil"))
      default_gangplank_region = v.region
    end
  end
  if nil == local_gangplank_region and default_gangplank_region then
    local_gangplank_region = default_gangplank_region
    E.LOG.debug(TAG, "init_gangplank_url_with_region, use default region:" .. default_gangplank_region)
  end
  if local_gangplank_region then
    E.LOG.debug(TAG, "set local gangplank region:" .. local_gangplank_region)
    E.CONFIG.set_config(E.CONFIG.KEY.LOCAL_GANGPLANK_REGION, local_gangplank_region)
  end
  return local_gangplank_region
end

local function check_config_region(gangplank_config_arr)
  local local_area = check_local_area()
  local local_gangplank_region = check_region_for_local_area(local_area, gangplank_config_arr)
  if local_gangplank_region and not E.CONFIG.get_config(E.CONFIG.KEY.REGION) then
    E.LOG.debug(TAG, "region not set, use local gangplank region instead:" .. local_gangplank_region)
    E.CONFIG.set_config(E.CONFIG.KEY.REGION, local_gangplank_region)
  end
  local global_gangplank_enabled = E.CONFIG.get_config(E.CONFIG.KEY.GLOBAL_GANGPLANK_ENABLED)
  if global_gangplank_enabled then
    E.LOG.debug(TAG, "global_gangplank_enabled is true, so need check local_gangplank_region")
    if local_gangplank_region then
      return true
    else
      local err_msg = "has no default url for region:" .. local_area
      E.LOG.error(TAG, "init_gangplank_url_with_region, " .. err_msg)
      return false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_URL_INVALID, err_msg
    end
  else
    E.LOG.debug(TAG, "global_gangplank_enabled is false, so NO need check local_gangplank_region, and return true")
    return true
  end
end

local function check_web_domain_whitelist()
  local current_config = M.get_current_cdn_config()
  if nil == current_config then
    E.LOG.debug(TAG, "check_web_domain_whitelist, current_config is nil, so skip")
    return
  end
  local domain_whitelist = current_config.domain_whitelist
  if domain_whitelist and type(domain_whitelist) == "table" then
    local WC = require("ejoysdk_lua.ejoysdk_web_config")
    for _, host in ipairs(domain_whitelist) do
      WC.add_injection_host(host)
    end
  end
end

local function check_platform_domain_rule_in_config()
  local current_config = M.get_current_cdn_config()
  if nil == current_config then
    E.LOG.debug(TAG, "check_init_platform_servers, current_config is nil, so skip set splice rule")
    return
  end
  local glocal_cdn_config = M.get_global_cdn_config()
  local rules_config = glocal_cdn_config[M.CONFIG_KEY.KEY_URL_SPLICE_RULES]
  local rules = {}
  E.LOG.debug(TAG, "begin check rule config >>")
  E.log(rules_config)
  if rules_config then
    local need_append_region = rules_config[M.CONFIG_KEY.KEY_RULE_APPEND_REGION]
    if need_append_region then
      E.LOG.debug(TAG, "rules_config is NOT nil, need_append_region is true")
      rules[E.CONFIG.RULE_KEY.RULE_REGION] = E.CONFIG.URL_REGION_SPLICE_RULE.RULE_DEFAULT
    else
      E.LOG.debug(TAG, "rules_config is NOT nil, need_append_region is false")
      rules[E.CONFIG.RULE_KEY.RULE_REGION] = E.CONFIG.URL_REGION_SPLICE_RULE.RULE_NO_REGION
    end
    local service_rule = rules_config[M.CONFIG_KEY.KEY_RULE_APPEND_SERVICE] or M.CONFIG_VAL.VAL_SERVICE_IN_DOMAIN
    if service_rule == M.CONFIG_VAL.VAL_SERVICE_IN_DOMAIN then
      E.LOG.debug(TAG, "rules_config is NOT nil, service_rule is VAL_SERVICE_IN_DOMAIN")
      rules[E.CONFIG.RULE_KEY.RULE_SERVICE] = E.CONFIG.URL_SERVICE_SPLICE_RULE.RULE_DEFAULT
    else
      E.LOG.debug(TAG, "rules_config is NOT nil, service_rule is RULE_SERVICE_SPLICE_IN_PATH")
      rules[E.CONFIG.RULE_KEY.RULE_SERVICE] = E.CONFIG.URL_SERVICE_SPLICE_RULE.RULE_SERVICE_SPLICE_IN_PATH
    end
  else
    E.LOG.debug(TAG, "rules_config is nil, service_rule and region rule is default")
    rules[E.CONFIG.RULE_KEY.RULE_REGION] = E.CONFIG.URL_REGION_SPLICE_RULE.RULE_DEFAULT
    rules[E.CONFIG.RULE_KEY.RULE_SERVICE] = E.CONFIG.URL_SERVICE_SPLICE_RULE.RULE_DEFAULT
  end
  local server_domain = M.server_domain_suffix()
  E.CONFIG.set_domain(server_domain)
  E.CONFIG.set_splice_rules(rules)
  E.CONFIG.update_ejoysdk_service()
  ET.publish(ET.config.CONFIG_CHANGED)
end

local requesting_gangplank_config_callbacks = {}

local function init_gangplank_config(cb)
  local server_domain = M.server_domain_suffix()
  E.CONFIG.set_domain(server_domain)
  E.LOG.debug(TAG, "init_gangplank_config, set server domain " .. tostring(server_domain))
  E.CONFIG.update_ejoysdk_service()
  if not check_gangplank_config_enabled() then
    E.LOG.debug(TAG, "init_gangplank_url_with_region, do not request gangplank from server and return success")
    cb(true)
    return
  end
  table.insert(requesting_gangplank_config_callbacks, cb)
  if #requesting_gangplank_config_callbacks > 1 then
    E.LOG.debug(TAG, "already requesting gangplank config, just add callback")
    return
  end
  E.LOG.debug(TAG, "init_gangplank_url_with_region, now begin check gangplank url")
  request_gangplank_config(function(succ, ...)
    local function callback_wrapper(...)
      for _, cb_item in ipairs(requesting_gangplank_config_callbacks) do
        cb_item(...)
      end
      requesting_gangplank_config_callbacks = {}
    end
    
    if succ then
      local config_arr = (...)
      if not config_arr then
        local err_msg = "request_gangplank_config response config arr is empty"
        E.LOG.error(TAG, "init_gangplank_url_with_region, err_msg:" .. err_msg)
        callback_wrapper(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_CONFIG_EMPTY, err_msg)
        return
      else
        E.LOG.debug(TAG, "request_gangplank_config success >>")
        E.log(config_arr)
        global_gangplank_config = config_arr
      end
      local ret, code, msg = check_config_region(config_arr)
      check_platform_domain_rule_in_config()
      check_web_domain_whitelist()
      callback_wrapper(ret, code, msg)
    else
      local status, message = ...
      E.LOG.error(TAG, "status:" .. (status or "nil") .. ", msg:" .. (message or "nil"))
      callback_wrapper(false, status, message)
    end
  end)
end

function M.init_config(cb)
  init_current_publish_area()
  init_gangplank_config(function(succ, ...)
    cb(succ, ...)
  end)
end

function M.check_init_cdn_config(cb)
  if not M.is_gangplank_config_enabled() then
    _ejoysdk.log("check_init_cdn_config not enable, skip")
    cb(true)
    return
  end
  local cdn_config = M.get_current_cdn_config()
  if nil ~= cdn_config then
    _ejoysdk.log("check_init_cdn_config already succ, directly return true")
    cb(true)
    return
  end
  _ejoysdk.log("check_init_cdn_config need check and begin")
  M.init_config(function(succ, ...)
    if succ then
      _ejoysdk.log("check_init_cdn_config succ")
      cb(true)
    else
      local code, msg = ...
      _ejoysdk.log(TAG .. "#check_init_cdn_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M.get_current_cdn_config()
  if not global_cdn_config then
    return nil
  end
  local gangplank_configs = M.get_global_gangplank_configs()
  if not gangplank_configs or 0 == #gangplank_configs then
    return nil
  end
  local region = E.CONFIG.get_config(E.CONFIG.KEY.REGION)
  local local_area = check_local_area()
  local select_region_gangplank_config, select_area_gangplank_config, default_gangplank_config
  for _, gangplank_config in pairs(gangplank_configs) do
    if gangplank_config.region and region and gangplank_config.region:lower() == region:lower() then
      select_region_gangplank_config = gangplank_config
    end
    if gangplank_config.area and local_area and gangplank_config.area:lower() == local_area:lower() then
      select_area_gangplank_config = gangplank_config
    end
    if gangplank_config.default then
      default_gangplank_config = gangplank_config
    end
  end
  if select_region_gangplank_config and not select_region_gangplank_config.default then
    E.LOG.debug(TAG, "get_current_cdn_config result>> select_region_gangplank_config, region:" .. (region or "nil"))
    return select_region_gangplank_config
  elseif select_area_gangplank_config then
    E.LOG.debug(TAG, "get_current_cdn_config result>> select_area_gangplank_config, local_area:" .. (local_area or "nil"))
    return select_area_gangplank_config
  else
    E.LOG.debug(TAG, "get_current_cdn_config result>> default_gangplank_config, local_area:" .. (local_area or "nil") .. ", region:" .. (region or "nil"))
    return default_gangplank_config
  end
end

function M.get_current_chat_config()
  local cdn_config = M.get_current_cdn_config()
  if nil == cdn_config then
    E.LOG.warn(TAG, "get_current_chat_config failed, current cdn config is nil")
    return nil
  end
  return cdn_config[M.CONFIG_KEY.KEY_CHAT_CONFIG]
end

function M.get_global_cdn_config()
  return global_cdn_config
end

function M.get_global_gangplank_configs()
  return global_gangplank_config
end

function M.current_publish_area()
  return current_publish_area
end

local function check_item_result(check_result, check_item, expect_value, current_value)
  if expect_value == current_value then
    check_result[check_item] = {
      result = true,
      msg = "expect:" .. tostring(expect_value) .. ", now:" .. tostring(current_value)
    }
  else
    check_result[check_item] = {
      result = false,
      msg = "expect:" .. tostring(expect_value) .. ", now:" .. tostring(current_value)
    }
  end
end

function M.test_config(global_cdn_config_str, expect_result)
  E.CONFIG.set_config(E.CONFIG.KEY.REGION, nil)
  E.CONFIG.set_config(E.CONFIG.KEY.LOCAL_GANGPLANK_REGION, nil)
  local body_json = JSON.decode(global_cdn_config_str)
  global_cdn_config = body_json
  global_gangplank_config = body_json["gangplank-config"]
  init_current_publish_area()
  check_config_region(global_gangplank_config)
  check_platform_domain_rule_in_config()
  local region = E.CONFIG.get_config(E.CONFIG.KEY.REGION)
  local local_region = E.CONFIG.get_config(E.CONFIG.KEY.LOCAL_GANGPLANK_REGION)
  local local_area = check_local_area()
  local current_domain = E.CONFIG.get_domain()
  local current_url_rules = E.CONFIG.get_splice_rules()
  local result = {}
  check_item_result(result, "region", expect_result.region, region)
  check_item_result(result, "publish_area", expect_result.publish_area, current_publish_area)
  check_item_result(result, "local_region", expect_result.local_region, local_region)
  check_item_result(result, "local_area", expect_result.local_area, local_area)
  check_item_result(result, "current_domain", expect_result.current_domain, current_domain)
  check_item_result(result, "service_rule", expect_result.service_rule, current_url_rules[E.CONFIG.RULE_KEY.RULE_SERVICE])
  check_item_result(result, "region_rule", expect_result.region_rule, current_url_rules[E.CONFIG.RULE_KEY.RULE_REGION])
  E.LOG.debug(TAG, "test_config result >>")
  E.log(result)
end

return M

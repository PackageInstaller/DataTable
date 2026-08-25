local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_init"
local M = {}
M.GANGPLANK = "ejoysdk_lua.ejoysdk_gangplank"
M.HOLO = "ejoysdk_lua.ejoysdk_holo"
M.LAUNCHER = "ejoysdk_lua.ejoysdk_launcher"
M.FRIEND = "ejoysdk_lua.friend.ejoysdk_friend"
M.FAVOR = "ejoysdk_lua.friend.ejoysdk_favor"
M.CHAT = "ejoysdk_lua.chat.ejoysdk_chat"
M.ACCOUNT_CHAT = "ejoysdk_lua.chat.ejoysdk_chat_account"
M.PUSH = "ejoysdk_lua.push.ejoysdk_push"
M.BLOCK = "ejoysdk_lua.block.ejoysdk_block"
M.AGE = "ejoysdk_lua.age_mark.age_mark"
M.SUBSCRIBE_GANGPLANK_INITSTART = ET.gangplank.INITSTART
M.SUBSCRIBE_GANGPLANK_INITED = ET.gangplank.INITED
M.SUBSCRIBE_HOLO_INITED = ET.holo.INITED
M.SUBSCRIBE_LAUNCHER_INITED = ET.launcher.INITED
M.SUBSCRIBE_ANNOUNCEMENT_INITED = ET.announcement.INITED
M.SUBSCRIBE_FRIEND_INITED = ET.friend.INITED
M.SUBSCRIBE_FAVOR_INITED = ET.favor.INITED
M.SUBSCRIBE_CHAT_INITED = ET.chat.INITED
M.SUBSCRIBE_PUSH_INITED = ET.push.INITED
M.SUBSCRIBE_BLOCK_INITED = ET.block.INITED
M.SUBSCRIBE_EJOYSDK_CONFIG_CHANGED = ET.config.CONFIG_CHANGED
M.SUBSCRIBE_AGE_INITED = ET.age.INITED
M.SUBSCRIBE_DY_TICKET_PUSH = ET.tiktok.TICKET_PUSH
local ejoy_modules = {
  gangplank = "ejoysdk_lua.ejoysdk_gangplank",
  holo = "ejoysdk_lua.ejoysdk_holo",
  launcher = "ejoysdk_lua.ejoysdk_launcher",
  friend = "ejoysdk_lua.friend.ejoysdk_friend",
  favor = "ejoysdk_lua.friend.ejoysdk_favor",
  chat = "ejoysdk_lua.chat.ejoysdk_chat",
  account_chat = "ejoysdk_lua.chat.ejoysdk_chat_account",
  push = "ejoysdk_lua.push.ejoysdk_push",
  block = "ejoysdk_lua.block.ejoysdk_block",
  age = "ejoysdk_lua.age_mark.age_mark",
  announement = "ejoysdk_lua.ejoysdk_anns"
}
local ex_modules = {
  gangplank = "ejoysdk_lua.server_api.gangplank_ex"
}
local module_params = {}
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.subscribe = ET.subscribe
local l_env = M.ENV.RELEASE
local public_product_code
for module_name, path in pairs(ejoy_modules) do
  M[module_name] = function(...)
    module_params[module_name] = {
      module = require(path),
      params = {
        ...
      }
    }
    return M
  end
end

local function inject_module_ex_function()
  for module_name, ex_path in pairs(ex_modules) do
    if module_params[module_name] then
      local module = module_params[module_name].module
      local module_ex = require(ex_path)
      for key, value in pairs(module_ex) do
        if type(value) == "function" then
          if module[key] then
            _ejoysdk.log(TAG .. "#Conflict function!Module: " .. tostring(module_name) .. " ,function: " .. tostring(key))
          else
            _ejoysdk.log(TAG .. "#inject module: " .. tostring(module_name) .. " ,function: " .. tostring(key))
            module[key] = value
          end
        end
      end
    end
  end
end

local function is_empty(str)
  return not str or "" == str or type(str) ~= "string"
end

local function setupEnv(env)
  env = env or M.ENV.RELEASE
  l_env = env
  local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
  DSP.set_env(env)
end

local function prefer_config(...)
  for _, v in pairs({
    ...
  }) do
    if nil ~= v then
      return v
    end
  end
  return nil
end

function M.env()
  return l_env or M.ENV.RELEASE
end

local function init_jf(debuggable)
  _ejoysdk.log("init_jf entered")
  local jf = require("ejoysdk_lua.vendors.jf")
  jf.init({debug = debuggable}, function()
    _ejoysdk.log("ejoysdk_init check jf init succ")
  end)
end

function M.config(platform, params)
  params = params or {}
  local E = require("ejoysdk_lua.ejoysdk")
  if E.Sysinfo.os() == "windows" then
    local pc_ad_token = params.pc_ad_token
    E.set_pc_ad_token(pc_ad_token)
  end
  local _unisdk = require("ejoysdk_lua.vendors.unisdk")
  local meta_data = E.CONFIG.get_config("unisdk_meta")
  local product_code = prefer_config(platform, params.server_env, params.product_code, meta_data[E.META_CONFIG_KEY.PRODUCT_CODE]) or ""
  public_product_code = product_code
  E.CONFIG.autoconfig("", product_code)
  local region = params.region or ""
  local open_log = params.open_log or false
  local env = params.env or "release"
  local lang = params.lang
  local district = params.district
  local gameid = params.game_id
  local open_app_version_update_check = params.open_app_version_update_check or false
  local open_qz_app_version_update_check = params.open_qz_app_version_update_check or false
  local app_review_version = prefer_config(params.app_review_version, meta_data[E.META_CONFIG_KEY.APP_REVIEW_VERSION])
  local disable_windows_embed_webview = params.disable_embed_webview or false
  local windows_app_version_code = prefer_config(params.windows_app_version_code, meta_data[E.META_CONFIG_KEY.APP_VERSION_CODE])
  E.CONFIG.set_config(E.CONFIG.KEY.WINDOWS_APP_VERSION_CODE, windows_app_version_code)
  E.CONFIG.set_config(E.CONFIG.KEY.APP_VERSION_UPDATE_CHECK, open_app_version_update_check)
  E.CONFIG.set_config(E.CONFIG.KEY.APP_VERSION_UPDATE_CHECK_QZ, open_qz_app_version_update_check)
  E.CONFIG.set_config(E.CONFIG.KEY.APP_REVIEW_VERSION, app_review_version)
  E.disable_embed_webview(disable_windows_embed_webview)
  E.open_log(open_log)
  setupEnv(env)
  E.LOG.debug(TAG, {config_params = params})
  E.LOG.debug(TAG, "init server_env: " .. product_code .. ", review_ver:" .. tostring(app_review_version) .. ", disable_windows_embed_webview:" .. tostring(disable_windows_embed_webview))
  if not is_empty(region) then
    E.LOG.debug(TAG, "init game region: " .. region)
    E.CONFIG.set_config(E.CONFIG.KEY.REGION, region)
  end
  local overseas = prefer_config(params.overseas, meta_data[E.META_CONFIG_KEY.OVERSEAS]) or false
  if 1 == overseas or true == overseas then
    E.LOG.debug(TAG, "init overseas")
    E.CONFIG.set_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED, true)
    local publish_area = prefer_config(params.publish_area, meta_data[E.META_CONFIG_KEY.PUBLISH_AREA]) or ""
    E.LOG.debug(TAG, "init publish area: " .. publish_area)
    E.CONFIG.set_config(E.CONFIG.KEY.PUBLISH_AREA, publish_area)
    meta_data[E.META_CONFIG_KEY.PUBLISH_AREA] = publish_area
    local server_domain = prefer_config(params.server_domain, meta_data[E.META_CONFIG_KEY.SERVER_DOMAIN]) or ""
    E.LOG.debug(TAG, "init server domain: " .. server_domain)
    E.CONFIG.set_config(E.CONFIG.KEY.SERVER_DOMAIN, server_domain or "")
    meta_data[E.META_CONFIG_KEY.SERVER_DOMAIN] = server_domain
  end
  lang = prefer_config(lang, meta_data[E.META_CONFIG_KEY.GAME_LANG]) or ""
  if not is_empty(lang) then
    E.LOG.debug(TAG, "init game language : " .. lang)
    E.CONFIG.set_config("lang", lang)
  end
  district = prefer_config(district, meta_data[E.META_CONFIG_KEY.DISTRICT]) or ""
  if not is_empty(district) then
    E.LOG.debug(TAG, "init game district: " .. district)
    E.CONFIG.set_config("district", district)
  end
  if gameid and "" ~= gameid then
    meta_data[E.META_CONFIG_KEY.GAME_ID] = gameid
  end
  local ELF = require("ejoysdk_lua.ejoysdk_log_file")
  ELF.init()
  init_jf(open_log)
  local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
  if not gangplank.is_inited() then
    E.LOG.debug(TAG, "is not inited, dismiss loading")
    E.Loading.dismiss()
  end
end

function M.init()
  local ELF = require("ejoysdk_lua.ejoysdk_log_file")
  ELF.init()
  local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
  QL.init()
  inject_module_ex_function()
  local unpack = unpack or table.unpack
  for _module_name, module_param in pairs(module_params) do
    local module = module_param.module
    if module.init then
      module.init(unpack(module_param.params))
    end
  end
end

function M.is_module_registered(moudle_name)
  return module_params[moudle_name] and true or false
end

function M.get_public_product_code()
  return public_product_code
end

return M

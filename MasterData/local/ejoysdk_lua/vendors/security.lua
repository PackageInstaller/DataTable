local E = require("ejoysdk_lua.ejoysdk")
local ok, OUT_SE = pcall(require, "security_lua.game_security")
if ok and OUT_SE then
  return OUT_SE
end
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_config")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CHANNEL = "SECURITY"
local TAG = EM.MODULE.VENDORS.SECURITY
local M = Vendor:Inherit(CHANNEL)
local CAST_UPDATE_DATA = "CAST_UPDATE_DATA"
local CAST_INIT_DATA = "CAST_SECURITY_INIT_DATA"
local CAST_UPDATE_VANGUARD_CONFIG = "CAST_UPDATE_VANGUARD_CONFIG"
local IS_SUPPORT_GET_PRIVACY_INFO = "IS_SUPPORT_GET_PRIVACY_INFO"
local ASYNC_GET_PRIVACY_INFO = "ASYNC_GET_PRIVACY_INFO"
local cached_security_privacy_info = {}

local function update_data(params)
  UNI.cast(CHANNEL, CAST_UPDATE_DATA, params)
end

local function get_extra_params(_ext_params)
  local ext_params = _ext_params or {}
  local params = {
    publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA),
    region = E.CONFIG.get_config(E.CONFIG.KEY.REGION),
    accountId = ext_params.accountId or "",
    roleId = ext_params.roleId or "",
    gid = E.get_game_id(),
    serverId = ext_params.serverId or "",
    product = E.CONFIG.get_config("product"),
    sysTime = os.time() * 1000
  }
  local pkg_info = E.get_pkg_info()
  if pkg_info then
    params.ch = pkg_info.ds_channel_id or ""
    params.subCh = pkg_info.ds_sub_channel_id or ""
  end
  return params
end

local function login_handler(user_info)
  local params = {
    uid = user_info.uid,
    serverid = user_info.server,
    extra_params = get_extra_params({
      accountId = user_info.uid,
      roleId = "",
      serverId = ""
    })
  }
  E.LOG.debug(TAG, "login，update security data")
  update_data(params)
  local os = E.Sysinfo.os()
  if "windows" == os then
    M.update_umid_token()
  else
    E.LOG.debug(TAG, "login succ, now refresh security info ")
    M.init_privacy_info()
  end
end

local function acquire_succ_handler()
  local os = E.Sysinfo.os()
  if "windows" == os then
    M.update_umid_token()
  else
    E.LOG.debug(TAG, "acquire succ, now refresh security info ")
    M.init_privacy_info()
  end
end

local function set_player_info_handler(player_info)
  E.LOG.debug(TAG, "set_player_info_handler, params >>")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local user_info = EG.user_info() or {}
  local params = {
    extra_params = get_extra_params({
      roleId = player_info and player_info.player_id or "",
      accountId = user_info.uid or "",
      serverId = player_info.server_id or ""
    })
  }
  E.LOG.debug(TAG, params)
  update_data(params)
  E.LOG.debug(TAG, "set_player_info_handler, now refresh security info ")
end

local function player_offline_handler()
  E.LOG.debug(TAG, "player_offline_handler")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local user_info = EG.user_info() or {}
  local params = {
    extra_params = get_extra_params({
      roleId = "",
      accountId = user_info.uid or "",
      serverId = ""
    })
  }
  update_data(params)
  E.LOG.debug(TAG, "player_offline_handler, now refresh security info ")
end

function M.test_update_data(params)
  update_data(params)
end

local function gangplank_logout_handler()
  local params = {
    uid = "",
    extra_params = get_extra_params({})
  }
  E.LOG.debug(TAG, "logout，update security data")
  update_data(params)
end

local function gangplank_exit_handler()
  local params = {uid = ""}
  E.LOG.debug(TAG, "exit，update security data")
  update_data(params)
end

local function cast_update_vanguard_config(global_config)
  if global_config and global_config["vanguard-config"] then
    UNI.cast(CHANNEL, CAST_UPDATE_VANGUARD_CONFIG, global_config["vanguard-config"])
    E.LOG.debug(TAG, "cast_update_vanguard_config vanguard-config >>")
    E.LOG.debug(TAG, global_config["vanguard-config"])
  end
end

local function global_config_handler(global_config)
  ET.unsubscribe(ET.gangplank.GLOBAL_CDN_CONFIG_SUCC, global_config_handler)
  cast_update_vanguard_config(global_config)
end

local function region_config_change_handle(new_region)
  local params = {region = new_region}
  E.LOG.debug(TAG, "security update region: " .. tostring(new_region))
  update_data(params)
end

local function get_umid_token()
  local umid_token
  local os = E.Sysinfo.os()
  if "windows" == os then
    if _ejoysdk.sysinfo then
      local sysinfo = _ejoysdk.sysinfo() or {}
      umid_token = sysinfo.security_token
    end
  elseif cached_security_privacy_info then
    umid_token = cached_security_privacy_info["x-umt"]
  end
  E.LOG.debug(TAG, "umid_token:" .. tostring(umid_token))
  return umid_token
end

function M.update_umid_token()
  local umid_token = get_umid_token()
  if umid_token then
    local user_info_manager = require("ejoysdk_lua.user_info_manager")
    user_info_manager.set_umid_token(umid_token)
  else
    E.LOG.debug(TAG, "umid token is nil, skip update")
  end
end

function M.init_privacy_info()
  E.LOG.debug(TAG, "init_privacy_info begin, is support result >>")
  local result_data, is_support
  if E.Sysinfo.os() ~= "harmonyos" then
    result_data = UNI.sync_call(CHANNEL, IS_SUPPORT_GET_PRIVACY_INFO, {})
  end
  E.LOG.debug(TAG, result_data)
  if nil == result_data then
    is_support = false
  else
    is_support = result_data.value
  end
  if not is_support then
    E.LOG.debug(TAG, "init_privacy_info skip, not support")
    return
  else
    E.LOG.debug(TAG, "init_privacy_info support, now get privacy info")
  end
  UNI.async_call(CHANNEL, ASYNC_GET_PRIVACY_INFO, {}, nil, function(succ, ...)
    if succ then
      local data = (...)
      cached_security_privacy_info = data or {}
      E.LOG.debug(TAG, "init_privacy_info succ >>")
      E.LOG.debug(TAG, cached_security_privacy_info)
      local user_info_manager = require("ejoysdk_lua.user_info_manager")
      user_info_manager.set_security_privacy_info(cached_security_privacy_info)
      M.update_umid_token()
    else
      local code = (...)
      E.LOG.warn(TAG, "init_privacy_info failed, code:" .. tostring(code))
    end
  end)
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "security stat start init!")
  local init_params = {
    game_version = E.CONFIG.get_config("game_version") or "",
    region = E.CONFIG.get_config("region"),
    gameid = E.get_game_id(),
    product = E.CONFIG.get_config("product"),
    extra_params = get_extra_params({})
  }
  local os = E.Sysinfo.os()
  if "windows" == os and opt and opt.open_check and not EC.has_vendor_config("SECURITY") then
    ESTAT.stat_action("umid_sdkconfig_miss_security", "umid_err", false, nil)
  end
  UNI.cast(CHANNEL, CAST_INIT_DATA, init_params)
  E.LOG.debug(TAG, "init params >>")
  E.LOG.debug(TAG, init_params)
  local global_config = EGC.get_global_cdn_config()
  if global_config then
    cast_update_vanguard_config(global_config)
  else
    ET.subscribe(ET.gangplank.GLOBAL_CDN_CONFIG_SUCC, global_config_handler)
  end
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ_handler)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. "region", region_config_change_handle)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, set_player_info_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  M.init_privacy_info()
  M.update_umid_token()
  cb(true)
end

return M

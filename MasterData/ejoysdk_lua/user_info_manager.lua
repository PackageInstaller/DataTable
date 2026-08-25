local V = require("ejoysdk_lua.version")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local AC
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "user_info_mgr"
local user_pkg_info, local_pkg_info, user_aegis_info
local local_cloud_info = {}
local predownload_run_mode_info = {}
local pref_cloud_info
local local_instant_info = {}
local outside_override_trace_id, ab_type
local security_info = {}
local pc_sysinfo_mw, umid_token
local channel_cloud_game_tag = false
local local_ua_cache_data
local M = {}
M.AB_TYPE = {A = "A", B = "B"}
M.PKG_INFO_KEY = {
  KEY_CLOUD_GAME_MODE = "cloud_game_mode",
  KEY_CLOUD_GAME_RUN_MODE = "cloud_game_runmode",
  KEY_INSTANT_MODE = "instant_mode",
  KEY_INSTALL_REFERRER = "install_referrer",
  KEY_AB_TEST_TYPE = "ab_type",
  KEY_CHANNEL_CLOUD_GAME_TAG = "channel_cloud_game",
  KEY_SDK_PLUGIN_VERSIONS = "sdk_plugin_versions",
  KEY_PREDOWNLOAD_GAME_RUN_MODE = "cloud_game_runmode",
  KEY_PKG_GAME_RUN_MODE_TYPE = "pkg_game_runmode"
}
M.INSTANT_INFO_KEY = {
  KEY_INSTANT_MODE = "key_instant_mode",
  KEY_INSTALL_REFERRER = "key_install_referrer"
}
M.INFO_KEY = {
  KEY_PKG_INFO = "pkg_info",
  KEY_AEGIS_INFO = "aegis_info",
  KEY_TRACE_ID = "trace_id",
  KEY_CLOUD_GAME_INFO = "cloud_game_info",
  KEY_RUNMODE_INFO = "runmode_info"
}
M.TOPIC = {
  TOPIC_INFO_CHANGES = "topic_user_info_data_changes",
  TOPIC_MOBILE_RUN_MODE_CHANGES = "topic_mobile_runmode_changes"
}
M.TOPIC_DATA_KEY = {KEY_DATA_TYPE = "data_type", KEY_DATA = "data"}
M.CAN_UPDATE_INFO_KEY = {
  "utdid",
  "ip",
  "ua",
  "oaid",
  "android_id",
  "idfa",
  "caid",
  "imei"
}

local function can_update_key(key)
  local result = false
  if not key then
    return result
  end
  for _, v in ipairs(M.CAN_UPDATE_INFO_KEY) do
    if key == v then
      result = true
    end
  end
  return result
end

local function get_meta_config(key)
  local CONFIG = require("ejoysdk_lua.ejoysdk_config")
  local meta_data = CONFIG.get_config("unisdk_meta")
  local value = meta_data[key]
  return value
end

local function generate_trace_id(utdid)
  return utdid .. "-" .. tostring(os.time())
end

local function _get_local_pkg_info_data()
  local ejoy = require("ejoysdk_lua.ejoysdk")
  if not local_pkg_info then
    _ejoysdk.log("local_pkg_info is nil, now init it")
    local_pkg_info = {}
    local_pkg_info.dev_id = ejoy.Sysinfo.idfa()
    local_pkg_info.utdid = ejoy.Sysinfo.utdid()
    local_pkg_info.uuid = ejoy.Sysinfo.uuid()
    local_pkg_info.brand = ejoy.Sysinfo.brand()
    local_pkg_info.model = ejoy.Sysinfo.model()
    local_pkg_info.time_zone = ejoy.Sysinfo.time_zone()
    local_pkg_info.country = ejoy.CONFIG.get_config("district")
    local_pkg_info.language = ejoy.Sysinfo.language()
    local_pkg_info.lang_script = ejoy.Sysinfo.language_and_script()
    local meta_data = ejoy.CONFIG.get_config("unisdk_meta")
    local_pkg_info.game_id = meta_data.game_id
    local_pkg_info.tag = meta_data.tag
    local_pkg_info.publish_area = meta_data.publish_area
    local_pkg_info.ptid = meta_data.ptid or ""
    local mobile_info = ejoy.Sysinfo.mobile_info()
    if mobile_info then
      local_pkg_info.mcc = mobile_info.mcc or ""
      local_pkg_info.mnc = mobile_info.mnc or ""
    end
    local_pkg_info.is_vpn = ejoy.Sysinfo.is_vpn_connected()
    local_pkg_info.versions = {
      os_version = ejoy.Sysinfo.os_version(),
      lua_version = V.LUA_VERSION,
      game_version = ejoy.CONFIG.get_config("game_version") or "",
      ejoysdk_version = ejoy.get_sdk_version_name("EJOYSDK") or "",
      aligames_version = ejoy.get_sdk_version_name("ALIGAMES") or "",
      fc_version = ejoy.get_sdk_version_name("FACEVERIFY") or "",
      app_version_code = ejoy.Sysinfo.app_version_code(),
      app_version_name = ejoy.Sysinfo.app_version_name(),
      app_review_version = tostring(ejoy.CONFIG.get_config(ejoy.CONFIG.KEY.APP_REVIEW_VERSION) or "")
    }
    local os = ejoy.Sysinfo.os()
    local_pkg_info.os = os
    local_pkg_info.channel_id = ejoy.get_channel()
    local_pkg_info.deviceType = ejoy.Sysinfo.get_device_type()
    if "android" == os then
      local_pkg_info.pkg_name = ejoy.Sysinfo.package_name()
      local_pkg_info.gaid = ejoy.Sysinfo.gaid()
      local_pkg_info.oaid = ejoy.Sysinfo.oaid()
      local imei = ejoy.Sysinfo.device_id()
      local_pkg_info.imei = imei
      local_pkg_info.device_android_id = ejoy.Sysinfo.device_with_android_id()
      local_pkg_info.android_id = ejoy.Sysinfo.android_id()
      local_pkg_info.ds_channel_id = ejoy.Sysinfo.ds_channel_id()
      local_pkg_info.ds_sub_channel_id = ejoy.Sysinfo.ds_sub_channel_id()
      local_pkg_info.is_simulator = ejoy.Sysinfo.is_simulator()
      local_pkg_info.screen_width = ejoy.Sysinfo.screen_width()
      local_pkg_info.screen_height = ejoy.Sysinfo.screen_height()
      local_pkg_info.apk_build_seq = meta_data.apk_build_seq or ""
      local pkg_type = ejoy.Sysinfo.package_type()
      if -1 ~= pkg_type then
        local_pkg_info.package_type = pkg_type
      end
    elseif "ios" == os then
      local_pkg_info.pkg_name = ejoy.Sysinfo.package_name()
      local_pkg_info.idfa = ejoy.Sysinfo.idfa()
      local_pkg_info.idfv = ejoy.Sysinfo.idfv()
      local_pkg_info.sysinfo_ejoy_ext_info = ejoy.Sysinfo.sysinfo_ejoy_ext_info()
      local_pkg_info.ds_channel_id = ejoy.Sysinfo.ds_channel_id()
      local_pkg_info.hw_machine = ejoy.Sysinfo.hw_machine()
    elseif "windows" == os then
      local package_name = get_meta_config("package_name")
      local_pkg_info.pkg_name = package_name
      local_pkg_info.ds_channel_id = local_pkg_info.channel_id
      local_pkg_info.ds_sub_channel_id = ejoy.Sysinfo.ds_sub_channel_id()
      local_pkg_info.pc_ad_token = ejoy.get_pc_ad_token()
    elseif "harmonyos" == os then
      local_pkg_info.pkg_name = ejoy.Sysinfo.package_name()
      local_pkg_info.ds_channel_id = ejoy.Sysinfo.ds_channel_id()
      local_pkg_info.oaid = ejoy.Sysinfo.oaid()
    elseif "weixin" == os or "douyin" == os then
      local_pkg_info.ds_channel_id = ejoy.Sysinfo.ds_channel_id()
      local_pkg_info.pkg_name = ejoy.Sysinfo.package_name()
      local_pkg_info.system = ejoy.Sysinfo.get_device_system()
    end
    if ejoy.is_scan_pkg() then
      local_pkg_info.is_scan_pkg = 1
    end
    local user_center = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
    local_pkg_info.si = user_center.get_si()
  elseif not local_pkg_info.channel_id or "" == local_pkg_info.channel_id then
    local_pkg_info.channel_id = ejoy.get_channel()
    _ejoysdk.log(TAG .. "local_pkg_info is not nil, and channel_id is empty string, so need to refresh local_pkg_info.channel_id, channel_id = " .. tostring(local_pkg_info.channel_id))
  end
  if not local_ua_cache_data then
    local_ua_cache_data = ejoy.Sysinfo.get_user_agent()
  end
  local_pkg_info.ua = local_ua_cache_data
  local_pkg_info.product_code = ejoy.CONFIG.get_config("product")
  local_pkg_info.game_lang = ejoy.CONFIG.get_config("lang") or ""
  local_pkg_info.umid_token = umid_token
  if not local_pkg_info.utdid or local_pkg_info.utdid == "" then
    local_pkg_info.utdid = ejoy.Sysinfo.utdid()
  end
  if ejoy.Sysinfo.os() == "harmonyos" and (not local_pkg_info.oaid or "" == local_pkg_info.oaid) then
    local_pkg_info.oaid = ejoy.Sysinfo.oaid()
  end
  if outside_override_trace_id and "" ~= outside_override_trace_id then
    local_pkg_info.sdk_trace_id = outside_override_trace_id
  elseif (local_pkg_info.sdk_trace_id == nil or "" == local_pkg_info.sdk_trace_id) and local_pkg_info.utdid ~= nil and local_pkg_info.utdid ~= "" then
    local_pkg_info.sdk_trace_id = generate_trace_id(local_pkg_info.utdid)
  end
  if ab_type and "" ~= ab_type then
    local_pkg_info[M.PKG_INFO_KEY.KEY_AB_TEST_TYPE] = ab_type
  end
  local game_version = ejoy.CONFIG.get_config("game_version") or ""
  local_pkg_info.versions.game_version = game_version
  local app_review_version = tostring(ejoy.CONFIG.get_config(ejoy.CONFIG.KEY.APP_REVIEW_VERSION) or "")
  local_pkg_info.versions.app_review_version = app_review_version
  local_pkg_info.region = ejoy.CONFIG.get_config("region")
  return local_pkg_info
end

function M.get_device_info_async(cb)
  _ejoysdk.log(TAG .. "get_pkg_info_async begin")
  local data = {}
  data[M.INFO_KEY.KEY_PKG_INFO] = M.get_pkg_info()
  data[M.INFO_KEY.KEY_AEGIS_INFO] = M.get_aegis_info()
  data[M.INFO_KEY.KEY_TRACE_ID] = M.get_pkg_info().sdk_trace_id
  cb(data)
  local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
  ESTAT.stat_action("mini_client_receive_device_info_sync", "", true)
end

local function _get_pkg_info()
  if user_pkg_info then
    _ejoysdk.log(TAG .. "get_pkg_info user_pkg_info not nil return current_pkg_info")
    return user_pkg_info
  end
  local local_pkg_info_data = _get_local_pkg_info_data()
  return local_pkg_info_data
end

local function _fill_cloud_info(pkg_info)
  local CLOUDGAME_3RD = require("ejoysdk_lua.ejoysdk_cloudgame_3rd")
  if CLOUDGAME_3RD.is_cloudgame() then
    pkg_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] = CLOUDGAME_3RD.get_cloudgame_mode()
    if not pkg_info.system or pkg_info.system == "unknown" then
      local cloud_v = CLOUDGAME_3RD.get_cloudgame_vendor()
      pkg_info.system = cloud_v and cloud_v.Sysinfo.get_device_system()
    end
    return
  end
  local local_cloud_mode = local_cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE]
  if local_cloud_mode and "" ~= local_cloud_mode then
    pkg_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] = local_cloud_mode
  else
    local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
    pkg_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] = cloud_config.get_cloud_mode()
  end
  local local_instant_mode = local_instant_info[M.INSTANT_INFO_KEY.KEY_INSTANT_MODE]
  if local_instant_mode and "" ~= local_instant_mode then
    pkg_info[M.PKG_INFO_KEY.KEY_INSTANT_MODE] = local_instant_mode
  else
    pkg_info[M.PKG_INFO_KEY.KEY_INSTANT_MODE] = "normal"
  end
  local local_install_referrer = local_instant_info[M.INSTANT_INFO_KEY.KEY_INSTALL_REFERRER]
  pkg_info[M.PKG_INFO_KEY.KEY_INSTALL_REFERRER] = local_install_referrer or "none"
  if local_cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] then
    pkg_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE] = local_cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE]
  else
    pkg_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE] = "run_in_normal_mode"
  end
end

local function _fill_other_pkg_info(pkg_info)
  if predownload_run_mode_info and predownload_run_mode_info[M.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE] then
    pkg_info[M.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE] = predownload_run_mode_info[M.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE]
    pkg_info[M.PKG_INFO_KEY.KEY_PKG_GAME_RUN_MODE_TYPE] = predownload_run_mode_info[M.PKG_INFO_KEY.KEY_PKG_GAME_RUN_MODE_TYPE]
  end
end

local function fill_airline_brand(pkg_info)
  if not pkg_info.airline or pkg_info.airline == "" then
    local E = require("ejoysdk_lua.ejoysdk")
    if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
      local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
      local gangplank_config = EGC.get_current_cdn_config()
      if gangplank_config then
        local airline_info = gangplank_config.ext and gangplank_config.ext.airline_info
        pkg_info.airline = airline_info and airline_info.brand
        if not pkg_info.airline or pkg_info.airline == "" then
          pkg_info.airline = get_meta_config("brand") or ""
        end
      end
    else
      local acf = require("ejoysdk_lua.vendors.aligames_config")
      local lx_brand = acf.get_lingxi_brand()
      pkg_info.airline = lx_brand
      _ejoysdk.log("fill pkg_info airline brand:" .. tostring(lx_brand))
    end
  end
end

function M.get_pkg_info()
  local pkg_info = _get_pkg_info()
  _fill_cloud_info(pkg_info)
  _fill_other_pkg_info(pkg_info)
  fill_airline_brand(pkg_info)
  return pkg_info
end

local function get_pref_cloud_keystore()
  if nil == pref_cloud_info then
    local E = require("ejoysdk_lua.ejoysdk")
    pref_cloud_info = E.LazyKeyStore:New("PREF_CLOUD_INFO", false, true, false)
  end
  return pref_cloud_info
end

function M.get_cloud_game_info()
  if local_cloud_info and local_cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] then
    _ejoysdk.log(TAG .. "get_cloud_game_info from cache")
    return local_cloud_info
  end
  local _pref_cloud_keystroe = get_pref_cloud_keystore()
  local _pref_cloud_info = _pref_cloud_keystroe:get()
  if _pref_cloud_info and next(_pref_cloud_info) ~= nil then
    local_cloud_info = _pref_cloud_info
    _ejoysdk.log(TAG .. "read cloud_info from pref cache")
  end
  local cm = require("ejoysdk_lua.cloud_game.cloud_config")
  local cloud_game_mode = cm.get_cloud_mode_name()
  local_cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] = cloud_game_mode
  local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
  if cloud_game_mode == cloud_config.CLOUD_MODE.CLOUD then
    local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
    local_cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE] = CSTAT.MOBILE_RUN_MODE.MODE_RUN_IN_CLOUD_SIDE
    _ejoysdk.log(TAG .. "cloud side run_mode always is " .. CSTAT.MOBILE_RUN_MODE.MODE_RUN_IN_CLOUD_SIDE)
  end
  if not cloud_game_mode then
    local_cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE] = "run_in_normal_mode"
  end
  _ejoysdk.log(TAG .. "get_cloud_game_mode use cloud game manager:" .. cloud_game_mode)
  return local_cloud_info
end

function M.set_cloud_game_info(cloud_info)
  local _cloud_info = cloud_info or {}
  local cloud_mode = _cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE]
  local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
  if cloud_mode == cloud_config.CLOUD_MODE.CLOUD then
    local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
    _cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE] = CSTAT.MOBILE_RUN_MODE.MODE_RUN_IN_CLOUD_SIDE
    _ejoysdk.log(TAG .. "cloud side run_mode always is " .. CSTAT.MOBILE_RUN_MODE.MODE_RUN_IN_CLOUD_SIDE)
  end
  local cloud_run_mode = _cloud_info[M.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE]
  _ejoysdk.log(TAG .. "set_cloud_game_mode:" .. tostring(cloud_mode) .. ", cloud_run_mode:" .. tostring(cloud_run_mode))
  local_cloud_info = _cloud_info
  local _pref_cloud_keystroe = get_pref_cloud_keystore()
  _pref_cloud_keystroe:set(local_cloud_info)
  local info_data = {
    [M.TOPIC_DATA_KEY.KEY_DATA_TYPE] = M.INFO_KEY.KEY_CLOUD_GAME_INFO,
    [M.TOPIC_DATA_KEY.KEY_DATA] = _cloud_info
  }
  ET.publish(M.TOPIC.TOPIC_INFO_CHANGES, info_data)
end

function M.set_predownload_game_mode(predownload_game_info)
  _ejoysdk.log("set_predownload_game_mode begin")
  predownload_run_mode_info = predownload_game_info
  local info_data = {
    [M.TOPIC_DATA_KEY.KEY_DATA_TYPE] = M.INFO_KEY.KEY_RUNMODE_INFO,
    [M.TOPIC_DATA_KEY.KEY_DATA] = predownload_run_mode_info
  }
  ET.publish(M.TOPIC.TOPIC_MOBILE_RUN_MODE_CHANGES, info_data)
end

function M.get_predownload_game_mode()
  return predownload_run_mode_info
end

function M.set_instant_mode(instant_mode)
  local_instant_info[M.INSTANT_INFO_KEY.KEY_INSTANT_MODE] = instant_mode
  _ejoysdk.log("set_instant_mode:" .. tostring(instant_mode))
end

function M.get_instant_mode()
  return local_instant_info[M.INSTANT_INFO_KEY.KEY_INSTANT_MODE]
end

function M.set_install_referrer(install_referrer)
  local_instant_info[M.INSTANT_INFO_KEY.KEY_INSTALL_REFERRER] = install_referrer
end

function M.get_install_referrer()
  return local_instant_info[M.INSTANT_INFO_KEY.KEY_INSTALL_REFERRER]
end

function M.set_channel_cloud_game_tag(is_cloud)
  channel_cloud_game_tag = is_cloud
  local pkg_info = _get_pkg_info()
  if pkg_info then
    pkg_info[M.PKG_INFO_KEY.KEY_CHANNEL_CLOUD_GAME_TAG] = channel_cloud_game_tag
  end
end

function M.get_channel_cloud_game_tag()
  return channel_cloud_game_tag
end

function M.get_user_pkg_info()
  return user_pkg_info
end

function M.refresh_channel_id(clear_account_ch)
  local pkg_info = _get_pkg_info()
  local ejoy = require("ejoysdk_lua.ejoysdk")
  ejoy.LOG.debug(TAG, "refresh channel id, channel_id >> " .. tostring(ejoy.get_channel()))
  pkg_info.channel_id = ejoy.get_channel()
  pkg_info.ds_channel_id = ejoy.Sysinfo.ds_channel_id()
  if clear_account_ch then
    pkg_info.accountCh = ""
  end
end

function M.update_channel_id(accountCh)
  local ejoy = require("ejoysdk_lua.ejoysdk")
  ejoy.LOG.debug(TAG, "update_channel_id, accountCh >> " .. tostring(accountCh))
  local pkg_info = _get_pkg_info()
  pkg_info.channel_id = accountCh
  pkg_info.ds_channel_id = accountCh
  pkg_info.accountCh = accountCh
end

function M.set_pkg_info(pkg_info)
  local ejoy = require("ejoysdk_lua.ejoysdk")
  if nil == pkg_info or nil == next(pkg_info) then
    ejoy.LOG.debug(TAG, "set_pkg_info failed, for pkg_info is nil")
  end
  ejoy.LOG.debug(TAG, "set_pkg_info begin >>")
  user_pkg_info = pkg_info
  ejoy.log(user_pkg_info)
  local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
  ESTAT.reset_env_info()
  local info_data = {
    [M.TOPIC_DATA_KEY.KEY_DATA_TYPE] = M.INFO_KEY.KEY_PKG_INFO,
    [M.TOPIC_DATA_KEY.KEY_DATA] = user_pkg_info
  }
  ET.publish(M.TOPIC.TOPIC_INFO_CHANGES, info_data)
end

function M.update_pkg_info(new_info, cb)
  local ejoy = require("ejoysdk_lua.ejoysdk")
  ejoy.log("update pkg info")
  if not new_info then
    ejoy.LOG.debug(TAG, "new info is empty, do nothing-1")
    if cb then
      cb(false, {})
    end
    return
  end
  local has_update = false
  local pkg_info = _get_pkg_info()
  if pkg_info then
    for key, value in pairs(new_info) do
      if key and can_update_key(key) then
        ejoy.log("reset key >> " .. tostring(key) .. ", and value >> " .. tostring(value))
        has_update = true
        pkg_info[key] = value
      end
    end
    if not has_update then
      ejoy.LOG.debug(TAG, "no value update, return")
      if cb then
        cb(false, {})
      end
      return
    end
    ejoy.log("reset env info ")
    local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
    ESTAT.reset_env_info()
    local info_data = {
      [M.TOPIC_DATA_KEY.KEY_DATA_TYPE] = M.INFO_KEY.KEY_PKG_INFO,
      [M.TOPIC_DATA_KEY.KEY_DATA] = pkg_info
    }
    ET.publish(M.TOPIC.TOPIC_INFO_CHANGES, info_data)
  end
  if cb then
    cb(true, {})
  end
end

local function get_aegis_lua()
  if AC then
    return AC
  end
  AC = require("ejoysdk_lua.aegis.aegis_collect_data")
  return AC
end

function M.get_aegis_info()
  if user_aegis_info then
    _ejoysdk.log(TAG .. "get_aegis_info current_aegis_info not nil return current_aegis_info")
    return user_aegis_info
  end
  _ejoysdk.log(TAG .. "get_aegis_info current_aegis_info is nil, init and return device aegis_info")
  local ac = get_aegis_lua()
  local _aegis_info = ac.get_collect_data()
  return _aegis_info
end

function M.get_encrypt_aegis_info()
  local aegis_info = M.get_aegis_info()
  local ac = get_aegis_lua()
  do return ac.encrpt_aegis_data end
  return ac.encrpt_aegis_data, aegis_info
end

function M.set_aegis_info(aegis_info)
  local ejoy = require("ejoysdk_lua.ejoysdk")
  if nil == aegis_info or nil == next(aegis_info) then
    ejoy.LOG.debug(TAG, "set_aegis_info failed, for aegis_info is nil")
  end
  ejoy.LOG.debug(TAG, "set_aegis_info begin >>")
  user_aegis_info = aegis_info
  ejoy.log(user_aegis_info)
end

function M.set_trace_id(trace_id)
  if trace_id and "" ~= trace_id then
    _ejoysdk.log("set_trace_id from outside:" .. tostring(trace_id))
    outside_override_trace_id = trace_id
  end
end

function M.set_ab_flag(flag)
  _ejoysdk.log(TAG, "set_ab_flag:" .. tostring(flag))
  ab_type = flag
end

function M.set_security_privacy_info(sec_info)
  security_info = sec_info or {}
  if sec_info then
    local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
    ESTAT.reset_has_init_public_params_flag()
  end
end

function M.get_security_privacy_info()
  return security_info
end

function M.get_mw()
  local ret
  local E = require("ejoysdk_lua.ejoysdk")
  local os = E.Sysinfo.os()
  if "windows" == os then
    if pc_sysinfo_mw then
      return pc_sysinfo_mw
    end
    if _ejoysdk.sysinfo then
      local sysinfo = _ejoysdk.sysinfo() or {}
      if sysinfo.mw and type(sysinfo.mw) == "string" then
        local JSON = require("ejoysdk_lua.ejoysdk_json")
        ret = JSON.safe_decode(sysinfo.mw)
        pc_sysinfo_mw = ret
        local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
        ESTAT.reset_has_init_public_params_flag()
      end
    end
  else
    ret = M.get_security_privacy_info()
  end
  return ret
end

function M.set_umid_token(token)
  if umid_token ~= token then
    umid_token = token
    local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
    ESTAT.update_umid_token(umid_token)
  end
end

function M.set_player_info()
end

function M._test_reset_cache()
  local_ua_cache_data = nil
end

function M._test_reset_pkg_info()
  local_pkg_info = nil
end

return M

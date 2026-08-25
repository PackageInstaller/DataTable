local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local V = require("ejoysdk_lua.version")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.AEGIS .. "aegis"
local AEGIS_SECURITY_KEY = "C5E5FC5325295EA16A53652A65CB32E8"
local AEGIS_TOTP_STEP = 3600
local AEGIS_ENCRYPT_VERSION = "01"
local M = {}
local cached_collect_data

local function collect_aegis_data()
  local collect_data = {}
  local os = E.Sysinfo.os()
  collect_data.os = os
  collect_data.brand = E.Sysinfo.brand()
  collect_data.model = E.Sysinfo.model()
  collect_data.os_version = E.Sysinfo.os_version()
  collect_data.lua_version = V.LUA_VERSION
  collect_data.game_version = E.CONFIG.get_config("game_version") or ""
  collect_data.ejoysdk_version = E.get_sdk_version_name("EJOYSDK") or ""
  collect_data.aligames_version = E.get_sdk_version_name("ALIGAMES") or ""
  collect_data.app_version_code = E.Sysinfo.app_version_code()
  collect_data.app_version_name = E.Sysinfo.app_version_name()
  collect_data.ds_channel_id = E.Sysinfo.ds_channel_id()
  collect_data.ds_sub_channel_id = E.Sysinfo.ds_sub_channel_id() or "DG_2"
  collect_data.ut = E.Sysinfo.utdid()
  if "windows" == os then
    collect_data.security_version = ""
  else
    collect_data.security_version = E.get_sdk_version_name("SECURITY") or ""
  end
  if "android" == os then
    if E.Sysinfo.is_simulator() then
      collect_data.simulatorjaq = 1
    else
      collect_data.simulatorjaq = 0
    end
    if E.Sysinfo.is_accessibility_enable() then
      collect_data.acc = 1
    else
      collect_data.acc = 0
    end
    if E.Sysinfo.is_param_mod_inuse() then
      collect_data.mod = 1
    else
      collect_data.mod = 0
    end
    collect_data.dp = E.Sysinfo.density()
    local battery_info = E.Sysinfo.battery()
    collect_data.batl = battery_info.level
    collect_data.bats = battery_info.status
    if E.Sysinfo.is_qemu_device() then
      collect_data.qe = 1
    else
      collect_data.qe = 0
    end
    collect_data.sdkver = E.get_sdk_version_name("EJOYSDK")
    collect_data.boot = E.Sysinfo.get_boot_time()
    if E.Sysinfo.is_adb_enabled() then
      collect_data.adb = 1
    else
      collect_data.adb = 0
    end
    local wifi_info = E.Sysinfo.wifi()
    collect_data.ss = wifi_info.ssid
    collect_data.spd = wifi_info.speed
    local cpu_str = E.Sysinfo.get_cpu_detail()
    if nil ~= cpu_str then
      collect_data.cpu = string.gsub(cpu_str, "\n", " ")
    end
    collect_data.appins = E.Sysinfo.get_app_install_time()
    collect_data.useragent = E.Sysinfo.get_user_agent()
    if E.Sysinfo.is_xposed_installed() then
      collect_data.xp = 1
    else
      collect_data.xp = 0
    end
    collect_data.sysins = E.Sysinfo.get_system_install_time()
    collect_data.cid = E.Sysinfo.get_cpu_id()
    if E.Sysinfo.is_device_root() then
      collect_data.rt = 1
    else
      collect_data.rt = 0
    end
    collect_data.cores = E.Sysinfo.get_cpu_cores_count()
    collect_data.mt = E.Sysinfo.get_manufacturer()
    collect_data.app_version = E.Sysinfo.app_version_name()
    collect_data.did = E.Sysinfo.idfa()
  elseif "ios" == os then
    collect_data.idfa = E.Sysinfo.idfa()
    collect_data.idfv = E.Sysinfo.idfv()
    collect_data.sysinfo_ejoy_ext_info = E.Sysinfo.sysinfo_ejoy_ext_info()
    collect_data.app_version = E.Sysinfo.app_version_name()
    local battery = E.Sysinfo.battery()
    collect_data.batl = battery.level
    collect_data.bats = battery.status
    collect_data.machine = E.Sysinfo.machine()
    collect_data.pb = E.Sysinfo.is_jailbroken()
    collect_data.device_name = E.Sysinfo.device_name()
    collect_data.boot = E.Sysinfo.get_boot_time()
    collect_data.sysins = E.Sysinfo.get_install_time()
    local mobile_info = E.Sysinfo.mobile_info() or {}
    collect_data.mcc = mobile_info.mcc or ""
    collect_data.mnc = mobile_info.mnc or ""
    collect_data.did = E.Sysinfo.device_idfv()
  end
  collect_data.width = E.Sysinfo.screen().width
  collect_data.height = E.Sysinfo.screen().height
  collect_data.gameid = E.get_game_id()
  return collect_data
end

function M.get_collect_data()
  if not cached_collect_data then
    E.LOG.debug(TAG, "get_collect_data first time init collect data")
    cached_collect_data = collect_aegis_data()
    E.log("aegis collect data:")
    E.log(cached_collect_data)
  end
  cached_collect_data.net_type = E.Sysinfo.network_type()
  local user_info_manager = require("ejoysdk_lua.user_info_manager")
  local mw = user_info_manager.get_mw()
  if mw then
    cached_collect_data.mw = mw
  end
  E.LOG.debug(TAG, "get updated aegis info, mw:" .. tostring(mw))
  return cached_collect_data
end

function M.get_encrypt_data()
  local data = M.get_collect_data()
  local final_result = M.encrpt_aegis_data(data)
  return final_result
end

function M.encrpt_aegis_data(data)
  local current_time = math.modf(E.time() / AEGIS_TOTP_STEP)
  local sha_key = _ejoysdk_crypt.hmac_sha1(AEGIS_SECURITY_KEY, current_time)
  local des_key = string.sub(sha_key, 1, 8)
  local data_str = tostring(JSON.encode(data))
  local des_result = _ejoysdk_crypt.desencode(des_key, data_str)
  local base64_result = _ejoysdk_crypt.base64encode(des_result)
  local final_result = AEGIS_ENCRYPT_VERSION .. base64_result
  _ejoysdk.log(TAG .. "#encrypt_result:" .. final_result)
  return final_result
end

return M

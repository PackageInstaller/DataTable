local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local AEGIS_DATA = require("ejoysdk_lua.aegis.aegis_collect_data")
local M = {}
local TAG = EM.MODULE.OFFICIAL_SCAN_LOGIN
local CODE_GRANT_QRCODE_ERROR = 4001198
local grant_succ = false
local scan_qrcode_callback

function M.get_qrcode(_cb)
  E.LOG.debug(TAG, "not support generate qrcode")
end

function M.cancel_query_status()
  E.LOG.debug(TAG, "not support cancel_query_status")
end

function M.query_status()
  E.LOG.debug(TAG, "not support query_status")
end

function M.grant_qrcode(_uuid, _cb)
  E.LOG.debug(TAG, "not need call grant_qrcode, H5 do it")
end

local function on_close_callback()
  if not grant_succ and scan_qrcode_callback then
    local LANG_UTIL = require("ejoysdk_lua.lang.util")
    local code = CODE_GRANT_QRCODE_ERROR
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_cancel", "")
    scan_qrcode_callback(false, code, tip_msg)
  end
end

local function open_webview(url, append_start_up_data)
  local host = E.HTTP.parse(url).host
  local local_start_up_data = {
    aegis_data = AEGIS_DATA.get_encrypt_data(),
    ejoysdk_ver = E.get_sdk_version_name("EJOYSDK")
  }
  if append_start_up_data then
    for start_up_data_key, start_up_data_data in pairs(append_start_up_data) do
      local_start_up_data[start_up_data_key] = start_up_data_data
    end
  end
  grant_succ = false
  E.WebView.open(url, {
    [host] = {startupData = local_start_up_data, transparent = true}
  }, {
    compactMode = true,
    use_fragment = true,
    hide_close_btn = true
  }, nil, on_close_callback)
end

local function get_airline_center_url(api)
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if is_overseas then
    local OFFICIAL = require("ejoysdk_lua.vendors.official")
    do return OFFICIAL.get_api_url end
    return OFFICIAL.get_api_url, api, nil, nil, nil, nil
  end
  local AIRLINE_V2_CONFIG = require("ejoysdk_lua.airline_v2.airline_v2_config")
  local host = AIRLINE_V2_CONFIG.get_airline_h5_url_host()
  if not host then
    E.LOG.debug(TAG, "没有读到灵犀2.0的域名配置，说明是灵犀1.0，使用内部默认的灵犀域名")
    host = "https://accounts.lingxigames.com"
    local EI = require("ejoysdk_lua.ejoysdk_init")
    if EI.env() == EI.ENV.DEBUG then
      host = "https://accounts-test.lingxigames.com"
      E.LOG.debug(TAG, "get_airline_center_url, 使用测试环境H5域名")
    elseif EI.env() == EI.ENV.PRE_RELEASE then
      host = "https://accounts-pre.lingxigames.com"
      E.LOG.debug(TAG, "get_airline_center_url, 使用预发环境H5域名")
    end
  end
  E.LOG.debug(TAG, "get_airline_center_url, host = " .. tostring(host))
  local AIRLINE_V2 = require("ejoysdk_lua.vendors.airline_v2")
  local h5_url = E.HTTP.uri_join(host, AIRLINE_V2.get_ui_version(), api)
  return h5_url
end

function M.h5_callback_grant_finish()
  grant_succ = true
  if scan_qrcode_callback then
    scan_qrcode_callback(true, "uuid", "official_scan_login")
  end
end

function M.scan_handler(qr_info, cb)
  local is_official_channel = tostring(E.get_channel()) == "998233" or false
  local is_ovseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if not is_ovseas and not is_official_channel then
    local REALNAME_INFO = require("ejoysdk_lua.realname.realname_info")
    local succ, code, msg = REALNAME_INFO.check_realname()
    if not succ then
      E.LOG.warn(TAG, "scan_handler skip, realname check failed")
      if cb then
        cb(false, code, msg)
      end
      return
    end
  end
  scan_qrcode_callback = cb
  local uid = qr_info.uuid
  E.LOG.debug(TAG, "qrcode scan uid is " .. tostring(uid))
  local scan_data = {qr_info = qr_info, uid = uid}
  local api = "m#/qrcode/login"
  local url = get_airline_center_url(api)
  local HISTORY = require("ejoysdk_lua.account.official_history")
  scan_data.current_account_data = HISTORY.get_last_login_account()
  scan_data.need_verify_uid = true
  open_webview(url, {scan_data = scan_data})
end

return M

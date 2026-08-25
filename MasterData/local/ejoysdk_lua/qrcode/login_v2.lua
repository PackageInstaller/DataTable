local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local REALNAME_INFO = require("ejoysdk_lua.realname.realname_info")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local TAG = EM.MODULE.QRCODE .. "login_v2"
local M = {}

function M.get_qrcode(cb)
  E.LOG.debug(TAG, "get_qrcode v2 begin")
  EG.get_login_qrcode_http_v2(function(succ, ...)
    if succ then
      local result = (...)
      cb(true, result.data.surl)
    else
      cb(false, ...)
    end
  end)
end

local function query_status_once(uuid, extra_params, cb)
  E.LOG.debug(TAG, "query_status_once begin")
  EG.validate_qrcode_uuid_http_v2(uuid, extra_params, cb)
end

local loop_querying = false

function M.cancel_query_status()
  ET.publish(ET.gangplank.SCAN_QUERY_FINISH)
  loop_querying = false
end

local loop_uuid

function M.query_status(uuid, cb)
  loop_querying = true
  loop_uuid = uuid
  E.LOG.debug(TAG, "轮询扫码登录, uuid:" .. tostring(loop_uuid))
  local query_frequency = 1
  E.Timer.once(60, function()
    query_frequency = 3
  end)
  
  local function loop_query_status()
    if not loop_querying or not loop_uuid then
      return
    end
    local extra_params = {}
    query_status_once(loop_uuid, extra_params, function(succ, ...)
      if succ then
        local body = (...)
        local status = body.data and body.data.status or -1
        E.LOG.debug(TAG, "query_status_once status:" .. tostring(status))
        E.log(body)
        if 0 == status then
          M.cancel_query_status()
          E.LOG.debug(TAG, "扫码登录成功!")
          if E.WebView.is_opened() then
            E.WebView.close()
            E.LOG.debug(TAG, "当前webview仍然处于打开状态，先关闭它再走acquire流程，避免后续acquire流程的风控等网页弹不出来!!!")
          end
          local authorized_infos = body.data and body.data.authorized_infos or {}
          if not authorized_infos.ptoken or authorized_infos.ptoken == "" then
            cb(false, EC.QRCODE_ERROR_CODES.CODE_PTOKEN_EMPTY, "ptoken empty", body)
            return
          end
          local region = authorized_infos.region
          local outsource = {
            platform = authorized_infos.platform,
            ptoken = authorized_infos.ptoken,
            pid = authorized_infos.pid,
            guest = authorized_infos.guest,
            with = authorized_infos.with,
            ext = authorized_infos.ext,
            appname = authorized_infos.appname
          }
          E.LOG.debug(TAG, "request_gangplank_acquire begin")
          E.LOG.debug(TAG, "client_params:" .. tostring(authorized_infos.client_params or nil))
          EG.request_gangplank_acquire(region, outsource, nil, function(_succ, ...)
            if _succ then
              local acquire_token, acquire_body = ...
              local user_info = EG.user_info()
              E.LOG.debug(TAG, user_info)
              cb(true, acquire_token, acquire_body)
              ET.publish(ET.gangplank.SCAN_LOGIN, EG.user_info())
            else
              local _status, acquire_body = ...
              E.LOG.debug(TAG, "query qrcode request_gangplank_acquire failed")
              cb(false, _status, "qrcode acquire failed", acquire_body)
            end
          end)
        else
          E.LOG.debug(TAG, "query qrcode not login, query again")
          E.Timer.once(query_frequency, function()
            loop_query_status()
          end)
        end
      else
        M.cancel_query_status()
        E.LOG.debug(TAG, "query qrcode other error")
        cb(false, ...)
      end
    end)
  end
  
  loop_query_status()
end

function M.scan_handler(qr_info, cb)
  local succ, code, msg = REALNAME_INFO.check_realname()
  if not succ then
    E.LOG.warn(TAG, "scan failed, realname failed:" .. tostring(REALNAME_INFO.get_adult_status()))
    if cb then
      cb(false, code, msg)
    end
    return
  end
  query_status_once(qr_info.uuid, {}, function(_succ, ...)
    if _succ then
      cb(true, qr_info.uuid, "login_v2", ...)
    else
      cb(false, ...)
    end
  end)
end

function M.grant_qrcode(uuid, cb)
  EG.grant_login_uuid_http_v2(uuid, cb)
end

local function win_send_crash_stat(err_type, err_msg)
  local md5_err_msg
  if type(_ejoysdk_crypt.md5) == "function" then
    md5_err_msg = _ejoysdk_crypt.md5(err_type)
  elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
    md5_err_msg = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.md5.sum(err_type))
  end
  local _pkg_info = E.get_pkg_info()
  local ext_data = {pkg_info = _pkg_info}
  local ok, encode_params = pcall(JSON.encode, ext_data)
  local ext_data_str
  if ok then
    ext_data_str = tostring(encode_params)
  else
    ext_data_str = ""
  end
  err_msg = err_type .. "\n" .. err_msg .. [[

 ext:
]] .. tostring(ext_data_str)
  local crash = require("ejoysdk_lua.vendors.crashsdk")
  crash.create_custom_log("error", err_type, err_msg, md5_err_msg, ext_data_str)
end

function M.check_support_scan()
  local EQ = require("ejoysdk_lua.qrcode.ejoysdk_qrcode")
  local result = {
    is_support = true,
    fallback_type = EQ.SCAN_TYPE.LOGIN
  }
  if E.Sysinfo.os() == "windows" then
    if _ejoysdk.is_build_in_webview_available then
      local available = _ejoysdk.is_build_in_webview_available()
      E.LOG.warn(TAG, "check_support_scan result, available:" .. tostring(available))
      if not available then
        E.LOG.warn(TAG, "check_support_scan not support, need fallback to login")
        result.is_support = false
      end
    end
    if result.is_support then
      result.is_support = E.support_webview()
      E.LOG.debug(TAG, "windows webview available and game set webview not support")
    end
    if not result.is_support then
      local err_msg_type = "pc_scan_login_v2_no_buildin_webview"
      pcall(win_send_crash_stat, err_msg_type, err_msg_type)
    end
  end
  return result
end

return M

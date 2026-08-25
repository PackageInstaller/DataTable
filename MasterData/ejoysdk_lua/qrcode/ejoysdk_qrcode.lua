local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ERROR_CODES = CONSTANTS.QRCODE_ERROR_CODES
local EM = require("ejoysdk_lua.ejoysdk_module")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local M = {}
local TAG = EM.MODULE.QRCODE .. "ejoysdk_qrcode"
local qr_modules = {}

function M.register_qr_module(qr_type, module)
  qr_modules[qr_type] = module
end

M.SCAN_TYPE = {
  LOGIN = "login",
  LOGIN_V2 = "login_v2",
  LOGIN_OLD = "LOGIN",
  BBS = "bbs",
  OFFICIAL_SCAN_LOGIN = "official_scan_login"
}
M.register_qr_module(M.SCAN_TYPE.LOGIN, require("ejoysdk_lua.qrcode.login"))
M.register_qr_module(M.SCAN_TYPE.LOGIN_OLD, require("ejoysdk_lua.qrcode.login"))
M.register_qr_module(M.SCAN_TYPE.LOGIN_V2, require("ejoysdk_lua.qrcode.login_v2"))
M.register_qr_module(M.SCAN_TYPE.BBS, require("ejoysdk_lua.qrcode.bbs"))
M.register_qr_module(M.SCAN_TYPE.OFFICIAL_SCAN_LOGIN, require("ejoysdk_lua.qrcode.ejoysdk_h5_scan_login"))

local function check_qr_func_support(type, func_name, cb)
  local qr_module = qr_modules[type]
  local has_module_func = qr_module and qr_module[func_name]
  if not has_module_func then
    if cb then
      cb(false, ERROR_CODES.CODE_NOT_SUPPORT_TYPE, "not support type")
    end
    return false
  else
    if qr_module.check_support_scan then
      local result = qr_module.check_support_scan()
      if result and not result.is_support and result.fallback_type then
        return true, result.fallback_type
      end
    end
    return true, type
  end
end

local cur_show_qr_info, cur_scan_qr_info
local close_sdk_scan_error_alert = false

function M.set_close_sdk_scan_error_alert()
  close_sdk_scan_error_alert = true
end

local function dispatch_qr_info(qr_info, cb)
  if qr_info.product and qr_info.product:lower() ~= E.CONFIG.get_config("product"):lower() then
    local error_msg = "wrong product code, qr:" .. tostring(qr_info.product) .. ", config:" .. tostring(E.CONFIG.get_config("product"))
    E.LOG.error(TAG, error_msg)
    local code = ERROR_CODES.CODE_WRONG_PRODUCT
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_product_code_not_match", "")
    if not close_sdk_scan_error_alert then
      tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
      E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
        message = tip_msg,
        buttons = {
          LANG_UTIL.getStringSuitCNOverseas("confirm", "")
        }
      })
    end
    cb(false, code, tip_msg)
    return
  end
  local is_support, qr_type = check_qr_func_support(qr_info.type, "scan_handler", cb)
  E.LOG.debug(TAG, "dispatch_qr_info check_qr_func_support result:" .. tostring(is_support) .. ", type:" .. tostring(qr_type))
  if not is_support then
    local code = CONSTANTS.QRCODE_ERROR_CODES.QRCODE_TYPE_NOT_SUPPORT
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_dispatch_fail", "")
    if not close_sdk_scan_error_alert then
      tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
      E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
        message = tip_msg,
        buttons = {
          LANG_UTIL.getStringSuitCNOverseas("confirm", "")
        }
      })
    end
    cb(false, code, tip_msg)
    return
  end
  cur_scan_qr_info = qr_info
  qr_modules[qr_type].scan_handler(qr_info, cb)
end

local function parse_json(content)
  local decode_succ, result = pcall(JSON.decode, content)
  E.LOG.debug(TAG, "parse_json succ?: " .. tostring(decode_succ))
  if decode_succ then
    if not (type(result) == "table" and result.uuid) or not result.type then
      return false, ERROR_CODES.CODE_WRONG_JSON, "no result.uuid or no result.type"
    else
      local qr_info = {
        type = result.type,
        uuid = result.uuid
      }
      return true, qr_info
    end
  else
    return false
  end
end

local function generate_qr_info_by_url_business(path, query)
  local params = E.Utils.split_string(path, "/")
  if "user" == params[1] and "login" == params[2] or "user" == params[2] and "login" == params[3] then
    local uid = query.uid
    if nil == uid or "" == uid then
      return false
    end
    local qr_info = {
      type = "official_scan_login",
      uuid = uid
    }
    return qr_info
  end
  local params_size = #params
  if params_size >= 3 then
    local _product = params[2]
    local _uuid = query.u
    local qr_info = {uuid = _uuid, product = _product}
    if "gangplank" == params[1] and "login" == params[3] then
      local qr_type = M.SCAN_TYPE.LOGIN_V2
      qr_info.type = qr_type
      return qr_info
    end
  end
  local qr_type = params[1]
  local product = params[2]
  local uuid = query.u
  if not (qr_type and product) or not uuid then
    return nil
  end
  local qr_info = {
    type = qr_type,
    uuid = uuid,
    product = product
  }
  return qr_info
end

local function parse_url(content)
  E.LOG.debug(TAG, "parse_url, content: " .. tostring(content))
  local url_info = E.HTTP.parse(content)
  E.LOG.debug(TAG, "parse_url, url_info")
  E.LOG.debug(TAG, url_info)
  if nil == url_info or nil == url_info.host or nil == url_info.path or nil == url_info.query then
    return false, ERROR_CODES.CODE_WRONG_URL, "wrong url"
  end
  local query = url_info.query
  local path = url_info.path
  local qr_info = generate_qr_info_by_url_business(path, query)
  E.LOG.debug(TAG, "generate_qr_info_by_url_business return qr_info")
  E.LOG.debug(TAG, {qr_info = qr_info})
  if not qr_info then
    return false, ERROR_CODES.CODE_WRONG_URL_PARAMS, "wrong url params"
  end
  return true, qr_info
end

local function parse_qrcode(content)
  local parse_succ, qr_info = parse_json(content)
  E.LOG.debug(TAG, "扫码解析 json 成功？" .. tostring(parse_succ))
  if parse_succ then
    return true, qr_info
  end
  do return parse_url end
  return parse_url, content, "扫码解析 json 成功？" .. tostring(parse_succ), tostring(parse_succ), parse_succ
end

function M.qrcode_scan_with_permission_dialog(cb)
  M.detect_camera_permission(function(succ)
    if succ then
      M.qrcode_scan(cb)
    else
      local code = ERROR_CODES.QRCODE_DENY_CAMERA_PERMISSION
      local tip_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_no_camera_permission", "")
      tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
      cb(false, code, tip_msg)
    end
  end)
end

function M.h5_qrcode_scan()
  E.WebView.close()
  M.qrcode_scan_with_grant()
end

function M.qrcode_scan_with_grant()
  M.detect_camera_permission(function(succ)
    if succ then
      M.qrcode_scan(function(scan_succ, ...)
        if scan_succ then
          E.LOG.debug(TAG, "scan qrcode succ, now start grant")
          M.grant_qrcode(function(grant_succ, ...)
            if grant_succ then
              E.LOG.debug(TAG, "qrcode grant succ")
            else
              local error_code, error_msg = ...
              E.LOG.debug(TAG, "error_code: " .. tostring(error_code) .. " ,error_msg: " .. tostring(error_msg))
            end
          end)
        end
      end)
    else
      local code = ERROR_CODES.QRCODE_DENY_CAMERA_PERMISSION
      local tip_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_no_camera_permission", "")
      tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
      E.LOG.debug(TAG, {code = code, msg = tip_msg})
    end
  end)
end

function M.detect_camera_permission(cb)
  if E.Sysinfo.os() == "harmonyos" then
    cb(true)
  elseif E.Permission.support_compliance_check() then
    local permissions_android = {
      ["android.permission.CAMERA"] = {}
    }
    local permissions_ios = {
      NSCameraUsageDescription = {}
    }
    local permissions = permissions_android
    if _ejoysdk.os() == "ios" then
      permissions = permissions_ios
    end
    local options = {permissions = permissions}
    E.Permission.check_permission_v3(options, function(succ)
      if succ then
        cb(true)
      else
        cb(false)
      end
    end)
  else
    cb(true)
  end
end

local function transfer_error_message_with_code(code, msg)
  local message = msg
  if 410012 == code or 410006 == code or 510006 == code or 510005 == code then
    message = LANG_UTIL.getStringSuitCNOverseas("qrcode_account_token_expired", "")
  elseif 410013 == code or 410014 == code or 410015 == code then
    message = LANG_UTIL.getStringSuitCNOverseas("qrcode_invalid", "")
  elseif code >= 10416 and code <= 10420 then
    message = LANG_UTIL.getStringSuitCNOverseas("qrcode_invalid", "")
  end
  return message
end

local function modal_open_suit_ios_alert_delay(tip_msg)
  if not close_sdk_scan_error_alert then
    local delay_seconds = 0
    if _ejoysdk.os() == "ios" then
      delay_seconds = 1.0
    end
    E.Timer.once(delay_seconds, function()
      E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
        message = tip_msg,
        buttons = {
          LANG_UTIL.getStringSuitCNOverseas("confirm", "")
        }
      })
    end)
  end
end

function M.qrcode_scan(cb)
  QL.commit_action_main("ej_qrcode_scan")
  E.qrcode_scan(function(succ, ...)
    if succ then
      QL.commit_action_main("ej_qrcode_scan_result", nil, true)
      local content = (...)
      E.LOG.debug(TAG, "扫码 info: " .. tostring(content))
      if nil == content or "" == content then
        local code = CONSTANTS.QRCODE_ERROR_CODES.CODE_EMPTY_CONTENT
        local tip_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_dispatch_fail", "")
        tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
        modal_open_suit_ios_alert_delay(tip_msg)
        cb(false, code, tip_msg)
        return
      end
      local parse_succ, qr_info = parse_qrcode(content)
      E.LOG.debug(TAG, "parse_qrcode return result")
      E.LOG.debug(TAG, {parse_succ = parse_succ, qr_info = qr_info})
      if parse_succ then
        dispatch_qr_info(qr_info, function(scan_result, ...)
          if scan_result then
            if cb then
              cb(true, ...)
            end
          else
            local code, message = ...
            message = transfer_error_message_with_code(code, message)
            if cb then
              if qr_info and qr_info.type == M.SCAN_TYPE.OFFICIAL_SCAN_LOGIN then
                E.LOG.debug(TAG, "账号扫码的失败不需要弹窗，H5已经展示过引导文案给用户了")
              else
                local tip_msg = message
                tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
                modal_open_suit_ios_alert_delay(tip_msg)
              end
              cb(false, code, message)
            end
          end
        end)
      else
        local code = CONSTANTS.QRCODE_ERROR_CODES.QRCODE_PARSE_ERROR
        local tip_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_server_exception", "")
        tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
        modal_open_suit_ios_alert_delay(tip_msg)
        cb(false, code, tip_msg, content)
      end
    else
      local error_code = (...)
      error_code = error_code or CONSTANTS.QRCODE_ERROR_CODES.CODE_SCAN_ERROR
      local error_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_server_exception", "")
      error_msg = error_msg .. "{" .. tostring(error_code) .. "}"
      if _ejoysdk.os() == "android" and tonumber(error_code) == 2002 then
        error_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_no_camera_permission", "")
        error_msg = error_msg .. "{" .. tostring(error_code) .. "}"
      elseif (_ejoysdk.os() == "android" or _ejoysdk.os() == "harmonyos") and tonumber(error_code) == 2006 then
        error_msg = LANG_UTIL.getStringSuitCNOverseas("qrcode_cancel", "")
        error_msg = error_msg .. "{" .. tostring(error_code) .. "}"
      else
        modal_open_suit_ios_alert_delay(error_msg)
      end
      E.LOG.debug(TAG, "qrcode scan fail: " .. tostring(error_code) .. tostring(error_msg))
      local params = {code = error_code, msg = error_msg}
      QL.commit_action_main("ej_qrcode_scan_result", nil, false, params)
      cb(false, error_code, error_msg, "")
    end
  end)
end

function M.grant_qrcode(cb)
  if not cur_scan_qr_info then
    cb(false, ERROR_CODES.CODE_NO_SCAN, "no qr info")
    return
  end
  local is_support, qr_type = check_qr_func_support(cur_scan_qr_info.type, "grant_qrcode", cb)
  E.LOG.debug(TAG, "grant_qrcode check_qr_func_support result:" .. tostring(is_support) .. ", type:" .. tostring(qr_type))
  if not is_support then
    E.LOG.warn(TAG, "grant_qrcode not support")
    return
  end
  qr_modules[qr_type].grant_qrcode(cur_scan_qr_info.uuid, function(grant_result, ...)
    if grant_result then
      if cb then
        cb(true, ...)
      end
    else
      local code, message = ...
      message = transfer_error_message_with_code(code, message)
      if cb then
        local tip_msg = message
        if not close_sdk_scan_error_alert then
          tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
          E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
            message = tip_msg,
            buttons = {
              LANG_UTIL.getStringSuitCNOverseas("confirm", "")
            }
          })
        end
        cb(false, code, message)
      end
    end
  end)
end

function M.query_status(cb)
  if not cur_show_qr_info then
    cb(false, ERROR_CODES.CODE_NO_QRCODE, "no qr code")
    return
  end
  local is_support, qr_type = check_qr_func_support(cur_show_qr_info.type, "query_status", cb)
  E.LOG.debug(TAG, "query_status check_qr_func_support result:" .. tostring(is_support) .. ", type:" .. tostring(qr_type))
  if not is_support then
    E.LOG.warn(TAG, "query_status is not support")
    return
  end
  qr_modules[qr_type].query_status(cur_show_qr_info.uuid, function(query_result, ...)
    if query_result then
      if cb then
        cb(true, ...)
      end
    else
      local code, message = ...
      if cb then
        message = transfer_error_message_with_code(code, message)
        local tip_msg = message
        if not close_sdk_scan_error_alert then
          tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
          E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
            message = tip_msg,
            buttons = {
              LANG_UTIL.getStringSuitCNOverseas("confirm", "")
            }
          })
        end
        cb(false, code, message)
      end
    end
  end)
end

function M.cancel_query_status()
  if not cur_show_qr_info then
    return
  end
  local is_support, qr_type = check_qr_func_support(cur_show_qr_info.type, "cancel_query_status")
  E.LOG.debug(TAG, "cancel_query_status check_qr_func_support result:" .. tostring(is_support) .. ", type:" .. tostring(qr_type))
  if not is_support then
    E.LOG.warn(TAG, "cancel_query_status not support")
    return
  end
  qr_modules[qr_type].cancel_query_status()
  cur_show_qr_info = nil
end

function M.show_qrcode(content)
  E.invoke("SHOW_QRCODE", {content = content})
end

function M.gen_qrcode_bmp(content)
  do return E.QRCode.gen_bmp end
  return E.QRCode.gen_bmp, content
end

function M.get_qrcode(type, cb)
  local is_support, qr_type = check_qr_func_support(type, "get_qrcode", cb)
  E.LOG.debug(TAG, "get_qrcode check_qr_func_support result:" .. tostring(is_support) .. ", type:" .. tostring(qr_type))
  if not is_support then
    E.LOG.warn(TAG, "get_qrcode failed, not support")
    return
  end
  qr_modules[qr_type].get_qrcode(function(succ, ...)
    if succ then
      local content = (...)
      local parse_succ, qr_info = parse_qrcode(content)
      if parse_succ then
        cur_show_qr_info = qr_info
        E.LOG.debug(TAG, "cur_show_qr_info")
        E.LOG.debug(TAG, cur_show_qr_info)
        cb(true, content)
      else
        local code = qr_info
        local message = LANG_UTIL.getStringSuitCNOverseas("qrcode_get_fail", "")
        local tip_msg = message
        if not close_sdk_scan_error_alert then
          tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
          E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
            message = tip_msg,
            buttons = {
              LANG_UTIL.getStringSuitCNOverseas("confirm", "")
            }
          })
        end
        cb(false, code, message)
      end
    else
      local code = (...)
      local message = LANG_UTIL.getStringSuitCNOverseas("qrcode_get_fail", "")
      if cb then
        local tip_msg = message
        if not close_sdk_scan_error_alert then
          tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
          E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
            message = tip_msg,
            buttons = {
              LANG_UTIL.getStringSuitCNOverseas("confirm", "")
            }
          })
        end
        cb(false, code, message)
      end
    end
  end)
end

return M

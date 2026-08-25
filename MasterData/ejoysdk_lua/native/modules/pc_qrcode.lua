local E = require("ejoysdk_lua.ejoysdk")
local QR = require("ejoysdk_lua.qrcode.ejoysdk_qrcode")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.NATIVE .. "modules.pc_qrcode"
local M = {}

function M.get_qrcode_bmp_string(cb)
  QR.get_qrcode(QR.SCAN_TYPE.LOGIN, function(succ, ...)
    E.LOG.debug(TAG, "获取登录二维码结果: " .. tostring(succ))
    if succ then
      local ori_result = (...)
      if ori_result then
        if cb then
          cb(true, ori_result)
        end
      elseif cb then
        local result = {
          code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_QRCODE_GET_DATA_EMPTY,
          msg = "获取二维码结果数据为空"
        }
        cb(false, result)
      end
    else
      local error_code, error_msg = ...
      if cb then
        local result = {code = error_code, msg = error_msg}
        cb(false, result)
      end
    end
  end)
end

function M.get_qrcode_bmp_string_with_cache_for_h5(cb)
  local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
  M.get_qrcode_bmp_string(function(succ, content)
    if succ then
      PROTOCOL.succ_callback(cb, content)
    else
      PROTOCOL.fail_callback(cb, CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_QRCODE_GET_DATA_EMPTY, "获取二维码数据失败")
    end
  end)
end

function M.query_stauts_loop_for_h5(cb)
  M.query_stauts_loop(function(succ, body)
    local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
    if succ then
      E.LOG.debug(TAG, "query_stauts_loop_for_h5, login success---")
      PROTOCOL.succ_callback(cb, body)
    else
      PROTOCOL.fail_callback(cb, body.code or CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_QRCODE_QUERY_DATA_FAILED, body.msg or "轮询二维码失败")
      E.LOG.debug(TAG, "调用轮询接口失败拉")
      E.LOG.debug(TAG, body)
    end
  end)
end

function M.query_stauts_loop(cb)
  QR.query_status(function(succ, ...)
    if succ then
      local _token, body = ...
      if cb then
        cb(true, body)
      end
    else
      local error_code, error_msg = ...
      if cb then
        local result = {code = error_code, msg = error_msg}
        cb(false, result)
      end
    end
  end)
end

function M.cancel_query_status()
  QR.cancel_query_status()
end

function M.login_with_qrcode(cb)
  if E.Sysinfo.os() ~= "windows" and cb then
    local result = {
      code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_QRCODE_DATA_GEN_PICTURE_FAILED,
      msg = "二维码图片生成失败"
    }
    cb(false, result)
  end
  M.get_qrcode_bmp_string(function(succ, ...)
    local ori_result = (...)
    if succ then
      local ret, content = E.QRCode.gen_bmp(ori_result)
      if ret and content then
        local sdkinfo = _ejoysdk.sdkinfo()
        local path = sdkinfo.program_private_dir .. "/qrcode.bmp"
        local file = io.open(path, "wb")
        if file then
          file:write(content)
          file:close()
          E.WebView.open("file://" .. path, nil, nil, nil, function(_value)
            M.cancel_query_status()
          end)
          M.query_stauts_loop(function(...)
            if cb then
              cb(...)
            end
            E.WebView.close()
          end)
        else
          E.LOG.debug(TAG, "io.open write bpm file failed, file is nil.")
        end
      elseif cb then
        local LANG = require("ejoysdk_lua.lang.util")
        local message = LANG.getString("qrcode_get_fail", "Failed to retrieve the QR code. Please retry")
        local result = {
          code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_QRCODE_DATA_GEN_PICTURE_FAILED,
          msg = message
        }
        cb(false, result)
      end
    end
  end)
end

return M

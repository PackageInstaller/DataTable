local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local COMPAT = require("ejoysdk_lua.compat.ejoysdk_compat")
local HTTP = require("ejoysdk_lua.libs.http")
local BitUtil = COMPAT.bitutil
local string_unpack = COMPAT.string.unpack
local M = {}
local TAG = "http_security"

function M.update_sign_headers_ifneeded(method, url, headers, body, content_type)
  local fill_moment_token, fill_ejoy_token
  if headers then
    for k, v in pairs(headers) do
      if type(k) == "string" then
        local lwk = k and k:lower()
        if "moment-token" == lwk then
          fill_moment_token = v
        elseif "ejoy-token" == lwk then
          fill_ejoy_token = v
        end
      end
    end
    if fill_moment_token then
      local EJ_SIGN = require("ejoysdk_lua.libs.signature")
      local url_info = E.HTTP.parse(url)
      if url_info then
        EJ_SIGN.general_authorization(method, url_info.path or "", url_info.query_ori_str or "", headers, body, content_type, fill_moment_token, EJ_SIGN.SIGN.MOMENT_TOKEN)
      end
    end
    if fill_ejoy_token then
      local EJ_SIGN = require("ejoysdk_lua.libs.signature")
      local url_info = E.HTTP.parse(url)
      if url_info then
        EJ_SIGN.general_authorization(method, url_info.path or "", url_info.query_ori_str or "", headers, body, content_type, fill_ejoy_token, EJ_SIGN.SIGN.EJOY_TOKEN)
      end
    end
  end
  return headers, fill_moment_token, fill_ejoy_token
end

function M.sign_headers_for_prevent_replay(method, url, headers, body)
  if headers then
    local url_info = E.HTTP.parse(url)
    if url_info then
      local EJ_SIGN = require("ejoysdk_lua.libs.signature")
      do return EJ_SIGN.general_prevent_replay_request, method, url_info.query_ori_str or "", headers end
      return EJ_SIGN.general_prevent_replay_request, method, url_info.query_ori_str or "", headers, body
    end
  end
  E.LOG.debug(TAG, "headers is nil, something wrong")
  return nil
end

function M.verify_response_for_prevent_modify(request_headers, url, response_headers, body, status)
  local stat = require("ejoysdk_lua.ejoysdk_stat")
  local stat_action = "http_verify_response_fail"
  local header_length = E_UTILS.tablelength(response_headers or {})
  if header_length > 0 then
    local stat_params = {
      response_headers = response_headers,
      url = url,
      request_headers = request_headers,
      response_body = body,
      status = status
    }
    local request_random_num = request_headers["ag-nonce"]
    local response_random_value = response_headers["ag-nonce"]
    if not request_random_num or not response_random_value then
      stat.stat_action(stat_action, "request ag-nonce or response ag-nonce is nil, or two number is nil", false, stat_params)
      return false
    end
    if tonumber(request_random_num) ~= tonumber(response_random_value) then
      E.LOG.debug(TAG, "request ag-nonce not equal response ag-nonce!!!!")
      stat.stat_action(stat_action, "request ag-nonce not equal response ag-nonce", false, stat_params)
      return false
    end
    local sign_value_str = response_headers["platform-resp-signature"]
    if not sign_value_str then
      stat.stat_action(stat_action, "response header platform-resp-signature no value", false, stat_params)
      return false
    end
    if type(sign_value_str) ~= "string" or string.len(sign_value_str) <= 0 then
      stat.stat_action(stat_action, "response header platform-resp-signature no string value or is empty string", false, stat_params)
      return false
    end
    local _, index_end = string.find(sign_value_str, "signature:")
    if not index_end or tonumber(index_end) < 1 or index_end > string.len(sign_value_str) then
      stat.stat_action(stat_action, "response header platform-resp-signature value format wrong", false, stat_params)
      return false
    end
    local signature_value = string.sub(sign_value_str, index_end + 1)
    local EJ_SIGN = require("ejoysdk_lua.libs.signature")
    local signature_result = EJ_SIGN.general_prevent_modify_response(response_headers, body)
    if signature_value ~= signature_result then
      stat_params.signature_result = signature_result
      stat.stat_action(stat_action, "response body signature not equal", false, stat_params)
      return false
    end
    return true
  elseif E.Sysinfo.os() == "windows" then
    local ejoysdk_version = E.get_sdk_version_name("EJOYSDK")
    local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
    if VER_CHECK.compare_versions(ejoysdk_version, "2.4.4") < 0 then
      return true
    end
  end
  local stat_params = {
    response_headers = response_headers,
    url = url,
    request_headers = request_headers,
    response_body = body
  }
  stat.stat_action(stat_action, "response header is empty", false, stat_params)
  E.LOG.debug(TAG, "headers is nil or empty, something wrong")
  return false
end

function M.decrypt_body(body, mtoken)
  local de_body
  local keytype_bit = string_unpack("I1", body:sub(3, 3))
  local keytype_bit_all = 0
  for i = 1, 8 do
    local keytype_bit_s = BitUtil.rshift(BitUtil.band(string_unpack("I1", body:sub(i + 11, i + 11)), 128), i - 1)
    keytype_bit_all = keytype_bit_all + keytype_bit_s
  end
  keytype_bit = BitUtil.bxor(keytype_bit, keytype_bit_all)
  local sign_key
  local ramdom_key = body:sub(7, 38)
  local EJ_SIGN = require("ejoysdk_lua.libs.signature")
  if 0 == tonumber(keytype_bit) then
    sign_key = EJ_SIGN.get_secret(mtoken)
  elseif 1 == tonumber(keytype_bit) then
    sign_key = EJ_SIGN.ejoy_sign_secret
  end
  if sign_key and ramdom_key then
    local final_key = _ejoysdk_crypt.sha1(sign_key .. ramdom_key)
    local rc4_key = _ejoysdk_crypt.rc4_key(final_key)
    E.LOG.debug(TAG, "dencrypt:=>sign_key:" .. tostring(sign_key))
    local body_bit = body:sub(67)
    if body_bit then
      de_body = _ejoysdk_crypt.rc4_decrypt(body_bit, rc4_key)
      if nil == de_body then
        E.LOG.debug(TAG, "dencrypt: body is nil")
      end
    else
      E.LOG.debug(TAG, "dencrypt: body_bit is nil")
    end
  else
    E.LOG.debug(TAG, "dencrypt: key is nil")
  end
  return de_body
end

function M.decode_by_content_type(params, info, body, url, mtoken)
  local acceptable = params.acceptable
  local headers = info.headers
  local content_type = headers and headers["Content-Type"]
  local is_encrypt = 0
  local length = E_UTILS.tablelength(headers or {})
  if _ejoysdk.os() == "windows" and acceptable == E.HTTP.CT_JSON and 0 == length then
    if body and #body >= 1 then
      local firstByte = body:sub(1, 1)
      local magic_num = string_unpack("I1", firstByte)
      if 1 == tonumber(magic_num) then
        is_encrypt = 1
      end
    end
  else
    local ejoy_rpc_info_str = headers and headers["ejoy-rpc-info"]
    if nil == ejoy_rpc_info_str then
      ejoy_rpc_info_str = headers and headers["Ejoy-Rpc-Info"]
    end
    if ejoy_rpc_info_str then
      local si, ei = string.find(ejoy_rpc_info_str, "encrypt%s-=%s-true")
      if si then
        is_encrypt = 1
        local encrypt_str = ejoy_rpc_info_str:sub(si, ei)
        local _, _, ori_content_type = string.find(ejoy_rpc_info_str, "^(.*);%s-" .. tostring(encrypt_str))
        content_type = ori_content_type
      end
    end
  end
  if 1 == is_encrypt then
    local de_ok, result = pcall(M.decrypt_body, body, mtoken)
    if de_ok then
      body = result
    else
      body = nil
      E.LOG.debug(TAG, "dencrypt: body fail")
    end
  end
  if not params.raw_body then
    local stat = require("ejoysdk_lua.ejoysdk_stat")
    local stat_action = "http_decode_fail"
    local stat_params = {
      params = params,
      info = info,
      url = url,
      encrypt = is_encrypt
    }
    if nil == info then
      stat.stat_action(stat_action, "empty_info", false, stat_params)
      return body
    end
    
    local function is_normal_request()
      return info.status == 200 and params.file == nil
    end
    
    if is_normal_request() then
      if nil == body then
        stat.stat_action(stat_action, "nil_body", false, stat_params)
        return body
      elseif "" == body then
        stat.stat_action(stat_action, "empty_body", false, stat_params)
        return body
      end
    end
    if nil == content_type then
      content_type = acceptable
    else
      content_type = content_type:match("^[^;]+")
    end
    if content_type ~= acceptable and nil ~= acceptable then
      stat.stat_action(stat_action, "content_type_diff_acceptable", false, stat_params)
      return nil
    end
    if content_type == E.HTTP.CT_JSON then
      local succ, json = pcall(JSON.decode, body)
      if succ then
        return json
      elseif is_normal_request() then
        _ejoysdk.log("content_type error")
        local error_msg = json
        if error_msg and "string" == type(error_msg) then
          stat_params.error_msg = _ejoysdk_crypt.base64encode(error_msg:sub(1, 500))
        end
        stat.stat_action(stat_action, "content_type_error", false, stat_params)
        return nil
      end
    end
  end
  return body
end

function M.http_get_adapter_security(url, params, cb)
  params = params or {}
  local ejoy_http = require("ejoysdk_lua.ejoysdk_http")
  params.headers = ejoy_http.check_and_update_headers(params.headers)
  local _, mtoken = M.update_sign_headers_ifneeded("get", url, params.headers, "", "")
  
  local function adapter_get_cb(info)
    local body = info.body
    body = M.decode_by_content_type(params, info, body, url, mtoken)
    if not body and info.status == 200 then
      body = {
        code = CONSTANTS.EJOYSDK_ERROR_CODES.HTTP_REQUEST_BODY_NIL,
        message = "resp body is nil"
      }
    end
    info.body = body
    if cb then
      cb(info)
    end
  end
  
  do return HTTP.get, url, params end
  return HTTP.get, url, params, adapter_get_cb
end

function M.http_post_adapter_security(url, params, content_type, body, cb)
  params = params or {}
  local ejoy_http = require("ejoysdk_lua.ejoysdk_http")
  params.headers = ejoy_http.check_and_update_headers(params.headers)
  if params.headers["Content-Type"] then
    assert(params.headers["Content-Type"] == content_type)
  end
  params.headers["Content-Type"] = content_type
  params["Content-Type"] = content_type
  body = HTTP.body_tostring(body, content_type)
  if params.enable_sign_headers_for_request then
    M.sign_headers_for_prevent_replay("post", url, params.headers, body)
  end
  local _, mtoken = M.update_sign_headers_ifneeded("post", url, params.headers, body, content_type)
  
  local function adapter_cb(info)
    local resp_body = info.body
    local status = info.status
    local status_need_verify_body = false
    if nil ~= status and type(status) == "number" and (status >= 200 and status < 300 or 0 == status) then
      status_need_verify_body = true
    end
    if params.enable_sign_headers_for_response and status_need_verify_body then
      local signature_right = M.verify_response_for_prevent_modify(params.headers, url, info.headers, resp_body, status)
      if not signature_right then
        info.body = {
          code = CONSTANTS.EJOYSDK_ERROR_CODES.HTTP_RESPONSE_VERIFY_FAIL,
          message = "resp body is verify failed"
        }
        cb(info)
        return
      end
    end
    resp_body = M.decode_by_content_type(params, info, resp_body, url, mtoken)
    if not resp_body and 200 == status then
      resp_body = {
        code = CONSTANTS.EJOYSDK_ERROR_CODES.HTTP_REQUEST_BODY_NIL,
        message = "resp body is nil"
      }
    end
    info.body = resp_body
    if cb then
      cb(info)
    end
  end
  
  do return HTTP.post, url, params, content_type, body end
  return HTTP.post, url, params, content_type, body, adapter_cb
end

return M

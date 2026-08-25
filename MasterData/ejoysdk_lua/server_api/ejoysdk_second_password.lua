local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local sec_psw_api = BASE_API:New("safebox")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.SERVER_API .. "sec_password"
local M = {}
local password_type = 1

local function encrypt_password(password)
  local rc4_init_key = "rc4_key_ZWxpeGlyaQ=="
  local rc4_key = _ejoysdk_crypt.rc4_key(rc4_init_key)
  local encrypt_key = _ejoysdk_crypt.rc4_encrypt(password, rc4_key)
  do return _ejoysdk_crypt.base64encode end
  return _ejoysdk_crypt.base64encode, encrypt_key
end

function M.get_status(cb)
  local headers = {}
  local body = {
    device_id = E.get_pkg_info().utdid
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/secondlock/get_current_status", headers, body, opt, function(succ, ...)
    if succ then
      local result = (...)
      local lock_info = result.lock_info
      cb(true, lock_info)
    else
      cb(false, ...)
    end
  end)
end

function M.set_password(password, cb)
  local headers = {}
  local body = {
    password = encrypt_password(password),
    type = password_type,
    device_id = E.get_pkg_info().utdid or ""
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/set_password", headers, body, opt, cb)
end

function M.close(password, cb)
  local headers = {}
  local body = {
    password = encrypt_password(password),
    device_id = E.get_pkg_info().utdid
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/secondlock/lock_close", headers, body, opt, cb)
end

function M.open(cb)
  local headers = {}
  local body = {}
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/secondlock/lock_open", headers, body, opt, cb)
end

function M.apply_remove(cb)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local headers = {}
  local body = {
    ptoken = EG.user_info().ptoken,
    pkg_info = E.get_pkg_info()
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/apply_message", headers, body, opt, cb)
end

function M.remove(message_code, cb)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local headers = {}
  local body = {
    message = tostring(message_code),
    type = password_type,
    ptoken = EG.user_info().ptoken,
    pkg_info = E.get_pkg_info()
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/remove", headers, body, opt, cb)
end

function M.remove_by_password(password, cb)
  local headers = {}
  local body = {
    password = encrypt_password(password),
    type = password_type
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/remove_by_password", headers, body, opt, cb)
end

function M.change_password(old_password, new_password, cb)
  local headers = {}
  local body = {
    password_old = encrypt_password(old_password),
    password_new = encrypt_password(new_password),
    type = password_type,
    device_id = E.get_pkg_info().utdid or ""
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/change_password", headers, body, opt, cb)
end

function M.verify(password, cb)
  local headers = {}
  local body = {
    password = encrypt_password(password),
    type = password_type
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/verify", headers, body, opt, cb)
end

function M.get_security_mobile(cb)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local headers = {}
  local body = {
    ptoken = EG.user_info().ptoken,
    pkg_info = E.get_pkg_info()
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/get_security_mobile", headers, body, opt, function(succ, ...)
    if not succ then
      cb(false, ...)
      return
    end
    local result = (...)
    local security_mobile = result.security_mobile
    cb(true, security_mobile)
  end)
end

function M.password_appeal(cb)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local headers = {}
  local _body = {
    device_id = E.get_pkg_info().utdid,
    client = {
      token = EG.user_info().ptoken or "",
      gameId = E.get_pkg_info().game_id or "",
      accountId = EG.user_info().uid or ""
    }
  }
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/appeal", headers, _body, opt, function(succ, ...)
    local auto_appeal_failed_code = 10410
    if not succ then
      local code, _msg, body = ...
      if code == auto_appeal_failed_code then
        local url = ""
        if body and body.data and body.data.submitCasePageUrl and type(body.data.submitCasePageUrl) == "string" and #body.data.submitCasePageUrl > 0 then
          url = body.data.submitCasePageUrl
        end
        if #url > 0 then
          E.open_webview(url, {
            ".aligames.cn",
            ".aligames.com"
          }, {}, nil, nil, nil)
        end
      end
      cb(false, ...)
      return
    end
    cb(true, ...)
  end)
end

function M.password_cancel_appeal(cb)
  local headers = {}
  local body = {type = password_type}
  local opt = {use_ejoy_token = true}
  sec_psw_api:post("/sdk_api/password/cancel_appeal", headers, body, opt, cb)
end

return M

local BRIDGE = require("ejoysdk_lua.ejoysdk_js_bridge_adapter")
local Class = require("ejoysdk_lua.ejoysdk_class")
local LoginResult = Class:Inherit("LoginResult")
local M = {}
M.TOKEN_TYPE = {ACCOUNT = "ac", CHANNEL = "ch"}

function LoginResult.succ(platform, user_info, ext)
  user_info = user_info or {}
  local obj = LoginResult:New()
  obj.platform = platform
  obj.token = user_info.token
  obj.uid = user_info.uid
  obj.ext = ext or {}
  return obj
end

function LoginResult.fail(code, msg, ext)
  local obj = LoginResult:New()
  obj.code = code or -1
  obj.msg = msg or "unknown error"
  obj.ext = ext or {}
  return obj
end

function LoginResult:is_succ()
  return self and self.token and type(self.token) == "string" and self.token ~= ""
end

M.LoginResult = LoginResult

local function callback(cb, s, b)
  if cb then
    cb({
      succ = s,
      body = b or {},
      ver = BRIDGE.VER.V2
    })
  end
end

function M.succ_callback(cb, body)
  callback(cb, true, body)
end

function M.fail_callback(cb, ec, em, ei)
  callback(cb, false, {
    err_code = ec or -1,
    err_msg = em,
    ext_info = ei or {}
  })
end

function M.make_succ_resp(body)
  return {
    succ = true,
    body = body or {},
    ver = BRIDGE.VER.V2
  }
end

function M.make_fail_resp(ec, em, ei)
  return {
    succ = false,
    body = {
      err_code = ec or -1,
      err_msg = em,
      ext_info = ei or {}
    }
  }
end

return M

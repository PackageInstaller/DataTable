local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local EUC = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local AL = require("ejoysdk_lua.account.service.account_login")
local TAG = EM.MODULE.OVERSEAS .. "user"
local M = {}

function M.user_info(cb)
  local gangplank_user_info = EG.user_info()
  if gangplank_user_info and gangplank_user_info.token and string.len(gangplank_user_info.token) > 0 then
    local user_tokens = {
      ejoy_token = gangplank_user_info.token,
      ptoken = gangplank_user_info.ptoken
    }
    if EUC.user_info() and EUC.user_info().token and string.len(EUC.user_info().token) then
      user_tokens.usercenter_token = EUC.user_info().token
    end
    PROTOCOL.succ_callback(cb, user_tokens)
  else
    PROTOCOL.fail_callback(cb, CONSTANTS.OFFICIAL_ERR_CODES.CODE_NO_LOGIN, "没登录")
  end
end

function M.bind(type, cb)
  AL.bind(type, nil, function(bind_result)
    if not bind_result or not bind_result:is_succ() then
      bind_result = bind_result or {}
      local err_code = bind_result.code
      local err_msg = bind_result.msg
      E.LOG.debug(TAG, "bind failed, err_code=" .. (err_code or CONSTANTS.OFFICIAL_ERR_CODES.CODE_BIND_FAIL))
      PROTOCOL.fail_callback(cb, err_code or CONSTANTS.OFFICIAL_ERR_CODES.CODE_BIND_FAIL, err_msg or "绑定失败")
    else
      E.LOG.debug(TAG, "bind succ")
      PROTOCOL.succ_callback(cb)
    end
  end)
end

M.logout = EG.logout
return M

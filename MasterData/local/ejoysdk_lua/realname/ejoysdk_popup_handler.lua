local E = require("ejoysdk_lua.ejoysdk")
local DS_PROTOCOL = require("ejoysdk_lua.protocol.aligames_protocol")
local EM = require("ejoysdk_lua.ejoysdk_module")
local INTERCEPT = require("ejoysdk_lua.realname.ejoysdk_login_intercept")
local TAG = EM.MODULE.REALNAME .. "popup_handler"
local M = {}
M.ERR_CODE_NEED_REALNAME_OR_ANTI_ADDICTION = 427

function M.show_popup_with_config(config, cb)
  INTERCEPT.handle_popup_config(config, cb)
end

M.handle_realname_pages = INTERCEPT.handle_lx_realname
M.handle_overseas_realname_page = INTERCEPT.handle_realname

function M.handle_login_reject_error(status, ejoy_token, attach_info, cb)
  E.LOG.debug(TAG, "handle_login_reject_error, status:" .. tostring(status) .. " ejoy_token:" .. tostring(ejoy_token))
  if attach_info then
    DS_PROTOCOL.set_si(attach_info.guestId)
  end
  if nil == attach_info or nil == next(attach_info) or nil == next(attach_info.popupConfigList or {}) then
    E.LOG.debug(TAG, "attach_info or popup list is empty, no need realname or anti addiction")
    E.LOG.debug(TAG, attach_info or "nil")
    return false
  end
  if status ~= M.ERR_CODE_NEED_REALNAME_OR_ANTI_ADDICTION and 200 ~= status then
    E.LOG.debug(TAG, "status no recognized, no need realname or anti addiction")
    return false
  end
  E.LOG.debug(TAG, "handle_login_reject_error popup handler handled this status")
  local popup_info = attach_info.popupConfigList[1]
  INTERCEPT.handle_popup_info(popup_info, cb)
  return true
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local AGST_TOKEN = require("ejoysdk_lua.user_center.agst_token_manager")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local AGST_VENDOR_NAME = "AGST"
local AGST = Vendor:Inherit(AGST_VENDOR_NAME)
AGST.VENDOR_NAME = AGST_VENDOR_NAME
local AGST_OFFICIAL_SIGN = E.LazyKeyStore:New("AGST_OFFICIAL_SIGN")
local TAG = EM.MODULE.VENDORS.AGST_ACC
AGST.login_cb = nil

function AGST.init(opt, cb)
  AGST.opt = opt
  cb(true)
end

function AGST.login(_ext, cb)
  AGST.login_cb = cb
  E.LOG.debug(TAG, "agst login begin")
  AGST_TOKEN.get_token(function(agst_token)
    local channel_result = PROTOCOL.LoginResult.succ(AGST.VENDOR_NAME, {
      token = agst_token or "",
      guest = true
    }, {})
    AGST.login_cb(channel_result)
  end)
end

function AGST.login_fail(status, _last_login_params, _fail_cb)
  if E.Sysinfo.os() == "ios" and 401 == status then
    E.LOG.debug(TAG, "iOS agst token invalid, delete")
    AGST_TOKEN.clear_token()
    AGST.login({}, AGST.login_cb)
    return true
  end
  return false
end

function AGST.logout()
  E.LOG.debug(TAG, "agst receive logout")
  AGST.opt.logout_listener({})
end

function AGST.merge_info(info, pinfo)
  do return AGST.merge_helper, info end
  return AGST.merge_helper, info, pinfo
end

function AGST.simple_token()
  return false
end

function AGST.check_token(_outsource, _info)
  AGST.login()
end

function AGST.mark_agst_official()
  AGST_OFFICIAL_SIGN:set(true)
end

function AGST.clear_agst_official_sign()
  AGST_OFFICIAL_SIGN:delete()
end

function AGST.has_marked_agst_official()
  return AGST_OFFICIAL_SIGN:get() or false
end

AGST:is_implemented({"ACCOUNT"})
return AGST

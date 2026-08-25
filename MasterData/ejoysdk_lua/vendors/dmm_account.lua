local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CAST_INIT = "CAST_INIT"
local VENDOR_NAME = "DMM_LOGIN"
local DMM = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.DMM_ACC
local dmm_appid = ""
local logout_invoke = false

local function login_callback(succ, info, _ext_paramas)
  local channel_result
  if succ then
    E.LOG.debug(TAG, "register_login_listener succ, info.token:" .. tostring(info.token or "") .. " ,userid:" .. tostring(info.pid or "nil"))
    local pt = {}
    if _ejoysdk.os() == "windows" then
      pt.type = "token"
      pt.appid = dmm_appid
      pt.onetimeToken = info.token
      pt.viewerId = info.pid
    else
      pt.type = "callback"
      pt.token = info.token
    end
    local userInfo = {
      token = JSON.encode(pt),
      uid = info.pid,
      guest = false
    }
    local ext = {}
    channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, ext)
  else
    E.LOG.warn(TAG, "register_login_listener failed >>")
    E.LOG.debug(TAG, info)
    local code = info.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
    local msg = info.msg or "login failed unknown reason"
    channel_result = PROTOCOL.LoginResult.fail(code, msg)
  end
  if DMM.login_cb then
    DMM.login_cb(channel_result)
  end
end

function DMM.init(opt, cb)
  DMM.opt = opt
  local sdk_info = UNI.get_sdk_info(VENDOR_NAME)
  if sdk_info and sdk_info.meta and type(sdk_info.meta.appid) == "string" and #sdk_info.meta.appid > 0 then
    dmm_appid = sdk_info.meta.appid
  end
  
  local function logout_callback(ext_params)
    E.LOG.debug(TAG, "logout_listener >>")
    if not logout_invoke then
      DMM.opt.logout_listener(ext_params)
    end
  end
  
  UNI.register_login_listener(VENDOR_NAME, login_callback)
  UNI.register_logout_listener(VENDOR_NAME, logout_callback)
  ET.subscribe(ET.gangplank.ACQUIRE_FAILED, function(_fail_info)
    E.LOG.debug(TAG, "dmm login fail>>")
    DMM.logout({manual = true})
  end)
  if sdk_info and sdk_info.meta then
    local meta_data = UTILS.deepcopy(sdk_info.meta)
    if "string" ~= type(meta_data.gameserver_url) or #meta_data.gameserver_url <= 0 then
      local global_config = EGC.get_current_cdn_config()
      if global_config and global_config.account_center then
        meta_data.gameserver_url = global_config.account_center .. "/dmm/login"
      end
    end
    UNI.cast(VENDOR_NAME, CAST_INIT, meta_data)
  end
  cb(true)
end

local function auto_login(viewer_id, onetime_token)
  if type(viewer_id) == "string" and #viewer_id > 0 and type(onetime_token) == "string" and #onetime_token > 0 then
    local userinfo = {pid = viewer_id, token = onetime_token}
    login_callback(true, userinfo)
    return true
  end
  login_callback(false)
  return false
end

function DMM.login(ext, cb)
  DMM.login_cb = cb or function()
  end
  E.LOG.debug(TAG, "call dmm login")
  logout_invoke = false
  ext = ext or {}
  if not ext.silent_login then
    E.LOG.debug(TAG, "not autologin, ready to launch dmm login page")
    if _ejoysdk.os() ~= "windows" then
      UNI.login(VENDOR_NAME, {})
    else
      local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT
      local msg = "DMM login Not Support"
      local channel_result = PROTOCOL.LoginResult.fail(code, msg)
      DMM.login_cb(channel_result)
    end
  else
    local init_args = E.CONFIG.get_config(E.CONFIG.KEY.INIT_ARGS)
    local args = DMM.check_args(init_args)
    if not args then
      E.LOG.debug(TAG, "channel login fail, missing params")
      cb(PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_DMM_FAILED_NOT_SUPPORT, "Missing Login Parameters: " .. VENDOR_NAME))
    else
      auto_login(args.uid, args.token)
    end
  end
end

function DMM.is_support()
  return UNI.get_sdk_info(VENDOR_NAME) ~= nil
end

function DMM.check_args(args)
  if type(args) == "table" and type(args.viewer_id) == "string" and "string" == type(args.onetime_token) and #args.viewer_id > 0 and #args.onetime_token > 0 then
    return {
      uid = args.viewer_id,
      token = args.onetime_token
    }
  end
  return nil
end

function DMM.can_auto_login()
  if _ejoysdk.os() == "windows" then
    return false
  end
  return true
end

function DMM.check_token(_outsource, _info)
  DMM.login()
end

function DMM.logout(params)
  params = params or {}
  logout_invoke = params.manual or false
  UNI.logout(VENDOR_NAME)
end

function DMM.merge_info(info, pinfo)
  do return DMM.merge_helper, info end
  return DMM.merge_helper, info, pinfo
end

function DMM.simple_token()
  return false
end

DMM:is_implemented({"ACCOUNT"})
return DMM

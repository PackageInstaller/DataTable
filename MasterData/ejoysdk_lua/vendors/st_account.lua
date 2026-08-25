local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local ST_VENDOR_NAME = "ST_LOGIN"
local ST = Vendor:Inherit(ST_VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.ST_ACC
local OFFICIAL_QUERY = E.LazyKeyStore:New("OFFICIAL_QUERY_ST", false, true, false)

local function get_current_region_key()
  local curr_region = E.CONFIG.get_config("region")
  if curr_region then
    curr_region = curr_region:lower()
  else
    curr_region = "unknown"
  end
  return curr_region
end

local current_login_third_platform

function ST.set_official_query(query)
  if query and query.st then
    E.LOG.debug(TAG, "set_official_query now begin set query, access_token:" .. tostring(query.st))
    query.region = get_current_region_key()
    OFFICIAL_QUERY:set(query)
  else
    E.LOG.warn(TAG, " failed, for query is not valid!")
  end
end

function ST.init(opt, cb)
  ST.opt = opt
  ET.subscribe(ET.gangplank.ACQUIRE, function(user_info)
    local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if user_info and (user_info.platform == ST_VENDOR_NAME or not is_overseas) then
      E.LOG.debug(TAG, "ST.login succ")
      ST.set_official_query({
        st = user_info.st or user_info.ptoken
      })
      STAT.stat_bizid("quick_login_result", "4", "1", {})
    end
  end)
  cb(true)
end

local function get_official_query()
  local curr_region = get_current_region_key()
  local official_query = OFFICIAL_QUERY:get()
  if official_query and official_query.region == curr_region then
    return official_query
  else
    local last_region = "unknown"
    if official_query then
      last_region = official_query.region or "unknown"
    end
    E.LOG.warn(TAG, "get_official_query for current region failed, current region NOT has airline cache, current region:" .. tostring(curr_region) .. ", last region:" .. tostring(last_region))
    return nil
  end
end

local function clear_official_query()
  OFFICIAL_QUERY:set(nil)
end

function ST.login(ext_params, cb)
  ST.login_cb = cb
  ext_params = ext_params or {}
  E.LOG.debug(TAG, "st login begin")
  E.LOG.debug(TAG, "ext_params ===")
  E.LOG.debug(TAG, ext_params)
  current_login_third_platform = ext_params.platform or nil
  local result = {platform = ST_VENDOR_NAME, guest = false}
  local ext = {
    origin_platform = ext_params.platform,
    thirdparty_type = ext_params.thirdparty_type or "",
    account_os = ext_params.account_os or ""
  }
  if ST.can_auto_login() then
    local official_query = get_official_query()
    E.LOG.debug(TAG, "ST.login, now proxy_login_type is login, has cache and then directly return cache token >>")
    E.LOG.debug(TAG, official_query)
    if official_query then
      result.token = official_query.st
      result.uid = official_query.uid
    end
  end
  if not result.token or "" == result.token then
    E.LOG.debug(TAG, "ST.login, now proxy_login_type is login, NOT has cache, try to read from ext_params or ext_params.pass_ext")
    result.token = ext_params.st
    result.uid = ext_params.uid
  end
  E.LOG.debug(TAG, " ST.login, result = ")
  E.LOG.debug(TAG, result)
  local channel_result
  if result.token and "" ~= result.token then
    channel_result = PROTOCOL.LoginResult.succ(ST_VENDOR_NAME, result, ext)
  else
    E.LOG.debug(TAG, "ST.login called，token is empty")
    local code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_ST_PARAMS_EMPTY
    local msg = "service ticket is empty"
    channel_result = PROTOCOL.LoginResult.fail(code, msg)
  end
  E.LOG.debug(TAG, "channel_result ====")
  E.LOG.debug(TAG, channel_result)
  ST.login_cb(channel_result)
  STAT.stat_bizid("quick_login", "5", "1", {})
end

function ST.can_auto_login()
  local query = get_official_query()
  local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
  local last_vendor = AUTO_LOGIN.get_last_login()
  return nil ~= last_vendor and string.len(last_vendor) > 0 and nil ~= query and "" ~= query and nil ~= query.st
end

ST.check_token = ST.login
ST.merge_info = ST.merge_helper

function ST.simple_token()
  return false
end

function ST.login_fail(_status, _last_login_params, _fail_cb)
  STAT.stat_bizid("quick_login_result", "4", "0", {
    code = _status or -1
  })
  return false
end

function ST.logout()
  E.LOG.debug(TAG, "st receive logout")
  clear_official_query()
  if current_login_third_platform and "GOOGLE" == current_login_third_platform then
    E.LOG.debug(TAG, "current st login third platform google, call google logout")
    local google_vendor = require("ejoysdk_lua.vendors.google")
    google_vendor.logout({manual = true})
  end
  ST.opt.logout_listener({})
end

ST:is_implemented({"ACCOUNT"})
return ST

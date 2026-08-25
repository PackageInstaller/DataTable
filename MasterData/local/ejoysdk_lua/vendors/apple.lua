local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ER = require("ejoysdk_lua.ejoysdk_resource")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local CHANNEL = "APPLE"
local TAG = EM.MODULE.VENDORS.APPLE
local M = Vendor:Inherit(CHANNEL)
M.LoginTopic = "GameCenterLogin"
M.login_cb = nil
local GAMECENTER_EVENT = "GAMECENTER_EVENT"
local GAMECENTER_EVENT_TYPE_SUCCESS = 0
local GAMECENTER_EVENT_TYPE_UNAVAIABLE = 1
local GAMECENTER_EVENT_TYPE_USER_CANCEL = 2
local GAMECENTER_EVENT_TYPE_USER_LOGOUT = 3
local GAMECENTER_EVENT_TYPE_APPLE_DECLINE = 4
local game_center_info
local on_login = false

local function try_callback()
  if not game_center_info then
    return
  end
  if not on_login then
    return
  end
  on_login = false
  local channel_result
  if game_center_info.succ then
    local info = {
      display_name = game_center_info.displayName,
      alias = game_center_info.alias
    }
    channel_result = PROTOCOL.LoginResult.succ(CHANNEL, {
      token = game_center_info.token or "",
      guest = false
    }, info)
  else
    local temp_msg = "gamecenter login failed"
    local temp_code = CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
    if game_center_info.value and type(game_center_info.value) == "string" then
      temp_code = CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_GAMECENTER_LOGOUT
      temp_msg = game_center_info.value
      game_center_info.value = {code = temp_code, msg = temp_msg}
    elseif game_center_info.value and type(game_center_info.value) == "table" then
      temp_code = game_center_info.value.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      temp_msg = game_center_info.value.msg or "login failed unknown reason"
    end
    channel_result = PROTOCOL.LoginResult.fail(temp_code, temp_msg)
  end
  M.login_cb(channel_result)
end

local function dismiss_loading_time_out()
  E.Timer.once(5, function()
    E.Loading.dismiss()
  end)
end

_ejoysdk.register_cb(GAMECENTER_EVENT, function(cbid, value)
  E.LOG.debug(TAG, "vendors apple cbid: " .. tostring(cbid))
  E.LOG.debug(TAG, {
    tag = "gamecenter tag",
    value = value
  })
  E.Loading.dismiss()
  if cbid == GAMECENTER_EVENT_TYPE_SUCCESS then
    value.token = M.make_token(value)
    value.succ = true
    game_center_info = value
    try_callback()
    return
  end
  if cbid == GAMECENTER_EVENT_TYPE_USER_LOGOUT then
    ET.publish(M.LoginTopic, ER.game_center.USER_LOGOUT)
  elseif cbid == GAMECENTER_EVENT_TYPE_USER_CANCEL then
    ET.publish(M.LoginTopic, ER.game_center.USER_CANCEL)
  elseif cbid == GAMECENTER_EVENT_TYPE_APPLE_DECLINE then
    ET.publish(M.LoginTopic, ER.game_center.APPLE_DECLINE)
  elseif cbid == GAMECENTER_EVENT_TYPE_UNAVAIABLE then
    ET.publish(M.LoginTopic, ER.game_center.UNAVAIABLE)
  end
  game_center_info = {succ = false, value = value}
  try_callback()
end)

function M.init(opt, cb)
  M.opt = opt
  E.LOG.debug(TAG, "game center init")
  cb(true)
end

function M.can_auto_login()
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) or false
  return is_overseas
end

function M.need_sdk_login()
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) or false
  E.LOG.debug(TAG, "is oversea >> " .. tostring(is_overseas))
  return false == is_overseas
end

function M.login(_ext, cb)
  on_login = true
  M.login_cb = cb
  E.LOG.debug(TAG, "game center login begin")
  _ejoysdk.gamecenter_enable()
  E.Loading.show()
  dismiss_loading_time_out()
end

function M.logout()
  M.opt.logout_listener({})
end

function M.simple_token()
  return false
end

function M.merge_info(a, b)
  do return M.merge_helper, a end
  return M.merge_helper, a, b
end

function M.check_token(_outsource, _info)
  M.login()
end

function M.product_list()
  return {}
end

function M.can_pay()
  return false
end

function M.pay(_product_id, _count, _order_id, _body)
  E.LOG.error(TAG, "apple pay error, should use officialpay or ejoypay instead")
end

function M.supportAuth()
  if _ejoysdk.os() ~= "ios" then
    E.LOG.debug(TAG, "is not ios")
    return false
  end
  local CONFIG = require("ejoysdk_lua.ejoysdk_config")
  local support = CONFIG.has_vendor_config("APPLE")
  E.LOG.debug(TAG, "return apple support >> " .. tostring(support))
  return support
end

function M.make_token(info)
  local token = {
    player_id = info.player_id,
    team_player_id = info.team_player_id,
    game_player_id = info.game_player_id,
    display_name = info.displayName,
    alias = info.alias,
    bundle_id = info.bundle_id,
    underage = info.underage,
    public_key_url = info.public_key_url,
    signature = _ejoysdk_crypt.base64encode(info.signature),
    salt = _ejoysdk_crypt.base64encode(info.salt),
    timestamp = info.timestamp,
    sign_version = info.sign_version or ""
  }
  local jsonstr = JSON.encode(token)
  do return _ejoysdk_crypt.base64encode end
  return _ejoysdk_crypt.base64encode, jsonstr
end

M:is_implemented({"PAY"})
return M

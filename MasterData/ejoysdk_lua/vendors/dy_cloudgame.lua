local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local UIM = require("ejoysdk_lua.user_info_manager")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local VENDOR_NAME = "DYCLOUDGAME"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.DYCLOUDGAME
local ASYNC_REQUEST_CLOUD_GAME_TOKEN = "ASYNC_REQUEST_CLOUD_GAME_TOKEN"
local SYNC_IS_RUNNING_CLOUD = "SYNC_IS_RUNNING_CLOUD"
local LUA_KEY_IS_RUNNING_CLOUD = "is_running_cloud"
local ERROR_MESSAGE_NOT_SUPPORT = "cloud game not support"
local INIT_EVENT_NAME = "sdk.douyin.cloudgame.init"
local INJECT_METHODS = {
  ["ejoysdk_lua.ejoysdk_gangplank"] = {
    pay = function(_origin_method, ...)
      _ejoysdk.log(TAG .. "#dy cloud game not support pay")
      EG.get_listener().pay_listener(false, "", CONSTANTS.ONE_KEY_ENTER_GAME_CODE.NOT_SUPPORT_FUNC, ERROR_MESSAGE_NOT_SUPPORT, {})
    end,
    can_show_user_center = function(_origin_method, ...)
      _ejoysdk.log(TAG .. "#dy cloud game not support user center")
      return false
    end
  }
}

function M.init(_opt, cb)
  E.LOG.debug(TAG, "init dy cloud game")
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_IS_RUNNING_CLOUD, {}, nil)
  local is_running_cloud = false
  if ret then
    E.LOG.debug(TAG, "SYNC_IS_RUNNING_CLOUD return")
    E.LOG.debug(TAG, {ret = ret})
    is_running_cloud = ret[LUA_KEY_IS_RUNNING_CLOUD]
    UIM.set_channel_cloud_game_tag(is_running_cloud)
    if is_running_cloud then
      E.LOG.debug(TAG, "inject methods")
      local BL = require("ejoysdk_lua.cloud_game.base_logic")
      BL.inject_methods(INJECT_METHODS)
    end
    M.get_cloud_game_token()
  end
  local params = {is_cloud = is_running_cloud}
  QL.commit_event(INIT_EVENT_NAME, params, true)
  if cb then
    cb(true)
  end
end

function M.get_cloud_game_token()
  UNI.async_call(VENDOR_NAME, ASYNC_REQUEST_CLOUD_GAME_TOKEN, {}, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_REQUEST_CLOUD_GAME_TOKEN result, succ >> " .. tostring(succ))
    if succ then
      local body = (...)
      local cloudGameToken = body.result
      E.LOG.debug(TAG, "get cloud game token return >>" .. tostring(cloudGameToken))
    else
      E.LOG.debug(TAG, "get cloud game token return false")
    end
  end)
end

return M

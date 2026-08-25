local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EI = require("ejoysdk_lua.ejoysdk_init")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local UIM = require("ejoysdk_lua.user_info_manager")
local VENDOR_NAME = "PREDOWNLOAD"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.PREDOWNLOAD
local inited
local SYNC_START_GAME = "SYNC_START_GAME"
local ASYNC_OPEN_WEBVIEW = "ASYNC_OPEN_WEBVIEW"
local LUA_KEY_DIRECT_START_GAME_ACTIVITY = "direct_start_game_activity"

local function login_handler(_user_info)
end

local function gangplank_logout_handler()
end

local is_gangplank_inited = false

function M.start_game_activity(direct_start_game_activity)
  local params = {
    [LUA_KEY_DIRECT_START_GAME_ACTIVITY] = direct_start_game_activity
  }
  if is_gangplank_inited then
    E.LOG.debug(TAG, "gangplank initted, now start_game_activity")
    UNI.sync_call(VENDOR_NAME, SYNC_START_GAME, params, nil)
  else
    local ALL_CHANNEL = "ALL"
    UNI.register_init_listener(ALL_CHANNEL, function(succ2, msg)
      if succ2 then
        E.LOG.debug(TAG, "native init succ, now start game activity")
        UNI.sync_call(VENDOR_NAME, SYNC_START_GAME, params, nil)
      else
        E.LOG.warn(TAG, "native init failed")
      end
    end)
    local _params = {}
    UNI.init(ALL_CHANNEL, _params)
  end
end

function M.open_url(_url, params, cb)
  params = params or {}
  local injection = params.injection
  local options = params.options
  local _params = {
    url = _url,
    injection = injection,
    options = options
  }
  UNI.async_call(VENDOR_NAME, ASYNC_OPEN_WEBVIEW, _params, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "open_url succ")
    else
      local code, msg = ...
      E.LOG.debug(TAG, "open_url ret, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

local function gangplank_inited_handler()
  E.LOG.debug(TAG, "recev gangplank inited")
  is_gangplank_inited = true
end

function M.init(_opt, cb)
  if inited then
    E.LOG.debug(TAG, "predownload had inited")
    return
  end
  inited = true
  local EPRD = require("ejoysdk_lua.predownload.ejoysdk_predownload")
  if EPRD.is_finish_predownload() then
    local predownload_game_info = {
      [UIM.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE] = "predownload_finish",
      [UIM.PKG_INFO_KEY.KEY_PKG_GAME_RUN_MODE_TYPE] = "predownload_finish"
    }
    UIM.set_predownload_game_mode(predownload_game_info)
    EPRD.stat_finish()
  end
  E.LOG.debug(TAG, "predownload vendor start init!")
  ET.subscribe(EI.SUBSCRIBE_GANGPLANK_INITED, gangplank_inited_handler)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  cb(true)
end

return M

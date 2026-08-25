local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JF = require("ejoysdk_lua.vendors.jf")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local CHANNEL = "DOUYIN"
local CHANNEL_MINI = "DOUYIN_MINI"
local TAG = EM.MODULE.VENDORS.DOUYIN
local DOUYIN = Vendor:Inherit(CHANNEL)
local inited = false
local clientKey
local ASYNC_REQUEST_DOUYIN_CODE = "ASYNC_REQUEST_DOUYIN_CODE"
local DOUYIN_TIMEOUT = 6000

local function get_player_token_handler()
  local player_info = EG.player_info()
  if not player_info or player_info and player_info.is_valid == false then
    E.LOG.debug(TAG, "player_info = nil or player_info.is_valid = false, ignore bind player")
    return
  end
  local push_api = require("ejoysdk_lua.server_api.push_ex")
  push_api.bind_channel("douyin", push_api.COLLECT_TYPE_PLAYERID, player_info.player_id)
end

local function acquire_succ_handler()
  local user_info = EG.user_info()
  local push_api = require("ejoysdk_lua.server_api.push_ex")
  push_api.bind_channel("douyin", push_api.COLLECT_TYPE_ACCOUNT, user_info.uid)
end

local function login_dy_mini(cb)
  local channel_result
  local params = {
    timeout = DOUYIN_TIMEOUT,
    success = function(res)
      E.LOG.debug(TAG, "douyin login success")
      local code = res.code
      local thirdPartyToken = {accessToken = code, clientId = clientKey}
      local user_info = {
        token = JSON.encode(thirdPartyToken)
      }
      channel_result = PROTOCOL.LoginResult.succ(CHANNEL_MINI, user_info, {thirdparty_type = CHANNEL})
      E.LOG.debug(TAG, channel_result)
      cb(channel_result)
    end,
    fail = function(res)
      E.LOG.debug(TAG, "douyin login fail")
      channel_result = PROTOCOL.LoginResult.fail(-1, "douyin login get code fail: " .. tostring(res.errMsg), {
        DOUYIN_code = res.errno
      })
      cb(channel_result)
    end,
    complete = function(res)
      E.LOG.debug(TAG, "douyin login complete")
    end
  }
  _ejoysdk.dy.login(params)
end

function DOUYIN.login(_ext, cb)
  E.LOG.debug(TAG, "douyin login start")
  if _ejoysdk.os() == "douyin" then
    login_dy_mini(cb)
  else
    local params = {
      request_code = "wechat_sdk_request_code",
      scope = "user_info,trial.whitelist"
    }
    UNI.async_call(CHANNEL, ASYNC_REQUEST_DOUYIN_CODE, params, nil, function(succ, ...)
      E.LOG.debug(TAG, "request douyin code return, succ >> " .. tostring(succ))
      E.LOG.debug(TAG, {
        ...
      })
      local channel_result
      if succ then
        local data = (...)
        local code = data.authCode
        local thirdPartyToken = {accessToken = code, clientId = clientKey}
        local user_info = {
          token = JSON.encode(thirdPartyToken)
        }
        channel_result = PROTOCOL.LoginResult.succ(CHANNEL, user_info, {thirdparty_type = CHANNEL})
        E.LOG.debug(TAG, channel_result)
        if cb then
          cb(channel_result)
        end
      else
        local _, body = ...
        local code = (body or {}).error_code
        local message = (body or {}).error_msg
        channel_result = PROTOCOL.LoginResult.fail(code, message)
        E.LOG.debug(TAG, {ch_result = channel_result})
        if cb then
          cb(channel_result)
        end
      end
    end)
  end
end

function DOUYIN.init(opt, cb)
  E.LOG.debug(TAG, "douyin init start")
  if inited then
    E.LOG.debug(TAG, "douyin vendor had inited")
    cb(true)
    return
  end
  inited = true
  cb(true)
  if _ejoysdk.os() == "douyin" then
    clientKey = _ejoysdk.dy.getEnvInfoSync().microapp.appId
    E.LOG.debug(TAG, "read clientKey >> " .. tostring(clientKey))
    local meta = E.CONFIG.get_config("unisdk_meta")
    local is_require_privacy = meta.is_require_privacy or false
    if is_require_privacy then
      E.LOG.debug(TAG, "douyin init start, is_require_privacy = true")
      E.require_privacy({})
    end
  else
    clientKey = opt.clientKey
    E.LOG.debug(TAG, "read ex clientKey >> " .. tostring(clientKey))
  end
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, get_player_token_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ_handler)
end

function DOUYIN.check_token(_outsource, _info)
end

function DOUYIN.merge_info()
end

function DOUYIN.simple_token()
  return false
end

function DOUYIN.logout()
  E.LOG.debug(TAG, "logout called----")
end

local function androidPay(_params, cb)
  E.LOG.debug(TAG, "androidPay start")
  E.LOG.debug(TAG, _params)
  if not _params or not _params.attach_info then
    E.LOG.debug(TAG, "_params.attach_info is nil")
    if cb then
      cb(false, {
        code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_FAIL_NO_SIGN_DATA,
        msg = "_params.attach_info is nil"
      })
    end
    return
  end
  _ejoysdk.dy.requestGamePayment({
    env = 0,
    goodType = 2,
    platform = "android",
    currencyType = "CNY",
    zoneId = "1",
    mode = "game",
    orderAmount = tonumber(_params.order_amount),
    customId = _params.order_id,
    extraInfo = _params.attach_info,
    success = function(res)
      E.LOG.debug(TAG, "requestGamePayment succ")
      E.log(res)
      if cb then
        cb(true, res)
      end
    end,
    fail = function(err_resp)
      E.LOG.debug(TAG, "requestGamePayment fail msg:")
      E.log(err_resp)
      local resp
      if -2 == err_resp.errNo then
        resp = {
          code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
          msg = "取消支付"
        }
      else
        resp = {
          code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_UNKNOWN,
          msg = "渠道支付失败，code：" .. tostring(err_resp.errNo) .. "，msg：" .. tostring(err_resp.errMsg)
        }
      end
      if cb then
        cb(false, resp)
      end
    end
  })
end

local function iosPay(_params, cb)
  E.LOG.debug(TAG, "iosPay start")
  E.LOG.debug(TAG, _params)
  _ejoysdk.dy.openAwemeCustomerService({
    env = 0,
    goodType = 2,
    zoneId = "1",
    mode = "game",
    orderAmount = tonumber(_params.order_amount),
    customId = _params.order_id,
    extraInfo = _params.attach_info,
    success = function(res)
      E.LOG.debug(TAG, "openAwemeCustomerService succ msg:")
      E.log(res)
      if cb then
        cb(true, res)
      end
    end,
    fail = function(err_resp)
      E.LOG.debug(TAG, "openAwemeCustomerService fail msg:" .. tostring(err_resp.errMsg))
      E.log(err_resp)
      local resp
      if -2 == err_resp.errNo then
        resp = {
          code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
          msg = "取消支付"
        }
      else
        resp = {
          code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_UNKNOWN,
          msg = "渠道支付失败，code：" .. tostring(err_resp.errNo) .. "，msg：" .. tostring(err_resp.errMsg)
        }
      end
      if cb then
        cb(false, resp)
      end
    end
  })
end

function DOUYIN.pay(_params, cb)
  if _ejoysdk.dy.canIUse("requestGamePayment.object.goodType") ~= true then
    E.LOG.debug(TAG, "can not support pay")
    return
  end
  local deviceSystem = E.Sysinfo.get_device_system() or ""
  if "android" == deviceSystem then
    androidPay(_params, cb)
  else
    iosPay(_params, cb)
  end
end

local launch_options

local function get_share_query()
  if nil == launch_options then
    launch_options = _ejoysdk.dy.getLaunchOptionsSync() or {}
  end
  local share_query = {}
  local query = launch_options.query
  local is_share_query_exists = false
  if query then
    for k, v in pairs(query) do
      if "share" == k then
        is_share_query_exists = true
        table.insert(share_query, "share=true")
      else
        table.insert(share_query, k .. "=" .. tostring(v))
      end
    end
  end
  if not is_share_query_exists then
    table.insert(share_query, "share=true")
  end
  local final_share_query = table.concat(share_query, "&")
  return final_share_query
end

local function share_image(param, cb)
  param.media = param.media or {}
  param.media[1] = param.media[1] or {}
  local image_url = param.media[1].data
  if nil == image_url or 0 == #image_url then
    if cb then
      cb(false, CONSTANTS.SHARE.CODE_IMAGE_FILE_EMPTY, "douyin image file empty")
    end
    return
  end
  local extra = param.extra or {}
  if param.channel == "picture" then
    if not extra.contentTitle then
      extra.contentTitle = param.title
    end
    if not extra.contentDescription then
      extra.contentDescription = param.message
    end
  end
  local query = get_share_query()
  _ejoysdk.dy.shareAppMessage({
    query = query,
    title = param.title,
    desc = param.message,
    channel = param.channel,
    extra = extra,
    imageUrl = image_url,
    success = function()
      if cb then
        cb(true)
      end
    end,
    fail = function(res)
      _ejoysdk.log("douyin share fail")
      _ejoysdk.log(res.errMsg)
      if cb then
        cb(false, CONSTANTS.SHARE.CODE_SHARE_OPEN_FAIL, "douyin share image open fail")
      end
    end
  })
end

function DOUYIN.share(param, _chunk_data, cb)
  E.LOG.debug(TAG, param)
  if param.media and #param.media > 0 and param.media[1].type == "image_url" then
    share_image(param, cb)
  elseif param.content_url then
    if cb then
      cb(false, CONSTANTS.SHARE.CODE_PARAM_NOT_SUPPORT, "douyin share url not support")
    end
  elseif cb then
    cb(false, CONSTANTS.SHARE.CODE_PARAM_NOT_SUPPORT, "douyin share param not support")
  end
  JF.commit_event("sdk.minigames.share.start")
end

function DOUYIN.showShareMenu(param, cb)
  param.media = param.media or {}
  param.media[1] = param.media[1] or {}
  local image_url = param.media[1].data
  local extra = param.extra or {}
  if param.channel == "picture" then
    if not extra.contentTitle then
      extra.contentTitle = param.title
    end
    if not extra.contentDescription then
      extra.contentDescription = param.message
    end
  end
  local listener = setmetatable({}, {
    __name = "js_function",
    __sync = true,
    __call = function()
      return {
        title = param.title,
        desc = param.message,
        channel = param.channel,
        extra = param.extra,
        imageUrl = image_url
      }
    end
  })
  _ejoysdk.dy.onShareAppMessage(listener)
  _ejoysdk.dy.showShareMenu({
    menus = {
      "shareAppMessage",
      "shareTimeline"
    },
    success = function()
      cb(true)
    end,
    fail = function(error)
      _ejoysdk.log("douyin show share fail")
      _ejoysdk.log(error.errMsg)
      cb(false, CONSTANTS.SHARE.CODE_SHARE_OPEN_FAIL, "douyin share image open fail")
    end,
    complete = function()
      E.LOG.debug(TAG, "douyin share complete")
    end
  })
end

function DOUYIN.is_share_support()
  E.LOG.debug(TAG, "douyin share support")
  return true
end

local function get_custom_service_session_from()
  local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local user_info = {}
  local pkg_info = {}
  local player_info = {}
  local _user_center_info = {}
  if E.get_pkg_info() then
    pkg_info = E.get_pkg_info()
  end
  user_info = user_info and EG.user_info()
  if EG.player_info() then
    player_info = EG.player_info()
  end
  if USER.user_info then
    _user_center_info = USER.user_info()
  end
  local session_params = {
    productCode = pkg_info.product_code or "",
    gameId = pkg_info.game_id or "",
    accountToken = user_info.ptoken or "",
    accountId = user_info.uid or "",
    roleId = player_info.player_id or "",
    gameLang = pkg_info.game_lang or "",
    deviceId = E.Sysinfo.device_id() or "",
    deviceSystem = E.Sysinfo.get_device_system() or "",
    airlineType = pkg_info.airline or "",
    publishArea = pkg_info.publish_area or "",
    channelId = E.get_channel() or "",
    brand = E.Sysinfo.brand() or "",
    model = E.Sysinfo.model() or "",
    osVersion = E.Sysinfo.os_version() or ""
  }
  local session_from_str = JSON.encode(session_params)
  E.LOG.debug(TAG, "session_from_str: " .. tostring(session_from_str))
  return session_from_str
end

function DOUYIN.show_custom_service(_params, cb, _close_cb)
  _ejoysdk.dy.openCustomerServiceConversation({
    type = 3,
    sessionFrom = get_custom_service_session_from(),
    success = function()
      cb(true)
    end,
    fail = function(error)
      cb(false, "DOUYIN openCustomerServiceConversation fail, reason: " .. tostring(error.errMsg))
    end
  })
end

function DOUYIN.add_shortcut(_params, cb)
  _ejoysdk.dy.addShortcut({
    success = function()
      cb(true)
    end,
    fail = function(error)
      cb(false, "DOUYIN addShortcut fail, reason: " .. tostring(error.errMsg))
    end
  })
end

function DOUYIN.check_shortcut(_params, cb)
  local device_system = E.Sysinfo.get_device_system() or ""
  if "android" ~= device_system then
    cb(false, "DOUYIN checkShortcut only support android")
    return
  end
  _ejoysdk.dy.checkShortcut({
    success = function(res)
      cb(res.status)
    end,
    fail = function(error)
      cb(false, "DOUYIN checkShortcut fail, reason: " .. tostring(error.errMsg))
    end
  })
end

function DOUYIN.check_exit_sidebar(_params, cb)
  _ejoysdk.dy.checkScene({
    scene = "sidebar",
    success = function(res)
      cb(res.isExist, res.errMsg)
    end,
    fail = function(error)
      cb(false, "DOUYIN checkScene fail, reason: " .. tostring(error.errMsg))
    end
  })
end

function DOUYIN.listen_sidebar_show(_params, cb)
  local show_listener
  
  function show_listener(res)
    if res and res.scene == "021036" and res.location == "sidebar_card" then
      cb(true, "is from sidebar")
    else
      cb(false, "not from sidebar")
    end
    ET.unsubscribe("APP_LIFE_CIRCLE_EVENT", show_listener)
  end
  
  ET.subscribe("APP_LIFE_CIRCLE_EVENT", show_listener)
end

function DOUYIN.nativgate_to_sidebar(_params, cb)
  _ejoysdk.dy.navigateToScene({
    scene = "sidebar",
    success = function(res)
      cb(true)
    end,
    fail = function(error)
      cb(false, "DOUYIN navigateToScene fail, reason: " .. tostring(error.errMsg))
    end
  })
end

function DOUYIN.supportAuth()
  local sdk_infos = UNI.get_sdk_infos()
  if sdk_infos and sdk_infos[CHANNEL] then
    if _ejoysdk.os() == "android" then
      return true
    elseif _ejoysdk.os() == "ios" then
      do return E.Sysinfo.is_app_install end
      return E.Sysinfo.is_app_install, "snssdk1128://"
    end
  end
  return false
end

DOUYIN:is_implemented({"SHARE"})
return DOUYIN

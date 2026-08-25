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
local CHANNEL = "WEIXIN"
local CHANNEL_MINI = "WEIXIN_MINI"
local TAG = EM.MODULE.VENDORS.WEIXIN
local WX = Vendor:Inherit(CHANNEL)
local inited = false
local ANDROID_WX_PACKAGE_NAME = "com.tencent.mm"
local WX_TIMEOUT = 6000
local WX_NOT_SIGNED = -1
local ASYNC_REQUEST_WEIXIN_CODE = "ASYNC_REQUEST_WEIXIN_CODE"
local appId, current_weixin_uid

local function is_weixin_os()
  return _ejoysdk.os() == "weixin"
end

local function get_player_token_handler()
  if is_weixin_os() then
    local player_info = EG.player_info()
    if not player_info or player_info and player_info.is_valid == false then
      E.LOG.debug(TAG, "player_info = nil or player_info.is_valid = false, ignore bind player")
      return
    end
    local push_api = require("ejoysdk_lua.server_api.push_ex")
    push_api.bind_channel("weixin", push_api.COLLECT_TYPE_PLAYERID, player_info.player_id)
  end
end

local function login_listener(account_result)
  E.LOG.debug(TAG, "receive login result")
  E.log(account_result)
  if account_result.ext and account_result.ext.account_data then
    local channel_result = account_result.ext.channel_result
    if channel_result.ext then
      local account_data = account_result.ext.account_data
      current_weixin_uid = account_data.thirdPartyUid
      E.LOG.debug(TAG, "save current uid >> " .. tostring(current_weixin_uid))
    end
  end
end

local function acquire_succ_handler()
  if is_weixin_os() then
    local user_info = EG.user_info()
    local push_api = require("ejoysdk_lua.server_api.push_ex")
    push_api.bind_channel("weixin", push_api.COLLECT_TYPE_ACCOUNT, user_info.uid)
  end
end

local function login_wx_mini(cb)
  local meta = E.CONFIG.get_config("unisdk_meta")
  local is_require_privacy = meta.is_require_privacy or false
  local channel_result
  local params = {
    timeout = WX_TIMEOUT,
    success = function(res)
      E.LOG.debug(TAG, "weixin login success")
      local code = res.code
      local thirdPartyToken = {accessToken = code, appId = appId}
      local user_info = {
        token = JSON.encode(thirdPartyToken)
      }
      channel_result = PROTOCOL.LoginResult.succ(CHANNEL_MINI, user_info, {thirdparty_type = CHANNEL})
      E.LOG.debug(TAG, channel_result)
      cb(channel_result)
    end,
    fail = function(res)
      E.LOG.debug(TAG, "weixin login fail")
      channel_result = PROTOCOL.LoginResult.fail(-1, "weixin login get code fail: " .. tostring(res.errMsg), {
        wx_code = res.errno
      })
      cb(channel_result)
    end,
    complete = function(res)
      E.LOG.debug(TAG, "weixin login complete")
    end
  }
  if is_require_privacy then
    E.require_privacy({
      success = function()
        _ejoysdk.wx.login(params)
      end,
      fail = function()
        _ejoysdk.js_log("require privacy fail")
        if cb then
          cb({
            code = WX_NOT_SIGNED,
            msg = "require privacy fail",
            is_succ = function()
              return false
            end
          })
        end
      end
    })
  else
    _ejoysdk.wx.login(params)
  end
end

function WX.login(_ext, cb)
  E.LOG.debug(TAG, "weixin login start")
  if _ejoysdk.os() == "weixin" then
    login_wx_mini(cb)
  else
    local params = {
      request_code = "wechat_sdk_request_code",
      scope = "snsapi_userinfo"
    }
    UNI.async_call(CHANNEL, ASYNC_REQUEST_WEIXIN_CODE, params, nil, function(succ, ...)
      E.LOG.debug(TAG, "request weixin code return, succ >> " .. tostring(succ))
      E.LOG.debug(TAG, {
        ...
      })
      local channel_result
      if succ then
        local data = (...)
        local code = data.code
        local thirdPartyToken = {accessToken = code, appId = appId}
        local user_info = {
          token = JSON.encode(thirdPartyToken)
        }
        channel_result = PROTOCOL.LoginResult.succ(CHANNEL, user_info, {thirdparty_type = CHANNEL})
        E.LOG.debug(TAG, channel_result)
        cb(channel_result)
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

function WX.init(opt, cb)
  E.LOG.debug(TAG, "weixin init start")
  E.LOG.debug(TAG, {params = opt})
  if inited then
    E.LOG.debug(TAG, "weixin vendor had inited")
    cb(true)
    return
  end
  inited = true
  cb(true)
  local meta = E.CONFIG.get_config("unisdk_meta")
  if is_weixin_os() then
    local is_require_privacy = meta.is_require_privacy or false
    if is_require_privacy then
      E.LOG.debug(TAG, "weixin init start, is_require_privacy = true")
      E.require_privacy({})
    end
    appId = _ejoysdk.wx.getAccountInfoSync().miniProgram.appId
  else
    appId = opt.wxAppId
  end
  E.LOG.debug(TAG, "read ex appid >> " .. tostring(appId))
  ET.subscribe(ET.ACCOUNT.LOGIN, login_listener)
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, get_player_token_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ_handler)
end

function WX.check_token(_outsource, _info)
end

function WX.merge_info()
end

function WX.simple_token()
  return false
end

function WX.logout()
  E.LOG.debug(TAG, "logout called----")
end

function WX.get_current_uid()
  return current_weixin_uid
end

local function wxmidasPay(params, cb)
  E.LOG.debug(TAG, params)
  if not params or not params.pay_body then
    E.LOG.debug(TAG, "_params.attach_info is nil")
    if cb then
      cb(false, {
        code = CONSTANTS.CODE_PAY_FAIL_NO_SIGN_DATA,
        msg = "_params.attach_info is nil"
      })
    end
    return
  end
  local pay_body = params.pay_body
  E.LOG.debug(TAG, "pay body >> ")
  E.LOG.debug(TAG, pay_body)
  local deviceSystem = E.Sysinfo.get_device_system()
  local platformValue
  if "windows" == deviceSystem then
    platformValue = "windows"
  end
  _ejoysdk.wx.requestMidasPaymentGameItem({
    platform = platformValue,
    signData = pay_body.signData,
    paySig = pay_body.paySig,
    signature = pay_body.signature,
    success = function(res)
      if cb then
        cb(true, res)
      end
    end,
    fail = function(err)
      local resp
      if -2 == err.errCode or err.errCode == 4294967294 then
        resp = {
          code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
          msg = "取消支付"
        }
      else
        resp = {
          code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_UNKNOWN,
          msg = "渠道支付失败，code：" .. tostring(err.errCode) .. "，msg：" .. tostring(err.errMsg)
        }
      end
      if cb then
        cb(false, resp)
      end
    end
  })
end

local function defaultPay(_params, cb)
  E.LOG.debug(TAG, _params)
  _ejoysdk.wx.showModal({
    title = "",
    content = "即将进入客服会话，在客服会话中点击右下角图片即可开始充值",
    confirmText = "去充值",
    success = function(res)
      local game_name = E.CONFIG.get_config("game_name")
      local game_cover = E.CONFIG.get_config("game_cover")
      local session_str = JSON.encode({
        orderId = _params.order_id
      })
      _ejoysdk.js_log("session_str: " .. session_str)
      if res.confirm then
        _ejoysdk.wx.openCustomerServiceConversation({
          sessionFrom = session_str,
          showMessageCard = true,
          sendMessageTitle = game_name or "游戏充值",
          sendMessagePath = "PLACEHOLDER/PLACEHOLDER?orderId=" .. _params.order_id,
          sendMessageImg = game_cover,
          success = function()
          end,
          fail = function()
            if cb then
              local resp = {
                code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_UNKNOWN,
                msg = "打开客服公众号失败"
              }
              cb(false, resp)
            end
          end
        })
      elseif res.cancel and cb then
        local resp = {
          code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
          msg = "取消进入客服公众号，中断支付"
        }
        cb(false, resp)
      end
    end
  })
end

function WX.pay(params, cb)
  local deviceSystem = E.Sysinfo.get_device_system() or ""
  if "android" == deviceSystem or "harmonyos" == deviceSystem or "windows" == deviceSystem then
    wxmidasPay(params, cb)
  else
    defaultPay(params, cb)
  end
end

local launch_options

local function get_share_query()
  if nil == launch_options then
    launch_options = _ejoysdk.wx.getLaunchOptionsSync() or {}
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
      cb(false, CONSTANTS.SHARE.CODE_IMAGE_FILE_EMPTY, "weixin image file empty")
    end
    return
  end
  local query = get_share_query()
  _ejoysdk.wx.shareAppMessage({
    query = query,
    title = param.title,
    imageUrl = image_url,
    imageUrlId = param.imageUrlId,
    success = function()
      if cb then
        cb(true)
      end
    end,
    fail = function()
      if cb then
        cb(false, CONSTANTS.SHARE.CODE_SHARE_OPEN_FAIL, "weixin share image open fail")
      end
    end
  })
  JF.commit_event("sdk.minigames.share.start")
end

function WX.share(param, _chunk_data, cb)
  E.LOG.debug(TAG, param)
  if param.media and #param.media > 0 and param.media[1].type == "image_url" then
    share_image(param, cb)
  elseif param.message then
    if cb then
      cb(false, CONSTANTS.SHARE.CODE_PARAM_NOT_SUPPORT, "weixin share text not support")
    end
  elseif param.content_url then
    if cb then
      cb(false, CONSTANTS.SHARE.CODE_PARAM_NOT_SUPPORT, "weixin share url not support")
    end
  elseif cb then
    cb(false, CONSTANTS.SHARE.CODE_PARAM_NOT_SUPPORT, "weixin share param not support")
  end
end

function WX.showShareMenu(param, cb)
  param.media = param.media or {}
  param.media[1] = param.media[1] or {}
  local image_url = param.media[1].data
  local listener = setmetatable({}, {
    __name = "js_function",
    __sync = true,
    __call = function()
      return {
        title = param.title,
        imageUrl = image_url,
        imageUrlId = param.imageUrlId
      }
    end
  })
  _ejoysdk.wx.onShareAppMessage(listener)
  _ejoysdk.wx.onShareTimeline(listener)
  _ejoysdk.wx.showShareMenu({
    menus = {
      "shareAppMessage",
      "shareTimeline"
    },
    success = function()
      cb(true)
    end,
    fail = function()
      cb(false, CONSTANTS.SHARE.CODE_SHARE_OPEN_FAIL, "weixin share image open fail")
    end,
    complete = function()
      E.LOG.debug(TAG, "weixin share complete")
    end
  })
end

function WX.is_share_support()
  E.LOG.debug(TAG, "weixin share support")
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

function WX.show_custom_service(_params, cb, _close_cb)
  _ejoysdk.wx.openCustomerServiceConversation({
    sessionFrom = get_custom_service_session_from(),
    success = function()
      cb(true)
    end,
    fail = function()
      cb(false, "wx openCustomerServiceConversation fail")
    end
  })
end

function WX.supportAuth()
  local sdk_infos = UNI.get_sdk_infos()
  if sdk_infos and sdk_infos[CHANNEL] then
    if _ejoysdk.os() == "android" then
      do return E.Sysinfo.is_app_install end
      return E.Sysinfo.is_app_install, ANDROID_WX_PACKAGE_NAME
    elseif _ejoysdk.os() == "ios" then
      do return E.Sysinfo.is_app_install end
      return E.Sysinfo.is_app_install, "weixin://"
    end
  end
  return false
end

WX:is_implemented({
  "SHARE",
  "CUSTOM_SERVICE"
})
return WX

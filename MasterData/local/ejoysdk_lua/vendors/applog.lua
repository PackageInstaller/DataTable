local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local VENDOR_NAME = "APPLOG"
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_config")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local CAST_INIT = "CAST_INIT"
local CAST_PURCHASE_SUCC = "CAST_PURCHASE_SUCC"
local CAST_SERVER_PURCHASE_SUCC = "CAST_SERVER_PURCHASE_SUCC"
local CAST_REGISTER = "CAST_REGISTER"
local CAST_ACQUIRE = "CAST_ACQUIRE"
local CAST_COMMIT_EVENT = "CAST_COMMIT_EVENT"
local TAG = EM.MODULE.VENDORS.APPLOG
local CAST_SET_UNIQUE_ID = "CAST_SET_UNIQUE_ID"
local CHAT
local M = Vendor:Inherit(VENDOR_NAME)
M.VENDOR_NAME = VENDOR_NAME
local applog_inited = false

local function sha1_hex(data)
  do return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data) end
  return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data)
end

local PURCHASE_STARTEGIES = {UES_PAY_SDK = 1, USE_CHAT_MSG = 2}
local purchase_startegies = PURCHASE_STARTEGIES.UES_PAY_SDK

local function notify_applog_purchase_event(order_id, product_info, event, from)
  if from == purchase_startegies then
    E.LOG.debug(TAG, "通知买量 SDK 付费事件")
    E.LOG.debug(TAG, {order_id = order_id, product_info = product_info})
    UNI.cast(VENDOR_NAME, event, {order_id = order_id, product_info = product_info})
  end
end

local function init_sdk_pay_handler()
  ET.subscribe(ET.analytics.PURCHASE_SUCC, function(order_id, product_info)
    notify_applog_purchase_event(sha1_hex(order_id), product_info, CAST_PURCHASE_SUCC, PURCHASE_STARTEGIES.UES_PAY_SDK)
  end)
end

local function parse_purchase_succ_msg(msg)
  if msg.reader_status ~= nil and 0 ~= msg.reader_status then
    return nil
  end
  local order_id, product_info
  local data = msg.content and msg.content.data or {}
  order_id = data.order_uuid
  product_info = data.product_info
  return order_id, product_info
end

local function check_purchase_succ_msg(msg)
  local order_id, product_info = parse_purchase_succ_msg(msg)
  if order_id then
    notify_applog_purchase_event(order_id, product_info, CAST_PURCHASE_SUCC, PURCHASE_STARTEGIES.USE_CHAT_MSG)
    notify_applog_purchase_event(order_id, product_info, CAST_SERVER_PURCHASE_SUCC, PURCHASE_STARTEGIES.USE_CHAT_MSG)
    local session_id = msg.session_id
    local ts = msg.ts
    CHAT.set_msg_received_with_ts(session_id, ts, function(succ)
      E.LOG.debug(TAG, "设置付费聊天消息已收，结果: " .. tostring(succ))
    end)
  end
end

local function chat_on_login_observer()
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local player_info = EG.player_info()
  if not player_info or not player_info.player_id then
    return
  end
  local session_id = "system_gangplank:" .. tostring(player_info.player_id)
  local opt = {max_msg_count = 20}
  E.LOG.debug(TAG, "登录后，获取历史聊天付费成功消息")
  CHAT.get_msg(session_id, opt, function(succ, ...)
    if succ then
      local msgs = (...)
      E.LOG.debug(TAG, "登录后，获取历史聊天付费成功消息，成功：" .. tostring(#msgs))
      for i = #msgs, 1, -1 do
        local msg = msgs[i]
        check_purchase_succ_msg(msg)
      end
    end
  end)
end

local function chat_gangplank_msg_observer(msgs)
  for _, msg in ipairs(msgs) do
    check_purchase_succ_msg(msg)
  end
end

function M.subscribe_server_purchase_msg()
  ET.subscribe("chat_on_login", chat_on_login_observer)
  ET.subscribe("chat_info_gangplank_msg", chat_gangplank_msg_observer)
end

local function init_server_pay_handler()
  CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
  M.subscribe_server_purchase_msg()
end

function M.init(opt, cb)
  opt = opt or {}
  UNI.cast(VENDOR_NAME, CAST_INIT, opt.config or {})
  local purchase_notify_mode = opt.purchase_notify_mode
  if not purchase_notify_mode then
    local sdk_infos = UNI.get_sdk_infos()
    local vendor_info = sdk_infos[VENDOR_NAME]
    if vendor_info and vendor_info.meta then
      purchase_notify_mode = vendor_info.meta.purchase_notify_mode
    end
  end
  if "NOTIFY_BY_SERVER" == purchase_notify_mode then
    purchase_startegies = PURCHASE_STARTEGIES.USE_CHAT_MSG
  end
  E.LOG.debug(TAG, "purchase_startegies:" .. tostring(purchase_startegies))
  E.log(opt)
  if applog_inited then
    E.LOG.debug(TAG, "already init, return")
    cb(true)
    return
  end
  ET.subscribe(ET.analytics.REGISTER, function(user_info)
    UNI.cast(VENDOR_NAME, CAST_REGISTER, {
      uid = sha1_hex(user_info.uid)
    })
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, function(user_info)
    local has_gbapplog = EC.has_vendor_config("gbapplog")
    local EG = require("ejoysdk_lua.ejoysdk_gangplank")
    local is_guest_result = EG.is_magic_guest()
    if has_gbapplog then
      local pkg_info = E.get_pkg_info()
      local params = {
        uid = user_info.uid,
        gid = pkg_info.game_id,
        utdid = pkg_info.utdid
      }
      DSP.post(DSP.SERVICE.GET_LOGIN_USER_INFO, params, function(succ, ...)
        if succ then
          local data = (...)
          E.LOG.debug(TAG, "get_login_user_info succ, user_info >>>")
          E.LOG.debug(TAG, data)
          data = data or {}
          local activeSituation = data.activeSituation or ""
          UNI.cast(VENDOR_NAME, CAST_ACQUIRE, {
            uid = sha1_hex(user_info.uid),
            is_guest = is_guest_result,
            active_situation = activeSituation
          })
        else
          local code, msg = ...
          E.LOG.debug(TAG, "get login user info fail, code is " .. tostring(code) .. ", msg is " .. tostring(msg))
          UNI.cast(VENDOR_NAME, CAST_ACQUIRE, {
            uid = sha1_hex(user_info.uid),
            is_guest = is_guest_result
          })
        end
      end, "ejoysdk")
    else
      UNI.cast(VENDOR_NAME, CAST_ACQUIRE, {
        uid = sha1_hex(user_info.uid),
        is_guest = is_guest_result
      })
    end
  end)
  init_sdk_pay_handler()
  init_server_pay_handler()
  applog_inited = true
  cb(true)
end

function M.set_unique_id(unique_id)
  UNI.cast(VENDOR_NAME, CAST_SET_UNIQUE_ID, {uid = unique_id})
end

function M.commit_event(event_name, params)
  local event_params = {event_name = event_name, params = params}
  UNI.cast(VENDOR_NAME, CAST_COMMIT_EVENT, event_params)
end

M:is_implemented({
  Vendor.ABILITY.STATS
})
return M

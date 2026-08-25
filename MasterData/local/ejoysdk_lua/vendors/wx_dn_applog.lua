local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
local VENDOR_NAME = "WX_DN_APPLOG"
local CAST_SERVER_PURCHASE_SUCC = "CAST_SERVER_PURCHASE_SUCC"
local TAG = EM.MODULE.VENDORS.WX_DN_APPLOG
local M = Vendor:Inherit(VENDOR_NAME)
M.VENDOR_NAME = VENDOR_NAME
local wx_dn_applog_inited = false
local wx_dn_sdk = _ejoysdk.dn_sdk and _ejoysdk.dn_sdk() or {}
local PURCHASE_STRATEGY = {UES_PAY_SDK = 1, USE_CHAT_MSG = 2}
local purchase_strategy = PURCHASE_STRATEGY.USE_CHAT_MSG

local function notify_applog_purchase_event(order_id, product_info, _event, from)
  if from == purchase_strategy then
    E.LOG.debug(TAG, "通知买量 SDK 付费事件")
    E.LOG.debug(TAG, {order_id = order_id, product_info = product_info})
    M.commit_event("onPurchase", product_info.money)
  end
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
    notify_applog_purchase_event(order_id, product_info, CAST_SERVER_PURCHASE_SUCC, PURCHASE_STRATEGY.USE_CHAT_MSG)
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
  M.subscribe_server_purchase_msg()
end

function M.init(opt, cb)
  if purchase_strategy == PURCHASE_STRATEGY.USE_CHAT_MSG then
    CHAT.real_init()
  end
  E.LOG.debug(TAG, "purchase_strategy:" .. tostring(purchase_strategy))
  E.log(opt)
  if wx_dn_applog_inited then
    E.LOG.debug(TAG, "already init, return")
    cb(true)
    return
  end
  ET.subscribe(ET.analytics.REGISTER, function()
    M.commit_event("onRegister")
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, function(user_info)
    if user_info.pinfo and user_info.pinfo.ext and user_info.pinfo.ext.ch_openid then
      local open_id = user_info.pinfo.ext.ch_openid
      M.commit_event("setOpenId", open_id)
    end
  end)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, function(player_info, type)
    if "createRole" == type then
      E.LOG.debug(TAG, "receive createRole event")
      local role_name = player_info.player_name or ""
      local role_id = player_info.player_id or ""
      local role_id_tag = tostring(role_id) .. "#" .. tostring(role_name)
      M.commit_event("onCreateRole", role_id_tag)
    end
  end)
  init_server_pay_handler()
  wx_dn_applog_inited = true
  cb(true)
end

function M.commit_event(event_name, params)
  if not wx_dn_sdk[event_name] then
    E.LOG.error(TAG, "wx dn-sdk event_name %s is not supported", tostring(event_name))
    return
  end
  wx_dn_sdk[event_name](params)
end

M:is_implemented({
  Vendor.ABILITY.STATS
})
return M

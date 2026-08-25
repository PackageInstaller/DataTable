local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local VENDOR_NAME = "APPLOG"
local APPLOG_SERVER = require("ejoysdk_lua.server_api.applog_server")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_config")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local JF = require("ejoysdk_lua.vendors.jf")
local CAST_INIT = "CAST_INIT"
local CAST_PURCHASE_SUCC = "CAST_PURCHASE_SUCC"
local CAST_SERVER_PURCHASE_SUCC = "CAST_SERVER_PURCHASE_SUCC"
local CAST_REGISTER = "CAST_REGISTER"
local CAST_ACQUIRE = "CAST_ACQUIRE"
local CAST_COMMIT_EVENT = "CAST_COMMIT_EVENT"
local CAST_SET_UNIQUE_ID = "CAST_SET_UNIQUE_ID"
local TAG = EM.MODULE.VENDORS.APPLOG
local CHAT
local JF_APPLOG_COMMIT_EVENT = "sdk.applog.commit_event"
local JF_MODIFY_EVENT_BY_RULE = "sdk.applog.modify_event_by_rule"
local M = Vendor:Inherit(VENDOR_NAME)
M.VENDOR_NAME = VENDOR_NAME
local applog_inited = false
local current_account_id
local APPLOG_EVENTS_QUEUE = E.LazyKeyStore:New("EJOYSDK_APPLOG_EVENTS_QUEUE", false, true, false)
local events_queue = {}
local handle_event, handle_events_queue
local EVENTS_QUEUE_CHECKING_INTERVAL = 1
local EVENTS_UPLOAD_INTERVAL_RANGE = 3
local EVENTS_QUEUE_SAVED_INTERVAL = 7
local EVENTS_NAME = {
  REGISTER = "sdk.user.create",
  ACQUIRE = "sdk.user.online",
  PURCHASE = "sdk.account.charge.success",
  ALL = "ALL"
}
local FILTER_EVENTS = {
  [EVENTS_NAME.REGISTER] = true,
  [EVENTS_NAME.ACQUIRE] = true,
  [EVENTS_NAME.PURCHASE] = true
}
local EVENT_UPLOAD_CMDS = {
  DEFAULT = "default",
  WAIT = "wait",
  CHANGE_PAY = "changePay",
  SPLIT_PAY = "splitPay",
  CHANGE_EVENT = "changeEvent"
}

local function sha1_hex(data)
  do return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data) end
  return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data)
end

local PURCHASE_STRATEGIES = {UES_PAY_SDK = 1, USE_CHAT_MSG = 2}
local purchase_strategies = PURCHASE_STRATEGIES.UES_PAY_SDK
local enable_upload_rules = false

local function notify_applog_purchase_event(order_id, product_info, event, from)
  if from == purchase_strategies then
    E.LOG.debug(TAG, "通知买量 SDK 付费事件")
    E.LOG.debug(TAG, {order_id = order_id, product_info = product_info})
    UNI.cast(VENDOR_NAME, event, {order_id = order_id, product_info = product_info})
  end
end

local function init_sdk_pay_handler()
  ET.subscribe(ET.analytics.PURCHASE_SUCC, function(order_id, product_info)
    if purchase_strategies == PURCHASE_STRATEGIES.UES_PAY_SDK or not enable_upload_rules then
      local event_params = {
        order_id = sha1_hex(order_id),
        product_info = E_UTILS.deepcopy(product_info),
        purchase_strategies = PURCHASE_STRATEGIES.UES_PAY_SDK
      }
      handle_event(EVENTS_NAME.PURCHASE, event_params)
    end
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
    if purchase_strategies == PURCHASE_STRATEGIES.USE_CHAT_MSG or not enable_upload_rules then
      local event_params = {
        order_id = order_id,
        product_info = E_UTILS.deepcopy(product_info),
        purchase_strategies = PURCHASE_STRATEGIES.USE_CHAT_MSG
      }
      handle_event(EVENTS_NAME.PURCHASE, event_params)
    end
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

local function save_events_queue()
  APPLOG_EVENTS_QUEUE:set(events_queue)
  if not events_queue or not next(events_queue) then
    return
  end
  E.Timer.once(EVENTS_QUEUE_SAVED_INTERVAL, function()
    save_events_queue()
  end)
end

local function upload_events_immediately(events)
  if not events or not next(events) then
    E.LOG.d(TAG, "此次所有事件已上报完成")
    return
  end
  local event = events[1]
  local event_name = event.name
  local event_params = event.params or {}
  local event_uploaded_to_applog = true
  if event_name == EVENTS_NAME.REGISTER and FILTER_EVENTS[event_name] then
    local user_info = event_params.user_info
    E.LOG.d(TAG, "上报注册事件 >> 事件名: " .. event_name .. ", uid: " .. user_info.uid)
    UNI.cast(VENDOR_NAME, CAST_REGISTER, {
      uid = sha1_hex(user_info.uid)
    })
  elseif event_name == EVENTS_NAME.PURCHASE and FILTER_EVENTS[event_name] then
    local order_id, product_info, strategy = event_params.order_id, event_params.product_info, event_params.purchase_strategies
    E.LOG.d(TAG, "上报付费事件 >> 事件名: " .. event_name .. ", order_id: " .. order_id .. ", strategy: " .. strategy)
    notify_applog_purchase_event(order_id, product_info, CAST_PURCHASE_SUCC, strategy)
    if strategy == PURCHASE_STRATEGIES.USE_CHAT_MSG then
      notify_applog_purchase_event(order_id, product_info, CAST_SERVER_PURCHASE_SUCC, strategy)
    end
  elseif event_name == EVENTS_NAME.ACQUIRE and FILTER_EVENTS[event_name] then
    local user_info, is_guest_result, activeSituation = event_params.user_info, event_params.is_guest, event_params.active_situation
    E.LOG.d(TAG, "上报账号登录事件 >> 事件名: " .. event_name .. ", uid: " .. user_info.uid)
    UNI.cast(VENDOR_NAME, CAST_ACQUIRE, {
      uid = sha1_hex(user_info.uid),
      is_guest = is_guest_result,
      active_situation = activeSituation
    })
  else
    event_uploaded_to_applog = false
    E.LOG.d(TAG, event_name .. " 事件不在基本规则配置内，不上报")
  end
  local jf_commit_event_params = {
    event_name = event_name,
    generate_time = event.time,
    upload_time = E.system_ms(),
    event_params = event_params,
    has_uploaded = event_uploaded_to_applog
  }
  JF.commit_event(JF_APPLOG_COMMIT_EVENT, jf_commit_event_params, {is_priority_high = true})
  table.remove(events, 1)
  E.Timer.once(math.random(EVENTS_UPLOAD_INTERVAL_RANGE), function()
    upload_events_immediately(events)
  end)
end

local function upload_event_by_rule(original_event, rule)
  local event = E_UTILS.deepcopy(original_event)
  local event_name = event.name
  local event_params = event.params or {}
  local cmd = rule.cmd
  E.LOG.d(TAG, "根据规则处理事件 >> 事件名: " .. event_name .. ", 事件规则: " .. cmd)
  local upload_events = {}
  local jf_commit_rule_params = {
    event_name = event_name,
    generate_time = event.time,
    rule = cmd or "no_cmd",
    original_event_params = E_UTILS.deepcopy(event_params),
    will_upload = FILTER_EVENTS[event_name] or false
  }
  if cmd == EVENT_UPLOAD_CMDS.DEFAULT then
    table.insert(upload_events, event)
  elseif cmd == EVENT_UPLOAD_CMDS.WAIT then
    event.rule = {
      cmd = cmd,
      waitTime = rule.waitTime
    }
    local queue_event = E_UTILS.deepcopy(event)
    table.insert(events_queue, queue_event)
    jf_commit_rule_params.wait_time = rule.waitTime
  elseif cmd == EVENT_UPLOAD_CMDS.CHANGE_EVENT then
    event.name = rule.targetEvent or event_name
    table.insert(upload_events, event)
    jf_commit_rule_params.changed_event_name = rule.targetEvent
  elseif cmd == EVENT_UPLOAD_CMDS.CHANGE_PAY then
    local money = rule.money and rule.money[1]
    local product_info = event_params.product_info
    if product_info then
      product_info.money = money
      product_info.product_desc = product_info.product_desc and ""
      product_info.show_money = product_info.show_money and ""
    end
    table.insert(upload_events, event)
    jf_commit_rule_params.changed_money = money
  elseif cmd == EVENT_UPLOAD_CMDS.SPLIT_PAY then
    local split_money = rule.money or {}
    for i = 1, #split_money do
      local new_event = E_UTILS.deepcopy(event)
      local product_info = new_event.params and new_event.params.product_info
      if product_info then
        product_info.money = split_money[i]
        product_info.product_desc = product_info.product_desc and ""
        product_info.show_money = product_info.show_money and ""
      end
      table.insert(upload_events, new_event)
    end
    jf_commit_rule_params.split_money_arr = split_money
  end
  E.LOG.d(TAG, "按规则处理事件的过程 上报经分 >> 事件名: " .. event_name)
  JF.commit_event(JF_MODIFY_EVENT_BY_RULE, jf_commit_rule_params, {is_priority_high = true})
  upload_events_immediately(upload_events)
end

function handle_event(event_name, event_params)
  local event = {
    name = event_name,
    time = E.system_ms(),
    params = event_params
  }
  if enable_upload_rules and FILTER_EVENTS[event_name] then
    E.LOG.d(TAG, "产生事件，将事件添加到队列 >> 事件名: " .. event_name)
    table.insert(events_queue, event)
    if 1 == #events_queue then
      handle_events_queue()
      save_events_queue()
    end
  elseif not enable_upload_rules then
    upload_events_immediately({event})
  else
    E.LOG.d(TAG, event_name .. " 事件不在基本规则配置内，不上报")
  end
end

function handle_events_queue()
  if not events_queue or not next(events_queue) then
    E.LOG.d(TAG, "目前事件队列为空，等待新事件再轮询")
    save_events_queue()
    return
  end
  local event = events_queue[1]
  local rule = event.rule
  local event_name = event.name
  if rule and rule.cmd == EVENT_UPLOAD_CMDS.WAIT and event.time + rule.waitTime > E.system_ms() then
    local queue_event = E_UTILS.deepcopy(event)
    table.insert(events_queue, queue_event)
    table.remove(events_queue, 1)
    E.Timer.once(EVENTS_QUEUE_CHECKING_INTERVAL, function()
      handle_events_queue()
    end)
    return
  end
  local params = {acid = current_account_id}
  APPLOG_SERVER.get_event_upload_rule(event, params, function(succ, ...)
    if succ then
      local data = (...)
      data = data or {}
      local postback = data.postback
      E.LOG.d(TAG, "事件 " .. event_name .. " 是否上报: " .. tostring(postback))
      if postback then
        local upload_rule = data.rule or {}
        upload_event_by_rule(event, upload_rule)
      end
    else
      E.LOG.d(TAG, "请求回传控制接口失败，立即上报事件: " .. event_name)
      upload_events_immediately({
        E_UTILS.deepcopy(event)
      })
    end
    table.remove(events_queue, 1)
    E.Timer.once(EVENTS_QUEUE_CHECKING_INTERVAL, function()
      handle_events_queue()
    end)
  end)
end

function M.init(opt, cb)
  opt = opt or {}
  local arg = opt.arg or {}
  arg.channel_id = E.get_channel()
  E.log("applog init with arg:")
  E.log(arg)
  UNI.cast(VENDOR_NAME, CAST_INIT, arg)
  local sdk_infos = UNI.get_sdk_infos()
  local vendor_info = sdk_infos[VENDOR_NAME]
  local purchase_notify_mode = opt.purchase_notify_mode
  if vendor_info and vendor_info.meta then
    enable_upload_rules = vendor_info.meta.enable_upload_rules
    purchase_notify_mode = purchase_notify_mode or vendor_info.meta.purchase_notify_mode
  end
  if "NOTIFY_BY_SERVER" == purchase_notify_mode then
    purchase_strategies = PURCHASE_STRATEGIES.USE_CHAT_MSG
  end
  E.LOG.debug(TAG, "purchase_strategies:" .. tostring(purchase_strategies))
  E.log(opt)
  if applog_inited then
    E.LOG.debug(TAG, "already init, return")
    cb(true)
    return
  end
  if enable_upload_rules then
    APPLOG_SERVER.get_filtered_events_to_upload({}, function(succ, ...)
      if succ then
        local data = (...)
        data = data or {}
        local events = data.event
        if events and type(events) == "table" then
          local filtered_events_map = {}
          for i = 1, #events do
            filtered_events_map[events[i]] = true
          end
          if not filtered_events_map[EVENTS_NAME.ALL] then
            for key in pairs(FILTER_EVENTS) do
              FILTER_EVENTS[key] = filtered_events_map[key]
            end
          end
        end
      end
      events_queue = APPLOG_EVENTS_QUEUE:get() or {}
      handle_events_queue()
      save_events_queue()
    end)
    ET.subscribe(ET.gangplank.EXIT, function()
      APPLOG_EVENTS_QUEUE:set(events_queue)
    end)
  end
  ET.subscribe(ET.analytics.REGISTER, function(user_info)
    current_account_id = user_info and user_info.uid
    handle_event(EVENTS_NAME.REGISTER, {user_info = user_info})
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, function(user_info)
    local has_gbapplog = EC.has_vendor_config("gbapplog")
    local EG = require("ejoysdk_lua.ejoysdk_gangplank")
    local is_guest_result = EG.is_magic_guest()
    current_account_id = user_info and user_info.uid
    local event_params = {user_info = user_info, is_guest = is_guest_result}
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
          event_params.active_situation = activeSituation
          handle_event(EVENTS_NAME.ACQUIRE, event_params)
        else
          local code, msg = ...
          E.LOG.debug(TAG, "get login user info fail, code is " .. tostring(code) .. ", msg is " .. tostring(msg))
          handle_event(EVENTS_NAME.ACQUIRE, event_params)
        end
      end, "ejoysdk")
    else
      handle_event(EVENTS_NAME.ACQUIRE, event_params)
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

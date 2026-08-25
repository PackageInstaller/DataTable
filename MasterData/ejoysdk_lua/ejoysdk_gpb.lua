local E = require("ejoysdk_lua.ejoysdk")
local ER = require("ejoysdk_lua.ejoysdk_resource")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local ETOPIC = require("ejoysdk_lua.ejoysdk_topic")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_gpb"
local M = {}
local IVK_GPB_INIT = "GPB_INIT"
local IVK_GPB_PURCHASE = "GPB_PURCHASE"
local IVK_GPB_QUERY = "GPB_QUERY"
local IVK_GPB_CONSUME = "GPB_CONSUME"
local SYNC_GPB_CAN_BUY = "GPB_CAN_BUY"
local GPB_EVENT = "GPB_EVENT"
local EVENT_TYPE_INIT_SUCCESS = 0
local EVENT_TYPE_INIT_FAIL = 1
local EVENT_TYPE_QUERY_SUCCESS = 2
local EVENT_TYPE_QUERY_FAIL = 3
local EVENT_TYPE_PURCHASE_SUCCESS = 4
local EVENT_TYPE_PURCHASE_FAIL = 5
local EVENT_TYPE_CONSUME_SUCCESS = 6
local EVENT_TYPE_CONSUME_FAIL = 7
local gpb_pubkey, gpb_notify_cb
local gpb_inited = false

local function notify_order_url()
  do return EG.gangplank_url end
  return EG.gangplank_url, "/notify/google"
end

function M.init(pubkey, cb)
  assert(type(pubkey) == "string", "cb is not a string")
  assert(type(cb) == "function", "cb is not a function")
  gpb_pubkey = pubkey:gsub("%s+", "")
  
  function gpb_notify_cb(...)
    local succ, err = pcall(cb, ...)
    if not succ then
      print("purchase cb error", err)
    end
  end
  
  E.log("gpb_pubkey=" .. tostring(gpb_pubkey))
  E.invoke(IVK_GPB_INIT, {pubkey = pubkey})
end

function M.can_make_purchase()
  if not gpb_inited then
    E.log({
      msg = "gpb_inited is false"
    })
    return false
  end
  local EA = require("ejoysdk_lua.ejoysdk_android")
  local can, _err = EA.sync_call(SYNC_GPB_CAN_BUY)
  if false then
    E.log({
      msg = "Google Play Bill not setup yet"
    })
  end
  return can
end

function M.purchase_product_base(product_id, order_id)
  local server = EG.user_info().server
  local payload = "{1}" .. server .. ":" .. order_id
  E.invoke(IVK_GPB_PURCHASE, {product_id = product_id, payload = payload})
end

function M.purchase_product(product_id, outsource)
  if not M.can_make_purchase() then
    ETOPIC.publish("purchased", false, ER.order.CANT_PURCHASE)
    return
  end
  local _a, _b = pcall(function()
    EG.create_order_base(product_id, 1, "GOOGLE", outsource, function(succ, order_id)
      ETOPIC.publish("purchase_order", succ)
      if succ then
        ETOPIC.publish("purchasing", ER.order.PURCHASING)
        M.purchase_product_base(product_id, order_id)
      else
        ETOPIC.publish("purchased", false, ER.order.CREATE_ORDER_FAIL)
      end
    end)
  end)
end

local function notify_server(order)
  E.log({notify_order = order})
  local call_params = {
    game = E.CONFIG.get_config("product"),
    token = EG.user_info().token,
    receipt = order.signatureData,
    signature = order.signature
  }
  ETOPIC.publish("purchasing", ER.order.PURCHASING)
  E.HTTP.post(notify_order_url(), {}, E.HTTP.CT_URLENCODED, call_params, function(resp)
    E.log({resp = resp})
    if resp.status ~= 200 then
      ETOPIC.publish("purchased", false, ER.order.UNKNOWN)
      return
    end
    E.log({
      ssss = resp.body.code == 10005,
      typeBody = type(resp.body),
      value = resp.body
    })
    local body = resp.body
    if 0 == body.code then
      E.invoke(IVK_GPB_CONSUME, {
        product_id = order.productId
      })
      ETOPIC.publish("purchased", true, ER.order.OK)
      gpb_notify_cb(true, body)
      return
    end
    if body.code == 10005 then
      E.invoke(IVK_GPB_CONSUME, {
        product_id = order.productId
      })
      ETOPIC.publish("purchased", false, ER.order.TRING)
      return
    end
    if body.code == 10006 then
      E.invoke(IVK_GPB_CONSUME, {
        product_id = order.productId
      })
      return
    end
  end)
end

local event_dispatch = {
  [EVENT_TYPE_INIT_SUCCESS] = function()
    E.log({
      msg = "EVENT_TYPE_INIT_SUCCESS"
    })
    gpb_inited = true
    ETOPIC.publish("gpb_inited")
    E.invoke(IVK_GPB_QUERY)
  end,
  [EVENT_TYPE_INIT_FAIL] = function(params)
    E.log({
      msg = "EVENT_TYPE_INIT_FAIL",
      params = params
    })
    gpb_inited = false
  end,
  [EVENT_TYPE_QUERY_SUCCESS] = function(params)
    E.log({
      msg = "EVENT_TYPE_QUERY_SUCCESS",
      params = params
    })
    local orders = JSON.decode(params)
    for _, order in pairs(orders) do
      notify_server(order)
    end
  end,
  [EVENT_TYPE_QUERY_FAIL] = function(params)
    E.log({
      msg = "EVENT_TYPE_QUERY_FAIL",
      params = params
    })
  end,
  [EVENT_TYPE_PURCHASE_SUCCESS] = function(params)
    E.log({
      msg = "EVENT_TYPE_PURCHASE_SUCCESS"
    })
    local order = JSON.decode(params)
    notify_server(order)
  end,
  [EVENT_TYPE_PURCHASE_FAIL] = function(params)
    E.log({
      msg = "EVENT_TYPE_PURCHASE_FAIL",
      params = params
    })
    local info = JSON.decode(params)
    local reason = "code_" .. info.code
    local msg = info.message
    if info.code == -1005 then
      reason = "cancel"
      msg = ER.order.CANCEL
    end
    ETOPIC.publish("purchased", false, msg)
    gpb_notify_cb(false, reason)
  end,
  [EVENT_TYPE_CONSUME_SUCCESS] = function()
    E.log({
      msg = "EVENT_TYPE_CONSUME_SUCCESS"
    })
  end,
  [EVENT_TYPE_CONSUME_FAIL] = function(params)
    E.log({
      msg = "EVENT_TYPE_CONSUME_FAIL",
      params = params
    })
  end
}
_ejoysdk.register_cb(GPB_EVENT, function(cbid, ...)
  local handler = event_dispatch[cbid]
  if handler then
    handler(...)
  end
end)

local function billboard_show_purchasing(info)
  if info then
    E.Toast.show(info)
  end
end

local function billboard_show_purchased(_succ, info)
  if info then
    E.Toast.show(info)
    E.Timer.once(3, E.Toast.hide)
  end
end

function M.billboard_show()
  ETOPIC.subscribe("gpb_purchasing", billboard_show_purchasing)
  ETOPIC.subscribe("gpb_purchased", billboard_show_purchased)
end

return M

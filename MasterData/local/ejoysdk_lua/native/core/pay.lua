local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
local LUTIL = require("ejoysdk_lua.native.utils.Utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local pay_callback
local M = {}
local _TAG = EM.MODULE.NATIVE .. "core.pay"

function M.pay(params, cb)
  pay_callback = cb
  local product_id = params.product_id
  local vendor_name = params.pay_vendor
  local ext = params.ext or {}
  local count = params.count
  gangplank.pay(vendor_name, product_id, count, ext)
end

function M.get_product_list(params, cb)
  local vendor_name = params.pay_vendor
  gangplank.get_product_list(vendor_name, function(succ, ...)
    if succ then
      local products = (...)
      LUTIL.notify(cb, true, "获取商品列表成功", products)
    else
      local code = (...)
      LUTIL.notify(cb, false, "获取商品列表失败,code:" .. code, nil)
    end
  end)
end

function M.pay_listener(succ, ...)
  if succ then
    local orderId, _ext = ...
    LUTIL.notify(pay_callback, true, "支付成功", {orderId = orderId})
  else
    local orderId, code, msg, ext = ...
    ext = ext or {}
    LUTIL.notify(pay_callback, false, "支付失败, code: " .. code .. " ,msg: " .. msg, {
      order_id = orderId,
      code = code,
      msg = msg,
      ext = ext
    })
  end
end

return M

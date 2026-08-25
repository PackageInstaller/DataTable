local Vendor = require("ejoysdk_lua.vendors.vendor")
local VENDOR_NAME = "WIN_OVERSEAS_PAY"
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local E = require("ejoysdk_lua.ejoysdk")
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.H5_OVERSEAS_PAY
local initted = false
local pay_listener

function M.init(opt)
  E.LOG.debug(TAG, "init begin")
  if initted then
    E.LOG.debug(TAG, "already initted, and return")
    return
  end
  initted = true
  pay_listener = opt.pay_listener
end

local function get_pay_url()
  local url
  local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
  local gangplank_config = EGC.get_current_cdn_config()
  if gangplank_config and gangplank_config.render_center and gangplank_config.render_center.payment and gangplank_config.render_center.payment ~= "" then
    url = gangplank_config.render_center.payment
  end
  E.LOG.d(TAG, "get_pay_url, ret=" .. tostring(url))
  return url
end

function M.pay(product_id, gp_order_id, ds_order_id, attach_info_str, local_params)
  E.LOG.d(TAG, "start pay, params >>")
  E.LOG.d(TAG, {
    product_id = product_id,
    gp_order_id = gp_order_id,
    ds_order_id = ds_order_id,
    attach_info_str = attach_info_str,
    local_params = local_params
  })
  local_params = local_params or {}
  if not product_id then
    E.LOG.warn(TAG, "product id not exist")
    pay_listener(false, gp_order_id, {
      code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_PRODUCT_ID_NOT_EXIST,
      msg = "product id not exist"
    })
    return
  end
  if not ds_order_id then
    E.LOG.warn(TAG, "order id not exist")
    pay_listener(false, gp_order_id, {
      code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_ORDER_ID_NOT_EXIST,
      msg = "order id not exist"
    })
    return
  end
  local url = get_pay_url()
  if not url or "" == url then
    E.LOG.warn(TAG, "pay h5 url not config")
    pay_listener(false, gp_order_id, {
      code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_WEB_URL_NOT_CONFIG,
      msg = "pay h5 url not config"
    })
    return
  end
  local product = local_params.product_info
  if not product then
    E.LOG.warn(TAG, "pay product not exist")
    pay_listener(false, gp_order_id, {
      code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_PRODUCT_NOT_EXIST,
      msg = "pay product not exist"
    })
    return
  end
  local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
  E.LOG.debug(TAG, "此时固定拉起新的支付收银台。for 海外安卓官渠包和PC官渠包，仁辉此时肯定灰度完成了")
  ejoy_pay.pay(gp_order_id, ds_order_id, product, attach_info_str)
end

function M.skip_official_order()
  local res = false
  E.LOG.debug(TAG, "skip_official_order=" .. tostring(res))
  return res
end

function M.skip_gp_order()
  local res = false
  E.LOG.debug(TAG, "skip_gp_order=" .. tostring(res))
  return res
end

return M

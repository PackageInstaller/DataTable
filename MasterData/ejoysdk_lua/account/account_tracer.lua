local ETracer = require("ejoysdk_lua.ejoysdk_span_reporter")
local M = {}
M.ACCOUNT_FLOWS_SPANS = {
  LOGIN = "login",
  CM_LOGIN = "cm_login",
  VENDOR_LOGIN = "vendor_login",
  ALIGAMES_LOGIN = "aligames_login",
  OFFICIAL_LOGIN = "official_login",
  OFFICIAL_PROXY_LOGIN = "official_proxy_login",
  OVERSEA_LOGIN = "oversea_login",
  UCENTER_LOGIN = "ucenter_login",
  UCENTER_API_LOGIN = "ucenter_api_login",
  FACEBOOK_LOGIN = "facebook_login",
  AIRLINE_V2_LOGIN = "airline_v2_login",
  ANT_LOGIN = "ant_login",
  TAP_LOGIN = "tap_login"
}
M.PAY_FLOWS_SPANS = {
  PAY = "pay",
  GANGPLANK_PAY = "gangplank_pay",
  ACCOUNT_PAY = "account_pay",
  GPS_PAY = "gps_pay",
  ALIGAMES_PAY = "aligames_pay",
  OFFICIAL_PAY = "official_pay",
  H5_OVERSEAS_PAY = "h5_overseas_pay",
  EJOY_PAY = "ejoy_pay",
  EJOY_PAY_H5 = "ejoy_pay_h5",
  EJOY_PAY_IOS = "ejoy_pay_ios",
  EJOY_PAY_HARMONYOS = "ejoy_pay_harmonyos",
  EJOY_PAY_WEGAME = "ejoy_pay_wegame",
  CANNEL_PAY = "channel_pay",
  UPLOAD_RECEIPT_PAY = "upload_receipt_pay",
  WEIXIN_PAY = "weixin_pay",
  DOUYIN_PAY = "douyin_pay",
  WEIXIN_MINI_CLOUDGAME_PAY = "weixin_mini_cloudgame_pay"
}
local login_span, pay_span

function M.start_login_span(vendor_name, region)
  local tags = {vendor = vendor_name, region = region}
  login_span = ETracer.start_span(M.ACCOUNT_FLOWS_SPANS.LOGIN, nil, tags)
  return login_span
end

function M.get_login_span()
  return login_span
end

function M.start_login_sub_span(span_name, tags)
  if login_span then
    local sub_span = ETracer.start_span(span_name, login_span:context():get_span_id(), tags)
    return sub_span
  end
  return nil
end

function M.finish_login_sub_span(span, tags)
  if not span then
    return
  end
  ETracer.finish_span(span:context():get_span_id(), tags)
end

function M.finish_login_span(tags)
  if login_span then
    ETracer.finish_span(login_span:context():get_span_id(), tags)
    login_span = nil
  end
end

function M.start_pay_span(vendor_name, product_id)
  local tags = {vendor = vendor_name, product_id = product_id}
  pay_span = ETracer.start_span(M.PAY_FLOWS_SPANS.PAY, nil, tags)
  return pay_span
end

function M.start_pay_sub_span(span_name, tags)
  if pay_span then
    local sub_span = ETracer.start_span(span_name, pay_span:context():get_span_id(), tags)
    return sub_span
  end
  return nil
end

function M.finish_pay_sub_span(span, tags)
  if not span then
    return
  end
  ETracer.finish_span(span:context():get_span_id(), tags)
end

function M.finish_pay_span(tags)
  if pay_span then
    ETracer.finish_span(pay_span:context():get_span_id(), tags)
    pay_span = nil
  end
end

return M

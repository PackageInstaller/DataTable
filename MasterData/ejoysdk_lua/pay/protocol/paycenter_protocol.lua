local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_lunajson")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local TAG = EM.MODULE.USER_CENTER .. "paycenter_protocol"
local M = {}
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.URL_BASE_DOMAIN_CN = {
  DEBUG = "https://daily-gps-cn.qookkagames.com",
  PRE_RELEASE = "https://pre-gps.lingxigames.com",
  RELEASE = "https://gps.lingxigames.com"
}
M.URL_BASE_DOMAIN_OVERSEA = {
  DEBUG = "",
  PRE_RELEASE = "",
  RELEASE = ""
}
M.SERVICE = {
  PAY_SDK_INIT = "com.pay.init",
  PAY_SDK_INFO_QUERY = "com.pay.cashier.promo.query",
  PAY_UPLOAD_RECEIPT = "com.pay.order.verify",
  PAY_UPLOAD_RECEIPT_IOS = "com.pay.ios.order.verify",
  PAY_PRE_CREATE_ORDER = "com.pay.order.create",
  PAY_PRE_CREATE_ORDER_IOS = "com.pay.ios.order.create",
  PAY_RESERVE_REPORT_IOS = "com.pay.ios.order.reservate",
  PAY_SDK_REPORT_ORDER_IOS = "com.pay.ios.order.report"
}
local l_env

function M.set_env(env)
  E.LOG.debug(TAG, "set_env: " .. tostring(env))
  l_env = env
end

local function get_env()
  if l_env then
    return l_env
  end
  local EI = require("ejoysdk_lua.ejoysdk_init")
  do return end
  return EI.env
end

function M.set_pay_url_base(api_url)
  E.LOG.debug(TAG, "set_url_base, api_url = " .. tostring(api_url))
  if not UTIL.STR.is_empty(api_url) then
    local _env = get_env()
    local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if is_oversea then
      if _env == M.ENV.DEBUG then
        M.URL_BASE_DOMAIN_OVERSEA.DEBUG = api_url
      elseif _env == M.ENV.PRE_RELEASE then
        M.URL_BASE_DOMAIN_OVERSEA.PRE_RELEASE = api_url
      else
        M.URL_BASE_DOMAIN_OVERSEA.RELEASE = api_url
      end
    elseif _env == M.ENV.DEBUG then
      M.URL_BASE_DOMAIN_CN.DEBUG = api_url
    elseif _env == M.ENV.PRE_RELEASE then
      M.URL_BASE_DOMAIN_CN.PRE_RELEASE = api_url
    else
      M.URL_BASE_DOMAIN_CN.RELEASE = api_url
    end
  end
end

function M.get_pay_url_base()
  local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  local _env = get_env()
  local gps_server_domain
  if is_oversea then
    gps_server_domain = M.URL_BASE_DOMAIN_OVERSEA.RELEASE
    if _env == M.ENV.DEBUG then
      gps_server_domain = M.URL_BASE_DOMAIN_OVERSEA.DEBUG
    elseif _env == M.ENV.PRE_RELEASE then
      gps_server_domain = M.URL_BASE_DOMAIN_OVERSEA.PRE_RELEASE
    end
    if UTIL.STR.is_empty(gps_server_domain) then
      E.LOG.debug(TAG, "is_oversea game，支付初始化接口未返回支付预下单的域名，所以海外游戏读取global-config里的支付域名来兜底")
      local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
      local gangplank_config = EGC.get_current_cdn_config()
      E.LOG.debug(TAG, {gangplank_config = gangplank_config})
      gps_server_domain = gangplank_config.paysdk_api_url_i
      if not gps_server_domain then
        E.LOG.error(TAG, "当前选择的区域，没有配置支付服务器的域名, global-config里的paysdk_api_url_i字段是空的")
      end
    else
      E.LOG.debug(TAG, "支付初始化接口已经返回了支付预下单的域名，直接用就好，不再读取global-config的配置, gps_server_domain = " .. tostring(gps_server_domain))
    end
  else
    gps_server_domain = M.URL_BASE_DOMAIN_CN.RELEASE
    if _env == M.ENV.DEBUG then
      gps_server_domain = M.URL_BASE_DOMAIN_CN.DEBUG
    elseif _env == M.ENV.PRE_RELEASE then
      gps_server_domain = M.URL_BASE_DOMAIN_CN.PRE_RELEASE
    end
  end
  return gps_server_domain
end

local function get_paycenter_body(api)
  local body = {}
  body.service = api
  body.version = "1.0"
  if _ejoysdk.os() == "ios" then
    body.biz_id = "ISP"
  elseif _ejoysdk.os() == "windows" or _ejoysdk.os() == "douyin" then
    body.biz_id = "SELF"
  else
    body.biz_id = "ASP"
  end
  body.app_id = E.get_pkg_info().game_id
  if _ejoysdk_crypt.hmac_sha256 then
    body.secure_mode = "HMAC_SHA256"
  else
    body.secure_mode = "MD5"
  end
  body.secure_version_id = M.get_secure_version_id()
  return body
end

function M.get_secret_key()
  local secret_key_v1 = "b8cedc42475382352ed4d169c23d4472"
  local _env = get_env()
  if _env == M.ENV.DEBUG then
    secret_key_v1 = "9e7a1f9e3d01ba7c57a92f4d6b120c6d"
  end
  return secret_key_v1
end

function M.get_secure_version_id()
  local secure_version_id = "v1"
  return secure_version_id
end

local function make_sign_str_from_map(sign_map)
  local k_list = {}
  for k, _v in pairs(sign_map) do
    table.insert(k_list, k)
  end
  table.sort(k_list)
  local sign_content_str = ""
  local index = 0
  for _, k_item in pairs(k_list) do
    if index > 0 then
      sign_content_str = sign_content_str .. "&"
    end
    sign_content_str = sign_content_str .. tostring(k_item) .. "=" .. tostring(sign_map[k_item])
    index = index + 1
  end
  return sign_content_str
end

local function post_to(url, api, params, cb)
  E.LOG.debug(TAG, "post, url:" .. url)
  local paycetner_body = get_paycenter_body(api)
  local req_data = {}
  if _ejoysdk.os() == "ios" then
    local ejoyPay = require("ejoysdk_lua.vendors.ejoy_pay")
    local frontData = ejoyPay.get_store_front_data()
    req_data.app_store_country_code = frontData.app_store_country_code
    req_data.app_store_identifier = frontData.app_store_identifier
    req_data.store_country_code = frontData.app_store_country_code
    if UTIL.STR.is_empty(req_data.store_country_code) and params.country_code then
      req_data.store_country_code = params.country_code
    end
  else
    if _ejoysdk.os() == "harmonyos" then
      req_data.pay_type = "240"
    end
    local pay_info = {}
    pay_info.order_id = params.cpOrderId
    pay_info.user_id = EG.user_info().uid
    pay_info.prd_id = params.payProductID
    pay_info.prd_type = "1"
    pay_info.prd_name = params.payProductName
    pay_info.currency = params.currency or "CNY"
    pay_info.order_amt = tostring(tonumber(params.order_amt))
    pay_info.min_order_amt = params.min_order_amt
    req_data.pay_info = JSON.encode(pay_info)
    local officialpay_vendor = require("ejoysdk_lua.vendors.official_pay")
    req_data.store_country_code = officialpay_vendor.getGoogleAccountPayArea()
  end
  req_data.user_id = EG.user_info().uid
  local userInfo = params.player_info or {}
  if type(userInfo) ~= "string" then
    req_data.user_info = JSON.encode(userInfo)
  else
    req_data.user_info = userInfo
  end
  params.player_info = nil
  for k, v in pairs(params) do
    req_data[k] = v
  end
  req_data.country_id = E.CONFIG.get_config("district")
  req_data.os = E.Sysinfo.os()
  req_data.os_ver = E.Sysinfo.os_version()
  req_data.utdid = E.Sysinfo.utdid()
  req_data.model = E.Sysinfo.model()
  if "string" == type(req_data.language) and req_data.language ~= "" then
    E.LOG.debug(TAG, "pay params contains language, do not get from system interface")
  else
    req_data.language = E.Sysinfo.language()
  end
  req_data.bundle_id = E.Sysinfo.package_name()
  req_data.sdk_ver = E.get_sdk_version_name("EJOYSDK")
  req_data.pkg_info = JSON.encode(E.get_pkg_info())
  req_data.idfv = E.Sysinfo.uuid()
  req_data.device_id = E.Sysinfo.device_id()
  paycetner_body.req_data = req_data
  local sign_map = UTILS.deepcopy(paycetner_body)
  sign_map.req_data = JSON.encode(req_data)
  local sign_content_str = make_sign_str_from_map(sign_map)
  sign_content_str = sign_content_str .. M.get_secret_key()
  E.LOG.debug(TAG, "sign_content_str = " .. sign_content_str)
  local EJ_SIGN = require("ejoysdk_lua.libs.signature")
  local sign_result = "test_sign_result"
  if req_data.skip_verify == "yes" then
    paycetner_body.sign = "test_sign"
    E.LOG.debug(TAG, "skip_verify = yes, do not sign the body")
  else
    if paycetner_body.secure_mode == "HMAC_SHA256" then
      sign_result = EJ_SIGN.sign_string_with_hmac_sha256(M.get_secret_key(), sign_content_str)
    elseif paycetner_body.secure_mode == "MD5" then
      sign_result = EJ_SIGN.sign_string_with_md5(sign_content_str)
    else
      E.LOG.error(TAG, tostring(paycetner_body.secure_mode) .. "不支持的加签算法！！！")
    end
    if sign_result and "" ~= sign_result and string.len(sign_result) > 0 then
      paycetner_body.sign = sign_result
    else
      E.LOG.debug(TAG, "sign_result is empty string, someting is wrong")
      if cb then
        cb(false, CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_FAIL_SIGN_OR_VERIFY_NOT_MATCH, "sign for HTTP request failed，sign_result is empty!")
      end
      return
    end
  end
  E.LOG.debug(TAG, "post, paycetner_body>>")
  E.LOG.debug(TAG, paycetner_body)
  E.HTTP.post(url, {}, E.HTTP.CT_JSON, paycetner_body, function(resp)
    E.LOG.debug(TAG, "post response received, url:" .. tostring(url))
    E.LOG.debug(TAG, resp)
    if resp.status == 200 then
      local body_json = resp.body
      if type(resp.body) == "string" then
        body_json = JSON.decode(resp.body)
      end
      if body_json.status then
        if body_json.status == "ok" then
          E.LOG.debug(TAG, "post response succ, url:" .. tostring(url))
          E.LOG.debug(TAG, "body_json ==== ")
          E.LOG.debug(TAG, body_json)
          local body_data = JSON.safe_decode(body_json.rsp_data)
          body_data.secure_mode = body_json.secure_mode
          body_data.sign = body_json.sign
          E.LOG.debug(TAG, "body_data ====")
          E.LOG.debug(TAG, body_data)
          cb(true, body_data)
        else
          E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", code:" .. tostring(body_json.error_code) .. ", msg:" .. tostring(body_json.error_msg))
          cb(false, body_json.error_code, body_json.error_msg, body_json)
        end
      else
        E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", body.state is nil")
        cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_RESPONSE_INVALID, "resp.body parse fail")
      end
    else
      E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", status:" .. tostring(resp.status))
      cb(false, resp.status, "http request fail")
    end
  end)
end

function M.post(api, params, cb)
  local gps_server_domain = M.get_pay_url_base()
  local gps_server_path = "/sdk/rest/api.htm"
  local url = gps_server_domain
  E.LOG.debug(TAG, "gps_server_domain = " .. gps_server_domain)
  E.LOG.debug(TAG, "gps_server_path = " .. gps_server_path)
  if not E.Utils.end_with(url, "api.htm") then
    url = gps_server_domain .. gps_server_path
    E.LOG.debug(TAG, "url 不包含路径，所以拼接下")
  end
  post_to(url, api, params, cb)
end

return M

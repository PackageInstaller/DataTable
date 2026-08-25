local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local vendor_name = "GOOGLEADS"
local ADS_LOAD = "ADS_LOAD"
local ADS_STATUS = "ADS_STATUS"
local EVENT_CREATE_ORDER = "ejoy_adv_order"
local EVENT_CREATE_ORDER_SUCC = "ejoy_adv_order_succ"
local EVENT_CREATE_ORDER_FAIL = "ejoy_adv_order_fail"
local EVENT_SHOW = "ejoy_adv_show"
local EVENT_SHOW_SUCC = "ejoy_adv_show_succ"
local EVENT_SHOW_FAIL = "ejoy_adv_show_fail"
local M = Vendor:Inherit(vendor_name)
local TAG = EM.MODULE.VENDORS.ADV
M.status = {
  AD_STATUS_ERR = -1,
  AD_STATUS_SHOWN = 1,
  AD_STATUS_CLICKED = 2,
  AD_STATUS_COMPLETED = 3,
  AD_STATUS_CLOSED = 4,
  AD_ERR_LOAD_FAIL = -99,
  AD_ERR_NOT_READY = -98,
  AD_ERR_LOAD_SHOW = -97,
  AD_ERR_C_ORDER_FAIL = -96,
  AD_ERR_NO_TOKEN = -95,
  AD_PRE_STATUS_NOT_LOAD = 1097,
  AD_PRE_STATUS_LOADING = 1098,
  AD_PRE_STATUS_HAS_LOADED = 1099,
  AD_PRE_STATUS_LOAD_FAIL = -1098,
  AD_PRE_STATUS_LOAD_ERR = -1099
}
local ADV_API = {}

local function request_params()
  local token = EH.get_player_token()
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = token
    }
  }
end

local function base_url()
  return E.CONFIG.get_config("ad-server"):lower() .. "/client_api/"
end

function M.query_list(cb)
  local url = base_url() .. "list_ad"
  E.LOG.debug(TAG, "google_ads: start to query ad list:" .. tostring(url))
  local params = {
    pkg_info = E.get_pkg_info()
  }
  E.HTTP.post(url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    local status = resp.status
    local body = resp.body
    if 200 == status then
      cb(true, body.data)
      E.LOG.debug(TAG, "google_ads: request ad list succ")
    else
      cb(false, {})
      E.LOG.debug(TAG, "google_ads: request ad list fail, status code = " .. tostring(status))
    end
  end)
end

local function player_token_handler(player_token)
  E.LOG.debug(TAG, "google_ads: ads player token=" .. (player_token or "null"))
  M.query_list(function(succ, adlist)
    if succ then
      for i = 1, #adlist do
        local params = {
          id = adlist[i].id,
          preload = true
        }
        M.loadAd(vendor_name, params, nil)
      end
    end
  end)
end

local function createOrder(ad_id, callback)
  local url = base_url() .. "create_order"
  local params = {
    id = ad_id,
    pkg_info = E.get_pkg_info()
  }
  E.HTTP.post(url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    E.LOG.debug(TAG, "google_ads:create order succ")
    local status = resp.status
    local body = resp.body
    if 200 == status then
      callback(200, body.data)
    else
      E.LOG.debug(TAG, "google_ads:create order fail, status = " .. tostring(status))
      local switch = {
        [10000] = function()
          E.LOG.debug(TAG, "google_ads: 传参错误")
        end,
        [10001] = function()
          E.LOG.debug(TAG, "google_ads: 广告已过期")
        end,
        [10002] = function()
          E.LOG.debug(TAG, "google_ads: 满足广告条件")
        end,
        [10003] = function()
          E.LOG.debug(TAG, "google_ads: 找不到玩家id")
        end,
        [10004] = function()
          E.LOG.debug(TAG, "google_ads: 没达到看广告最小间隔")
        end,
        [10005] = function()
          E.LOG.debug(TAG, "google_ads: 超过设定的看广告频率")
        end,
        [10500] = function()
          E.LOG.debug(TAG, "google_ads: 创建订单失败")
        end
      }
      local func = switch[status]
      if func then
        func()
      else
        E.LOG.debug(TAG, "google_ads: 创建订单失败")
      end
      callback(status, {})
    end
  end)
end

function M.adsInit()
  do
    local os_config = E.CONFIG.get_config("os")
    if "android" == os_config then
      function ADV_API.loadAd(chn, params, cb)
        UNI.async_call(chn, ADS_LOAD, params, nil, cb)
      end
      
      function ADV_API.getAdStatus(chn, params)
        do return UNI.sync_call, chn, ADS_STATUS, params end
        return UNI.sync_call, chn, ADS_STATUS, params, nil
      end
    elseif "ios" == os_config then
      function ADV_API.loadAd(chn, params, cb)
        UNI.async_call(chn, ADS_LOAD, params, nil, cb)
      end
      
      function ADV_API.getAdStatus(chn, params)
        do return UNI.sync_call, chn, ADS_STATUS, params end
        return UNI.sync_call, chn, ADS_STATUS, params, nil
      end
    end
  end
  ET.subscribe(ET.holo.GET_PLAYER_TOKEN, player_token_handler)
end

local function isKeyInTable(tbl, key)
  if nil == tbl then
    return false
  end
  for k, _ in pairs(tbl) do
    if k == key then
      return true
    end
  end
  return false
end

function M.loadAd(chn, oParams, cb)
  local token = EH.get_player_token()
  cb = cb or function(...)
  end
  if nil == token or "" == token then
    E.LOG.debug(TAG, "google_ads: no player token, skip showing ad")
    local body = {
      err_code = M.status.AD_ERR_NO_TOKEN,
      err_msg = "没有用户角色token"
    }
    cb(false, M.status.AD_ERR_NO_TOKEN, body, nil)
    return
  end
  oParams = oParams or {}
  local ad_id = oParams.id
  local is_preload = false
  if isKeyInTable(oParams, "preload") then
    is_preload = oParams.preload
  end
  local params = {adId = ad_id}
  QL.commit_event(EVENT_CREATE_ORDER, params)
  createOrder(ad_id, function(status, ad_detail)
    if 200 == status then
      if nil ~= ad_detail then
        ad_detail.preload = is_preload
        QL.commit_event(EVENT_CREATE_ORDER_SUCC, params)
        QL.commit_event(EVENT_SHOW, params)
        ADV_API.loadAd(chn, ad_detail, function(succ, ...)
          if succ then
            local body = (...)
            local s = body.status
            params.code = s
            QL.commit_event(EVENT_SHOW_SUCC, params)
          else
            local _, body = ...
            local err_code = body.err_code
            params.code = err_code
            QL.commit_event(EVENT_SHOW_FAIL, params)
          end
          cb(succ, ...)
        end)
      end
    else
      local body = {
        err_code = M.status.AD_ERR_C_ORDER_FAIL,
        err_msg = "创建订单失败"
      }
      cb(false, M.status.AD_ERR_C_ORDER_FAIL, body, nil)
      QL.commit_event(EVENT_CREATE_ORDER_FAIL, params)
    end
  end)
end

function M.get_status(chn, oParams)
  local status_info = ADV_API.getAdStatus(chn, oParams)
  status_info = status_info or {}
  if nil ~= status_info then
    local code = status_info.code
    if code == M.status.AD_PRE_STATUS_NOT_LOAD or code == M.status.AD_PRE_STATUS_LOAD_FAIL or code == M.status.AD_PRE_STATUS_LOAD_ERR then
      local pre_params = {
        id = oParams.id,
        preload = true
      }
      M.loadAd(vendor_name, pre_params, nil)
    end
  end
  return status_info
end

return M

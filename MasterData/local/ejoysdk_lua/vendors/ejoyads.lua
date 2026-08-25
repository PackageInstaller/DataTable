local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ADS_VENDER_NAME = "EJOYADS"
local ADS_INIT = "ADS_INIT"
local ADS_LOAD = "ADS_LOAD"
local ADS_STATUS = "ADS_STATUS"
local ADS_SHOW = "ADS_SHOW"
local ADS_CLOSE = "ADS_CLOSE"
local ADS_SUPPORT_AD_TYPES = "ADS_SUPPORT_AD_TYPES"
local IS_SUPPORT_INIT_AD_SDK = "IS_SUPPORT_INIT_AD_SDK"
local EVENT_CREATE_ORDER = "sdk.ejoy_ads_order"
local EVENT_CREATE_ORDER_SUCC = "sdk.ejoy_ads_order_succ"
local EVENT_CREATE_ORDER_FAIL = "sdk.ejoy_ads_order_fail"
local EVENT_GET_SERVICE_SUCC = "sdk.ejoy_ads_get_service_succ"
local EVENT_GET_SERVICE_FAIL = "sdk.ejoy_ads_get_service_fail"
local EVENT_LOAD = "sdk.ejoy_ads_load"
local EVENT_LOAD_SUCC = "sdk.ejoy_ads_load_succ"
local EVENT_LOAD_FAIL = "sdk.ejoy_ads_load_fail"
local EVENT_SHOW = "sdk.ejoy_ads_show"
local EVENT_SHOW_START = "sdk.ejoy_ads_show_start"
local EVENT_SHOW_SUCC = "sdk.ejoy_ads_show_succ"
local _EVENT_SHOW_CLICK = "sdk.ejoy_ads_show_click"
local EVENT_SHOW_FAIL = "sdk.ejoy_ads_show_fail"
local EVENT_NOTIFY = "sdk.ejoy_ads_notify"
local EVENT_NOTIFY_SUCC = "sdk.ejoy_ads_notify_succ"
local EVENT_NOTIFY_FAIL = "sdk.ejoy_ads_notify_fail"
local EVENT_CLOSE = "sdk.ejoy_ads_close"
local EVENT_CLOSE_SUCC = "sdk.ejoy_ads_close_succ"
local EVENT_CLOSE_FAIL = "sdk.ejoy_ads_close_fail"
local EVENT_IMPRESSION_START = "sdk.ads.impression.start"
local EVENT_IMPRESSION_END = "sdk.ads.impression.end"
local MAX_NOFITY_RETRY = 3
local CHANNEL = "EJOYADS"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.EJOY_ADS
M.status = {
  AD_ERR_C_ORDER_FAIL = -99,
  AD_ERR_NO_TOKEN = -98,
  AD_ERR_C_AD_SERVICE_FAIL = -97,
  AD_ERR_C_UNSUPPORT_TYPE = -96,
  AD_INIT_SUCC = 10300,
  AD_INIT_FAIL = 10301,
  AD_SHOW_ERR = 10200,
  AD_SHOW_FAIL = 10201,
  AD_SHOW_CLOSE = 10202,
  AD_SHOW_COMPLETED = 10203,
  AD_CLOSE_FAIL = 10204,
  AD_SHOW_START = 10205,
  AD_SHOW_CLICK = 10206,
  AD_LOAD_ERR = 10100,
  AD_LOAD_LOADING = 10101,
  AD_LOAD_FAIL = 10102,
  AD_LOAD_SUCC = 10103,
  AD_STATUS_ERR = 10000,
  AD_STATUS_NOT_EXISTS = 10001,
  AD_STATUS_NOT_LOAD = 10002,
  AD_STATUS_LOADING = 10003,
  AD_STATUS_READY = 10004,
  AD_STATUS_SHOWING = 10005,
  AD_STATUS_FINISHED = 10006
}
local load_succ_result = {}
local support_ad_types = {}
local VENDOR_ADS = {}

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

local MAX_BANNER_PRELOAD_NUM = 3
local MAX_VIDEO_PRELOAD_NUM = 1

local function player_online_handler(_player_token)
  M.query_list(function(succ, adlist)
    if succ then
      local video_count = 0
      local banner_count = 0
      local total_ad = #adlist
      local loaded_ad = 0
      E.log("ejoyads: 检测到有" .. tostring(total_ad) .. "个广告需要预加载")
      for _, ad in ipairs(adlist) do
        if ad.type == "video" and video_count < MAX_VIDEO_PRELOAD_NUM then
          M.load_ad(ad, function(succ2, ...)
            if succ2 then
              E.log("ejoyads: video 广告预加载成功")
            else
              E.log("ejoyads: video 广告预加载失败")
            end
          end)
          video_count = video_count + 1
          loaded_ad = loaded_ad + 1
        elseif ad.type == "banner" and banner_count < MAX_BANNER_PRELOAD_NUM then
          M.load_ad(ad, function(succ2, ...)
            if succ2 then
              E.log("ejoyads: banner 广告预加载成功")
            else
              E.log("ejoyads: banner 广告预加载失败")
            end
          end)
          banner_count = banner_count + 1
          loaded_ad = loaded_ad + 1
        end
      end
      E.log("ejoyads: 实际预加载数量为" .. loaded_ad .. "个（vidoe：" .. video_count .. "，banner：" .. banner_count .. "）")
    end
  end)
end

function M.fill_support_ad_types()
  support_ad_types = VENDOR_ADS.support_ad_types() or {video = 1}
end

function M.initAd()
  E.LOG.debug(TAG, "ejoyads: start initAd")
  
  local function init_callback(succ, ...)
    if succ then
      E.LOG.debug(TAG, "ejoyads: 初始化成功")
    else
      E.LOG.debug(TAG, "ejoyads: 初始化失败")
    end
  end
  
  local ad_plugins = UNI.get_sdk(Vendor.ABILITY.CHANNEL_AD)
  E.LOG.debug(TAG, {table_print = ad_plugins})
  if nil == ad_plugins or nil == ad_plugins.sdks or nil == next(ad_plugins.sdks) then
    UNI.async_call(ADS_VENDER_NAME, ADS_INIT, {}, nil, init_callback)
  else
    local sdk_infos = UNI.get_sdk_infos()
    local ad_configs = {}
    for name, config in pairs(sdk_infos) do
      for _index, ad_plugin_name in pairs(ad_plugins.sdks) do
        if name == ad_plugin_name then
          table.insert(ad_configs, config.meta)
          break
        end
      end
    end
    if nil == next(ad_configs) then
      UNI.async_call(ADS_VENDER_NAME, ADS_INIT, {}, nil, init_callback)
    else
      UNI.async_call(ADS_VENDER_NAME, ADS_INIT, {ad_configs = ad_configs}, nil, init_callback)
    end
  end
end

local create_wx_custom_ad = {}
local create_wx_video_ad = {}
if E.Sysinfo.os() == "weixin" then
  create_wx_custom_ad = _ejoysdk.wx.createCustomAd
  create_wx_video_ad = _ejoysdk.wx.createRewardedVideoAd
end
local wasm_ad_info_map = {}

local function get_wasm_ad_info_by_id(ad_id)
  local wasm_ad_info = wasm_ad_info_map[ad_id]
  if not wasm_ad_info then
    error("invalid ad_id, can not find wasm ad info")
  end
  return wasm_ad_info
end

local function remove_wasm_ad_info_by_id(ad_id)
  local wasm_ad_info = wasm_ad_info_map[ad_id]
  if wasm_ad_info and wasm_ad_info_map[ad_id] then
    wasm_ad_info_map[ad_id] = nil
  end
end

local function final_handle_wasm_ad_info(ad_id)
  local wasm_ad_info = wasm_ad_info_map[ad_id]
  if not wasm_ad_info then
    return
  end
  local ad_instance = wasm_ad_info.instance
  if ad_instance then
    ad_instance.offClose()
    ad_instance.destroy()
  end
  remove_wasm_ad_info_by_id(ad_id)
end

function M.init(opt, cb2)
  E.LOG.debug(TAG, "ejoyads: init vendor")
  do
    local os_config = E.CONFIG.get_config("os")
    if "android" == os_config then
      local is_support_init = M.is_support_init()
      if is_support_init then
        M.initAd()
      end
      
      function VENDOR_ADS.loadAd(params, cb)
        UNI.async_call(ADS_VENDER_NAME, ADS_LOAD, params, nil, cb)
      end
      
      function VENDOR_ADS.getAdStatus(params)
        do return UNI.sync_call, ADS_VENDER_NAME, ADS_STATUS, params end
        return UNI.sync_call, ADS_VENDER_NAME, ADS_STATUS, params, nil
      end
      
      function VENDOR_ADS.showAd(params, cb)
        UNI.async_call(ADS_VENDER_NAME, ADS_SHOW, params, nil, cb)
      end
      
      function VENDOR_ADS.closeAd(params, cb)
        UNI.async_call(ADS_VENDER_NAME, ADS_CLOSE, params, nil, cb)
      end
      
      function VENDOR_ADS.support_ad_types()
        do return UNI.sync_call, ADS_VENDER_NAME, ADS_SUPPORT_AD_TYPES, {} end
        return UNI.sync_call, ADS_VENDER_NAME, ADS_SUPPORT_AD_TYPES, {}, nil
      end
    elseif "ios" == os_config then
      function VENDOR_ADS.loadAd(params, cb)
        UNI.async_call(ADS_VENDER_NAME, ADS_LOAD, params, nil, cb)
      end
      
      function VENDOR_ADS.getAdStatus(params)
        do return UNI.sync_call, ADS_VENDER_NAME, ADS_STATUS, params end
        return UNI.sync_call, ADS_VENDER_NAME, ADS_STATUS, params, nil
      end
      
      function VENDOR_ADS.showAd(params, cb)
        UNI.async_call(ADS_VENDER_NAME, ADS_SHOW, params, nil, cb)
      end
      
      function VENDOR_ADS.closeAd(params, cb)
        UNI.async_call(ADS_VENDER_NAME, ADS_CLOSE, params, nil, cb)
      end
      
      function VENDOR_ADS.support_ad_types()
        do return UNI.sync_call, ADS_VENDER_NAME, ADS_SUPPORT_AD_TYPES, {} end
        return UNI.sync_call, ADS_VENDER_NAME, ADS_SUPPORT_AD_TYPES, {}, nil
      end
    elseif "weixin" == os_config then
      function VENDOR_ADS.loadAd(params, cb)
        local ad_id = params.id
        
        local ad_type = params.ad_type or params.type
        local pos_id = params.service_extra.pos_id
        local service = params.service
        if "wechat_game" ~= service then
          E.LOG.debug("ejoyads: weixin ad service is not wechat_game, ad ignore")
          cb(false, M.status.AD_LOAD_FAIL, {
            err_code = M.status.AD_LOAD_FAIL,
            err_msg = "weixin ad service is not wechat_game"
          })
          return
        end
        if not wasm_ad_info_map[ad_id] then
          wasm_ad_info_map[ad_id] = {
            params = params,
            type = ad_type,
            status = M.status.AD_STATUS_NOT_LOAD,
            instance = nil,
            use_fallback_share_page = false
          }
        end
        local ad_status_info = VENDOR_ADS.getAdStatus(params)
        local ad_status = ad_status_info.code
        if ad_status ~= M.status.AD_STATUS_NOT_LOAD then
          if ad_status == M.status.AD_STATUS_LOADING then
            cb(true, {
              status = M.status.AD_LOAD_LOADING
            })
          elseif ad_status == M.status.AD_STATUS_READY then
            cb(true, {
              status = M.status.AD_LOAD_SUCC,
              use_fallback_share_page = wasm_ad_info_map[ad_id].use_fallback_share_page
            })
          else
            cb(false, M.status.AD_LOAD_FAIL, {
              err_code = M.status.AD_LOAD_FAIL,
              err_msg = "ad status is invalid"
            })
          end
          return
        end
        if "banner" == ad_type then
          wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_READY
          cb(true, {
            status = M.status.AD_LOAD_SUCC
          })
        else
          local wx_video_ad = create_wx_video_ad({adUnitId = pos_id, multiton = true})
          wasm_ad_info_map[ad_id].instance = wx_video_ad
          wx_video_ad.onLoad(function(res)
            if res and res.useFallbackSharePage then
              E.LOG.debug(TAG, "ejoyads: onLoad useFallbackSharePage")
              wasm_ad_info_map[ad_id].use_fallback_share_page = true
            end
          end)
          wx_video_ad.onError(function(err)
            E.LOG.debug(TAG, "ejoyads: video on error, err=" .. tostring(err.errMsg))
          end)
          wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_LOADING
          wx_video_ad.load():next(function()
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_READY
            cb(true, {
              status = M.status.AD_LOAD_SUCC,
              data = {
                use_fallback_share_page = wasm_ad_info_map[ad_id].use_fallback_share_page
              }
            })
          end):catch(function(err)
            E.LOG.debug(TAG, "ejoyads: video load error, err=" .. tostring(err.errMsg))
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_ERR
            cb(false, M.status.AD_LOAD_FAIL, {
              err_code = M.status.AD_LOAD_FAIL,
              err_msg = err.errMsg .. "(" .. tostring(err.errCode) .. ")"
            })
            final_handle_wasm_ad_info(ad_id)
          end)
        end
      end
      
      function VENDOR_ADS.getAdStatus(params)
        local ad_id = params.id
        local is_call_ok, wasm_ad_info = pcall(get_wasm_ad_info_by_id, ad_id)
        local status = is_call_ok and wasm_ad_info.status or M.status.AD_STATUS_NOT_LOAD
        local ad_status_message_map = {
          [M.status.AD_STATUS_ERR] = "广告错误",
          [M.status.AD_STATUS_NOT_EXISTS] = "广告不存在",
          [M.status.AD_STATUS_NOT_LOAD] = "广告未加载",
          [M.status.AD_STATUS_LOADING] = "广告正在加载",
          [M.status.AD_STATUS_READY] = "广告已就绪",
          [M.status.AD_STATUS_SHOWING] = "广告正在显示",
          [M.status.AD_STATUS_FINISHED] = "此广告位广告已结束"
        }
        return {
          code = status,
          message = ad_status_message_map[status] or "未知广告错误"
        }
      end
      
      function VENDOR_ADS.showAd(params, cb)
        local ad_status_info = VENDOR_ADS.getAdStatus(params)
        local ad_status = ad_status_info.code
        if ad_status ~= M.status.AD_STATUS_READY then
          cb(false, M.status.AD_SHOW_ERR, {
            err_code = M.status.AD_SHOW_ERR,
            err_msg = "ad show error，need load first"
          })
          return
        end
        local ad_id = params.id
        local wasm_ad_info = get_wasm_ad_info_by_id(ad_id)
        local ad_type = wasm_ad_info.type
        local ad_instance = wasm_ad_info.instance
        local ad_unit_id = wasm_ad_info.params.service_extra.pos_id
        if "banner" == ad_type then
          if not params.style then
            error("weixin show banner error, param 'style' filed is required")
          end
          local wx_custom_ad = create_wx_custom_ad({
            adUnitId = ad_unit_id,
            style = params.style
          })
          wasm_ad_info_map[ad_id].instance = wx_custom_ad
          ad_instance = wx_custom_ad
          ad_instance.onError(function(err)
            E.LOG.debug(TAG, "ejoyads: banner on error, err=" .. tostring(err.errMsg))
          end)
          
          local function close_listener(res)
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_FINISHED
            QL.commit_event(EVENT_IMPRESSION_END, {ad_unit_id = ad_unit_id}, true)
            cb(true, {
              status = M.status.AD_SHOW_CLOSE,
              data = {}
            })
            final_handle_wasm_ad_info(ad_id)
          end
          
          ad_instance.onClose(close_listener)
          ad_instance.show():next(function()
            QL.commit_event(EVENT_IMPRESSION_START, {ad_unit_id = ad_unit_id}, true)
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_SHOWING
          end):catch(function(err)
            E.LOG.debug(TAG, "ejoyads: banner show error, err=" .. tostring(err.errMsg))
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_ERR
            cb(false, M.status.AD_SHOW_FAIL, {
              err_code = M.status.AD_SHOW_FAIL,
              err_msg = err.errMsg .. "(" .. tostring(err.errCode) .. ")"
            })
            final_handle_wasm_ad_info(ad_id)
          end)
        else
          local order_id = wasm_ad_info.params.order_id
          local service = wasm_ad_info.params.service
          local video_start_time = E.system_ms()
          
          local function close_listener(res)
            local is_ended = res and res.isEnded
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_FINISHED
            local video_end_time = E.system_ms()
            QL.commit_event(EVENT_IMPRESSION_END, {
              ad_unit_id = ad_unit_id,
              ad_is_success = is_ended,
              ad_duration = video_end_time - video_start_time
            }, true)
            cb(true, {
              status = is_ended and M.status.AD_SHOW_COMPLETED or M.status.AD_SHOW_CLOSE,
              data = {
                use_fallback_share_page = wasm_ad_info_map[ad_id].use_fallback_share_page,
                is_ended = is_ended,
                order_id = order_id,
                service = service
              }
            })
            final_handle_wasm_ad_info(ad_id)
          end
          
          ad_instance.onClose(close_listener)
          ad_instance.show():next(function()
            QL.commit_event(EVENT_IMPRESSION_START, {ad_unit_id = ad_unit_id}, true)
            video_start_time = E.system_ms()
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_SHOWING
          end):catch(function(err)
            E.LOG.debug(TAG, "ejoyads: video show error, err=" .. tostring(err.errMsg))
            wasm_ad_info_map[ad_id].status = M.status.AD_STATUS_ERR
            cb(false, M.status.AD_SHOW_FAIL, {
              err_code = M.status.AD_SHOW_FAIL,
              err_msg = err.errMsg .. "(" .. tostring(err.errCode) .. ")"
            })
            final_handle_wasm_ad_info(ad_id)
          end)
        end
      end
      
      function VENDOR_ADS.closeAd(params, cb)
        local ad_status_info = VENDOR_ADS.getAdStatus(params)
        local ad_status = ad_status_info.code
        if ad_status ~= M.status.AD_STATUS_SHOWING then
          cb(false, M.status.AD_CLOSE_FAIL, {
            err_code = M.status.AD_CLOSE_FAIL,
            err_msg = "ad close error，need show first"
          })
          return
        end
        local ad_id = params.id
        local wasm_ad_info = get_wasm_ad_info_by_id(ad_id)
        local ad_type = wasm_ad_info.type
        local ad_unit_id = wasm_ad_info.params.service_extra.pos_id
        if "banner" == ad_type then
          QL.commit_event(EVENT_IMPRESSION_END, {ad_unit_id = ad_unit_id}, true)
          cb(true, {
            status = M.status.AD_SHOW_CLOSE,
            data = {}
          })
          final_handle_wasm_ad_info(ad_id)
        else
          cb(false, -1, {
            err_code = M.status.AD_CLOSE_FAIL,
            err_msg = "不支持的广告类型, close操作只支持banner广告"
          })
        end
      end
      
      function VENDOR_ADS.support_ad_types()
        return {banner = 1, video = 1}
      end
    end
    M.fill_support_ad_types()
    ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_online_handler)
    ET.subscribe(ET.gangplank.PLAYER_OFFLINE, function()
      UNI.logout(ADS_VENDER_NAME)
    end)
    ET.subscribe(ET.gangplank.LOGOUT, function()
      UNI.logout(ADS_VENDER_NAME)
    end)
    cb2(true)
  end
end

function M.is_support_init()
  local result = UNI.sync_call(ADS_VENDER_NAME, IS_SUPPORT_INIT_AD_SDK, {})
  if nil == result then
    return false
  else
    return result.value
  end
end

function M.query_list(cb)
  local url = base_url() .. "list_ad"
  local params = {
    pkg_info = E.get_pkg_info()
  }
  E.HTTP.post(url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    local status = resp.status
    local body = resp.body
    if 200 == status then
      cb(true, body.data)
      E.LOG.debug(TAG, "ejoyads:request ad list succ")
    else
      cb(false, {})
      E.LOG.debug(TAG, "ejoyads:request ad list fail")
    end
  end)
  E.LOG.debug(TAG, "ejoyads:start to query ad list")
end

local function createOrder(ad_id, callback)
  local url = base_url() .. "create_order"
  local params = {
    id = ad_id,
    pkg_info = E.get_pkg_info()
  }
  E.LOG.debug(TAG, "ejoyads: create order for " .. tostring(ad_id))
  E.HTTP.post(url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    local status = resp.status
    local body = resp.body or {}
    if 200 == status then
      local code = body.code or -1
      if 200 == code or 0 == code then
        E.LOG.debug(TAG, "ejoyads:create order succ")
        callback(code, body.data)
      else
        E.LOG.warn(TAG, "ejoyads:create order fail, code=" .. tostring(code) .. ", msg=" .. (body.message or ""))
        callback(code, {})
      end
    end
  end)
end

local function getAdService(ad_id, callback)
  local url = base_url() .. "get_ad_service_by_id"
  local params = {
    id = ad_id,
    pkg_info = E.get_pkg_info()
  }
  E.LOG.debug(TAG, "ejoyads: getAdService for " .. tostring(ad_id))
  E.HTTP.post(url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    local status = resp.status
    local body = resp.body or {}
    if 200 == status then
      local code = body.code or -1
      if 200 == code or 0 == code then
        E.LOG.debug(TAG, "ejoyads:get ad service succ")
        E.LOG.debug(TAG, body)
        callback(code, body.data)
      else
        E.LOG.warn(TAG, "ejoyads:get ad service fail, code=" .. tostring(code) .. ", msg=" .. (body.message or ""))
        callback(code, {})
      end
    end
  end)
end

local function notifyFinish(origin_body, retry_count, callback)
  local url = base_url() .. "finish_order"
  local data = origin_body.data
  local stat_params = {
    order_id = data.order_id or "",
    service = data.service or "",
    retry = retry_count
  }
  QL.commit_event(EVENT_NOTIFY, stat_params)
  if data.order_id and data.service then
    E.LOG.debug(TAG, "ejoyads: notify check succ")
    local params = {
      order_id = data.order_id
    }
    E.LOG.debug(TAG, "ejoyads: notify ad finish about " .. tostring(data.order_id))
    E.HTTP.post(url, request_params(), E.HTTP.CT_JSON, params, function(resp)
      local status = resp.status
      local body = resp.body
      local code = -1
      if 200 == status then
        code = body.code
        if 200 == code or 0 == code then
          E.LOG.debug(TAG, "ejoyads:notify finish succ")
          QL.commit_event(EVENT_NOTIFY_SUCC, stat_params)
          callback(true, origin_body)
          return
        end
      end
      E.LOG.debug(TAG, "ejoyads: notify finish fail, retry " .. tostring(retry_count) .. " ,code=" .. tostring(code) .. ",msg=" .. (body.message or ""))
      if retry_count < MAX_NOFITY_RETRY then
        notifyFinish(origin_body, retry_count + 1, callback)
      else
        QL.commit_event(EVENT_NOTIFY_FAIL, stat_params)
        callback(false, {
          err_code = M.status.AD_SHOW_ERR,
          err_msg = "通知服务器失败"
        })
      end
    end)
  else
    callback(true, origin_body)
  end
end

function M.load_ad(oParams, cb)
  local token = EH.get_player_token()
  cb = cb or function(...)
  end
  if nil == token or "" == token then
    E.LOG.debug(TAG, "ejoyads:no player token, skip showing ad")
    local body = {
      err_code = M.status.AD_ERR_NO_TOKEN,
      err_msg = "没有用户角色token"
    }
    cb(false, M.status.AD_ERR_NO_TOKEN, body, nil)
    return
  end
  oParams = oParams or {}
  local ad_id = oParams.id
  local ad_type = oParams.type or "video"
  local params = {adId = ad_id, adType = ad_type}
  if "video" ~= ad_type and not support_ad_types[ad_type] then
    local body = {
      err_code = M.status.AD_ERR_C_UNSUPPORT_TYPE,
      err_msg = "do not support this ad type"
    }
    cb(false, M.status.AD_ERR_C_UNSUPPORT_TYPE, body, nil)
    return
  end
  QL.commit_event(EVENT_CREATE_ORDER, params)
  if "video" == ad_type then
    createOrder(ad_id, function(status, ad_detail)
      if 200 == status or 0 == status then
        if nil ~= ad_detail then
          QL.commit_event(EVENT_CREATE_ORDER_SUCC, params)
          QL.commit_event(EVENT_LOAD, params)
          E.LOG.debug(TAG, "ejoyads: start load ad")
          ad_detail.ad_type = ad_detail.type
          if E.Sysinfo.os() ~= "weixin" and ad_detail.service == "wechat_game" then
            if load_succ_result[tostring(ad_id)] then
              load_succ_result[tostring(ad_id)] = nil
            end
            local body = {
              err_code = M.status.AD_ERR_C_ORDER_FAIL,
              err_msg = "do not support ad from wechat_game"
            }
            cb(false, M.status.AD_ERR_C_ORDER_FAIL, body, nil)
            QL.commit_event(EVENT_LOAD_FAIL, params)
            return
          end
          VENDOR_ADS.loadAd(ad_detail, function(succ, ...)
            if succ then
              local body = (...)
              local s = body.status
              params.code = s
              if s == M.status.AD_LOAD_SUCC then
                load_succ_result[tostring(ad_id)] = {
                  ad_type = ad_detail.ad_type
                }
                QL.commit_event(EVENT_LOAD_SUCC, params)
              end
            else
              if load_succ_result[tostring(ad_id)] then
                load_succ_result[tostring(ad_id)] = nil
              end
              local _, body = ...
              local err_code = body.err_code
              params.code = err_code
              if body.err_msg then
                params.message = body.err_msg
              end
              QL.commit_event(EVENT_LOAD_FAIL, params)
            end
            cb(succ, ...)
          end)
        else
          E.LOG.debug(TAG, "ejoyads: 获取广告信息失败")
          if load_succ_result[tostring(ad_id)] then
            load_succ_result[tostring(ad_id)] = nil
          end
          local body = {
            err_code = M.status.AD_ERR_C_ORDER_FAIL,
            err_msg = "ad detail is null"
          }
          QL.commit_event(EVENT_CREATE_ORDER_FAIL, params)
          cb(false, M.status.AD_ERR_C_ORDER_FAIL, body, nil)
        end
      else
        if load_succ_result[tostring(ad_id)] then
          load_succ_result[tostring(ad_id)] = nil
        end
        local body = {
          err_code = M.status.AD_ERR_C_ORDER_FAIL,
          err_msg = "创建订单失败"
        }
        QL.commit_event(EVENT_CREATE_ORDER_FAIL, params)
        cb(false, M.status.AD_ERR_C_ORDER_FAIL, body, nil)
      end
    end)
  elseif "banner" == ad_type then
    getAdService(ad_id, function(status, ad_service)
      E.LOG.d(TAG, "banner callback >>")
      E.LOG.d(TAG, status)
      E.LOG.d(TAG, ad_service)
      if 200 == status or 0 == status then
        if nil ~= ad_service then
          QL.commit_event(EVENT_GET_SERVICE_SUCC, params)
          QL.commit_event(EVENT_LOAD, params)
          E.LOG.debug(TAG, "ejoyads: start load ad")
          ad_service.ad_type = ad_service.type
          if E.Sysinfo.os() ~= "weixin" and ad_service.service == "wechat_game" then
            if load_succ_result[tostring(ad_id)] then
              load_succ_result[tostring(ad_id)] = nil
            end
            local body = {
              err_code = M.status.AD_ERR_C_ORDER_FAIL,
              err_msg = "do not support ad from wechat_game"
            }
            cb(false, M.status.AD_ERR_C_ORDER_FAIL, body, nil)
            QL.commit_event(EVENT_LOAD_FAIL, params)
            return
          end
          VENDOR_ADS.loadAd(ad_service, function(succ, ...)
            if succ then
              local body = (...)
              local s = body.status
              params.code = s
              if s == M.status.AD_LOAD_SUCC then
                load_succ_result[tostring(ad_id)] = {
                  ad_type = ad_service.ad_type
                }
                QL.commit_event(EVENT_LOAD_SUCC, params)
              end
            else
              if load_succ_result[tostring(ad_id)] then
                load_succ_result[tostring(ad_id)] = nil
              end
              local _, body = ...
              local err_code = body.err_code
              params.code = err_code
              if body.err_msg then
                params.message = body.err_msg
              end
              QL.commit_event(EVENT_LOAD_FAIL, params)
            end
            cb(succ, ...)
          end)
        else
          E.LOG.debug(TAG, "ejoyads: 获取广告服务商信息失败")
          if load_succ_result[tostring(ad_id)] then
            load_succ_result[tostring(ad_id)] = nil
          end
          local body = {
            err_code = M.status.AD_ERR_C_ORDER_FAIL,
            err_msg = "ad service is null"
          }
          QL.commit_event(EVENT_GET_SERVICE_FAIL, params)
          cb(false, M.status.AD_ERR_C_AD_SERVICE_FAIL, body, nil)
        end
      else
        if load_succ_result[tostring(ad_id)] then
          load_succ_result[tostring(ad_id)] = nil
        end
        local body = {
          err_code = M.status.AD_ERR_C_AD_SERVICE_FAIL,
          err_msg = "get ad service fail"
        }
        QL.commit_event(EVENT_GET_SERVICE_FAIL, params)
        cb(false, M.status.AD_ERR_C_AD_SERVICE_FAIL, body, nil)
      end
    end)
  else
    if load_succ_result[tostring(ad_id)] then
      load_succ_result[tostring(ad_id)] = nil
    end
    local body = {
      err_code = M.status.AD_ERR_C_UNSUPPORT_TYPE,
      err_msg = "不支持的广告类型"
    }
    cb(false, M.status.AD_ERR_C_UNSUPPORT_TYPE, body, nil)
    QL.commit_event(EVENT_LOAD_FAIL, params)
  end
end

function M.show_ad(params, cb)
  QL.commit_event(EVENT_SHOW, params)
  params = params or {}
  params.cutout = E.Sysinfo.cutout()
  VENDOR_ADS.showAd(params, function(succ, ...)
    if succ then
      local ad_type = "video"
      if load_succ_result[params.id] then
        local load_succ_item = load_succ_result[params.id]
        ad_type = load_succ_item.ad_type
      end
      local body = (...)
      if "banner" == ad_type then
        if body.status == M.status.AD_SHOW_START then
          E.LOG.debug(TAG, "ejoyads: show banner")
          QL.commit_event(EVENT_SHOW_START, params, true)
        end
      elseif "video" == ad_type then
        if body.status == M.status.AD_SHOW_COMPLETED then
          E.LOG.debug(TAG, "ejoyads: show ad completedm, notify finish")
          QL.commit_event(EVENT_SHOW_SUCC, params, true)
          notifyFinish(body, 1, cb)
          return
        elseif body.status == M.status.AD_SHOW_START then
          E.LOG.debug(TAG, "ejoyads: show video")
          QL.commit_event(EVENT_SHOW_START, params, true)
        end
      else
        E.LOG.w(TAG, "不识别的ad_type")
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "ad load fail, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      QL.commit_event(EVENT_SHOW_FAIL, params)
    end
    cb(succ, ...)
  end)
end

function M.get_status(oParams)
  local status_info = VENDOR_ADS.getAdStatus(oParams)
  status_info = status_info or {}
  return status_info
end

function M.close_ad(params, cb)
  QL.commit_event(EVENT_CLOSE, params)
  params = params or {}
  params.type = params.type or "video"
  if params.type ~= "banner" then
    QL.commit_event(EVENT_CLOSE_FAIL, params)
    cb(false, -1, {
      err_code = M.status.AD_CLOSE_FAIL,
      err_msg = "不支持的广告类型，close操作只支持banner广告"
    })
    return
  end
  VENDOR_ADS.closeAd(params, function(succ, ...)
    if succ then
      local body = (...)
      if body.status == M.status.AD_SHOW_CLOSE then
        E.LOG.debug(TAG, "ejoyads: ad close succ")
        QL.commit_event(EVENT_CLOSE_SUCC, params)
      end
    else
      QL.commit_event(EVENT_CLOSE_FAIL, params)
    end
    cb(succ, ...)
  end)
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local M = {}
local TAG = "dspay_protocol"

local function get_dsp_api()
  local api = DSP.SERVICE.CREATE_ORDER
  if _ejoysdk.os() == "weixin" then
    local sys = E.Sysinfo.get_device_system()
    if "android" ~= sys and "harmonyos" ~= sys and "windows" ~= sys then
      api = DSP.SERVICE.WEB_CREATE_ORDER
    end
  end
  return api
end

function M.create_order(pay_params, channel_ext, cb)
  local params = {}
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  params[DSP.PAY_PARAMS_KEY.STRING_DS_TOKEN] = GDP.USER_INFO.get("ptoken")
  E.LOG.debug(TAG, "create order, current ds token >> " .. tostring(GDP.USER_INFO.get("ptoken")))
  params[DSP.PAY_PARAMS_KEY.STRING_CP_ORDERID] = pay_params.cpOrderId
  params[DSP.PAY_PARAMS_KEY.INT_PAY_AMOUNT] = pay_params.amount
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_PRODUCT_ID] = pay_params.payProductID
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_PRODUCT_NAME] = pay_params.payProductName
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_PRODUCT_DESCRIBE] = pay_params.payProductDescribe
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_PRODUCT_TYPE] = pay_params.payProductType or 1
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_CALLBACK_URL] = pay_params.payCallbackURL
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_CALLBACK_PARAMS] = pay_params.payCallbackParams
  local channelSDKVersion = E.get_cn_channel_version()
  if 0 == string.len(channelSDKVersion) then
    channelSDKVersion = "1.0"
  end
  params.channelSDKVe = channelSDKVersion
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_CLIENT_ORDER_EX] = channel_ext
  local thirdPartyType = GDP.USER_INFO.get("thirdPartyType") or nil
  E.LOG.debug(TAG, "thirdPartyType = " .. tostring(thirdPartyType))
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_THIRDPARTYTYPE] = thirdPartyType
  local productInfo = {}
  productInfo.productId = pay_params.payProductID
  productInfo.productName = pay_params.payProductName
  productInfo.productDetail = pay_params.payProductDescribe
  productInfo.productType = pay_params.payProductType or 1
  params.productInfo = productInfo
  local player_info = GDP.PLAYER_INFO.clone()
  player_info.player_token = nil
  params.player_info = player_info
  params.roleInfo = {
    roleId = player_info.player_id,
    roleName = player_info.player_name,
    serverId = player_info.server_id,
    serverName = player_info.server_name
  }
  if _ejoysdk.os() == "weixin" then
    local sys = E.Sysinfo.get_device_system()
    local pkg_info = E.get_pkg_info()
    if "android" ~= sys and "harmonyos" ~= sys and "windows" ~= sys then
      params[DSP.PAY_PARAMS_KEY.WEB_PAY_GAME_ID] = pkg_info.game_id
      params[DSP.PAY_PARAMS_KEY.WEB_PAY_DS_TOKEN] = GDP.USER_INFO.get("ptoken")
      params[DSP.PAY_PARAMS_KEY.WEB_PAY_CHANNEL_ID] = pkg_info.channel_id
      params[DSP.PAY_PARAMS_KEY.WEB_PAY_PLAYER_INFO] = {
        playerId = player_info.player_id,
        serverId = player_info.server_id,
        playerName = player_info.player_name
      }
      params[DSP.PAY_PARAMS_KEY.WEB_PAY_PRODUCT_EXT] = pay_params.payProductExt
      params[DSP.PAY_PARAMS_KEY.WEB_PAY_PKG_INFO] = pkg_info
      params[DSP.PAY_PARAMS_KEY.WEB_PAY_AIRLINE_TYPE] = pkg_info.airline or "lingxi"
    else
      channel_ext.notifyUrl = "1"
      channel_ext.mode = "directBuy"
    end
  end
  params[DSP.PAY_PARAMS_KEY.STRING_PAY_CLIENT_ORDER_EX] = channel_ext
  DSP.post(get_dsp_api(), params, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "ds create order success >> ")
      local dsOrder = (...)
      E.log(dsOrder)
      if dsOrder and dsOrder.ex then
        local exStr = dsOrder.ex
        local exJson = JSON.safe_decode(exStr)
        if exJson then
          dsOrder.ex = exJson
        end
      end
      dsOrder.pay_params = params
      if cb then
        cb(true, dsOrder)
      end
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request pay.order.create failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local ali_datapkg = require("ejoysdk_lua.vendors.ali_datapkg")
local UI = require("ejoysdk_lua.free_flow.free_flow_ui")
local FSTAT = require("ejoysdk_lua.free_flow.free_flow_stat")
local ACTION = FSTAT.FREE_FLOW_ACTION
local TAG = "free_flow#ejoysdk_free_flow"
local M = {}
local mobile_auth_secret
local ali_free_flow_config = {productId = nil, xgipAppId = nil}
local has_retry_receive = false
M.EJOY_OPERATOR = {
  CTCC = "CTCC",
  CUCC = "CUCC",
  CMCC = "CMCC"
}
M.FREE_CHANNEL = {CHANNEL_ALI = "ali"}

local function exchange_operator_to_ali(operator)
  if operator == M.EJOY_OPERATOR.CTCC then
    return ali_datapkg.OPERATOR.CT
  elseif operator == M.EJOY_OPERATOR.CUCC then
    return ali_datapkg.OPERATOR.CU
  elseif operator == M.EJOY_OPERATOR.CMCC then
    return ali_datapkg.OPERATOR.CM
  end
end

local function _exchange_operator_to_ejoy(operator)
  if operator == ali_datapkg.OPERATOR.CT then
    return M.EJOY_OPERATOR.CTCC
  elseif operator == ali_datapkg.OPERATOR.CU then
    return M.EJOY_OPERATOR.CUCC
  elseif operator == ali_datapkg.OPERATOR.CM then
    return M.EJOY_OPERATOR.CMCC
  end
end

function M.init(channel, cb)
  if not channel or not cb then
    E.LOG.e(TAG, "init params wrong, channel or cb is nil")
  end
  if channel == M.FREE_CHANNEL.CHANNEL_ALI then
    if not mobile_auth_secret then
      cb(false, "mobile auth secret config not init")
      return
    end
    if not ali_free_flow_config.productId or not ali_free_flow_config.xgipAppId then
      cb(false, "ali free flow config not init")
      return
    end
    local opt = {}
    opt[ali_datapkg.CONFIG_KEY.AUTH_SECRET] = mobile_auth_secret
    opt[ali_datapkg.CONFIG_KEY.PRODUCT_ID] = ali_free_flow_config.productId
    opt[ali_datapkg.CONFIG_KEY.XGIP_APPID] = ali_free_flow_config.xgipAppId
    FSTAT.stat_action(ACTION.FREE_FLOW_INIT, nil, opt)
    ali_datapkg.init(opt, function(succ, ...)
      if succ then
        cb(true)
      else
        cb(false, "ali datapkg init fail")
      end
    end)
  end
end

function M.set_mobile_auth_secret(secret)
  E.LOG.debug(TAG, "set mobile auth secret >> " .. tostring(secret))
  if secret then
    mobile_auth_secret = secret
  end
end

function M.set_ali_free_flow_config(productId, xgipAppId, dataPkgName)
  E.LOG.debug(TAG, "set_ali_free_flow_config productId >> " .. tostring(productId) .. ". xgipAppId >> " .. tostring(xgipAppId))
  if productId and xgipAppId then
    ali_free_flow_config.productId = productId
    ali_free_flow_config.xgipAppId = xgipAppId
  end
  UI.update_data_pkg_name(dataPkgName)
end

function M.current_operator()
  local ali_operator = ali_datapkg.get_current_carrier_name()
  return ali_operator
end

function M.is_eligible(mask)
  do return ali_datapkg.is_eligible end
  return ali_datapkg.is_eligible, mask
end

function M.current_mask_number(cb)
  if not cb then
    E.LOG.e(TAG, "get current mask number, cb is nil, return ")
    return
  end
  ali_datapkg.get_mobile_mask_number(function(succ, ...)
    if succ then
      local mask = (...)
      local params = {mask = mask}
      FSTAT.stat_action(ACTION.FREE_FLOW_GET_MASK_RESULT, true, params)
      cb(mask)
    else
      local code, message = ...
      local params = {code = code, msg = message}
      FSTAT.stat_action(ACTION.FREE_FLOW_GET_MASK_RESULT, false, params)
      cb()
    end
  end)
end

function M.is_free_for_mask(ejoy_operator, mask, cb)
  local ali_operator = exchange_operator_to_ali(ejoy_operator)
  ali_datapkg.stop_request_result_loop()
  ali_datapkg.is_current_mask_free(ali_operator, mask, function(succ, ...)
    if succ and cb then
      local status = (...)
      if status == ali_datapkg.FREE_STATUE.IN_FREE then
        cb(true)
      else
        cb(false)
      end
    end
  end)
end

function M.receive_free_data_pkg(mask, cb)
  local protocol = ali_datapkg.get_protocol(mask)
  
  local function inner_cb(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end
  
  if protocol then
    local protocol_name = protocol[ali_datapkg.PROTOCOL_KEY.PROTOCOL_NAME]
    local protocol_url = protocol[ali_datapkg.PROTOCOL_KEY.PROTOCOL_URL]
    local receive_progress, ensure_cb, retry_cb, fail_cb
    
    function receive_progress()
      FSTAT.stat_action(ACTION.FREE_FLOW_SHOW_AUTH)
      UI.show_user_auth(mask, protocol_name, protocol_url, function(agree)
        FSTAT.stat_action(ACTION.FREE_FLOW_SHOW_AUTH_RESULT, agree)
        if agree then
          ali_datapkg.get_auth_token(function(succ, ...)
            if succ then
              local auth_token = (...)
              local params = {token = auth_token}
              FSTAT.stat_action(ACTION.FREE_FLOW_GET_TOKEN_RESULT, true, params)
              ali_datapkg.request_free_data_pack(ali_datapkg.OPERATOR.CT, mask, auth_token, function(succ_1, ...)
                if succ_1 then
                  local order_id = (...)
                  local order_params = {order_id = order_id}
                  FSTAT.stat_action(ACTION.FREE_FLOW_RECEIVE_REQUEST_RESULT, true, order_params)
                  ali_datapkg.start_request_result_loop(mask, order_id, function(succ_2, ...)
                    FSTAT.stat_action(ACTION.FREE_FLOW_RECEIVE_RESULT, succ_2)
                    UI.hide_receive_loading()
                    if succ_2 then
                      UI.show_receive_success(ensure_cb)
                    else
                      UI.show_receive_fail(retry_cb, fail_cb)
                    end
                  end)
                  ali_datapkg.set_loop_interval(ali_datapkg.GET_RESULT_LOOP_INTERVAL.INTERVAL_FOREGROUND)
                  FSTAT.stat_action(ACTION.FREE_FLOW_RECEIVE_SHOW_LOADING)
                  UI.show_receive_loading(function()
                    E.LOG.debug(TAG, "close the receive loading dialog >> ")
                    local interval_params = {
                      interval = ali_datapkg.GET_RESULT_LOOP_INTERVAL.INTERVAL_BACKGROUND
                    }
                    FSTAT.stat_action(ACTION.FREE_FLOW_RECEIVE_LOADING_INTERVAL, nil, interval_params)
                    ali_datapkg.set_loop_interval(ali_datapkg.GET_RESULT_LOOP_INTERVAL.INTERVAL_BACKGROUND)
                  end)
                else
                  local code, message = ...
                  local result_params = {code = code, msg = message}
                  FSTAT.stat_action(ACTION.FREE_FLOW_RECEIVE_REQUEST_RESULT, false, result_params)
                  E.LOG.debug(TAG, "receive data pkg fail, code >> " .. tostring(code) .. ", and message >> " .. tostring(message))
                  if code == ali_datapkg.RECEIVE_ERROR_CODE.CUR_ACCOUNT_ALREADY_RECEIVE then
                    E.LOG.debug(TAG, "show already ")
                    UI.show_already_receive_fail(fail_cb)
                  elseif code == ali_datapkg.RECEIVE_ERROR_CODE.CUR_PHONE_ALREADY_RECEIVE then
                    ali_datapkg.is_current_mask_free(ali_datapkg.OPERATOR.CT, mask, function(succ_3, ...)
                      if succ_3 then
                        ensure_cb()
                      else
                        fail_cb()
                      end
                    end)
                  elseif code == ali_datapkg.RECEIVE_ERROR_CODE.MASK_TOKEN_NOT_MATCH then
                    E.LOG.debug(TAG, "receive data pkg fail, and err_code is 5001014")
                    UI.show_receive_fail(function()
                      E.LOG.debug(TAG, "user click back btn, and retry state >> " .. tostring(has_retry_receive))
                      if not has_retry_receive then
                        has_retry_receive = true
                        inner_cb(false, code)
                      else
                        inner_cb(false)
                      end
                    end, fail_cb, true)
                  else
                    UI.show_receive_fail(retry_cb, fail_cb)
                  end
                end
              end)
            else
              FSTAT.stat_action(ACTION.FREE_FLOW_GET_TOKEN_RESULT, false)
              UI.show_receive_fail(retry_cb, fail_cb)
            end
          end)
        else
          inner_cb(false, "user did not agree protocol")
        end
      end)
    end
    
    function ensure_cb()
      inner_cb(true)
    end
    
    function fail_cb()
      inner_cb(false)
    end
    
    function retry_cb()
      if not has_retry_receive then
        has_retry_receive = true
        receive_progress()
      else
        inner_cb(false)
      end
    end
    
    receive_progress()
  else
    E.LOG.debug(TAG, "receive free data pkg fail, protocol is nil")
    inner_cb(false, "protocol info is nil")
  end
end

function M.check_ordering_order(mask, cb)
  E.LOG.debug(TAG, "check ordering order >> mask >> " .. tostring(mask))
  local order = ali_datapkg.get_ordering_order(mask)
  if order then
    local params = {
      order_id = order.orderId
    }
    FSTAT.stat_action(ACTION.FREE_FLOW_HAS_ORDERING_ORDER, true, params)
    E.LOG.debug(TAG, "ordering order is not nil, order_id >> " .. tostring(order.orderId))
    
    local function inner_cb(succ)
      if cb then
        cb(succ)
      end
    end
    
    ali_datapkg.start_request_result_loop(mask, order.orderId, function(succ, ...)
      UI.hide_receive_loading()
      if succ then
        UI.show_receive_success(function()
          inner_cb(true)
        end)
      else
        UI.show_receive_fail(function()
          inner_cb(false)
        end, function()
          inner_cb(false)
        end)
      end
    end)
    ali_datapkg.set_loop_interval(ali_datapkg.GET_RESULT_LOOP_INTERVAL.INTERVAL_FOREGROUND)
    UI.show_receive_loading(function()
      E.LOG.debug(TAG, "close the receive loading dialog >> ")
      local interval_params = {
        interval = ali_datapkg.GET_RESULT_LOOP_INTERVAL.INTERVAL_BACKGROUND
      }
      FSTAT.stat_action(ACTION.FREE_FLOW_RECEIVE_LOADING_INTERVAL, nil, interval_params)
      ali_datapkg.set_loop_interval(ali_datapkg.GET_RESULT_LOOP_INTERVAL.INTERVAL_BACKGROUND)
    end)
  else
    FSTAT.stat_action(ACTION.FREE_FLOW_HAS_ORDERING_ORDER, false)
    E.LOG.debug(TAG, "ordering order is nil ")
    if cb then
      cb(false)
    end
  end
end

function M.exchange_cdn_host(mask, hosts, cb)
  ali_datapkg.exchange_CDN_host(mask, hosts, cb)
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local HTTP = E.HTTP
local free_flow = require("ejoysdk_lua.free_flow.ejoysdk_free_flow")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local FREE_FLOW_UI = require("ejoysdk_lua.free_flow.free_flow_ui")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local ali_datapkg = require("ejoysdk_lua.vendors.ali_datapkg")
local TAG = "free_flow#cloud_free_data_pkg"
local M = {}
M.DATA_DOWNLOAD_TYPE = {
  UNKNOWN = 0,
  WIFI = 1,
  PAID_4G = 2,
  FREE_4G = 3
}
M.DATA_PAY_TYPE = {FREE = 1, PAY = 2}
local current_download_type = M.DATA_DOWNLOAD_TYPE.UNKNOWN
local current_data_pay_type = M.DATA_PAY_TYPE.FREE
local last_data_download_type
local data_pay_type_change_observers = {}
local receive_data_pkg_over_cbs = {}
local free_flow_data = {}
local current_mask
local has_receive_tag = false
local is_free_flow_open = true
local is_exchange_free_host = false

local function traverse_notify_handler(type)
  for _, handler in ipairs(data_pay_type_change_observers) do
    if handler then
      handler(type)
    end
  end
end

local function notify_data_pay_changed(data_pay_type)
  local params = {pay_type = current_data_pay_type}
  CSTAT.stat_action("free_flow_notify_data_pay_changed", "free_flow", nil, params)
  E.LOG.debug(TAG, "notify data pay type changed, current data pay type >> " .. tostring(data_pay_type))
  E.LOG.debug(TAG, "current download type >> " .. tostring(current_download_type) .. ", and last data download type >> " .. tostring(last_data_download_type))
  if is_free_flow_open then
    if current_download_type == M.DATA_DOWNLOAD_TYPE.FREE_4G and last_data_download_type ~= M.DATA_DOWNLOAD_TYPE.FREE_4G then
      last_data_download_type = current_download_type
      FREE_FLOW_UI.show_switch_to_free_flow()
      traverse_notify_handler(data_pay_type)
    elseif current_download_type == M.DATA_DOWNLOAD_TYPE.PAID_4G and last_data_download_type ~= M.DATA_DOWNLOAD_TYPE.PAID_4G then
      last_data_download_type = current_download_type
      traverse_notify_handler(data_pay_type)
    else
      last_data_download_type = current_download_type
      traverse_notify_handler(data_pay_type)
    end
  else
    traverse_notify_handler(data_pay_type)
  end
end

local function notify_receive_data_pkg_over_cbs(is_free)
  for _, handler in ipairs(receive_data_pkg_over_cbs) do
    if handler then
      handler(is_free)
    end
  end
  notify_data_pay_changed(current_data_pay_type)
end

local function notify_receive_data_pkg_over(is_free)
  E.LOG.debug(TAG, "notify receive data pkg over ")
  local params = {is_free = current_data_pay_type}
  CSTAT.stat_action("free_flow_notify_receive_data_pkg_over", "free_flow", nil, params)
  has_receive_tag = true
  notify_receive_data_pkg_over_cbs(is_free)
end

local function free_flow_network_change_listener()
  E.LOG.debug(TAG, "receive network change callback >> ")
  if not has_receive_tag then
    E.LOG.debug(TAG, "did not invoke receive data pkg progress, return ")
    return
  end
  local network_available = CA.is_network_available()
  if network_available then
    local is_mobile_network = CA.is_mobile_network()
    if is_mobile_network then
      if M.is_ctcc() then
        M.is_free(function(is_free)
          if is_free then
            current_download_type = M.DATA_DOWNLOAD_TYPE.FREE_4G
            current_data_pay_type = M.DATA_PAY_TYPE.FREE
            if not is_exchange_free_host then
              notify_receive_data_pkg_over_cbs(true)
            else
              notify_data_pay_changed(current_data_pay_type)
            end
          else
            current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
            current_data_pay_type = M.DATA_PAY_TYPE.PAY
            notify_data_pay_changed(current_data_pay_type)
          end
        end)
      else
        current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
        current_data_pay_type = M.DATA_PAY_TYPE.PAY
        notify_data_pay_changed(current_data_pay_type)
      end
    else
      current_download_type = M.DATA_DOWNLOAD_TYPE.WIFI
      current_data_pay_type = M.DATA_PAY_TYPE.FREE
      notify_data_pay_changed(current_data_pay_type)
    end
  end
end

local function normal_network_change_listener()
  local network_available = CA.is_network_available()
  if network_available then
    local is_mobile_network = CA.is_mobile_network()
    if is_mobile_network then
      current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
      current_data_pay_type = M.DATA_PAY_TYPE.PAY
    else
      current_download_type = M.DATA_DOWNLOAD_TYPE.WIFI
      current_data_pay_type = M.DATA_PAY_TYPE.FREE
    end
    notify_data_pay_changed(current_data_pay_type)
  end
end

local function acquire_listener()
  E.LOG.debug(TAG, "gangplank acquire succ,")
  if not is_free_flow_open then
    E.LOG.debug(TAG, "is free flow open is false, do not receive free_flow, return ")
    return
  end
  free_flow_data = {}
  local is_mobile_network = CA.is_mobile_network()
  local is_ctcc = M.is_ctcc()
  local params = {is_mobile_network = is_mobile_network, is_ctcc = is_ctcc}
  CSTAT.stat_action("cloud_free_flow_acquire_cb", "free_flow", nil, params)
  E.LOG.debug(TAG, " is mobile work >> " .. tostring(is_mobile_network) .. ", is ctcc >> " .. tostring(is_ctcc))
  if is_mobile_network then
    if is_ctcc then
      M.is_free(function(is_free)
        E.LOG.debug(TAG, "get the free status >> " .. tostring(is_free))
        local params_1 = {is_free = is_free}
        CSTAT.stat_action("cloud_free_flow_free_state", "free_flow", nil, params_1)
        if is_free then
          current_download_type = M.DATA_DOWNLOAD_TYPE.FREE_4G
          current_data_pay_type = M.DATA_PAY_TYPE.FREE
          notify_receive_data_pkg_over(true)
        elseif current_mask then
          local eligible = free_flow.is_eligible(current_mask)
          local params_2 = {eligible = eligible}
          CSTAT.stat_action("cloud_free_flow_eligible", "free_flow", nil, params_2)
          if eligible then
            M.start_receive_data_pkg()
          else
            M.check_ordering_order()
          end
        else
          E.LOG.debug(TAG, "current mask is nil, receive data pkg over")
          current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
          current_data_pay_type = M.DATA_PAY_TYPE.PAY
          notify_receive_data_pkg_over(false)
        end
      end)
    else
      current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
      current_data_pay_type = M.DATA_PAY_TYPE.PAY
      notify_receive_data_pkg_over(false)
    end
  else
    current_download_type = M.DATA_DOWNLOAD_TYPE.WIFI
    current_data_pay_type = M.DATA_PAY_TYPE.FREE
    notify_receive_data_pkg_over(false)
  end
end

function M.init()
  CA.observer_cloud_static_config_refresh(function()
    E.LOG.debug(TAG, "request_cloud_static_config result: is_free_flow_open >> " .. tostring(is_free_flow_open))
    local params = {free_flow_open = is_free_flow_open}
    CSTAT.stat_action("cloud_free_flow_config_cb", "free_flow", true, params)
    local is_mobile_network = CA.is_mobile_network()
    if is_mobile_network then
      current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
      last_data_download_type = current_download_type
      current_data_pay_type = M.DATA_PAY_TYPE.PAY
    else
      current_download_type = M.DATA_DOWNLOAD_TYPE.WIFI
      last_data_download_type = current_download_type
      current_data_pay_type = M.DATA_PAY_TYPE.FREE
    end
    if not is_free_flow_open then
      ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, normal_network_change_listener)
      E.LOG.debug(TAG, "is free flow open is false, do not init free_flow, return ")
      return
    end
    ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, free_flow_network_change_listener)
    ET.subscribe(ET.gangplank.ACQUIRE, acquire_listener)
    free_flow.init(free_flow.FREE_CHANNEL.CHANNEL_ALI, function(succ)
      if succ then
        E.LOG.debug(TAG, "free flow init succ")
      else
        E.LOG.debug(TAG, "free flow init fail")
      end
    end)
  end)
end

function M.is_free_flow_open()
  return is_free_flow_open
end

function M.set_is_free_flow_open(is_open)
  E.LOG.debug(TAG, "set is free flow open >> " .. tostring(is_open))
  is_free_flow_open = is_open
end

function M.is_ctcc()
  E.LOG.debug(TAG, "get is stcc >> ")
  local operator = free_flow.current_operator()
  if operator and operator == free_flow.EJOY_OPERATOR.CTCC then
    E.LOG.debug(TAG, "current operator is ctcc")
    return true
  end
  E.LOG.debug(TAG, "current operator is not ctcc, return false")
  return false
end

function M.is_free(cb, force_query_server)
  if not cb then
    E.LOG.debug(TAG, "is free cb is nil, return")
    return
  end
  E.LOG.debug(TAG, "force_query_server " .. tostring(force_query_server))
  local query_server = force_query_server or false
  free_flow.current_mask_number(function(mask)
    if mask then
      E.LOG.debug(TAG, "current mask number >> " .. tostring(mask))
      current_mask = mask
      if query_server then
        free_flow.is_free_for_mask(free_flow.EJOY_OPERATOR.CTCC, mask, function(is_free)
          free_flow_data[mask] = is_free
          cb(is_free)
        end)
      else
        local is_free = free_flow_data[mask]
        E.LOG.debug(TAG, "current mask number is free >> " .. tostring(is_free))
        if nil ~= is_free then
          cb(is_free)
        else
          free_flow.is_free_for_mask(free_flow.EJOY_OPERATOR.CTCC, mask, function(free_state)
            free_flow_data[mask] = free_state
            cb(free_state)
          end)
        end
      end
    else
      E.LOG.debug(TAG, "get mask number fail")
      current_mask = nil
      cb(false)
    end
  end)
end

local function receive_data_pkg_cb(succ, ...)
  if succ then
    M.is_free(function(is_free)
      if is_free then
        current_data_pay_type = M.DATA_PAY_TYPE.FREE
        local is_mobile_network = CA.is_mobile_network()
        if is_mobile_network then
          current_download_type = M.DATA_DOWNLOAD_TYPE.FREE_4G
          notify_receive_data_pkg_over(true)
        else
          current_download_type = M.DATA_DOWNLOAD_TYPE.WIFI
          notify_receive_data_pkg_over(false)
        end
      else
        local is_mobile_network = CA.is_mobile_network()
        if is_mobile_network then
          current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
          current_data_pay_type = M.DATA_PAY_TYPE.PAY
        else
          current_download_type = M.DATA_DOWNLOAD_TYPE.WIFI
          current_data_pay_type = M.DATA_PAY_TYPE.FREE
        end
        notify_receive_data_pkg_over(false)
      end
    end, true)
  else
    local code = (...)
    if code and code == ali_datapkg.RECEIVE_ERROR_CODE.MASK_TOKEN_NOT_MATCH then
      acquire_listener()
      return
    end
    local is_mobile_network = CA.is_mobile_network()
    if is_mobile_network then
      current_download_type = M.DATA_DOWNLOAD_TYPE.PAID_4G
      current_data_pay_type = M.DATA_PAY_TYPE.PAY
    else
      current_download_type = M.DATA_DOWNLOAD_TYPE.WIFI
      current_data_pay_type = M.DATA_PAY_TYPE.FREE
    end
    notify_receive_data_pkg_over(false)
  end
end

function M.start_receive_data_pkg()
  free_flow.receive_free_data_pkg(current_mask, receive_data_pkg_cb)
end

function M.check_ordering_order()
  free_flow.check_ordering_order(current_mask, receive_data_pkg_cb)
end

function M.exchange_download_host(url, cb)
  if not cb then
    E.LOG.debug(TAG, "exchange download host, cb is nil, return")
    return
  end
  local url_obj = HTTP.parse(url)
  local host = url_obj.host
  local params = {host = host}
  CSTAT.stat_action("cloud_free_flow_exchange_host", "free_flow", nil, params)
  E.LOG.debug(TAG, "get host from url >> " .. tostring(url) .. ", host >> " .. tostring(host))
  local host_list = {}
  table.insert(host_list, host)
  free_flow.exchange_cdn_host(current_mask, host_list, function(succ, ...)
    if succ then
      local result = (...)
      local new_host = result[host]
      local new_url = url_obj.scheme .. "://" .. new_host .. url_obj.path
      local params_1 = {origin_host = host, new_host = new_host}
      CSTAT.stat_action("cloud_free_flow_exchange_host_cb", "free_flow", true, params_1)
      is_exchange_free_host = true
      cb(true, new_url)
    else
      local code, message = ...
      E.LOG.debug(TAG, "exchange cdn host fail, code >> " .. tostring(code) .. ", message >> " .. tostring(message))
      local fail_params = {code = code, message = message}
      CSTAT.stat_action("cloud_free_flow_exchange_host_cb", "free_flow", false, fail_params)
      cb(false)
    end
  end)
end

function M.get_current_data_pay_type()
  return current_data_pay_type
end

function M.get_current_download_type()
  return current_download_type
end

function M.register_receive_data_pkg_over_cb(cb)
  for _, handler in ipairs(receive_data_pkg_over_cbs) do
    if handler == cb then
      return
    end
  end
  receive_data_pkg_over_cbs[#receive_data_pkg_over_cbs + 1] = cb
end

function M.register_data_pay_type_changed_cb(cb)
  for _, handler in ipairs(data_pay_type_change_observers) do
    if handler == cb then
      return
    end
  end
  data_pay_type_change_observers[#data_pay_type_change_observers + 1] = cb
end

function M.unregister_data_pay_type_changed_cb(cb)
  local new = {}
  for _, handler in ipairs(data_pay_type_change_observers) do
    if cb ~= handler then
      new[#new + 1] = handler
    end
  end
  data_pay_type_change_observers = new
end

function M.check_and_show_ctcc_splash(enter_cb)
  if M.is_ctcc() and M.is_free_flow_open() then
    FREE_FLOW_UI.show_receive_splash(enter_cb)
  else
    enter_cb()
  end
end

return M

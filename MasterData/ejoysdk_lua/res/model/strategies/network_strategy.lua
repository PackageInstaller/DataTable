local E = require("ejoysdk_lua.ejoysdk")
local IS = require("ejoysdk_lua.res.model.strategies.i_strategy")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local TAG = "network_strategy"
local M = IS:Inherit(TAG)
M.STRATEGY = {
  BOTH_MOBILE_WIFI_NETWORK = "both_mobile_wifi_network",
  WIFI_ONLY = "wifi_only"
}
local m_listeners_strategy_map = {}
local m_listen_state_started = false
local m_current_is_mobile_network

local function is_network_available()
  return 0 ~= E.Sysinfo.network_type()
end

local function is_mobile_network()
  local type = E.Sysinfo.network_type()
  return 2 == type or 3 == type
end

local function check_strategy_state(lis, strategy)
  strategy = strategy or M.STRATEGY.BOTH_MOBILE_WIFI_NETWORK
  local staisfied = true
  if strategy == M.STRATEGY.BOTH_MOBILE_WIFI_NETWORK then
    staisfied = true
  elseif strategy == M.STRATEGY.WIFI_ONLY then
    if nil == m_current_is_mobile_network then
      m_current_is_mobile_network = is_mobile_network()
    end
    staisfied = not m_current_is_mobile_network
  end
  E.LOG.debug(TAG, string.format("check_strategy_state with strategy:%s , m_current_is_mobile_network:%s, available:%s, staisfied:%s ", tostring(strategy), tostring(m_current_is_mobile_network), tostring(is_network_available()), tostring(staisfied)))
  return staisfied
end

local function on_network_change_handler()
  local _is_available = is_network_available()
  local _is_mobile = is_mobile_network()
  E.LOG.debug(TAG, string.format("on_network_change_handler, available:%s, mobile:%s, m_current_is_mobile_network:%s", tostring(_is_available), tostring(_is_mobile), tostring(m_current_is_mobile_network)))
  if not _is_available then
    E.LOG.debug(TAG, "on_network_change_handler current not available2")
    m_current_is_mobile_network = nil
    return
  end
  local network_type_changed = _is_mobile ~= m_current_is_mobile_network
  if not network_type_changed then
    E.LOG.debug(TAG, "receive network state changed, current is_mobile_network state not changed, current:" .. tostring(m_current_is_mobile_network) .. ", received:" .. tostring(_is_mobile))
    return
  end
  m_current_is_mobile_network = _is_mobile
  for lis, strategy in pairs(m_listeners_strategy_map) do
    local strategy_satisfied = check_strategy_state(lis, strategy)
    lis(strategy_satisfied)
  end
end

local function check_strategy_start()
  local lis_size = EU.tablelength(m_listeners_strategy_map)
  local enable = lis_size > 0
  local state_listen_state_changed = false
  if m_listen_state_started ~= enable then
    state_listen_state_changed = true
  end
  if not state_listen_state_changed then
    E.LOG.debug(TAG, "listen state not changed, current:" .. tostring(m_listen_state_started))
    return
  end
  m_listen_state_started = enable
  if enable then
    E.LOG.debug(TAG, "strategy start")
    E.Sysinfo.network_monitor_start()
    ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change_handler)
  else
    E.LOG.debug(TAG, "strategy stop")
    ET.unsubscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change_handler)
  end
end

function M.register_state_change_listener(lis, listen_strategy)
  if not lis then
    E.LOG.warn(TAG, "register_state_change_listener skip, listener is nil")
    return
  end
  m_listeners_strategy_map[lis] = listen_strategy
  m_current_is_mobile_network = nil
  local staisfied = check_strategy_state(lis, listen_strategy)
  lis(staisfied)
  check_strategy_start()
end

function M.unregister_state_change_listener(lis)
  m_listeners_strategy_map[lis] = nil
  check_strategy_start()
end

local _strategy_name = M.STRATEGY.BOTH_MOBILE_WIFI_NETWORK

function M.update_strategy(strategy_name)
  local SF = require("ejoysdk_lua.res.model.strategies.strategy_factory")
  if SF.get_strategy_processor(strategy_name) then
    _strategy_name = strategy_name
  end
  local _strategy_map = UTILS.deepcopy(m_listeners_strategy_map)
  for lis, _strategy in pairs(_strategy_map) do
    local strategy_satisfied = check_strategy_state(lis, strategy_name)
    lis(strategy_satisfied, strategy_name)
  end
end

function M.get_strategy()
  return _strategy_name
end

function M.tostring()
  return "network is mobile:" .. tostring(is_mobile_network())
end

return M

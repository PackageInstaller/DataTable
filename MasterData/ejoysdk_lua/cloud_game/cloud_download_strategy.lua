local E = require("ejoysdk_lua.ejoysdk")
local CTL = require("ejoysdk_lua.cloud_game.cloud_time_limit_checker")
local CLOUD_UI = require("ejoysdk_lua.cloud_game.cloud_ui")
local FREE_FLOW = require("ejoysdk_lua.cloud_game.cloud_free_data_pkg")
local M = {}
M.DOWNLOAD_STRATEGYS = {
  STRATEGY_UNKNOWN = "unknown",
  DOWNLOAD_IN_WIFI_ONLY = "download_in_wifi_only",
  DOWNLOAD_FORCE_IN_MOBILE_NETWORK = "download_force_in_mobile_network"
}
local TAG = "cloud_download_strategy"
local DEFAULT_USER_CONFIRMED_DOWNLOAD_STRATEGY = true
local current_strategy = M.DOWNLOAD_STRATEGYS.DOWNLOAD_FORCE_IN_MOBILE_NETWORK
local user_confirmed_strategy = DEFAULT_USER_CONFIRMED_DOWNLOAD_STRATEGY
local strategy_change_listener, current_time_limit_stage
local current_data_pay_type = FREE_FLOW.DATA_PAY_TYPE.PAY
local is_experience_time_end_strategy_showed = false

local function check_startegy_need_confirm()
  E.LOG.debug(TAG, "on experience time end, current_time_limit_stage:" .. tostring(current_time_limit_stage) .. ", current_data_pay_type:" .. tostring(current_data_pay_type) .. ", current_strategy:" .. tostring(current_strategy))
  if current_time_limit_stage == CTL.TIME_LIMIT_STAGE.EXPERIENCE_TIME_END and current_data_pay_type == FREE_FLOW.DATA_PAY_TYPE.PAY and current_strategy == M.DOWNLOAD_STRATEGYS.DOWNLOAD_IN_WIFI_ONLY then
    E.LOG.warn(TAG, "it's experience time end, it's moible network, and it's current download strategy is wifi-only, so need show experience time end dialog")
    if is_experience_time_end_strategy_showed then
      return
    end
    user_confirmed_strategy = DEFAULT_USER_CONFIRMED_DOWNLOAD_STRATEGY
    is_experience_time_end_strategy_showed = true
    CLOUD_UI.show_free_exper_time_over(function(_is_force_download)
      E.LOG.debug(TAG, "experience time end confirm dialog dismiss, so always change download strategy to force in mobile network")
      M.update_download_strategy(M.DOWNLOAD_STRATEGYS.DOWNLOAD_FORCE_IN_MOBILE_NETWORK, true)
    end)
  end
end

local function on_time_limit_state_change(limit_state_obj)
  current_time_limit_stage = limit_state_obj[CTL.STATE_INFO_KEY.KEY_STAGE]
  E.LOG.debug(TAG, "receive time limit state change:" .. tostring(current_time_limit_stage))
  check_startegy_need_confirm()
end

local function data_pay_type_change_listener(type)
  E.LOG.debug(TAG, "receive data pay type change >> " .. tostring(type))
  current_data_pay_type = type
  check_startegy_need_confirm()
end

function M.init()
  CTL.register_time_limit_state_changed(on_time_limit_state_change)
  FREE_FLOW.register_data_pay_type_changed_cb(data_pay_type_change_listener)
end

function M.update_download_strategy(strategy, confirmed)
  E.LOG.debug(TAG, "update_download_strategy, new:" .. tostring(strategy) .. ", current：" .. tostring(current_strategy))
  user_confirmed_strategy = confirmed
  local is_strategy_changed = current_strategy ~= strategy
  current_strategy = strategy
  if is_strategy_changed and strategy_change_listener then
    strategy_change_listener()
  end
end

function M.current_strategy()
  return current_strategy
end

function M.register_strategy_changed(listener)
  E.LOG.debug(TAG, "register_strategy_changed")
  strategy_change_listener = listener
end

function M.is_user_confirmed_strategy()
  E.LOG.debug(TAG, "is_user_confirmed_strategy:" .. tostring(user_confirmed_strategy))
  return user_confirmed_strategy
end

return M

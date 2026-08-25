local STAT = require("ejoysdk_lua.ejoysdk_stat")
local E = require("ejoysdk_lua.ejoysdk")
local TAG = "free_flow#free_flow_stat"
local M = {}
M.FREE_FLOW_ACTION = {
  FREE_FLOW_INIT = "free_flow_init",
  FREE_FLOW_SHOW_AUTH = "free_flow_show_auth",
  FREE_FLOW_SHOW_AUTH_RESULT = "free_flow_show_auth_result",
  FREE_FLOW_GET_TOKEN_RESULT = "free_flow_get_token_result",
  FREE_FLOW_RECEIVE_REQUEST_RESULT = "free_flow_receive_request_result",
  FREE_FLOW_RECEIVE_RESULT = "free_flow_receive_result",
  FREE_FLOW_RECEIVE_SHOW_LOADING = "free_flow_receive_show_loading",
  FREE_FLOW_RECEIVE_LOADING_INTERVAL = "free_flow_receive_loading_interval",
  FREE_FLOW_SHOW_RECEIVE_SUCC_PAGE = "free_flow_show_receive_succ_page",
  FREE_FLOW_SHOW_RECEIVE_FAIL = "free_flow_show_receive_fail",
  FREE_FLOW_SHOW_RECEIVE_FAIL_RETRY = "free_flow_show_receive_fail_retry",
  FREE_FLOW_SHOW_RECEIVE_FAIL_ENTER = "free_flow_show_receive_fail_enter",
  FREE_FLOW_SHOW_RECEIVE_SUCC_ENTER = "free_flow_show_receive_succ_enter",
  FREE_FLOW_HAS_ORDERING_ORDER = "free_flow_has_ordering_order",
  FREE_FLOW_GET_MASK_RESULT = "free_flow_get_mask_result",
  FREE_FLOW_TOAST = "free_flow_toast",
  DX_GET_FREE_FLOW_PAGE = "dx_get_free_flow_page",
  DX_GET_FREE_FLOW_PAGE_LOGIN_BUTTON = "dx_get_free_flow_page_login_button"
}
local action_type = "free_flow"

function M.stat_action(action, result, params)
  E.LOG.debug(TAG, "stat action, action >> " .. tostring(action) .. ", and result >> " .. tostring(result))
  local stat_params = params or {}
  stat_params.is_priority_high = true
  STAT.stat_action(action, action_type, result, stat_params)
end

return M

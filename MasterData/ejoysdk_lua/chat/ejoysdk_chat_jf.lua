local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local E = require("ejoysdk_lua.ejoysdk")
local TAG = EM.MODULE.CHAT .. "chat_jf"
local M = {}
M.ACTION_TYPE = {ERROR = "chat_err", EVENT = "chat_event"}
M.ACTION = {
  CONNECT_FAIL = "chat_connect_fail",
  LOGIN_GROUP_EMPTY = "chat_login_group_empty",
  LOGIN_FAIL_CAUSE_BY_RPC = "chat_login_fail_cause_by_rpc",
  LOGIN_FAIL_CAUSE_BY_CHECK_GROUPS = "chat_login_fail_cause_by_check_groups",
  GET_LATEST_SESSION_FAIL = "chat_get_latest_session_fail",
  GET_MSG_FAIL = "chat_get_msg_fail",
  SEND_MSG_FAIL = "chat_send_msg_fail",
  GET_GROUP_FAIL = "chat_get_group_fail"
}

function M.connect_fail(params)
  params = params or {}
  params.is_priority_high = true
  local stat_key = M.ACTION.CONNECT_FAIL .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, M.ACTION.CONNECT_FAIL, M.ACTION_TYPE.ERROR, params)
end

function M.login_succ(_params)
end

function M.login_fail(action, params)
  params = params or {}
  params.is_priority_high = true
  local stat_key = action .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, action, M.ACTION_TYPE.ERROR, params)
end

function M.login_result_group_empty(params)
  params = params or {}
  params.is_priority_high = true
  local stat_key = M.ACTION.LOGIN_GROUP_EMPTY .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, M.ACTION.LOGIN_GROUP_EMPTY, M.ACTION_TYPE.ERROR, params)
end

function M.re_login(_params)
end

function M.get_latest_session_fail(chat_type, params)
  params = params or {}
  if tostring(params.code) == "-1" or tostring(params.code) == "7010100" or tostring(params.code) == "-10" then
    E.LOG.d(TAG, "get_latest_session_fail, code=" .. tostring(params.code))
    return
  end
  params._chat_type = chat_type
  params.is_priority_high = true
  local stat_key = M.ACTION.GET_LATEST_SESSION_FAIL .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, M.ACTION.GET_LATEST_SESSION_FAIL, M.ACTION_TYPE.ERROR, params)
end

function M.get_msg_fail(chat_type, params)
  params = params or {}
  if tostring(params.code) == "-1" or tostring(params.code) == "7010100" or tostring(params.code) == "-10" then
    E.LOG.d(TAG, "get_msg_fail, code=" .. tostring(params.code))
    return
  end
  params._chat_type = chat_type
  params.is_priority_high = true
  local stat_key = M.ACTION.GET_MSG_FAIL .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, M.ACTION.GET_MSG_FAIL, M.ACTION_TYPE.ERROR, params)
end

function M.send_msg_fail(chat_type, params)
  params = params or {}
  params._chat_type = chat_type
  params.is_priority_high = true
  local stat_key = M.ACTION.SEND_MSG_FAIL .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, M.ACTION.SEND_MSG_FAIL, M.ACTION_TYPE.ERROR, params)
end

function M.get_group_fail(chat_type, params)
  params = params or {}
  params._chat_type = chat_type
  params.is_priority_high = true
  local stat_key = M.ACTION.GET_GROUP_FAIL .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, M.ACTION.GET_GROUP_FAIL, M.ACTION_TYPE.ERROR, params)
end

return M

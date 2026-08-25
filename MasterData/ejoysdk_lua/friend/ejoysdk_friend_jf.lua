local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.FRIEND .. "friend_jf"
local M = {}
M.ACTION_TYPE = {
  ERROR = "friend_err",
  EVENT = "friend_event"
}
M.ACTION = {
  GET_FRIEND_LIST_FAIL = "get_friend_list_fail",
  ADD_FRIEND_FAIL = "add_friend_fail",
  ACCEPT_FRIEND_APPLY_FAIL = "accept_friend_apply_fail",
  ADD_BLACK_FAIL = "add_black_fail",
  DEL_BLACK_FAIL = "del_black_fail"
}

function M.get_friend_list_fail(params)
  params = params or {}
  params.is_priority_high = true
  local stat_key = M.ACTION.GET_FRIEND_LIST_FAIL .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, M.ACTION.GET_FRIEND_LIST_FAIL, M.ACTION_TYPE.ERROR, params)
end

function M.add_friend_fail(params)
  local action = M.ACTION.ADD_FRIEND_FAIL
  params = params or {}
  params.is_priority_high = true
  local stat_key = action .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, action, M.ACTION_TYPE.ERROR, params)
end

function M.accept_friend_apply_fail(params)
  local action = M.ACTION.ACCEPT_FRIEND_APPLY_FAIL
  params = params or {}
  params.is_priority_high = true
  local stat_key = action .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, action, M.ACTION_TYPE.ERROR, params)
end

function M.add_black_fail(params)
  local action = M.ACTION.ADD_BLACK_FAIL
  params = params or {}
  params.is_priority_high = true
  local stat_key = action .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, action, M.ACTION_TYPE.ERROR, params)
end

function M.del_black_fail(params)
  local action = M.ACTION.DEL_BLACK_FAIL
  params = params or {}
  params.is_priority_high = true
  local stat_key = action .. "-" .. M.ACTION_TYPE.ERROR
  ESTAT.stat_error_with_limit(TAG, stat_key, action, M.ACTION_TYPE.ERROR, params)
end

return M

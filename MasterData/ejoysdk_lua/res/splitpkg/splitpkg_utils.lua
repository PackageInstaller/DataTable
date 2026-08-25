local E = require("ejoysdk_lua.ejoysdk")
local ES = require("ejoysdk_lua.ejoysdk_stat")
local TAG = "splitpkg_utils"
local M = {}

function M.splitpkg_download_track(function_name, action_name, params)
  params = params or {}
  E.LOG.debug(TAG, "track, function_name:" .. function_name .. ", action_name:" .. action_name)
  local is_fail = "download_fail" == action_name
  ES.stat_bizid_pfcomm({
    is_priority_high = params.is_priority_high or false,
    biz_group = "lq",
    biz_prod = "qz",
    biz_mod = "play_while_download",
    biz_func = function_name,
    biz_act = action_name,
    biz_st = is_fail and "fail" or "succ",
    biz_co = is_fail and tostring(params.error_code or "400") or "200",
    biz_params = params
  })
end

return M

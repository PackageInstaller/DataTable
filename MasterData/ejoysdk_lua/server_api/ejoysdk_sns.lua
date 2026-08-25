local BASE_API = require("ejoysdk_lua.libs.base_api")
local E = require("ejoysdk_lua.ejoysdk")
local sns_api = BASE_API:New("sns")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.SERVER_API .. "sns"
local M = {}

function M.have_active_site_entry(app_refs, cb)
  if not app_refs or app_refs and 0 == #app_refs then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "app_refs is nil or empty")
    return
  end
  local params = {app_refs = app_refs}
  M.have_active_site_entry_with_params(params, cb)
end

function M.have_active_site_entry_with_params(params, cb)
  E.LOG.d(_TAG, params)
  local opt = {use_moment_token = true}
  sns_api:post("/api/conf_system/user/has_activity_site_entry", {}, params, opt, function(succ, ...)
    if succ then
      local res_body = (...)
      cb(succ, res_body.items)
    else
      cb(succ, ...)
    end
  end)
end

function M.create_player_share_snapshot(params, cb)
  E.LOG.d(_TAG, params)
  local opt = {use_moment_token = true}
  sns_api:post("/api/logined/user_v2/create_player_share_snapshot", {}, params, opt, function(succ, ...)
    if succ then
      local res_body = (...)
      cb(succ, res_body)
    else
      cb(succ, ...)
    end
  end)
end

return M

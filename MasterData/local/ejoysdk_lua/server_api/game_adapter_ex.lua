local BASE_API = require("ejoysdk_lua.libs.base_api")
local game_adapter_api = BASE_API:New("game-adapter")
local server_manager_api = BASE_API:New("server-manager")
local EC = require("ejoysdk_lua.ejoysdk_config")
local M = {}

local function game_adapter_api_path(api, ver)
  if ver then
    api = "/v" .. tostring(ver) .. api
  end
  return api
end

local function auto_choose_api()
  if EC.is_force_use_rule_service_splice_in_path("game-adapter") then
    return server_manager_api
  end
  return game_adapter_api
end

function M.get_reserve_server_list(_params, cb)
  local params = _params or {}
  local opt = {use_ejoy_token = true}
  auto_choose_api():post(game_adapter_api_path("/reserve_server/get_reserve_server_list"), {}, params, opt, function(succ, ...)
    if succ then
      local body = (...)
      local list = body.data and body.data.reserve_server_list
      cb(succ, list)
    else
      cb(succ, ...)
    end
  end)
end

function M.get_account_reserve_info(cb)
  local body = {}
  local opt = {use_ejoy_token = true}
  auto_choose_api():post(game_adapter_api_path("/reserve_server/get_account_reserve_info"), {}, body, opt, function(succ, ...)
    if succ then
      local res_body = (...)
      cb(succ, res_body.data)
    else
      cb(succ, ...)
    end
  end)
end

function M.do_reserve_server(_params, cb)
  local params = _params or {}
  local opt = {use_ejoy_token = true}
  auto_choose_api():post(game_adapter_api_path("/reserve_server/do_reserve_server"), {}, params, opt, cb)
end

function M.cancel_reserve_server(_params, cb)
  local params = _params or {}
  local opt = {use_ejoy_token = true}
  auto_choose_api():post(game_adapter_api_path("/reserve_server/cancel_reserve_server"), {}, params, opt, cb)
end

return M

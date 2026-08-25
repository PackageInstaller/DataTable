local BASE_API = require("ejoysdk_lua.libs.base_api")
local stake_api = BASE_API:New("stake")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.SERVER_API .. "stake"
local M = {}

function M.get_stake_info(stake_id, cb)
  local body = {stake_id = stake_id}
  local opt = {use_moment_token = true}
  stake_api:post("/register/stake_info", {}, body, opt, cb)
end

function M.get_player_profile(stake_id, cb)
  local body = {stake_id = stake_id}
  local opt = {use_moment_token = true}
  stake_api:post("/draw/player_profile", {}, body, opt, cb)
end

function M.get_result(stake_id, batch_id, reward_id, last_page_index, cb)
  local query = {
    stake_id = stake_id,
    batch_id = batch_id,
    reward_id = reward_id,
    last_page_index = last_page_index
  }
  local opt = {use_moment_token = true}
  stake_api:get("/draw/get_result", {}, query, opt, cb)
end

function M.get_batch_list(stake_id, descending_order, page, count, cb)
  local body = {
    stake_id = stake_id,
    descending_order = descending_order,
    page = page or 1,
    count = count or 10
  }
  local opt = {use_moment_token = true}
  stake_api:post("/register/get_batch_list", {}, body, opt, cb)
end

return M

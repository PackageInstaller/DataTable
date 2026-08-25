local BASE_API = require("ejoysdk_lua.libs.base_api")
local badge_api = BASE_API:New("badge")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.SERVER_API .. "badge"
local M = {}

function M.get_badge_tree(badge_app_id, badge_tree_id, cb)
  local headers = {}
  local body = {app_id = badge_app_id, tree_id = badge_tree_id}
  local opt = {use_moment_token = true}
  badge_api:post("/v1/get_tree", headers, body, opt, function(succ, ...)
    if succ then
      local result = (...)
      local tree_info = result.data.tree_info
      cb(true, tree_info, result.data)
    else
      cb(false, ...)
    end
  end)
end

function M.report_visit_node(badge_app_id, badge_tree_id, badge_node_ids, cb)
  local headers = {}
  local body = {
    app_id = badge_app_id,
    tree_id = badge_tree_id,
    node_ids = badge_node_ids
  }
  local opt = {use_moment_token = true}
  badge_api:post("/v1/collect", headers, body, opt, function(succ, ...)
    if succ then
      cb(true)
    else
      cb(false, ...)
    end
  end)
end

function M.batch_get_tree(query, cb)
  local headers = {}
  local body = {batch_query = query}
  local opt = {use_moment_token = true}
  badge_api:post("/v1/batch_get_trees", headers, body, opt, function(succ, ...)
    if succ then
      local result = (...)
      local tree_info = result.data.batch_result
      cb(true, tree_info, result.data)
    else
      cb(false, ...)
    end
  end)
end

return M

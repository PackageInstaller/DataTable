local E = require("ejoysdk_lua.ejoysdk")
local BADGE_API = require("ejoysdk_lua.server_api.ejoysdk_badge")
local CACHE = require("ejoysdk_lua.badge.ejoysdk_badge_tree_cache")
local BADGE_OP = require("ejoysdk_lua.badge.ejoysdk_badge_tree_op")
local util = require("ejoysdk_lua.ejoysdk_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.BADGE .. "badge"
local INTERVAL = 300
local pending_deactivate_nodes = {}
local request_queue = {}
local cb_queue = {}
M.Status = {REQUEST_TIME_OUT = 10001}

local function inner_deactivate_node(badge_app_id, badge_tree_id, root_node, node_id, deactivate_mode)
  local find_succ = BADGE_OP.deactivate(root_node, node_id, deactivate_mode)
  if find_succ then
    BADGE_API.report_visit_node(badge_app_id, badge_tree_id, {node_id}, function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "badge: 红点刷新上报成功, 上报节点：" .. tostring(node_id))
      else
        local code, msg = ...
        local text = "code: " .. tostring(code) .. " ,msg: " .. tostring(msg)
        E.LOG.debug(TAG, "badge: 红点刷新上报失败:" .. tostring(text))
      end
    end)
  else
    E.LOG.debug(TAG, "badge: 没有消除红点，无需上报")
  end
  return root_node
end

local function handle_pending_node(key, app_id, tree_id, tree_info, deactivate_mode, succ, ...)
  if pending_deactivate_nodes[key] and next(pending_deactivate_nodes[key]) then
    local current_tree_pending_nodes = pending_deactivate_nodes[key]
    local pending_length = #current_tree_pending_nodes
    for index = pending_length, 1, -1 do
      local pending_action = current_tree_pending_nodes[index]
      local pending_app_id = pending_action.app_id
      local pending_tree_id = pending_action.tree_id
      local pending_node_id = pending_action.node_id
      local pending_cb = pending_action.cb
      E.LOG.debug(TAG, "badge: 消除暂存红点 " .. tostring(pending_node_id))
      if app_id == pending_app_id and tree_id == pending_tree_id then
        if succ then
          inner_deactivate_node(app_id, tree_id, tree_info, pending_node_id, deactivate_mode)
          pending_cb(true, util.deepcopy(tree_info))
        else
          pending_cb(false, ...)
        end
        table.remove(current_tree_pending_nodes, index)
      end
    end
  end
end

local function handle_cb(key, succ, ...)
  if cb_queue[key] then
    for _, cb in pairs(cb_queue[key]) do
      cb(succ, ...)
    end
    cb_queue[key] = nil
  end
end

local function inner_get_badge_tree(badge_app_id, badge_tree_id, cb)
  local key = CACHE.cal_key(badge_app_id, badge_tree_id)
  if cb_queue[key] then
    table.insert(cb_queue[key], cb)
  else
    cb_queue[key] = {cb}
  end
  if request_queue[key] then
    E.LOG.debug(TAG, "获取红点树数据请求中，不再重新请求")
    return
  end
  local callBackAlready = false
  E.Timer.once(5, function()
    if callBackAlready then
      return
    end
    callBackAlready = true
    request_queue[key] = nil
    E.LOG.debug(TAG, "badge: get_tree 请求超时")
    handle_cb(key, false, M.Status.REQUEST_TIME_OUT, "请求超时")
  end)
  request_queue[key] = true
  BADGE_API.get_badge_tree(badge_app_id, badge_tree_id, function(succ, ...)
    if callBackAlready then
      return
    end
    request_queue[key] = nil
    callBackAlready = true
    if succ then
      local _, data = ...
      E.LOG.debug(TAG, "badge: app_id: " .. tostring(badge_app_id) .. ", tree_id: " .. tostring(badge_tree_id) .. ", 拉取数据成功")
      local tree_info = data.tree_info
      local deactivate_mode = data.deactivate_mode
      local cache_ttl = data.cache_ttl or INTERVAL
      CACHE.add_badge_tree(badge_app_id, badge_tree_id, tree_info, deactivate_mode, cache_ttl)
      handle_cb(key, true, data)
    else
      local code, msg = ...
      local err_msg = "code: " .. tostring(code) .. " ,msg: " .. tostring(msg)
      E.LOG.debug(TAG, "badge: app_id: " .. tostring(badge_app_id) .. ", tree_id: " .. tostring(badge_tree_id) .. ", 拉取数据失败, " .. tostring(err_msg))
      handle_cb(key, false, ...)
    end
  end)
end

function M.get_badge_tree(badge_app_id, badge_tree_id, cb)
  local cache_entity = CACHE.get_cache_tree(badge_app_id, badge_tree_id)
  if cache_entity then
    E.LOG.debug(TAG, "badge: app_id: " .. tostring(badge_app_id) .. ", tree_id: " .. tostring(badge_tree_id) .. ", 存在有效缓存")
    cb(true, util.deepcopy(cache_entity.tree_info))
  else
    E.LOG.debug(TAG, "badge: app_id: " .. tostring(badge_app_id) .. ", tree_id: " .. tostring(badge_tree_id) .. ", 没有有效缓存，拉取数据")
    inner_get_badge_tree(badge_app_id, badge_tree_id, function(succ, ...)
      if succ then
        local data = (...)
        cb(true, util.deepcopy(data.tree_info))
      else
        cb(false, ...)
      end
    end)
  end
end

function M.deactivate_node(badge_app_id, badge_tree_id, node_id, cb)
  local cache_entity = CACHE.get_cache_tree(badge_app_id, badge_tree_id)
  if cache_entity then
    E.LOG.debug(TAG, "badge: 存在有效缓存数据，消除红点")
    local tree_info = inner_deactivate_node(badge_app_id, badge_tree_id, cache_entity.tree_info, node_id, cache_entity.deactivate_mode)
    cb(true, util.deepcopy(tree_info))
  else
    E.LOG.debug(TAG, "badge: 不存在有效缓存，拉取数据后消除红点")
    local pending_deactivate_node_action = {
      app_id = badge_app_id,
      tree_id = badge_tree_id,
      node_id = node_id,
      cb = cb
    }
    local key = CACHE.cal_key(badge_app_id, badge_tree_id)
    if pending_deactivate_nodes[key] then
      table.insert(pending_deactivate_nodes[key], pending_deactivate_node_action)
    else
      pending_deactivate_nodes[key] = {pending_deactivate_node_action}
    end
    inner_get_badge_tree(badge_app_id, badge_tree_id, function(succ, ...)
      if succ then
        local data = (...)
        local tree_info = data.tree_info
        local deactivate_mode = data.deactivate_mode
        handle_pending_node(key, badge_app_id, badge_tree_id, tree_info, deactivate_mode, true)
        E.LOG.debug(TAG, "badge: 拉取数据并消除红点成功")
      else
        handle_pending_node(key, badge_app_id, badge_tree_id, nil, nil, false, ...)
        E.LOG.debug(TAG, "badge: 消除红点时拉取数据失败")
      end
    end)
  end
end

return M

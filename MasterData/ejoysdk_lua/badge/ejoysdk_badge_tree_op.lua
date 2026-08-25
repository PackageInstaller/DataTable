local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.BADGE .. "tree_op"
M.deactivate_mode = {REMOVE_FORCE = "RECURSION", DEFAULT = "CURRENT"}
M.ID_TYPE = {NODE = 1, REF_TREE = 2}
M.DEACT_RULE = {DEFAULT = 0, NOT_DEACT = 1}

local function copy_record(record)
  if nil == record then
    return nil
  end
  local record_copy = {}
  for _, node in pairs(record) do
    table.insert(record_copy, node)
  end
  return record_copy
end

local function back_record(record)
  if record and next(record) then
    table.remove(record, 1)
    if record and next(record) then
      return record[1]
    end
  end
  return nil
end

local function inner_find_all(root, id, record, type, all_find_record)
  record = record or {}
  local id_type = type or M.ID_TYPE.NODE
  if not root.visited then
    root.visited = true
    table.insert(record, 1, root)
  end
  if id_type == M.ID_TYPE.NODE and root.node_id == id then
    table.insert(all_find_record, copy_record(record))
    local back_root = back_record(record)
    if back_root then
      inner_find_all(back_root, id, record, type, all_find_record)
    end
    return
  end
  if id_type == M.ID_TYPE.REF_TREE and root.ref_tree_id == id then
    table.insert(all_find_record, copy_record(record))
    local ref_back_root = back_record(record)
    if ref_back_root then
      inner_find_all(ref_back_root, id, record, type, all_find_record)
    end
    return
  end
  local not_has_children = root.children == nil or nil == next(root.children)
  local not_has_ref_tree_info = nil == root.ref_tree_info
  if not_has_children and not_has_ref_tree_info then
    local leaf_back_root = back_record(record)
    if leaf_back_root then
      inner_find_all(leaf_back_root, id, record, type, all_find_record)
    end
    return
  end
  local all_visited = true
  if not not_has_children then
    for _, node in pairs(root.children) do
      if not node.visited then
        all_visited = false
        inner_find_all(node, id, record, type, all_find_record)
      end
    end
    if all_visited then
      local all_visited_back_root = back_record(record)
      if all_visited_back_root then
        inner_find_all(all_visited_back_root, id, record, type, all_find_record)
      end
    end
  end
  if not not_has_ref_tree_info then
    if root.ref_tree_info.visited then
      local ref_tree_back_root = back_record(record)
      if ref_tree_back_root then
        inner_find_all(ref_tree_back_root, id, record, type, all_find_record)
      end
    else
      inner_find_all(root.ref_tree_info, id, record, type, all_find_record)
    end
  end
end

local function clear_visited(root)
  if root then
    root.visited = nil
    if root.children and next(root.children) then
      for _, node in pairs(root.children) do
        clear_visited(node)
      end
    end
    if root.ref_tree_info then
      clear_visited(root.ref_tree_info)
    end
  end
end

function M.find_all(root, id, type)
  local all_find_record = {}
  inner_find_all(root, id, nil, type, all_find_record)
  clear_visited(root)
  return all_find_record
end

local function inner_find(root, id, record, type, find_ref_tree)
  local id_type = type or M.ID_TYPE.NODE
  if nil == find_ref_tree then
    find_ref_tree = true
  end
  if id_type == M.ID_TYPE.NODE and root.node_id == id then
    table.insert(record, root)
    return true
  end
  if id_type == M.ID_TYPE.REF_TREE and root.ref_tree_id == id then
    table.insert(record, root)
    return true
  end
  local not_has_children = nil == root.children or nil == next(root.children)
  local not_has_ref_tree_info = nil == root.ref_tree_info
  if not_has_children and not_has_ref_tree_info then
    return false
  end
  if not not_has_children then
    for _, node in pairs(root.children) do
      local has_find = inner_find(node, id, record, id_type, find_ref_tree)
      if has_find then
        table.insert(record, root)
        return true
      end
    end
  end
  if find_ref_tree and not not_has_ref_tree_info then
    local ref_tree_node = root.ref_tree_info
    local ref_has_find = inner_find(ref_tree_node, id, record, id_type, find_ref_tree)
    if ref_has_find then
      table.insert(record, root)
      return true
    end
  end
  return false
end

M.find = inner_find

local function cal_node_state(node)
  local not_has_children = node.children == nil or nil == next(node.children)
  local not_has_ref_tree_info = nil == node.ref_tree_info
  if not_has_children and not_has_ref_tree_info then
    return false
  else
    if not not_has_children then
      for _, child_node in pairs(node.children) do
        if child_node.is_activated then
          return true
        end
      end
    end
    if not not_has_ref_tree_info and node.ref_tree_info.is_activated then
      return true
    end
    return false
  end
end

local function deactivate_all_node(node)
  node.is_activated = false
  if node.children then
    for _, child_node in pairs(node.children) do
      deactivate_all_node(child_node)
    end
  elseif node.ref_tree_info then
    deactivate_all_node(node.ref_tree_info)
  end
end

local function refresh(record)
  if nil == record or nil == next(record) then
    E.LOG.debug(TAG, "badge: 消除的节点是根节点")
  else
    for _, node in pairs(record) do
      local node_state = cal_node_state(node)
      if node.is_activated == node_state then
        break
      end
      node.is_activated = node_state
    end
  end
end

local function refresh_child_tree(node, rule)
  if not node.is_activated then
    E.LOG.debug(TAG, "节点原本未激活，无需变化")
    return false
  end
  if rule == M.deactivate_mode.DEFAULT then
    if node.is_activated == cal_node_state(node) then
      E.LOG.debug(TAG, "节点计算后状态和原状态一致，无变化，状态为激活")
      return false
    else
      E.LOG.debug(TAG, "节点状态改为非激活")
      node.is_activated = false
      return true
    end
  elseif rule == M.deactivate_mode.REMOVE_FORCE then
    E.LOG.debug(TAG, "递归消除所有子节点")
    deactivate_all_node(node)
    return true
  end
end

function M.deactivate(root, node_id, deactivate_mode, ref_tree_record)
  if nil == root then
    return false
  end
  local rule = deactivate_mode or M.deactivate_mode.DEFAULT
  local record = {}
  local find_succ = inner_find(root, node_id, record, M.ID_TYPE.NODE, false)
  if find_succ and (not record[1].deact_rule or record[1].deact_rule ~= M.DEACT_RULE.NOT_DEACT) then
    E.LOG.debug(TAG, "badge: 消除红点的节点存在")
    local root_node_index = #record
    local root_node = record[root_node_index]
    local root_original_state = root_node.is_activated
    local need_refresh_parent = refresh_child_tree(record[1], rule)
    table.remove(record, 1)
    if need_refresh_parent then
      refresh(record)
      local need_refresh_ref_parent_tree = false
      if nil == record or nil == next(record) then
        need_refresh_ref_parent_tree = need_refresh_parent
      else
        local root_new_state = root_node.is_activated
        if true == root_original_state and false == root_new_state then
          need_refresh_ref_parent_tree = true
        end
      end
      if need_refresh_ref_parent_tree and ref_tree_record then
        refresh(ref_tree_record)
      end
    end
  elseif find_succ then
    E.LOG.debug(TAG, "badge: 消除红点的节点存在，但消除限制规则 deact_rule 为 1, 不做处理")
    return false
  else
    E.LOG.debug(TAG, "badge: 消除红点的节点不存在, 不做处理")
  end
  return find_succ
end

return M
